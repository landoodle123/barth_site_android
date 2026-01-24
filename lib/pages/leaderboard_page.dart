import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LeaderboardPage extends StatefulWidget {
  const LeaderboardPage({super.key});

  @override
  State<LeaderboardPage> createState() => _LeaderboardPageState();
}

class _LeaderboardPageState extends State<LeaderboardPage> {
  List<Map<String, dynamic>> leaderboard = [];
  bool loading = true;
  String error = '';

  static const String apiUrl =
      'https://barth-site.vercel.app/api/leaderboard';

  @override
  void initState() {
    super.initState();
    fetchLeaderboard();
  }

  Future<void> fetchLeaderboard() async {
    try {
      final uri = Uri.parse(apiUrl);

      final response = await http.get(uri);

      if (response.statusCode != 200) {
        setState(() {
          error =
              'HTTP ${response.statusCode}\n\nResponse:\n${response.body}';
          loading = false;
        });
        return;
      }

      final decoded = jsonDecode(response.body);

      // Your API might return:
      // 1) { leaderboard: [...] }
      // OR
      // 2) [ ... ] directly

      final List<dynamic> rawList =
          decoded is Map && decoded['leaderboard'] != null
              ? decoded['leaderboard']
              : decoded is List
                  ? decoded
                  : [];

      if (rawList.isEmpty) {
        setState(() {
          error = 'No leaderboard data found.\nRaw response:\n$decoded';
          loading = false;
        });
        return;
      }

      final List<Map<String, dynamic>> fetched = [];

      for (int i = 0; i < rawList.length; i++) {
        final entry = rawList[i];

        fetched.add({
          'rank': i + 1,
          'name': entry['user']?['name']?.toString() ?? 'Unknown',
          'score': int.tryParse(entry['count']?.toString() ?? '0') ?? 0,
        });
      }

      setState(() {
        leaderboard = fetched;
        loading = false;
      });
    } catch (e) {
      setState(() {
        error = 'Exception:\n$e';
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Leaderboard'),
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : error.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.all(16),
                  child: SingleChildScrollView(
                    child: Text(
                      error,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                )
              : ListView.builder(
                  itemCount: leaderboard.length,
                  itemBuilder: (context, index) {
                    final entry = leaderboard[index];
                    return ListTile(
                      leading: CircleAvatar(
                        child: Text('${entry['rank']}'),
                      ),
                      title: Text(entry['name']),
                      trailing: Text(
                        '${entry['score']}',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    );
                  },
                ),
    );
  }
}
