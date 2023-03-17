import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class addPatientScreen extends StatelessWidget {
  const addPatientScreen({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'We Care App',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: Colors.orange,
            textStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          contentPadding:
              const EdgeInsets.only(left: 14.0, bottom: 12.0, top: 0.0),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.indigo),
          ),
        ),
      ),
      home: const PersonalInfoForm(title: 'Add Patient'),
    );
  }
}

class PersonalInfoForm extends StatefulWidget {
  const PersonalInfoForm({super.key, required this.title});
  final String title;
  @override
  // ignore: library_private_types_in_public_api
  _PersonalInfoFormState createState() => _PersonalInfoFormState();
}

class _PersonalInfoFormState extends State<PersonalInfoForm> {
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
                          print('Name: $name');
                          print('Address: $address');
                          print('Contact: $contact');
                          print('Department: $department');
                          print('Doctor: $doctor');
                          print('Age: $age');
                          print('Gender: $gender');
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
}
