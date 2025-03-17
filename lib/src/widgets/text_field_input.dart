import 'package:flutter/material.dart';

class TextFieldInput extends StatelessWidget {
  final String label;
  final bool? isPasswordField;
  final bool textarea;
  final String? hintText;
  final TextEditingController? controller;
  final validator;

  const TextFieldInput(
      {super.key,
      required this.label,
      this.isPasswordField = false,
      this.hintText,
      this.textarea = false,
      this.controller,
      this.validator});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
        ),
        TextFormField(
          controller: controller,
          validator: validator,
          obscureText: isPasswordField! ? true : false,
          cursorColor: Colors.black,
          maxLines: isPasswordField == false
              ? textarea == true
                  ? 5
                  : 1
              : 1,
          decoration: InputDecoration(
            hintText: hintText,
            border: const OutlineInputBorder(
              borderSide: BorderSide(),
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            focusColor: Colors.black,
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
