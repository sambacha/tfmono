resource "aws_vpc" "vpc" {
  cidr_block = "${var.cidr_block}"

  enable_dns_hostnames = true

}

resource "aws_subnet" "public_subnet" {
  count                   = "${length(var.availability_zones)}"
  vpc_id                  = "${aws_vpc.vpc.id}"
  availability_zone       = "${element(var.availability_zones, count.index)}"
  cidr_block              = "${element(var.subnets, count.index)}"
  map_public_ip_on_launch = true
}

resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = "${aws_vpc.vpc.id}"
}

resource "aws_route_table" "igw_route_table" {
  vpc_id = "${aws_vpc.vpc.id}"
}

resource "aws_route" "igw_route" {
  route_table_id         = "${aws_route_table.igw_route_table.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.internet_gateway.id}"
}

resource "aws_route_table_association" "public_route" {
  count          = "${length(var.availability_zones)}"
  subnet_id      = "${element(aws_subnet.public_subnet.*.id, count.index)}"
  route_table_id = "${aws_route_table.igw_route_table.id}"
}