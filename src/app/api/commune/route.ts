// app/api/commune/route.ts
import { NextRequest, NextResponse } from "next/server";
import { PrismaClient } from "@prisma/client";

const prisma = new PrismaClient();

export async function GET() {
  try {
    const communes = await prisma.commune.findMany();
    return NextResponse.json(communes);
  } catch (error) {
    console.error("Error fetching communes:", error);
    return NextResponse.json(
      { error: "Error fetching communes" },
      { status: 500 }
    );
  }
}

export async function POST(request: NextRequest) {
  try {
    const { nom, code_postal } = await request.json();

    if (!nom || !code_postal) {
      return NextResponse.json(
        { error: "Missing required data" },
        { status: 400 }
      );
    }

    const commune = await prisma.commune.create({
      data: {
        nom,
        code_postal,
      },
    });
    return NextResponse.json(commune, { status: 201 });
  } catch (error) {
    console.error("Error adding commune:", error);
    return NextResponse.json(
      { error: "Error adding commune" },
      { status: 500 }
    );
  }
}

export async function PUT(request: NextRequest) {
  try {
    const { id, nom, code_postal } = await request.json();

    if (!id || !nom || !code_postal) {
      return NextResponse.json(
        { error: "Missing required data" },
        { status: 400 }
      );
    }

    const commune = await prisma.commune.update({
      where: { id: Number(id) },
      data: {
        nom,
        code_postal,
      },
    });
    return NextResponse.json(commune);
  } catch (error) {
    console.error("Error updating commune:", error);
    return NextResponse.json(
      { error: "Error updating commune" },
      { status: 500 }
    );
  }
}

export async function DELETE(request: NextRequest) {
  try {
    const { id } = await request.json();

    if (!id) {
      return NextResponse.json({ error: "Missing id" }, { status: 400 });
    }

    const commune = await prisma.commune.delete({
      where: { id: Number(id) },
    });
    return NextResponse.json(commune);
  } catch (error) {
    console.error("Error deleting commune:", error);
    return NextResponse.json(
      { error: "Error deleting commune" },
      { status: 500 }
    );
  }
}
