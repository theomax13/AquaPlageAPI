/*
  Warnings:

  - You are about to drop the `Commune` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Contact` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Gestion` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Langue` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Plage` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Service` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "Contact" DROP CONSTRAINT "Contact_plage_id_fkey";

-- DropForeignKey
ALTER TABLE "Gestion" DROP CONSTRAINT "Gestion_plage_id_fkey";

-- DropForeignKey
ALTER TABLE "Langue" DROP CONSTRAINT "Langue_plage_id_fkey";

-- DropForeignKey
ALTER TABLE "Plage" DROP CONSTRAINT "Plage_commune_id_fkey";

-- DropForeignKey
ALTER TABLE "Service" DROP CONSTRAINT "Service_plage_id_fkey";

-- DropTable
DROP TABLE "Commune";

-- DropTable
DROP TABLE "Contact";

-- DropTable
DROP TABLE "Gestion";

-- DropTable
DROP TABLE "Langue";

-- DropTable
DROP TABLE "Plage";

-- DropTable
DROP TABLE "Service";

-- CreateTable
CREATE TABLE "commune" (
    "id" SERIAL NOT NULL,
    "nom" TEXT NOT NULL,
    "code_postal" TEXT NOT NULL,

    CONSTRAINT "commune_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "plage" (
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

    CONSTRAINT "plage_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "contact" (
    "id" SERIAL NOT NULL,
    "plage_id" INTEGER NOT NULL,
    "telephone" TEXT,
    "telephone_mobile" TEXT,
    "telephone_complet" TEXT,
    "email" TEXT,

    CONSTRAINT "contact_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "langue" (
    "id" SERIAL NOT NULL,
    "plage_id" INTEGER NOT NULL,
    "langue_visite" TEXT,
    "langue_parlee" TEXT,

    CONSTRAINT "langue_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "service" (
    "id" SERIAL NOT NULL,
    "plage_id" INTEGER NOT NULL,
    "service" TEXT NOT NULL,

    CONSTRAINT "service_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "gestion" (
    "id" SERIAL NOT NULL,
    "plage_id" INTEGER NOT NULL,
    "gestion_sociale" TEXT NOT NULL,

    CONSTRAINT "gestion_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "plage" ADD CONSTRAINT "plage_commune_id_fkey" FOREIGN KEY ("commune_id") REFERENCES "commune"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "contact" ADD CONSTRAINT "contact_plage_id_fkey" FOREIGN KEY ("plage_id") REFERENCES "plage"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "langue" ADD CONSTRAINT "langue_plage_id_fkey" FOREIGN KEY ("plage_id") REFERENCES "plage"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "service" ADD CONSTRAINT "service_plage_id_fkey" FOREIGN KEY ("plage_id") REFERENCES "plage"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "gestion" ADD CONSTRAINT "gestion_plage_id_fkey" FOREIGN KEY ("plage_id") REFERENCES "plage"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
