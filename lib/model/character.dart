import 'package:flutter/foundation.dart';

class Character {
  final int? id;
  final String? name;
  final String? image;
  final String? gender;
  final String? species;

  Character(
    this.id,
    this.name,
    this.image,
    this.species,
    this.gender,
  );
}
