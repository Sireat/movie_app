import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/search_provider.dart';
import 'details_screen.dart'; // Make sure to import the details screen

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final searchProvider = Provider.of<SearchProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Movies'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: (value) {
                if (value.isNotEmpty) {
                  searchProvider.searchMovies(value);
                } else {
                  searchProvider.clearMovies(); // Clear the movies if the input is empty
                }
              },
              decoration: const InputDecoration(
                hintText: 'Search for a movie...',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          if (searchProvider.isLoading) // Show loading indicator
            const Center(child: CircularProgressIndicator()),
          if (searchProvider.errorMessage != null) // Show error message
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                searchProvider.errorMessage!,
                style: const TextStyle(color: Colors.red),
              ),
            ),
          if (searchProvider.movies.isEmpty && !searchProvider.isLoading)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                searchProvider.lastSearchTerm == null
                    ? 'Please enter a search term.'
                    : 'No movies found for "${searchProvider.lastSearchTerm}". Please try another search.',
                style: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
              ),
            ),
          Expanded(
            child: ListView.builder(
              itemCount: searchProvider.movies.length,
              itemBuilder: (context, index) {
                final movie = searchProvider.movies[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => DetailsScreen(movie: movie)),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Image.network(
                            movie.image,
                            width: 100,
                            height: 150,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  movie.title,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  movie.summary,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
