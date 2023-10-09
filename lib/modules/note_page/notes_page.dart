import 'package:flutter/material.dart';
import 'package:notes_app/modules/new_note/new_note.dart';
import 'package:notes_app/modules/note_details/note_details.dart';

import '../../models/database_helper.dart';

class Notes extends StatefulWidget {
  const Notes({super.key});

  @override
  State<Notes> createState() => NotesState();
}

class NotesState extends State<Notes> {
  List<Map<String, dynamic>>? notes = [];
  List<bool> isFavourite = [];
  List<String> result = [];
  bool isDBEmpty = true;

  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    print("initState");
  }

  @override
  Scaffold build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        leading: const Icon(
          Icons.book_outlined,
          color: Colors.black,
          size: 30,
        ),
        title: const Text(
          "All Notes",
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
              onPressed: () async {
                notes = await DBHelper.getDataFromDB();
                if (notes != null || notes!.isNotEmpty) {
                  isDBEmpty = false;
                } else {
                  isDBEmpty = true;
                }
                setState(() {});
              },
              icon: const Icon(
                Icons.refresh,
                color: Colors.black,
              ))
        ],
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
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: notes!.length,
                itemBuilder: (context, index) {
                  isFavourite.add(false);
                  return noteItem(index, notes![index]);
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
          onPressed: () async {
            result = await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
                return NewNote();
              }),
            );
            await DBHelper.insertToDB(result[0], result[1]);
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

  Widget noteItem(int index, Map result) {
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
                child: Text(
                  "${result['Title']}",
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    isFavourite[index] = !isFavourite[index];
                  });
                },
                icon: Icon(
                  isFavourite[index] ? Icons.favorite : Icons.favorite_border,
                  color: Colors.redAccent,
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
