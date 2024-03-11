import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persons_app/data/entity/kisiler.dart';
import 'package:persons_app/data/repo/kisilerdao_repository.dart';

class AnasayfaCubit extends Cubit<List<Kisiler>>{
  AnasayfaCubit():super(<Kisiler>[]);

  var kRepo = KisilerDaoRepository();

  Future<void> kisileriListele() async{
    var liste = await kRepo.kisileriListele();
    emit(liste);
  }

}