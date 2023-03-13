import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  File? _image;

  Future getImage( ImageSource source ) async {
    final image = await ImagePicker().pickImage(source:source);
    if (image == null) return;
    final imageTemproray = File(image.path);

    setState(() {
      _image = imageTemproray;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Pick an Image')),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            _image != null
                ? Image.file(
                    _image!,
                    width: 300,
                    height: 400,
                    fit: BoxFit.cover,
                  )
                : Image.network('https://picsum.photos/id/237/300/400'),
            const SizedBox(
              height: 20,
            ),
            CustomButton(
                title: 'Pick Image from Gallery',
                icon: Icons.image_search_outlined,
                onClick: () =>  getImage(ImageSource.gallery)),
            CustomButton(
                title: 'Pick Image from Camera',
                icon: Icons.camera_alt,
                onClick: () => getImage(ImageSource.camera)),
          ],
        ),
      ),
    );
  }

  Widget CustomButton({
    required String title,
    required IconData icon,
    required VoidCallback onClick,
  }) {
    return Container(
      width: 250,
      child: ElevatedButton(
        onPressed: onClick,
        child: Row(
          children: [
            Icon(icon),
            SizedBox(
              width: 20,
            ),
            Text(title)
          ],
        ),
      ),
    );
  }
}
