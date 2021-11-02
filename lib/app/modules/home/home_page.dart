import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:image_picker/image_picker.dart';
import 'package:images_gallery_camera/app/modules/home/home_store.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key key, this.title = "Home"}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeStore> {
  File _image;
  File imagem;
  final ImagePicker picker = ImagePicker();

  Future takePhoto() async {
    // ignore: deprecated_member_use
    final PickedFile = await picker.getImage(source: ImageSource.camera);
    setState(() {
      _image = File(PickedFile.path);
    });
  }

  Future getImage() async {
    // ignore: deprecated_member_use
    final Image = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = File(Image.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Picker'),
        backgroundColor: Colors.lightBlue,
        centerTitle: true,
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(left: 25, right: 25),
          child: Column(
            children: [
              const SizedBox(
                height: 250,
              ),
              Container(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 15),
                child: Column(
                  children: [
                    Center(
                      child: _image == null
                          ? const Text(
                              "No defined image",
                              style: TextStyle(fontSize: 26),
                            )
                          : Image.file(File(_image.path)),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 70,
              ),
              Container(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 15),
                child: Column(
                  children: [
                    Center(
                      child: imagem == null
                          ? const Text(
                              "No file selected",
                              style: TextStyle(fontSize: 26),
                            )
                          : Image.file(File(imagem.path)),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                    alignment: Alignment.bottomRight,
                    child: FloatingActionButton(
                      onPressed: takePhoto,
                      backgroundColor: Colors.amberAccent,
                      child: const Icon(Icons.add_a_photo_outlined),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: FloatingActionButton(
                      onPressed: getImage,
                      backgroundColor: Colors.lightGreen,
                      child: const Icon(Icons.add_photo_alternate_rounded),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      )),
    );
  }
}
