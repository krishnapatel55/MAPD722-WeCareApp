import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_milestone_project/clinicalRecordHistory.dart';

import 'constants.dart';

import 'package:http/http.dart' as http;

class ClinicalRecordForm extends StatefulWidget {
  String patientID;

  ClinicalRecordForm(this.patientID);

  @override
  _ClinicalRecordFormState createState() => _ClinicalRecordFormState(patientID);
}

class _ClinicalRecordFormState extends State<ClinicalRecordForm> {
  final _formKey = GlobalKey<FormState>();

  final _bloodPressureController = TextEditingController();
  final _respiratoryRateController = TextEditingController();
  final _bloodOxygenLevelController = TextEditingController();
  final _heartbeatRateController = TextEditingController();

  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();

  String patientID;
  _ClinicalRecordFormState(this.patientID);

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final bloodPressure = _bloodPressureController.text;
      final respiratoryRate = _respiratoryRateController.text;
      final bloodOxygenLevel = _bloodOxygenLevelController.text;
      final heartbeatRate = _heartbeatRateController.text;
      var criticalCondition = "false";
      final date =
          '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}';
      final time = '${_selectedTime.hour}:${_selectedTime.minute}';

      if (int.parse(bloodPressure) > 120 || int.parse(bloodPressure) < 80) {
        criticalCondition = "true";
      } else if (int.parse(respiratoryRate) < 12 ||
          int.parse(respiratoryRate) > 16) {
        criticalCondition = "true";
      } else if (int.parse(bloodOxygenLevel) < 95) {
        criticalCondition = "true";
      } else if (int.parse(heartbeatRate) > 100 ||
          int.parse(heartbeatRate) < 60) {
        criticalCondition = "true";
      } else {
        criticalCondition = "false";
      }

      sendData(patientID, "nurse_name", date, time, bloodPressure,
          respiratoryRate, bloodOxygenLevel, heartbeatRate, criticalCondition);
    }
  }

  @override
  void dispose() {
    _bloodPressureController.dispose();
    _respiratoryRateController.dispose();
    _bloodOxygenLevelController.dispose();
    _heartbeatRateController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  Future<void> _pickTime() async {
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (pickedTime != null && pickedTime != _selectedTime) {
      setState(() {
        _selectedTime = pickedTime;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Add Clinical Record'),
          foregroundColor: Colors.white,
        ),
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(25),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      TextFormField(
                        style: const TextStyle(fontSize: 18.0),
                        controller: _bloodPressureController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Blood Pressure (mm Hg)',
                          hintText: 'e.g. 120/80',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter blood pressure';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 30),
                      TextFormField(
                        style: const TextStyle(fontSize: 18.0),
                        controller: _respiratoryRateController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Respiratory Rate (breaths/min)',
                          hintText: 'e.g. 12',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter respiratory rate';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 30),
                      TextFormField(
                        style: const TextStyle(fontSize: 18.0),
                        controller: _bloodOxygenLevelController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Blood Oxygen Level (%)',
                          hintText: 'e.g. 95',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter blood oxygen level';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 30),
                      TextFormField(
                        style: const TextStyle(fontSize: 18.0),
                        controller: _heartbeatRateController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Heartbeat Rate (beats/min)',
                          hintText: 'e.g. 60',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter heartbeat rate';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 30),
                      Row(
                        children: [
                          const Icon(
                            Icons.date_range,
                            color:
                                Colors.orange, // Change the color of the icon
                            size: 30,
                          ),
                          Expanded(
                              child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: GestureDetector(
                              onTap: _pickDate,
                              child: AbsorbPointer(
                                child: TextFormField(
                                  style: const TextStyle(fontSize: 18.0),
                                  decoration: const InputDecoration(
                                    labelText: 'Date',
                                    hintText: 'Enter the date',
                                  ),
                                  controller: TextEditingController(
                                    text:
                                        '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please select the date';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                          )),
                          //const SizedBox(width: 20),
                          const Icon(
                            Icons.access_time_filled,
                            color:
                                Colors.orange, // Change the color of the icon
                            size: 30,
                          ),
                          Expanded(
                              child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: GestureDetector(
                              onTap: _pickTime,
                              child: AbsorbPointer(
                                child: TextFormField(
                                  style: const TextStyle(fontSize: 18.0),
                                  decoration: const InputDecoration(
                                    labelText: 'Time',
                                    hintText: 'Enter the time',
                                  ),
                                  controller: TextEditingController(
                                    text:
                                        '${_selectedTime.hour}:${_selectedTime.minute}',
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please select the time';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                          )),
                        ],
                      ),
                      const SizedBox(height: 32.0),
                      Center(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              onPrimary: Colors.white,
                              textStyle: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold) // text color
                              ),
                          onPressed: _submitForm,
                          child: const Text('Submit'),
                        ),
                      )
                    ],
                  ),
                ))));
  }

  sendData(
      String _id,
      String nurse_name,
      String datetext,
      String timetext,
      String blood_pressue,
      String respiratory_rate,
      String blood_oxygen,
      String heart_rate,
      String critical_condition) async {
    final url = '$urlPort/patients/$_id/tests';
    final headers = {'Content-Type': 'application/json'};

    final data = {
      "patient_id": _id,
      "nurse_name": nurse_name,
      "date": datetext,
      "time": timetext,
      "blood_pressue": blood_pressue,
      "respiratory_rate": respiratory_rate,
      "blood_oxygen": blood_oxygen,
      "heart_rate": heart_rate,
      "critical_condition": critical_condition
    };

    final response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      print(response.body.toString());
      // Data was successfully sent to the server

      // Navigate to a new page and reload this page when the new page is popped
      // ignore: use_build_context_synchronously
      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(builder: (context) => ClinicalDataListView(_id)),
      // );
      // ignore: use_build_context_synchronously
      Navigator.pop(context, true);
    } else {
      print("Error from server");
      // There was an error sending data to the server
    }
  }
}
