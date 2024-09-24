import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../domain/entities/movie_entity.dart';

class DetailsScreen extends StatelessWidget {
  final MovieEntity movie;

  const DetailsScreen({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(movie.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(movie.image),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Premiere: ${movie.premiered}',
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Status: ${movie.status}',
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Average Rating: ${movie.averageRating}',
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Genres: ${movie.genres.join(', ')}',
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    movie.summary.replaceAll(RegExp(r'<[^>]*>|&[^;]+;'), ''), // Remove HTML tags
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  if (movie.officialSite.isNotEmpty) 
                    ElevatedButton(
                      onPressed: () {
                        launchURL(movie.officialSite);
                      },
                      child: const Text("Official Site"),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void launchURL(String url) async {
    // Use url_launcher to launch the official site
    // Note: Ensure you have added url_launcher package to your pubspec.yaml
    // import 'package:url_launcher/url_launcher.dart';
    // ignore: deprecated_member_use
    if (await canLaunch(url)) {
      // ignore: deprecated_member_use
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
