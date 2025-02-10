import 'package:flutter/material.dart';
import 'package:formation/data/note.dart';
import 'package:formation/data/note_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class NoteEditPage extends StatefulWidget {
  final Note note;

  const NoteEditPage({super.key, required this.note});

  @override
  State<StatefulWidget> createState() => _NoteEditPageState();
}

class _NoteEditPageState extends State<NoteEditPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  @override
  void initState() {
    _titleController.text = widget.note.title;
    _contentController.text = widget.note.content ?? '';
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    NoteDatabaseProvider provider = Provider.of<NoteDatabaseProvider>(context);
    ThemeData theme = Theme.of(context);

    String date = DateFormat('dd/MM/yy').format(widget.note.creationDate);
    String time = DateFormat('hh:mm').format(widget.note.creationDate);

    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        widget.note.title = _titleController.text.trim();
        String content = _contentController.text.trim();
        widget.note.content = content.isNotEmpty ? content : null;

        provider.editNote(widget.note);
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Modifier la note'),
          actions: [
            IconButton(
              onPressed: () {
                provider.deleteNote(widget.note);
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.delete),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _titleController,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 20),
                decoration: const InputDecoration(border: InputBorder.none),
              ),
              Text(
                'Créée le $date à $time',
                style: TextStyle(color: theme.colorScheme.onSurfaceVariant),
              ),
              Expanded(
                child: TextField(
                  controller: _contentController,
                  maxLines: null,
                  expands: true,
                  decoration: const InputDecoration(border: InputBorder.none),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
