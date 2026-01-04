import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/view/portfolio/controller/portfolio_con.dart';

class PortfolioHome extends StatelessWidget {
  const PortfolioHome({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.put(PortfolioController());
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width > 900;
    final isTablet = size.width > 600 && size.width <= 900;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0A0E27), Color(0xFF1A1F3A), Color(0xFF2D3748)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: CustomScrollView(
          controller: c.scrollController,
          slivers: [
            _buildNavBar(c, isDesktop),
            SliverList(
              delegate: SliverChildListDelegate([
                _buildHero(c, isDesktop, isTablet),
                _buildAbout(isDesktop),
                _buildExperience(c, isDesktop),
                _buildProjects(c, isDesktop, isTablet),
                _buildSkills(c, isDesktop, isTablet),
                _buildContact(c, isDesktop, isTablet),
                _buildFooter(),
              ]),
            ),
          ],
        ),
      ),
    );
  }

  // ==================== NAVIGATION BAR ====================
  SliverAppBar _buildNavBar(PortfolioController c, bool isDesktop) {
    return SliverAppBar(
      pinned: true,
      backgroundColor: const Color(0xFF0A0E27).withOpacity(0.98),
      elevation: 8,
      shadowColor: const Color(0xFF00D9FF).withOpacity(0.3),
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF00D9FF), Color(0xFF7B2FF7)],
              ),
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF00D9FF).withOpacity(0.5),
                  blurRadius: 12,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: const Icon(Icons.code, color: Colors.white, size: 20),
          ),
          const SizedBox(width: 12),
          ShaderMask(
            shaderCallback: (bounds) => const LinearGradient(
              colors: [Color(0xFF00D9FF), Color(0xFF7B2FF7)],
            ).createShader(bounds),
            child: Text(
              "Aniket Yadav",
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      actions: isDesktop
          ? [
              _navButton("Home", () => c.scrollTo(0)),
              _navButton("About", () => c.scrollTo(600)),
              _navButton("Experience", () => c.scrollTo(1100)),
              _navButton("Projects", () => c.scrollTo(1700)),
              _navButton("Skills", () => c.scrollTo(2500)),
              _navButton("Contact", () => c.scrollTo(3200)),
              const SizedBox(width: 8),
            ]
          : [
              IconButton(
                icon: const Icon(Icons.menu, color: Colors.white),
                onPressed: () => _showMobileMenu(c),
              ),
            ],
    );
  }

  Widget _navButton(String text, VoidCallback onTap) {
    return TextButton(
      onPressed: onTap,
      style: TextButton.styleFrom(
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
      child: Text(
        text,
        style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget _gradientButton({
    required VoidCallback onPressed,
    required IconData icon,
    required String label,
  }) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 18),
      label: Text(
        label,
        style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
      ),
      style:
          ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ).copyWith(
            backgroundColor: MaterialStateProperty.all(Colors.transparent),
          ),
    );
  }

  void _showMobileMenu(PortfolioController c) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Color(0xFF1A1F3A),
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _mobileMenuItem("Home", Icons.home, () => c.scrollTo(0)),
            _mobileMenuItem("About", Icons.person, () => c.scrollTo(600)),
            _mobileMenuItem("Experience", Icons.work, () => c.scrollTo(1100)),
            _mobileMenuItem("Projects", Icons.folder, () => c.scrollTo(1700)),
            _mobileMenuItem("Skills", Icons.star, () => c.scrollTo(2500)),
            _mobileMenuItem("Contact", Icons.mail, () => c.scrollTo(3200)),
          ],
        ),
      ),
    );
  }

  Widget _mobileMenuItem(String title, IconData icon, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF00D9FF)),
      title: Text(title, style: const TextStyle(color: Colors.white)),
      onTap: () {
        Get.back();
        onTap();
      },
    );
  }

  // ==================== HERO SECTION ====================
  Widget _buildHero(PortfolioController c, bool isDesktop, bool isTablet) {
    return FadeTransition(
      opacity: c.fadeAnimation,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: isDesktop ? 100 : 24,
          vertical: isDesktop ? 120 : 60,
        ),
        child: isDesktop
            ? Row(
                children: [
                  Expanded(child: _heroContent(c)),
                  const SizedBox(width: 60),
                  _heroImage(),
                ],
              )
            : Column(
                children: [
                  _heroImage(),
                  const SizedBox(height: 40),
                  _heroContent(c),
                ],
              ),
      ),
    );
  }

  Widget _heroContent(PortfolioController c) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Hi, I'm",
          style: GoogleFonts.poppins(
            fontSize: 24,
            color: const Color(0xFF94A3B8),
          ),
        ),
        const SizedBox(height: 8),
        ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [Color(0xFF00D9FF), Color(0xFF7B2FF7)],
          ).createShader(bounds),
          child: Text(
            "Aniket Yadav",
            style: GoogleFonts.poppins(
              fontSize: 56,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              height: 1.2,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF00D9FF), Color(0xFF7B2FF7)],
            ),
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF00D9FF).withOpacity(0.4),
                blurRadius: 20,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Text(
            "FLUTTER DEVELOPER",
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
            ),
          ),
        ),
        const SizedBox(height: 24),
        Text(
          "1.5+ Years of Experience",
          style: GoogleFonts.poppins(
            fontSize: 20,
            color: const Color(0xFF00D9FF),
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          "Building beautiful, high-performance cross-platform mobile applications. Specialized in Flutter, Firebase, REST APIs, and state management solutions.",
          style: GoogleFonts.inter(
            fontSize: 16,
            color: const Color(0xFF94A3B8),
            height: 1.7,
          ),
        ),
        const SizedBox(height: 40),
        Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [
            _heroButton(
              onPressed: () => c.scrollTo(1700),
              icon: Icons.work_outline,
              label: "View Projects",
              isPrimary: true,
            ),
            _heroButton(
              onPressed: () => c.scrollTo(3200),
              icon: Icons.mail_outline,
              label: "Contact Me",
              isPrimary: false,
            ),
          ],
        ),
      ],
    );
  }

  Widget _heroButton({
    required VoidCallback onPressed,
    required IconData icon,
    required String label,
    required bool isPrimary,
  }) {
    return isPrimary
        ? ElevatedButton.icon(
            onPressed: onPressed,
            icon: Icon(icon),
            label: Text(
              label,
              style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
            ),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
              backgroundColor: const Color(0xFF00D9FF),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 8,
              shadowColor: const Color(0xFF00D9FF).withOpacity(0.5),
            ),
          )
        : OutlinedButton.icon(
            onPressed: onPressed,
            icon: Icon(icon),
            label: Text(
              label,
              style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
            ),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
              foregroundColor: const Color(0xFF00D9FF),
              side: const BorderSide(color: Color(0xFF00D9FF), width: 2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          );
  }

  Widget _heroImage() {
    return Container(
      width: 210,
      height: 210,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: const LinearGradient(
          colors: [Color(0xFF00D9FF), Color(0xFF7B2FF7)],
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF00D9FF).withOpacity(0.5),
            blurRadius: 80,
            spreadRadius: 15,
          ),
        ],
      ),
      child: Container(
        margin: const EdgeInsets.all(5),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xFF1A1F3A),
        ),
        child: ClipOval(
          child: Image.asset(
            "assets/img/aniket_yadav.jpeg",
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return const Icon(
                Icons.person,
                size: 150,
                color: Color(0xFF00D9FF),
              );
            },
          ),
        ),
      ),
    );
  }

  // ==================== ABOUT SECTION ====================
  Widget _buildAbout(bool isDesktop) {
    return _sectionContainer(
      child: Column(
        children: [
          _sectionTitle("About Me"),
          const SizedBox(height: 20),
          Container(
            constraints: const BoxConstraints(maxWidth: 900),
            padding: const EdgeInsets.all(40),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  const Color(0xFF1A1F3A).withOpacity(0.8),
                  const Color(0xFF2D3748).withOpacity(0.6),
                ],
              ),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: const Color(0xFF00D9FF).withOpacity(0.3),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF00D9FF).withOpacity(0.1),
                  blurRadius: 30,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Text(
              "I'm a passionate Flutter developer with 1.5 years of professional experience in building robust, scalable mobile applications. I specialize in creating intuitive user interfaces, implementing complex business logic, and integrating various APIs and backend services. My expertise includes state management with GetX and Provider, Firebase integration, REST API consumption, and responsive UI design. I'm committed to writing clean, maintainable code and staying updated with the latest Flutter developments.",
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 16,
                color: const Color(0xFFCBD5E1),
                height: 1.9,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ==================== EXPERIENCE SECTION ====================
  Widget _buildExperience(PortfolioController c, bool isDesktop) {
    return _sectionContainer(
      child: Column(
        children: [
          _sectionTitle("Professional Experience"),
          const SizedBox(height: 20),
          ...c.experience.map((exp) => _experienceCard(exp)),
        ],
      ),
    );
  }

  Widget _experienceCard(Map<String, String> exp) {
    return Container(
      margin: const EdgeInsets.only(bottom: 32),
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF1A1F3A).withOpacity(0.9),
            const Color(0xFF2D3748).withOpacity(0.7),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFF00D9FF).withOpacity(0.2),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF00D9FF).withOpacity(0.15),
            blurRadius: 25,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF00D9FF), Color(0xFF7B2FF7)],
                  ),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF00D9FF).withOpacity(0.4),
                      blurRadius: 15,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: const Icon(Icons.work, color: Colors.white, size: 32),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      exp["position"]!,
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      exp["company"]!,
                      style: GoogleFonts.inter(
                        fontSize: 18,
                        color: const Color(0xFF00D9FF),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            exp["duration"]!,
            style: GoogleFonts.inter(
              fontSize: 14,
              color: const Color(0xFF94A3B8),
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            exp["description"]!,
            style: GoogleFonts.inter(
              fontSize: 15,
              color: const Color(0xFFCBD5E1),
              height: 1.8,
            ),
          ),
        ],
      ),
    );
  }

  // ==================== PROJECTS SECTION ====================
  Widget _buildProjects(PortfolioController c, bool isDesktop, bool isTablet) {
    return _sectionContainer(
      child: Column(
        children: [
          _sectionTitle("Featured Projects"),
          Text(
            "Here are some of my recent works",
            style: GoogleFonts.inter(
              fontSize: 16,
              color: const Color(0xFF94A3B8),
            ),
          ),
          const SizedBox(height: 30),
          Wrap(
            spacing: 24,
            runSpacing: 24,
            alignment: WrapAlignment.center,
            children: c.projects.map((p) => _projectCard(p)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _projectCard(Map<String, dynamic> project) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: 300,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF1A1F3A).withOpacity(0.9),
              const Color(0xFF2D3748).withOpacity(0.7),
            ],
          ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: (project['color'] as Color).withOpacity(0.3),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: (project['color'] as Color).withOpacity(0.2),
              blurRadius: 25,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    (project['color'] as Color).withOpacity(0.9),
                    (project['color'] as Color),
                  ],
                ),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Center(
                child: Icon(
                  project['icon'] as IconData,
                  size: 80,
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    project['title'] as String,
                    style: GoogleFonts.poppins(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    project['description'] as String,
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      color: const Color(0xFFCBD5E1),
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
                          color: (project['color'] as Color).withOpacity(0.15),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: (project['color'] as Color).withOpacity(0.5),
                          ),
                        ),
                        child: Text(
                          tech,
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            color: project['color'] as Color,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ==================== SKILLS SECTION (NEW DESIGN) ====================
  Widget _buildSkills(PortfolioController c, bool isDesktop, bool isTablet) {
    return _sectionContainer(
      child: Column(
        children: [
          _sectionTitle("Technical Skills"),
          const SizedBox(height: 20),
          Text(
            "My expertise and proficiency levels",
            style: GoogleFonts.inter(
              fontSize: 16,
              color: const Color(0xFF94A3B8),
            ),
          ),
          const SizedBox(height: 30),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1100),
            child: Wrap(
              alignment: WrapAlignment.center,
              children: c.skills.map((skill) => _skillCardNew(skill)).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _skillCardNew(Map<String, dynamic> skill) {
    final Color color = skill['color'] as Color;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Container(
        width: 340,
        padding: const EdgeInsets.all(28),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF1A1F3A).withOpacity(0.9),
              const Color(0xFF2D3748).withOpacity(0.7),
            ],
          ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color.withOpacity(0.35), width: 1.5),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.2),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          children: [
            // Icon and Title Row
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [color.withOpacity(0.3), color.withOpacity(0.15)],
                    ),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: color.withOpacity(0.5), width: 2),
                    boxShadow: [
                      BoxShadow(
                        color: color.withOpacity(0.3),
                        blurRadius: 12,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Icon(
                    skill['icon'] as IconData,
                    size: 32,
                    color: color,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    skill['name'] as String,
                    style: GoogleFonts.poppins(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 0.3,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ==================== CONTACT SECTION ====================
  Widget _buildContact(PortfolioController c, bool isDesktop, bool isTablet) {
    return _sectionContainer(
      child: Column(
        children: [
          _sectionTitle("Get In Touch"),
          const SizedBox(height: 16),
          Text(
            "Let's work together on your next project!",
            style: GoogleFonts.inter(
              fontSize: 18,
              color: const Color(0xFF94A3B8),
            ),
          ),
          const SizedBox(height: 30),
          Wrap(
            spacing: 24,
            runSpacing: 24,
            alignment: WrapAlignment.center,
            children: c.contacts
                .map((contact) => _contactCard(c, contact))
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _contactCard(PortfolioController c, Map<String, dynamic> contact) {
    return InkWell(
      onTap: () => c.launchLink(contact['url'] as String),
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: 300,
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF1A1F3A).withOpacity(0.9),
              const Color(0xFF2D3748).withOpacity(0.7),
            ],
          ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: const Color(0xFF00D9FF).withOpacity(0.2),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF00D9FF).withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF00D9FF), Color(0xFF7B2FF7)],
                ),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF00D9FF).withOpacity(0.4),
                    blurRadius: 20,
                    spreadRadius: 4,
                  ),
                ],
              ),
              child: Icon(
                contact['icon'] as IconData,
                size: 40,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              contact['title'] as String,
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              contact['subtitle'] as String,
              style: GoogleFonts.inter(
                fontSize: 14,
                color: const Color(0xFFCBD5E1),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  // ==================== FOOTER ====================
  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF0A0E27),
        border: Border(
          top: BorderSide(color: const Color(0xFF00D9FF).withOpacity(0.2)),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.code, color: Color(0xFF00D9FF), size: 24),
              const SizedBox(width: 12),
              ShaderMask(
                shaderCallback: (bounds) => const LinearGradient(
                  colors: [Color(0xFF00D9FF), Color(0xFF7B2FF7)],
                ).createShader(bounds),
                child: Text(
                  "Built with Flutter & Love",
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  // ==================== HELPER METHODS ====================
  Widget _sectionContainer({required Widget child}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
      child: child,
    );
  }

  Widget _sectionTitle(String title) {
    return ShaderMask(
      shaderCallback: (bounds) => const LinearGradient(
        colors: [Color(0xFF00D9FF), Color(0xFF7B2FF7)],
      ).createShader(bounds),
      child: Text(
        title,
        style: GoogleFonts.poppins(
          fontSize: 42,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}
