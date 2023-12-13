Return-Path: <stable+bounces-5061-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E00980AD62
	for <lists+stable@lfdr.de>; Fri,  8 Dec 2023 20:54:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A27E281B30
	for <lists+stable@lfdr.de>; Fri,  8 Dec 2023 19:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE1CB55C2F;
	Fri,  8 Dec 2023 19:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Jeuqri0g"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7976550242;
	Fri,  8 Dec 2023 19:54:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04078C433C8;
	Fri,  8 Dec 2023 19:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1702065244;
	bh=SJxST20NhyTnjXqbUfKqTJV+JfeOReo01Em5Ogn5+xg=;
	h=Date:To:From:Subject:From;
	b=Jeuqri0g1Hg3qUXXoJ6U5/mnuq0FhBiJ27dHkNEkXWkFpZwaFCqZyVuqTmQFASFEo
	 RVxBJp5w65jJvipWsoPhMcbQ/tO7VetSGlKz6Nuxre/wuXvIR2LRL4XIaYHvTwVINk
	 y5ChGij1u9h8WrDFgPZsYA09f4Odl0kzEM/+Br4M=
Date: Fri, 08 Dec 2023 11:54:03 -0800
To: mm-commits@vger.kernel.org,tjmercier@google.com,stable@vger.kernel.org,ryncsn@gmail.com,quic_charante@quicinc.com,kaleshsingh@google.com,jaroslav.pulchart@gooddata.com,hdanton@sina.com,yuzhao@google.com,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: + mm-mglru-respect-min_ttl_ms-with-memcgs.patch added to mm-hotfixes-unstable branch
Message-Id: <20231208195404.04078C433C8@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>


The patch titled
     Subject: mm/mglru: respect min_ttl_ms with memcgs
has been added to the -mm mm-hotfixes-unstable branch.  Its filename is
     mm-mglru-respect-min_ttl_ms-with-memcgs.patch

This patch will shortly appear at
     https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/mm-mglru-respect-min_ttl_ms-with-memcgs.patch

This patch will later appear in the mm-hotfixes-unstable branch at
    git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

Before you just go and hit "reply", please:
   a) Consider who else should be cc'ed
   b) Prefer to cc a suitable mailing list as well
   c) Ideally: find the original patch on the mailing list and do a
      reply-to-all to that, adding suitable additional cc's

*** Remember to use Documentation/process/submit-checklist.rst when testing your code ***

The -mm tree is included into linux-next via the mm-everything
branch at git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
and is updated there every 2-3 working days

------------------------------------------------------
From: Yu Zhao <yuzhao@google.com>
Subject: mm/mglru: respect min_ttl_ms with memcgs
Date: Thu, 7 Dec 2023 23:14:06 -0700

While investigating kswapd "consuming 100% CPU" [1] (also see "mm/mglru:
try to stop at high watermarks"), it was discovered that the memcg LRU can
breach the thrashing protection imposed by min_ttl_ms.

Before the memcg LRU:
  kswapd()
    shrink_node_memcgs()
      mem_cgroup_iter()
        inc_max_seq()  // always hit a different memcg
    lru_gen_age_node()
      mem_cgroup_iter()
        check the timestamp of the oldest generation

After the memcg LRU:
  kswapd()
    shrink_many()
      restart:
        iterate the memcg LRU:
          inc_max_seq()  // occasionally hit the same memcg
          if raced with lru_gen_rotate_memcg():
            goto restart
    lru_gen_age_node()
      mem_cgroup_iter()
        check the timestamp of the oldest generation

Specifically, when the restart happens in shrink_many(), it needs to stick
with the (memcg LRU) generation it began with.  In other words, it should
neither re-read memcg_lru->seq nor age an lruvec of a different
generation.  Otherwise it can hit the same memcg multiple times without
giving lru_gen_age_node() a chance to check the timestamp of that memcg's
oldest generation (against min_ttl_ms).

[1] https://lore.kernel.org/CAK8fFZ4DY+GtBA40Pm7Nn5xCHy+51w3sfxPqkqpqakSXYyX+Wg@mail.gmail.com/

Link: https://lkml.kernel.org/r/20231208061407.2125867-3-yuzhao@google.com
Fixes: e4dde56cd208 ("mm: multi-gen LRU: per-node lru_gen_folio lists")
Signed-off-by: Yu Zhao <yuzhao@google.com>
Tested-by: T.J. Mercier <tjmercier@google.com>
Cc: Charan Teja Kalla <quic_charante@quicinc.com>
Cc: Hillf Danton <hdanton@sina.com>
Cc: Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>
Cc: Kairui Song <ryncsn@gmail.com>
Cc: Kalesh Singh <kaleshsingh@google.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 include/linux/mmzone.h |   30 +++++++++++++++++-------------
 mm/vmscan.c            |   30 ++++++++++++++++--------------
 2 files changed, 33 insertions(+), 27 deletions(-)

--- a/include/linux/mmzone.h~mm-mglru-respect-min_ttl_ms-with-memcgs
+++ a/include/linux/mmzone.h
@@ -505,33 +505,37 @@ void lru_gen_look_around(struct page_vma
  * the old generation, is incremented when all its bins become empty.
  *
  * There are four operations:
- * 1. MEMCG_LRU_HEAD, which moves an memcg to the head of a random bin in its
+ * 1. MEMCG_LRU_HEAD, which moves a memcg to the head of a random bin in its
  *    current generation (old or young) and updates its "seg" to "head";
- * 2. MEMCG_LRU_TAIL, which moves an memcg to the tail of a random bin in its
+ * 2. MEMCG_LRU_TAIL, which moves a memcg to the tail of a random bin in its
  *    current generation (old or young) and updates its "seg" to "tail";
- * 3. MEMCG_LRU_OLD, which moves an memcg to the head of a random bin in the old
+ * 3. MEMCG_LRU_OLD, which moves a memcg to the head of a random bin in the old
  *    generation, updates its "gen" to "old" and resets its "seg" to "default";
- * 4. MEMCG_LRU_YOUNG, which moves an memcg to the tail of a random bin in the
+ * 4. MEMCG_LRU_YOUNG, which moves a memcg to the tail of a random bin in the
  *    young generation, updates its "gen" to "young" and resets its "seg" to
  *    "default".
  *
  * The events that trigger the above operations are:
  * 1. Exceeding the soft limit, which triggers MEMCG_LRU_HEAD;
- * 2. The first attempt to reclaim an memcg below low, which triggers
+ * 2. The first attempt to reclaim a memcg below low, which triggers
  *    MEMCG_LRU_TAIL;
- * 3. The first attempt to reclaim an memcg below reclaimable size threshold,
+ * 3. The first attempt to reclaim a memcg below reclaimable size threshold,
  *    which triggers MEMCG_LRU_TAIL;
- * 4. The second attempt to reclaim an memcg below reclaimable size threshold,
+ * 4. The second attempt to reclaim a memcg below reclaimable size threshold,
  *    which triggers MEMCG_LRU_YOUNG;
- * 5. Attempting to reclaim an memcg below min, which triggers MEMCG_LRU_YOUNG;
+ * 5. Attempting to reclaim a memcg below min, which triggers MEMCG_LRU_YOUNG;
  * 6. Finishing the aging on the eviction path, which triggers MEMCG_LRU_YOUNG;
- * 7. Offlining an memcg, which triggers MEMCG_LRU_OLD.
+ * 7. Offlining a memcg, which triggers MEMCG_LRU_OLD.
  *
- * Note that memcg LRU only applies to global reclaim, and the round-robin
- * incrementing of their max_seq counters ensures the eventual fairness to all
- * eligible memcgs. For memcg reclaim, it still relies on mem_cgroup_iter().
+ * Notes:
+ * 1. Memcg LRU only applies to global reclaim, and the round-robin incrementing
+ *    of their max_seq counters ensures the eventual fairness to all eligible
+ *    memcgs. For memcg reclaim, it still relies on mem_cgroup_iter().
+ * 2. There are only two valid generations: old (seq) and young (seq+1).
+ *    MEMCG_NR_GENS is set to three so that when reading the generation counter
+ *    locklessly, a stale value (seq-1) does not wraparound to young.
  */
-#define MEMCG_NR_GENS	2
+#define MEMCG_NR_GENS	3
 #define MEMCG_NR_BINS	8
 
 struct lru_gen_memcg {
--- a/mm/vmscan.c~mm-mglru-respect-min_ttl_ms-with-memcgs
+++ a/mm/vmscan.c
@@ -4089,6 +4089,9 @@ static void lru_gen_rotate_memcg(struct
 	else
 		VM_WARN_ON_ONCE(true);
 
+	WRITE_ONCE(lruvec->lrugen.seg, seg);
+	WRITE_ONCE(lruvec->lrugen.gen, new);
+
 	hlist_nulls_del_rcu(&lruvec->lrugen.list);
 
 	if (op == MEMCG_LRU_HEAD || op == MEMCG_LRU_OLD)
@@ -4099,9 +4102,6 @@ static void lru_gen_rotate_memcg(struct
 	pgdat->memcg_lru.nr_memcgs[old]--;
 	pgdat->memcg_lru.nr_memcgs[new]++;
 
-	lruvec->lrugen.gen = new;
-	WRITE_ONCE(lruvec->lrugen.seg, seg);
-
 	if (!pgdat->memcg_lru.nr_memcgs[old] && old == get_memcg_gen(pgdat->memcg_lru.seq))
 		WRITE_ONCE(pgdat->memcg_lru.seq, pgdat->memcg_lru.seq + 1);
 
@@ -4124,11 +4124,11 @@ void lru_gen_online_memcg(struct mem_cgr
 
 		gen = get_memcg_gen(pgdat->memcg_lru.seq);
 
+		lruvec->lrugen.gen = gen;
+
 		hlist_nulls_add_tail_rcu(&lruvec->lrugen.list, &pgdat->memcg_lru.fifo[gen][bin]);
 		pgdat->memcg_lru.nr_memcgs[gen]++;
 
-		lruvec->lrugen.gen = gen;
-
 		spin_unlock_irq(&pgdat->memcg_lru.lock);
 	}
 }
@@ -4635,7 +4635,7 @@ static long get_nr_to_scan(struct lruvec
 	DEFINE_MAX_SEQ(lruvec);
 
 	if (mem_cgroup_below_min(sc->target_mem_cgroup, memcg))
-		return 0;
+		return -1;
 
 	if (!should_run_aging(lruvec, max_seq, sc, can_swap, &nr_to_scan))
 		return nr_to_scan;
@@ -4710,7 +4710,7 @@ static bool try_to_shrink_lruvec(struct
 		cond_resched();
 	}
 
-	/* whether try_to_inc_max_seq() was successful */
+	/* whether this lruvec should be rotated */
 	return nr_to_scan < 0;
 }
 
@@ -4764,13 +4764,13 @@ static void shrink_many(struct pglist_da
 	struct lruvec *lruvec;
 	struct lru_gen_folio *lrugen;
 	struct mem_cgroup *memcg;
-	const struct hlist_nulls_node *pos;
+	struct hlist_nulls_node *pos;
 
+	gen = get_memcg_gen(READ_ONCE(pgdat->memcg_lru.seq));
 	bin = first_bin = get_random_u32_below(MEMCG_NR_BINS);
 restart:
 	op = 0;
 	memcg = NULL;
-	gen = get_memcg_gen(READ_ONCE(pgdat->memcg_lru.seq));
 
 	rcu_read_lock();
 
@@ -4781,6 +4781,10 @@ restart:
 		}
 
 		mem_cgroup_put(memcg);
+		memcg = NULL;
+
+		if (gen != READ_ONCE(lrugen->gen))
+			continue;
 
 		lruvec = container_of(lrugen, struct lruvec, lrugen);
 		memcg = lruvec_memcg(lruvec);
@@ -4865,16 +4869,14 @@ static void set_initial_priority(struct
 	if (sc->priority != DEF_PRIORITY || sc->nr_to_reclaim < MIN_LRU_BATCH)
 		return;
 	/*
-	 * Determine the initial priority based on ((total / MEMCG_NR_GENS) >>
-	 * priority) * reclaimed_to_scanned_ratio = nr_to_reclaim, where the
-	 * estimated reclaimed_to_scanned_ratio = inactive / total.
+	 * Determine the initial priority based on
+	 * (total >> priority) * reclaimed_to_scanned_ratio = nr_to_reclaim,
+	 * where reclaimed_to_scanned_ratio = inactive / total.
 	 */
 	reclaimable = node_page_state(pgdat, NR_INACTIVE_FILE);
 	if (get_swappiness(lruvec, sc))
 		reclaimable += node_page_state(pgdat, NR_INACTIVE_ANON);
 
-	reclaimable /= MEMCG_NR_GENS;
-
 	/* round down reclaimable and round up sc->nr_to_reclaim */
 	priority = fls_long(reclaimable) - 1 - fls_long(sc->nr_to_reclaim - 1);
 
_

Patches currently in -mm which might be from yuzhao@google.com are

mm-mglru-fix-underprotected-page-cache.patch
mm-mglru-try-to-stop-at-high-watermarks.patch
mm-mglru-respect-min_ttl_ms-with-memcgs.patch
mm-mglru-reclaim-offlined-memcgs-harder.patch


