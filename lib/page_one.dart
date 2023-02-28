import 'dart:io';

import 'package:camera_application/image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});
  ValueNotifier<List> db = ValueNotifier([]);

  File? imageFile;

  ImagePicker picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    get();
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 47, 66, 103),
      appBar: AppBar(
        centerTitle: true,
        title: const Text('GALLERY'),
        backgroundColor: const Color.fromARGB(255, 47, 66, 103),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          getimage();
        },
      ),
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: db,
          builder: (context, value, child) {
            return GridView.builder(
              itemCount: db.value.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 4.0,
                  mainAxisSpacing: 4.0),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ImageView(image: db.value[index]),
                    ));
                  },
                  child: Image(
                    image: FileImage(File(db.value[index])),
                    fit: BoxFit.cover,
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  void getimage() async {
    var image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image == null) {
      return;
    } else {
      Directory? directory = await getExternalStorageDirectory();
      File imagePath = File(image.path);
      await imagePath.copy('${directory!.path}/${DateTime.now()}.jpg');

      getItems(directory);
    }
  }

  void getItems(Directory directory) async {
    final listDir = await directory.list().toList();
    db.value.clear();
    for (var i = 0; i < listDir.length; i++) {
      db.value.add(listDir[i].path);
      db.notifyListeners();
    }
  }

  void get() async {
    dynamic directory = await getExternalStorageDirectory();
    getItems(directory);
  }
}
