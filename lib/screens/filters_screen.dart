import 'dart:ui';

import 'package:flutter/material.dart';
import '../models/filter.dart';

import '../widgets/drawer.dart';

class FilterScreen extends StatefulWidget {
  static const routeName = '/fliter';

  Filter filter;
  final void Function(Filter) _savefilter;
  FilterScreen(this.filter, this._savefilter);

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  var _isGlutenFree = false;
  var _isLactoseFree = false;
  var _isVegan = false;
  var _isVegetarian = false;

  @override
  initState() {
    _isGlutenFree = widget.filter.gluten;
    _isLactoseFree = widget.filter.lactose;
    _isVegan = widget.filter.vegan;
    _isVegetarian = widget.filter.vegetaian;
    super.initState();
  }

  Widget _buildSwitchListTile(
    String title,
    String discription,
    bool currentvalue,
    void Function(bool)? updateValue,
  ) {
    return SwitchListTile(
      title: Text(title),
      subtitle: Text(discription),
      value: currentvalue,
      onChanged: updateValue,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filter'),
        actions: [
          IconButton(
              onPressed: () {
                widget._savefilter(
                  Filter(
                    gluten: _isGlutenFree,
                    lactose: _isLactoseFree,
                    vegan: _isVegan,
                    vegetaian: _isVegetarian,
                  ),
                );
              },
              icon: Icon(Icons.save))
        ],
      ),
      drawer: const MainDrawer(),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            height: 100,
            child: Text(
              'Adjust Your Meals Selection.',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                _buildSwitchListTile(
                  'Gluten-Free',
                  'Display only non-gluten meals',
                  _isGlutenFree,
                  (bool newValue) {
                    setState(
                      () {
                        _isGlutenFree = newValue;
                      },
                    );
                  },
                ),
                _buildSwitchListTile(
                  'Lactose-Free',
                  'Display only non-actose meals',
                  _isLactoseFree,
                  (bool newValue) {
                    setState(
                      () {
                        _isLactoseFree = newValue;
                      },
                    );
                  },
                ),
                _buildSwitchListTile(
                  'Vegan',
                  'Display only vegan meals',
                  _isVegan,
                  (bool newValue) {
                    setState(
                      () {
                        _isVegan = newValue;
                      },
                    );
                  },
                ),
                _buildSwitchListTile(
                  'Vegetarian',
                  'Display only vegetarian meals',
                  _isVegetarian,
                  (bool newValue) {
                    setState(
                      () {
                        _isVegetarian = newValue;
                      },
                    );
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
