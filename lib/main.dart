import 'package:flutter/material.dart';
import 'package:flutter_milestone_project/AddPatientScreen.dart';
import 'package:flutter_milestone_project/addClinicalRecord.dart';
import 'package:flutter_milestone_project/clinicalRecordHistory.dart';
import 'package:flutter_milestone_project/loginScreen.dart';
import 'package:flutter_milestone_project/patientDetails.dart';
import 'package:flutter_milestone_project/updatePatient.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(
    theme: ThemeData(primarySwatch: Colors.orange),
    title: "home",
    home: loginScreen(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Patients List'),
        foregroundColor: Colors.white,
        actions: <Widget>[
          IconButton(
              icon: const Icon(
                Icons.add,
                size: 35,
                color: Colors.white,
              ),
              onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const addPatientScreen()),
                  )),
        ],
      ),
      body: MyDataListView(),
    );
  }
}

class MyDataListView extends StatefulWidget {
  @override
  _MyDataListViewState createState() => _MyDataListViewState();
}

class _MyDataListViewState extends State<MyDataListView> {
  List<dynamic> data = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response =
        await http.get(Uri.parse('http://10.0.0.104:8000/patients'));
    // await http.get(Uri.parse('http://192.168.2.23:8000/patients'));
    if (response.statusCode == 200) {
      setState(() {
        data = jsonDecode(response.body);
        print("response" + response.body);
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //       builder: (context) =>
              //           updatePatientScreen(data: data[index]['patient_name'])),
              // );
            },
            child: Card(
              elevation: 5.0, // Set the elevation for shadow effect
              shadowColor: Colors.grey, // Set the shadow color
              margin:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            data[index]['patient_name'],
                            style: const TextStyle(fontSize: 18.0),
                          ),
                          const SizedBox(height: 8.0),
                          Text(
                            data[index]['address'],
                            style: const TextStyle(
                                fontSize: 14.0, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const PatientDetailsPage(
                                  name: 'John Doe',
                                  address: '123 Main St, Anytown, USA',
                                  contactNo: '555-555-1212',
                                  age: 42,
                                  gender: 'Male',
                                  department: 'Cardiology',
                                  doctor: 'Dr. Jane Smith',
                                ),
                              ),
                            );
                          },
                          child: const Icon(
                            Icons.person,
                            size: 30,
                            color: Colors.orange,
                          ),
                        ),
                        const SizedBox(width: 20),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ClinicalDataListView()),
                            );
                          },
                          child: const Icon(
                            Icons.medical_services,
                            size: 30,
                            color: Colors.orange,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
