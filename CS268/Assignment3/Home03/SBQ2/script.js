window.onload = () => {
  const table = document.getElementById("employeeTable");
  fetch("employee.json").then((response) => {
    response.json().then((json) => {
      //Headers 
      var header = table.createTHead();
      let hrow = header.insertRow(0);
      Object.keys(json.Employees[0])?.forEach((key) => {
        var cell = hrow.insertCell(-1);
        cell.innerHTML = `<b>${key}</b>`;
      });

      //Body
      var body = table.createTBody();
      json.Employees.forEach((employee) => {
        let hrow = body.insertRow(0);
      Object.values(employee).forEach((value) => {
        var cell = hrow.insertCell(-1);
        cell.innerHTML = `${value}`;
      });
      });

    })
  })
};
