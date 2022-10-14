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
    log(usernameController.text);
    return usernameController.text;
  }

  Future<String> readFromStorageSec() async {
    String last = (await _storage.read(key: lastKey)) ?? '';
    log(usernameController.text);
    return last;
  }

  Future<void> readAllFromStorage() async {
    String all = _storage.readAll().toString();
    log(all);
  }

  overWriteLast() async {
    String data = usernameController.text;
    await _storage.write(key: firstKey, value: data);
    lastKey = data;
    await _storage.write(key: lastKey, value: lastKey);
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
    readAllFromStorage();
    _storage.deleteAll();
  }
}