// lib/screens/detail_screen.dart

import 'dart:async';
import 'package:flutter/material.dart';
import '../models/todo.dart';

class DetailScreen extends StatefulWidget {
  final Todo todo;
  
  const DetailScreen({super.key, required this.todo});

  @override
  // Digunakan untuk membuat komponen dinamis yang penampilannya dapat berubah merespons sentuhan atau perubahan data.
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  // === 1. DEFINISI STATE ===
  // Memori aplikasi yang menentukan hasil akhir antarmuka.
  bool isCompleted = false; 
  int secondsViewed = 0;
  Timer? _backgroundTimer;

  // === 2. LIFECYCLE: initState ===
  @override
  void initState() {
    super.initState();
    // Dipanggil hanya satu kali seumur hidup widget untuk menyiapkan sistem sebelum berjalan.
    
    // EVENT SISTEM: Aksi sistem di latar belakang berupa timer yang berdetak setiap 1 detik.
    _backgroundTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      // Mengubah State berdasarkan Event sistem
      setState(() {
        secondsViewed++; 
      });
    });
  }

  // === 3. LIFECYCLE: dispose ===
  @override
  void dispose() {
    // Menandakan akhir dari widget saat pengguna pindah halaman.
    // Sangat penting untuk mematikan timer di sini agar memori RAM ponsel tidak terkuras sia-sia (memory leak)[cite: 2].
    _backgroundTimer?.cancel();
    super.dispose();
  }

  // === 4. LIFECYCLE: build ===
  @override
  Widget build(BuildContext context) {
    // Di sinilah UI digambar[cite: 2].
    // Setiap kali ada Event yang memicu setState, sistem berputar kembali ke fungsi build untuk menggambar ulang dengan data terbaru[cite: 2].
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Tugas'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
            
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFFDF6E3),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.black12),
              ),
              child: Text(
                widget.todo.description,
                style: const TextStyle(fontSize: 16, height: 1.5),
              ),
            ),
            
            const SizedBox(height: 24),
            
            // UI untuk menampilkan perubahan State dari Event Sistem
            Center(
              child: Text(
                'Waktu melihat detail: $secondsViewed detik',
                style: const TextStyle(color: Colors.grey, fontStyle: FontStyle.italic),
              ),
            ),
            
            const Spacer(),
            
            // EVENT PENGGUNA (Aksi Fisik)
            Center(
              child: ElevatedButton.icon(
                // Event: Interaksi langsung berupa sentuhan jari (tap) yang menjadi pemicu aplikasi bertindak[cite: 2].
                onPressed: () {
                  // Memicu perubahan State
                  setState(() {
                    isCompleted = !isCompleted;
                  });
                },
                // State: Mengubah warna tombol secara dinamis merespons sentuhan[cite: 2].
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