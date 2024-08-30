const fs = require('fs');
const csv = require('fast-csv');
const connection = require('./db');

const geoMap = new Map();
const popMap = new Map();

const processData = () => {
    fs.createReadStream('hiv_data.csv')
        .pipe(csv.parse({ headers: true })) // Use csv.parse with { headers: true }
        .on('data', (row) => {
            // Insert into GeographicAreas table
            if (!geoMap.has(row['Geographic Code'])) {
                connection.query(
                    'INSERT INTO GeographicAreas (geographic_code, geographic_area, country_code, country) VALUES (?, ?, ?, ?)', [row['Geographic Code'], row['Geographic Area'], row['Country Code'], row['Country']],
                    (err, results) => {
                        if (err) throw err;
                        geoMap.set(row['Geographic Code'], results.insertId);
                    }
                );
            }

            // Insert into PopulationSubgroups table
            if (!popMap.has(row['Subpop Code'])) {
                connection.query(
                    'INSERT INTO PopulationSubgroups (population_subgroup, subpop_code) VALUES (?, ?)', [row['Population Subgroup'], row['Subpop Code']],
                    (err, results) => {
                        if (err) throw err;
                        popMap.set(row['Subpop Code'], results.insertId);
                    }
                );
            }

            // Insert into HIVData table
            connection.query(
                'INSERT INTO HIVData (record_id, data_type, age_category_code, geographic_area_id, reference_date, virus_type, source_id, sequence, age, sex, num_of_deaths, num_cases, prevalence_rate, sample_size, incidence_rate, comments, specimen_type, test_type, quality, site_name, author, year, title, publication_information, subpop_id) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)', [
                    row['Record ID'], row['Data Type'], row['Age Category Code'], geoMap.get(row['Geographic Code']),
                    row['Reference Date'], row['Virus Type'], row['Source ID'], row['Sequence'], row['Age'],
                    row['Sex'], row['Num of Deaths'], row['Num Cases'], row['Prevalence Rate'], row['Sample Size'],
                    row['Incidence Rate'], row['Comments'], row['Specimen Type'], row['Test Type'], row['Quality'],
                    row['Site Name'], row['Author'], row['Year'], row['Title'], row['Publication Information'],
                    popMap.get(row['Subpop Code'])
                ],
                (err) => {
                    if (err) throw err;
                }
            );
        })
        .on('end', () => {
            console.log('CSV file successfully processed and data inserted.');
            connection.end();
        });
};

processData();