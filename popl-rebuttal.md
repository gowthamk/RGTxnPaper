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
   significantly complicate the formal framework. Weighing such pros
   and cons, we decided to elide RU.

2. While our language only includes the four basic SQL operations,
   they are nonetheless enough to implement database community's
   standard benchmarks, such TPC-C and TPC-E. Moreover, MySQL's
   (developer) documentation seems to indicate that its core calculus
   for SQL is indeed composed of these four basic operations, making
   our technique likely applicable on MySQL's core language, if not
   its surface language. We haven't analyzed other databases, but if
   the need arises, we can accommodate database-specific semantics as
   elaboration rules on the lines described in Sec. 6.1 para 1. 

3. About our framework not admitting all SI executions, it seems that
   reviewer might have misunderstood our specification for SI. The
   spec allows concurrent transactions that do not conflict with the
   current SI transaction to commit concurrently, since SI's I_c spec
   (p.11) allows Δ to change as long as it doesn't conflict with δ.

4. We have ignored heap memory to focus on the database state in this
   paper. N Swamy et al (PLDI'13) have proposed Dijkstra monad to
   reason about heap memory monadically, and it would be interesting
   to see if Diskstra and DB monads can be cleanly composed to reason
   about the combination of heap and database.

 
