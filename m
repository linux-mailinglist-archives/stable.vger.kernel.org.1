Return-Path: <stable+bounces-35355-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0413894393
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 19:05:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1E751C2118F
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 17:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D268482E4;
	Mon,  1 Apr 2024 17:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nrrkCCc5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7B11DFF4;
	Mon,  1 Apr 2024 17:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711991126; cv=none; b=IA4PDRXSV3+0TtdmKNmKCATI7hyCtdJUIxRAa3HxzutGUrRigbY3u6IZBPaNOmoCOulDYuBkoXnJKwi2r2C627vtSGIKSAdu16H3555CkDc8p4+0YAKvvjMdwzSzBlYPKrVS/8l4+Ty7cMc3+WmkOfXqQaFwUfPFYz9t2Q+wLlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711991126; c=relaxed/simple;
	bh=cbiJl+oJLMDTFdKBjOwF4x2v4T8XCXwturD6sI1+7do=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I/gfwpL3Jpp3ANF6s+gtvfqdgVzBUvME4+FEccrd16COgeP32c3gxQD9F63pvrLZgrRXn+ItNdX624ddaaYIZjtj6ggeGEoUuIlwnWAnSiuzWUkeDg4aH8sChD0dqvoXSgQS/M9LPTzOMvo61BSrVehxKMwYtML8byqUOdxdxkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nrrkCCc5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E2C9C433C7;
	Mon,  1 Apr 2024 17:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711991125;
	bh=cbiJl+oJLMDTFdKBjOwF4x2v4T8XCXwturD6sI1+7do=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nrrkCCc5iTKwXKYyEQqr5LTK2Lb+781dNCh/BCdGCzT7HGVfnqbMmzrlojKQ3rPgj
	 Y7zX9BaeUNwEP6grXBWiZOpS/Wmu5QQRSFnLA51WAXhxQvGpEPgvdLe9TIIgers4M6
	 5e6UuwMaFhOBTp7hJxPo77a/arnQ/xXRyM5ds4mo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Vlastimil Babka <vbabka@suse.cz>,
	Sven van Ashbrook <svenva@chromium.org>,
	Karthikeyan Ramasubramanian <kramasub@chromium.org>,
	Brian Geffon <bgeffon@google.com>,
	Curtis Malainey <cujomalainey@chromium.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Mel Gorman <mgorman@techsingularity.net>,
	Michal Hocko <mhocko@kernel.org>,
	Takashi Iwai <tiwai@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.1 170/272] mm, vmscan: prevent infinite loop for costly GFP_NOIO | __GFP_RETRY_MAYFAIL allocations
Date: Mon,  1 Apr 2024 17:46:00 +0200
Message-ID: <20240401152536.061057149@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240401152530.237785232@linuxfoundation.org>
References: <20240401152530.237785232@linuxfoundation.org>
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

From: Vlastimil Babka <vbabka@suse.cz>

commit 803de9000f334b771afacb6ff3e78622916668b0 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/gfp.h |    9 +++++++++
 mm/compaction.c     |    7 +------
 mm/page_alloc.c     |   10 ++++++----
 mm/vmscan.c         |    5 ++++-
 4 files changed, 20 insertions(+), 11 deletions(-)

--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -341,6 +341,15 @@ bool gfp_pfmemalloc_allowed(gfp_t gfp_ma
 extern void pm_restrict_gfp_mask(void);
 extern void pm_restore_gfp_mask(void);
 
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
 
 #ifdef CONFIG_PM_SLEEP
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -2570,16 +2570,11 @@ enum compact_result try_to_compact_pages
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
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5012,6 +5012,7 @@ __alloc_pages_slowpath(gfp_t gfp_mask, u
 						struct alloc_context *ac)
 {
 	bool can_direct_reclaim = gfp_mask & __GFP_DIRECT_RECLAIM;
+	bool can_compact = gfp_compaction_allowed(gfp_mask);
 	const bool costly_order = order > PAGE_ALLOC_COSTLY_ORDER;
 	struct page *page = NULL;
 	unsigned int alloc_flags;
@@ -5090,7 +5091,7 @@ restart:
 	 * Don't try this for allocations that are allowed to ignore
 	 * watermarks, as the ALLOC_NO_WATERMARKS attempt didn't yet happen.
 	 */
-	if (can_direct_reclaim &&
+	if (can_direct_reclaim && can_compact &&
 			(costly_order ||
 			   (order > 0 && ac->migratetype != MIGRATE_MOVABLE))
 			&& !gfp_pfmemalloc_allowed(gfp_mask)) {
@@ -5188,9 +5189,10 @@ retry:
 
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
@@ -5203,7 +5205,7 @@ retry:
 	 * implementation of the compaction depends on the sufficient amount
 	 * of free memory (see __compaction_suitable)
 	 */
-	if (did_some_progress > 0 &&
+	if (did_some_progress > 0 && can_compact &&
 			should_compact_retry(ac, order, alloc_flags,
 				compact_result, &compact_priority,
 				&compaction_retries))
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -6024,7 +6024,7 @@ static void shrink_lruvec(struct lruvec
 /* Use reclaim/compaction for costly allocs or under memory pressure */
 static bool in_reclaim_compaction(struct scan_control *sc)
 {
-	if (IS_ENABLED(CONFIG_COMPACTION) && sc->order &&
+	if (gfp_compaction_allowed(sc->gfp_mask) && sc->order &&
 			(sc->order > PAGE_ALLOC_COSTLY_ORDER ||
 			 sc->priority < DEF_PRIORITY - 2))
 		return true;
@@ -6266,6 +6266,9 @@ static inline bool compaction_ready(stru
 	unsigned long watermark;
 	enum compact_result suitable;
 
+	if (!gfp_compaction_allowed(sc->gfp_mask))
+		return false;
+
 	suitable = compaction_suitable(zone, sc->order, 0, sc->reclaim_idx);
 	if (suitable == COMPACT_SUCCESS)
 		/* Allocation should succeed already. Don't reclaim. */



