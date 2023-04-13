import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_milestone_project/updatePatient.dart';

import 'package:http/http.dart' as http;

import 'constants.dart';

class PatientDetailsPage extends StatelessWidget {
  final String patientID;
  String name;
  String address;
  String contactNo;
  String age;
  String gender;
  String department;
  String doctor;

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
                    onPressed: () async {
                      bool? result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => updatePatientScreen(
                                  patientID: patientID,
                                  name: name,
                                  address: address,
                                  contactNo: contactNo,
                                  age: age,
                                  gender: gender,
                                  department: department,
                                  doctor: doctor,
                                )),
                      );

                      if (result != null && result) {
                        Navigator.pop(context, true);
                      }
                      // name.value = result.item1 as String;
                      // address.value = result.item2 as String;
                      // contactNo.value = result.item3 as String;
                      // age.value = result.item4 as String;
                      // gender.value = result.item5 as String;
                      // department.value = result.item6 as String;
                      // doctor.value = result.item6 as String;
                    },
                    icon: const Icon(Icons.edit),
                    label: const Text('Edit', style: TextStyle(fontSize: 17)),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 15),
                  ElevatedButton.icon(
                    onPressed: () {
                      //deletePatient(context);
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text(
                              'Confirm Delete',
                              style: TextStyle(color: Colors.orange),
                              textAlign: TextAlign.center,
                            ),
                            content: const Text(
                                'Are you sure you want to delete this patient?',
                                style: TextStyle(fontSize: 17)),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Cancel',
                                    style: TextStyle(fontSize: 17)),
                              ),
                              TextButton(
                                onPressed: () {
                                  // delete patient functionality
                                  deletePatient(context);
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Delete',
                                    style: TextStyle(fontSize: 17)),
                              ),
                            ],
                          );
                        },
                      );
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
  void deletePatient(BuildContext context) async {
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
      Navigator.pop(context, true);
    } else {
      print("Error from server");
      // There was an error sending data to the server
    }
  }
}
