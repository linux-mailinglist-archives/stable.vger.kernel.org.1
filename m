Return-Path: <stable+bounces-6550-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B7281078B
	for <lists+stable@lfdr.de>; Wed, 13 Dec 2023 02:21:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87124281657
	for <lists+stable@lfdr.de>; Wed, 13 Dec 2023 01:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF93D20F2;
	Wed, 13 Dec 2023 01:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="X+nJlZd2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5AF20E7;
	Wed, 13 Dec 2023 01:20:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 435B4C433CA;
	Wed, 13 Dec 2023 01:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1702430459;
	bh=KehDN4nhWyPy2fXuF5ABf74N4tbaM3vK19IHJgp2JOA=;
	h=Date:To:From:Subject:From;
	b=X+nJlZd2c3GUJBiHPQfB218mkFT7dqXjJ+i3CoenZQAi9G21fzEC8lgPd5+Vu/8sh
	 H8h6MSIGC/Kk9G1ycjIQeJKDH7OIBzerjUGvdD08qEa5olk657Qgl/rSVRcycBG9C9
	 h7DPqv0r69bS4WXN2ivQx9iv5kaXqsf/GsXjlmxs=
Date: Tue, 12 Dec 2023 17:20:58 -0800
To: mm-commits@vger.kernel.org,tjmercier@google.com,stable@vger.kernel.org,ryncsn@gmail.com,quic_charante@quicinc.com,kaleshsingh@google.com,jaroslav.pulchart@gooddata.com,hdanton@sina.com,yuzhao@google.com,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: [merged mm-hotfixes-stable] mm-mglru-try-to-stop-at-high-watermarks.patch removed from -mm tree
Message-Id: <20231213012059.435B4C433CA@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>


The quilt patch titled
     Subject: mm/mglru: try to stop at high watermarks
has been removed from the -mm tree.  Its filename was
     mm-mglru-try-to-stop-at-high-watermarks.patch

This patch was dropped because it was merged into the mm-hotfixes-stable branch
of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

------------------------------------------------------
From: Yu Zhao <yuzhao@google.com>
Subject: mm/mglru: try to stop at high watermarks
Date: Thu, 7 Dec 2023 23:14:05 -0700

The initial MGLRU patchset didn't include the memcg LRU support, and it
relied on should_abort_scan(), added by commit f76c83378851 ("mm:
multi-gen LRU: optimize multiple memcgs"), to "backoff to avoid
overshooting their aggregate reclaim target by too much".

Later on when the memcg LRU was added, should_abort_scan() was deemed
unnecessary, and the test results [1] showed no side effects after it was
removed by commit a579086c99ed ("mm: multi-gen LRU: remove eviction
fairness safeguard").

However, that test used memory.reclaim, which sets nr_to_reclaim to
SWAP_CLUSTER_MAX.  So it can overshoot only by SWAP_CLUSTER_MAX-1 pages,
i.e., from nr_reclaimed=nr_to_reclaim-1 to
nr_reclaimed=nr_to_reclaim+SWAP_CLUSTER_MAX-1.  Compared with the batch
size kswapd sets to nr_to_reclaim, SWAP_CLUSTER_MAX is tiny.  Therefore
that test isn't able to reproduce the worst case scenario, i.e., kswapd
overshooting GBs on large systems and "consuming 100% CPU" (see the Closes
tag).

Bring back a simplified version of should_abort_scan() on top of the memcg
LRU, so that kswapd stops when all eligible zones are above their
respective high watermarks plus a small delta to lower the chance of
KSWAPD_HIGH_WMARK_HIT_QUICKLY.  Note that this only applies to order-0
reclaim, meaning compaction-induced reclaim can still run wild (which is a
different problem).

On Android, launching 55 apps sequentially:
           Before     After      Change
  pgpgin   838377172  802955040  -4%
  pgpgout  38037080   34336300   -10%

[1] https://lore.kernel.org/20221222041905.2431096-1-yuzhao@google.com/

Link: https://lkml.kernel.org/r/20231208061407.2125867-2-yuzhao@google.com
Fixes: a579086c99ed ("mm: multi-gen LRU: remove eviction fairness safeguard")
Signed-off-by: Yu Zhao <yuzhao@google.com>
Reported-by: Charan Teja Kalla <quic_charante@quicinc.com>
Reported-by: Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>
Closes: https://lore.kernel.org/CAK8fFZ4DY+GtBA40Pm7Nn5xCHy+51w3sfxPqkqpqakSXYyX+Wg@mail.gmail.com/
Tested-by: Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>
Tested-by: Kalesh Singh <kaleshsingh@google.com>
Cc: Hillf Danton <hdanton@sina.com>
Cc: Kairui Song <ryncsn@gmail.com>
Cc: T.J. Mercier <tjmercier@google.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/vmscan.c |   36 ++++++++++++++++++++++++++++--------
 1 file changed, 28 insertions(+), 8 deletions(-)

--- a/mm/vmscan.c~mm-mglru-try-to-stop-at-high-watermarks
+++ a/mm/vmscan.c
@@ -4648,20 +4648,41 @@ static long get_nr_to_scan(struct lruvec
 	return try_to_inc_max_seq(lruvec, max_seq, sc, can_swap, false) ? -1 : 0;
 }
 
-static unsigned long get_nr_to_reclaim(struct scan_control *sc)
+static bool should_abort_scan(struct lruvec *lruvec, struct scan_control *sc)
 {
+	int i;
+	enum zone_watermarks mark;
+
 	/* don't abort memcg reclaim to ensure fairness */
 	if (!root_reclaim(sc))
-		return -1;
+		return false;
+
+	if (sc->nr_reclaimed >= max(sc->nr_to_reclaim, compact_gap(sc->order)))
+		return true;
+
+	/* check the order to exclude compaction-induced reclaim */
+	if (!current_is_kswapd() || sc->order)
+		return false;
+
+	mark = sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING ?
+	       WMARK_PROMO : WMARK_HIGH;
+
+	for (i = 0; i <= sc->reclaim_idx; i++) {
+		struct zone *zone = lruvec_pgdat(lruvec)->node_zones + i;
+		unsigned long size = wmark_pages(zone, mark) + MIN_LRU_BATCH;
+
+		if (managed_zone(zone) && !zone_watermark_ok(zone, 0, size, sc->reclaim_idx, 0))
+			return false;
+	}
 
-	return max(sc->nr_to_reclaim, compact_gap(sc->order));
+	/* kswapd should abort if all eligible zones are safe */
+	return true;
 }
 
 static bool try_to_shrink_lruvec(struct lruvec *lruvec, struct scan_control *sc)
 {
 	long nr_to_scan;
 	unsigned long scanned = 0;
-	unsigned long nr_to_reclaim = get_nr_to_reclaim(sc);
 	int swappiness = get_swappiness(lruvec, sc);
 
 	/* clean file folios are more likely to exist */
@@ -4683,7 +4704,7 @@ static bool try_to_shrink_lruvec(struct
 		if (scanned >= nr_to_scan)
 			break;
 
-		if (sc->nr_reclaimed >= nr_to_reclaim)
+		if (should_abort_scan(lruvec, sc))
 			break;
 
 		cond_resched();
@@ -4744,7 +4765,6 @@ static void shrink_many(struct pglist_da
 	struct lru_gen_folio *lrugen;
 	struct mem_cgroup *memcg;
 	const struct hlist_nulls_node *pos;
-	unsigned long nr_to_reclaim = get_nr_to_reclaim(sc);
 
 	bin = first_bin = get_random_u32_below(MEMCG_NR_BINS);
 restart:
@@ -4777,7 +4797,7 @@ restart:
 
 		rcu_read_lock();
 
-		if (sc->nr_reclaimed >= nr_to_reclaim)
+		if (should_abort_scan(lruvec, sc))
 			break;
 	}
 
@@ -4788,7 +4808,7 @@ restart:
 
 	mem_cgroup_put(memcg);
 
-	if (sc->nr_reclaimed >= nr_to_reclaim)
+	if (!is_a_nulls(pos))
 		return;
 
 	/* restart if raced with lru_gen_rotate_memcg() */
_

Patches currently in -mm which might be from yuzhao@google.com are



