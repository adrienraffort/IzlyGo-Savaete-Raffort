package com.example.demo.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.validation.constraints.NotNull;


import lombok.Data;

@Entity
@Data
public class Formation {

    @Id
    @Column
    private long id;

    @Column
    @NotNull(message="{NotNull.Formation.libelle}")
    private String libelle;

    @Column
    @NotNull(message="{NotNull.Formation.chemin}")
    private String chemin;

}
