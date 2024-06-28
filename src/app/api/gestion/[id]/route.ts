import { NextApiRequest, NextApiResponse } from "next";
import { PrismaClient } from "@prisma/client";

const prisma = new PrismaClient();

export default async function handler(
  req: NextApiRequest,
  res: NextApiResponse
) {
  const { id } = req.query;

  try {
    const gestion = await prisma.gestion.findUnique({
      where: {
        id: Number(id),
      },
    });

    if (!gestion) {
      return res.status(404).json({ message: "Gestion not found" });
    }

    return res.status(200).json(gestion);
  } catch (error) {
    return res.status(500).json({ message: "Internal server error" });
  }
}
