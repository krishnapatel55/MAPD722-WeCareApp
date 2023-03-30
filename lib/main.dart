import 'package:flutter/material.dart';
import 'package:flutter_milestone_project/AddPatientScreen.dart';
import 'package:flutter_milestone_project/addClinicalRecord.dart';
import 'package:flutter_milestone_project/clinicalRecordHistory.dart';
import 'package:flutter_milestone_project/loginScreen.dart';
import 'package:flutter_milestone_project/patientDetails.dart';
import 'package:flutter_milestone_project/updatePatient.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'constants.dart' as Constants;

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
  List<dynamic> searchDataList = [];
  bool _isSearchBarVisible = false;
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void onFilter(bool isShowCriticalPatient) {
    setState(() {
      if (isShowCriticalPatient) {
        data.clear();
        for (var i = 0; i < searchDataList.length; i++) {
          if (searchDataList[i]['critical_condition']
              .toString()
              .toLowerCase()
              .contains("true")) {
            data.add(searchDataList[i]);
          }
        }
      } else {
        data.clear();
        data.addAll(searchDataList);
      }
    });
  }

  void onSearch(String searchQuery) {
    setState(() {
      if (searchQuery.toString().trim() != "" &&
          searchQuery.trim().isNotEmpty) {
        data.clear();

        for (var i = 0; i < searchDataList.length; i++) {
          if (searchDataList[i]['patient_name']
              .toString()
              .toLowerCase()
              .contains(searchQuery.toLowerCase())) {
            data.add(searchDataList[i]);
          }
        }
      } else {
        data.clear();
        data.addAll(searchDataList);
      }
    });
  }

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse('${Constants.urlPort}/patients'));
    if (response.statusCode == 200) {
      setState(() {
        data = jsonDecode(response.body);
        searchDataList = jsonDecode(response.body);
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
          PopupMenuButton<String>(
            onSelected: (result) {
              // Handle filter option selection
              if (result == "Critical Patients") {
                onFilter(true);
              } else {
                onFilter(false);
              }
            },
            icon: const Icon(
              Icons.filter_list_alt,
              color: Colors.white,
              size: 28,
            ),
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem(
                  value: 'All Patients',
                  child: Text('All Patients'),
                ),
                const PopupMenuItem(
                  value: 'Critical Patients',
                  child: Text('Critical Patients'),
                ),
              ];
            },
          ),
        ],
      ),
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
                                builder: (context) => PatientDetailsPage(
                                  patientID: data[index]['_id'],
                                  name: data[index]['patient_name'],
                                  address: data[index]['address'],
                                  contactNo: data[index]['contact_no'],
                                  age: data[index]['age'],
                                  gender: data[index]['gender'],
                                  department: data[index]['department'],
                                  doctor: data[index]['doctor'],
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
                                  builder: (context) =>
                                      ClinicalDataListView(data[index]['_id'])),
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
      floatingActionButton: AnimatedSwitcher(
        duration: const Duration(milliseconds: 250),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return ScaleTransition(
            scale: animation,
            child: child,
          );
        },
        child: _isSearchBarVisible
            ? Container(
                height: kToolbarHeight,
                //margin: const EdgeInsets.symmetric(horizontal: 30),
                margin: const EdgeInsets.only(left: 30),
                decoration: BoxDecoration(
                  color: Colors.transparent.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(50.0),
                ),
                child: Row(
                  children: [
                    const SizedBox(width: 18),
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        autofocus: true,
                        cursorColor: Colors.white,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 18),
                        decoration: const InputDecoration(
                          hintText: 'Search',
                          hintStyle: TextStyle(color: Colors.grey),
                          border: InputBorder.none,
                        ),
                        onChanged: (value) {
                          onSearch(value);
                        },
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.white),
                      onPressed: () {
                        setState(() {
                          _isSearchBarVisible = false;
                          _searchController.clear();
                          data.clear();
                          data.addAll(searchDataList);
                        });
                      },
                    ),
                  ],
                ),
              )
            : FloatingActionButton(
                onPressed: () {
                  setState(() {
                    _isSearchBarVisible = true;
                  });
                },
                child: const Icon(
                  Icons.search,
                  color: Colors.white,
                  size: 30,
                ),
              ),
      ),
    );
  }
}
