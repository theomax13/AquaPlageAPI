import { NextApiRequest, NextApiResponse } from "next";
import { PrismaClient } from "@prisma/client";

const prisma = new PrismaClient();

export default async function handler(
  req: NextApiRequest,
  res: NextApiResponse
) {
  const { id } = req.query;

  try {
    const langue = await prisma.langue.findUnique({
      where: {
        id: Number(id),
      },
    });

    if (!langue) {
      return res.status(404).json({ message: "Langue not found" });
    }

    return res.status(200).json(langue);
  } catch (error) {
    return res.status(500).json({ message: "Internal server error" });
  }
}
