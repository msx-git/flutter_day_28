import 'package:flutter/material.dart';
import 'package:flutter_day_28/constants/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

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
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(AppConstants.backgroundImage),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
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
                      child: Text(
                        'Get',
                        style: TextStyle(
                          fontSize: AppConstants.textSize,
                          color: AppConstants.textColor,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: FilledButton(
                      onPressed: () {
                        saveName();
                        saveAge();
                      },
                      child: Text(
                        'Save',
                        style: TextStyle(
                          fontSize: AppConstants.textSize,
                          color: AppConstants.textColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Text(
                "Name: ${name ?? ''}",
                style: TextStyle(
                    fontSize: AppConstants.textSize,
                    color: AppConstants.textColor),
              ),
              Text(
                "Age: ${age ?? ''}",
                style: TextStyle(
                  fontSize: AppConstants.textSize,
                  color: AppConstants.textColor,
                ),
              ),

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
                    child: Text(
                      "Save Colors",
                      style: TextStyle(
                        fontSize: AppConstants.textSize,
                        color: AppConstants.textColor,
                      ),
                    ),
                  ),
                  OutlinedButton(
                    onPressed: () {
                      getColors();
                    },
                    child: Text(
                      "Get Colors",
                      style: TextStyle(
                        fontSize: AppConstants.textSize,
                        color: AppConstants.textColor,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Colors",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: AppConstants.textSize,
                    color: AppConstants.textColor,
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: colors!.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: const Icon(
                        Icons.circle,
                        color: Colors.redAccent,
                        size: 12,
                      ),
                      title: Text(
                        colors![index],
                        style: TextStyle(
                          fontSize: AppConstants.textSize,
                          color: AppConstants.textColor,
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
