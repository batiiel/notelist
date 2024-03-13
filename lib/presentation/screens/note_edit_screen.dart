import 'package:flutter/material.dart';
import 'package:notelist/domain/models/note.dart';
import 'package:notelist/presentation/provider/note_provider.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class NoteEditScreen extends StatelessWidget {
  Note? note;
  late String title;
  String text = "";

  NoteEditScreen({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    NoteProviderChange state = Provider.of<NoteProviderChange>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Edit Note'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Column(
                children: [
                  TextFormField(
                    initialValue: note!.title,
                    maxLines: null, // Allow unlimited lines
                    keyboardType: TextInputType.multiline,
                    decoration: const InputDecoration(
                      hintText: 'Заголовок...',
                    ),
                    onChanged: (value) {
                      note!.title = value;
                    },
                  ),
                  const SizedBox(height: 20.0),
                  TextFormField(
                    initialValue: note!.text,
                    minLines: 5,
                    maxLines: 15, // Allow unlimited lines
                    keyboardType: TextInputType.multiline,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Текст...',
                    ),
                    onChanged: (value) {
                      note!.text = value;
                    },
                  ),
                ],
              ),
            ),
            //const SizedBox(height: 16.0),

                ElevatedButton(
                  onPressed: () {
                    state.update(note!);
                    Navigator.pop(context);
                  },
                  child: const Text('Записать'),
                ),
          ],
        ),
      ),
    );
  }

  void saveText() {}
}
