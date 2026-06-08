// REGISTER
function register() {
    let username = document.getElementById("username").value;
    let password = document.getElementById("password").value;

    let users = JSON.parse(localStorage.getItem("users")) || [];

    users.push({ username, password });

    localStorage.setItem("users", JSON.stringify(users));

    document.getElementById("msg").innerText = "Registrazione completata";
}

// LOGIN
function login() {
    let username = document.getElementById("username").value;
    let password = document.getElementById("password").value;

    let users = JSON.parse(localStorage.getItem("users")) || [];

    let user = users.find(u => u.username === username && u.password === password);

    if (user) {
        localStorage.setItem("loggedUser", username);
        window.location.href = "dashboard.html";
    } else {
        document.getElementById("msg").innerText = "Login fallito";
    }
}

// RACE
function race() {
    let position = Math.floor(Math.random() * 20) + 1;
    let prize = (21 - position) * 10000;

    localStorage.setItem("lastRace", JSON.stringify({ position, prize }));

    window.location.href = "race.html";
}

// SHOW RESULT (solo race.html)
if (window.location.pathname.includes("race.html")) {
    let data = JSON.parse(localStorage.getItem("lastRace"));

    if (data) {
        document.getElementById("result").innerHTML =
            "Posizione: " + data.position +
            "<br>Premio: €" + data.prize;
    }
}
