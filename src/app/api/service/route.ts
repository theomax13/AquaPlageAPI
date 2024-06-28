// app/api/service/route.ts
import { NextRequest, NextResponse } from "next/server";
import { PrismaClient } from "@prisma/client";

const prisma = new PrismaClient();

export async function GET() {
  try {
    const services = await prisma.service.findMany();
    return NextResponse.json(services);
  } catch (error) {
    console.error("Error fetching services:", error);
    return NextResponse.json(
      { error: "Error fetching services" },
      { status: 500 }
    );
  }
}

export async function POST(request: NextRequest) {
  try {
    const { plage_id, service } = await request.json();

    if (!plage_id || !service) {
      return NextResponse.json(
        { error: "Missing required data" },
        { status: 400 }
      );
    }

    const newService = await prisma.service.create({
      data: {
        plage_id,
        service,
      },
    });
    return NextResponse.json(newService, { status: 201 });
  } catch (error) {
    console.error("Error adding service:", error);
    return NextResponse.json(
      { error: "Error adding service" },
      { status: 500 }
    );
  }
}

export async function PUT(request: NextRequest) {
  try {
    const { id, plage_id, service } = await request.json();

    if (!id || !plage_id || !service) {
      return NextResponse.json(
        { error: "Missing required data" },
        { status: 400 }
      );
    }

    const updatedService = await prisma.service.update({
      where: { id: Number(id) },
      data: {
        plage_id,
        service,
      },
    });
    return NextResponse.json(updatedService);
  } catch (error) {
    console.error("Error updating service:", error);
    return NextResponse.json(
      { error: "Error updating service" },
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

    const deletedService = await prisma.service.delete({
      where: { id: Number(id) },
    });
    return NextResponse.json(deletedService);
  } catch (error) {
    console.error("Error deleting service:", error);
    return NextResponse.json(
      { error: "Error deleting service" },
      { status: 500 }
    );
  }
}
