import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'utils.dart';

import 'material_icon.dart';

class ColorBox extends StatefulWidget {
  const ColorBox({
    super.key,
    required this.label,
    required this.tone,
    required this.color,
    required this.onColor,
    required this.height,
    required this.width,
  });

  final String label;
  final String tone;
  final Color color, onColor;
  final double height, width;

  @override
  State<ColorBox> createState() => _ColorBoxState();
}

class _ColorBoxState extends State<ColorBox> {
  bool hovered = false;

  @override
  Widget build(BuildContext context) {
    final fonts = Theme.of(context).textTheme;
    return MouseRegion(
      onEnter: (_) {
        if (mounted) setState(() => hovered = true);
      },
      onExit: (_) {
        if (mounted) setState(() => hovered = false);
      },
      child: Container(
        color: widget.color,
        height: widget.height,
        width: widget.width,
        child: DefaultTextStyle(
          style: fonts.labelSmall!.copyWith(color: widget.onColor),
          child: Stack(
            children: [
              Positioned(
                top: 10,
                left: 10,
                child: Text(widget.label),
              ),
              if (hovered)
                Positioned(
                  top: 0,
                  right: 0,
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    color: widget.onColor,
                    tooltip: 'Copy hex color',
                    icon: const MaterialIcon(Icons.copy),
                    onPressed: () async {
                      final messenger = ScaffoldMessenger.of(context);
                      // Copy color as hex to clipboard
                      var hex = widget.color.toHex();
                      final data = ClipboardData(text: hex);
                      await Clipboard.setData(data);
                      messenger.hideCurrentSnackBar();
                      messenger.showSnackBar(
                        SnackBar(
                          content: Text('Copied $hex to clipboard'),
                        ),
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
