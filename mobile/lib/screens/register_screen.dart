import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'login_screen.dart';
import '../widgets/common/glass_container.dart';
import '../widgets/common/custom_text_field.dart';
import '../widgets/auth/auth_animated_background.dart';
import '../widgets/auth/auth_logo.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: Stack(
        children: [
          // 1. Background Shapes
          const AuthAnimatedBackground(),
          
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // 2. Logo y Títulos
                    const AuthLogo(
                      title: 'Únete a City Safe',
                      subtitle: 'Crea tu cuenta para reportar emergencias',
                      icon: Icons.person_add_alt_1_rounded,
                    ),
                    
                    const SizedBox(height: 48),

                    // 3. Contenedor del Formulario (Entra al final, 600ms)
                    GlassContainer(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // TextFields refactorizados
                          const CustomTextField(
                            hintText: 'Nombre de usuario',
                            prefixIcon: Icons.person_outline_rounded,
                          ),
                          const SizedBox(height: 16),
                          CustomTextField(
                            hintText: 'Contraseña',
                            prefixIcon: Icons.lock_rounded,
                            obscureText: _obscurePassword,
                            suffixIcon: IconButton(
                              icon: Icon(_obscurePassword ? Icons.visibility_off_rounded : Icons.visibility_rounded, size: 20),
                              onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                            ),
                          ),
                          
                          const SizedBox(height: 32),
                          SizedBox(
                            width: double.infinity,
                            height: 56,
                            child: FilledButton(
                              onPressed: () {
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
                              },
                              style: FilledButton.styleFrom(
                                backgroundColor: theme.colorScheme.primary,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text('Crear Cuenta', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                  const SizedBox(width: 8),
                                  const Icon(Icons.person_add_alt_1_rounded, size: 20),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ).animate().fadeIn(delay: 600.ms, duration: 400.ms).slideY(begin: 0.1, curve: Curves.easeOutCubic),
                    
                    const SizedBox(height: 32),
                    
                    // 4. Enlace de Login
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
                      },
                      child: RichText(
                        text: TextSpan(
                          text: '¿Ya tienes cuenta? ',
                          style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                          children: [
                            TextSpan(
                              text: 'Inicia Sesión',
                              style: TextStyle(color: theme.colorScheme.primary, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ).animate().fadeIn(delay: 1000.ms),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}