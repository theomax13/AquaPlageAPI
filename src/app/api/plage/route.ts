// app/api/plage/route.ts
import { NextRequest, NextResponse } from "next/server";
import { PrismaClient } from "@prisma/client";

const prisma = new PrismaClient();

export async function GET() {
  try {
    const plages = await prisma.plage.findMany();
    return NextResponse.json(plages);
  } catch (error) {
    console.error("Error fetching plages:", error);
    return NextResponse.json(
      { error: "Error fetching plages" },
      { status: 500 }
    );
  }
}

export async function POST(request: NextRequest) {
  try {
    const data = await request.json();
    const plage = await prisma.plage.create({ data });
    return NextResponse.json(plage, { status: 201 });
  } catch (error) {
    console.error("Error adding plage:", error);
    return NextResponse.json({ error: "Error adding plage" }, { status: 500 });
  }
}

export async function PUT(request: NextRequest) {
  try {
    const { id, ...data } = await request.json();
    const plage = await prisma.plage.update({
      where: { id: Number(id) },
      data,
    });
    return NextResponse.json(plage);
  } catch (error) {
    console.error("Error updating plage:", error);
    return NextResponse.json(
      { error: "Error updating plage" },
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

    const plage = await prisma.plage.delete({
      where: { id: Number(id) },
    });
    return NextResponse.json(plage);
  } catch (error) {
    console.error("Error deleting plage:", error);
    return NextResponse.json(
      { error: "Error deleting plage" },
      { status: 500 }
    );
  }
}
