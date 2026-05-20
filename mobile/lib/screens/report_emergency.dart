import 'dart:ui';
import 'package:flutter/material.dart';
import '../widgets/report/report_form_dialog.dart';
class ReportEmergencyScreen extends StatelessWidget {
  const ReportEmergencyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            // Backdrop global con blur
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  color: Colors.black.withValues(alpha: 0.2), // Tinte oscuro sutil sobre el desenfoque
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
            ),
            
            // Dialog flotante central
            const ReportFormDialog(),
          ],
        ),
      );
  }
}