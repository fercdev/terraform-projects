# Terraform Examples

Ejemplos básicos de Terraform contenidos en este directorio.

## Estructura

```text
Terraform-examples/
├── primer-proyecto/             # Ejemplo simple: bucket S3 en AWS
│   └── main.tf
├── proyecto-docker/             # Ejemplo local: contenedor nginx con Docker
│   └── main.tf
└── proyecto-compuesto-terraform/ # Ejemplo estructurado con variables y outputs (S3 + IAM)
    ├── main.tf
    ├── providers.tf
    ├── variables.tf
    ├── terraform.tfvars
    ├── outputs.tf
    ├── versions.tf
    └── .gitignore
```

### 1. `primer-proyecto/`
Crea un bucket S3 (`primer-bucket-aws-terraform`) en `us-east-1`.

### 2. `proyecto-docker/`
Descarga la imagen `nginx:latest` y levanta un contenedor `nginx_terraform_container` con el puerto `9080 -> 80`. No requiere AWS, solo Docker local.

### 3. `proyecto-compuesto-terraform/`
Ejemplo ordenado con buenas prácticas:
- `versions.tf`: versión mínima de Terraform (`>=1.5.0`) y provider AWS (`~> 5.0`).
- `providers.tf`: provider AWS con región parametrizada.
- `variables.tf` + `terraform.tfvars`: parámetros (`aws_region`, `bucket_name`, `environment`, `project_name`, `iam_user_name`).
- `main.tf`: crea un bucket S3 y un usuario IAM.
- `outputs.tf`: muestra el nombre del bucket y del usuario.

## Requisitos previos

1. Instalar Terraform:
   ```powershell
   terraform -version
   ```
2. Para proyectos AWS (`primer-proyecto`, `proyecto-compuesto-terraform`):
   - Instalar AWS CLI y configurar credenciales:
   ```powershell
   aws configure
   ```
   - Verificar con `aws sts get-caller-identity`.
3. Para `proyecto-docker`:
   - Instalar y tener corriendo Docker Desktop.

## Cómo inicializar cualquier proyecto

Ejecuta estos comandos **dentro de la carpeta del proyecto** que quieras probar:

```powershell
cd primer-proyecto
# o: cd proyecto-docker
# o: cd proyecto-compuesto-terraform

terraform init
terraform validate
terraform plan
terraform apply
```

Detalle de cada paso:

1. `terraform init` — Descarga los providers necesarios (AWS, Docker) e inicializa el directorio `.terraform/`. Solo se hace una vez (o cuando cambian providers/versiones).
2. `terraform validate` — Valida la sintaxis de los archivos `.tf`.
3. `terraform plan` — Muestra qué recursos se van a crear/modificar, sin aplicar cambios.
4. `terraform apply` — Aplica los cambios. Pide confirmación con `yes`.
   - Para aplicar sin confirmación: `terraform apply -auto-approve`
5. `terraform destroy` — Elimina todos los recursos creados por ese proyecto.

## Ejemplos por proyecto

### Primer proyecto (S3 simple)
```powershell
cd primer-proyecto
terraform init
terraform plan
terraform apply
```

### Proyecto Docker (nginx local)
```powershell
cd proyecto-docker
terraform init
terraform apply
# Verificar en http://localhost:9080
terraform destroy
```

### Proyecto compuesto (variables + outputs)
```powershell
cd proyecto-compuesto-terraform
terraform init
terraform plan
terraform apply
# Ver outputs:
terraform output
terraform destroy
```

Puedes personalizar los valores editando `terraform.tfvars` o pasándolos por línea de comandos:
```powershell
terraform apply -var="bucket_name=mi-otro-bucket" -var="environment=prod"
```

## Notas
- No subir al repositorio `.terraform/`, `terraform.tfstate` ni `terraform.tfstate.backup` (ya ignorados en `proyecto-compuesto-terraform/.gitignore`).
- Los nombres de buckets S3 deben ser únicos globalmente. Si `apply` falla por nombre duplicado, cambia `bucket_name`.
