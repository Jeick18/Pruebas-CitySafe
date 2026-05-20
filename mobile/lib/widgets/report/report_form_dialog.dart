import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ReportFormDialog extends StatelessWidget {
  const ReportFormDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(32),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: theme.colorScheme.surface.withValues(alpha: 0.95),
                borderRadius: BorderRadius.circular(32),
                border: Border.all(color: theme.colorScheme.error.withValues(alpha: 0.2), width: 2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 30,
                    offset: const Offset(0, 10),
                  )
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Icon(Icons.warning_rounded, size: 32, color: theme.colorScheme.error)
                                .animate().scale(delay: 100.ms, curve: Curves.easeOutBack),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                'Reportar Emergencia',
                                style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, color: theme.colorScheme.error),
                              ).animate().fadeIn().slideX(begin: -0.1),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close_rounded),
                        onPressed: () => Navigator.pop(context),
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: 'Categoría',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    ),
                    items: const [
                      DropdownMenuItem(value: '1', child: Text('Seguridad')),
                      DropdownMenuItem(value: '2', child: Text('Médicas')),
                      DropdownMenuItem(value: '3', child: Text('Servicios Públicos')),
                      DropdownMenuItem(value: '4', child: Text('Protección Civil')),
                    ],
                    onChanged: (value) {},
                  ).animate().fadeIn(delay: 200.ms),
                  const SizedBox(height: 16),
                  TextField(
                    maxLines: 2,
                    decoration: InputDecoration(
                      labelText: 'Descripción de la emergencia',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    ),
                  ).animate().fadeIn(delay: 300.ms),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: FilledButton(
                      onPressed: () {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text('Emergencia reportada con éxito.'),
                            backgroundColor: theme.colorScheme.errorContainer, // Rojo general del theme
                          ),
                        );
                      },
                      style: FilledButton.styleFrom(
                        backgroundColor: theme.colorScheme.error, // Rojo que sí deriva del main.dart
                        foregroundColor: theme.colorScheme.onError,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)), // Forma pastilla
                      ),
                      child: const Text('Enviar Reporte', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    ),
                  ).animate().fadeIn(delay: 400.ms).scale(curve: Curves.easeOutBack),
                ],
              ),
            ),
          ),
        ),
      ),
    ).animate().scale(duration: 400.ms, curve: Curves.easeOutBack).fadeIn();
  }
}
