// Loonud Jan-Erich
// Kasutasin ChatGPT abi.

// Game objects
let rock = "Rock";
let paper = "Paper";
let scissors = "Scissors";
const choices = [rock, paper, scissors];

// Game objects in Estonian
let rockEstonian = "Kivi";
let paperEstonian = "Paber";
let scissorsEstonian = "Käärid";

// Players
let computerMove, playerMove;
let playerName;
let opponentName = "PC";

// Results
let playerWins = 0;
let pcWins = 0;
let result;
let message = "If you see this, something's gone wrong...";
let PcWinMessage = opponentName + " won!";
let tieMessage = "It's a tie!";
let playerWinMessage = playerName + " wins!";

function pcMove() {
	let choice;
	if ($("#language").text() === "Eng") {
		choice = choices[Math.floor(Math.random() * choices.length)];
	} else {
		choice = [rockEstonian, paperEstonian, scissorsEstonian][
			Math.floor(Math.random() * choices.length)
		];
	}
	$("#pcMove").text(choice);
	return choice;
}

function playerChoice() {
	// Takes the users choice
	$("#rock").on("click", () => play(rock));
	$("#paper").on("click", () => play(paper));
	$("#scissors").on("click", () => play(scissors));
}

function play(playerMove) {
	computerMove = pcMove();
	playerWinMessage = playerName + " wins!";
	result = findWinner(playerMove, computerMove);
	displayWinner(result);
}

function findWinner(player, computer) {
	if (player === computer) {
		message = tieMessage;
	} else if (
		(player === rock && computer === paper) ||
		(player === paper && computer === scissors) ||
		(player === scissors && computer === rock)
	) {
		message = PcWinMessage;
		pcWins++;
	} else {
		message = playerWinMessage;
		playerWins++;
	}

	return message;
}

function displayWinner(result) {
	// Update scoreboard text
	$("#scoreboard").text(
		playerName + ": " + playerWins + " | " + opponentName + ": " + pcWins
	);

	// Update result text
	$("#result").text(result);

	// Flash
	$("#game-container").removeClass("flash-win");

	if (result === playerWinMessage) {
		$("#game-container").addClass("flash-win");
	}

	setTimeout(function () {
		$("#game-container").removeClass("flash-win");
	}, 1000);
}

function changeLanguage() {
	if ($("#language").text() === "Eng") {
		// Win message + button
		$("#language").text("Est");
		PcWinMessage = opponentName + " võitis!";
		tieMessage = "Viik!";
		playerWinMessage = playerName + " võitis!";

		// Pc Moves
		rock = "Kivi";
		paper = "Paber";
		scissors = "Käärid";

		// Player buttons
		$("#rock").text(rock);
		$("#paper").text(paper);
		$("#scissors").text(scissors);
	} else {
		$("#language").text("Eng");
		PcWinMessage = opponentName + " won!";
		tieMessage = "It's a tie!";
		playerWinMessage = playerName + " wins!";
		rock = "Rock";
		paper = "Paper";
		scissors = "Scissors";

		// Player buttons
		$("#rock").text(rock);
		$("#paper").text(paper);
		$("#scissors").text(scissors);
	}
}

// Starts the game
$(document).ready(function () {
	$("#language").on("click", () => changeLanguage());

	// Show/hide input field on button click
	$("#name-change").on("click", () => {
		$("#name-change-input").toggle().focus();
		$("#notice").toggle();
	});

	// Handle input field submission
	$("#name-change-input").on("keypress", function (event) {
		if (event.which === 13) {
			// Check if Enter key is pressed
			let newName = $(this).val();
			playerName = newName;
			$(this).hide(); // Hide the input field
			$("#notice").toggle();
		}
	});

	playerChoice();
	displayWinner();
});
