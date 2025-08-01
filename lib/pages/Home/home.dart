import 'package:flutter/material.dart';
import 'package:co/pages/Cart/cart.dart';
import 'package:co/pages/Detail/coffee_detail.dart';
import 'package:co/pages/Detail/shop_detail.dart';
import 'package:co/pages/Detail/community_detail.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();
  final List<Map<String, dynamic>> _cartItems = [];
  final List<Map<String, dynamic>> _reviews = [
    {
      'user': 'CoffeeLover42',
      'comment': 'The caramel latte at Brew Haven is amazing!',
      'rating': 5,
      'shop': 'Brew Haven'
    },
    {
      'user': 'JavaJunkie',
      'comment': 'Great atmosphere at Bean Dream',
      'rating': 4,
      'shop': 'Bean Dream'
    },
  ];

  void _addToCart(Map<String, dynamic> coffee) {
    setState(() {
      _cartItems.add(coffee);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${coffee['name']} added to cart')),
    );
  }

  void _navigateToCart() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CartPage(cartItems: _cartItems),
      ),
    );
  }

  void _navigateToCoffeeDetail(Map<String, dynamic> coffee) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CoffeeDetailPage(
          coffee: coffee,
          onAddToCart: _addToCart,
        ),
      ),
    );
  }

  void _navigateToShopDetail(Map<String, dynamic> shop) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ShopDetailPage(shop: shop),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cofe App'),
        backgroundColor: const Color.fromARGB(255, 143, 97, 6),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Badge(
              label: Text(_cartItems.length.toString()),
              child: const Icon(Icons.shopping_cart),
            ),
            onPressed: _navigateToCart,
          ),
        ],
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        children: [
          CoffeeTypesPage(onCoffeeSelected: _navigateToCoffeeDetail),
          CoffeeShopsPage(onShopSelected: _navigateToShopDetail),
          CommunityPage(reviews: _reviews),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToCart,
        backgroundColor: const Color.fromARGB(255, 143, 97, 6),
        child: Badge(
          label: Text(_cartItems.length.toString()),
          isLabelVisible: _cartItems.isNotEmpty,
          child: const Icon(Icons.shopping_cart, color: Colors.white),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            _pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          });
        },
        selectedItemColor: const Color.fromARGB(255, 143, 97, 6),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.coffee),
            label: 'Coffee Types',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.store),
            label: 'Shops',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Community',
          ),
        ],
      ),
    );
  }
}

class CoffeeTypesPage extends StatelessWidget {
  final Function(Map<String, dynamic>) onCoffeeSelected;

  const CoffeeTypesPage({super.key, required this.onCoffeeSelected});

  @override
  Widget build(BuildContext context) {
    final coffeeTypes = [
      {
        'name': 'Espresso', 
        'image': 'lib/assets/expresso.png',
        'description': 'Strong concentrated coffee',
        'price': '\$3.50'
      },
      {
        'name': 'Cappuccino', 
        'image': 'lib/assets/cappuccino.png',
        'description': 'Espresso with steamed milk foam',
        'price': '\$4.50'
      },
      {
        'name': 'Latte', 
        'image': 'lib/assets/latte.png',
        'description': 'Espresso with a lot of steamed milk',
        'price': '\$4.00'
      },
      {
        'name': 'Americano', 
        'image': 'lib/assets/coffee.png',
        'description': 'Espresso with hot water',
        'price': '\$3.00'
      },
      {
        'name': 'Mocha', 
        'image': 'lib/assets/mocha.png',
        'description': 'Chocolate-flavored latte',
        'price': '\$4.75'
      },
    ];

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Coffee Varieties',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: coffeeTypes.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => onCoffeeSelected(coffeeTypes[index]),
                  child: Card(
                    margin: const EdgeInsets.only(bottom: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(12),
                          ),
                          child: Image.asset(
                            coffeeTypes[index]['image']!,
                            height: 150,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            coffeeTypes[index]['name']!,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CoffeeShopsPage extends StatefulWidget {
  final Function(Map<String, dynamic>) onShopSelected;

  const CoffeeShopsPage({super.key, required this.onShopSelected});

  @override
  State<CoffeeShopsPage> createState() => _CoffeeShopsPageState();
}

class _CoffeeShopsPageState extends State<CoffeeShopsPage> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _filteredShops = [];
  final List<Map<String, dynamic>> _allShops = [
    {
      'name': 'Brew Haven',
      'image': 'lib/assets/coffee-shop1.png',
      'address': '123 Coffee St, Beanville',
      'phone': '(555) 123-4567',
      'hours': 'Mon-Fri: 7am-7pm\nSat-Sun: 8am-6pm',
      'description': 'Artisanal coffee shop specializing in single-origin beans',
      'rating': 4.8
    },
    {
      'name': 'Bean Dream',
      'image': 'lib/assets/coffee-shop2.png',
      'address': '456 Espresso Ave, Coffeetown',
      'phone': '(555) 987-6543',
      'hours': 'Daily: 6am-8pm',
      'description': 'Cozy neighborhood cafe with homemade pastries',
      'rating': 4.5
    },
    {
      'name': 'Roast & Toast',
      'image': 'lib/assets/coffee-shop3.png',
      'address': '789 Latte Lane, Brew City',
      'phone': '(555) 456-7890',
      'hours': 'Mon-Sat: 6:30am-6pm\nSun: 7am-5pm',
      'description': 'Local roaster with fresh beans daily',
      'rating': 4.7
    },
    {
      'name': 'Caffeine Fix',
      'image': 'lib/assets/coffee-shop4.png',
      'address': '101 Mocha Blvd, Java Town',
      'phone': '(555) 789-0123',
      'hours': 'Open 24/7',
      'description': 'Always open for your coffee needs',
      'rating': 4.3
    },
  ];

  @override
  void initState() {
    super.initState();
    _filteredShops = _allShops;
    _searchController.addListener(_filterShops);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterShops() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredShops = _allShops.where((shop) {
        return shop['name'].toString().toLowerCase().contains(query) ||
            shop['address'].toString().toLowerCase().contains(query) ||
            shop['description'].toString().toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search coffee shops...',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    suffixIcon: _searchController.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              _searchController.clear();
                              _filterShops();
                            },
                          )
                        : null,
                  ),
                  onChanged: (value) => _filterShops(),
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                icon: const Icon(Icons.mic),
                onPressed: () {
                  // Implement voice search here if needed
                },
                style: IconButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 143, 97, 6),
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: _filteredShops.isEmpty
                ? const Center(
                    child: Text(
                      'No shops found',
                      style: TextStyle(fontSize: 16),
                    ),
                  )
                : GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 0.75,
                    ),
                    itemCount: _filteredShops.length,
                    itemBuilder: (context, index) {
                      final shop = _filteredShops[index];
                      return GestureDetector(
                        onTap: () => widget.onShopSelected(shop),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(12),
                                ),
                                child: Image.asset(
                                  shop['image'] as String,
                                  height: 120,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      Container(
                                        color: Colors.grey[200],
                                        child: const Center(
                                            child: Icon(Icons.store)),
                                      ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      shop['name'] as String,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        const Icon(Icons.star,
                                            size: 16, color: Colors.amber),
                                        const SizedBox(width: 4),
                                        Text(shop['rating'].toString()),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}