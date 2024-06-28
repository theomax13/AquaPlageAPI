import { NextApiRequest, NextApiResponse } from "next";
import { PrismaClient } from "@prisma/client";

const prisma = new PrismaClient();

export default async function handler(
  req: NextApiRequest,
  res: NextApiResponse
) {
  const { id } = req.query;

  try {
    const commune = await prisma.commune.findUnique({
      where: {
        id: Number(id),
      },
    });

    if (!commune) {
      return res.status(404).json({ message: "Commune not found" });
    }

    return res.status(200).json(commune);
  } catch (error) {
    return res.status(500).json({ message: "Internal server error" });
  }
}
