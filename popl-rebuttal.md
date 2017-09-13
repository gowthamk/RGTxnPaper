We thank the reviewers for their valuable feedback.

Reviewer A
-----------

- Read Uncommitted (RU) isolation: While RU is a valid ANSI SQL
  isolation level, it is typically not implemented by modern
  databases. For example, Oracle supports only RC and SER, while
  Postgres maps RU to RC. Even when RU is supported, it is never the
  default isolation level (Bailis et al, HotOS'13)., and applications
  rarely demote isolation levels to RU in practice (Bailis et al,
  SIGMOD'15). Furthermore, RU violates atomicity, the basic tenet
  underlying transactions.  Given its lack of acceptance in the
  database community, and the complications it would introduce to our
  formalization, we opted to use RC as the baseline isolation level.

- Limited set of operations in the DSL: While it is true our language
  only includes four basic SQL operations, they have proven sufficient
  to implement widely accepted benchmarks, such TPC-C and TPC-E. We
  also note that MySQL's [developer
  documentation](https://dev.mysql.com/doc/internals/en/) (also see: S
  Pachev, Understanding MySQL Internals, 1st Edition, Chapter 9)
  indicates that its core calculus for SQL is indeed composed of these
  four basic operations, making our technique likely applicable on
  MySQL's core language, if not its surface language. We expect
  similar conclusions to hold on other databases.

Reviewer B
-------------

- Isolation levels weaker than RC: please see above.

- Not admitting valid snapshot isolation (SI) executions:  We believe
  the reviewer has misunderstood our specification for SI as $I_{ss}$,
  which only describes the semantics of "executing against a
  snapshot". SI indeed executes against a snapshot (thus its $I_e =
  I_{ss}$), but it *commits* against any non-write-write-conflicting
  database state (thus its $I_c = I_{ww}$). This is explained on p.13
  ("Snapshot Isolation"). The presented specification indeed allows
  non-conflicting concurrent transactions to commit in parallel, and hence
  admits all SI executions.

- Decidability: The RG-TXN (Sec. 5.2, p. 20) rule does not lead to
  second-order quantification or quantified formulas with negation at
  prenex position. Sets are encoded as uninterpreted functions (Fig.
  10), and quantified set variables are simply replaced with new
  function symbols that occur free in the encoded formula.  Consider
  the ${\sf F} \Rightarrow G$ premise of RG-TXN. The quantified set
  variables $\delta$ and $\Delta$ are instantiated with fresh function
  variables $f_{\delta}$ and $f_{\Delta}$, respectively, resulting in
  a quantifier-free implication with free function symbols. The
  antecedent of this implication (${\sf F}$) is asserted as such, but
  its consequent ($G$) is negated before checking the satisfiability
  of the entire formula. This is a standard approach often employed to
  discharge verification conditions of the form $\forall a. \phi_1(a)
  \Rightarrow \phi_2(a)$.  In this process: (i). sets or functions are
  never quantified (thus no second-order quantification), and
  (ii). ${\sf F}$ is never negated (thus no inversion of quantifiers
  in ${\sf F}$). Other premises are similarly encoded.

  The reviewer is correct in observing that our encoding is not in the
  EPR fragment of FOL.  However, our encoding is still decidable as it
  belongs to a closely related variant of EPR, Godel-Kalmar-Schutte,
  that admits sentences of the form:
  $\exists^{*}\forall^{2}\exists^{*}$ (see: Borger et al, The
  Classical Decision Problem, 1st Edition, p.261, and Gurevich, On the
  Classical Decision Problem, p.7); formulas generated by our encoding
  clearly belong to this fragment.  We will clarify this issue in the
  final version.

- Local Context Independence: This assumption is used by the inference
  rule for `FOREACH`. The rule computes the transformer of a loop by
  lifting the transformer (${\sf F}$) of its body. In the process, it
  assumes that the effect of each loop iteration depends only on
  the loop variable $z$, but not on local ($\delta$) and global
  ($\Delta$) states (observe that ${\sf F}$ is applied to the same
  $\delta$ and $\Delta$ forall $z$). While independence on $\Delta$ is
  gauranteed by the stability condition (checked separately), the
  independence on the local state $\delta$ is simply assumed.


Reviewer C
-------------

- Dealing with heap state: It is indeed true that we have ignored heap
  memory to focus exclusively on database state in our
  formalization. Swamy et al. (PLDI'13), however, have proposed the
  Dijkstra monad to reason about heap memory monadically.  As part of
  future work, we intend to explore the composition of the DB and
  Dijkstra monads to enable reasoning over both heap and database
  state.
