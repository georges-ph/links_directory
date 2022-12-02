import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Body extends StatelessWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
    late CollectionReference _linksCollection = _firebaseFirestore
        .collection("LinksDirectory")
        .doc("AppCollections")
        .collection("Links");

    return FutureBuilder<QuerySnapshot>(
      future: _linksCollection.get(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text("Error loading data. Please try again later"),
          );
        }

        if (snapshot.connectionState == ConnectionState.done) {
          List<DocumentSnapshot> documents = snapshot.data!.docs;

          return Padding(
            padding: const EdgeInsets.all(16),
            child: ListView(
              children: documents.map((document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                return Card(
                  margin: const EdgeInsets.symmetric(
                    vertical: 6,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ListTile(
                    onTap: () async {
                      await launch(data["url"]);
                      _linksCollection.doc(data["id"].toString()).update({
                        "clicks": FieldValue.increment(1),
                      });
                    },
                    title: Text(data["name"]),
                    subtitle: Text(data["description"]),
                  ),
                );
              }).toList(),
            ),
          );
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
