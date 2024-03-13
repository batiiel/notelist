import 'package:flutter/material.dart';
import 'package:notelist/domain/models/note.dart';
import 'package:notelist/presentation/provider/note_provider.dart';
import 'package:notelist/presentation/screens/note_add_screen.dart';
import 'package:notelist/presentation/screens/note_edit_screen.dart';
import 'package:provider/provider.dart';

class NoteListScreen extends StatelessWidget {
  const NoteListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => NoteProviderChange(),
      builder: (context, child) {
        return FutureProvider<List<Note>>.value(
            value: Provider.of<NoteProviderChange>(context).list,
            initialData: const [],
            //builder: (context, child){
            child: MaterialApp(
              title: 'NoteList',
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                useMaterial3: true,
              ),
              home: const NoteListScreenPage(),
            )
            //},
            );
      },
    );
  }
}

class NoteListScreenPage extends StatefulWidget {
  const NoteListScreenPage({super.key});

  @override
  State<NoteListScreenPage> createState() => _NoteListScreenPageState();
}

class _NoteListScreenPageState extends State<NoteListScreenPage> {
  //Future<List<Note>>? list;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("NoteList"),
        centerTitle: true,
      ),
      body: Consumer<List<Note>>(
        builder: (context, List<Note> list, child) {
          return Container(
            child: list.isEmpty
                ? const Center(child: Text("Нету записей"))
                : ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          title: Text(
                              "${list[index].id}\t\t\t${list[index].title!}"),
                          shape: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                          ),
                          trailing: Consumer<NoteProviderChange>(
                            builder: (context, value, child) {
                              return IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () async {
                                  WidgetsBinding.instance.addPostFrameCallback(
                                    (_) async {
                                      await value.delete(list[index].id!);
                                    },
                                  );
                                },
                              );
                            },
                          ),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) {
                                  return NoteEditScreen(note: list[index]);
                                },
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => NoteAddScreen(),
            ),
          );
        },
      ),
    );
  }
}
