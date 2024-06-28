import { NextApiRequest, NextApiResponse } from "next";
import { PrismaClient } from "@prisma/client";

const prisma = new PrismaClient();

export default async function handler(
  req: NextApiRequest,
  res: NextApiResponse
) {
  const { id } = req.query;

  try {
    const plage = await prisma.plage.findUnique({
      where: {
        id: Number(id),
      },
    });

    if (!plage) {
      return res.status(404).json({ message: "Plage not found" });
    }

    return res.status(200).json(plage);
  } catch (error) {
    return res.status(500).json({ message: "Internal server error" });
  }
}
