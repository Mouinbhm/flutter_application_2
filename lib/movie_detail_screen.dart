import 'package:flutter/material.dart';

class MovieDetailScreen extends StatelessWidget {
  const MovieDetailScreen({
    super.key,
    required this.movie,
    required this.onArchive,
  });

  final Map<String, dynamic> movie;
  final void Function(Map<String, dynamic> movie) onArchive;

  List<Widget> _buildStarRating(double rating) {
    final List<Widget> stars = [];
    for (int i = 1; i <= 5; i++) {
      if (rating >= i) {
        stars.add(const Icon(Icons.star, color: Colors.amber, size: 22));
      } else if (rating >= i - 0.5) {
        stars.add(const Icon(Icons.star_half, color: Colors.amber, size: 22));
      } else {
        stars.add(
          const Icon(Icons.star_border, color: Colors.amber, size: 22),
        );
      }
    }
    return stars;
  }

  @override
  Widget build(BuildContext context) {
    final String title = movie["title"] as String;
    final String imageUrl = movie["image"] as String;
    final String summary = movie["summary"] as String;
    final double rating = movie["rating"] as double;

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ✅ IMAGE PLUS PETITE
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: SizedBox(
                    width: 240, // largeur réduite
                    height: 340, // hauteur réduite
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey.shade800,
                          child: const Center(
                            child: Icon(
                              Icons.broken_image_outlined,
                              color: Colors.white54,
                              size: 40,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // ✅ TITRE
              Text(
                title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),

              const SizedBox(height: 10),

              // ✅ RATING
              Row(
                children: [
                  Row(children: _buildStarRating(rating)),
                  const SizedBox(width: 8),
                  Text(
                    rating.toStringAsFixed(1),
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // ✅ RÉSUMÉ
              const Text(
                "Résumé",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                summary,
                style: const TextStyle(
                  fontSize: 14,
                  height: 1.4,
                ),
              ),

              const SizedBox(height: 30),

              // ✅ BOUTON ARCHIVE PLUS PETIT ET À GAUCHE
              Align(
                alignment: Alignment.centerLeft, // bouton à gauche
                child: ElevatedButton.icon(
                  onPressed: () {
                    onArchive(movie);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Film archivé dans l'historique ✅"),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16, // largeur réduite
                      vertical: 8, // hauteur réduite
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    minimumSize: const Size(0, 36),
                  ),
                  icon: const Icon(
                    Icons.archive,
                    size: 18,
                  ),
                  label: const Text(
                    "ARCHIVER",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
