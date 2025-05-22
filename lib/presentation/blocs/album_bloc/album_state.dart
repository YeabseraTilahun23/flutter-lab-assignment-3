import 'package:equatable/equatable.dart';
import '../../../data/models/album.dart';
import '../../../data/models/photo.dart';

abstract class AlbumState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AlbumInitial extends AlbumState {}

class AlbumLoading extends AlbumState {}

class AlbumLoaded extends AlbumState {
  final List<Album> albums;
  final List<Photo> photos;

  AlbumLoaded({required this.albums, required this.photos});

  @override
  List<Object?> get props => [albums, photos];
}

class AlbumError extends AlbumState {
  final String message;

  AlbumError(this.message);

  @override
  List<Object?> get props => [message];
}
