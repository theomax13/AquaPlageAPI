import psycopg2
import json

# Database connection details
DB_HOST = 'ep-young-snow-a2kdyjzr.eu-central-1.aws.neon.tech'
DB_NAME = 'aquaplage'
DB_USER = 'testdb_owner'
DB_PASS = 'vzZAq52GYBHQ'

# Connect to PostgreSQL database
conn = psycopg2.connect(
    host=DB_HOST,
    dbname=DB_NAME,
    user=DB_USER,
    password=DB_PASS
)
cur = conn.cursor()

# Load JSON data
with open('./Plage.json', 'r', encoding='utf-8') as f:
    data = json.load(f)

# Function to insert commune data
def insert_commune(commune, code_postal):
    cur.execute("""
        INSERT INTO Commune (nom, code_postal)
        VALUES (%s, %s)
        ON CONFLICT (nom) DO NOTHING
        RETURNING id;
    """, (commune, code_postal))
    commune_id = cur.fetchone()
    if commune_id:
        return commune_id[0]
    else:
        cur.execute("SELECT id FROM Commune WHERE nom = %s", (commune,))
        return cur.fetchone()[0]

# Helper function to convert "oui"/"non" to boolean
def convert_to_boolean(value):
    if value is None:
        return None
    if value.lower() == "oui":
        return True
    elif value.lower() == "non":
        return False
    else:
        return None

# Insert data into tables
for item in data['d']:
    commune_id = insert_commune(item['COMMUNE'], item['CP'])
    
    cur.execute("""
        INSERT INTO Plage (nom, latitude, longitude, description, commune_id, adresse1, adresse2, adresse3, conditions_visite, ouverture, labels, handicap_acces, handicap_label, tarifs, activites, equipements, groupes_acceptees, animaux_acceptes, url)
        VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
        RETURNING id;
    """, (
        item['SyndicObjectName'], item['LAT'], item['LON'], item['DESCRIPTIF'], commune_id, 
        item['AD1'], item['AD2'], item['AD3'], item['VISITECONDITIONS'], item['OUVERTURE'], 
        item['LABELS'], item['ACCESHANDI'], item['HANDICAPLABEL'], item['TARIFS'], 
        item['ACTIVPLACE'], item['EQUIP'], item['GROUPE'], convert_to_boolean(item['ANIMAUX']), item['URL']
    ))
    plage_id = cur.fetchone()[0]
    
    cur.execute("""
        INSERT INTO Contact (plage_id, telephone, telephone_mobile, telephone_complet, email)
        VALUES (%s, %s, %s, %s, %s);
    """, (
        plage_id, item['TEL'], item['TELMOB'], item['TELCOMPLET'], item['MAIL']
    ))
    
    cur.execute("""
        INSERT INTO Langue (plage_id, langue_visite, langue_parlee)
        VALUES (%s, %s, %s);
    """, (
        plage_id, item['LANGVISITE'], item['LANGPARLE']
    ))
    
    if item['SERVICES']:
        services = item['SERVICES'].split('#')
        for service in services:
            cur.execute("""
                INSERT INTO Service (plage_id, service)
                VALUES (%s, %s);
            """, (plage_id, service))
    
    cur.execute("""
        INSERT INTO Gestion (plage_id, gestion_sociale)
        VALUES (%s, %s);
    """, (plage_id, item['GESTRSOCIALE']))

# Commit changes and close connection
conn.commit()
cur.close()
conn.close()

print("Data insertion complete.")
