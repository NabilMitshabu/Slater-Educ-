import 'package:flutter/material.dart';
import 'chat_screen.dart';

// Ton modèle de message
class MessageModel {
  final String name;
  final String message;
  final String time;
  final bool isUnread;
  final String avatarUrl;

  MessageModel({
    required this.name,
    required this.message,
    required this.time,
    required this.isUnread,
    required this.avatarUrl,
  });
}

class ChatTab extends StatelessWidget {
  final List<MessageModel> messages = [
    MessageModel(
      name: "Mr Doeol Mwanakahambo",
      message:
      "Bonjour Mme Du Corbeau. Je tiens à vous informer que Neville a eu plusieurs difficultés de discipline en classe",
      time: "5 min",
      isUnread: true,
      avatarUrl: "https://randomuser.me/api/portraits/men/31.jpg",
    ),
    MessageModel(
      name: "Madame Sofia",
      message:
      "Bonjour Mme Du Corbeau. Je tiens à vous informer que Neville a eu plusieurs difficultés de discipline en classe cette semaine. Une rencontre est souhaitable afin d’en discuter.",
      time: "10 min",
      isUnread: false,
      avatarUrl: "https://randomuser.me/api/portraits/women/44.jpg",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.arrow_back, color: Colors.black),
        title: const Text(
          "Messages",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: const [
          Icon(Icons.search, color: Colors.black),
          SizedBox(width: 12),
        ],
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView.separated(
        itemCount: messages.length,
        separatorBuilder: (context, index) =>
        const Divider(indent: 70, endIndent: 15),
        itemBuilder: (context, index) {
          final msg = messages[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(msg.avatarUrl),
              radius: 25,
            ),
            title: Text(
              msg.name,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              msg.message,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  msg.time,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
                const SizedBox(height: 6),
                msg.isUnread
                    ? Container(
                  width: 12,
                  height: 12,
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),
                )
                    : const SizedBox.shrink(),
              ],
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatScreen(
                    name: msg.name,
                    avatarUrl: msg.avatarUrl,
                  ),
                ),
              );
            },
          );
        },
      ),

      // bouton flottant
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        shape: const CircleBorder(),
        child: const Icon(Icons.add, size: 28, color: Colors.white),
        onPressed: () {
          // Action quand on appuie sur +
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Nouveau chat")),
          );
        },
      ),
    );
  }
}
