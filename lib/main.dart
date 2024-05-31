import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    initSharedPreferences();
  }

  void initSharedPreferences() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  /// Text Controllers--------------------------------------------------------
  final nameController = TextEditingController();

  final ageController = TextEditingController();
  final colorsController = TextEditingController();

  /// Variables--------------------------------------------------------
  String? name;
  int? age;
  List<String>? colors = [];
  late SharedPreferences sharedPreferences;

  /// SharedPrefs Setters--------------------------------------------------------
  Future<void> saveName() async {
    await sharedPreferences.setString('name', nameController.text.trim());
  }

  Future<void> saveAge() async {
    await sharedPreferences.setInt('age', int.parse(ageController.text.trim()));
  }

  Future<void> saveColors() async {
    await sharedPreferences.setStringList(
        'colors', colorsController.text.split(','));
  }

  /// SharedPrefs Getters--------------------------------------------------------
  Future<void> getName() async {
    setState(() {
      name = sharedPreferences.getString('name');
    });
  }

  Future<void> getAge() async {
    setState(() {
      age = sharedPreferences.getInt('age');
    });
  }

  Future<void> getColors() async {
    setState(() {
      colors = sharedPreferences.getStringList('colors');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Shared Preferences"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /// Age and Name --------------------------------------------------------
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: ageController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Age',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: FilledButton(
                    onPressed: () async {
                      getName();
                      getAge();
                    },
                    child: const Text('Get'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: FilledButton(
                    onPressed: () {
                      saveName();
                      saveAge();
                    },
                    child: const Text('Save'),
                  ),
                ),
              ],
            ),
            Text("Name: ${name ?? ''}"),
            Text("Age: ${age ?? ''}"),

            /// Colors--------------------------------------------------------
            const SizedBox(height: 10),
            TextField(
              controller: colorsController,
              decoration: InputDecoration(
                labelText: 'Favorite colors',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                OutlinedButton(
                  onPressed: () {
                    saveColors();
                  },
                  child: const Text("Save Colors"),
                ),
                OutlinedButton(
                  onPressed: () {
                    getColors();
                  },
                  child: const Text("Get Colors"),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Colors",
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: colors!.length,
                itemBuilder: (context, index) {
                  print(colors!);
                  return ListTile(
                    leading: const Icon(
                      Icons.circle,
                      color: Colors.redAccent,
                      size: 12,
                    ),
                    title: Text(colors![index]),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
