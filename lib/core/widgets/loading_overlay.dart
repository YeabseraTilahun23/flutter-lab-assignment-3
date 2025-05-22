import 'dart:ui';
import 'package:flutter/material.dart';

class LoadingOverlay extends StatelessWidget {
  const LoadingOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
          child: Container(color: Colors.black.withOpacity(0.1)),
        ),
        const Center(
          child: CircularProgressIndicator(
            strokeWidth: 3,
            color: Color(0xFFD4AF37), // Deep gold
          ),
        ),
      ],
    );
  }
}
