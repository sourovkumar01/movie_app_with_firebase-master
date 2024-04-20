import 'package:flutter/foundation.dart';

class ImageDetails{
 final String? name,year,language;
 ImageDetails({required this.name,required this.year,required this.language});
  factory ImageDetails.fromJson(Map<String,dynamic> movie){
   return ImageDetails(language:movie['language'],name:movie['name'], year: movie['year'],);
   //  name= movie['name'];
   //  Year = movie['year'];
  }
}