import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/modules/note_details/note_details.dart';

import '../../models/notes_cubit.dart';

class Notes extends StatelessWidget {
  const Notes({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, '/fav_note');
          },
          icon: const Icon(
            Icons.book_outlined,
            color: Colors.black,
            size: 30,
          ),
        ),
        title: const Text(
          "All Notes",
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
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.notes?.length ?? 0,
                      itemBuilder: (context, index) {
                        return noteItem(context, index, state.notes![index]);
                      },
                    );
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
            Navigator.pushNamed(context, '/new_note');
          },
          backgroundColor: Colors.grey[200],
          child: const Icon(
            Icons.add,
            color: Colors.grey,
            size: 30,
          ),
        ),
      ),
    );
  }

  Widget noteItem(BuildContext context, int index, Map result) {
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
                        title: result['Title'],
                        note: result['Note'],
                      ),
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
                  BlocProvider.of<NotesCubit>(context).changeFavourite(index);
                },
                icon: BlocBuilder<NotesCubit, NoteState>(
                  builder: (context, state) {
                    if (state.isFavourite[index]) {
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
