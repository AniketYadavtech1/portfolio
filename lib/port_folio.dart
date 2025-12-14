// main.dart
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PortfolioHome extends StatefulWidget {
  const PortfolioHome({Key? key}) : super(key: key);

  @override
  State<PortfolioHome> createState() => _PortfolioHomeState();
}

class _PortfolioHomeState extends State<PortfolioHome>
    with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _fadeController, curve: Curves.easeIn));
    _fadeController.forward();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  void _scrollToSection(double offset) {
    _scrollController.animateTo(
      offset,
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeInOut,
    );
  }

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF0F2027), // Dark blue
              Color(0xFF203A43), // AI tone
              Color(0xFF2C5364), // Neon hint
            ],
          ),
        ),
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            // App Bar
            SliverAppBar(
              expandedHeight: 80,
              floating: true,
              pinned: true,
              backgroundColor: Color(0xFF1E293B).withOpacity(0.5),
              flexibleSpace: FlexibleSpaceBar(
                title: Row(
                  children: [
                    const Icon(Icons.code, color: Color(0xFF06B6D4)),
                    const SizedBox(width: 8),
                    ShaderMask(
                      shaderCallback: (bounds) => const LinearGradient(
                        colors: [Color(0xFF06B6D4), Color(0xFF3B82F6)],
                      ).createShader(bounds),
                      child: const Text(
                        'Aniket Yadav',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              actions: [
                TextButton(
                  onPressed: () => _scrollToSection(0),
                  child: const Text(
                    'Home',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                TextButton(
                  onPressed: () => _scrollToSection(600),
                  child: const Text(
                    'Projects',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                TextButton(
                  onPressed: () => _scrollToSection(1400),
                  child: const Text(
                    'Skills',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                TextButton(
                  onPressed: () => _scrollToSection(2000),
                  child: const Text(
                    'Contact',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(width: 16),
              ],
            ),

            // Content
            SliverList(
              delegate: SliverChildListDelegate([
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: Column(
                    children: [
                      _buildHeroSection(),
                      _buildProjectsSection(),
                      _buildSkillsSection(),
                      _buildContactSection(),
                      _buildFooter(),

                    ],
                  ),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildHeroSection() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 80),
      child: Column(
        children: [
          // Avatar with gradient border
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                colors: [Color(0xFF06B6D4), Color(0xFF3B82F6)],
              ),
            ),
            child: Container(
              padding: const EdgeInsets.all(1),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  colors: [Color(0xFF00D9FF), Color(0xFF7B2FF7)],
                ),
              ),
              child: ClipOval(
                child: Image.asset(
                  "assets/img/aniket_yadav.jpeg",
                  width: 140,
                  height: 140,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(height: 32),

          // Name with gradient
          ShaderMask(
            shaderCallback: (bounds) => const LinearGradient(
              colors: [Color(0xFF06B6D4), Color(0xFF3B82F6)],
            ).createShader(bounds),
            child: const Text(
              'Aniket Yadav',
              style: TextStyle(
                fontSize: 56,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 16),

          const Text(
            'Flutter & Node.js Developer',
            style: TextStyle(
              fontSize: 24,
              color: Color(0xFF94A3B8),
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 24),

          const SizedBox(
            width: 600,
            child: Text(
              'Building beautiful cross-platform mobile applications with powerful backend solutions. Passionate about creating seamless user experiences.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFF94A3B8),
                height: 1.6,
              ),
            ),
          ),
          const SizedBox(height: 40),

          // CTA Buttons
          Wrap(
            spacing: 16,
            runSpacing: 16,
            alignment: WrapAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => _scrollToSection(600),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 20,
                  ),
                  backgroundColor: const Color(0xFF06B6D4),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'View Projects',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              OutlinedButton(
                onPressed: () => _scrollToSection(2000),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 20,
                  ),
                  side: const BorderSide(color: Color(0xFF06B6D4), width: 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Contact Me',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProjectsSection() {
    final projects = [
      {
        'title': 'Chat Application',
        'description':
            'Real-time messaging app with user authentication, message encryption, and instant notifications. Built with Flutter for frontend and Node.js backend with Socket.io for real-time communication.',
        'tech': ['Flutter', 'Node.js', 'Socket.io', 'MongoDB', 'JWT'],
        'icon': Icons.chat_bubble,
        'gradient': [const Color(0xFF3B82F6), const Color(0xFF06B6D4)],
      },
      {
        'title': 'Gemini AI Integration',
        'description':
            'AI-powered mobile application integrating Google\'s Gemini AI for intelligent conversations, content generation, and smart assistance. Features include chat history, voice input, and multi-language support.',
        'tech': ['Flutter', 'Gemini API', 'Node.js', 'REST API', 'Provider'],
        'icon': Icons.auto_awesome,
        'gradient': [const Color(0xFFA855F7), const Color(0xFFEC4899)],
      },
      {
        'title': 'FCM Push Notifications',
        'description':
            'Comprehensive push notification system using Firebase Cloud Messaging for real-time alerts, user engagement, and targeted messaging. Includes notification scheduling and analytics.',
        'tech': ['Flutter', 'FCM', 'Node.js', 'Firebase', 'Cloud Functions'],
        'icon': Icons.notifications,
        'gradient': [const Color(0xFFF97316), const Color(0xFFEF4444)],
      },
    ];

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color(0xFF1E293B).withOpacity(0.5),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 60),

      child: Column(
        children: [
          const Text(
            'Featured Projects',
            style: TextStyle(
              fontSize: 42,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 48),

          Wrap(
            spacing: 24,
            runSpacing: 24,
            alignment: WrapAlignment.center,
            children: projects.map((project) {
              return Container(
                width: 380,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: const Color(0xFF0F172A),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFF334155)),
                  boxShadow: [
                    BoxShadow(
                      color: (project['gradient'] as List<Color>)[0]
                          .withOpacity(0.2),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: project['gradient'] as List<Color>,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        project['icon'] as IconData,
                        size: 32,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 20),

                    Text(
                      project['title'] as String,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 12),

                    Text(
                      project['description'] as String,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF94A3B8),
                        height: 1.6,
                      ),
                    ),
                    const SizedBox(height: 20),

                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: (project['tech'] as List<String>).map((tech) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF1E293B),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: const Color(0xFF334155)),
                          ),
                          child: Text(
                            tech,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Color(0xFF06B6D4),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSkillsSection() {
    final skills = [
      {
        'name': 'Flutter',
        'level': 0.95,
        'icon': Icons.flutter_dash,
        'color': const Color(0xFF02569B),
      },
      {
        'name': 'Dart',
        'level': 0.93,
        'icon': Icons.code,
        'color': const Color(0xFF0175C2),
      },
      {
        'name': 'Node.js',
        'level': 0.88,
        'icon': Icons.javascript,
        'color': const Color(0xFF339933),
      },
      {
        'name': 'JavaScript',
        'level': 0.87,
        'icon': Icons.javascript_outlined,
        'color': const Color(0xFFF7DF1E),
      },
      {
        'name': 'Firebase',
        'level': 0.90,
        'icon': Icons.local_fire_department,
        'color': const Color(0xFFFFCA28),
      },

      {
        'name': 'REST APIs',
        'level': 0.89,
        'icon': Icons.api,
        'color': const Color(0xFF00D9FF),
      },
      {
        'name': 'Socket.io',
        'level': 0.85,
        'icon': Icons.bolt,
        'color': const Color(0xFFFFB800),
      },
      {
        'name': 'Git & GitHub',
        'level': 0.91,
        'icon': Icons.source,
        'color': const Color(0xFFE94E31),
      },
      {
        'name': 'Python',
        'level': 0.75,
        'icon': Icons.terminal,
        'color': const Color(0xFF3776AB),
      },
      {
        'name': 'Java',
        'level': 0.70,
        'icon': Icons.coffee,
        'color': const Color(0xFFED8B00),
      },
      {
        'name': 'SQL',
        'level': 0.80,
        'icon': Icons.table_chart,
        'color': const Color(0xFF4479A1),
      },
    ];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 80),
      child: Column(
        children: [
          // Section Title
          ShaderMask(
            shaderCallback: (bounds) => const LinearGradient(
              colors: [Color(0xFF00D9FF), Color(0xFF7B2FF7)],
            ).createShader(bounds),
            child: const Text(
              'Technical Skills',
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 1,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Container(
            height: 4,
            width: 100,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF00D9FF), Color(0xFF7B2FF7)],
              ),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 48),

          // Skills List
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 900),
            child: Column(
              children: skills.map((skill) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 28),
                  child: _skillCard(skill),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _skillCard(Map<String, Object> skill) {
    final Color color = skill['color'] as Color;
    final double level = skill['level'] as double;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF1A1F3A).withOpacity(0.6),
            const Color(0xFF0A0E27).withOpacity(0.85),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.35), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.15),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          // Icon, Name & Percentage
          Row(
            children: [
              // Icon container
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: color.withOpacity(0.35), width: 2),
                ),
                child: Icon(skill['icon'] as IconData, size: 28, color: color),
              ),
              const SizedBox(width: 16),

              // Skill name
              Expanded(
                child: Text(
                  skill['name'] as String,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 0.5,
                  ),
                ),
              ),

              // Percentage badge
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [color.withOpacity(0.25), color.withOpacity(0.1)],
                  ),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: color.withOpacity(0.45),
                    width: 1.5,
                  ),
                ),
                child: Text(
                  '${(level * 100).toInt()}%',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: color,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Progress bar
          Stack(
            children: [
              // Background
              Container(
                height: 12,
                decoration: BoxDecoration(
                  color: const Color(0xFF1A1F3A),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                    color: const Color(0xFF2A3F5A).withOpacity(0.5),
                  ),
                ),
              ),

              // Progress
              FractionallySizedBox(
                widthFactor: level,
                child: Container(
                  height: 12,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [color, color.withOpacity(0.7)],
                    ),
                    borderRadius: BorderRadius.circular(6),
                    boxShadow: [
                      BoxShadow(
                        color: color.withOpacity(0.6),
                        blurRadius: 10,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildContactSection() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color(0xFF1E293B).withOpacity(0.5),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 60),

      child: Column(
        children: [
          const Text(
            'Get In Touch',
            style: TextStyle(
              fontSize: 42,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Interested in working together? Let\'s connect!',
            style: TextStyle(fontSize: 18, color: Color(0xFF94A3B8)),
          ),
          const SizedBox(height: 48),

          Wrap(
            spacing: 24,
            runSpacing: 24,
            alignment: WrapAlignment.center,
            children: [
              _buildContactCard(
                icon: Icons.email,
                title: 'Email',
                subtitle: 'aniketyadavtech1@gmail.com',
                onTap: () => _launchURL('mailto:aniketyadavtech1@gmail.com'),
              ),
              _buildContactCard(
                icon: Icons.phone,
                title: 'Phone',
                subtitle: '+91 9555785980',
                onTap: () => _launchURL('tel:+919555785980'),
              ),
              _buildContactCard(
                icon: Icons.code,
                title: 'GitHub',
                subtitle: 'AniketYadavtech1',
                onTap: () => _launchURL(
                  'https://github.com/AniketYadavtech1?tab=repositories',
                ),
              ),
              _buildContactCard(
                icon: Icons.work,
                title: 'LinkedIn',
                subtitle: 'Aniket Yadav',
                onTap: () => _launchURL(
                  'https://www.linkedin.com/in/aniket-yadav-666b7225a/',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildContactCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: 280,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: const Color(0xFF0F172A),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFF334155)),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF06B6D4).withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 32, color: const Color(0xFF06B6D4)),
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              style: const TextStyle(fontSize: 14, color: Color(0xFF94A3B8)),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: Color(0xFF334155))),
      ),
      child: const Text(
        '© 2024 Aniket Yadav. Built with Flutter & Node.js ',
        textAlign: TextAlign.center,
        style: TextStyle(color: Color(0xFF94A3B8), fontSize: 14),
      ),
    );
  }




}
