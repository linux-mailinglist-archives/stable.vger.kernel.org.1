Return-Path: <stable+bounces-62589-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D43993FBDE
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 18:53:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 044A1282830
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 16:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FBC5156C70;
	Mon, 29 Jul 2024 16:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m/AsOEPc"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B2078B50
	for <stable@vger.kernel.org>; Mon, 29 Jul 2024 16:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722271973; cv=none; b=Eci83MrKY0eJjWsPLZlTSx2jU25Si+yU4YLoikYQj/TvFOeD6UC3wwmT+qSrUYfbrUTjdi8V+Kt5mSqIEWGTWTE2njFC9VDZ2/8v1AiR2aJZZaGL43KJII2xJ/Mh1S4rfvXRastlIA7bHmxXWG4+b8JlTuidJZ92WIAFNIg982Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722271973; c=relaxed/simple;
	bh=i3I2xTl6xim1Na1uLHwgmj1RfREET6hVrtdHxBxxHwA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VK5pJ597GtS/wjMXAjH+GOnD57+vQZEaTr+zH0Q6M0j2Tp458ScDdI/jdsP6HA4r57TlzFVDXfyCBFVT+O504QAlSofLUvioT1LptJXTYDRy2lVXtyiASBkR64bsKrWxQKRurvduYAnQP16Ji/XalVrykz1Jai50LjLM8TpNWuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m/AsOEPc; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2cb6b642c49so3448273a91.1
        for <stable@vger.kernel.org>; Mon, 29 Jul 2024 09:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722271971; x=1722876771; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LQ9QerfQKBKbpHF7lQJ84RtIw9HuEQjZ+0GgfDFGrOw=;
        b=m/AsOEPcvLvSl/z7moKmyLRUb5gQV08rdJlA3uX9B8yn9n+5Xwtz/dDUe7YSXTqKKS
         NMd0aayMgOpRkQuGVoSFyGDE5wXZ9LuW9npShrSQSdbfgdNsPGibMeNJbivwbbmHWXGv
         SuF+pQvk6pngcJ9KAu8mXuZHYvl2J7KWmcIWDGCxZBvBN5bExY1gRnRNyUGSRcITvcpU
         poIinvutR0jXn6h60mXDYOH8yvYgXxaNb8wlvSezWkypsynMR7yVA1fnvsCa5GJymHaf
         xKx0L62cbIqc9qGWn91gKcc4I+PIK8Y8JZ5TvXsx4cWfrJkDYGaYXuMmC60NcxRMqxip
         jkGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722271971; x=1722876771;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LQ9QerfQKBKbpHF7lQJ84RtIw9HuEQjZ+0GgfDFGrOw=;
        b=OuHBYIIb3e5JCG5yvXPQSCU1jyvoYZjBMPpk75l0JQHG3yotEg6yDdvKKnzTgsXoew
         o6Cfe3nXlBybhW+LLixBFIlsQfyJWdMsG2hv1G0g7YHPM6eAbwLi0G+GkMhczML7Y1rE
         WioIzOJD4fjzKB8jFBjLgIzbso2vxkg+9PCrbOSYsgYOyQj6reWt95nxFGvxyj00vDQG
         D3/+srsdbgHEM+MaXA3ilKnPPv/1MBmQZZqVFC3hMvN7MhRFBi16Y8g2dWjot7Y7VTDn
         64/r1OoNKW2UkL4rRXlGWJD+/P/E96wlfjCVWGNT1VmXDvqE8Vxc6agzylqasgpaIz46
         2wKg==
X-Gm-Message-State: AOJu0Yz76b4tMMdSImhdH8/9XnYSWC1SrnInPetikB4T/imsmx68vDNx
	gbQhlrq3b24WyMn0sHXFYKZANQdmdBam11DZgmjPbVDDGpUT4tot8BVtmOdF0p4hpFK5LGrv8xg
	/N60k0+INp+P2lhQvu8YE8TVeP/2/T5yO0XeuRbcUXIb2UKx0dhXgvqa5/OyZqgiv4DrSdyt2O6
	AssqbfTW7VH80JvExSFz1oiLOQWEFV98uqEylkkdrY9p6TW/UI
X-Google-Smtp-Source: AGHT+IEZFQ+8BJPFQ0oo5DF0VTmpl/slJsw9lBs/bKnZQzjeIAkwA7bhUJ5yNUMMWYiIfEJLU+5BkWY8DH9aWnA=
X-Received: from tj-virt2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:1910])
 (user=tjmercier job=sendgmr) by 2002:a17:90a:db98:b0:2c9:7545:b5d2 with SMTP
 id 98e67ed59e1d1-2cf7d005edcmr122343a91.2.1722271970455; Mon, 29 Jul 2024
 09:52:50 -0700 (PDT)
Date: Mon, 29 Jul 2024 16:52:47 +0000
In-Reply-To: <2024072912-during-vitalize-fe0c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2024072912-during-vitalize-fe0c@gregkh>
X-Mailer: git-send-email 2.46.0.rc1.232.g9752f9e123-goog
Message-ID: <20240729165247.709968-1-tjmercier@google.com>
Subject: [PATCH 6.6.y] mm/mglru: fix ineffective protection calculation
From: "T.J. Mercier" <tjmercier@google.com>
To: stable@vger.kernel.org
Cc: Yu Zhao <yuzhao@google.com>, "T.J. Mercier" <tjmercier@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"

From: Yu Zhao <yuzhao@google.com>

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
Change-Id: I2ff1de0c7a3fae01370d99198d3a1b04c109aac6
Signed-off-by: Yu Zhao <yuzhao@google.com>
Reported-by: T.J. Mercier <tjmercier@google.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit 30d77b7eef019fa4422980806e8b7cdc8674493e)
[TJ: moved up the existing set_initial_priority from this branch
instead of the upstream version with changes from other patches]
Signed-off-by: T.J. Mercier <tjmercier@google.com>
---
 mm/vmscan.c | 75 ++++++++++++++++++++++++-----------------------------
 1 file changed, 34 insertions(+), 41 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index e9d4c1f6d7bb..627c4d3b4c04 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4545,6 +4545,28 @@ static bool try_to_inc_max_seq(struct lruvec *lruvec, unsigned long max_seq,
 /******************************************************************************
  *                          working set protection
  ******************************************************************************/
+static void set_initial_priority(struct pglist_data *pgdat, struct scan_control *sc)
+{
+	int priority;
+	unsigned long reclaimable;
+	struct lruvec *lruvec = mem_cgroup_lruvec(NULL, pgdat);
+
+	if (sc->priority != DEF_PRIORITY || sc->nr_to_reclaim < MIN_LRU_BATCH)
+		return;
+	/*
+	 * Determine the initial priority based on
+	 * (total >> priority) * reclaimed_to_scanned_ratio = nr_to_reclaim,
+	 * where reclaimed_to_scanned_ratio = inactive / total.
+	 */
+	reclaimable = node_page_state(pgdat, NR_INACTIVE_FILE);
+	if (get_swappiness(lruvec, sc))
+		reclaimable += node_page_state(pgdat, NR_INACTIVE_ANON);
+
+	/* round down reclaimable and round up sc->nr_to_reclaim */
+	priority = fls_long(reclaimable) - 1 - fls_long(sc->nr_to_reclaim - 1);
+
+	sc->priority = clamp(priority, 0, DEF_PRIORITY);
+}
 
 static bool lruvec_is_sizable(struct lruvec *lruvec, struct scan_control *sc)
 {
@@ -4579,19 +4601,17 @@ static bool lruvec_is_reclaimable(struct lruvec *lruvec, struct scan_control *sc
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
@@ -4601,23 +4621,20 @@ static void lru_gen_age_node(struct pglist_data *pgdat, struct scan_control *sc)
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
@@ -4625,7 +4642,7 @@ static void lru_gen_age_node(struct pglist_data *pgdat, struct scan_control *sc)
 	 * younger than min_ttl. However, another possibility is all memcgs are
 	 * either too small or below min.
 	 */
-	if (mutex_trylock(&oom_lock)) {
+	if (!reclaimable && mutex_trylock(&oom_lock)) {
 		struct oom_control oc = {
 			.gfp_mask = sc->gfp_mask,
 		};
@@ -5425,8 +5442,7 @@ static int shrink_one(struct lruvec *lruvec, struct scan_control *sc)
 	struct mem_cgroup *memcg = lruvec_memcg(lruvec);
 	struct pglist_data *pgdat = lruvec_pgdat(lruvec);
 
-	mem_cgroup_calculate_protection(NULL, memcg);
-
+	/* lru_gen_age_node() called mem_cgroup_calculate_protection() */
 	if (mem_cgroup_below_min(NULL, memcg))
 		return MEMCG_LRU_YOUNG;
 
@@ -5566,29 +5582,6 @@ static void lru_gen_shrink_lruvec(struct lruvec *lruvec, struct scan_control *sc
 
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
-	sc->priority = clamp(priority, 0, DEF_PRIORITY);
-}
-
 static void lru_gen_shrink_node(struct pglist_data *pgdat, struct scan_control *sc)
 {
 	struct blk_plug plug;
-- 
2.46.0.rc1.232.g9752f9e123-goog


