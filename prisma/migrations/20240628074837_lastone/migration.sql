/*
  Warnings:

  - You are about to drop the `commune` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `contact` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `gestion` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `langue` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `plage` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `service` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "contact" DROP CONSTRAINT "contact_plage_id_fkey";

-- DropForeignKey
ALTER TABLE "gestion" DROP CONSTRAINT "gestion_plage_id_fkey";

-- DropForeignKey
ALTER TABLE "langue" DROP CONSTRAINT "langue_plage_id_fkey";

-- DropForeignKey
ALTER TABLE "plage" DROP CONSTRAINT "plage_commune_id_fkey";

-- DropForeignKey
ALTER TABLE "service" DROP CONSTRAINT "service_plage_id_fkey";

-- DropTable
DROP TABLE "commune";

-- DropTable
DROP TABLE "contact";

-- DropTable
DROP TABLE "gestion";

-- DropTable
DROP TABLE "langue";

-- DropTable
DROP TABLE "plage";

-- DropTable
DROP TABLE "service";

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
    "latitude" DOUBLE PRECISION,
    "longitude" DOUBLE PRECISION,
    "description" TEXT,
    "commune_id" INTEGER NOT NULL,
    "adresse1" TEXT,
    "adresse2" TEXT,
    "adresse3" TEXT,
    "conditions_visite" TEXT,
    "labels" TEXT,
    "handicap_acces" BOOLEAN NOT NULL DEFAULT false,
    "groupes_acceptees" BOOLEAN,
    "animaux_acceptes" BOOLEAN,
    "url" TEXT,

    CONSTRAINT "Plage_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Contact" (
    "id" SERIAL NOT NULL,
    "plage_id" INTEGER NOT NULL,
    "email" TEXT,

    CONSTRAINT "Contact_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Telephone" (
    "id" SERIAL NOT NULL,
    "contact_id" INTEGER NOT NULL,
    "telephone" TEXT NOT NULL,
    "type" TEXT NOT NULL,

    CONSTRAINT "Telephone_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Gestion" (
    "id" SERIAL NOT NULL,
    "plage_id" INTEGER NOT NULL,
    "gestion_sociale" TEXT,

    CONSTRAINT "Gestion_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Tarif" (
    "id" SERIAL NOT NULL,
    "plage_id" INTEGER NOT NULL,
    "nom" TEXT,
    "prix1" DOUBLE PRECISION,
    "prix2" DOUBLE PRECISION,
    "description" TEXT,

    CONSTRAINT "Tarif_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Ouverture" (
    "id" SERIAL NOT NULL,
    "plage_id" INTEGER NOT NULL,
    "date_debut" TIMESTAMP(3),
    "date_fin" TIMESTAMP(3),

    CONSTRAINT "Ouverture_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Horaire" (
    "id" SERIAL NOT NULL,
    "ouverture_id" INTEGER NOT NULL,
    "heure_matin_debut" TIMESTAMP(3),
    "heure_matin_fin" TIMESTAMP(3),
    "heure_aprem_debut" TIMESTAMP(3),
    "heure_aprem_fin" TIMESTAMP(3),

    CONSTRAINT "Horaire_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "LangueUnique" (
    "id" SERIAL NOT NULL,
    "langue" TEXT NOT NULL,

    CONSTRAINT "LangueUnique_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ServiceUnique" (
    "id" SERIAL NOT NULL,
    "service" TEXT NOT NULL,

    CONSTRAINT "ServiceUnique_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "HandicapUnique" (
    "id" SERIAL NOT NULL,
    "handicap" TEXT NOT NULL,

    CONSTRAINT "HandicapUnique_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "EquipementUnique" (
    "id" SERIAL NOT NULL,
    "equipement" TEXT NOT NULL,

    CONSTRAINT "EquipementUnique_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ActiviteUnique" (
    "id" SERIAL NOT NULL,
    "activite" TEXT NOT NULL,

    CONSTRAINT "ActiviteUnique_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PlageLangue" (
    "plage_id" INTEGER NOT NULL,
    "langue_id" INTEGER NOT NULL,

    CONSTRAINT "PlageLangue_pkey" PRIMARY KEY ("plage_id","langue_id")
);

-- CreateTable
CREATE TABLE "PlageService" (
    "plage_id" INTEGER NOT NULL,
    "service_id" INTEGER NOT NULL,

    CONSTRAINT "PlageService_pkey" PRIMARY KEY ("plage_id","service_id")
);

-- CreateTable
CREATE TABLE "PlageHandicap" (
    "plage_id" INTEGER NOT NULL,
    "handicap_id" INTEGER NOT NULL,

    CONSTRAINT "PlageHandicap_pkey" PRIMARY KEY ("plage_id","handicap_id")
);

-- CreateTable
CREATE TABLE "PlageEquipement" (
    "plage_id" INTEGER NOT NULL,
    "equipement_id" INTEGER NOT NULL,

    CONSTRAINT "PlageEquipement_pkey" PRIMARY KEY ("plage_id","equipement_id")
);

-- CreateTable
CREATE TABLE "PlageActivite" (
    "plage_id" INTEGER NOT NULL,
    "activite_id" INTEGER NOT NULL,

    CONSTRAINT "PlageActivite_pkey" PRIMARY KEY ("plage_id","activite_id")
);

-- CreateIndex
CREATE UNIQUE INDEX "Commune_nom_key" ON "Commune"("nom");

-- CreateIndex
CREATE UNIQUE INDEX "LangueUnique_langue_key" ON "LangueUnique"("langue");

-- CreateIndex
CREATE UNIQUE INDEX "ServiceUnique_service_key" ON "ServiceUnique"("service");

-- CreateIndex
CREATE UNIQUE INDEX "HandicapUnique_handicap_key" ON "HandicapUnique"("handicap");

-- CreateIndex
CREATE UNIQUE INDEX "EquipementUnique_equipement_key" ON "EquipementUnique"("equipement");

-- CreateIndex
CREATE UNIQUE INDEX "ActiviteUnique_activite_key" ON "ActiviteUnique"("activite");

-- AddForeignKey
ALTER TABLE "Plage" ADD CONSTRAINT "Plage_commune_id_fkey" FOREIGN KEY ("commune_id") REFERENCES "Commune"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Contact" ADD CONSTRAINT "Contact_plage_id_fkey" FOREIGN KEY ("plage_id") REFERENCES "Plage"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Telephone" ADD CONSTRAINT "Telephone_contact_id_fkey" FOREIGN KEY ("contact_id") REFERENCES "Contact"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Gestion" ADD CONSTRAINT "Gestion_plage_id_fkey" FOREIGN KEY ("plage_id") REFERENCES "Plage"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Tarif" ADD CONSTRAINT "Tarif_plage_id_fkey" FOREIGN KEY ("plage_id") REFERENCES "Plage"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Ouverture" ADD CONSTRAINT "Ouverture_plage_id_fkey" FOREIGN KEY ("plage_id") REFERENCES "Plage"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Horaire" ADD CONSTRAINT "Horaire_ouverture_id_fkey" FOREIGN KEY ("ouverture_id") REFERENCES "Ouverture"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PlageLangue" ADD CONSTRAINT "PlageLangue_plage_id_fkey" FOREIGN KEY ("plage_id") REFERENCES "Plage"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PlageLangue" ADD CONSTRAINT "PlageLangue_langue_id_fkey" FOREIGN KEY ("langue_id") REFERENCES "LangueUnique"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PlageService" ADD CONSTRAINT "PlageService_plage_id_fkey" FOREIGN KEY ("plage_id") REFERENCES "Plage"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PlageService" ADD CONSTRAINT "PlageService_service_id_fkey" FOREIGN KEY ("service_id") REFERENCES "ServiceUnique"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PlageHandicap" ADD CONSTRAINT "PlageHandicap_plage_id_fkey" FOREIGN KEY ("plage_id") REFERENCES "Plage"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PlageHandicap" ADD CONSTRAINT "PlageHandicap_handicap_id_fkey" FOREIGN KEY ("handicap_id") REFERENCES "HandicapUnique"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PlageEquipement" ADD CONSTRAINT "PlageEquipement_plage_id_fkey" FOREIGN KEY ("plage_id") REFERENCES "Plage"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PlageEquipement" ADD CONSTRAINT "PlageEquipement_equipement_id_fkey" FOREIGN KEY ("equipement_id") REFERENCES "EquipementUnique"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PlageActivite" ADD CONSTRAINT "PlageActivite_plage_id_fkey" FOREIGN KEY ("plage_id") REFERENCES "Plage"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PlageActivite" ADD CONSTRAINT "PlageActivite_activite_id_fkey" FOREIGN KEY ("activite_id") REFERENCES "ActiviteUnique"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
