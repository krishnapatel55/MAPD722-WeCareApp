import 'package:flutter/material.dart';
import 'package:flutter_milestone_project/addClinicalRecord.dart';
import 'package:flutter_milestone_project/constants.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ClinicalDataListView extends StatefulWidget {
  @override
  _ClinicalDataListViewState createState() => _ClinicalDataListViewState();
}

class _ClinicalDataListViewState extends State<ClinicalDataListView> {
  List<dynamic> data = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http
        .get(Uri.parse('$urlPort/patients/640c0bf6a777018f31b917ca/tests'));
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
      appBar: AppBar(
        title: const Text('Clinical Record History'),
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
                        builder: (context) => ClinicalRecordForm()),
                  )),
        ],
      ),
      body: ListView.builder(
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
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
                            // ignore: prefer_interpolation_to_compose_strings
                            'Blood Pressure : ' +
                                data[index]['blood_pressue'] +
                                ' mmHg',
                            style: const TextStyle(fontSize: 18.0),
                          ),
                          const SizedBox(height: 8.0),
                          Text(
                            // ignore: prefer_interpolation_to_compose_strings
                            'Respiratory Rate : ' +
                                data[index]['respiratory_rate'],
                            style: const TextStyle(fontSize: 18.0),
                          ),
                          const SizedBox(height: 8.0),
                          Text(
                            // ignore: prefer_interpolation_to_compose_strings
                            'Blood Oxygen Level : ' +
                                data[index]['blood_oxygen'] +
                                '%',
                            style: const TextStyle(fontSize: 18.0),
                          ),
                          const SizedBox(height: 8.0),
                          Text(
                            // ignore: prefer_interpolation_to_compose_strings
                            'Heartbeat Rate : ' + data[index]['heart_rate'],
                            style: const TextStyle(fontSize: 18.0),
                          ),
                          const SizedBox(height: 8.0),
                          Text(
                            // ignore: prefer_interpolation_to_compose_strings
                            '                                                               ' +
                                data[index]['date'] +
                                '  ' +
                                data[index]['time'],
                            textAlign: TextAlign.right,
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
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
