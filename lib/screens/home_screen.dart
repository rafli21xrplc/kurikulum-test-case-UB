// lib/screens/home_screen.dart

import 'package:flutter/material.dart';
import '../models/todo.dart';
import 'detail_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Data List berisi 3 item sesuai spesifikasi ekspektasi
    final List<Todo> todos = [
      Todo(
          title: 'Mengerjakan Modul Routing',
          description: 'Mempelajari implementasi Navigator.push pada Flutter.'),
      Todo(
          title: 'Desain UI Screen 2',
          description: 'Membuat layout vertikal menggunakan Column dan Container pastel.'),
      Todo(
          title: 'Push ke GitHub',
          description: 'Mengunggah source code dan melengkapi file README.md.'),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Tugas (Beranda)'),
      ),
      body: ListView.builder(
        itemCount: 3,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              leading: const Icon(Icons.assignment),
              title: Text(todos[index].title),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                // Proses perpindahan menggunakan Stack Navigation (Navigator.push)[cite: 1]
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailScreen(todo: todos[index]),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}