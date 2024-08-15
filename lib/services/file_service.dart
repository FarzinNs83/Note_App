import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:note_app_pc/component/my_snackbar.dart';

class FileService {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController tagsController = TextEditingController();

  bool fieldNotEmpty = false;

  File? _selectedFile;
  String _selectedDirectory = '';

  void saveContent(context) async {
    final title = titleController.text;
    final description = descriptionController.text;
    final tags = tagsController.text;

    final textContent =
        "Title:\n\n$title\n\nDescription:\n\n$description\n\nTags:\n\n$tags";

    try {
      if (_selectedFile != null) {
        await _selectedFile!.writeAsString(textContent);
      } else {
        final todayDate = getTodayDate();
        String appDirPath = _selectedDirectory;
        if (appDirPath.isEmpty) {
          final directory = await FilePicker.platform.getDirectoryPath();
          _selectedDirectory = appDirPath = directory!;
        }
        final filePath = '$appDirPath/$todayDate - $title - AppData.txt';
        final newFile = File(filePath);
        await newFile.writeAsString(textContent);
      }
      MySnackbar.showSnackBar(
          context, Icons.check_box_outlined, 'File Saved Successfully');
    } catch (e) {
      MySnackbar.showSnackBar(context, Icons.error_outline, 'File Not Saved');
    }
  }

  void loadFile(context) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();
      if (result != null) {
        File file = File(result.files.single.path!);
        _selectedFile = file;
        final fileContext = await file.readAsString();
        final lines = fileContext.split('\n\n');
        titleController.text = lines[1];
        descriptionController.text = lines[3];
        tagsController.text = lines[5];
        MySnackbar.showSnackBar(context, Icons.upload_file, 'File Upload');
      } else {
        MySnackbar.showSnackBar(
            context, Icons.error_outline, 'No File Selected!');
      }
    } catch (e) {
      MySnackbar.showSnackBar(context, Icons.error_outline, 'No File Selected');
    }
  }

  void newFile(context) {
    _selectedFile = null;
    titleController.clear();
    descriptionController.clear();
    tagsController.clear();
    MySnackbar.showSnackBar(context, Icons.file_upload, "New File Created");
  }

  void newDirectory(context) async {
    try {
      String? directory = await FilePicker.platform.getDirectoryPath();
      _selectedDirectory = directory!;
      _selectedFile = null;
      MySnackbar.showSnackBar(context, Icons.folder, 'New Folder Selected');
    } catch(e) {
      MySnackbar.showSnackBar(context, Icons.error_outline, 'No Folder Selected');
    }
  }

  static String getTodayDate() {
    final now = DateTime.now();
    final formmater = DateFormat('yyyy-MM-dd');
    final formmatedDate = formmater.format(now);
    return formmatedDate;
  }
}
