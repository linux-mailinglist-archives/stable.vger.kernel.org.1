Return-Path: <stable+bounces-62374-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA0693EED5
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 09:45:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2657B22DCB
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 07:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B7BE12D769;
	Mon, 29 Jul 2024 07:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xSDLlxMb"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0D112D1FF
	for <stable@vger.kernel.org>; Mon, 29 Jul 2024 07:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722239086; cv=none; b=KhNW8Yu9upzc39zCXKxAmLyfeVYNpDyJuUn65nIQ2WGbamiOs/LSJ/t3NBW37CKB0rrWL2ck+SoTKmT6lWhbP28FqRQFEp80E/sl+ynZw/luX0v6tLPaxJJMBtLimjoLCKn2u+/p8xz8asKGYRJNBLyUgCpe8u6pXf7GjLyY5zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722239086; c=relaxed/simple;
	bh=DRuH8rN9jKZYvrWx3wp/v7OwBqwAZOJXB7mnjJn+NHQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=APX8nVf+uARje7szGaBmsF727ODJr3jfSk+ONYaRnHvkB1YDXVfbNsjgQe6kimT9WDoebDoXtgnhxtAlnwx9NgkrEpWuUTKdWk5OtRmWH1QXYKg7ZOLXZGJE1AiGWasDoz17TXohoo5oX+FquIBEvQEPnYbWeSD+lAWvdA+olCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuzhao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xSDLlxMb; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuzhao.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e0b3742b30bso3416828276.1
        for <stable@vger.kernel.org>; Mon, 29 Jul 2024 00:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722239084; x=1722843884; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rpUOawjKXD7og577AiLYIdcstUBoqVJ7cGObf6WXtmA=;
        b=xSDLlxMbeQ69YAhMS1HlkO/Ui7Jafh6FjrbbMy3KqzA7+tcMUS6JjhoZgeKe4EJcai
         +cHMuhFLaiucMdgxU0LDPZOe89kZxklPlzHabcON91RaYanaFJNKtJIaTdaTiHwiGPKD
         AeJKJV0BJQyPCn1FtBAaDEwL/TxdslsuhGFHKy/RaMTXvZbyzQGHf97tgW/m+/qWGXZG
         rGYjvJrtzeYvlw2z7loaG/ga0SFUnJBUHAu/j68Zd0BEooRwceXmhavQu2zYwWdTb+4N
         OE8k/z7jIq3tAaX1T46vLYKI8gPu/dqbIERdpb5ItSYCXz8sFUanEBo9NnedLrfKHMEX
         Tybg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722239084; x=1722843884;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rpUOawjKXD7og577AiLYIdcstUBoqVJ7cGObf6WXtmA=;
        b=qEfgF2lUCTD414dFe9m08QEXaBz9DwSZLXmp6bfM6+f11lBhUf0wzKYfO2kpv6y07O
         xgOzqXt+M90B7RqMcCdt83Rk/v3McPvbLVhc89WehvCNNcwl8m1v2Hr/ddQ7VP1445JJ
         YONoaxJMxAoi5wNQ/+Kh3lKyukW1GIWRRsDuqA1PLAKMZRM9T/XIhe43uPXZTZaKTOKW
         J7xnFIe91xotE1eTFRb1EUvOgQHZL1vCrxwOxUf0FFk/BN5mLfOEDQQHTUCi/uWbwqmE
         BZ/Nx60Wwzu4iRbumlXtPHUVnWO6PxG1GjOJ1Px7Pocr/qh4jAFCvHsfbFyna5B2hbpi
         3H4Q==
X-Gm-Message-State: AOJu0YzAhNTcodiZPizxIeueApp3PbnTkSCEBwFxfP+XSFTGFaUdVSc4
	BH59o44NxslHXKyECTSyFJRN1DaBMwstqQpO2F9mAP6lx5w01xHWIi5MmnyPUvtCGW3aO50BmfV
	ecy5AnITY1legzgjUEEl/wa0/m5o8HApv/L+OfsAOt0OKB/BseV93hWehXzRcorHN5gKIAw7PVI
	gqnFAOyjQYgRk8/+NSt2G90KKN2UB+Nui7
X-Google-Smtp-Source: AGHT+IFaEw6an6kEJlnLoMDqT4/MokYq/k2eHCihAYoU+bVGlXP8aOOBMH/5VHlElkjCzQmZSiHG1Ut7JyM=
X-Received: from yuzhao2.bld.corp.google.com ([2a00:79e0:2e28:6:33d8:464b:83b0:a265])
 (user=yuzhao job=sendgmr) by 2002:a05:6902:c0a:b0:e05:a890:5aaa with SMTP id
 3f1490d57ef6-e0b555474d7mr180089276.1.1722239083731; Mon, 29 Jul 2024
 00:44:43 -0700 (PDT)
Date: Mon, 29 Jul 2024 01:44:34 -0600
In-Reply-To: <20240729074434.1223587-1-yuzhao@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2024072912-during-vitalize-fe0c@gregkh> <20240729074434.1223587-1-yuzhao@google.com>
X-Mailer: git-send-email 2.46.0.rc1.232.g9752f9e123-goog
Message-ID: <20240729074434.1223587-3-yuzhao@google.com>
Subject: [PATCH 6.6.y 3/3] mm/mglru: fix ineffective protection calculation
From: Yu Zhao <yuzhao@google.com>
To: stable@vger.kernel.org
Cc: Yu Zhao <yuzhao@google.com>, "T.J. Mercier" <tjmercier@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"

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
(cherry picked from commit 30d77b7eef019fa4422980806e8b7cdc8674493e)
---
 mm/vmscan.c | 83 ++++++++++++++++++++++++-----------------------------
 1 file changed, 38 insertions(+), 45 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 94b001b1c4c7..83fa8e924f8a 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4546,6 +4546,32 @@ static bool try_to_inc_max_seq(struct lruvec *lruvec, unsigned long max_seq,
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
@@ -4579,19 +4605,17 @@ static bool lruvec_is_reclaimable(struct lruvec *lruvec, struct scan_control *sc
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
@@ -4601,23 +4625,20 @@ static void lru_gen_age_node(struct pglist_data *pgdat, struct scan_control *sc)
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
@@ -4625,7 +4646,7 @@ static void lru_gen_age_node(struct pglist_data *pgdat, struct scan_control *sc)
 	 * younger than min_ttl. However, another possibility is all memcgs are
 	 * either too small or below min.
 	 */
-	if (mutex_trylock(&oom_lock)) {
+	if (!reclaimable && mutex_trylock(&oom_lock)) {
 		struct oom_control oc = {
 			.gfp_mask = sc->gfp_mask,
 		};
@@ -5424,8 +5445,7 @@ static int shrink_one(struct lruvec *lruvec, struct scan_control *sc)
 	struct mem_cgroup *memcg = lruvec_memcg(lruvec);
 	struct pglist_data *pgdat = lruvec_pgdat(lruvec);
 
-	mem_cgroup_calculate_protection(NULL, memcg);
-
+	/* lru_gen_age_node() called mem_cgroup_calculate_protection() */
 	if (mem_cgroup_below_min(NULL, memcg))
 		return MEMCG_LRU_YOUNG;
 
@@ -5565,33 +5585,6 @@ static void lru_gen_shrink_lruvec(struct lruvec *lruvec, struct scan_control *sc
 
 #endif
 
-static void set_initial_priority(struct pglist_data *pgdat, struct scan_control *sc)
-{
-	int priority;
-	unsigned long reclaimable;
-	struct lruvec *lruvec = mem_cgroup_lruvec(NULL, pgdat);
-
-	if (sc->priority != DEF_PRIORITY || sc->nr_to_reclaim < MIN_LRU_BATCH)
-		return;
-	/*
-	 * Determine the initial priority based on
-	 * (total >> priority) * reclaimed_to_scanned_ratio = nr_to_reclaim,
-	 * where reclaimed_to_scanned_ratio = inactive / total.
-	 */
-	reclaimable = node_page_state(pgdat, NR_INACTIVE_FILE);
-	if (get_swappiness(lruvec, sc))
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
-- 
2.46.0.rc1.232.g9752f9e123-goog


