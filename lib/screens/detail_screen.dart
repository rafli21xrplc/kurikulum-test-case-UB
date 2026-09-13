// lib/screens/detail_screen.dart

import 'package:flutter/material.dart';
import '../models/todo.dart';

class DetailScreen extends StatefulWidget {
  final Todo todo;
  
  const DetailScreen({super.key, required this.todo});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  // State interaktif[cite: 1]
  bool isCompleted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Tugas'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        // Wajib menggunakan tata letak vertikal dengan Column[cite: 1]
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon back tambahan yang difungsikan kembali ke Screen 1[cite: 1]
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: const Row(
                children: [
                  Icon(Icons.arrow_back_rounded, color: Colors.blue),
                  SizedBox(width: 8),
                  Text('Kembali', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            const SizedBox(height: 24),
            
            Text(
              widget.todo.title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            
            // Container dengan latar belakang warna pastel dan padding[cite: 1]
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFFDF6E3), // Warna pastel
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.black12),
              ),
              child: Text(
                widget.todo.description,
                style: const TextStyle(fontSize: 16, height: 1.5),
              ),
            ),
            
            const Spacer(),
            
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    isCompleted = !isCompleted;
                  });
                },
                icon: Icon(isCompleted ? Icons.check_circle : Icons.radio_button_unchecked),
                label: Text(isCompleted ? 'Tugas Selesai' : 'Tandai Selesai'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: isCompleted ? Colors.green : Colors.blue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}