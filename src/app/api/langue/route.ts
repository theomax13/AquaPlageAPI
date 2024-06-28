// app/api/langue/route.ts
import { NextRequest, NextResponse } from "next/server";
import { PrismaClient } from "@prisma/client";

const prisma = new PrismaClient();

export async function GET() {
  try {
    const langues = await prisma.langue.findMany();
    return NextResponse.json(langues);
  } catch (error) {
    console.error("Error fetching langues:", error);
    return NextResponse.json(
      { error: "Error fetching langues" },
      { status: 500 }
    );
  }
}

export async function POST(request: NextRequest) {
  try {
    const { plage_id, langue_visite, langue_parlee } = await request.json();

    if (!plage_id) {
      return NextResponse.json(
        { error: "Missing required data" },
        { status: 400 }
      );
    }

    const langue = await prisma.langue.create({
      data: {
        plage_id,
        langue_visite,
        langue_parlee,
      },
    });
    return NextResponse.json(langue, { status: 201 });
  } catch (error) {
    console.error("Error adding langue:", error);
    return NextResponse.json({ error: "Error adding langue" }, { status: 500 });
  }
}

export async function PUT(request: NextRequest) {
  try {
    const { id, plage_id, langue_visite, langue_parlee } = await request.json();

    if (!id || !plage_id) {
      return NextResponse.json(
        { error: "Missing required data" },
        { status: 400 }
      );
    }

    const langue = await prisma.langue.update({
      where: { id: Number(id) },
      data: {
        plage_id,
        langue_visite,
        langue_parlee,
      },
    });
    return NextResponse.json(langue);
  } catch (error) {
    console.error("Error updating langue:", error);
    return NextResponse.json(
      { error: "Error updating langue" },
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

    const langue = await prisma.langue.delete({
      where: { id: Number(id) },
    });
    return NextResponse.json(langue);
  } catch (error) {
    console.error("Error deleting langue:", error);
    return NextResponse.json(
      { error: "Error deleting langue" },
      { status: 500 }
    );
  }
}
