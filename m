Return-Path: <stable+bounces-32991-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AB7988EB1B
	for <lists+stable@lfdr.de>; Wed, 27 Mar 2024 17:24:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61316B31336
	for <lists+stable@lfdr.de>; Wed, 27 Mar 2024 15:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DCFD13CF86;
	Wed, 27 Mar 2024 15:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2chd2WFF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15D313C90A
	for <stable@vger.kernel.org>; Wed, 27 Mar 2024 15:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711552594; cv=none; b=RH1iY+r3ZJx1HePLZKwcJoZhD1O597eCsD6mjaK2nNXum5gdBX9QDBhn1YAkN1z3YLXMkXyENnbCQIZOrOmg3PnaT6R5otyWi+8xuUGx1lWnhj74qNm4BhT+rJABnsSCJOu0lyfZ+jvIbQVb2BHOF094zwpGHJfft6rJNGlQZqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711552594; c=relaxed/simple;
	bh=EKlq9cZGccq0l9VFj22kXte+CcubUGY6uCEbEC0E4dM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=s8we1Zb6qXwzM2vQLGtq7+jcfknBEoo1qfN+p/0SEHDRcMomW3zm6c1yiTwUYSC9Y0HZCmoCohQKhSPXscLw8udxLBIwzWjqtQuBfGkWNlJRnYZT7KQ3Nd60J5kfz1TEIKsSOU+RcfRHZjBOeyvF/eSDtFXH8V7s2apXuEMRVPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2chd2WFF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06D22C433F1;
	Wed, 27 Mar 2024 15:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711552593;
	bh=EKlq9cZGccq0l9VFj22kXte+CcubUGY6uCEbEC0E4dM=;
	h=Subject:To:Cc:From:Date:From;
	b=2chd2WFF7gWa/8KDv+FsOhaYlkmDJTBsUBP6Q2devyBANsgSTYYnkFS44ah3Be4z5
	 pifl2V5SD6OPNvLfqM4leKVIkXXS3zrs/W8HiavFrSs2hBJfsdYTGUial6vFpHwTBv
	 yWB/tx7D2VGbehdqkAi8wO78RsG6x9aRoYoYFPwQ=
Subject: FAILED: patch "[PATCH] mm, vmscan: prevent infinite loop for costly GFP_NOIO |" failed to apply to 5.10-stable tree
To: vbabka@suse.cz,akpm@linux-foundation.org,bgeffon@google.com,cujomalainey@chromium.org,kramasub@chromium.org,mgorman@techsingularity.net,mhocko@kernel.org,perex@perex.cz,stable@vger.kernel.org,svenva@chromium.org,tiwai@suse.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 27 Mar 2024 16:16:27 +0100
Message-ID: <2024032727-pastel-sincerity-a986@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 803de9000f334b771afacb6ff3e78622916668b0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024032727-pastel-sincerity-a986@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

803de9000f33 ("mm, vmscan: prevent infinite loop for costly GFP_NOIO | __GFP_RETRY_MAYFAIL allocations")
f98a497e1f16 ("mm: compaction: remove unnecessary is_via_compact_memory() checks")
e8606320e9af ("mm: compaction: refactor __compaction_suitable()")
fe573327ffb1 ("tracing: incorrect gfp_t conversion")
cff387d6a294 ("mm: compaction: make compaction_zonelist_suitable return false when COMPACT_SUCCESS")
9353ffa6e9e9 ("kasan, page_alloc: allow skipping memory init for HW_TAGS")
53ae233c30a6 ("kasan, page_alloc: allow skipping unpoisoning for HW_TAGS")
f49d9c5bb15c ("kasan, mm: only define ___GFP_SKIP_KASAN_POISON with HW_TAGS")
e9d0ca922816 ("kasan, page_alloc: rework kasan_unpoison_pages call site")
7e3cbba65de2 ("kasan, page_alloc: move kernel_init_free_pages in post_alloc_hook")
89b271163328 ("kasan, page_alloc: move SetPageSkipKASanPoison in post_alloc_hook")
9294b1281d0a ("kasan, page_alloc: combine tag_clear_highpage calls in post_alloc_hook")
b42090ae6f3a ("kasan, page_alloc: merge kasan_alloc_pages into post_alloc_hook")
b8491b9052fe ("kasan, page_alloc: refactor init checks in post_alloc_hook")
1c0e5b24f117 ("kasan: only apply __GFP_ZEROTAGS when memory is zeroed")
c82ce3195fd1 ("mm: clarify __GFP_ZEROTAGS comment")
7c13c163e036 ("kasan, page_alloc: merge kasan_free_pages into free_pages_prepare")
5b2c07138cbd ("kasan, page_alloc: move tag_clear_highpage out of kernel_init_free_pages")
94ae8b83fefc ("kasan, page_alloc: deduplicate should_skip_kasan_poison")
3bf03b9a0839 ("Merge branch 'akpm' (patches from Andrew)")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 803de9000f334b771afacb6ff3e78622916668b0 Mon Sep 17 00:00:00 2001
From: Vlastimil Babka <vbabka@suse.cz>
Date: Wed, 21 Feb 2024 12:43:58 +0100
Subject: [PATCH] mm, vmscan: prevent infinite loop for costly GFP_NOIO |
 __GFP_RETRY_MAYFAIL allocations

Sven reports an infinite loop in __alloc_pages_slowpath() for costly order
__GFP_RETRY_MAYFAIL allocations that are also GFP_NOIO.  Such combination
can happen in a suspend/resume context where a GFP_KERNEL allocation can
have __GFP_IO masked out via gfp_allowed_mask.

Quoting Sven:

1. try to do a "costly" allocation (order > PAGE_ALLOC_COSTLY_ORDER)
   with __GFP_RETRY_MAYFAIL set.

2. page alloc's __alloc_pages_slowpath tries to get a page from the
   freelist. This fails because there is nothing free of that costly
   order.

3. page alloc tries to reclaim by calling __alloc_pages_direct_reclaim,
   which bails out because a zone is ready to be compacted; it pretends
   to have made a single page of progress.

4. page alloc tries to compact, but this always bails out early because
   __GFP_IO is not set (it's not passed by the snd allocator, and even
   if it were, we are suspending so the __GFP_IO flag would be cleared
   anyway).

5. page alloc believes reclaim progress was made (because of the
   pretense in item 3) and so it checks whether it should retry
   compaction. The compaction retry logic thinks it should try again,
   because:
    a) reclaim is needed because of the early bail-out in item 4
    b) a zonelist is suitable for compaction

6. goto 2. indefinite stall.

(end quote)

The immediate root cause is confusing the COMPACT_SKIPPED returned from
__alloc_pages_direct_compact() (step 4) due to lack of __GFP_IO to be
indicating a lack of order-0 pages, and in step 5 evaluating that in
should_compact_retry() as a reason to retry, before incrementing and
limiting the number of retries.  There are however other places that
wrongly assume that compaction can happen while we lack __GFP_IO.

To fix this, introduce gfp_compaction_allowed() to abstract the __GFP_IO
evaluation and switch the open-coded test in try_to_compact_pages() to use
it.

Also use the new helper in:
- compaction_ready(), which will make reclaim not bail out in step 3, so
  there's at least one attempt to actually reclaim, even if chances are
  small for a costly order
- in_reclaim_compaction() which will make should_continue_reclaim()
  return false and we don't over-reclaim unnecessarily
- in __alloc_pages_slowpath() to set a local variable can_compact,
  which is then used to avoid retrying reclaim/compaction for costly
  allocations (step 5) if we can't compact and also to skip the early
  compaction attempt that we do in some cases

Link: https://lkml.kernel.org/r/20240221114357.13655-2-vbabka@suse.cz
Fixes: 3250845d0526 ("Revert "mm, oom: prevent premature OOM killer invocation for high order request"")
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
Reported-by: Sven van Ashbrook <svenva@chromium.org>
Closes: https://lore.kernel.org/all/CAG-rBihs_xMKb3wrMO1%2B-%2Bp4fowP9oy1pa_OTkfxBzPUVOZF%2Bg@mail.gmail.com/
Tested-by: Karthikeyan Ramasubramanian <kramasub@chromium.org>
Cc: Brian Geffon <bgeffon@google.com>
Cc: Curtis Malainey <cujomalainey@chromium.org>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index de292a007138..e2a916cf29c4 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -353,6 +353,15 @@ static inline bool gfp_has_io_fs(gfp_t gfp)
 	return (gfp & (__GFP_IO | __GFP_FS)) == (__GFP_IO | __GFP_FS);
 }
 
+/*
+ * Check if the gfp flags allow compaction - GFP_NOIO is a really
+ * tricky context because the migration might require IO.
+ */
+static inline bool gfp_compaction_allowed(gfp_t gfp_mask)
+{
+	return IS_ENABLED(CONFIG_COMPACTION) && (gfp_mask & __GFP_IO);
+}
+
 extern gfp_t vma_thp_gfp_mask(struct vm_area_struct *vma);
 
 #ifdef CONFIG_CONTIG_ALLOC
diff --git a/mm/compaction.c b/mm/compaction.c
index 4add68d40e8d..b961db601df4 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -2723,16 +2723,11 @@ enum compact_result try_to_compact_pages(gfp_t gfp_mask, unsigned int order,
 		unsigned int alloc_flags, const struct alloc_context *ac,
 		enum compact_priority prio, struct page **capture)
 {
-	int may_perform_io = (__force int)(gfp_mask & __GFP_IO);
 	struct zoneref *z;
 	struct zone *zone;
 	enum compact_result rc = COMPACT_SKIPPED;
 
-	/*
-	 * Check if the GFP flags allow compaction - GFP_NOIO is really
-	 * tricky context because the migration might require IO
-	 */
-	if (!may_perform_io)
+	if (!gfp_compaction_allowed(gfp_mask))
 		return COMPACT_SKIPPED;
 
 	trace_mm_compaction_try_to_compact_pages(order, gfp_mask, prio);
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 150d4f23b010..a663202045dc 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4041,6 +4041,7 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 						struct alloc_context *ac)
 {
 	bool can_direct_reclaim = gfp_mask & __GFP_DIRECT_RECLAIM;
+	bool can_compact = gfp_compaction_allowed(gfp_mask);
 	const bool costly_order = order > PAGE_ALLOC_COSTLY_ORDER;
 	struct page *page = NULL;
 	unsigned int alloc_flags;
@@ -4111,7 +4112,7 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 	 * Don't try this for allocations that are allowed to ignore
 	 * watermarks, as the ALLOC_NO_WATERMARKS attempt didn't yet happen.
 	 */
-	if (can_direct_reclaim &&
+	if (can_direct_reclaim && can_compact &&
 			(costly_order ||
 			   (order > 0 && ac->migratetype != MIGRATE_MOVABLE))
 			&& !gfp_pfmemalloc_allowed(gfp_mask)) {
@@ -4209,9 +4210,10 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 
 	/*
 	 * Do not retry costly high order allocations unless they are
-	 * __GFP_RETRY_MAYFAIL
+	 * __GFP_RETRY_MAYFAIL and we can compact
 	 */
-	if (costly_order && !(gfp_mask & __GFP_RETRY_MAYFAIL))
+	if (costly_order && (!can_compact ||
+			     !(gfp_mask & __GFP_RETRY_MAYFAIL)))
 		goto nopage;
 
 	if (should_reclaim_retry(gfp_mask, order, ac, alloc_flags,
@@ -4224,7 +4226,7 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 	 * implementation of the compaction depends on the sufficient amount
 	 * of free memory (see __compaction_suitable)
 	 */
-	if (did_some_progress > 0 &&
+	if (did_some_progress > 0 && can_compact &&
 			should_compact_retry(ac, order, alloc_flags,
 				compact_result, &compact_priority,
 				&compaction_retries))
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 4f9c854ce6cc..4255619a1a31 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -5753,7 +5753,7 @@ static void shrink_lruvec(struct lruvec *lruvec, struct scan_control *sc)
 /* Use reclaim/compaction for costly allocs or under memory pressure */
 static bool in_reclaim_compaction(struct scan_control *sc)
 {
-	if (IS_ENABLED(CONFIG_COMPACTION) && sc->order &&
+	if (gfp_compaction_allowed(sc->gfp_mask) && sc->order &&
 			(sc->order > PAGE_ALLOC_COSTLY_ORDER ||
 			 sc->priority < DEF_PRIORITY - 2))
 		return true;
@@ -5998,6 +5998,9 @@ static inline bool compaction_ready(struct zone *zone, struct scan_control *sc)
 {
 	unsigned long watermark;
 
+	if (!gfp_compaction_allowed(sc->gfp_mask))
+		return false;
+
 	/* Allocation can already succeed, nothing to do */
 	if (zone_watermark_ok(zone, sc->order, min_wmark_pages(zone),
 			      sc->reclaim_idx, 0))


