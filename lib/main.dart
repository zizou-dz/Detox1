import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const ReplyBossApp());
}

class ReplyBossApp extends StatelessWidget {
  const ReplyBossApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ReplyBoss AI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Roboto',
        scaffoldBackgroundColor: const Color(0xFFFFF4E8),
        useMaterial3: true,
      ),
      home: const OnboardingScreen(),
    );
  }
}

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Color(0xFFFFB800),
        statusBarIconBrightness: Brightness.dark,
        navigationBarColor: Colors.white,
        navigationBarIconBrightness: Brightness.dark,
      ),
    );

    return Scaffold(
      backgroundColor: const Color(0xFFFFF4E8),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  height: 260,
                  width: double.infinity,
                  color: const Color(0xFFFFB800),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      SunFace(),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    color: Colors.white,
                  ),
                ),
              ],
            ),

            Positioned(
              top: 210,
              left: 0,
              right: 0,
              bottom: 0,
              child: ClipPath(
                clipper: SoftWaveClipper(),
                child: Container(
                  color: Colors.white,
                ),
              ),
            ),

            Positioned.fill(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(28, 250, 28, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Write better\nEnglish replies.',
                      style: TextStyle(
                        color: Color(0xFF222222),
                        fontSize: 34,
                        height: 1.08,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.6,
                      ),
                    ),

                    const SizedBox(height: 14),

                    const Text(
                      'Create professional customer replies for sales, negotiation, apologies, and follow-ups.',
                      style: TextStyle(
                        color: Color(0xFF555555),
                        fontSize: 16,
                        height: 1.45,
                        fontWeight: FontWeight.w400,
                      ),
                    ),

                    const SizedBox(height: 34),

                    const FeatureItem(
                      iconColor: Color(0xFF179BFF),
                      title: 'Business replies',
                      subtitle:
                          'Reply to customers faster with clear and professional English.',
                    ),

                    const SizedBox(height: 24),

                    const FeatureItem(
                      iconColor: Color(0xFF114BBA),
                      title: 'Sales and support',
                      subtitle:
                          'Handle price questions, delays, refunds, and follow-ups with confidence.',
                    ),

                    const Spacer(),

                    SizedBox(
                      width: double.infinity,
                      height: 58,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const ReplyGeneratorScreen(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: const Color(0xFF147DF5),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32),
                          ),
                        ),
                        child: const Text(
                          'Continue',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 14),

                    SizedBox(
                      width: double.infinity,
                      height: 54,
                      child: TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          backgroundColor: const Color(0xFFF8F2ED),
                          foregroundColor: const Color(0xFF222222),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: const Text(
                          'Back',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ReplyGeneratorScreen extends StatefulWidget {
  const ReplyGeneratorScreen({super.key});

  @override
  State<ReplyGeneratorScreen> createState() => _ReplyGeneratorScreenState();
}

class _ReplyGeneratorScreenState extends State<ReplyGeneratorScreen> {
  final TextEditingController messageController = TextEditingController();

  String selectedGoal = 'Sell';
  String selectedTone = 'Professional';

  final List<String> goals = [
    'Sell',
    'Apologize',
    'Negotiate',
    'Follow up',
  ];

  final List<String> tones = [
    'Professional',
    'Friendly',
    'Short',
  ];

  List<String> replies = [];

  void generateReplies() {
    final message = messageController.text.trim();

    if (message.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Paste a customer message first')),
      );
      return;
    }

    List<String> result;

    if (selectedGoal == 'Sell') {
      result = [
        'Hello! Thank you for your interest. I’d be happy to help you choose the best option.',
        'Yes, it’s available. I can help you confirm your order today.',
        'Thank you for reaching out. This is a great choice, and I can guide you through the next step.',
      ];
    } else if (selectedGoal == 'Apologize') {
      result = [
        'Hello, I sincerely apologize for the inconvenience. Thank you for your patience, and I’ll do my best to resolve this quickly.',
        'I’m really sorry about this. I understand your concern, and I’ll make sure we handle it properly.',
        'Thank you for letting us know. We apologize for the issue and appreciate the chance to make it right.',
      ];
    } else if (selectedGoal == 'Negotiate') {
      result = [
        'Thank you for your interest. This is our best price, but I can offer a small discount if you confirm today.',
        'I understand your request. The price reflects the quality, but I’m happy to discuss a fair option.',
        'I appreciate your offer. I can make a small adjustment while still maintaining the quality of our service.',
      ];
    } else {
      result = [
        'Hi! I just wanted to follow up and see if you’re still interested.',
        'Hello, I hope you’re doing well. I’m checking in to see if you’d like to continue.',
        'Just a quick follow-up. The offer is still available, and I can help whenever you’re ready.',
      ];
    }

    if (selectedTone == 'Short') {
      result = result.map((e) {
        if (selectedGoal == 'Sell') {
          return 'Yes, it’s available. I can help you confirm your order today.';
        }
        if (selectedGoal == 'Apologize') {
          return 'I’m sorry for the inconvenience. I’ll help resolve this quickly.';
        }
        if (selectedGoal == 'Negotiate') {
          return 'This is our best price, but I can offer a small discount today.';
        }
        return 'Hi! Just following up to see if you’re still interested.';
      }).toList();
    }

    if (selectedTone == 'Friendly') {
      result = result.map((e) => '$e 😊').toList();
    }

    setState(() {
      replies = result;
    });
  }

  Future<void> copyReply(String text) async {
    await Clipboard.setData(ClipboardData(text: text));
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Reply copied')),
    );
  }

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Color(0xFFFFB800),
        statusBarIconBrightness: Brightness.dark,
        navigationBarColor: Colors.white,
        navigationBarIconBrightness: Brightness.dark,
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              height: 210,
              width: double.infinity,
              color: const Color(0xFFFFB800),
              child: const Center(
                child: SunFace(),
              ),
            ),

            Positioned(
              top: 160,
              left: 0,
              right: 0,
              bottom: 0,
              child: ClipPath(
                clipper: SoftWaveClipper(),
                child: Container(
                  color: Colors.white,
                ),
              ),
            ),

            SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(28, 220, 28, 26),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Create your reply.',
                    style: TextStyle(
                      color: Color(0xFF222222),
                      fontSize: 32,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.5,
                    ),
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    'Paste the customer message and choose the goal.',
                    style: TextStyle(
                      color: Color(0xFF555555),
                      fontSize: 16,
                      height: 1.4,
                    ),
                  ),

                  const SizedBox(height: 24),

                  TextField(
                    controller: messageController,
                    minLines: 5,
                    maxLines: 7,
                    style: const TextStyle(
                      color: Color(0xFF222222),
                      fontSize: 16,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Paste customer message here...',
                      hintStyle: const TextStyle(
                        color: Color(0xFF999999),
                      ),
                      filled: true,
                      fillColor: const Color(0xFFFDF7F0),
                      contentPadding: const EdgeInsets.all(18),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(26),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  const Text(
                    'Reply goal',
                    style: SectionTitleStyle.textStyle,
                  ),

                  const SizedBox(height: 12),

                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: goals.map((goal) {
                      return SelectPill(
                        label: goal,
                        selected: selectedGoal == goal,
                        onTap: () {
                          setState(() {
                            selectedGoal = goal;
                          });
                        },
                      );
                    }).toList(),
                  ),

                  const SizedBox(height: 24),

                  const Text(
                    'Tone',
                    style: SectionTitleStyle.textStyle,
                  ),

                  const SizedBox(height: 12),

                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: tones.map((tone) {
                      return SelectPill(
                        label: tone,
                        selected: selectedTone == tone,
                        onTap: () {
                          setState(() {
                            selectedTone = tone;
                          });
                        },
                      );
                    }).toList(),
                  ),

                  const SizedBox(height: 28),

                  SizedBox(
                    width: double.infinity,
                    height: 58,
                    child: ElevatedButton(
                      onPressed: generateReplies,
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: const Color(0xFF147DF5),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32),
                        ),
                      ),
                      child: const Text(
                        'Generate Reply',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 28),

                  if (replies.isNotEmpty) ...[
                    const Text(
                      'Suggested replies',
                      style: TextStyle(
                        color: Color(0xFF222222),
                        fontSize: 26,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ...List.generate(
                      replies.length,
                      (index) => ReplyCard(
                        number: index + 1,
                        text: replies[index],
                        onCopy: () => copyReply(replies[index]),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FeatureItem extends StatelessWidget {
  final Color iconColor;
  final String title;
  final String subtitle;

  const FeatureItem({
    super.key,
    required this.iconColor,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 58,
          height: 58,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xFFF2F6FF),
          ),
          child: Center(
            child: Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                color: iconColor,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),

        const SizedBox(width: 18),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Color(0xFF222222),
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: const TextStyle(
                  color: Color(0xFF555555),
                  fontSize: 14.5,
                  height: 1.35,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ReplyCard extends StatelessWidget {
  final int number;
  final String text;
  final VoidCallback onCopy;

  const ReplyCard({
    super.key,
    required this.number,
    required this.text,
    required this.onCopy,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFFDF7F0),
        borderRadius: BorderRadius.circular(28),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 18,
                backgroundColor: const Color(0xFFFFDFA6),
                child: Text(
                  '$number',
                  style: const TextStyle(
                    color: Color(0xFF222222),
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'Ready reply',
                style: TextStyle(
                  color: Color(0xFF222222),
                  fontSize: 17,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const Spacer(),
              IconButton(
                onPressed: onCopy,
                icon: const Icon(Icons.copy_rounded),
                color: Color(0xFF147DF5),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            text,
            style: const TextStyle(
              color: Color(0xFF555555),
              fontSize: 16,
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }
}

class SelectPill extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const SelectPill({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFFFFDFA6) : const Color(0xFFF8F2ED),
          borderRadius: BorderRadius.circular(22),
          border: Border.all(
            color: selected ? const Color(0xFFFFA726) : Colors.transparent,
            width: 1.4,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: selected ? const Color(0xFF222222) : const Color(0xFF666666),
            fontSize: 15.5,
            fontWeight: selected ? FontWeight.w800 : FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class SunFace extends StatelessWidget {
  const SunFace({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 104,
      height: 104,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: const Color(0xFFFF7900),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFFF7900).withOpacity(0.25),
            blurRadius: 28,
            spreadRadius: 8,
          ),
        ],
      ),
      child: CustomPaint(
        painter: SunFacePainter(),
      ),
    );
  }
}

class SunFacePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF222222)
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final leftEye = Path()
      ..moveTo(size.width * 0.34, size.height * 0.40)
      ..quadraticBezierTo(
        size.width * 0.40,
        size.height * 0.46,
        size.width * 0.46,
        size.height * 0.40,
      );

    final rightEye = Path()
      ..moveTo(size.width * 0.54, size.height * 0.40)
      ..quadraticBezierTo(
        size.width * 0.60,
        size.height * 0.46,
        size.width * 0.66,
        size.height * 0.40,
      );

    final smile = Path()
      ..moveTo(size.width * 0.30, size.height * 0.58)
      ..quadraticBezierTo(
        size.width * 0.50,
        size.height * 0.76,
        size.width * 0.70,
        size.height * 0.58,
      );

    canvas.drawPath(leftEye, paint);
    canvas.drawPath(rightEye, paint);
    canvas.drawPath(smile, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class SoftWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    path.moveTo(0, 70);

    path.quadraticBezierTo(
      size.width * 0.50,
      -30,
      size.width,
      70,
    );

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class SectionTitleStyle {
  static const TextStyle textStyle = TextStyle(
    color: Color(0xFF222222),
    fontSize: 21,
    fontWeight: FontWeight.w800,
  );
}
