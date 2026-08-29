import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(const AITerminalApp());
}

class AITerminalApp extends StatelessWidget {
  const AITerminalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AI Terminal',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Courier',
        scaffoldBackgroundColor: const Color(0xFF1E1E1E),
        useMaterial3: true,
        brightness: Brightness.dark,
      ),
      home: const TerminalScreen(),
    );
  }
}

class TerminalScreen extends StatefulWidget {
  const TerminalScreen({super.key});

  @override
  State<TerminalScreen> createState() => _TerminalScreenState();
}

class _TerminalScreenState extends State<TerminalScreen> {
  final TextEditingController commandController = TextEditingController();
  final List<TerminalMessage> messages = [];
  bool isProcessing = false;

  void sendMessage(String command) async {
    if (command.trim().isEmpty) return;

    setState(() {
      messages.add(TerminalMessage(text: '> $command', isUser: true));
      isProcessing = true;
    });

    await Future.delayed(const Duration(milliseconds: 500));

    String response = await processCommand(command);

    setState(() {
      messages.add(TerminalMessage(text: response, isUser: false));
      isProcessing = false;
    });

    commandController.clear();
  }

  Future<String> processCommand(String command) async {
    final cmd = command.trim().toLowerCase();

    if (cmd.startsWith('create file') || cmd.startsWith('createfile')) {
      final fileName = command.substring(11).trim();
      if (fileName.isEmpty) {
        return 'Error: Please specify a filename. Usage: create file <filename>';
      }
      return await createFile(fileName);
    } else if (cmd.startsWith('create folder') || cmd.startsWith('createfolder')) {
      final folderName = command.substring(13).trim();
      if (folderName.isEmpty) {
        return 'Error: Please specify a folder name. Usage: create folder <foldername>';
      }
      return await createFolder(folderName);
    } else if (cmd == 'help') {
      return '''Available commands:
- create file <filename>: Create a new file
- create folder <foldername>: Create a new folder
- list files: List all created files
- clear: Clear terminal history
- about: About this app''';
    } else if (cmd == 'list files' || cmd == 'ls') {
      return await listFiles();
    } else if (cmd == 'clear') {
      setState(() {
        messages.clear();
      });
      return 'Terminal cleared.';
    } else if (cmd == 'about') {
      return 'AI Terminal v1.0 - Generate code and files with AI assistance. Type "help" for available commands.';
    } else {
      return 'Unknown command. Type "help" for available commands.';
    }
  }

  Future<String> createFile(String fileName) async {
    try {
      var status = await Permission.storage.status;
      if (!status.isGranted) {
        status = await Permission.storage.request();
        if (!status.isGranted) {
          return 'Error: Storage permission denied. Cannot create file.';
        }
      }

      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/$fileName');
      
      if (await file.exists()) {
        return 'File $fileName already exists.';
      }

      await file.writeAsString('// Created by AI Terminal\n');
      return '✓ File created: ${file.path}';
    } catch (e) {
      return 'Error creating file: $e';
    }
  }

  Future<String> createFolder(String folderName) async {
    try {
      var status = await Permission.storage.status;
      if (!status.isGranted) {
        status = await Permission.storage.request();
        if (!status.isGranted) {
          return 'Error: Storage permission denied. Cannot create folder.';
        }
      }

      final directory = await getApplicationDocumentsDirectory();
      final folder = Directory('${directory.path}/$folderName');
      
      if (await folder.exists()) {
        return 'Folder $folderName already exists.';
      }

      await folder.create();
      return '✓ Folder created: ${folder.path}';
    } catch (e) {
      return 'Error creating folder: $e';
    }
  }

  Future<String> listFiles() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final files = directory.listSync();
      
      if (files.isEmpty) {
        return 'No files or folders created yet.';
      }

      StringBuffer sb = StringBuffer();
      sb.writeln('Files and folders:');
      for (var entity in files) {
        final name = entity.path.split('/').last;
        sb.writeln('- $name (${entity is Directory ? 'folder' : 'file'})');
      }
      return sb.toString();
    } catch (e) {
      return 'Error listing files: $e';
    }
  }

  @override
  void dispose() {
    commandController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Color(0xFF1E1E1E),
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Color(0xFF1E1E1E),
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );

    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2D2D2D),
        foregroundColor: Colors.greenAccent,
        title: const Text(
          'AI Terminal',
          style: TextStyle(
            fontFamily: 'Courier',
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  backgroundColor: const Color(0xFF2D2D2D),
                  title: const Text('AI Terminal', style: TextStyle(color: Colors.greenAccent)),
                  content: const Text(
                    'Generate code and files using terminal commands.\n\nType "help" to see available commands.',
                    style: TextStyle(color: Colors.white70),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Close', style: TextStyle(color: Colors.greenAccent)),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              child: ListView.builder(
                itemCount: messages.length + (isProcessing ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index >= messages.length) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.greenAccent),
                            ),
                          ),
                          SizedBox(width: 12),
                          Text(
                            'Processing...',
                            style: TextStyle(
                              color: Colors.greenAccent,
                              fontFamily: 'Courier',
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  return MessageBubble(message: messages[index]);
                },
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF2D2D2D),
              border: Border(top: BorderSide(color: Colors.grey[800]!)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: commandController,
                    style: const TextStyle(
                      color: Colors.greenAccent,
                      fontFamily: 'Courier',
                      fontSize: 16,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Enter command...',
                      hintStyle: TextStyle(color: Colors.grey[600]),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: const Color(0xFF1E1E1E),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                    onSubmitted: (value) => sendMessage(value),
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.greenAccent,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.send, color: Color(0xFF1E1E1E)),
                    onPressed: () => sendMessage(commandController.text),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TerminalMessage {
  final String text;
  final bool isUser;

  TerminalMessage({required this.text, required this.isUser});
}

class MessageBubble extends StatelessWidget {
  final TerminalMessage message;

  const MessageBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: SelectableText(
        message.text,
        style: TextStyle(
          color: message.isUser ? Colors.blueAccent : Colors.greenAccent,
          fontFamily: 'Courier',
          fontSize: 14,
          height: 1.4,
        ),
      ),
    );
  }
}
