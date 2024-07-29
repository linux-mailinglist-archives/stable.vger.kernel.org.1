Return-Path: <stable+bounces-62368-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E24793EE59
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 09:20:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 826131F2503E
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 07:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B0988002A;
	Mon, 29 Jul 2024 07:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OynZeyi3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E736A8DB
	for <stable@vger.kernel.org>; Mon, 29 Jul 2024 07:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722237615; cv=none; b=G+qWQXhAHsC2XzIphyvjcoscZzxgKnQLxu10iARCrWf6lLP4E2XnyaEP/8AmAXq4bP9cI1WzNaSK2KsdRrcm+EHQUzd3Fv/UoeEjIJ6BrjyX/1yLD9I2T2HxukQQEg51MEDBtsd0nmgumsm25BrbitqmX0wYeNWYzOVN9oM0m3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722237615; c=relaxed/simple;
	bh=hXn/vE1APUsMyT3xCXJs8t5yrYTz8T0/CEiQDxRqv2k=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=JbUHgDno8WhqfQCO9nQRxeghvIXr9SeXcL/xOQIww454/wkWLcHFuU/cDV2W000xavY9ZwiNO8Jv41OopgM3TM5fTQDcHW1cQqhjUmOhLCg+CTHCYcYaJrPlvV+KaDGA1tGG91WORSl3ZmZ7bZS6TJfhDH72kwtuztwY+vTSetU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OynZeyi3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C1C3C32786;
	Mon, 29 Jul 2024 07:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722237615;
	bh=hXn/vE1APUsMyT3xCXJs8t5yrYTz8T0/CEiQDxRqv2k=;
	h=Subject:To:Cc:From:Date:From;
	b=OynZeyi3xZO8MM+VE4t2E0vPZCtX9eKdy/TBdfdtPG0JQMKcayzv4OESggvH0HuSM
	 47LR1REDR5r/QoNXFbqKRHIDSLQJC4nnvMgC3GAAmmJsn3lg2XHAnZDCmfX2L/XnNX
	 hSvHzccjGP0PBfo/OHK4Hf95aJC1jHPUDSEgIj1I=
Subject: FAILED: patch "[PATCH] mm/mglru: fix ineffective protection calculation" failed to apply to 6.10-stable tree
To: yuzhao@google.com,akpm@linux-foundation.org,stable@vger.kernel.org,tjmercier@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Jul 2024 09:20:11 +0200
Message-ID: <2024072911-marshland-grab-ced7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.10.y
git checkout FETCH_HEAD
git cherry-pick -x 30d77b7eef019fa4422980806e8b7cdc8674493e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024072911-marshland-grab-ced7@gregkh' --subject-prefix 'PATCH 6.10.y' HEAD^..

Possible dependencies:

30d77b7eef01 ("mm/mglru: fix ineffective protection calculation")
3f74e6bd3b84 ("mm/mglru: fix overshooting shrinker memory")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 30d77b7eef019fa4422980806e8b7cdc8674493e Mon Sep 17 00:00:00 2001
From: Yu Zhao <yuzhao@google.com>
Date: Fri, 12 Jul 2024 17:29:56 -0600
Subject: [PATCH] mm/mglru: fix ineffective protection calculation

mem_cgroup_calculate_protection() is not stateless and should only be used
as part of a top-down tree traversal.  shrink_one() traverses the per-node
memcg LRU instead of the root_mem_cgroup tree, and therefore it should not
call mem_cgroup_calculate_protection().

The existing misuse in shrink_one() can cause ineffective protection of
sub-trees that are grandchildren of root_mem_cgroup.  Fix it by reusing
lru_gen_age_node(), which already traverses the root_mem_cgroup tree, to
calculate the protection.

Previously lru_gen_age_node() opportunistically skips the first pass,
i.e., when scan_control->priority is DEF_PRIORITY.  On the second pass,
lruvec_is_sizable() uses appropriate scan_control->priority, set by
set_initial_priority() from lru_gen_shrink_node(), to decide whether a
memcg is too small to reclaim from.

Now lru_gen_age_node() unconditionally traverses the root_mem_cgroup tree.
So it should call set_initial_priority() upfront, to make sure
lruvec_is_sizable() uses appropriate scan_control->priority on the first
pass.  Otherwise, lruvec_is_reclaimable() can return false negatives and
result in premature OOM kills when min_ttl_ms is used.

Link: https://lkml.kernel.org/r/20240712232956.1427127-1-yuzhao@google.com
Fixes: e4dde56cd208 ("mm: multi-gen LRU: per-node lru_gen_folio lists")
Signed-off-by: Yu Zhao <yuzhao@google.com>
Reported-by: T.J. Mercier <tjmercier@google.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 6216d79edb7f..525d3ffa8451 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -3915,6 +3915,32 @@ static bool try_to_inc_max_seq(struct lruvec *lruvec, unsigned long seq,
  *                          working set protection
  ******************************************************************************/
 
+static void set_initial_priority(struct pglist_data *pgdat, struct scan_control *sc)
+{
+	int priority;
+	unsigned long reclaimable;
+
+	if (sc->priority != DEF_PRIORITY || sc->nr_to_reclaim < MIN_LRU_BATCH)
+		return;
+	/*
+	 * Determine the initial priority based on
+	 * (total >> priority) * reclaimed_to_scanned_ratio = nr_to_reclaim,
+	 * where reclaimed_to_scanned_ratio = inactive / total.
+	 */
+	reclaimable = node_page_state(pgdat, NR_INACTIVE_FILE);
+	if (can_reclaim_anon_pages(NULL, pgdat->node_id, sc))
+		reclaimable += node_page_state(pgdat, NR_INACTIVE_ANON);
+
+	/* round down reclaimable and round up sc->nr_to_reclaim */
+	priority = fls_long(reclaimable) - 1 - fls_long(sc->nr_to_reclaim - 1);
+
+	/*
+	 * The estimation is based on LRU pages only, so cap it to prevent
+	 * overshoots of shrinker objects by large margins.
+	 */
+	sc->priority = clamp(priority, DEF_PRIORITY / 2, DEF_PRIORITY);
+}
+
 static bool lruvec_is_sizable(struct lruvec *lruvec, struct scan_control *sc)
 {
 	int gen, type, zone;
@@ -3948,19 +3974,17 @@ static bool lruvec_is_reclaimable(struct lruvec *lruvec, struct scan_control *sc
 	struct mem_cgroup *memcg = lruvec_memcg(lruvec);
 	DEFINE_MIN_SEQ(lruvec);
 
-	/* see the comment on lru_gen_folio */
-	gen = lru_gen_from_seq(min_seq[LRU_GEN_FILE]);
-	birth = READ_ONCE(lruvec->lrugen.timestamps[gen]);
-
-	if (time_is_after_jiffies(birth + min_ttl))
+	if (mem_cgroup_below_min(NULL, memcg))
 		return false;
 
 	if (!lruvec_is_sizable(lruvec, sc))
 		return false;
 
-	mem_cgroup_calculate_protection(NULL, memcg);
+	/* see the comment on lru_gen_folio */
+	gen = lru_gen_from_seq(min_seq[LRU_GEN_FILE]);
+	birth = READ_ONCE(lruvec->lrugen.timestamps[gen]);
 
-	return !mem_cgroup_below_min(NULL, memcg);
+	return time_is_before_jiffies(birth + min_ttl);
 }
 
 /* to protect the working set of the last N jiffies */
@@ -3970,23 +3994,20 @@ static void lru_gen_age_node(struct pglist_data *pgdat, struct scan_control *sc)
 {
 	struct mem_cgroup *memcg;
 	unsigned long min_ttl = READ_ONCE(lru_gen_min_ttl);
+	bool reclaimable = !min_ttl;
 
 	VM_WARN_ON_ONCE(!current_is_kswapd());
 
-	/* check the order to exclude compaction-induced reclaim */
-	if (!min_ttl || sc->order || sc->priority == DEF_PRIORITY)
-		return;
+	set_initial_priority(pgdat, sc);
 
 	memcg = mem_cgroup_iter(NULL, NULL, NULL);
 	do {
 		struct lruvec *lruvec = mem_cgroup_lruvec(memcg, pgdat);
 
-		if (lruvec_is_reclaimable(lruvec, sc, min_ttl)) {
-			mem_cgroup_iter_break(NULL, memcg);
-			return;
-		}
+		mem_cgroup_calculate_protection(NULL, memcg);
 
-		cond_resched();
+		if (!reclaimable)
+			reclaimable = lruvec_is_reclaimable(lruvec, sc, min_ttl);
 	} while ((memcg = mem_cgroup_iter(NULL, memcg, NULL)));
 
 	/*
@@ -3994,7 +4015,7 @@ static void lru_gen_age_node(struct pglist_data *pgdat, struct scan_control *sc)
 	 * younger than min_ttl. However, another possibility is all memcgs are
 	 * either too small or below min.
 	 */
-	if (mutex_trylock(&oom_lock)) {
+	if (!reclaimable && mutex_trylock(&oom_lock)) {
 		struct oom_control oc = {
 			.gfp_mask = sc->gfp_mask,
 		};
@@ -4786,8 +4807,7 @@ static int shrink_one(struct lruvec *lruvec, struct scan_control *sc)
 	struct mem_cgroup *memcg = lruvec_memcg(lruvec);
 	struct pglist_data *pgdat = lruvec_pgdat(lruvec);
 
-	mem_cgroup_calculate_protection(NULL, memcg);
-
+	/* lru_gen_age_node() called mem_cgroup_calculate_protection() */
 	if (mem_cgroup_below_min(NULL, memcg))
 		return MEMCG_LRU_YOUNG;
 
@@ -4911,32 +4931,6 @@ static void lru_gen_shrink_lruvec(struct lruvec *lruvec, struct scan_control *sc
 	blk_finish_plug(&plug);
 }
 
-static void set_initial_priority(struct pglist_data *pgdat, struct scan_control *sc)
-{
-	int priority;
-	unsigned long reclaimable;
-
-	if (sc->priority != DEF_PRIORITY || sc->nr_to_reclaim < MIN_LRU_BATCH)
-		return;
-	/*
-	 * Determine the initial priority based on
-	 * (total >> priority) * reclaimed_to_scanned_ratio = nr_to_reclaim,
-	 * where reclaimed_to_scanned_ratio = inactive / total.
-	 */
-	reclaimable = node_page_state(pgdat, NR_INACTIVE_FILE);
-	if (can_reclaim_anon_pages(NULL, pgdat->node_id, sc))
-		reclaimable += node_page_state(pgdat, NR_INACTIVE_ANON);
-
-	/* round down reclaimable and round up sc->nr_to_reclaim */
-	priority = fls_long(reclaimable) - 1 - fls_long(sc->nr_to_reclaim - 1);
-
-	/*
-	 * The estimation is based on LRU pages only, so cap it to prevent
-	 * overshoots of shrinker objects by large margins.
-	 */
-	sc->priority = clamp(priority, DEF_PRIORITY / 2, DEF_PRIORITY);
-}
-
 static void lru_gen_shrink_node(struct pglist_data *pgdat, struct scan_control *sc)
 {
 	struct blk_plug plug;


