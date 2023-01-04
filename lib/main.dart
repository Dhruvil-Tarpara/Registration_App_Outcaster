import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  formDecoration(icon, String text) {
    return InputDecoration(
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(22),
        borderSide: const BorderSide(
          color: Color(0xffB7C5C0),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(22),
        borderSide: const BorderSide(
          color: Color(0xffB7C5C0),
        ),
      ),
      filled: true,
      fillColor: Colors.white,
      hintText: text,
      icon: Icon(icon),
    );
  }

  int current = 0;
  String? redioval;
  String? selectedImagePath;
  final ImagePicker _picker = ImagePicker();

  Color my = const Color(0xff3E6356);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
          statusBarColor: Color(0xffb7c5c0),
          statusBarIconBrightness: Brightness.dark),
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffb7c5c0),
        title: const Text(
          "Registration",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/logo.png"),
            opacity: 0.2,
          ),
        ),
        child: Theme(
          data: ThemeData(
              primarySwatch: Colors.blueGrey,
              colorScheme: const ColorScheme.light(primary: Color(0xff3E6356))),
          child: Stepper(
            physics: const BouncingScrollPhysics(),
            currentStep: current,
            onStepTapped: (val) {
              setState(() {
                current = val;
              });
            },
            onStepContinue: () {
              setState(() {
                if (current < 10) current++;
              });
            },
            onStepCancel: () {
              setState(() {
                if (current > 0) current--;
              });
            },
            steps: [
              Step(
                isActive: current >= 0,
                title: const Text("Profile Picture"),
                content: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundImage: (selectedImagePath != null)
                          ? FileImage(File(selectedImagePath!))
                          : null,
                      backgroundColor: Colors.grey.withOpacity(0.5),
                      child: (selectedImagePath != null)
                          ? const Text("")
                          : const Text(
                              "ADD",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                              ),
                            ),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        await showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                scrollable: true,
                                shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25)),
                                ),
                                title: const Text(
                                  "When You go to pick Image ?",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                actions: [
                                  ElevatedButton(
                                    onPressed: () async {
                                      Navigator.of(context).pop();
                                      XFile? pickerFile =
                                          await _picker.pickImage(
                                              source: ImageSource.gallery);

                                      if (pickerFile != null) {
                                        setState(() {
                                          selectedImagePath = pickerFile.path;
                                        });
                                      }
                                    },
                                    child: const Text("gallery"),
                                  ),
                                  ElevatedButton(
                                    onPressed: () async {
                                      Navigator.of(context).pop();
                                      XFile? pickerFile =
                                          await _picker.pickImage(
                                              source: ImageSource.camera);
                                      setState(() {
                                        selectedImagePath = pickerFile!.path;
                                      });
                                    },
                                    child: const Text("Camera"),
                                  ),
                                ],
                              );
                            });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xffb7c5c0),
                        shape: const CircleBorder(),
                      ),
                      child: const Icon(Icons.add),
                    ),
                  ],
                ),
              ),
              Step(
                isActive: current >= 1,
                title: const Text("Name"),
                content: TextField(
                  decoration:
                      formDecoration(Icons.person_outline, "Enter Your Name"),
                ),
              ),
              Step(
                isActive: current >= 2,
                title: const Text("Phone"),
                content: TextField(
                  keyboardType: TextInputType.phone,
                  decoration: formDecoration(Icons.call, "Enter Your Number"),
                ),
              ),
              Step(
                isActive: current >= 3,
                title: const Text("Email"),
                content: TextField(
                  keyboardType: TextInputType.emailAddress,
                  decoration:
                      formDecoration(Icons.email_outlined, "Enter Your Email"),
                ),
              ),
              Step(
                isActive: current >= 4,
                title: const Text("DOB"),
                content: TextField(
                  keyboardType: TextInputType.number,
                  decoration:
                      formDecoration(Icons.date_range, "Enter Your Birth Date"),
                ),
              ),
              Step(
                isActive: current >= 5,
                title: const Text("Gender"),
                content: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Radio(
                          activeColor: Colors.green,
                          value: "Male",
                          groupValue: redioval,
                          onChanged: (value) {
                            setState(() {
                              redioval = value.toString();
                            });
                          },
                        ),
                        const Text("Male"),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Radio(
                          activeColor: Colors.green,
                          value: "Female",
                          groupValue: redioval,
                          onChanged: (value) {
                            setState(() {
                              redioval = value.toString();
                            });
                          },
                        ),
                        const Text("Female"),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Radio(
                          activeColor: Colors.green,
                          value: "Others",
                          groupValue: redioval,
                          onChanged: (value) {
                            setState(() {
                              redioval = value.toString();
                            });
                          },
                        ),
                        const Text("Others"),
                      ],
                    ),
                  ],
                ),
              ),
              Step(
                isActive: current >= 6,
                title: const Text("Current Location"),
                content: TextField(
                  decoration: formDecoration(Icons.home, "Enter Your Address"),
                ),
              ),
              Step(
                isActive: current >= 7,
                title: const Text("Nationality"),
                content: TextField(
                  decoration:
                      formDecoration(Icons.flag, "Enter Your Nationality"),
                ),
              ),
              Step(
                isActive: current >= 8,
                title: const Text("Religion"),
                content: TextField(
                  decoration: formDecoration(
                      Icons.adjust_rounded, "Enter Your Religion"),
                ),
              ),
              Step(
                isActive: current >= 9,
                title: const Text("Languages"),
                content: TextField(
                  decoration:
                      formDecoration(Icons.language_rounded, "Enter Languages"),
                ),
              ),
              Step(
                isActive: current >= 10,
                title: const Text("Biography"),
                content: TextField(
                  decoration: formDecoration(Icons.details, "Enter Biography"),
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: const Color(0xffD7DDDB),
    );
  }
}
