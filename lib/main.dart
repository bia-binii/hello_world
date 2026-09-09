import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';

void main() {
  runApp(const MeuApp());
}

class MeuApp extends StatelessWidget {
  const MeuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Meu mapa',
      home: const MapaPage(),
    );
  }
}

class MapaPage extends StatefulWidget {
  const MapaPage({super.key});

  @override
  State<MapaPage> createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {
  final MapController _mapController = MapController();

  LatLng? _localizacaoAtual;
  bool _carregando = true;

  @override
  void initState() {
    super.initState();
    _iniciarLocalizacao();
  }

  Future<void> _iniciarLocalizacao() async {
    bool servicoAtivo = await Geolocator.isLocationServiceEnabled();

    if (!servicoAtivo) {
      setState(() {
        _carregando = false;
      });
      return;
    }

    LocationPermission permissao = await Geolocator.checkPermission();

    if (permissao == LocationPermission.denied) {
      permissao = await Geolocator.requestPermission();
    }

    if (permissao == LocationPermission.denied ||
        permissao == LocationPermission.deniedForever) {
      setState(() {
        _carregando = false;
      });
      return;
    }

    Position posicao = await Geolocator.getCurrentPosition();

    setState(() {
      _localizacaoAtual = LatLng(
        posicao.latitude,
        posicao.longitude,
      );

      _carregando = false;
    });

    _mapController.move(
      _localizacaoAtual!,
      16,
    );

    Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 5,
      ),
    ).listen((Position posicao) {
      final novaLocalizacao = LatLng(
        posicao.latitude,
        posicao.longitude,
      );

      setState(() {
        _localizacaoAtual = novaLocalizacao;
      });

      _mapController.move(
        novaLocalizacao,
        _mapController.camera.zoom,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Minha localização'),
      ),

      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,

            options: const MapOptions(
              initialCenter: LatLng(
                -21.442010,
                -47.009005,
              ),
              initialZoom: 13,
            ),

            children: [
              TileLayer(
                urlTemplate:
                    'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName:
                    'com.example.mapa_flutter',
              ),

              MarkerLayer(
                markers: [
                  if (_localizacaoAtual != null)
                    Marker(
                      point: _localizacaoAtual!,
                      width: 50,
                      height: 50,
                      child: const Icon(
                        Icons.location_pin,
                        color: Colors.red,
                        size: 50,
                      ),
                    ),
                ],
              ),
            ],
          ),

          if (_carregando)
            const Center(
              child: CircularProgressIndicator(),
            ),

          Positioned(
            right: 20,
            bottom: 20,
            child: FloatingActionButton(
              onPressed: () {
                if (_localizacaoAtual != null) {
                  _mapController.move(
                    _localizacaoAtual!,
                    16,
                  );
                }
              },
              child: const Icon(Icons.my_location),
            ),
          ),
        ],
      ),
    );
  }
}