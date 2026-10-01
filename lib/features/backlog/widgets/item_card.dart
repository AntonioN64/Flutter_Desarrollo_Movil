import 'package:flutter/material.dart';
import 'package:backlog_tracker/features/backlog/models/item.dart';
import 'package:backlog_tracker/features/backlog/screens/details_screen.dart';

class ItemCard extends StatelessWidget {
  final Item item;

  const ItemCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        leading: Icon(
          item.completado ? Icons.check_circle : Icons.radio_button_unchecked,
          color: Colors.blueAccent,
        ),
        title: Text(item.titulo),
        subtitle: Text(item.categoria),
        trailing: Icon(Icons.chevron_right),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DetailScreen(item: item)),
          );
        },
      ),
    );
  }
}