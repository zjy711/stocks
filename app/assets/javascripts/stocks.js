$(document).ready(function() {
  var chart = createEmptyLineChart();

  $('#stock_id').on('change', function() {
    $('form#stock_prices').submit();
    return false;
  });

  $('form#stock_prices').on('ajax:success', function(event, data, status, xhr) {
    var response = $.parseJSON(xhr.responseText);
    var stock_name = response.stock_name;
    var dates = response.dates;
    var prices = response.prices;
    updateChart(chart, stock_name, dates, prices);
    return false;
  });

  $('form#stock_prices').submit();

  function createEmptyLineChart(){
    var emptyChart = new Chart($("#chart"), {
      type: 'line',
      data: {
        labels: [],
        datasets: [{
          label: "Empty Chart",
          data: [],
          fill: false,
          lineTension: 0.1,
          backgroundColor: "#FF6384",
          borderColor: "#FF6384",
          borderCapStyle: 'butt',
          borderJoinStyle: 'miter',
          pointBorderColor: "#4BC0C0",
          pointHoverBorderWidth: 2,
          pointRadius: 1,
          pointHitRadius: 10,
          responsive: false
        }]
      }
    })

    return emptyChart;
  }

  function updateChart(chart, stock_name, dates, prices){
    chart.data.labels = dates;
    chart.data.datasets[0].label = stock_name;
    chart.data.datasets[0].data = prices;
    chart.update();
    return chart;
  }
});