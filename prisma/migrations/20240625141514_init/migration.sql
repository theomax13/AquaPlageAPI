/*
  Warnings:

  - The `handicap_acces` column on the `plage` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - The `groupes_acceptees` column on the `plage` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - A unique constraint covering the columns `[nom]` on the table `commune` will be added. If there are existing duplicate values, this will fail.
  - Made the column `commune_id` on table `plage` required. This step will fail if there are existing NULL values in that column.

*/
-- DropForeignKey
ALTER TABLE "plage" DROP CONSTRAINT "plage_commune_id_fkey";

-- AlterTable
ALTER TABLE "gestion" ALTER COLUMN "gestion_sociale" DROP NOT NULL;

-- AlterTable
ALTER TABLE "plage" ALTER COLUMN "latitude" DROP NOT NULL,
ALTER COLUMN "longitude" DROP NOT NULL,
ALTER COLUMN "commune_id" SET NOT NULL,
DROP COLUMN "handicap_acces",
ADD COLUMN     "handicap_acces" BOOLEAN,
DROP COLUMN "groupes_acceptees",
ADD COLUMN     "groupes_acceptees" BOOLEAN,
ALTER COLUMN "animaux_acceptes" DROP NOT NULL;

-- CreateIndex
CREATE UNIQUE INDEX "commune_nom_key" ON "commune"("nom");

-- AddForeignKey
ALTER TABLE "plage" ADD CONSTRAINT "plage_commune_id_fkey" FOREIGN KEY ("commune_id") REFERENCES "commune"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
