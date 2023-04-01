import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_milestone_project/constants.dart';
import 'package:http/http.dart' as http;

class addPatientScreen extends StatefulWidget {
  const addPatientScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PersonalInfoFormState createState() => _PersonalInfoFormState();
}

class _PersonalInfoFormState extends State<addPatientScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _contactController = TextEditingController();
  final _departmentController = TextEditingController();
  final _doctorController = TextEditingController();
  final _ageController = TextEditingController();
  String? _gender = "male";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
            title: const Text('Add Patient'),
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

                          sendData(name, address, contact, department, doctor,
                              age, gender);
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

  sendData(String name, String address, String contact, String department,
      String doctor, String age, String gender) async {
    const url = '$urlPort/patients';
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

    final response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: jsonEncode(data),
    );

    if (response.statusCode == 201) {
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
