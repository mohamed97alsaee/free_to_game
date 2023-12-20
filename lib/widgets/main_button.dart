import 'package:flutter/material.dart';

class MainButton extends StatefulWidget {
  const MainButton(
      {super.key,
      required this.text,
      required this.color,
      required this.isActive,
      required this.onPressd,
      required this.isLoading,
      required this.txtcolor});
  final String text;
  final Color color;
  final Color txtcolor;

  final bool isActive;
  final Function onPressd;
  final bool isLoading;
  @override
  State<MainButton> createState() => _MainButtonState();
}

class _MainButtonState extends State<MainButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.isActive) {
          widget.onPressd();
        }
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color:
                widget.isActive ? widget.color : widget.color.withOpacity(0.5)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              widget.isLoading
                  ? const SizedBox(
                      width: 20, height: 20, child: CircularProgressIndicator())
                  : Text(
                      widget.text,
                      style: TextStyle(
                          color: widget.txtcolor, fontWeight: FontWeight.bold),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
