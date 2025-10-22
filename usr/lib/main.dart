import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

void main() {
  runApp(const PowerBICloneApp());
}

class PowerBICloneApp extends StatelessWidget {
  const PowerBICloneApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Power BI Clone',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.grey[100],
      ),
      home: const DashboardScreen(),
    );
  }
}

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _pages = <Widget>[
    DashboardView(),
    ReportsView(),
    DataSourcesView(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Power BI Clone'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              // Refresh data logic here
            },
          ),
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              // Share dashboard logic here
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Navigation',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.dashboard),
              title: const Text('Dashboard'),
              onTap: () {
                _onItemTapped(0);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.bar_chart),
              title: const Text('Reports'),
              onTap: () {
                _onItemTapped(1);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.storage),
              title: const Text('Data Sources'),
              onTap: () {
                _onItemTapped(2);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: _pages[_selectedIndex],
    );
  }
}

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 16.0,
        mainAxisSpacing: 16.0,
        children: const <Widget>[
          ChartCard(title: 'Sales Overview', child: SalesBarChart()),
          ChartCard(title: 'Revenue Trend', child: RevenueLineChart()),
          ChartCard(title: 'Category Distribution', child: CategoryPieChart()),
          ChartCard(title: 'Performance Metrics', child: PerformanceGauge()),
        ],
      ),
    );
  }
}

class ReportsView extends StatelessWidget {
  const ReportsView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Reports View - Coming Soon'),
    );
  }
}

class DataSourcesView extends StatelessWidget {
  const DataSourcesView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Data Sources View - Coming Soon'),
    );
  }
}

class ChartCard extends StatelessWidget {
  final String title;
  final Widget child;

  const ChartCard({super.key, required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16.0),
            Expanded(child: child),
          ],
        ),
      ),
    );
  }
}

class SalesBarChart extends StatelessWidget {
  const SalesBarChart({super.key});

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        barGroups: [
          BarChartGroupData(x: 0, barRods: [BarChartRodData(toY: 8, color: Colors.blue)]),
          BarChartGroupData(x: 1, barRods: [BarChartRodData(toY: 10, color: Colors.blue)]),
          BarChartGroupData(x: 2, barRods: [BarChartRodData(toY: 14, color: Colors.blue)]),
          BarChartGroupData(x: 3, barRods: [BarChartRodData(toY: 15, color: Colors.blue)]),
        ],
        titlesData: FlTitlesData(
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                const titles = ['Q1', 'Q2', 'Q3', 'Q4'];
                return Text(titles[value.toInt()]);
              },
            ),
          ),
        ),
      ),
    );
  }
}

class RevenueLineChart extends StatelessWidget {
  const RevenueLineChart({super.key});

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        lineBarsData: [
          LineChartBarData(
            spots: [
              const FlSpot(0, 1),
              const FlSpot(1, 3),
              const FlSpot(2, 10),
              const FlSpot(3, 7),
              const FlSpot(4, 12),
              const FlSpot(5, 13),
            ],
            isCurved: true,
            color: Colors.green,
            barWidth: 4,
            isStrokeCapRound: true,
            belowBarData: BarAreaData(show: false),
          ),
        ],
        titlesData: FlTitlesData(
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                const titles = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'];
                return Text(titles[value.toInt()]);
              },
            ),
          ),
        ),
      ),
    );
  }
}

class CategoryPieChart extends StatelessWidget {
  const CategoryPieChart({super.key});

  @override
  Widget build(BuildContext context) {
    return PieChart(
      PieChartData(
        sections: [
          PieChartSectionData(
            value: 40,
            title: '40%',
            color: Colors.red,
          ),
          PieChartSectionData(
            value: 30,
            title: '30%',
            color: Colors.blue,
          ),
          PieChartSectionData(
            value: 20,
            title: '20%',
            color: Colors.green,
          ),
          PieChartSectionData(
            value: 10,
            title: '10%',
            color: Colors.yellow,
          ),
        ],
      ),
    );
  }
}

class PerformanceGauge extends StatelessWidget {
  const PerformanceGauge({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Performance Gauge - Placeholder'),
    );
  }
}