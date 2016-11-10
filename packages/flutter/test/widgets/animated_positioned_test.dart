// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

void main() {
  testWidgets('AnimatedPositioned - basics', (WidgetTester tester) async {
    GlobalKey key = new GlobalKey();

    RenderBox box;

    await tester.pumpWidget(
      new Stack(
        children: <Widget>[
          new AnimatedPositioned(
            child: new Container(key: key),
            left: 50.0,
            top: 30.0,
            width: 70.0,
            height: 110.0,
            duration: const Duration(seconds: 2)
          )
        ]
      )
    );

    box = key.currentContext.findRenderObject();
    expect(box.localToGlobal(box.size.center(Point.origin)), equals(const Point(50.0 + 70.0 / 2.0, 30.0 + 110.0 / 2.0)));

    await tester.pump(const Duration(seconds: 1));

    box = key.currentContext.findRenderObject();
    expect(box.localToGlobal(box.size.center(Point.origin)), equals(const Point(50.0 + 70.0 / 2.0, 30.0 + 110.0 / 2.0)));

    await tester.pumpWidget(
      new Stack(
        children: <Widget>[
          new AnimatedPositioned(
            child: new Container(key: key),
            left: 37.0,
            top: 31.0,
            width: 59.0,
            height: 71.0,
            duration: const Duration(seconds: 2)
          )
        ]
      )
    );

    box = key.currentContext.findRenderObject();
    expect(box.localToGlobal(box.size.center(Point.origin)), equals(const Point(50.0 + 70.0 / 2.0, 30.0 + 110.0 / 2.0)));

    await tester.pump(const Duration(seconds: 1));

    box = key.currentContext.findRenderObject();
    expect(box.localToGlobal(box.size.center(Point.origin)), equals(const Point(50.0 - (50.0 - 37.0) / 2.0 + (70.0 - (70.0 - 59.0) / 2.0) / 2.0,
                                                                                30.0 + (31.0 - 30.0) / 2.0 + (110.0 - (110.0 - 71.0) / 2.0) / 2.0)));

    await tester.pump(const Duration(seconds: 1));

    box = key.currentContext.findRenderObject();
    expect(box.localToGlobal(box.size.center(Point.origin)), equals(const Point(37.0 + 59.0 / 2.0, 31.0 + 71.0 / 2.0)));
  });

  testWidgets('AnimatedPositioned - interrupted animation', (WidgetTester tester) async {
    GlobalKey key = new GlobalKey();

    RenderBox box;

    await tester.pumpWidget(
      new Stack(
        children: <Widget>[
          new AnimatedPositioned(
            child: new Container(key: key),
            left: 0.0,
            top: 0.0,
            width: 100.0,
            height: 100.0,
            duration: const Duration(seconds: 2)
          )
        ]
      )
    );

    box = key.currentContext.findRenderObject();
    expect(box.localToGlobal(box.size.center(Point.origin)), equals(const Point(50.0, 50.0)));

    await tester.pump(const Duration(seconds: 1));

    box = key.currentContext.findRenderObject();
    expect(box.localToGlobal(box.size.center(Point.origin)), equals(const Point(50.0, 50.0)));

    await tester.pumpWidget(
      new Stack(
        children: <Widget>[
          new AnimatedPositioned(
            child: new Container(key: key),
            left: 100.0,
            top: 100.0,
            width: 100.0,
            height: 100.0,
            duration: const Duration(seconds: 2)
          )
        ]
      )
    );

    box = key.currentContext.findRenderObject();
    expect(box.localToGlobal(box.size.center(Point.origin)), equals(const Point(50.0, 50.0)));

    await tester.pump(const Duration(seconds: 1));

    box = key.currentContext.findRenderObject();
    expect(box.localToGlobal(box.size.center(Point.origin)), equals(const Point(100.0, 100.0)));

    await tester.pumpWidget(
      new Stack(
        children: <Widget>[
          new AnimatedPositioned(
            child: new Container(key: key),
            left: 150.0,
            top: 150.0,
            width: 100.0,
            height: 100.0,
            duration: const Duration(seconds: 2)
          )
        ]
      )
    );

    box = key.currentContext.findRenderObject();
    expect(box.localToGlobal(box.size.center(Point.origin)), equals(const Point(100.0, 100.0)));

    await tester.pump(const Duration(seconds: 1));

    box = key.currentContext.findRenderObject();
    expect(box.localToGlobal(box.size.center(Point.origin)), equals(const Point(150.0, 150.0)));

    await tester.pump(const Duration(seconds: 1));

    box = key.currentContext.findRenderObject();
    expect(box.localToGlobal(box.size.center(Point.origin)), equals(const Point(200.0, 200.0)));
  });

  testWidgets('AnimatedPositioned - switching variables', (WidgetTester tester) async {
    GlobalKey key = new GlobalKey();

    RenderBox box;

    await tester.pumpWidget(
      new Stack(
        children: <Widget>[
          new AnimatedPositioned(
            child: new Container(key: key),
            left: 0.0,
            top: 0.0,
            width: 100.0,
            height: 100.0,
            duration: const Duration(seconds: 2)
          )
        ]
      )
    );

    box = key.currentContext.findRenderObject();
    expect(box.localToGlobal(box.size.center(Point.origin)), equals(const Point(50.0, 50.0)));

    await tester.pump(const Duration(seconds: 1));

    box = key.currentContext.findRenderObject();
    expect(box.localToGlobal(box.size.center(Point.origin)), equals(const Point(50.0, 50.0)));

    await tester.pumpWidget(
      new Stack(
        children: <Widget>[
          new AnimatedPositioned(
            child: new Container(key: key),
            left: 0.0,
            top: 100.0,
            right: 100.0, // 700.0 from the left
            height: 100.0,
            duration: const Duration(seconds: 2)
          )
        ]
      )
    );

    box = key.currentContext.findRenderObject();
    expect(box.localToGlobal(box.size.center(Point.origin)), equals(const Point(350.0, 50.0)));

    await tester.pump(const Duration(seconds: 1));

    box = key.currentContext.findRenderObject();
    expect(box.localToGlobal(box.size.center(Point.origin)), equals(const Point(350.0, 100.0)));

    await tester.pump(const Duration(seconds: 1));

    box = key.currentContext.findRenderObject();
    expect(box.localToGlobal(box.size.center(Point.origin)), equals(const Point(350.0, 150.0)));
  });

}