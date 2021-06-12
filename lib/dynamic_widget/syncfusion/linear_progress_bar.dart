import 'package:dynamic_widget/dynamic_widget.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

part 'linear_progress_bar.g.dart';

class LabeledProgressBar extends StatelessWidget {
  final LabeledProgressBarModel model;

  const LabeledProgressBar({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SfLinearGauge(
      minimum: model.minValue,
      maximum: model.maxValue,
      interval: model.interval,
      onGenerateLabels: () => model.labels
          .map((l) => LinearAxisLabel(text: l.text, value: l.value))
          .toList(),
      showLabels: model.showLabels,
      showTicks: model.showTicks,
      labelOffset: model.labelOffset,
      barPointers: [
        LinearBarPointer(
          value: model.value,
          color: Colors.green,
          enableAnimation: false,
          position: LinearElementPosition.cross,
        ),
      ],
      markerPointers: _buildMarkers(),
    );
  }

  List<LinearMarkerPointer> _buildMarkers() {
    var widgets = <LinearMarkerPointer>[];
    for (var i = model.minValue; i <= model.maxValue; i += model.interval) {
      if (i <= model.value) {
        widgets.add(_buildSelectedMarker(i));
      } else {
        widgets.add(_buildUnselectedMarker(i));
      }
    }
    return widgets;
  }

  LinearMarkerPointer _buildSelectedMarker(double value) {
    return LinearWidgetPointer(
      value: value,
      enableAnimation: false,
      position: LinearElementPosition.cross,
      child: Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(width: 4, color: Colors.green),
            borderRadius: BorderRadius.all(Radius.circular(12))),
        child: Center(
          child: Icon(Icons.check_rounded, size: 14, color: Colors.green),
        ),
      ),
    );
  }

  LinearMarkerPointer _buildUnselectedMarker(double value) {
    return LinearShapePointer(
      value: value,
      enableAnimation: false,
      color: Colors.grey,
      width: 24,
      height: 24,
      position: LinearElementPosition.cross,
      shapeType: LinearShapePointerType.circle,
    );
  }
}

class LabeledProgressBarParser extends WidgetParser {
  @override
  Map<String, dynamic>? export(Widget? widget, BuildContext? buildContext) {
    if (widget == null || !(widget is LabeledProgressBar)) {
      return null;
    }
    return widget.model.toJson();
  }

  @override
  Widget parse(Map<String, dynamic> map, BuildContext buildContext,
      ClickListener? listener) {
    try {
      var model = LabeledProgressBarModel.fromJson(map);
      return LabeledProgressBar(model: model);
    } catch (e) {
      return Text('Unable to parse dynamic widget $e');
    }
  }

  @override
  String get widgetName => 'LabeledProgressBar';

  @override
  // TODO: implement widgetType
  Type get widgetType => LabeledProgressBar;
}

@JsonSerializable()
class LabeledProgressBarModel {
  @JsonKey(defaultValue: 0)
  final double minValue;
  @JsonKey(defaultValue: 100)
  final double maxValue;
  @JsonKey(defaultValue: 1)
  final double interval;
  @JsonKey(defaultValue: 24)
  final double labelOffset;
  @JsonKey(defaultValue: [])
  final List<ProgressBarLabel> labels;
  @JsonKey(defaultValue: true)
  final bool showLabels;
  @JsonKey(defaultValue: true)
  final bool showTicks;
  @JsonKey(defaultValue: 0)
  final double value;

  LabeledProgressBarModel(
    this.minValue,
    this.maxValue,
    this.interval,
    this.labelOffset,
    this.labels,
    this.showLabels,
    this.showTicks,
    this.value,
  );

  factory LabeledProgressBarModel.fromJson(json) =>
      _$LabeledProgressBarModelFromJson(json);

  Map<String, dynamic> toJson() => _$LabeledProgressBarModelToJson(this);
}

@JsonSerializable()
class ProgressBarLabel {
  @JsonKey(defaultValue: '')
  final String text;
  @JsonKey(defaultValue: 0)
  final double value;

  ProgressBarLabel(this.text, this.value);

  factory ProgressBarLabel.fromJson(json) => _$ProgressBarLabelFromJson(json);

  Map<String, dynamic> toJson() => _$ProgressBarLabelToJson(this);
}
