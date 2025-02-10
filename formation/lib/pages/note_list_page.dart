import 'package:flutter/material.dart';
import 'package:formation/data/note.dart';
import 'package:formation/data/note_provider.dart';
import 'package:provider/provider.dart';

import 'note_edit_page.dart';

class NoteListPage extends StatefulWidget {
  const NoteListPage({super.key});

  @override
  State<NoteListPage> createState() => _NoteListPageState();
}

class _NoteListPageState extends State<NoteListPage> {
  @override
  Widget build(BuildContext context) {
    NoteDatabaseProvider provider = Provider.of<NoteDatabaseProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Notes')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _newNote(provider),
        tooltip: 'Nouvelle note',
        child: const Icon(Icons.add),
      ),
      body: Stack(
        children: [
          // Logo en arrière-plan
          Center(
            child: Opacity(
              opacity: 0.5,
              child: Image.asset(
                'assets/images/Logo.png',
                width: 200,
              ),
            ),
          ),
          // Liste des notes
          provider.notes == null
              ? const Center(child: CircularProgressIndicator())
              : provider.notes!.isEmpty
                  ? const Center(child: Text('Aucune note pour le moment'))
                  : ListView.builder(
                      padding: const EdgeInsets.all(20),
                      itemCount: provider.notes!.length,
                      itemBuilder: (ctx, index) {
                        Note note = provider.notes![index];
                        return _buildNote(context, note);
                      }),
        ],
      ),
    );
  }

  Future<void> _newNote(NoteDatabaseProvider provider) async {
    DateTime now = DateTime.now();
    Note newNote = Note(creationDate: now, title: 'Nouvelle note');
    await provider.addNote(newNote);

    if (!mounted) return; // Vérification nécessaire après le await

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => NoteEditPage(note: newNote),
      ),
    );
  }

  Widget _buildNote(BuildContext context, Note note) {
    final ThemeData theme = Theme.of(context);
    const nhitecRed = Color(0xFFC11B17);

    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => NoteEditPage(note: note)));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: nhitecRed.withAlpha(85),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(note.title, style: theme.textTheme.displayLarge),
                const Spacer(),
                Text(note.creationDate.toString().substring(0, 16),
                    style: theme.textTheme.displaySmall),
              ],
            ),
            if (note.content != null) const SizedBox(height: 5),
            if (note.content != null)
              Text(
                note.content!,
                style: theme.textTheme.displayMedium,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
          ],
        ),
      ),
    );
  }
}
