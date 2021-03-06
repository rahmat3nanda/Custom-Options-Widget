import 'package:custom_options/model/app/option_value_model.dart';
import 'package:flutter/material.dart';

class OptionWidget extends StatefulWidget {
  final Color textColor;
  final Color selectedColor;
  final Color unselectedColor;
  final dynamic groupValue;
  final List<OptionValueModel> items;
  final Axis scrollDirection;
  final Function(dynamic asd) onChanged;

  OptionWidget({
    @required this.textColor,
    @required this.selectedColor,
    @required this.unselectedColor,
    @required this.groupValue,
    @required this.items,
    this.scrollDirection = Axis.horizontal,
    this.onChanged,
  });

  @override
  _OptionWidgetState createState() => _OptionWidgetState();
}

class _OptionWidgetState extends State<OptionWidget> {
  dynamic _groupValue;

  @override
  void initState() {
    super.initState();
    _groupValue = widget.groupValue;
  }

  void _onItemSelected(dynamic value) {
    setState(() {
      _groupValue = value;
    });
    widget.onChanged(value);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.scrollDirection == Axis.horizontal)
      return SizedBox(
        height: 42.0,
        child: _buildItems(),
      );
    else
      return _buildItems();
  }

  Widget _buildItems() {
    return ListView.builder(
      shrinkWrap: true,
      physics: widget.scrollDirection == Axis.vertical
          ? const NeverScrollableScrollPhysics()
          : const ClampingScrollPhysics(),
      scrollDirection: widget.scrollDirection,
      itemCount: widget.items.length,
      itemBuilder: (context, index) {
        OptionValueModel o = widget.items[index];
        return InkWell(
          child: Container(
            margin: const EdgeInsets.all(4.0),
            padding: const EdgeInsets.symmetric(
              vertical: 8.0,
              horizontal: 16.0,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(16.0)),
              color: _groupValue == o.value
                  ? widget.selectedColor
                  : widget.unselectedColor,
            ),
            child: Center(
              child: Text(
                "${o.title}",
                style: TextStyle(color: widget.textColor),
              ),
            ),
          ),
          onTap: () => _onItemSelected(o.value),
        );
      },
    );
  }
}
