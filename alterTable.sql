ALTER TABLE HIVData
MODIFY age VARCHAR(10),
ADD COLUMN population_subgroup_id INT;

ALTER TABLE HIVData
ADD CONSTRAINT fk_population_subgroup
FOREIGN KEY (population_subgroup_id) REFERENCES PopulationSubgroups(id);
