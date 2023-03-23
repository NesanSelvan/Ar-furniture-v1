import 'package:arapp/screens/allproduct.dart';
import 'package:arapp/screens/ar_design.dart';
import 'package:arapp/screens/defaultgrabbing.dart';
import 'package:flutter/material.dart';
import 'package:snapping_sheet/snapping_sheet.dart';

class downscroll extends StatelessWidget {
  final ScrollController _scrollController = ScrollController();

  downscroll({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: DarkAppBar(title: "Snapping Sheet - Below").build(context),
      body: SnappingSheet(
        lockOverflowDrag: true,
        snappingPositions: const [
          SnappingPosition.factor(
            positionFactor: 0.0,
            grabbingContentOffset: GrabbingContentOffset.top,
          ),
          SnappingPosition.factor(
            snappingCurve: Curves.elasticOut,
            snappingDuration: Duration(milliseconds: 1750),
            positionFactor: 0.5,
          ),
          SnappingPosition.factor(positionFactor: 0.9),
        ],
        grabbingHeight: 75,
        grabbing: const DefaultGrabbing(),
        sheetBelow: SnappingSheetContent(
          childScrollController: _scrollController,
          draggable: true,
          // ignore: prefer_const_constructors
          child: AllProduct(
            url: (String value) {},
          ),
        ),
        child: const ArDesign(),
      ),
    );
  }
}
