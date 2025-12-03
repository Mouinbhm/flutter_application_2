import 'package:flutter/material.dart';
import 'package:flutter_application_2/movie_detail_screen.dart';

class MoviesScreen extends StatelessWidget {
  const MoviesScreen({super.key, required this.onArchiveMovie});

  /// Callback fourni par main.dart pour enregistrer en history
  final void Function(Map<String, dynamic> movie) onArchiveMovie;

  final List<Map<String, dynamic>> movies = const [
    {
      "title": "Interstellar",
      "genre": "Sci-Fi",
      "year": "2014",
      "image":
          "https://image.tmdb.org/t/p/w500/gEU2QniE6E77NI6lCU6MxlNBvIx.jpg",
      "summary":
          "Un groupe d’astronautes voyage à travers un trou de ver pour trouver une nouvelle planète habitable pour l’humanité.",
      "rating": 4.8,
    },
    {
      "title": "The Dark Knight",
      "genre": "Action",
      "year": "2008",
      "image":
          "https://image.tmdb.org/t/p/w500/qJ2tW6WMUDux911r6m7haRef0WH.jpg",
      "summary":
          "Batman affronte le Joker, un criminel anarchiste qui plonge Gotham dans le chaos.",
      "rating": 4.9,
    },
    {
      "title": "The Matrix",
      "genre": "Sci-Fi",
      "year": "1999",
      "image":
          "https://image.tmdb.org/t/p/w500/f89U3ADr1oiB1s9GkdPOEpXUk5H.jpg",
      "summary":
          "Un hacker découvre que la réalité dans laquelle il vit est une simulation contrôlée par des machines.",
      "rating": 4.7,
    },
    {
      "title": "La La Land",
      "genre": "Musical",
      "year": "2016",
      "image":
          "https://image.tmdb.org/t/p/w500/uDO8zWDhfWwoFdKS4fzkUJt0Rf0.jpg",
      "summary":
          "Une actrice en devenir et un pianiste de jazz tombent amoureux en poursuivant leurs rêves à Los Angeles.",
      "rating": 4.3,
    },
    {
      "title": "Parasite",
      "genre": "Thriller",
      "year": "2019",
      "image":
          "https://image.tmdb.org/t/p/w500/7IiTTgloJzvGI1TAYymCfbfl3vT.jpg",
      "summary":
          "Une famille pauvre s’immisce progressivement dans la vie d’une famille riche, jusqu’à ce que tout dérape.",
      "rating": 4.6,
    },
    {
      "title": "Gladiator",
      "genre": "Historical",
      "year": "2000",
      "image":
          "https://image.tmdb.org/t/p/w500/ty8TGRuvJLPUmAR1H1nRIsgwvim.jpg",
      "summary":
          "Un général romain trahi devient gladiateur et cherche à se venger de l’empereur corrompu.",
      "rating": 4.5,
    },
    {
      "title": "The Godfather",
      "genre": "Crime",
      "year": "1972",
      "image":
          "https://image.tmdb.org/t/p/w500/3bhkrj58Vtu7enYsRolD1fZdja1.jpg",
      "summary":
          "La saga d’une puissante famille mafieuse italo-américaine et de son héritier réticent.",
      "rating": 4.9,
    },
    {
      "title": "Spirited Away",
      "genre": "Animation",
      "year": "2001",
      "image":
          "https://image.tmdb.org/t/p/w500/oRvMaJOmapypFUcQqpgHMZA6qL9.jpg",
      "summary":
          "Une jeune fille se retrouve coincée dans un monde d’esprits et doit sauver ses parents transformés en cochons.",
      "rating": 4.8,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Movies Screen 🎬"),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GridView.builder(
          itemCount: movies.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.7,
          ),
          itemBuilder: (context, index) {
            final movie = movies[index];

            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => MovieDetailScreen(
                      movie: movie,
                      onArchive: onArchiveMovie,
                    ),
                  ),
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    // Image background
                    Image.network(
                      movie["image"] as String,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, progress) {
                        if (progress == null) return child;
                        return Container(
                          color: Colors.grey.shade900,
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey.shade800,
                          child: const Center(
                            child: Icon(
                              Icons.broken_image_outlined,
                              color: Colors.white54,
                              size: 32,
                            ),
                          ),
                        );
                      },
                    ),

                    // Dégradé noir
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Colors.black.withOpacity(0.85),
                            Colors.black.withOpacity(0.4),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),

                    // Texte en bas
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            movie["title"] as String,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              letterSpacing: 0.3,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.12),
                                  borderRadius: BorderRadius.circular(999),
                                  border: Border.all(
                                    color: Colors.white.withOpacity(0.25),
                                    width: 0.7,
                                  ),
                                ),
                                child: Text(
                                  movie["genre"] as String,
                                  style: const TextStyle(
                                    fontSize: 11,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 6),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.deepPurple.withOpacity(0.9),
                                  borderRadius: BorderRadius.circular(999),
                                ),
                                child: Text(
                                  movie["year"] as String,
                                  style: const TextStyle(
                                    fontSize: 11,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
