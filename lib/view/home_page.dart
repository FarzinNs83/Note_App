import 'package:flutter/material.dart';
import 'package:note_app_pc/component/my_color.dart';
import 'package:note_app_pc/component/my_textfield.dart';
import 'package:note_app_pc/services/file_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FileService fileService = FileService();
  @override
  void initState() {
    super.initState();
    addListeners();
  }

  @override
  void dispose() {
    removeListeners();
    super.dispose();
  }

  void addListeners() {
    List<TextEditingController> controllers = [
      fileService.titleController,
      fileService.descriptionController,
      fileService.tagsController,
    ];
    for (TextEditingController controller in controllers) {
      controller.addListener(
        _onFieldChanged,
      );
    }
  }

  void removeListeners() {
    List<TextEditingController> controllers = [
      fileService.titleController,
      fileService.descriptionController,
      fileService.tagsController,
    ];
    for (TextEditingController controller in controllers) {
      controller.removeListener(
        _onFieldChanged,
      );
    }
  }

  void _onFieldChanged() {
    setState(() {
      fileService.fieldNotEmpty = fileService.titleController.text.isNotEmpty &&
          fileService.descriptionController.text.isNotEmpty &&
          fileService.tagsController.text.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SolidColors.surface,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _newFileButton(() => fileService.newFile(context), "New File"),
                Row(
                  children: [
                    _exportImportButton(()=>fileService.loadFile(context), Icons.file_upload_outlined),
                    _exportImportButton(() => fileService.newDirectory(context), Icons.folder),
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 24,
            ),
            MyTextfield(
              maxLength: 100,
              maxLines: 3,
              hintText: "Enter Title",
              controller: fileService.titleController,
            ),
            const SizedBox(
              height: 24,
            ),
            MyTextfield(
              maxLength: 5000,
              maxLines: 5,
              hintText: "Enter Description",
              controller: fileService.descriptionController,
            ),
            const SizedBox(
              height: 24,
            ),
            MyTextfield(
              maxLength: 500,
              maxLines: 4,
              hintText: "Enter Tags",
              controller: fileService.tagsController,
            ),
            const SizedBox(
              height: 24,
            ),
            Row(
              children: [
                _newFileButton(
                    fileService.fieldNotEmpty
                        ? () => fileService.saveContent(context)
                        : null,
                    "Save File")
              ],
            )
          ],
        ),
      ),
    );
  }

  ElevatedButton _newFileButton(Function()? onPressed, String text) {
    return ElevatedButton(
      onPressed: onPressed,
      style: _buttonStyle(),
      child: Text(text),
    );
  }

  IconButton _exportImportButton(Function()? onPressed, IconData icon) {
    return IconButton(
        onPressed: onPressed,
        color: SolidColors.iconColor,
        icon: Icon(
          icon,
        ));
  }

  ButtonStyle _buttonStyle() {
    return ElevatedButton.styleFrom(
      backgroundColor: SolidColors.accent,
      foregroundColor: SolidColors.surface,
      disabledBackgroundColor: SolidColors.disabledBackgroundColor,
      disabledForegroundColor: SolidColors.disabledForegroundColor,
    );
  }
}
