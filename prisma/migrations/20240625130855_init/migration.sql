-- CreateTable
CREATE TABLE "Commune" (
    "id" SERIAL NOT NULL,
    "nom" TEXT NOT NULL,
    "code_postal" TEXT NOT NULL,

    CONSTRAINT "Commune_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Plage" (
    "id" SERIAL NOT NULL,
    "nom" TEXT NOT NULL,
    "latitude" DOUBLE PRECISION NOT NULL,
    "longitude" DOUBLE PRECISION NOT NULL,
    "description" TEXT,
    "commune_id" INTEGER,
    "adresse1" TEXT,
    "adresse2" TEXT,
    "adresse3" TEXT,
    "conditions_visite" TEXT,
    "ouverture" TEXT,
    "labels" TEXT,
    "handicap_acces" TEXT,
    "handicap_label" TEXT,
    "tarifs" TEXT,
    "activites" TEXT,
    "equipements" TEXT,
    "groupes_acceptees" TEXT,
    "animaux_acceptes" BOOLEAN NOT NULL,
    "url" TEXT,

    CONSTRAINT "Plage_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Contact" (
    "id" SERIAL NOT NULL,
    "plage_id" INTEGER NOT NULL,
    "telephone" TEXT,
    "telephone_mobile" TEXT,
    "telephone_complet" TEXT,
    "email" TEXT,

    CONSTRAINT "Contact_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Langue" (
    "id" SERIAL NOT NULL,
    "plage_id" INTEGER NOT NULL,
    "langue_visite" TEXT,
    "langue_parlee" TEXT,

    CONSTRAINT "Langue_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Service" (
    "id" SERIAL NOT NULL,
    "plage_id" INTEGER NOT NULL,
    "service" TEXT NOT NULL,

    CONSTRAINT "Service_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Gestion" (
    "id" SERIAL NOT NULL,
    "plage_id" INTEGER NOT NULL,
    "gestion_sociale" TEXT NOT NULL,

    CONSTRAINT "Gestion_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "Plage" ADD CONSTRAINT "Plage_commune_id_fkey" FOREIGN KEY ("commune_id") REFERENCES "Commune"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Contact" ADD CONSTRAINT "Contact_plage_id_fkey" FOREIGN KEY ("plage_id") REFERENCES "Plage"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Langue" ADD CONSTRAINT "Langue_plage_id_fkey" FOREIGN KEY ("plage_id") REFERENCES "Plage"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Service" ADD CONSTRAINT "Service_plage_id_fkey" FOREIGN KEY ("plage_id") REFERENCES "Plage"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Gestion" ADD CONSTRAINT "Gestion_plage_id_fkey" FOREIGN KEY ("plage_id") REFERENCES "Plage"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
