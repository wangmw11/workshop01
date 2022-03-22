data digitalocean_ssh_key shawn_key {
  name = "shawn_key"
}

// Image
resource docker_image dov-bear {
    name = "chukmunnlee/dov-bear:v2"
    keep_locally = true
}

// container
resource docker_container dov-bear-container {
    count = 3
    name = "dov-${count.index}"
    image = docker_image.dov-bear.latest
    ports {
        internal = 3000
        //external = 8080
    }
}


output dov-names {
    value = docker_container.dov-bear-container[*].name
}

output external-ports {
    value = docker_container.dov-bear-container[*].ports[*].external  
}

output shawn_fingerprint {
    value = data.digitalocean_ssh_key.shawn_key.fingerprint
}

