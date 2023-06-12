CREATE DATABASE universe;
\c universe;
CREATE TABLE galaxy (
	galaxy_id SERIAL PRIMARY KEY,
	name VARCHAR(50) UNIQUE,
	description TEXT NOT NULL,
    is_spiral BOOLEAN NOT NULL,
    is_elliptical BOOLEAN NOT NULL,
    discovery_date INT,
    distance_from_earth_in_light_years NUMERIC(8,0)
);
CREATE TABLE star (
	star_id SERIAL PRIMARY KEY,
    galaxy_id INT,
	name VARCHAR(50) UNIQUE,
	description VARCHAR(300) NOT NULL,
	temperature_in_k INT NOT NULL,
	discovery_date INT,
    CONSTRAINT fk_galaxy
    FOREIGN KEY(galaxy_id) 
	REFERENCES galaxy(galaxy_id)
);

CREATE TABLE planet (
	planet_id SERIAL PRIMARY KEY,
    star_id INT,
	name VARCHAR(50) UNIQUE,
	description VARCHAR(300) NOT NULL,
    has_life BOOLEAN NOT NULL,
	discovery_date INT,
	n_of_moons INT,
    CONSTRAINT fk_star
    FOREIGN KEY(star_id) 
	REFERENCES star(star_id)
);


CREATE TABLE moon (
	moon_id SERIAL PRIMARY KEY,
    planet_id INT,
	name VARCHAR(50) UNIQUE,
	description VARCHAR(300) NOT NULL,
	discovery_date INT NOT NULL,
    orbital_period_in_days INT,
    CONSTRAINT fk_planet
    FOREIGN KEY(planet_id) 
	REFERENCES planet(planet_id)
); 
CREATE TABLE people (
 people_id SERIAL PRIMARY KEY,
 planet_id INT,
 name VARCHAR(50) UNIQUE,
 age NUMERIC(2) NOT NULL,
 country VARCHAR(50) NOT NULL,
 CONSTRAINT fk_planet
 FOREIGN KEY(planet_id) 
 REFERENCES planet(planet_id)
);

INSERT INTO galaxy(
	name,
	description,
    is_spiral,
    is_elliptical,
    discovery_date,
    distance_from_earth_in_light_years)
VALUES('Milky Way','galaxy that includes the Solar System, with the name describing the galaxys appearance from Earth: a hazy band of light seen in the night sky formed from stars that cannot be individually distinguished by the naked eye.', true, false, 1609, NULL),
('Andromeda','is the closest major galaxy to the Milky Way, where the Solar System resides. It was originally named the Andromeda Nebula and is cataloged as Messier 31, M31, and NGC 224.', true, false,NULL, 2537000),
('Triangulum Galaxy','It is sometimes informally referred to as the "Pinwheel Galaxy" by some astronomy references,is the third-largest member of the Local Group of galaxies, behind the Andromeda Galaxy and the Milky Way.', true, false, 1654, 2723000),
('M89(NGC 4552)','E0 type elliptical galaxy', false, true, 1781, 60000000),
('M105 (NGC 3379)','E1 type elliptical galaxy,It is the brightest elliptical galaxy in the Leo I group.', false, true, 1781, 38000000),
('M64 (NGC 628)','Sc-type spiral galaxy,Hailed by many as the "perfect spiral galaxy".', true, false, 1779, 35000000); 

INSERT INTO star(
    galaxy_id,
	name,
	description,
	temperature_in_k,
	discovery_date) 
VALUES(1,'Sun','is the star at the center of the Solar System. It is a nearly perfect ball of hot plasma,heated to incandescence by nuclear fusion reactions in its core.', 5772, 450),
(1,'Proxima Centauri', 'It was discovered by Robert Innes and is the nearest-known star to the Sun.', 2670, 1915),
(2, 'Upsilon Andromedae', 'is a binary star located Earth in the constellation of Andromeda.four extrasolar planets (designated Upsilon Andromedae b, c, d and e; the first three named Saffar, Samh and Majriti, respectively) are believed to orbit υ Andromedae', 6107, 2010),
(4, '61 Virginis', ' is the Flamsteed designation of a G-type main-sequence star (G7V) slightly less massive than the Sun (which has a hotter G2V spectral type)', 5538, 2009),
(5, '88 LeonisA','is a cool orange subgiant star',5509, 2005),
(5, '88 LeonisB','is an orange dwarf star.', 4740, 2005); 

INSERT INTO planet(
    star_id,
	name,
	description,
    has_life,
	discovery_date,
	n_of_moons
    )
    VALUES(1,'Earth','is the third planet from the Sun and the only place known in the universe where life has originated and found habitability.', true, NULL, 1),
(1,'Mars','is the fourth planet and the furthest terrestrial planet from the Sun. The reddish color of its surface is due to finely grained iron(III) oxide dust in the soil, giving it the nickname "the Red Planet".', false, 1610, 2),
(1,'Neptune','is the eighth planet from the Sun and the farthest known planet in the Solar System. It is the fourth-largest planet in the Solar System by diameter, the third-most-massive planet, and the densest giant planet.', false, 1846, 14),
(1,'Mercury',' is the first planet from the Sun and the smallest planet in the Solar System. It is a terrestrial planet with a heavily cratered surface due to the planet having no geological activity and an extremely tenuous atmosphere (called an exosphere).', false, 1631, NULL),
(1,'Uranus','is the seventh planet from the Sun and is a gaseous cyan ice giant. Most of Uranus is made out of water, ammonia, and methane in a supercritical phase of matter, which in astronomy is called "ice" or volatiles', false, 1781, 27),
(1,'Saturn',' is the sixth planet from the Sun and the second-largest in the Solar System, after Jupiter. It is a gas giant with an average radius of about nine and a half times that of Earth.', false, 1610, 146),
(1,'Venus','is the second planet from the Sun. It is a rocky planet with the thickest atmosphere of all the rocky bodies in the Solar System, and the only one with a mass and size that is close to that of its orbital neighbour Earth.', false, 1962,NULL),
(3,'Upsilon Andromedae b', 'it was one of the first hot Jupiters to be discovered. It is also one of the first non-resolved planets to be detected directly. Upsilon Andromedae b is the innermost-known planet in its planetary system.', false, 1996, NULL),
(3,'Upsilon Andromedae c','formally named Samh /ˈsɑːm/ (a homophone with the star Salm), is an extrasolar planet orbiting the Sun-like star Upsilon Andromedae A every 241.3 days at an average distance of 0.83 AU', false, 1999,NULL),
(3,'Upsilon Andromedae d','formally named Majriti /mædʒˈraɪti/, is a super-Jupiter exoplanet orbiting within the habitable zone of the Sun-like star Upsilon Andromedae A',
false,1999, NULL),
(4,'61 Virginis b','s a Neptune-like exoplanet that orbits a G-type star. Its mass is 5.1 Earths, it takes 4.2 days to complete one orbit of its star', false, 2009, NULL),
(4,'61 Virginis c','is a Neptune-like exoplanet that orbits a G-type star. Its mass is 18.2 Earths, it takes 38 days to complete one orbit of its star, and is 0.2175 AU', false, 2009, NULL);

INSERT INTO moon(
    planet_id,
	name,
	description,
	discovery_date,
    orbital_period_in_days)
VALUES(1,'moon','is Earths only natural satellite.',1609, 27),
(2,'Fobos',' is the innermost and larger of the two natural satellites of Mars.', 1877, 0.33),
(2,'Deimos','is the smaller and outermost of the two natural satellites of Mars', 1877, 1.25),
(3,'Triton','is the largest natural satellite of the planet Neptune, and was the first Neptunian moon to be discovered',1846, 5.16),
(3,'Thalassa',' also known as Neptune IV, is the second-innermost satellite of Neptune. Thalassa was named after sea goddess Thalassa, a daughter of Aether and Hemera from Greek mythology. "Thalassa" is also the Greek word for "sea".', 1989, 0.29),
(3,'Hippocamp',' also designated Neptune XIV, is a small moon of Neptune', 2013, 0.95),
(3,'Nereid', 'Nereid, or Neptune II, is the third-largest moon of Neptune. It has the most eccentric orbit of all known moons in the Solar System.', 1949, 360),
(3,'Galatea','Galatea /ɡælətiːə/, also known as Neptune VI, is the fourth-closest inner moon of Neptune. It is named after Galatea, one of the fifty Nereids of Greek legend, with whom Cyclops Polyphemus was vainly in love.', 1989, 0.41),
(3,'Despoina','Despina /dɛspaɪnə/, also known as Neptune V, is the third-closest inner moon of Neptune. It is named after Greek mythological character Despoina, a nymph who was a daughter of Poseidon and Demeter.', 1989, 0.33),
(3,'Neso', 'Neso /niːsoʊ/, also known as Neptune XIII, is the outermost known natural satellite of Neptune. It is a retrograde irregular moon discovered by Matthew J. Holman, Brett J. Gladman, et al.', 2002, 9855),
(3,'Naiad','Naiad /neɪəd/, (also known as Neptune III and previously designated as S/1989 N 6) named after the naiads of Greek legend,[11] is the innermost satellite of Neptune and the nearest to the center of any gas giant with moons.', 1989, 0.29),
(3,'Halimede', '/hæləmiːdiː/ or Neptune IX, is a retrograde irregular satellite of Neptune. It was discovered by Matthew J. Holman\, John J. Kavelaars\, Tommy Grav\, Wesley C. Fraser and Dan Milisavljevic',2002,1879),
(3,'Psamathe', 'Psamathe /sæməθiː/, also known as Neptune X, is a retrograde irregular satellite of Neptune. It is named after Psamathe, one of the Nereids. Psamathe was discovered by Scott S. Sheppard and David C. Jewitt in 2003 using the 8.2 meter Subaru telescope.', 2003, 9128),
(3,'Laomedeia','is a prograde irregular satellite of Neptune. It was discovered by Matthew J. Holman, et al.', 2002, 3171),
(3,'Proteus', 'also known as Neptune VIII, is the second-largest Neptunian moon, and Neptunes largest inner satellite. Discovered by Voyager 2 spacecraft', 1989, 1.12),
(3,'Larissa','also known as Neptune VII, is the fifth-closest inner satellite of Neptune. It is named after Larissa, a lover of Poseidon (Neptune) in Greek mythology and eponymous nymph of the city in Thessaly, Greece.', 1981, 0.55),
(3,'Sao','is a prograde irregular satellite of Neptune. It was discovered by Matthew J. Holman et al.', 2002, 2912),
(4,'Titania','also designated Uranus III, is the largest of the moons of Uranus and the eighth largest moon in the Solar System at a diameter of 1,578 kilometres (981 mi), with a surface area comparable to that of Australia.', 1787, 8.7),
(4,'Miranda','also designated Uranus V, is the smallest and innermost of Uranus s five round satellites. It was discovered by Gerard Kuiper', 1948, 1.41),
(4,'Oberon', 'also designated Uranus IV, is the outermost major moon of the planet Uranus. It is the second-largest, with a surface area that is compareable to the area of Australia, and second most massive of the Uranian moons.', 1787, 13.46);

INSERT INTO people(
planet_id,
name,
age,
country)
VALUES(1, 'Kauã', 17, 'Brazil'),
(1,'Felipe', 19, 'Brazil'),
(1,'荒木 飛呂彦', 63,'Japan');


 



