import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persons_app/data/entity/kisiler.dart';
import 'package:persons_app/ui/cubit/anasayfa_cubit.dart';
import 'package:persons_app/ui/views/detay_sayfa.dart';
import 'package:persons_app/ui/views/kayit_sayfa.dart';

class Anasayfa extends StatefulWidget {

  @override
  State<Anasayfa> createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {
  bool aramaYapiliyorMu = false;

  Future<void> kisiAra(String arananKelime) async{
    print("Kişi ara: $arananKelime");
  }

  Future<void> kisiSil(int kisi_id) async{
    print("Silinen Kişi id: ${kisi_id}");
  }

 @override
  void initState() {
    super.initState();
    context.read<AnasayfaCubit>().kisileriListele();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: aramaYapiliyorMu ?
        TextField(
          decoration: InputDecoration(hintText: "Ara"),
          onChanged: (aramaSonucu) {
            kisiAra(aramaSonucu);
          },
        ) :
            Text("Kişiler"),
            actions: [
              aramaYapiliyorMu ?
                  IconButton(
                      onPressed: () {
                      setState(() {
                        aramaYapiliyorMu = false;
                      });
                      },
                      icon: Icon(Icons.search_off_outlined)) :
                  IconButton(
                  onPressed: () {
                    setState(() {
                      aramaYapiliyorMu = true;
                    });
                  },
                  icon: Icon(Icons.search))

        ],
      ),
      body: BlocBuilder<AnasayfaCubit,List<Kisiler>>(
        builder: (context,kisilerListesi) {
          if(kisilerListesi.isNotEmpty){
            return ListView.builder(
              itemCount: kisilerListesi.length,
              itemBuilder: (context,index) {
                var kisiNesnesi = kisilerListesi[index];

                return SizedBox(
                  height: 80,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => DetaySayfa(kisi: kisiNesnesi,)));
                      context.read<AnasayfaCubit>().kisileriListele();
                    },
                    child: Card(
                     // color: Colors.white60,
                      elevation: 10,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(kisiNesnesi.kisi_adi,style: TextStyle(color: Colors.black,fontSize: 20),),
                                Text(kisiNesnesi.kisi_no.toString(),style: TextStyle(color: Colors.black,fontSize: 16)),
                              ],
                            ),
                          ),
                          Spacer(),
                          IconButton(
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("${kisiNesnesi.kisi_adi} silinsin mi?"),
                                    action: SnackBarAction(
                                      label: "Evet",
                                      onPressed: () {
                                        kisiSil(kisiNesnesi.kisi_id);
                                      },
                                    ),
                                  )
                                );
                              },
                              icon: Icon(CupertinoIcons.xmark))
                        ],
                      )

                    ),
                  ),
                );

              },
            );

          }else{
            return Center();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => KayitSayfa()));
          context.read<AnasayfaCubit>().kisileriListele();
        },
        child: Icon(CupertinoIcons.add),
      ),

    );
  }
}