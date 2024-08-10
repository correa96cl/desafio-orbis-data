 

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
    stock INT NOT NULL,
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
    descuento DECIMAL(10,2) DEFAULT 0,
    FOREIGN KEY (empleado_id) REFERENCES Empleados(empleado_id)
);

CREATE TABLE Detalles_Venta (
    detalle_venta_id INT PRIMARY KEY AUTO_INCREMENT,
    venta_id INT,
    producto_id INT,
    cantidad INT,
    precio_unitario DECIMAL(10,2),
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

CREATE TABLE Historial_Precios (
    historial_precio_id INT PRIMARY KEY AUTO_INCREMENT,
    producto_id INT NOT NULL,
    precio DECIMAL(10,2) NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE,
    FOREIGN KEY (producto_id) REFERENCES Productos(producto_id),
    INDEX idx_producto_fecha_inicio (producto_id, fecha_inicio)
);


CREATE TABLE Puntos_Fidelidad (
    puntos_fidelidad_id INT PRIMARY KEY AUTO_INCREMENT,
    cliente_id INT NOT NULL,
    venta_id INT NOT NULL,
    puntos_ganados INT NOT NULL,
    fecha_acumulacion DATE NOT NULL,
    saldo_actual INT,
    FOREIGN KEY (cliente_id) REFERENCES Clientes(cliente_id),
    FOREIGN KEY (venta_id) REFERENCES Ventas(venta_id),
    INDEX idx_cliente_fecha (cliente_id, fecha_acumulacion)
);





CREATE INDEX idx_fecha_cliente ON Ventas (fecha, cliente_id);
CREATE INDEX idx_empleado_fecha ON Ventas (empleado_id, fecha);
CREATE INDEX idx_venta_producto ON Detalles_Venta (venta_id, producto_id);
CREATE INDEX idx_fecha_inicio_fin ON Promociones (fecha_inicio, fecha_fin);
CREATE INDEX idx_tipo_activo ON Promociones (tipo, activo);
CREATE INDEX idx_proveedor_producto ON Productos_Proveedores (proveedor_id, producto_id);
CREATE INDEX idx_apellido_nombre ON Clientes (apellidos, nombre);
CREATE INDEX idx_tarjeta_fidelidad ON Clientes (tarjeta_fidelidad);
CREATE INDEX idx_departamento_puesto ON Empleados (departamento, puesto);



commit;
