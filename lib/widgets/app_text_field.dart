import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  final String hint;
  final IconData icon;
  final TextInputType? keyboardType;
  final Function(String?) onClick;
  const AppTextField({
    Key? key,
    required this.hint,
    required this.icon,
    required this.onClick,
    this.keyboardType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        child: TextFormField(
          obscureText: hint == 'password' ? true : false,
          validator: (value) {
            if (value!.isEmpty) return '${hint} is Empty';
          },
          keyboardType: keyboardType,
          onSaved: onClick,
          style: TextStyle(color: Colors.white),
          cursorColor: Colors.white,
          decoration: InputDecoration(
            prefixIcon: Icon(
              icon,
              color: Colors.white,
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 2),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 2),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 2),
            ),
            hintText: hint,
            hintStyle: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
      ),
    );
  }
}
