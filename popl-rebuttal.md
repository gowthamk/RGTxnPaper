Firstly, we thank the reviewers for their valuable feedback.

1. Read Uncommitted (RU), while a valid ANSI SQL isolation level, is
   often not implemented by the databases. For eg., Oracle supports
   only RC and SER, while Postgres maps RU to RC. Even when RU is
   implemented, it is never the default isolation level (Bailis et al,
   HotOS'13), and applications almost never demote the isolation level
   in practice (Bailis et al, SIGMOD'15). Thus, RC can be considered
   as a baseline isolation level that meets the performance demands of
   real-world applications. Lastly, RU violates atomicity, the basic
   tenet underlying transactions, and accommodating it would
   significantly complicate the formal framework, jeopardizing
   automation. Weighing such pros and cons, we decided to elide RU.

2. While our language only includes the four basic SQL operations,
   they are nonetheless enough to implement database community's
   standard benchmarks, such TPC-C and TPC-E. Moreover, MySQL's
   [developer documentation](https://dev.mysql.com/doc/internals/en/)
   seems to indicate that its core calculus for SQL is indeed composed
   of these four basic operations, making our technique likely
   applicable on MySQL's core language, if not its surface language.
   We haven't analyzed other databases, but if the need arises, we can
   accommodate database-specific semantics as elaboration rules on the
   lines described in Sec. 6.1 para 1. 

3. About our framework not admitting all SI executions, the reviewer has 
   possibly misunderstood our specification for SI as
   $I_{ss}$, which only describes the semantics of "executing
   against a snapshot". SI indeed executes against a snapshot (thus its $I_e
   = I_{ss}$), but it commits against any non-write-write-conflicting
   database state (thus its $I_c = I_{ww}$). This is explained under
   "Snapshot Isolation" heading on p.13. Observe that the spec allows
   non-conflicting concurrent transactions to commit in parallel.

4. The RG-TXN rule does not lead to second-order quantification or
   inversion of quantifier positions for the reasons described below.
   Firstly, lets recall that each premise of the rule generates an
   independent verification condition (VC) dispatched to the solver.
   The VC corresponding to $F\Rightarrow G$ first introduces $\delta$
   and $\Delta$ into the context as *some* sets (uninterpreted
   functions, to be precise). Next, it asserts the logical encoding of
   $F$ computed using the rules in Fig.10. Finally it asserts the
   negation of $G$, and checks for satisfiability. Note that in this
   process: (a). Sets or functions are never quantified (thus no
   second-order quantification), and (b). $F$ is never negated (thus
   no inversion of quantifiers in $F$). Other premises are similarly
   encoded.

5. We have been a bit sloppy about describing the fragment of FOL that
   our logic belongs to. The reviewer is indeed right that $\forall
   x.\exists y.\phi$ doesn't belong to EPR. The appropriate fragment
   in our case is a closely related fragment called
   Godel-Kalmar-Schutte, which admits sentences of form
   $\exists^{*}\forall^{2}\exists^{*}$, while remaining decidable
   (Borger et al, The Classical Decision Problem, p.261; Gurevich, On
   the Classical Decision Problem, p.7). We apologize for not being
   precise, and will promptly correct the mistake.

6. We have ignored heap memory to focus on the database state in this
   paper. N Swamy et al (PLDI'13) have proposed Dijkstra monad to
   reason about heap memory monadically, and it would be interesting
   to see if Dijkstra and DB monads can be cleanly composed to reason
   about the combination of heap and database.
