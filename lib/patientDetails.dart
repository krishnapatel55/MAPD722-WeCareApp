import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_milestone_project/main.dart';

import 'package:http/http.dart' as http;

import 'constants.dart';

class PatientDetailsPage extends StatelessWidget {
  final String patientID;
  final String name;
  final String address;
  final String contactNo;
  final String age;
  final String gender;
  final String department;
  final String doctor;

  PatientDetailsPage({
    Key? key,
    required this.patientID,
    required this.name,
    required this.address,
    required this.contactNo,
    required this.age,
    required this.gender,
    required this.department,
    required this.doctor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Patient Details'),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.person,
                        size: 48.0, color: Colors.orange),
                    title: Text(
                      name,
                      style: const TextStyle(
                          fontSize: 24.0, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      '$age years, $gender',
                      style: const TextStyle(fontSize: 18.0),
                    ),
                  ),
                  ExpansionTile(
                    title: const Text(
                      'Department',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    children: [
                      ListTile(
                        title: Text(
                          department,
                          style: const TextStyle(fontSize: 18.0),
                        ),
                        subtitle: Text(
                          'Doctor: $doctor',
                          style: const TextStyle(fontSize: 18.0),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Card(
              child: ExpansionTile(
                title: const Text(
                  'Contact Information',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                children: [
                  ListTile(
                    title: const Text(
                      'Address',
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      address,
                      style: const TextStyle(fontSize: 16.0),
                    ),
                  ),
                  ListTile(
                    title: const Text(
                      'Phone',
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      contactNo,
                      style: const TextStyle(fontSize: 16.0),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.edit),
                    label: const Text('Edit', style: TextStyle(fontSize: 17)),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 15),
                  ElevatedButton.icon(
                    onPressed: () {
                      // Implement delete functionality
                      deletePatient();
                    },
                    icon: const Icon(Icons.delete),
                    label: const Text('Delete', style: TextStyle(fontSize: 17)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Delete patients by sending there id to the server.
  void deletePatient() async {
    final url = '$urlPort/patients/$patientID';
    final headers = {'Content-Type': 'application/json'};

    final data = {
      "patient_id": patientID,
    };

    final response = await http.delete(
      Uri.parse(url),
      headers: headers,
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      print(response.body.toString());
      // ignore: use_build_context_synchronously
      // Navigator.pushReplacement(context,
      //   MaterialPageRoute(builder: (context) => const MyApp()),
      // );
    } else {
      print("Error from server");
      // There was an error sending data to the server
    }
  }
}
