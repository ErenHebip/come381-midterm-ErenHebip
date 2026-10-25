# Gym Membership System

This project models a gym membership system with membership plans, members, trainers, fitness classes, and class registrations. Each member can have a membership plan, and each fitness class is assigned to a trainer. Members can register for multiple fitness classes, and each class can have multiple members, so the many-to-many relationship is represented by the `class_registration` table. This associative table stores registration details and connects members to the classes they attend.
