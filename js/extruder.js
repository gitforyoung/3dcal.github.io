const calculate_button = document.querySelector("button");
console.log(calculate_button);

var fila_dia = document.getElementById("fila_dia").value;
var line_width = document.getElementById("line_width").value;
var layer_height = document.getElementById("layer_height").value;
var print_speed = document.getElementById("print_speed").value;

function getValue() {
  fila_dia = document.getElementById("fila_dia").value;
  line_width = document.getElementById("line_width").value;
  layer_height = document.getElementById("layer_height").value;
  print_speed = document.getElementById("print_speed").value;
}

function handleButtonClick(event) {
  console.log("handleButtonClick");
  event.preventDefault();
  getValue();
  calculate();
}

function calculate() {
  const flow_rate = print_speed * line_width * layer_height;
  const transfer_speed = (4 * flow_rate) / (fila_dia * fila_dia * Math.PI);

  console.log(flow_rate);
  console.log(transfer_speed);

  document.getElementById("volume_rate").innerText = flow_rate.toFixed(1);
  document.getElementById("transfer_speed").innerText = transfer_speed.toFixed(
    1
  );
}
console.log("ready");

calculate_button.addEventListener("click", handleButtonClick);
