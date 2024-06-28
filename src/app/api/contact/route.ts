// app/api/contact/route.ts
import { NextRequest, NextResponse } from "next/server";
import { PrismaClient } from "@prisma/client";

const prisma = new PrismaClient();

export async function GET() {
  try {
    const contacts = await prisma.contact.findMany();
    return NextResponse.json(contacts);
  } catch (error) {
    console.error("Error fetching contacts:", error);
    return NextResponse.json(
      { error: "Error fetching contacts" },
      { status: 500 }
    );
  }
}

export async function POST(request: NextRequest) {
  try {
    const { plage_id, telephone, telephone_mobile, telephone_complet, email } =
      await request.json();

    if (!plage_id) {
      return NextResponse.json(
        { error: "Missing required data" },
        { status: 400 }
      );
    }

    const contact = await prisma.contact.create({
      data: {
        plage_id,
        telephone,
        telephone_mobile,
        telephone_complet,
        email,
      },
    });
    return NextResponse.json(contact, { status: 201 });
  } catch (error) {
    console.error("Error adding contact:", error);
    return NextResponse.json(
      { error: "Error adding contact" },
      { status: 500 }
    );
  }
}

export async function PUT(request: NextRequest) {
  try {
    const {
      id,
      plage_id,
      telephone,
      telephone_mobile,
      telephone_complet,
      email,
    } = await request.json();

    if (!id || !plage_id) {
      return NextResponse.json(
        { error: "Missing required data" },
        { status: 400 }
      );
    }

    const contact = await prisma.contact.update({
      where: { id: Number(id) },
      data: {
        plage_id,
        telephone,
        telephone_mobile,
        telephone_complet,
        email,
      },
    });
    return NextResponse.json(contact);
  } catch (error) {
    console.error("Error updating contact:", error);
    return NextResponse.json(
      { error: "Error updating contact" },
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

    const contact = await prisma.contact.delete({
      where: { id: Number(id) },
    });
    return NextResponse.json(contact);
  } catch (error) {
    console.error("Error deleting contact:", error);
    return NextResponse.json(
      { error: "Error deleting contact" },
      { status: 500 }
    );
  }
}
