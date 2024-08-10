

-- Creación de tablas
CREATE TABLE Categorias (
    categoria_id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL
);

CREATE TABLE Productos (
    producto_id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT,
    precio_venta DECIMAL(10,2) NOT NULL,
    stock INT,
    categoria_id INT,
    FOREIGN KEY (categoria_id) REFERENCES Categorias(categoria_id)
);

CREATE TABLE Proveedores (
    proveedor_id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    direccion TEXT
);

CREATE TABLE Productos_Proveedores (
    producto_id INT,
    proveedor_id INT,
    precio_compra DECIMAL(10,2),
    PRIMARY KEY (producto_id, proveedor_id),
    FOREIGN KEY (producto_id) REFERENCES Productos(producto_id),
    FOREIGN KEY (proveedor_id) REFERENCES Proveedores(proveedor_id)
);

CREATE TABLE Empleados (
    empleado_id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    puesto VARCHAR(50),
    salario DECIMAL(10,2),
    fecha_contratacion DATE,
    departamento VARCHAR(50)
);

CREATE TABLE Clientes (
    cliente_id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    apellidos VARCHAR(100) NOT NULL,
    direccion TEXT,
    telefono VARCHAR(20),
    email VARCHAR(100),
    fecha_registro DATE,
    tarjeta_fidelidad BOOLEAN DEFAULT FALSE,
    puntos INT DEFAULT 0
);
CREATE TABLE Ventas (
    venta_id INT PRIMARY KEY AUTO_INCREMENT,
    fecha DATE NOT NULL,
    cliente_id INT,
    empleado_id INT,
    total DECIMAL(10,2) NOT NULL,
    forma_pago VARCHAR(50),
    descuento DECIMAL(10,2) DEFAULT 0
);

CREATE TABLE Detalles_Venta (
    venta_id INT,
    producto_id INT,
    cantidad INT,
    precio_unitario DECIMAL(10,2),
    PRIMARY KEY (venta_id, producto_id),
    FOREIGN KEY (venta_id) REFERENCES Ventas(venta_id),
    FOREIGN KEY (producto_id) REFERENCES Productos(producto_id)
);

CREATE TABLE Promociones (
    promocion_id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT,
    fecha_inicio DATE,
    fecha_fin DATE,
    tipo ENUM('descuento_porcentaje', 'descuento_fijo', 'producto_gratis', '2x1'),
    valor DECIMAL(10,2),
    minimo_compra DECIMAL(10,2),
    activo BOOLEAN DEFAULT TRUE,
    categoria_id INT,
    producto_id INT,
    FOREIGN KEY (categoria_id) REFERENCES Categorias(categoria_id),
    FOREIGN KEY (producto_id) REFERENCES Productos(producto_id)
);




-- ... (continuar con las demás tablas: Empleados, Clientes, Ventas, Detalles_Venta, Promociones)

-- Creación de índices (ejemplo)
CREATE INDEX idx_productos_nombre ON Productos(nombre);
CREATE INDEX idx_ventas_fecha ON Ventas(fecha);

commit;
