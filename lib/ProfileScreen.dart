import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _occupationController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isEditing = false;
  Map<String, dynamic> _profileData = {};

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    final userId = _auth.currentUser?.uid;
    if (userId != null) {
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();
      if (doc.exists) {
        setState(() {
          _profileData = doc.data() ?? {};
          _usernameController.text = _profileData['username'] ?? '';
          _emailController.text = _profileData['email'] ?? '';
          _dobController.text = _profileData['dob'] ?? '';
          _locationController.text = _profileData['location'] ?? '';
          _occupationController.text = _profileData['occupation'] ?? '';
          _bioController.text = _profileData['bio'] ?? '';
        });
      }
    }
  }

  Future<void> _saveProfile() async {
    if (_formKey.currentState!.validate()) {
      final userId = _auth.currentUser?.uid;
      // Let user edit each field individually
      if (userId != null) {
        Map<String, dynamic> profileData = {};
        if (_usernameController.text.isNotEmpty)
          profileData['username'] = _usernameController.text;
        if (_emailController.text.isNotEmpty)
          profileData['email'] = _emailController.text;
        if (_dobController.text.isNotEmpty)
          profileData['dob'] = _dobController.text;
        if (_locationController.text.isNotEmpty)
          profileData['location'] = _locationController.text;
        if (_occupationController.text.isNotEmpty)
          profileData['occupation'] = _occupationController.text;
        if (_bioController.text.isNotEmpty)
          profileData['bio'] = _bioController.text;

        await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .set(profileData, SetOptions(merge: true));

        setState(() {
          _isEditing = false;
          _profileData = profileData;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Profile information saved!')),
        );
      }
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _dobController.dispose();
    _locationController.dispose();
    _occupationController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        actions: [
          if (_isEditing)
            IconButton(
              icon: Icon(Icons.check),
              onPressed: _saveProfile,
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: _isEditing ? _buildEditForm() : _buildProfileView(),
      ),
    );
  }

  // Profile view 
  Widget _buildProfileView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildProfileField('Username', _profileData['username']),
        _buildProfileField('Email', _profileData['email']),
        _buildProfileField('Date of Birth', _profileData['dob']),
        _buildProfileField('Location', _profileData['location']),
        _buildProfileField('Occupation', _profileData['occupation']),
        _buildProfileField('Bio', _profileData['bio']),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            setState(() {
              _isEditing = true;
            });
          },
          child: Text('Edit'),
        ),
      ],
    );
  }

  Widget _buildProfileField(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label: ',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Expanded(
            child: Text(
              value ?? 'Not set',
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEditForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          // USERNAME
          TextFormField(
            controller: _usernameController,
            decoration: InputDecoration(labelText: 'Username'),
          ),
          // EMAIL ADDRESS
          TextFormField(
            controller: _emailController,
            decoration: InputDecoration(labelText: 'Email'),
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value != null &&
                  value.isNotEmpty &&
                  !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                return 'Please enter a valid email address';
              }
              return null;
            },
          ),
          // DATE OF BIRTH
          TextFormField(
            controller: _dobController,
            decoration: InputDecoration(
                labelText: 'Date of Birth', hintText: 'YYYY-MM-DD'),
            keyboardType: TextInputType.datetime,
            validator: (value) {
              if (value != null &&
                  value.isNotEmpty &&
                  !RegExp(r'^\d{4}-\d{2}-\d{2}$').hasMatch(value)) {
                return 'Please enter date in the format YYYY-MM-DD';
              }
              return null;
            },
          ),
          // LOCATION
          TextFormField(
            controller: _locationController,
            decoration: InputDecoration(labelText: 'Location'),
          ),
          // OCCUPATION
          TextFormField(
            controller: _occupationController,
            decoration: InputDecoration(labelText: 'Occupation'),
          ),
          // BIO
          TextFormField(
            controller: _bioController,
            decoration: InputDecoration(labelText: 'Bio'),
            maxLines: 3,
          ),
          SizedBox(height: 20),
          // SAVE BUTTON
          ElevatedButton(
            onPressed: _saveProfile,
            child: Text('Save'),
          ),
        ],
      ),
    );
  }
}
