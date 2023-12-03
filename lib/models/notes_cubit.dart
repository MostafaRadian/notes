import 'package:bloc/bloc.dart';
import 'package:notes_app/models/database_helper.dart';

part 'notes_state.dart';

class NotesCubit extends Cubit<NoteState> {
  NotesCubit()
      : super(NoteState(
          notes: [],
          isDBEmpty: true,
          isFavourite: [],
        ));

  Future<void> addNote(String titles, String notes) async {
    await DBHelper.insertToDB(titles, notes);
    state.notes = await DBHelper.getDataFromDB();
    state.isDBEmpty = false;
    state.isFavourite.add(false);
    emit(
      NoteState(
        notes: state.notes,
        isDBEmpty: state.isDBEmpty,
        isFavourite: state.isFavourite,
      ),
    );
  }

  Future<void> getNotes() async {
    state.notes = await DBHelper.getDataFromDB();
    //print(state.notes);
    // Check if state.notes is not null, not empty, and the "Note" property is both non-null and not an empty string
    if (state.notes != null &&
        state.notes!.isNotEmpty &&
        state.notes![0]["Note"] != null &&
        state.notes![0]["Note"] != "") {
      state.isDBEmpty = false;
      state.isFavourite =
          state.notes!.map((note) => note['Favourite'] == 'true').toList();
    } else {
      // The "Note" column is either null or empty

      state.isDBEmpty = true;
    }
    emit(
      NoteState(
        notes: state.notes,
        isDBEmpty: state.isDBEmpty,
        isFavourite: state.isFavourite,
      ),
    );
  }

  Future<void> changeFavourite(int index) async {
    final List<bool> updatedFavourites = List.from(state.isFavourite);
    updatedFavourites[index] = !updatedFavourites[index];
    int noteId = state.notes![index]['id'];
    await DBHelper.updateFavouriteStatus(noteId, updatedFavourites[index]);
    emit(
      NoteState(
        notes: state.notes,
        isDBEmpty: state.isDBEmpty,
        isFavourite: updatedFavourites,
      ),
    );
  }

  bool getFavourite(int index) {
    return state.isFavourite[index];
  }
}
