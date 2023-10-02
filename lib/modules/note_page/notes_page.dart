import 'package:flutter/material.dart';
import 'package:notes_app/modules/new_note/new_note.dart';
import 'package:notes_app/modules/note_details/note_details.dart';
import 'package:sqflite/sqflite.dart';

class Notes extends StatefulWidget {
  const Notes({super.key});

  @override
  State<Notes> createState() => NotesState();
}

class NotesState extends State<Notes> {
  List<Map<String, dynamic>> notes = [];
  List<bool> isFavourite = [];
  late Database dataObject;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    createDB().then((value) => getDataFromDB());
  }

  @override
  Widget build(BuildContext context) {
    getDataFromDB();
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
              onPressed: () {
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
              if (notes.isNotEmpty)
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: notes.length,
                  itemBuilder: (context, index) {
                    isFavourite.add(false);
                    return noteItem(index);
                  },
                )
              else
                const Text(
                  'No notes yet? Add more today!',
                  style: TextStyle(color: Colors.grey),
                ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(50.0),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
                return NewNote(dataObject: dataObject);
              }),
            );
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

  Widget noteItem(int index) {
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
                          title: notes[index]['title'],
                          note: notes[index]['note']),
                    ),
                  );
                },
                child: Text(
                  "${notes[index]['title']}",
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

  Future<void> createDB() async {
    print('Creating database...');
    try {
      openDatabase(
        "notes.db",
        version: 1,
        onCreate: (db, version) async {
          await db.execute(
            'CREATE TABLE notes (id INTEGER PRIMARY KEY AUTOINCREMENT, Title TEXT, Note TEXT)',
          );
        },
      ).then((value) => dataObject = value);
    } catch (error) {
      print("error in creation is $error");
    }
    print('Database created.');
  }

  Future<void> getDataFromDB() async {
    try {
      notes = await dataObject.query('notes');
    } catch (error) {
      print("error in select is $error");
    }
  }
}
