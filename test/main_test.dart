import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_milestone_project/addPatientScreen.dart';
import 'package:flutter_milestone_project/loginScreen.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_milestone_project/main.dart';
import 'package:flutter_milestone_project/constants.dart' as Constants;
import 'package:http/http.dart' as http;

void main() {
  test("Some matcher test", () {
    expect(const MyApp(), isA<MyApp>());
  });

  test("Patient API Response Test", () async {
    final response = await http.get(Uri.parse('${Constants.urlPort}/patients'));
    final data = json.decode(response.body);

    expect(response.statusCode, 200);
    expect(data, isNotEmpty);
    expect(data[0]['_id'], isNotEmpty);
    expect(data[0]['patient_name'], equals("Jenny"));
    expect(data[0]['address'], isNotEmpty);
    expect(data[0]['contact_no'], isNotEmpty);
    expect(data[0]['age'], isNotEmpty);
    expect(data[0]['gender'], isNotEmpty);
    expect(data[0]['department'], isNotEmpty);
    expect(data[0]['doctor'], isNotEmpty);
    expect(data[0]['critical_condition'], true);
  });
}
