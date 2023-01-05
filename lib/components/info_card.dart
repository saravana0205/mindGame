import 'package:flutter/material.dart';

Widget infoCard(String title, String info) {
  return Expanded(
    child: Container(
      margin: const EdgeInsets.all(26.0),
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Card(
        elevation: 8,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 26.0),
          child: Column(
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 6.0,
              ),
              Text(
                info,
                style: const TextStyle(
                    fontSize: 34.0, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
