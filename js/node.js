function Node(name) {
    this.name = name;
    this.val_s = 0;
    this.val_h = 0;
}

Node.prototype.conversion = function() {
    console.log("Decimal: ", this.val_s);
    return this.val_s;
}
