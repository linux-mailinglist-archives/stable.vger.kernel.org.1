Return-Path: <stable+bounces-4966-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0029809C3C
	for <lists+stable@lfdr.de>; Fri,  8 Dec 2023 07:14:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 094EE1C20C4B
	for <lists+stable@lfdr.de>; Fri,  8 Dec 2023 06:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B0977486;
	Fri,  8 Dec 2023 06:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sEhpW7n9"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2F171720
	for <stable@vger.kernel.org>; Thu,  7 Dec 2023 22:14:13 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-db539c987e0so2396748276.3
        for <stable@vger.kernel.org>; Thu, 07 Dec 2023 22:14:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702016053; x=1702620853; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Z4mnJuieaycBMAUUn8t7GQZw8OVUsYesaq0RGH3Lfpw=;
        b=sEhpW7n99BHoqyVEloepCNmgZyxzTxY5PS8Z19fagxcD0dXLl9VEizP5nTfN8Zk9Vr
         JqO2jYsoljWdGT+RMz8mzAopmSK+jy1DYmYw8m2pO8OCZNLVM1lOeCASQi/k6LzBpnbU
         XdST1z3tnHvbvTBijqKfv5sozS9EyQXUvL6Jr0DtivgqjzmsNb7Kekms/lAgYzmwAppY
         pjboS9yZ0ptCPC/hHVhdcoWR22HPyoM/LPIpKfO88TgdqLTBSKGs1Gv6+eI4RiYbOl4b
         NCDrWuU8bXos9d3sdNMDVTrjzavFnTNcr6OEdGcrA9UF22YY0vEY5wIKUVJFpyqZNjHE
         QpxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702016053; x=1702620853;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z4mnJuieaycBMAUUn8t7GQZw8OVUsYesaq0RGH3Lfpw=;
        b=sUvglK2CtC5YxI8V9qeY2adwQpt1vL+Xrrgp3UxXYaBxjoQJupk9ix6nT1qVtU/ydK
         L1TmBvmCnkGgUM8P4iFfIVi9yYu1lkEdh2NkNQQ0IXHQWZtB2rkZZ4TlOy/ZJufp0IWf
         jKLXOaE+hrKbJiJnTaePY59NlMoUsC7PxAxVagI38jIFMYKlL5xkvwZLjhSy/nHIlUpa
         7XER5wUcRFfRhjyZbjwj772KW/vTb2cAKSGD3d90vlD6ar7cDri6QbZZ6vG3ieYqkDC3
         LGTDdwcFrK1rAedK6PzFvLYXpC6mQ43Yage2w6fYLoMXLOg+jgrkHT2Dk6fs+K+TZNNX
         qdoA==
X-Gm-Message-State: AOJu0Yxk5t8fA1wNDqFz2/RKp1UfAdDkPUZfiK/w3ejMPwDRwOcPurg9
	uqrXejUA/iPPE2Z82ZxbaMhqlHhSp3w=
X-Google-Smtp-Source: AGHT+IHhxQvDbfCzLXGcrgriZnrDb7xchNgA0cUieagOjXHbp5V8pGi0I1EYaipp3zZy55FFcaB1WVBR9y4=
X-Received: from yuzhao2.bld.corp.google.com ([100.64.188.49]) (user=yuzhao
 job=sendgmr) by 2002:a25:cf81:0:b0:d9a:36cd:482e with SMTP id
 f123-20020a25cf81000000b00d9a36cd482emr49952ybg.13.1702016052872; Thu, 07 Dec
 2023 22:14:12 -0800 (PST)
Date: Thu,  7 Dec 2023 23:14:04 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231208061407.2125867-1-yuzhao@google.com>
Subject: [PATCH mm-unstable v1 1/4] mm/mglru: fix underprotected page cache
From: Yu Zhao <yuzhao@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Yu Zhao <yuzhao@google.com>, Charan Teja Kalla <quic_charante@quicinc.com>, 
	Kalesh Singh <kaleshsingh@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Unmapped folios accessed through file descriptors can be
underprotected. Those folios are added to the oldest generation based
on:
1. The fact that they are less costly to reclaim (no need to walk the
   rmap and flush the TLB) and have less impact on performance (don't
   cause major PFs and can be non-blocking if needed again).
2. The observation that they are likely to be single-use. E.g., for
   client use cases like Android, its apps parse configuration files
   and store the data in heap (anon); for server use cases like MySQL,
   it reads from InnoDB files and holds the cached data for tables in
   buffer pools (anon).

However, the oldest generation can be very short lived, and if so, it
doesn't provide the PID controller with enough time to respond to a
surge of refaults. (Note that the PID controller uses weighted
refaults and those from evicted generations only take a half of the
whole weight.) In other words, for a short lived generation, the
moving average smooths out the spike quickly.

To fix the problem:
1. For folios that are already on LRU, if they can be beyond the
   tracking range of tiers, i.e., five accesses through file
   descriptors, move them to the second oldest generation to give them
   more time to age. (Note that tiers are used by the PID controller
   to statistically determine whether folios accessed multiple times
   through file descriptors are worth protecting.)
2. When adding unmapped folios to LRU, adjust the placement of them so
   that they are not too close to the tail. The effect of this is
   similar to the above.

On Android, launching 55 apps sequentially:
                           Before     After      Change
  workingset_refault_anon  25641024   25598972   0%
  workingset_refault_file  115016834  106178438  -8%

Fixes: ac35a4902374 ("mm: multi-gen LRU: minimal implementation")
Signed-off-by: Yu Zhao <yuzhao@google.com>
Reported-by: Charan Teja Kalla <quic_charante@quicinc.com>
Tested-by: Kalesh Singh <kaleshsingh@google.com>
Cc: stable@vger.kernel.org
---
 include/linux/mm_inline.h | 23 ++++++++++++++---------
 mm/vmscan.c               |  2 +-
 mm/workingset.c           |  6 +++---
 3 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
index 9ae7def16cb2..f4fe593c1400 100644
--- a/include/linux/mm_inline.h
+++ b/include/linux/mm_inline.h
@@ -232,22 +232,27 @@ static inline bool lru_gen_add_folio(struct lruvec *lruvec, struct folio *folio,
 	if (folio_test_unevictable(folio) || !lrugen->enabled)
 		return false;
 	/*
-	 * There are three common cases for this page:
-	 * 1. If it's hot, e.g., freshly faulted in or previously hot and
-	 *    migrated, add it to the youngest generation.
-	 * 2. If it's cold but can't be evicted immediately, i.e., an anon page
-	 *    not in swapcache or a dirty page pending writeback, add it to the
-	 *    second oldest generation.
-	 * 3. Everything else (clean, cold) is added to the oldest generation.
+	 * There are four common cases for this page:
+	 * 1. If it's hot, i.e., freshly faulted in, add it to the youngest
+	 *    generation, and it's protected over the rest below.
+	 * 2. If it can't be evicted immediately, i.e., a dirty page pending
+	 *    writeback, add it to the second youngest generation.
+	 * 3. If it should be evicted first, e.g., cold and clean from
+	 *    folio_rotate_reclaimable(), add it to the oldest generation.
+	 * 4. Everything else falls between 2 & 3 above and is added to the
+	 *    second oldest generation if it's considered inactive, or the
+	 *    oldest generation otherwise. See lru_gen_is_active().
 	 */
 	if (folio_test_active(folio))
 		seq = lrugen->max_seq;
 	else if ((type == LRU_GEN_ANON && !folio_test_swapcache(folio)) ||
 		 (folio_test_reclaim(folio) &&
 		  (folio_test_dirty(folio) || folio_test_writeback(folio))))
-		seq = lrugen->min_seq[type] + 1;
-	else
+		seq = lrugen->max_seq - 1;
+	else if (reclaiming || lrugen->min_seq[type] + MIN_NR_GENS >= lrugen->max_seq)
 		seq = lrugen->min_seq[type];
+	else
+		seq = lrugen->min_seq[type] + 1;
 
 	gen = lru_gen_from_seq(seq);
 	flags = (gen + 1UL) << LRU_GEN_PGOFF;
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 4e3b835c6b4a..e67631c60ac0 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4260,7 +4260,7 @@ static bool sort_folio(struct lruvec *lruvec, struct folio *folio, struct scan_c
 	}
 
 	/* protected */
-	if (tier > tier_idx) {
+	if (tier > tier_idx || refs == BIT(LRU_REFS_WIDTH)) {
 		int hist = lru_hist_from_seq(lrugen->min_seq[type]);
 
 		gen = folio_inc_gen(lruvec, folio, false);
diff --git a/mm/workingset.c b/mm/workingset.c
index 7d3dacab8451..2a2a34234df9 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -313,10 +313,10 @@ static void lru_gen_refault(struct folio *folio, void *shadow)
 	 * 1. For pages accessed through page tables, hotter pages pushed out
 	 *    hot pages which refaulted immediately.
 	 * 2. For pages accessed multiple times through file descriptors,
-	 *    numbers of accesses might have been out of the range.
+	 *    they would have been protected by sort_folio().
 	 */
-	if (lru_gen_in_fault() || refs == BIT(LRU_REFS_WIDTH)) {
-		folio_set_workingset(folio);
+	if (lru_gen_in_fault() || refs >= BIT(LRU_REFS_WIDTH) - 1) {
+		set_mask_bits(&folio->flags, 0, LRU_REFS_MASK | BIT(PG_workingset));
 		mod_lruvec_state(lruvec, WORKINGSET_RESTORE_BASE + type, delta);
 	}
 unlock:
-- 
2.43.0.472.g3155946c3a-goog


