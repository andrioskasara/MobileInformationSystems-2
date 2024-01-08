import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      title: 'MIS-lab2',
      home: MyApp(),
    ),
  );
}

class Clothes {
  String type;
  String color;

  Clothes({required this.type, required this.color});
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Clothes> clothes = [];
  String selectedTypeAdd = 'Dress';
  String selectedColorAdd = 'Purple';
  String selectedTypeEdit = '';
  String selectedColorEdit = '';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clothes App',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Clothes App'),
        ),
        body: Column(
          children: [
            ElevatedButton(
              onPressed: () => _showAddNewItemDialog(),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.greenAccent,
              ),
              child: const Text('Add new item',
                  style: TextStyle(color: Colors.redAccent, fontSize: 18)),
            ),
            const SizedBox(height: 36),
            const Text('Your Clothes:',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.lightBlue)),
            Expanded(
              child: ListView.builder(
                itemCount: clothes.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                        '${clothes[index].color} ${clothes[index].type}',
                        style:
                        const TextStyle(color: Colors.lightBlue, fontSize: 18)),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () => _showEditClothesDialog(index),
                          color: Colors.greenAccent.shade700,
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => _deleteClothes(index),
                          color: Colors.greenAccent.shade400,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddNewItemDialog() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add new item'),
          content: Column(
            children: [
              _buildTypeDropdown(selectedTypeAdd),
              _buildColorDropdown(selectedColorAdd),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel',
                  style: TextStyle(
                      backgroundColor: Colors.greenAccent, color: Colors.redAccent, fontWeight: FontWeight.bold, fontSize: 16)),
            ),
            TextButton(
              onPressed: () {
                _addClothes();
                Navigator.pop(context);
              },
              child: const Text('Add',
                  style: TextStyle(
                      backgroundColor: Colors.greenAccent, color: Colors.redAccent, fontWeight: FontWeight.bold, fontSize: 16)),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTypeDropdown(String selectedValue) {
    return DropdownButtonFormField<String>(
      value: selectedValue,
      onChanged: (value) {
        setState(() {
          if (selectedValue == selectedTypeAdd) {
            selectedTypeAdd = value!;
          } else if (selectedValue == selectedTypeEdit) {
            selectedTypeEdit = value!;
          }
        });
      },
      items: ['Dress', 'Jeans', 'Trousers', 'Shorts', 'Skirt', 'Jumpsuit', 'Shirt', 'Sweater', 'Blazer', 'Coat',  'Jacket']
          .map<DropdownMenuItem<String>>((String type) {
        return DropdownMenuItem<String>(
          value: type,
          child: Text(type),
        );
      }).toList(),
      decoration: const InputDecoration(
          labelText: 'Select Type', labelStyle: TextStyle(color: Colors.blueAccent, fontSize: 18)),
    );
  }

  Widget _buildColorDropdown(String selectedValue) {
    return DropdownButtonFormField<String>(
      value: selectedValue,
      onChanged: (value) {
        setState(() {
          if (selectedValue == selectedColorAdd) {
            selectedColorAdd = value!;
          } else if (selectedValue == selectedColorEdit) {
            selectedColorEdit = value!;
          }
        });
      },
      items: ['Pink', 'Purple', 'Blue', 'Green', 'Red', 'Orange', 'Yellow', 'Brown', 'Grey', 'Black', 'White']
          .map<DropdownMenuItem<String>>((String color) {
        return DropdownMenuItem<String>(
          value: color,
          child: Text(color),
        );
      }).toList(),
      decoration: const InputDecoration(
          labelText: 'Select Color', labelStyle: TextStyle(color: Colors.blueAccent, fontSize: 18)),
    );
  }

  void _addClothes() {
    if (selectedTypeAdd.isNotEmpty && selectedColorAdd.isNotEmpty) {
      setState(() {
        clothes.add(Clothes(type: selectedTypeAdd, color: selectedColorAdd));
      });
    }
  }

  void _showEditClothesDialog(int index) {
    selectedTypeEdit = clothes[index].type;
    selectedColorEdit = clothes[index].color;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Clothes'),
          content: Column(
            children: [
              _buildTypeDropdown(selectedTypeEdit),
              _buildColorDropdown(selectedColorEdit),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel',
                  style: TextStyle(
                      backgroundColor: Colors.greenAccent, color: Colors.redAccent)),
            ),
            TextButton(
              onPressed: () {
                _editClothes(index);
                Navigator.pop(context);
              },
              child: const Text('Save',
                  style: TextStyle(
                      backgroundColor: Colors.greenAccent, color: Colors.redAccent)),
            ),
          ],
        );
      },
    );
  }

  void _editClothes(int index) {
    if (selectedTypeEdit.isNotEmpty && selectedColorEdit.isNotEmpty) {
      setState(() {
        clothes[index].type = selectedTypeEdit;
        clothes[index].color = selectedColorEdit;
      });
    }
  }

  void _deleteClothes(int index) {
    setState(() {
      clothes.removeAt(index);
    });
  }
}
