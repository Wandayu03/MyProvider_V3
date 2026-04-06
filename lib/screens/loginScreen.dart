import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/appframe.dart';
import 'homeScreen.dart';
 
class Login extends StatefulWidget {
  const Login({super.key});
 
  @override
  State<Login> createState() => _LoginState();
}
 
class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final _identifierCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  bool _isPhone = false;
  bool _obscurePass = true;
  bool _isLoading = false;
 
  // Deteksi apakah input adalah nomor telepon
  void _onIdentifierChanged(String value) {
    final isNum = RegExp(r'^[0-9+]').hasMatch(value);
    if (isNum != _isPhone) {
      setState(() => _isPhone = isNum);
    }
  }
 
  String? _validateIdentifier(String? val) {
    if (val == null || val.isEmpty) return 'Wajib diisi';
    if (_isPhone) {
      if (!RegExp(r'^(\+62|62|0)[0-9]{8,12}$').hasMatch(val)) {
        return 'Format nomor HP tidak valid (cth: 08123456789)';
      }
    } else {
      if (!RegExp(r'^[\w.-]+@[\w.-]+\.\w{2,}$').hasMatch(val)) {
        return 'Format email tidak valid';
      }
    }
    return null;
  }
 
  String? _validatePass(String? val) {
    if (val == null || val.isEmpty) return 'Wajib diisi';
    if (val.length < 6) return 'Password minimal 6 karakter';
    return null;
  }
 
  Future<void> _doLogin() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 1)); // simulasi request
 
    if (!mounted) return;
    setState(() => _isLoading = false);
 
    final identifier = _identifierCtrl.text.trim();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => HomeScreen(identifier: identifier),
      ),
    );
  }
 
  @override
  void dispose() {
    _identifierCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 48),
                // Logo
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Appframe.primary,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: const Icon(Icons.wifi, color: Colors.white, size: 40),
                ),
                const SizedBox(height: 16),
                Text(
                  'MyProvider',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: Appframe.primaryDark,
                        fontWeight: FontWeight.w600,
                      ),
                ),
                Text(
                  'Koneksi cepat, hidup lancar',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.grey[500],
                      ),
                ),
                const SizedBox(height: 40),
 
                // Identifier field
                TextFormField(
                  controller: _identifierCtrl,
                  onChanged: _onIdentifierChanged,
                  validator: _validateIdentifier,
                  keyboardType: _isPhone
                      ? TextInputType.phone
                      : TextInputType.emailAddress,
                  inputFormatters: _isPhone
                      ? [FilteringTextInputFormatter.allow(RegExp(r'[0-9+]'))]
                      : [],
                  decoration: InputDecoration(
                    labelText: 'Email atau Nomor HP',
                    hintText: _isPhone ? '08123456789' : 'contoh@email.com',
                    prefixIcon: Icon(
                      _isPhone ? Icons.phone_outlined : Icons.email_outlined,
                      color: Appframe.primary,
                    ),
                    suffixIcon: _identifierCtrl.text.isNotEmpty
                        ? Tooltip(
                            message: _isPhone ? 'Mode: Nomor HP' : 'Mode: Email',
                            child: Icon(
                              _isPhone ? Icons.smartphone : Icons.alternate_email,
                              color: Colors.grey[400],
                              size: 18,
                            ),
                          )
                        : null,
                  ),
                ),
                const SizedBox(height: 16),
 
                // Password field
                TextFormField(
                  controller: _passCtrl,
                  obscureText: _obscurePass,
                  validator: _validatePass,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    hintText: 'Minimal 6 karakter',
                    prefixIcon: const Icon(Icons.lock_outline, color: Appframe.primary),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePass ? Icons.visibility_off : Icons.visibility,
                        color: Colors.grey[400],
                      ),
                      onPressed: () => setState(() => _obscurePass = !_obscurePass),
                    ),
                  ),
                ),
 
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Lupa password?',
                      style: TextStyle(color: Appframe.primary),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
 
                // Login button
                ElevatedButton(
                  onPressed: _isLoading ? null : _doLogin,
                  child: _isLoading
                      ? const SizedBox(
                          height: 22,
                          width: 22,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2.5,
                          ),
                        )
                      : const Text('Masuk'),
                ),
                const SizedBox(height: 20),
 
                // Divider
                Row(
                  children: [
                    Expanded(child: Divider(color: Colors.grey[300])),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text('atau', style: TextStyle(color: Colors.grey[400], fontSize: 13)),
                    ),
                    Expanded(child: Divider(color: Colors.grey[300])),
                  ],
                ),
                const SizedBox(height: 20),
 
                // Register link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Belum punya akun? ',
                        style: TextStyle(color: Colors.grey[600], fontSize: 14)),
                    GestureDetector(
                      onTap: () {},
                      child: const Text(
                        'Daftar Sekarang',
                        style: TextStyle(
                          color: Appframe.primary,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }
}