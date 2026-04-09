import 'package:flutter/material.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _messageController = TextEditingController();

  String _selectedGender = 'Male';
  String _selectedCountry = 'India';
  bool _agreeToTerms = false;
  bool _subscribeNewsletter = false;
  double _rating = 3;
  bool _submitted = false;

  final List<String> _countries = ['India', 'USA', 'UK', 'Canada', 'Australia', 'Germany'];

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      if (!_agreeToTerms) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please agree to the terms and conditions'), backgroundColor: Colors.red),
        );
        return;
      }
      setState(() => _submitted = true);
    }
  }

  void _resetForm() {
    _formKey.currentState!.reset();
    _nameController.clear();
    _emailController.clear();
    _phoneController.clear();
    _messageController.clear();
    setState(() {
      _selectedGender = 'Male';
      _selectedCountry = 'India';
      _agreeToTerms = false;
      _subscribeNewsletter = false;
      _rating = 3;
      _submitted = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form Elements'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: _submitted ? _buildSuccessView() : _buildForm(),
    );
  }

  Widget _buildSuccessView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.check_circle, color: Colors.green, size: 80),
          const SizedBox(height: 16),
          const Text('Form Submitted Successfully!', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text('Name: ${_nameController.text}'),
          Text('Email: ${_emailController.text}'),
          Text('Country: $_selectedCountry'),
          Text('Gender: $_selectedGender'),
          Text('Rating: ${_rating.toInt()}/5'),
          const SizedBox(height: 24),
          ElevatedButton(
            key: const Key('reset_button'),
            onPressed: _resetForm,
            child: const Text('Fill Again'),
          ),
        ],
      ),
    );
  }

  Widget _buildForm() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Registration Form', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 24),

            // Full Name
            TextFormField(
              key: const Key('name_field'),
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Full Name *',
                hintText: 'Enter your full name',
                prefixIcon: Icon(Icons.person_outline),
                border: OutlineInputBorder(),
              ),
              validator: (v) => v == null || v.isEmpty ? 'Name is required' : null,
            ),
            const SizedBox(height: 16),

            // Email
            TextFormField(
              key: const Key('email_field'),
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Email Address *',
                hintText: 'Enter your email',
                prefixIcon: Icon(Icons.email_outlined),
                border: OutlineInputBorder(),
              ),
              validator: (v) {
                if (v == null || v.isEmpty) return 'Email is required';
                if (!v.contains('@')) return 'Enter valid email';
                return null;
              },
            ),
            const SizedBox(height: 16),

            // Phone
            TextFormField(
              key: const Key('phone_field'),
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: 'Phone Number',
                hintText: 'Enter your phone number',
                prefixIcon: Icon(Icons.phone_outlined),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            // Country Dropdown
            Semantics(
              label: 'Country dropdown',
              child: DropdownButtonFormField<String>(
                key: const Key('country_dropdown'),
                value: _selectedCountry,
                decoration: const InputDecoration(
                  labelText: 'Country *',
                  prefixIcon: Icon(Icons.flag_outlined),
                  border: OutlineInputBorder(),
                ),
                items: _countries.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
                onChanged: (v) => setState(() => _selectedCountry = v!),
              ),
            ),
            const SizedBox(height: 16),

            // Gender Radio
            const Text('Gender *', style: TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Row(
              children: ['Male', 'Female', 'Other'].map((gender) {
                return Row(
                  children: [
                    Semantics(
                      label: '$gender radio button',
                      child: Radio<String>(
                        key: Key('gender_$gender'),
                        value: gender,
                        groupValue: _selectedGender,
                        onChanged: (v) => setState(() => _selectedGender = v!),
                      ),
                    ),
                    Text(gender),
                    const SizedBox(width: 16),
                  ],
                );
              }).toList(),
            ),
            const SizedBox(height: 16),

            // Rating Slider
            Text('Experience Rating: ${_rating.toInt()}/5', style: const TextStyle(fontSize: 16)),
            Semantics(
              label: 'Rating slider',
              child: Slider(
                key: const Key('rating_slider'),
                value: _rating,
                min: 1,
                max: 5,
                divisions: 4,
                label: _rating.toInt().toString(),
                onChanged: (v) => setState(() => _rating = v),
              ),
            ),
            const SizedBox(height: 16),

            // Message
            TextFormField(
              key: const Key('message_field'),
              controller: _messageController,
              maxLines: 4,
              decoration: const InputDecoration(
                labelText: 'Message',
                hintText: 'Enter your message here...',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            // Checkboxes
            Semantics(
              label: 'Newsletter checkbox',
              child: CheckboxListTile(
                key: const Key('newsletter_checkbox'),
                value: _subscribeNewsletter,
                onChanged: (v) => setState(() => _subscribeNewsletter = v!),
                title: const Text('Subscribe to newsletter'),
                controlAffinity: ListTileControlAffinity.leading,
              ),
            ),
            Semantics(
              label: 'Terms checkbox',
              child: CheckboxListTile(
                key: const Key('terms_checkbox'),
                value: _agreeToTerms,
                onChanged: (v) => setState(() => _agreeToTerms = v!),
                title: const Text('I agree to the Terms and Conditions *'),
                controlAffinity: ListTileControlAffinity.leading,
              ),
            ),
            const SizedBox(height: 24),

            // Buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    key: const Key('submit_button'),
                    onPressed: _submitForm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text('Submit Form', style: TextStyle(fontSize: 16)),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: OutlinedButton(
                    key: const Key('clear_button'),
                    onPressed: _resetForm,
                    style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16)),
                    child: const Text('Clear Form', style: TextStyle(fontSize: 16)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
