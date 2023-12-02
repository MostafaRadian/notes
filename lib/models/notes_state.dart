part of 'notes_cubit.dart';

class NoteState {
  List<Map<String, dynamic>>? notes;
  bool isDBEmpty;
  List<bool> isFavourite;
  NoteState({
    required this.notes,
    required this.isDBEmpty,
    required this.isFavourite,
  });
}
