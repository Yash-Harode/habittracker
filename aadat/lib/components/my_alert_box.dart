import 'package:flutter/material.dart';

class MyAlertBox extends StatelessWidget {
  final controller;
  //final String hintText;
  final VoidCallback onSave;
  final VoidCallback onCancel;

  const MyAlertBox({
    super.key,
    required this.controller,
    // required this.hintText,
    required this.onSave,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.grey[900],
      content: TextField(
        controller: controller,
        style: const TextStyle(
          color: Color.fromARGB(255, 230, 225, 225),
        ),
        decoration: InputDecoration(
          hintText: "Enter Habit Name",
          hintStyle: TextStyle(color: Colors.grey[900]),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white)),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white)),
        ),
      ),
      actions: [
        MaterialButton(
          onPressed: onSave,
          color: Colors.black,
          child: const Text(
            "Save",
            style: TextStyle(color: Colors.white),
          ),
        ),
        MaterialButton(
          onPressed: onCancel,
          color: Colors.black,
          child: const Text(
            "Cancel",
            style: TextStyle(color: Colors.white),
          ),
        )
      ],
    );
  }
}
