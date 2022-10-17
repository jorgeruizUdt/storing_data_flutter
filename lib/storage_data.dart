import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageData {
  String firstKey = "FIRST";
  String lastKey = "";

  final GlobalKey formKey = GlobalKey();
  final GlobalKey scaffoldKey = GlobalKey();

  final _storage = const FlutterSecureStorage();

  final TextEditingController usernameController = TextEditingController(text: "");

  Future<String> readFromStorage() async {
    usernameController.text = (await _storage.read(key: firstKey)) ?? '';
    return usernameController.text;
  }

  Future<String> readFromStorageSec() async {
    String last = (await _storage.read(key: lastKey)) ?? '';
    return last;
  }

  Future<Map<String, String>> readAllFromStorage() async {
    return _storage.readAll();
  }

  overWriteLast() async {
    String data = usernameController.text;
    
    if (((await _storage.read(key: firstKey)) ?? '') == '') {
      await _storage.write(key: firstKey, value: data);
    } else if (((await _storage.read(key: firstKey)) ?? '') == '' && ((await _storage.read(key: lastKey)) ?? '') == '') {
      await _storage.write(key: firstKey, value: data);
    } else if (((await _storage.read(key: firstKey)) ?? '') != '' && ((await _storage.read(key: lastKey)) ?? '') == '') {
      await _storage.write(key: firstKey, value: data);
    } else {
      await _storage.write(key: lastKey, value: data);
    }
  }

  saveNew() async {
    if (((await _storage.read(key: firstKey)) ?? '') == '') {
      overWriteLast();
      return;
    } else {
      lastKey = usernameController.text;
      await _storage.write(key: lastKey, value: lastKey);
    }
  }

  deleteLast() async {
    String a = await readFromStorage();
    String b = await readFromStorageSec();
    if (a == b) {
      _storage.delete(key: firstKey);
    }
    _storage.delete(key: lastKey);
  }

  deleteAll() {
    _storage.deleteAll();
  }
}