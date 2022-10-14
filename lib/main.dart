import 'dart:developer';

import 'package:crud_store_data_and_passw/storage_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const Color primaryColor = Color.fromARGB(255, 57, 140, 250);
  final StorageData storageData = StorageData();

  @override
  void initState() {
    super.initState();
    storageData.readFromStorage();
  }

  @override
  void dispose() {
    super.dispose();
    storageData.usernameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      key: storageData.scaffoldKey,
      body: SingleChildScrollView(
        child: Container(
          width: size.width,
          padding: EdgeInsets.all(size.width - size.width * .85),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: size.height * .10,
              ),
              const Text(
                "Storage data",
                style: TextStyle(
                    color: Color(0xFF161925),
                    fontWeight: FontWeight.w600,
                    fontSize: 32),
              ),
              SizedBox(
                height: size.height * .1,
              ),
              Form(
                key: storageData.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "Data to save",
                        labelStyle: const TextStyle(color: primaryColor),
                        focusedBorder: UnderlineInputBorder(borderRadius: BorderRadius.circular(0), borderSide: const BorderSide(color: primaryColor, width: 2),),
                      ),
                      controller: storageData.usernameController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Required field';
                        }
                        return null;
                      },
                      textInputAction: TextInputAction.next,
                      textCapitalization: TextCapitalization.none,
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: size.height * .07,
              ),
              Container(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: 
                  MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: size.width * .3,
                          child: ElevatedButton(
                            onPressed: storageData.overWriteLast,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primaryColor,
                              textStyle: const TextStyle(fontSize: 15)
                            ),
                            child: const Text("Overwrite"),
                          ),
                        ),
                        SizedBox(
                          width: size.width * .1,
                        ),
                        SizedBox(
                          width: size.width * .3,
                          child: ElevatedButton(
                            onPressed: storageData.saveNew,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primaryColor,
                              textStyle: const TextStyle(fontSize: 15)
                            ),
                            child: const Text("Save new"),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size.height * .1,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: size.height * .15,
              ),
              Row(mainAxisAlignment: 
                MainAxisAlignment.center,
                children: [
                  Center(
                    child: InkWell(
                      onTap: storageData.deleteLast,
                      child: const Text(
                        "Delete current",
                        style: TextStyle(
                          color: Colors.black54,
                          decoration: TextDecoration.underline, 
                          fontSize: 14.5
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  SizedBox(
                      width: size.width * .03,
                  ),
                  const Text(
                    "or",
                    style: TextStyle(color: Colors.black54, fontSize: 11),
                    textAlign: TextAlign.center
                  ),
                  SizedBox(
                      width: size.width * .03,
                  ),
                  Center(
                    child: InkWell(
                      onTap: storageData.deleteAll,
                      child: const Text(
                        "Delete all",
                        style: TextStyle(
                          color: Colors.black54,
                          decoration: TextDecoration.underline, 
                          fontSize: 14.5
                          ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}