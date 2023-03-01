import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/category_model.dart';
import '../models/user_model.dart';
import '../services/firebase_service.dart';

class CategoryRepository{
  CollectionReference<CategoryModel> categoryRef = FirebaseService.db.collection("categories")
      .withConverter<CategoryModel>(
    fromFirestore: (snapshot, _) {
      return CategoryModel.fromFirebaseSnapshot(snapshot);
    },
    toFirestore: (model, _) => model.toJson(),
  );
    Future<List<QueryDocumentSnapshot<CategoryModel>>> getCategories() async {
    try {
      var data = await categoryRef.get();
      bool hasData = data.docs.isNotEmpty;
      if(!hasData){
        makeCategory().forEach((element) async {
          await categoryRef.add(element);
        });
      }
      final response = await categoryRef.get();
      var category = response.docs;
      return category;
    } catch (err) {
      print(err);
      rethrow;
    }
  }

  Future<DocumentSnapshot<CategoryModel>>  getCategory(String categoryId) async {
      try{
        print(categoryId);
        final response = await categoryRef.doc(categoryId).get();
        return response;
      }catch(e){
        rethrow;
      }
  }

  List<CategoryModel> makeCategory(){
      return [
        CategoryModel(categoryName: "Dominar", status: "active", imageUrl: "https://www.google.com/search?q=dominar+250&sxsrf=AJOqlzUysuv842VGretwA5XySG7FQoIduw:1677614347908&source=lnms&tbm=isch&sa=X&ved=2ahUKEwicwZu6gLn9AhW87zgGHT4bDscQ_AUoAXoECAEQAw&biw=1366&bih=625&dpr=1#imgrc=2oHYjsFww0UBOM&imgdii=tjNOFC79EpHFSM"),
        CategoryModel(categoryName: "Duke", status: "active", imageUrl: "https://www.google.com/search?q=duke&tbm=isch&ved=2ahUKEwjZrqO7gLn9AhX82HMBHU27BYQQ2-cCegQIABAA&oq=duke&gs_lcp=CgNpbWcQAzIECCMQJzIHCAAQsQMQQzIHCAAQsQMQQzIECAAQQzIECAAQQzIHCAAQsQMQQzIECAAQQzIECAAQQzIECAAQQzIECAAQQzoFCAAQgARQ2gZYkwpgsAtoAHAAeACAAa8BiAGdBZIBAzAuNZgBAKABAaoBC2d3cy13aXotaW1nwAEB&sclient=img&ei=Dl3-Y9nvB_yxz7sPzfaWoAg&bih=625&biw=1366#imgrc=syF92KsZzxqr-M"),
        CategoryModel(categoryName: "Royal Enfield", status: "active", imageUrl: "https://www.google.com/search?q=bullet+bike&tbm=isch&ved=2ahUKEwiit_e5grn9AhVJidgFHbZlCX8Q2-cCegQIABAA&oq=bullet+&gs_lcp=CgNpbWcQARgAMgcIABCxAxBDMgQIABBDMgQIABBDMgQIABBDMgQIABBDMgQIABBDMgQIABBDMgQIABBDMgQIABBDMgQIABBDOgQIIxAnOgUIABCABDoICAAQgAQQsQNQ1AdY3hFgzRhoAHAAeACAAYcBiAHWB5IBAzAuOJgBAKABAaoBC2d3cy13aXotaW1nwAEB&sclient=img&ei=JF_-Y6KVC8mS4t4Ptsul-Ac&bih=625&biw=1366#imgrc=-MaToRfoF95qUM"),
        CategoryModel(categoryName: "Honda", status: "active", imageUrl: "https://www.google.com/search?q=honda+superbike&tbm=isch&ved=2ahUKEwjNiOrPgrn9AhX7AbcAHeJRDxcQ2-cCegQIABAA&oq=honda+superbike&gs_lcp=CgNpbWcQAzIFCAAQgAQyBQgAEIAEMgUIABCABDIFCAAQgAQyBQgAEIAEMgUIABCABDIFCAAQgAQyBQgAEIAEMgUIABCABDIFCAAQgAQ6BAgjECc6BAgAEEM6BggAEAcQHlDABVj5C2CuDmgAcAB4AIABugGIAZYGkgEDMC42mAEAoAEBqgELZ3dzLXdpei1pbWfAAQE&sclient=img&ei=Ul_-Y82XBvuD3LUP4qO9uAE&bih=625&biw=1366#imgrc=tAReI_p-1x7GRM"),
        CategoryModel(categoryName: "Electric", status: "active", imageUrl: "https://www.google.com/search?q=super+soco+tc+max+price+in+nepal&tbm=isch&ved=2ahUKEwjPmNfWgrn9AhVFLbcAHbuPC7QQ2-cCegQIABAA&oq=super+soco+tc+max+&gs_lcp=CgNpbWcQARgBMgQIIxAnMgUIABCABDIFCAAQgAQyBQgAEIAEMgUIABCABDIFCAAQgAQyBQgAEIAEMgUIABCABDIFCAAQgAQyBQgAEIAEOgQIABBDOgoIABCxAxCDARBDOggIABCABBCxAzoGCAAQCBAeUIcFWOEoYMgqaABwAHgAgAG_AYgBrA2SAQQwLjEymAEAoAEBqgELZ3dzLXdpei1pbWfAAQE&sclient=img&ei=YF_-Y8_oHMXa3LUPu5-uoAs&bih=625&biw=1366#imgrc=lFEOF_hTq6rIvM"),
      ];
  }



}