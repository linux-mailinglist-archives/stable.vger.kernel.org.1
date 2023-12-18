Return-Path: <stable+bounces-7388-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9732817250
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:08:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBCB71C24DF8
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 14:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28D5842374;
	Mon, 18 Dec 2023 14:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xdJQbCR2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B2937865;
	Mon, 18 Dec 2023 14:05:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69462C433C7;
	Mon, 18 Dec 2023 14:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702908336;
	bh=vir/vxo0nVjXzStAt+MrjYqQMYrKqdXzTsiImrowmOU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xdJQbCR2ho1h/eFVWZkqUz9T6b7TnjewjOxfWuktmYk5CN2xc8f26jcqQdblL71ad
	 DtpJawj3PhXyw1/LDqszDMuPSxs7GBFa0pIOvSrWuLOpcHJeMP1zhJzTbN90wS0O9J
	 rYkRJ1C6IufVjiw6/O4wjYj9XF/+HgG+dydcZgK4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yu Zhao <yuzhao@google.com>,
	"T.J. Mercier" <tjmercier@google.com>,
	Charan Teja Kalla <quic_charante@quicinc.com>,
	Hillf Danton <hdanton@sina.com>,
	Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>,
	Kairui Song <ryncsn@gmail.com>,
	Kalesh Singh <kaleshsingh@google.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.6 139/166] mm/mglru: respect min_ttl_ms with memcgs
Date: Mon, 18 Dec 2023 14:51:45 +0100
Message-ID: <20231218135111.322074337@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231218135104.927894164@linuxfoundation.org>
References: <20231218135104.927894164@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yu Zhao <yuzhao@google.com>

commit 8aa420617918d12d1f5d55030a503c9418e73c2c upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/mmzone.h |   30 +++++++++++++++++-------------
 mm/vmscan.c            |   30 ++++++++++++++++--------------
 2 files changed, 33 insertions(+), 27 deletions(-)

--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
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
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4790,6 +4790,9 @@ static void lru_gen_rotate_memcg(struct
 	else
 		VM_WARN_ON_ONCE(true);
 
+	WRITE_ONCE(lruvec->lrugen.seg, seg);
+	WRITE_ONCE(lruvec->lrugen.gen, new);
+
 	hlist_nulls_del_rcu(&lruvec->lrugen.list);
 
 	if (op == MEMCG_LRU_HEAD || op == MEMCG_LRU_OLD)
@@ -4800,9 +4803,6 @@ static void lru_gen_rotate_memcg(struct
 	pgdat->memcg_lru.nr_memcgs[old]--;
 	pgdat->memcg_lru.nr_memcgs[new]++;
 
-	lruvec->lrugen.gen = new;
-	WRITE_ONCE(lruvec->lrugen.seg, seg);
-
 	if (!pgdat->memcg_lru.nr_memcgs[old] && old == get_memcg_gen(pgdat->memcg_lru.seq))
 		WRITE_ONCE(pgdat->memcg_lru.seq, pgdat->memcg_lru.seq + 1);
 
@@ -4825,11 +4825,11 @@ void lru_gen_online_memcg(struct mem_cgr
 
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
@@ -5328,7 +5328,7 @@ static long get_nr_to_scan(struct lruvec
 	DEFINE_MAX_SEQ(lruvec);
 
 	if (mem_cgroup_below_min(sc->target_mem_cgroup, memcg))
-		return 0;
+		return -1;
 
 	if (!should_run_aging(lruvec, max_seq, sc, can_swap, &nr_to_scan))
 		return nr_to_scan;
@@ -5403,7 +5403,7 @@ static bool try_to_shrink_lruvec(struct
 		cond_resched();
 	}
 
-	/* whether try_to_inc_max_seq() was successful */
+	/* whether this lruvec should be rotated */
 	return nr_to_scan < 0;
 }
 
@@ -5457,13 +5457,13 @@ static void shrink_many(struct pglist_da
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
 
@@ -5474,6 +5474,10 @@ restart:
 		}
 
 		mem_cgroup_put(memcg);
+		memcg = NULL;
+
+		if (gen != READ_ONCE(lrugen->gen))
+			continue;
 
 		lruvec = container_of(lrugen, struct lruvec, lrugen);
 		memcg = lruvec_memcg(lruvec);
@@ -5558,16 +5562,14 @@ static void set_initial_priority(struct
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
 



