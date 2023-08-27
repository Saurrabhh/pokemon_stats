// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemon_detail_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PokemonDetailModelAdapter extends TypeAdapter<PokemonDetailModel> {
  @override
  final int typeId = 1;

  @override
  PokemonDetailModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PokemonDetailModel(
      id: fields[0] as int,
      name: fields[1] as String,
      height: fields[2] as int,
      weight: fields[3] as int,
      baseExperience: fields[4] as int,
      types: fields[5] as String,
      abilities: fields[6] as String,
      moves: fields[7] as String,
      species: fields[8] as String,
      sprite: fields[9] as String,
    )..isFavourite = fields[10] as bool;
  }

  @override
  void write(BinaryWriter writer, PokemonDetailModel obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.height)
      ..writeByte(3)
      ..write(obj.weight)
      ..writeByte(4)
      ..write(obj.baseExperience)
      ..writeByte(5)
      ..write(obj.types)
      ..writeByte(6)
      ..write(obj.abilities)
      ..writeByte(7)
      ..write(obj.moves)
      ..writeByte(8)
      ..write(obj.species)
      ..writeByte(9)
      ..write(obj.sprite)
      ..writeByte(10)
      ..write(obj.isFavourite);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PokemonDetailModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
