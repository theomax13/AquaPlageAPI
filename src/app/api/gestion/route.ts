// app/api/gestion/route.ts
import { NextRequest, NextResponse } from "next/server";
import { PrismaClient } from "@prisma/client";

const prisma = new PrismaClient();

export async function GET() {
  try {
    const gestions = await prisma.gestion.findMany();
    return NextResponse.json(gestions);
  } catch (error) {
    console.error("Error fetching gestions:", error);
    return NextResponse.json(
      { error: "Error fetching gestions" },
      { status: 500 }
    );
  }
}

export async function POST(request: NextRequest) {
  try {
    const { plage_id, gestion_sociale } = await request.json();

    if (!plage_id || !gestion_sociale) {
      return NextResponse.json(
        { error: "Missing required data" },
        { status: 400 }
      );
    }

    const gestion = await prisma.gestion.create({
      data: {
        plage_id,
        gestion_sociale,
      },
    });
    return NextResponse.json(gestion, { status: 201 });
  } catch (error) {
    console.error("Error adding gestion:", error);
    return NextResponse.json(
      { error: "Error adding gestion" },
      { status: 500 }
    );
  }
}

export async function PUT(request: NextRequest) {
  try {
    const { id, plage_id, gestion_sociale } = await request.json();

    if (!id || !plage_id || !gestion_sociale) {
      return NextResponse.json(
        { error: "Missing required data" },
        { status: 400 }
      );
    }

    const gestion = await prisma.gestion.update({
      where: { id: Number(id) },
      data: {
        plage_id,
        gestion_sociale,
      },
    });
    return NextResponse.json(gestion);
  } catch (error) {
    console.error("Error updating gestion:", error);
    return NextResponse.json(
      { error: "Error updating gestion" },
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

    const gestion = await prisma.gestion.delete({
      where: { id: Number(id) },
    });
    return NextResponse.json(gestion);
  } catch (error) {
    console.error("Error deleting gestion:", error);
    return NextResponse.json(
      { error: "Error deleting gestion" },
      { status: 500 }
    );
  }
}
