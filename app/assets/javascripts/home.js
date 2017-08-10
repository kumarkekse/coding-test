$(document).on('dp.change','#weeklyDatePicker', function(e) {
  var firstDate, lastDate, value;
  value = $('#weeklyDatePicker').val();
  firstDate = moment(value, 'DD-MMM-YYYY').day(0).format('DD-MMM-YYYY');
  lastDate = moment(value, 'DD-MMM-YYYY').day(6).format('DD-MMM-YYYY');
  $('#weeklyDatePicker').val(firstDate + ' - ' + lastDate);
  $("form").submit();
});