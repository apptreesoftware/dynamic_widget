// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'linear_progress_bar.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LabeledProgressBarModel _$LabeledProgressBarModelFromJson(
    Map<String, dynamic> json) {
  return LabeledProgressBarModel(
    (json['minValue'] as num?)?.toDouble() ?? 0,
    (json['maxValue'] as num?)?.toDouble() ?? 100,
    (json['interval'] as num?)?.toDouble() ?? 1,
    (json['labelOffset'] as num?)?.toDouble() ?? 24,
    (json['labels'] as List<dynamic>?)
            ?.map((e) => ProgressBarLabel.fromJson(e))
            .toList() ??
        [],
    json['showLabels'] as bool? ?? true,
    json['showTicks'] as bool? ?? true,
    (json['value'] as num?)?.toDouble() ?? 0,
  );
}

Map<String, dynamic> _$LabeledProgressBarModelToJson(
        LabeledProgressBarModel instance) =>
    <String, dynamic>{
      'minValue': instance.minValue,
      'maxValue': instance.maxValue,
      'interval': instance.interval,
      'labelOffset': instance.labelOffset,
      'labels': instance.labels,
      'showLabels': instance.showLabels,
      'showTicks': instance.showTicks,
      'value': instance.value,
    };

ProgressBarLabel _$ProgressBarLabelFromJson(Map<String, dynamic> json) {
  return ProgressBarLabel(
    json['text'] as String? ?? '',
    (json['value'] as num?)?.toDouble() ?? 0,
  );
}

Map<String, dynamic> _$ProgressBarLabelToJson(ProgressBarLabel instance) =>
    <String, dynamic>{
      'text': instance.text,
      'value': instance.value,
    };
