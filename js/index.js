const divError = document.getElementById("divError");
const inputDecimal = document.getElementById("decimal");
const btnConversion = document.getElementById("btnConversion");

btnConversion.addEventListener("click", () => {
  try {
    const result = grammar.parse(document.getElementById("binario").value);
    inputDecimal.value = result;
    divError.innerText = "";
  } catch (error) {
    divError.innerHTML = error;
    console.log(error);
  }
});
