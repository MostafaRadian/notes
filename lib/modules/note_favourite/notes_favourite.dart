import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/notes_cubit.dart';
import '../note_details/note_details.dart';

class NotesFavourite extends StatefulWidget {
  const NotesFavourite({super.key});

  @override
  State<NotesFavourite> createState() => _NotesFavouriteState();
}

class _NotesFavouriteState extends State<NotesFavourite> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        leading: const Icon(
          Icons.book_sharp,
          color: Colors.black,
          size: 30,
        ),
        title: const Text(
          "Favourite Notes",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                width: 280,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(color: Colors.grey),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.search, size: 22, color: Colors.grey),
                    SizedBox(width: 20),
                    Text("Search", style: TextStyle(color: Colors.grey)),
                  ],
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              BlocBuilder<NotesCubit, NoteState>(
                builder: (context, state) {
                  if (state.isDBEmpty) {
                    return const Text(
                      "Add new notes to start!",
                      style: TextStyle(color: Colors.grey),
                    );
                  } else {
                    List<Map<String, dynamic>> favouriteNotes = [];
                    List<int> favouriteIndices = [];
                    for (int index = 0; index < state.notes!.length; index++) {
                      if (state.isFavourite[index]) {
                        favouriteNotes.add(state.notes![index]);
                        favouriteIndices.add(index);
                      }
                    }
                    if (favouriteIndices.isNotEmpty) {
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: favouriteNotes.length,
                        itemBuilder: (context, index) {
                          return noteItem(
                              favouriteNotes[index], favouriteIndices[index]);
                        },
                      );
                    } else {
                      return const Text(
                        "Add your favourite notes here!",
                        style: TextStyle(color: Colors.grey),
                      );
                    }
                  }
                },
              )
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(50.0),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, '/');
          },
          backgroundColor: Colors.grey[200],
          child: const Icon(
            Icons.home,
            color: Colors.grey,
            size: 30,
          ),
        ),
      ),
    );
  }

  Widget noteItem(Map result, int favouriteIndex) {
    return Column(
      children: [
        Container(
          width: 300,
          height: 70,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.grey),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NoteDetail(
                          title: result['Title'], note: result['Note']),
                    ),
                  );
                },
                child: SizedBox(
                  width: 200,
                  child: Text(
                    "${result['Title']}",
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  BlocProvider.of<NotesCubit>(context)
                      .changeFavourite(favouriteIndex);
                },
                icon: BlocBuilder<NotesCubit, NoteState>(
                  builder: (context, state) {
                    if (state.isFavourite[favouriteIndex]) {
                      return const Icon(Icons.favorite,
                          color: Colors.redAccent);
                    } else {
                      return const Icon(
                        Icons.favorite_border,
                      );
                    }
                  },
                ),
              )
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        )
      ],
    );
  }
}
