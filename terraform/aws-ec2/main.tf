provider "aws" {
  region = "eu-central-1"
}

resource "aws_key_pair" "ansible" {
  key_name   = "ansible-key"
  public_key = file("~/.ssh/id_ed25519.pub")
}


resource "aws_instance" "monitor" {
  launch_template {
    id = var.template_id
    version = "$Latest"
  }

  key_name = aws_key_pair.ansible.key_name
  tags = {
    Name = "Prometheus-Grafana-Server"
    Project = "Monitoring-Stack-Training"
  }
}
output "server_public_ip" {
  description = "The public IP address of the monitoring server"
  value       = aws_instance.monitor.public_ip
}
resource "local_file" "ansible_inventory" {
  # We use the IP from the instance created above and format it for Ansible
  content = <<-EOF
    [monitoring]
    ${aws_instance.monitor.public_ip} ansible_user=${var.username}
  EOF
  
  # This saves the file as 'inventory.ini' in the same folder as your main.tf
  filename = "${path.module}/ansible-monitor/inventory.ini"
}