const calculate_button = document.querySelector("button");
var selected_output1;
var selected_output2;
var selected;

var fila_dia = document.getElementById("fila_dia").value;
var line_width = document.getElementById("line_width").value;
var layer_height = document.getElementById("layer_height").value;
var selected_input = document.getElementById("selected_input").value;
var radio1 = document.getElementById("select1");
var radio2 = document.getElementById("select2");
var radio3 = document.getElementById("select3");

function getValue() {
  fila_dia = document.getElementById("fila_dia").value;
  line_width = document.getElementById("line_width").value;
  layer_height = document.getElementById("layer_height").value;
  selected_input = document.getElementById("selected_input").value;
  radio1 = document.getElementById("select1");
  radio2 = document.getElementById("select2");
  radio3 = document.getElementById("select3");
}

function handleButtonClick(event) {
  console.log("handleButtonClick");
  event.preventDefault();
  getValue();
  if (radio1.checked) {
    fromPrintSpeed();
  } else if (radio2.checked) {
    fromVolumeRate();
  } else if (radio3.checked) {
    fromTransferSpeed();
  }
}

function fromPrintSpeed() {
  selected_output1 = selected_input * line_width * layer_height;
  selected_output2 = (4 * selected_output1) / (fila_dia * fila_dia * Math.PI);
  printResult();
}

function fromVolumeRate() {
  selected_output1 = selected_input / (line_width * layer_height);
  selected_output2 = (4 * selected_input) / (fila_dia * fila_dia * Math.PI);
  printResult();
}

function fromTransferSpeed() {
  selected_output1 =
    (selected_input * fila_dia * fila_dia * Math.PI) /
    (4 * line_width * layer_height);
  selected_output2 = (selected_input * fila_dia * fila_dia * Math.PI) / 4;
  printResult();
}

function printResult() {
  document.getElementById(
    "selected_output1"
  ).innerText = selected_output1.toFixed(1);
  document.getElementById(
    "selected_output2"
  ).innerText = selected_output2.toFixed(1);
}
console.log("ready");

calculate_button.addEventListener("click", handleButtonClick);
document.querySelectorAll('input[name="select"]').forEach((elem) => {
  elem.addEventListener("change", function (event) {
    selected = event.target.value;
    resetOutput();
    changeText();
  });
});

function resetOutput() {
  document.getElementById("selected_output1").innerText = "0";
  document.getElementById("selected_output2").innerText = "0";
}

function changeText() {
  if (selected === "select1") {
    document.getElementById("selected_inputLabel").innerText = "Print Speed";
    document.getElementById("selected_outputLabel1").innerText = "Volume Rate";
    document.getElementById("selected_outputLabel2").innerText =
      "Transfer Speed";
    document.getElementById("selected_inputUnit").innerText = "mm/s";
    document.getElementById("selected_outputUnit1").innerHTML =
      "mm<sup>3</sup>/s";
    document.getElementById("selected_outputUnit2").innerText = "mm/s";
  } else if (selected === "select2") {
    document.getElementById("selected_inputLabel").innerText = "Volume Rate";
    document.getElementById("selected_outputLabel1").innerText = "Print Speed";
    document.getElementById("selected_outputLabel2").innerText =
      "Transfer Speed";
    document.getElementById("selected_inputUnit").innerHTML =
      "mm<sup>3</sup>/s";
    document.getElementById("selected_outputUnit1").innerText = "mm/s";
    document.getElementById("selected_outputUnit2").innerText = "mm/s";
  } else if (selected === "select3") {
    document.getElementById("selected_inputLabel").innerText = "Transfer Speed";
    document.getElementById("selected_outputLabel1").innerText = "Volume Rate";
    document.getElementById("selected_outputLabel2").innerText = "Print Speed";
    document.getElementById("selected_inputUnit").innerText = "mm/s";
    document.getElementById("selected_outputUnit1").innerHTML =
      "mm<sup>3</sup>/s";
    document.getElementById("selected_outputUnit2").innerText = "mm/s";
  }
  console.log(document.getElementById("selected_inputLabel").innerText);
}
