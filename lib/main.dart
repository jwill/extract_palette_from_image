// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'dart:math' as math;

import 'package:extract_palette_from_image/image.dart';
import 'package:extract_palette_from_image/scheme_preview.dart';
import 'package:flutter/material.dart';

import 'package:palette_generator/palette_generator.dart';
import 'package:signals_flutter/signals_core.dart';
import 'package:signals_flutter/signals_flutter.dart';
import 'color_box.dart';
import 'image_colors.dart';
import 'palette_swatch.dart';
import 'utils.dart';
import 'constants.dart';

void main() => runApp(const MyApp());

var colors = signal(<Color>[]);
var scheme = signal(ColorScheme.fromSeed(seedColor: Colors.purple));

/// The main Application class.
class MyApp extends StatelessWidget {
  /// Creates the main Application class.
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final imageName = 'assets/pascal-debrunner-vwFvhJf6u_I-unsplash.png';
    getColorsFromImage(AssetImage(imageName)).then((c) {
      colors.value = c;
      scheme.value = ColorScheme.fromSeed(seedColor: c[0],
      dynamicSchemeVariant: DynamicSchemeVariant.tonalSpot
      );
    });

    return MaterialApp(
      title: 'Image Colors',
      theme: ThemeData(colorSchemeSeed: Colors.green),
      home: Scaffold(
        appBar: AppBar(title: Text("Palette Demo")),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                ImageColors(
                  title: 'Image Colors',
                  image: AssetImage(imageName),
                  imageSize: Size(256.0, 170.0),
                ),
                SizedBox(height: 16),
                Divider(height: 2.0),
                SizedBox(height: 16),

                SizedBox(
                  width: 350,
                  height: 100,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: colors.value.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Row(
                        children: [
                          Container(
                            height: 64,
                            color: colors.value[index],
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Center(
                                child: Text(
                                  'Color $index',
                                  style: TextStyle(
                                    color: colors.value[index].onColor(),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 16, height: 10),
                        ],
                      );
                    },
                  ),
                ),

                SchemePreview(
                  label: "",
                  scheme: scheme.watch(context),
                  brightness: Brightness.light,
                  seed: scheme.value.primary,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// The home page for this example app.
