variable "yc_subnet" {
  description = "Name of the yandex cloud subnet"
  type        = string
  default     = "default-ru-central1-a"
}

variable "image_family" {
  description = "Name of the image family"
  type        = string
  default     = "ubuntu-1804-lts"
}

variable "image_folder_id" {
  description = "Name of the image folder id"
  type        = string
  default     = "standard-images"
}

variable "instance_count" {
  description = "Count of created instance"
  type        = number
  default     = 1
}

variable "prefix" {
  description = "Prefix to identify creator"
  type        = string
  default     = "sg-soap-at-gmail-com"
}

variable "instance_type" {
  description = "Type of created instance"
  type        = string
  default     = "app"
}

variable "platform_id" {
  description = "Specifies platform for the instance"
  type        = string
  default     = "standard-v1"
}

variable "instance_zone" {
  description = "Specifies platform for the instance"
  type        = string
  default     = "ru-central1-a"
}

variable "allow_stopping" {
  description = "Allow stopping instance for update"
  type        = bool
  default     = true
}

variable "instance_cores" {
  description = "Sets count of instance cores"
  type        = number
  default     = 2
}

variable "instance_memory" {
  description = "Sets count of instance memory"
  type        = number
  default     = 2
}

variable "instance_core_fraction" {
  description = "Sets baseline performance for each core. Value must be one of 0, 5, 20, 50 or 100"
  type        = number
  default     = 5
}

variable "instance_disk_size" {
  description = "Sets size of instance drive"
  type        = number
  default     = 6
}

variable "allow_nat" {
  description = "Allow to use nat"
  type        = bool
  default     = true
}

variable "task_name" {
  description = "Name of course task"
  type        = string
  default     = "do-37"
}

variable "user_email" {
  description = "Specifies user email"
  type        = string
  default     = "sg.soap@gmail.com"
}

variable "ssh_username" {
  description = "SSH user to deploy to instance"
  type        = string
  default     = "ubuntu"
}

variable "ssh_pubkey" {
  description = "SSH key to deploy to instance"
  type        = string
  default     = "/home/sg/.ssh/id_ed25519.pub"
}
