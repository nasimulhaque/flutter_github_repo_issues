import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class Skeleton extends GetView {

  final double width;
  final double height;

  const Skeleton({super.key, required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.black12,
      highlightColor: Colors.black38,
      enabled: true,
      child: Container(
        color: Colors.black26,
        width: width,
        height: height,
      ),
    );
  }
}