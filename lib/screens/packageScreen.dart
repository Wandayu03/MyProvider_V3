import 'package:flutter/material.dart';
import 'package:internet_provider/theme/appframe.dart';
import 'package:intl/intl.dart';
import '../models/packageModel.dart';
import '../theme/appframe.dart';
import 'paymentScreen.dart';

class Packagescreen extends StatefulWidget {
  const Packagescreen({super.key});

  @override
  State<Packagescreen> createState() => _PackagescreenState();
}

class _PackagescreenState extends State<Packagescreen> {
  InternetPackage? _selected;
  final _currency = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pilih Paket'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Text('Pilih paket internet sesuai kebutuhan Anda',
                    style: TextStyle(color: Colors.grey[600], fontSize: 14)),
                const SizedBox(height: 16),
                ...availablePackages.map((pkg) => _PackageCard(
                      package: pkg,
                      isSelected: _selected?.id == pkg.id,
                      currency: _currency,
                      onTap: () => setState(() => _selected = pkg),
                    )),
                const SizedBox(height: 100),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: _selected != null
          ? _BottomBar(package: _selected!, currency: _currency, onLanjut: _goToPembayaran)
          : null,
    );
  }

  void _goToPembayaran() {
    if (_selected == null) return;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PembayaranScreen(package: _selected!),
      ),
    );
  }
}

class _PackageCard extends StatelessWidget {
  final InternetPackage package;
  final bool isSelected;
  final NumberFormat currency;
  final VoidCallback onTap;

  const _PackageCard({
    required this.package,
    required this.isSelected,
    required this.currency,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? Appframe.primaryLight : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? Appframe.primary : Colors.grey.shade200,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                if (package.isPopular)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                    margin: const EdgeInsets.only(right: 8),
                    decoration: BoxDecoration(
                      color: Appframe.primary,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text('Terpopuler',
                        style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600)),
                  ),
                Text(package.name,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Appframe.primaryDark)),
                const Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(currency.format(package.pricePerMonth),
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w700, color: Appframe.primaryDark)),
                    const Text('/bulan', style: TextStyle(fontSize: 11, color: Colors.grey)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                const Icon(Icons.speed, size: 16, color: Appframe.primary),
                const SizedBox(width: 4),
                Text(package.speed,
                    style: const TextStyle(fontWeight: FontWeight.w600, color: Appframe.primary)),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(package.description,
                      style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: package.features
                  .map((f) => Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                        decoration: BoxDecoration(
                          color: Appframe.primaryLight,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(f,
                            style: const TextStyle(fontSize: 11, color: Appframe.primaryDark)),
                      ))
                  .toList(),
            ),
            if (isSelected) ...[
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [
                  Icon(Icons.check_circle, color: Appframe.primary, size: 20),
                  SizedBox(width: 4),
                  Text('Dipilih', style: TextStyle(color: Appframe.primary, fontWeight: FontWeight.w600)),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _BottomBar extends StatelessWidget {
  final InternetPackage package;
  final NumberFormat currency;
  final VoidCallback onLanjut;

  const _BottomBar({required this.package, required this.currency, required this.onLanjut});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 20, offset: const Offset(0, -4))],
      ),
      child: Row(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(package.name, style: const TextStyle(fontWeight: FontWeight.w600)),
              Text(currency.format(package.total),
                  style: const TextStyle(
                      color: Appframe.primaryDark, fontWeight: FontWeight.w700, fontSize: 16)),
              const Text('sudah termasuk PPN', style: TextStyle(fontSize: 10, color: Colors.grey)),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: ElevatedButton(
              onPressed: onLanjut,
              child: const Text('Lanjut ke Pembayaran'),
            ),
          ),
        ],
      ),
    );
  }
}