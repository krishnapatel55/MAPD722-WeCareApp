// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.


import 'package:flutter/material.dart';
import 'package:flutter_milestone_project/addPatientScreen.dart';
import 'package:flutter_milestone_project/loginScreen.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_milestone_project/main.dart';
import 'package:flutter_milestone_project/constants.dart' as Constants;
import 'package:http/http.dart' as http;

void main() {
    group('Login Screen TextForm Field', () {
    Widget testwidget = MediaQuery(
        data: const MediaQueryData(), child: MaterialApp(home: loginScreen()));
    testWidgets('Render 2 TextField', (WidgetTester tester) async {
      await tester.pumpWidget(testwidget);
      expect(
          find.byType(TextFormField),
          findsNWidgets(
              2)); // Expecting 2 TextFormField widget on Login Screen.
    });
  });

  group('Main Screen listview Field', () {
    Widget testwidget = const MediaQuery(
        data: MediaQueryData(), child: MaterialApp(home: addPatientScreen()));
    testWidgets('Render Listview', (WidgetTester tester) async {
      await tester.pumpWidget(testwidget);
      expect(find.byType(TextFormField),
          findsWidgets); // Expecting ListView widget on main Screen.
    });
  });
}
