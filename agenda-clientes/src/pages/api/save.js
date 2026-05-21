import fs from "fs";
import path from "path";

export const POST = async ({ request }) => {
  try {
    const data = await request.json();
    const { type, content } = data;

    let fileName = "clientes.json";
    if (type === "config") {
       fileName = "config.json";
    }

    const esProduccion = process.env.NODE_ENV === 'production' || !fs.existsSync('./src');
    const folder = esProduccion ? 'data' : 'src/data';
    
    const filePath = path.join(process.cwd(), folder, fileName);
    
    // Logging for debugging
    fs.appendFileSync(path.join(process.cwd(), "api_debug.log"), `Saving ${type} to ${filePath} at ${new Date().toISOString()}\n`);

    if (!fs.existsSync(folder)) {
      fs.mkdirSync(folder, { recursive: true });
    }
    fs.writeFileSync(filePath, JSON.stringify(content, null, 2), "utf-8");

    return new Response(JSON.stringify({ success: true, message: "Datos guardados correctamente" }), {
      status: 200,
      headers: { "Content-Type": "application/json" }
    });
  } catch (error) {
    console.error("Error saving data:", error);
    return new Response(JSON.stringify({ success: false, message: error.message }), {
      status: 500,
      headers: { "Content-Type": "application/json" }
    });
  }
};
