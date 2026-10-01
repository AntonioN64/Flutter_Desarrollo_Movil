import 'package:flutter/material.dart';
import 'package:backlog_tracker/features/backlog/models/item.dart';
import 'package:backlog_tracker/features/backlog/widgets/item_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> _categorias = ["PC", "Consola", "Móvil"];

  final List<Item> _items = [
    Item(titulo: "Hollow Knight", categoria: "PC", completado: true),
    Item(titulo: "Mario Odyssey", categoria: "Consola"),
    Item(titulo: "Balatro", categoria: "Móvil"),
  ];

  void _agregarItem(String titulo, String categoria) {
    setState(() {
      _items.add(Item(titulo: titulo, categoria: categoria));
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("$titulo agregado correctamente")),
    );
  }

  void _eliminarItem(int index) {
    final String titulo = _items[index].titulo;
    setState(() {
      _items.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("$titulo eliminado correctamente")),
    );
  }

  void _mostrarFormulario() {
    final TextEditingController tituloController = TextEditingController();
    String categoriaSeleccionada = _categorias.first;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateDialogo) {
            return AlertDialog(
              title: Text("Nuevo elemento"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: tituloController,
                    decoration: InputDecoration(labelText: "Título"),
                  ),
                  SizedBox(height: 16),
                  DropdownButton<String>(
                    value: categoriaSeleccionada,
                    isExpanded: true,
                    items: _categorias.map((categoria) {
                      return DropdownMenuItem(
                        value: categoria,
                        child: Text(categoria),
                      );
                    }).toList(),
                    onChanged: (nuevoValor) {
                      setStateDialogo(() {
                        categoriaSeleccionada = nuevoValor!;
                      });
                    },
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("Cancelar"),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (tituloController.text.isEmpty) return;
                    _agregarItem(tituloController.text, categoriaSeleccionada);
                    Navigator.pop(context);
                  },
                  child: Text("Agregar"),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
        title: Text("Backlog Tracker"),
      ),
      body: ListView.builder(
        itemCount: _items.length,
        itemBuilder: (context, index) {
          final Item currentItem = _items[index];
          return Dismissible(
            key: ValueKey(currentItem),
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              padding: EdgeInsets.only(right: 20),
              child: Icon(Icons.delete, color: Colors.white),
            ),
            onDismissed: (direction) => _eliminarItem(index),
            child: ItemCard(item: currentItem),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
        onPressed: _mostrarFormulario,
        child: Icon(Icons.add),
      ),
    );
  }
}