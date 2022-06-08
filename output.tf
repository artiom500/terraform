output "load_balancer_public_ip" {
  description = "Public IP address of load balancer"
  value = yandex_lb_network_load_balancer.lb.listener.*.external_address_spec[0].*.address
}