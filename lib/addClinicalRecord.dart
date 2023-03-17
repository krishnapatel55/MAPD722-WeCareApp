import 'package:flutter/material.dart';

class ClinicalRecordForm extends StatefulWidget {
  @override
  _ClinicalRecordFormState createState() => _ClinicalRecordFormState();
}

class _ClinicalRecordFormState extends State<ClinicalRecordForm> {
  final _formKey = GlobalKey<FormState>();

  final _bloodPressureController = TextEditingController();
  final _respiratoryRateController = TextEditingController();
  final _bloodOxygenLevelController = TextEditingController();
  final _heartbeatRateController = TextEditingController();

  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final bloodPressure = _bloodPressureController.text;
      final respiratoryRate = _respiratoryRateController.text;
      final bloodOxygenLevel = _bloodOxygenLevelController.text;
      final heartbeatRate = _heartbeatRateController.text;

      final date =
          '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}';
      final time = '${_selectedTime.hour}:${_selectedTime.minute}';

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Record Summary'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('Blood Pressure: $bloodPressure'),
                  Text('Respiratory Rate: $respiratoryRate'),
                  Text('Blood Oxygen Level: $bloodOxygenLevel'),
                  Text('Heartbeat Rate: $heartbeatRate'),
                  Text('Date: $date'),
                  Text('Time: $time'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
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
}
