import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class PortfolioController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late ScrollController scrollController;
  late AnimationController fadeController;
  late Animation<double> fadeAnimation;

  final List<Map<String, String>> experience = [
    {
      "position": "Flutter Developer",
      "company": "Tech Solutions Pvt. Ltd.",
      "duration": "June 2023 - Present (1.5 Years)",
      "description":
          "Developed and maintained multiple cross-platform mobile applications using Flutter. Implemented state management solutions with GetX and Provider. Integrated Firebase services including Authentication, Firestore, and Cloud Storage. Worked with REST APIs and implemented complex UI/UX designs. Collaborated with backend team to optimize API responses and improve app performance. Reduced app loading time by 40% through code optimization and lazy loading techniques.",
    },
  ];

  final List<Map<String, dynamic>> projects = [
    {
      "title": "Real-Time Chat Application",
      "description":
          "A scalable real-time messaging application supporting one-to-one and group chats, media sharing, message read receipts, typing indicators, and user presence tracking. Backend powered by Firebase for real-time data sync and secure authentication.",
      "tech": [
        "Flutter",
        "Firebase Authentication",
        "Firebase Realtime Database",
        "Cloud Storage",
        "Provider",
        "RESTful APIs",
      ],
      "icon": Icons.chat_bubble,
      "color": const Color(0xFF8B5CF6),
    },
    {
      "title": "Task Management & To-Do Application",
      "description":
          "A productivity-focused task management app featuring task categorization, priority levels, due dates, reminders, and calendar-based scheduling. Includes offline-first support with local persistence and optional cloud synchronization.",
      "tech": [
        "Flutter",
        "SQLite",
        "Provider",
        "Local Notifications",
        "Node.js REST API",
        "JWT Authentication",
      ],
      "icon": Icons.task_alt,
      "color": const Color(0xFF10B981),
    },
    {
      "title": "Food Delivery Application",
      "description":
          "A full-stack food delivery platform enabling restaurant discovery, menu browsing, order placement, and real-time order tracking. Integrated secure payments, location-based services, and backend APIs for order and user management.",
      "tech": [
        "Flutter",
        "Node.js (Express)",
        "REST API",
        "Firebase Authentication",
        "Google Maps API",
        "Bloc",
      ],
      "icon": Icons.restaurant,
      "color": const Color(0xFFF59E0B),
    },
    {
      "title": "News & Media Application",
      "description":
          "A modern news aggregation app providing category-based filtering, search, bookmarks, offline reading, and social sharing. Backend integration ensures real-time news updates and optimized API response handling.",
      "tech": [
        "Flutter",
        "Node.js REST API",
        "News API",
        "Provider",
        "SharedPreferences",
        "Pagination & Caching",
      ],
      "icon": Icons.newspaper,
      "color": const Color(0xFFEF4444),
    },
  ];

  final List<Map<String, dynamic>> skills = [
    {
      "name": "Flutter & Dart",
      "icon": Icons.flutter_dash,
      "level": 0.85,
      "color": const Color(0xFF02569B),
    },
    {
      "name": "State Management (GetX, Provider, Bloc)",
      "icon": Icons.settings_applications,
      "level": 0.80,
      "color": const Color(0xFF8B5CF6),
    },
    {
      "name": "Firebase (Auth, Firestore, Storage)",
      "icon": Icons.local_fire_department,
      "level": 0.85,
      "color": const Color(0xFFF59E0B),
    },
    {
      "name": "REST API Integration",
      "icon": Icons.api,
      "level": 0.80,
      "color": const Color(0xFF10B981),
    },
    {
      "name": "Git & GitHub",
      "icon": Icons.code_outlined,
      "level": 0.75,
      "color": const Color(0xFF6B7280),
    },
    {
      "name": "UI/UX Design Implementation",
      "icon": Icons.design_services,
      "level": 0.80,
      "color": const Color(0xFFEC4899),
    },
    {
      "name": "SQLite & Local Storage",
      "icon": Icons.storage,
      "level": 0.75,
      "color": const Color(0xFF06B6D4),
    },
    {
      "name": "Google Maps & Location Services",
      "icon": Icons.location_on,
      "level": 0.70,
      "color": const Color(0xFFEF4444),
    },

    {
      "name": "Push Notifications (FCM)",
      "icon": Icons.notifications,
      "level": 0.75,
      "color": const Color(0xFFF59E0B),
    },
  ];

  final List<Map<String, dynamic>> contacts = [
    {
      "icon": Icons.email,
      "title": "Email",
      "subtitle": "aniketyadavtech1@gmail.com",
      "url": "mailto:aniketyadavtech1@gmail.com",
    },
    {
      "icon": Icons.phone,
      "title": "Phone",
      "subtitle": "+91 9555785980",
      "url": "tel:+919555785980",
    },
    {
      "icon": Icons.work,
      "title": "LinkedIn",
      "subtitle": "Connect on LinkedIn",
      "url": "https://www.linkedin.com/in/aniket-yadav-666b7225a/",
    },
    {
      "icon": Icons.code,
      "title": "GitHub",
      "subtitle": "View my repositories",
      "url": "https://github.com/AniketYadavtech1",
    },
  ];

  @override
  void onInit() {
    scrollController = ScrollController();

    fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    fadeAnimation = CurvedAnimation(
      parent: fadeController,
      curve: Curves.easeInOut,
    );

    fadeController.forward();
    super.onInit();
  }

  void scrollTo(double offset) {
    scrollController.animateTo(
      offset,
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeInOut,
    );
  }

  Future<void> launchLink(String url) async {
    final uri = Uri.parse(url);
    try {
      if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
        Get.snackbar(
          'Error',
          'Could not launch $url',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'An error occurred: $e',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  @override
  void onClose() {
    scrollController.dispose();
    fadeController.dispose();
    super.onClose();
  }
}
