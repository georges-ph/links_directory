import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:links_directory/models/link.dart';
import 'package:url_launcher/url_launcher.dart';

class Body extends StatelessWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CollectionReference _linksCollection = FirebaseFirestore.instance
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

        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          List<DocumentSnapshot> documents = snapshot.data!.docs;

          return Padding(
            padding: const EdgeInsets.all(16),
            child: ListView(
              children: documents.map((document) {
                Link link =
                    Link.fromMap(document.data()! as Map<String, dynamic>);

                return Card(
                  margin: const EdgeInsets.symmetric(
                    vertical: 6,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ListTile(
                    onTap: () async {
                      link = link.copyWith(clicks: link.id + 1);

                      _linksCollection
                          .doc(link.id.toString())
                          .update(link.toMap());

                      await launchUrl(Uri.parse(link.url));
                    },
                    title: Text(link.name),
                    subtitle: Text(link.description),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.ads_click),
                        Text(link.clicks.toString()),
                      ],
                    ),
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
