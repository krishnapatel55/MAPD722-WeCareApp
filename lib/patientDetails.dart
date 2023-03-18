import 'package:flutter/material.dart';

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
                    title: Text(
                      'Department',
                      style: const TextStyle(
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
                    onPressed: () {
                      // Implement edit functionality
                    },
                    icon: const Icon(Icons.edit),
                    label: const Text('Edit'),
                  ),
                  const SizedBox(width: 10.0),
                  ElevatedButton.icon(
                    onPressed: () {
                      // Implement delete functionality
                    },
                    icon: const Icon(Icons.delete),
                    label: const Text('Delete'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
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
}
