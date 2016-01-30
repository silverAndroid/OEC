public enum Function {
    MOVE("move"), TURN_LEFT("turn left"), TURN_RIGHT("turn right"), GRAB("grab"), USE("use"), LOOK("look"),
    ADD("+"), EQUALS("="), SUBTRACT("-");

    private String name;

    Function(String name) {
        this.name = name;
    }

    public String getName() {
        return name;
    }
}