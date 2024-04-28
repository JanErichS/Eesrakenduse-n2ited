// Used: Anime.js, jQuery, Masonry
// Images taken from: Yotube Music, SvgRepo or freepik.
// Website made by: Jan-Erich

// List of color gradients.
const colorGradients = [
	{ colors: ["#ff0000", "#ffcc00"] },
	{ colors: ["#0099ff", "#66ffcc"] },
	{ colors: ["#ff3399", "#ff9933"] },
	{ colors: ["#ff6699", "#ffcc00"] },
	{ colors: ["#3399ff", "#ff99cc"] },
	{ colors: ["#ff6600", "#ffff00"] },
	{ colors: ["#ff3366", "#ffff00"] },
	{ colors: ["#003399", "#66ff33"] },
	{ colors: ["#ff9933", "#ffcc99"] },
	{ colors: ["#ff6633", "#ffcc66"] },
	{ colors: ["#0066ff", "#ffcc00"] },
	{ colors: ["#ff3399", "#ff9966"] },
	{ colors: ["#ff3366", "#ffcc33"] },
	{ colors: ["#0099ff", "#ff99cc"] },
	{ colors: ["#ff6600", "#ffcc00"] },
	{ colors: ["#ff3366", "#ffcc00"] },
	{ colors: ["#0099cc", "#ffcc66"] },
	{ colors: ["#ff6600", "#ffcc00"] },
	{ colors: ["#ff3333", "#ffff66"] },
	{ colors: ["#0066cc", "#ffcc00"] },
	{ colors: ["#ff3399", "#ff9966"] },
	{ colors: ["#ff3366", "#ffcc99"] },
	{ colors: ["#0099ff", "#ff99cc"] },
	{ colors: ["#ff6600", "#ffcc00"] },
	{ colors: ["#ff3366", "#ffcc00"] },
	{ colors: ["#0066cc", "#ffcc99"] },
	{ colors: ["#ff6600", "#ffcc00"] },
	{ colors: ["#ff3333", "#ffcc00"] },
	{ colors: ["#003399", "#66ff33"] },
	{ colors: ["#ff6633", "#ffcc66"] },
	{ colors: ["#ff3366", "#ffcc33"] },
	{ colors: ["#0066cc", "#ffcc99"] },
	{ colors: ["#ff6600", "#ffcc00"] },
	{ colors: ["#ff3366", "#ffcc00"] },
	{ colors: ["#0099cc", "#ffcc66"] },
	{ colors: ["#ff6600", "#ffcc00"] },
	{ colors: ["#ff3333", "#ffcc00"] },
	{ colors: ["#003399", "#66ff33"] },
	{ colors: ["#ff6633", "#ffcc66"] },
	{ colors: ["#ff3366", "#ffcc33"] },
	{ colors: ["#0066cc", "#ffcc99"] },
	{ colors: ["#ff6600", "#ffcc00"] },
	{ colors: ["#ff3366", "#ffcc00"] },
	{ colors: ["#0099cc", "#ffcc66"] },
	{ colors: ["#ff6600", "#ffcc00"] },
	{ colors: ["#ff3333", "#ffcc00"] },
	{ colors: ["#003399", "#66ff33"] },
	{ colors: ["#ff6633", "#ffcc66"] },
	{ colors: ["#ff3366", "#ffcc33"] },
];
const gradientsLen = colorGradients.length;
let gradient;
let contactSectionId = "contact";

jQuery(function () {
	// Initializes the fullpage.js
	new fullpage("#fullpage", {
		sectionsColor: ["#ffffff", "#ffffff", "#ffffff"],
		navigation: true,
		lazyload: true,
		navigationPosition: "right",
		navigationTooltips: [
			"Oskused",
			"Kood",
			"Minu hobid",
			"Muusika",
			"Mäng",
			"Kontakt",
		],

		// Adds an gradient to the section
		onLeave: function (origin, destination, direction) {
			if ($(destination.item).hasClass("gradient")) {
				let gradient = randomGradientGen();
				$(destination.item).css({
					background:
						"linear-gradient(to right, " +
						gradient.colors[0] +
						", " +
						gradient.colors[1] +
						")",
				});
				// Adds an gradient to the menu
				$(".menu-gradient").css({
					background:
						"linear-gradient(to right, " +
						gradient.colors[0] +
						", " +
						gradient.colors[1] +
						")",
				});
			}
		},
		// Removes the gradient on leave
		afterLoad: function (origin, destination, direction) {
			if ($(origin.item).hasClass("gradient")) {
				$(origin.item).find(".gradient").removeClass("animate-gradient");
			}

			// Animates the contact elements
			if (destination.item.id === contactSectionId) {
				animateContact();
			}
			fullpage_api.setAllowScrolling(true);
		},
	});

	// Menu
	$(".menu-icon").on("click", () => {
		$("#menu").toggle();
	});

	// Because the anchor attribute broke this website, I have to create them manually.
	$(".menu-item").on("click", function () {
		let sectionId = $(this).attr("href");
		if (sectionId.charAt(0) === "#") {
			sectionId = sectionId.slice(1);
		}
		let index = $('#fullpage [data-anchor="' + sectionId + '"]').index();
		if (index !== -1) {
			fullpage_api.moveTo(index + 1);
			$("#menu").toggle();
		}
	});

	$(document).ready(function () {
		$(".grid").each(function (index, grid) {
			var $grid = $(grid);
			$grid.imagesLoaded(function () {
				$grid.masonry({
					itemSelector: ".grid-item",
					columnWidth: ".grid-sizer",
					gutter: 20,
				});
			});
		});
	});

	// Image grid (Masonry)
	$(".grid-example").click(function () {
		var language = $(this).data("language");
		var repos = {
			python:
				"https://github.com/JanErichS/Eesrakenduse-n2ited/blob/main/Python/Programm.py",
			"robot-framework":
				"https://github.com/JanErichS/Eesrakenduse-n2ited/blob/main/RobotFramework/main.robot",
			java: "https://github.com/JanErichS/Eesrakenduse-n2ited/blob/main/Java/",
			web: "https://github.com/JanErichS/Eesrakenduse-n2ited/blob/main/Web/",
		};
		window.open(repos[language], "_blank");
	});
});

// Generates a random gradient for the sections
function randomGradientGen() {
	let randomNum = Math.floor(Math.random() * gradientsLen);
	console.log(colorGradients[randomNum]);
	return colorGradients[randomNum];
}

// Animates the last (contact) sections elements
function animateContact() {
	anime
		.timeline({
			easing: "easeOutExpo",
		})
		.add({
			targets: ".header",
			translateY: [-100, 0],
			opacity: [0, 1],
			duration: 500,
		})
		.add({
			targets: ".contact-info",
			translateY: [100, 0],
			opacity: [0, 1],
			duration: 500,
			offset: "-=500",
		});
}
