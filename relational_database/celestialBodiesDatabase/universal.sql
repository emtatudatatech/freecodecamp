--
-- PostgreSQL database dump
--

-- Dumped from database version 12.17 (Ubuntu 12.17-1.pgdg22.04+1)
-- Dumped by pg_dump version 12.17 (Ubuntu 12.17-1.pgdg22.04+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

DROP DATABASE universe;
--
-- Name: universe; Type: DATABASE; Schema: -; Owner: freecodecamp
--

CREATE DATABASE universe WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';


ALTER DATABASE universe OWNER TO freecodecamp;

\connect universe

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: galaxy; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.galaxy (
    galaxy_id integer NOT NULL,
    name character varying NOT NULL,
    description text,
    no_of_planets integer,
    distance_from_earth numeric
);


ALTER TABLE public.galaxy OWNER TO freecodecamp;

--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.galaxy_galaxy_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.galaxy_galaxy_id_seq OWNER TO freecodecamp;

--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.galaxy_galaxy_id_seq OWNED BY public.galaxy.galaxy_id;


--
-- Name: moon; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.moon (
    moon_id integer NOT NULL,
    name character varying NOT NULL,
    description text,
    distance_from_earth numeric,
    planet_id integer
);


ALTER TABLE public.moon OWNER TO freecodecamp;

--
-- Name: moon_moon_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.moon_moon_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.moon_moon_id_seq OWNER TO freecodecamp;

--
-- Name: moon_moon_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.moon_moon_id_seq OWNED BY public.moon.moon_id;


--
-- Name: planet; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.planet (
    planet_id integer NOT NULL,
    name character varying NOT NULL,
    description text,
    has_life boolean,
    is_spherical boolean,
    age_in_millions_of_years numeric,
    no_of_moons integer,
    star_id integer,
    planet_types_id integer
);


ALTER TABLE public.planet OWNER TO freecodecamp;

--
-- Name: planet_planet_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.planet_planet_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.planet_planet_id_seq OWNER TO freecodecamp;

--
-- Name: planet_planet_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.planet_planet_id_seq OWNED BY public.planet.planet_id;


--
-- Name: planet_types; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.planet_types (
    planet_types_id integer NOT NULL,
    name character varying NOT NULL,
    info text
);


ALTER TABLE public.planet_types OWNER TO freecodecamp;

--
-- Name: planet_types_planet_type_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.planet_types_planet_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.planet_types_planet_type_id_seq OWNER TO freecodecamp;

--
-- Name: planet_types_planet_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.planet_types_planet_type_id_seq OWNED BY public.planet_types.planet_types_id;


--
-- Name: star; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.star (
    star_id integer NOT NULL,
    name character varying NOT NULL,
    description text,
    age_in_millions_of_years numeric,
    distance_from_earth numeric,
    galaxy_id integer
);


ALTER TABLE public.star OWNER TO freecodecamp;

--
-- Name: star_star_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.star_star_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.star_star_id_seq OWNER TO freecodecamp;

--
-- Name: star_star_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.star_star_id_seq OWNED BY public.star.star_id;


--
-- Name: galaxy galaxy_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy ALTER COLUMN galaxy_id SET DEFAULT nextval('public.galaxy_galaxy_id_seq'::regclass);


--
-- Name: moon moon_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon ALTER COLUMN moon_id SET DEFAULT nextval('public.moon_moon_id_seq'::regclass);


--
-- Name: planet planet_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet ALTER COLUMN planet_id SET DEFAULT nextval('public.planet_planet_id_seq'::regclass);


--
-- Name: planet_types planet_types_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet_types ALTER COLUMN planet_types_id SET DEFAULT nextval('public.planet_types_planet_type_id_seq'::regclass);


--
-- Name: star star_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star ALTER COLUMN star_id SET DEFAULT nextval('public.star_star_id_seq'::regclass);


--
-- Data for Name: galaxy; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.galaxy VALUES (1, 'Milky Way', 'The galaxy that contains our Solar System.', 1000000000, 0);
INSERT INTO public.galaxy VALUES (2, 'Andromeda', 'Closest spiral galaxy to the Milky Way.', 1000000000, 2.5);
INSERT INTO public.galaxy VALUES (3, 'Triangulum', 'A member of the Local Group of galaxies.', 40000000, 3.0);
INSERT INTO public.galaxy VALUES (4, 'Whirlpool', 'A classic spiral galaxy with a well-defined structure.', 200000000, 23.0);
INSERT INTO public.galaxy VALUES (5, 'Sombrero', 'A spiral galaxy with a bright nucleus and an extended halo.', 100000000, 29.3);
INSERT INTO public.galaxy VALUES (6, 'Messier 87', 'A giant elliptical galaxy with a supermassive black hole.', 300000000, 53.5);
INSERT INTO public.galaxy VALUES (7, 'Centaurus A', 'A peculiar galaxy with an active galactic nucleus.', 200000000, 12.0);


--
-- Data for Name: moon; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.moon VALUES (61, 'Luna', 'Earth’s only natural satellite, known simply as the Moon.', 384400, 21);
INSERT INTO public.moon VALUES (62, 'Phobos', 'The larger and closer of Mars’ two moons.', 9377, 22);
INSERT INTO public.moon VALUES (63, 'Deimos', 'The smaller and farther of Mars’ two moons.', 23460, 22);
INSERT INTO public.moon VALUES (64, 'Io', 'The most volcanically active body in the Solar System.', 628300, 23);
INSERT INTO public.moon VALUES (65, 'Europa', 'An icy moon with a subsurface ocean.', 628300, 23);
INSERT INTO public.moon VALUES (66, 'Ganymede', 'The largest moon in the Solar System.', 628300, 23);
INSERT INTO public.moon VALUES (67, 'Callisto', 'A heavily cratered moon of Jupiter.', 628300, 23);
INSERT INTO public.moon VALUES (68, 'Titan', 'The largest moon of Saturn with a thick atmosphere.', 1275000, 24);
INSERT INTO public.moon VALUES (69, 'Enceladus', 'An icy moon that ejects water vapor into space.', 1275000, 24);
INSERT INTO public.moon VALUES (70, 'Triton', 'A Neptune moon with a retrograde orbit.', 4351000, 25);
INSERT INTO public.moon VALUES (71, 'Oberon', 'The second-largest moon of Uranus.', 5826000, 26);
INSERT INTO public.moon VALUES (72, 'Miranda', 'A uniquely deformed moon with massive cliffs.', 5840000, 26);
INSERT INTO public.moon VALUES (73, 'Proteus', 'A dark and irregularly shaped moon of Neptune.', 4351000, 27);
INSERT INTO public.moon VALUES (74, 'Nereid', 'An eccentric moon with a highly elliptical orbit.', 5514000, 27);
INSERT INTO public.moon VALUES (75, 'Charon', 'The largest moon of Pluto, nearly half its size.', 19571000, 28);
INSERT INTO public.moon VALUES (76, 'Styx', 'A small moon of Pluto with an irregular shape.', 19580000, 28);
INSERT INTO public.moon VALUES (77, 'Hydra', 'A distant moon of Pluto, highly reflective.', 19600000, 28);
INSERT INTO public.moon VALUES (78, 'Andromeda I-A', 'A natural satellite of Andromeda I.', 2360000, 29);
INSERT INTO public.moon VALUES (79, 'Whirlpool Prime I', 'A rocky moon of Whirlpool Prime.', 180000000, 30);
INSERT INTO public.moon VALUES (80, 'Centauri One A', 'A volcanic moon in the Centauri system.', 9100000, 31);


--
-- Data for Name: planet; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.planet VALUES (21, 'Mercury', 'The smallest planet in the Solar System.', false, true, 4500, 0, 1, 1);
INSERT INTO public.planet VALUES (22, 'Venus', 'A planet with a thick, toxic atmosphere.', false, true, 4500, 0, 1, 1);
INSERT INTO public.planet VALUES (23, 'Earth', 'The only planet known to support life.', true, true, 4500, 1, 1, 1);
INSERT INTO public.planet VALUES (24, 'Mars', 'Known as the Red Planet, possibly had water.', false, true, 4500, 2, 1, 1);
INSERT INTO public.planet VALUES (25, 'Jupiter', 'The largest planet, a gas giant.', false, true, 4500, 79, 1, 2);
INSERT INTO public.planet VALUES (26, 'Saturn', 'A gas giant known for its prominent rings.', false, true, 4500, 83, 1, 2);
INSERT INTO public.planet VALUES (27, 'Neptune', 'A distant ice giant with strong winds.', false, true, 4500, 14, 1, 3);
INSERT INTO public.planet VALUES (28, 'Sirius b-I', 'An exoplanet orbiting the white dwarf Sirius B.', false, true, 2000, 0, 2, 2);
INSERT INTO public.planet VALUES (29, 'Sirius b-II', 'A super-Earth exoplanet in the Sirius system.', false, true, 3000, 2, 2, 4);
INSERT INTO public.planet VALUES (30, 'Betel Prime', 'A gas giant orbiting Betelgeuse.', false, true, 8000, 10, 3, 2);
INSERT INTO public.planet VALUES (31, 'Betel X', 'A rocky planet with extreme conditions.', false, true, 7500, 1, 3, 1);
INSERT INTO public.planet VALUES (32, 'Andromeda I', 'A terrestrial planet in the Andromeda galaxy.', false, true, 5000, 3, 4, 1);
INSERT INTO public.planet VALUES (33, 'Andromeda II', 'A Neptune-like ice giant.', false, true, 5000, 6, 4, 3);
INSERT INTO public.planet VALUES (34, 'Whirlpool Prime', 'A super-Earth in the Whirlpool galaxy.', false, true, 6000, 2, 6, 4);
INSERT INTO public.planet VALUES (35, 'Centauri One', 'A hot Jupiter orbiting close to its star.', false, true, 7000, 0, 7, 5);


--
-- Data for Name: planet_types; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.planet_types VALUES (1, 'Terrestrial', 'Rocky planets with solid surfaces, like Earth and Mars.');
INSERT INTO public.planet_types VALUES (2, 'Gas Giant', 'Massive planets primarily composed of hydrogen and helium, like Jupiter and Saturn.');
INSERT INTO public.planet_types VALUES (3, 'Ice Giant', 'Planets with a thick atmosphere and an icy composition, like Uranus and Neptune.');
INSERT INTO public.planet_types VALUES (4, 'Super-Earth', 'Exoplanets larger than Earth but smaller than Neptune, potentially habitable.');
INSERT INTO public.planet_types VALUES (5, 'Hot Jupiter', 'Gas giants that orbit very close to their stars, experiencing extreme heat.');
INSERT INTO public.planet_types VALUES (6, 'Ocean World', 'Planets believed to have vast oceans covering their surfaces.');
INSERT INTO public.planet_types VALUES (7, 'Rogue Planet', 'Planets that do not orbit a star and drift freely through space.');


--
-- Data for Name: star; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.star VALUES (1, 'Sun', 'The star at the center of our Solar System.', 4600, 0, 1);
INSERT INTO public.star VALUES (2, 'Sirius', 'The brightest star in the night sky, part of a binary system.', 200, 8.6, 1);
INSERT INTO public.star VALUES (3, 'Betelgeuse', 'A red supergiant star in the Orion constellation.', 8000, 642, 1);
INSERT INTO public.star VALUES (4, 'Andromeda A', 'A massive star located in the Andromeda galaxy.', 5000, 2.5, 2);
INSERT INTO public.star VALUES (5, 'Triangulum Star X', 'A young star forming in the Triangulum galaxy.', 300, 3.0, 3);
INSERT INTO public.star VALUES (6, 'Whirlpool Alpha', 'A star located in the Whirlpool galaxy.', 6000, 23.0, 4);
INSERT INTO public.star VALUES (7, 'Centauri B', 'A bright star in the Centaurus A galaxy.', 7000, 12.0, 7);


--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.galaxy_galaxy_id_seq', 7, true);


--
-- Name: moon_moon_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.moon_moon_id_seq', 80, true);


--
-- Name: planet_planet_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.planet_planet_id_seq', 35, true);


--
-- Name: planet_types_planet_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.planet_types_planet_type_id_seq', 7, true);


--
-- Name: star_star_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.star_star_id_seq', 7, true);


--
-- Name: galaxy galaxy_id; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT galaxy_id PRIMARY KEY (galaxy_id);


--
-- Name: galaxy galaxy_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT galaxy_name_key UNIQUE (name);


--
-- Name: moon moon_id; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_id PRIMARY KEY (moon_id);


--
-- Name: moon moon_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_name_key UNIQUE (name);


--
-- Name: planet planet_id; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_id PRIMARY KEY (planet_id);


--
-- Name: planet planet_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_name_key UNIQUE (name);


--
-- Name: planet_types planet_types_id; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet_types
    ADD CONSTRAINT planet_types_id PRIMARY KEY (planet_types_id);


--
-- Name: planet_types planet_types_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet_types
    ADD CONSTRAINT planet_types_name_key UNIQUE (name);


--
-- Name: star star_id; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_id PRIMARY KEY (star_id);


--
-- Name: star star_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_name_key UNIQUE (name);


--
-- Name: moon fk_moon_planet; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT fk_moon_planet FOREIGN KEY (planet_id) REFERENCES public.planet(planet_id);


--
-- Name: planet fk_planet_star; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT fk_planet_star FOREIGN KEY (star_id) REFERENCES public.star(star_id);


--
-- Name: planet fk_planet_types; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT fk_planet_types FOREIGN KEY (planet_types_id) REFERENCES public.planet_types(planet_types_id);


--
-- Name: star fk_star_galaxy; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT fk_star_galaxy FOREIGN KEY (galaxy_id) REFERENCES public.galaxy(galaxy_id);


--
-- PostgreSQL database dump complete
--

