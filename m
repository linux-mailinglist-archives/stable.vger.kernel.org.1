Return-Path: <stable+bounces-7223-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 851F781717B
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 14:58:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31CA92836BF
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 13:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3F4E1D127;
	Mon, 18 Dec 2023 13:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YEfjWxMR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1E3129EF7;
	Mon, 18 Dec 2023 13:58:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6A99C433C7;
	Mon, 18 Dec 2023 13:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702907895;
	bh=c9AIcKz2cyup4cbhsA+faUul1IYNciyPM2HEoIfpyPM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YEfjWxMR3EaC8KNQ8alvgKM16SXDx4iRKkDUbAxztRycoxOOcNLdzKNP6M/60oa7S
	 QFrNp4zhrGO6HUg4yXMwWqMwoTRE3IE9Sx6znARCenlE2oEwYvByHlhW2ZJ13fvIoQ
	 bD7pkWv29rDi3fpnftTXP0lWk24b0DoyRHVomNO4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yu Zhao <yuzhao@google.com>,
	Charan Teja Kalla <quic_charante@quicinc.com>,
	Kalesh Singh <kaleshsingh@google.com>,
	"T.J. Mercier" <tjmercier@google.com>,
	Kairui Song <ryncsn@gmail.com>,
	Hillf Danton <hdanton@sina.com>,
	Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.1 085/106] mm/mglru: fix underprotected page cache
Date: Mon, 18 Dec 2023 14:51:39 +0100
Message-ID: <20231218135058.709778525@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231218135055.005497074@linuxfoundation.org>
References: <20231218135055.005497074@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yu Zhao <yuzhao@google.com>

commit 081488051d28d32569ebb7c7a23572778b2e7d57 upstream.

Unmapped folios accessed through file descriptors can be underprotected.
Those folios are added to the oldest generation based on:

1. The fact that they are less costly to reclaim (no need to walk the
   rmap and flush the TLB) and have less impact on performance (don't
   cause major PFs and can be non-blocking if needed again).
2. The observation that they are likely to be single-use. E.g., for
   client use cases like Android, its apps parse configuration files
   and store the data in heap (anon); for server use cases like MySQL,
   it reads from InnoDB files and holds the cached data for tables in
   buffer pools (anon).

However, the oldest generation can be very short lived, and if so, it
doesn't provide the PID controller with enough time to respond to a surge
of refaults.  (Note that the PID controller uses weighted refaults and
those from evicted generations only take a half of the whole weight.) In
other words, for a short lived generation, the moving average smooths out
the spike quickly.

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

Link: https://lkml.kernel.org/r/20231208061407.2125867-1-yuzhao@google.com
Fixes: ac35a4902374 ("mm: multi-gen LRU: minimal implementation")
Signed-off-by: Yu Zhao <yuzhao@google.com>
Reported-by: Charan Teja Kalla <quic_charante@quicinc.com>
Tested-by: Kalesh Singh <kaleshsingh@google.com>
Cc: T.J. Mercier <tjmercier@google.com>
Cc: Kairui Song <ryncsn@gmail.com>
Cc: Hillf Danton <hdanton@sina.com>
Cc: Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/mm_inline.h |   23 ++++++++++++++---------
 mm/vmscan.c               |    2 +-
 mm/workingset.c           |    6 +++---
 3 files changed, 18 insertions(+), 13 deletions(-)

--- a/include/linux/mm_inline.h
+++ b/include/linux/mm_inline.h
@@ -231,22 +231,27 @@ static inline bool lru_gen_add_folio(str
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
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4770,7 +4770,7 @@ static bool sort_folio(struct lruvec *lr
 	}
 
 	/* protected */
-	if (tier > tier_idx) {
+	if (tier > tier_idx || refs == BIT(LRU_REFS_WIDTH)) {
 		int hist = lru_hist_from_seq(lrugen->min_seq[type]);
 
 		gen = folio_inc_gen(lruvec, folio, false);
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -289,10 +289,10 @@ static void lru_gen_refault(struct folio
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



