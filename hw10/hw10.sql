CREATE TABLE parents AS
  SELECT "abraham" AS parent, "barack" AS child UNION
  SELECT "abraham"          , "clinton"         UNION
  SELECT "delano"           , "herbert"         UNION
  SELECT "fillmore"         , "abraham"         UNION
  SELECT "fillmore"         , "delano"          UNION
  SELECT "fillmore"         , "grover"          UNION
  SELECT "eisenhower"       , "fillmore";

CREATE TABLE dogs AS
  SELECT "abraham" AS name, "long" AS fur, 26 AS height UNION
  SELECT "barack"         , "short"      , 52           UNION
  SELECT "clinton"        , "long"       , 47           UNION
  SELECT "delano"         , "long"       , 46           UNION
  SELECT "eisenhower"     , "short"      , 35           UNION
  SELECT "fillmore"       , "curly"      , 32           UNION
  SELECT "grover"         , "short"      , 28           UNION
  SELECT "herbert"        , "curly"      , 31;

CREATE TABLE sizes AS
  SELECT "toy" AS size, 24 AS min, 28 AS max UNION
  SELECT "mini"       , 28       , 35        UNION
  SELECT "medium"     , 35       , 45        UNION
  SELECT "standard"   , 45       , 60;


-- All dogs with parents ordered by decreasing height of their parent
CREATE TABLE by_parent_height AS
  SELECT child_dog.name
    FROM parents p
    JOIN dogs child_dog ON p.child = child_dog.name
    JOIN dogs parent_dog ON p.parent = parent_dog.name
    ORDER BY parent_dog.height DESC;


-- The size of each dog
CREATE TABLE size_of_dogs AS
  SELECT d.name, s.size FROM dogs d, sizes s
    WHERE s.min < d.height AND d.height <= s.max;


-- Filling out this helper table is optional
CREATE TABLE siblings AS
  SELECT d1.name AS name1, d2.name AS name2, s1.size AS size
  FROM (dogs d1 JOIN size_of_dogs s1 ON d1.name = s1.name JOIN parents p1 ON d1.name = p1.child),
       (dogs d2 JOIN size_of_dogs s2 ON d2.name = s2.name JOIN parents p2 ON d2.name = p2.child)
  WHERE s1.size = s2.size AND p1.parent = p2.parent AND d1.name < d2.name;

-- Sentences about siblings that are the same size
CREATE TABLE sentences AS
  SELECT "The two siblings, " || name1 || " plus " || name2 || " have the same size: " || size
  FROM siblings;


-- Height range for each fur type where all of the heights differ by no more than 30% from the average height
CREATE TABLE low_variance AS
  SELECT fur, MAX(height) - MIN(height)
  FROM dogs GROUP BY fur
  HAVING 0.7 * AVG(height) <= MIN(height) AND MAX(height) <= 1.3 * AVG(height);

