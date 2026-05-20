import 'package:flutter/material.dart';

import '../widgets/home/category_navigation_bar.dart';
import '../widgets/home/home_app_bar.dart';
import '../widgets/home/incident_list_area.dart';
import 'report_emergency.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? _selectedCategory;

  final List<Map<String, dynamic>> _allIncidents = [];

  // CATEGORIAS PARA LA BARRA DE NAVEGACION
  final List<Map<String, dynamic>> _categories = [
    {"name": "Seguridad", "icon": Icons.shield_rounded},
    {"name": "Médicas", "icon": Icons.medical_services_rounded},
    {"name": "Servicios Públicos", "icon": Icons.construction_rounded},
    {"name": "Protección Civil", "icon": Icons.warning_rounded},
  ];

  Future<void> _refreshData() async {
    await Future.delayed(const Duration(seconds: 2));
  }

  void _openReportEmergency() {
    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        barrierColor: Colors.black.withValues(alpha: 0.3),
        pageBuilder: (context, animation, secondaryAnimation) =>
            const ReportEmergencyScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final filteredIncidents = _selectedCategory == null
        ? _allIncidents
        : _allIncidents
              .where((i) => i['category'] == _selectedCategory)
              .toList();

    return Scaffold(
      backgroundColor: theme.colorScheme.primaryContainer,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // 1. CONTORNO SUPERIOR (Título y Usuario)
            const HomeAppBar(),

            // 2. ÁREA CENTRAL (Tarjeta con Reportes y Animaciones)
            Expanded(
              child: IncidentListArea(
                incidents: filteredIncidents,
                selectedCategory: _selectedCategory,
                onRefresh: _refreshData,
                onReportEmergency: _openReportEmergency,
              ),
            ),

            // 3. CONTORNO INFERIOR (Barra de Categorías)
            CategoryNavigationBar(
              categories: _categories,
              selectedCategory: _selectedCategory,
              onCategorySelected: (category) {
                setState(() {
                  _selectedCategory = category;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
