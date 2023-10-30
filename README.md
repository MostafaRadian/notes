# Notes app

Certainly! Here's a more detailed and organized description of the provided project code:

1. NewNote Class:
   - This class represents the screen for creating a new note.
   - It extends the StatelessWidget class from Flutter.
   - It includes two TextEditingController objects for capturing the user input for the note's title and description.
   - The title and description strings are also defined within the class.
   - The build() method returns a Scaffold widget with an AppBar and a body containing input fields for the title and description.
   - The FloatingActionButton at the bottom allows users to save the note. It performs validation to ensure that both the title and description are filled in before saving.
   - If the validation fails, an AlertDialog is displayed to prompt the user to fill in the missing fields.

2. NoteDetail Class:
   - This class represents the screen for displaying the details of a specific note.
   - It extends the StatelessWidget class from Flutter.
   - It receives the title and notes content as parameters through its constructor.
   - The build() method returns a Scaffold widget with an AppBar and a body containing the note's title and content.
   - The note content is displayed within a container with a fixed height and scrollable functionality.

3. Notes Class:
   - This class serves as the main page of the notes app.
   - It extends the StatefulWidget class from Flutter, allowing the management of its internal state.
   - It defines several instance variables, including a list of maps for storing the notes, a list of booleans to track the favorite status of each note, a list of strings to store the result of new note creation, and a boolean flag to determine if the database is empty.
   - The build() method returns a Scaffold widget with an AppBar and a body containing a search bar and a ListView of note items.
   - The search bar is a container with an icon and text, providing a placeholder for future search functionality.
   - The ListView.builder widget is used to display the note items. It retrieves the notes from the database and renders each note using the noteItem() method.
   - The noteItem() method creates a container for each note with the note's title and a favorite button. Tapping on a note opens the NoteDetail screen.
   - The FloatingActionButton at the bottom allows users to create a new note. It navigates to the NewNote screen using Flutter's Navigator class. After a new note is created, it is inserted into the database using the DBHelper class.

4. Database Helper (DBHelper):
   - Although not explicitly shown in the provided code, the DBHelper class is assumed to be responsible for database operations, such as retrieving data from and inserting data into the database.
   - The Notes class interacts with the DBHelper class to fetch and save notes.

The overall structure of the code follows Flutter's widget-based architecture, where each screen or component is represented by a separate class. The code demonstrates the use of Flutter's built-in widgets, state management, navigation, and integration with a database for creating a functional notes app.

![Screen Shot 2023-10-30 at 4 44 49 AM](https://github.com/MostafaRadian/notes/assets/46004434/59fa8a3e-2d0f-4c90-9439-8e58aef77ede)
![Screen Shot 2023-10-30 at 4 45 11 AM](https://github.com/MostafaRadian/notes/assets/46004434/14da78c2-6127-466f-876c-4833d453f3f4) 
![Screen Shot 2023-10-30 at 4 45 55 AM](https://github.com/MostafaRadian/notes/assets/46004434/54dbf986-7dfa-4b23-b545-7bb6d7fe43bd)
![Screen Shot 2023-10-30 at 4 46 17 AM](https://github.com/MostafaRadian/notes/assets/46004434/fd062780-82a1-4230-aae1-3862ca20b3b5)
![Screen Shot 2023-10-30 at 4 46 31 AM](https://github.com/MostafaRadian/notes/assets/46004434/7df17c0a-05dd-467a-b4fd-49b45cae225c)



