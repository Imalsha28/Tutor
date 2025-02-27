import 'package:flutter/material.dart';

void main() {
  runApp(TutorFinderApp());
}

class TutorFinderApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tutor Finder',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomePage(title: 'Tutor Finder'),
    );
  }
}

class HomePage extends StatelessWidget {
  final String title;

  const HomePage({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TutorsPage()),
                );
              },
              child: Text('Find Tutors'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UserProfilePage()),
                );
              },
              child: Text('Your Profile'),
            ),
          ],
        ),
      ),
    );
  }
}

class TutorsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tutors'),
      ),
      body: ListView.builder(
        itemCount: tutors.length,
        itemBuilder: (context, index) {
          final tutor = tutors[index];
          return Card(
            child: ListTile(
              title: Text(tutor['name'] ?? ''),
              subtitle: Text(tutor['subject'] ?? ''),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TutorDetailsPage(tutor: tutor),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class UserProfilePage extends StatefulWidget {
  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  bool isTutor = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Profile'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('User Profile Page'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RegisterAsTutorPage(
                      onRegister: (tutor) {
                        setState(() {
                          isTutor = true;
                          tutors.add(tutor);
                        });
                      },
                    ),
                  ),
                );
              },
              child: Text('Register as a Tutor'),
            ),
          ],
        ),
      ),
    );
  }
}

class RegisterAsTutorPage extends StatelessWidget {
  final Function(Map<String, String>) onRegister;

  RegisterAsTutorPage({required this.onRegister});

  final _nameController = TextEditingController();
  final _subjectController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register as Tutor'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _subjectController,
              decoration: InputDecoration(labelText: 'Subject'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final tutor = {
                  'name': _nameController.text,
                  'subject': _subjectController.text,
                };
                onRegister(tutor);
                Navigator.pop(context);
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}

class TutorDetailsPage extends StatelessWidget {
  final Map<String, String> tutor;

  TutorDetailsPage({required this.tutor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tutor['name'] ?? 'Tutor Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: ${tutor['name']}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Subject: ${tutor['subject']}',
                style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}

// A shared list to hold the registered tutors
List<Map<String, String>> tutors = [];
