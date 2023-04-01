import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'constants.dart';

class updatePatientScreen extends StatefulWidget {
  final String patientID;
  final String name;
  final String address;
  final String contactNo;
  final String age;
  final String gender;
  final String department;
  final String doctor;

  updatePatientScreen({
    super.key,
    required this.patientID,
    required this.name,
    required this.address,
    required this.contactNo,
    required this.age,
    required this.gender,
    required this.department,
    required this.doctor,
  });

  @override
  _updatePatientForm createState() => _updatePatientForm(
      patientID, name, address, contactNo, age, gender, department, doctor);
}

class _updatePatientForm extends State<updatePatientScreen> {
  final String patientID;
  final String name;
  final String address;
  final String contactNo;
  final String age;
  final String gender;
  final String department;
  final String doctor;

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController(text: '');
  final _addressController = TextEditingController(text: '');
  final _contactController = TextEditingController(text: '');
  final _departmentController = TextEditingController(text: '');
  final _doctorController = TextEditingController(text: '');
  final _ageController = TextEditingController(text: '');
  String? _gender = "male";

  _updatePatientForm(
    this.patientID,
    this.name,
    this.address,
    this.contactNo,
    this.age,
    this.gender,
    this.department,
    this.doctor,
  ) {
    _nameController.text = name;
    _addressController.text = address;
    _contactController.text = contactNo;
    _departmentController.text = department;
    _doctorController.text = doctor;
    _ageController.text = age;
    _gender = gender.toString().toLowerCase();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
            title: const Text('Update Patient'),
            foregroundColor: Colors.white,
            leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () =>
                    Navigator.of(context, rootNavigator: true).pop())),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Name :',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange),
                  ),
                  TextFormField(
                    controller: _nameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    'Address :',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange),
                  ),
                  TextFormField(
                    controller: _addressController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your address';
                      }
                      return null;
                    },
                    maxLines: null,
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    'Contact :',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange),
                  ),
                  TextFormField(
                    controller: _contactController,
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your contact number';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    'Department :',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange),
                  ),
                  TextFormField(
                    controller: _departmentController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your department';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    'Doctor :',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange),
                  ),
                  TextFormField(
                    controller: _doctorController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your doctor';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    'Age :',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange),
                  ),
                  TextFormField(
                    controller: _ageController,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your age';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      const Text("Gender : ",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.orange)),
                      Expanded(
                        child: RadioListTile(
                          title: const Text("Male"),
                          value: "male",
                          groupValue: _gender,
                          onChanged: (value) {
                            setState(() {
                              _gender = value;
                            });
                          },
                        ),
                      ),
                      Expanded(
                        child: RadioListTile(
                          title: const Text("Female"),
                          value: "female",
                          groupValue: _gender,
                          onChanged: (value) {
                            setState(() {
                              _gender = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32.0),
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        onPrimary: Colors.white, // text color
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // Do something with the form data
                          String name = _nameController.text;
                          String address = _addressController.text;
                          String contact = _contactController.text;
                          String department = _departmentController.text;
                          String doctor = _doctorController.text;
                          String age = _ageController.text;
                          String gender = _gender!;

                          updatePatientDataApi(name, address, contact,
                              department, doctor, age, gender);
                        }
                      },
                      child: const Text('Submit'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  updatePatientDataApi(String name, String address, String contact,
      String department, String doctor, String age, String gender) async {
    final url = '$urlPort/patients/$patientID';
    final headers = {'Content-Type': 'application/json'};

    final data = {
      "patient_name": name,
      "address": address,
      "age": age,
      "gender": gender,
      "contact_no": contact,
      "department": department,
      "doctor": doctor,
    };

    final response = await http.put(
      Uri.parse(url),
      headers: headers,
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      print(response.body.toString());
      // Data was successfully sent to the server

      // Navigate to a new page and reload this page when the new page is popped
      // ignore: use_build_context_synchronously
      Navigator.pop(context, true);
    } else {
      print("Error from server");
      // There was an error sending data to the server
    }
  }
}
