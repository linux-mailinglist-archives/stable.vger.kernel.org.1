Return-Path: <stable+bounces-35943-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CE34898B1F
	for <lists+stable@lfdr.de>; Thu,  4 Apr 2024 17:28:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E642D2820B9
	for <lists+stable@lfdr.de>; Thu,  4 Apr 2024 15:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6CB8823D0;
	Thu,  4 Apr 2024 15:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="iAAxK5ZE";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="vnEzIv4f";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="m3GzjUM8";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="UQfK3Iad"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5351BDC4
	for <stable@vger.kernel.org>; Thu,  4 Apr 2024 15:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712244531; cv=none; b=uMH7gUIFOZSQwnyw0xqHi61jFmMU+mZVN9CDOXdgN0+OpbxG/TMfi+VjpIJgLzMuwiOOemGzmzjfRsvFPkK5yUeDIdbWDT+F6IbIc/TJktIUvW4QE15ImVTwpFk7t8dKVCLXJ/5olmFJRLjyuCrAbRD+7w2G3uz6js2d25N0KHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712244531; c=relaxed/simple;
	bh=Ur0XNbg5OzPSR49NBcLOKIk/coJNZKxyfWEZFQBLmDE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rpzJyGVK4ixYyMI2trzCgRZlAk6ABWCe2OLe7BDW/bo8JS+Z/7965bD2VIcha/9rGETxXJciULNI3KUpcJE38AEQAYImGpHuMCiPOeWyOcfBv/ffPQljkSshY9XKBN3CER2ofpIxdIhZHeRh1NT5/fzWk3wWdFPuH52huT5bhfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=iAAxK5ZE; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=vnEzIv4f; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=m3GzjUM8; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=UQfK3Iad; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CDD8137CE8;
	Thu,  4 Apr 2024 15:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1712244527; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TLg3oI+nyedwotwsu4q//kXEFRE65MlLwr3LRgpLU+E=;
	b=iAAxK5ZEfM+Z2D5d6BFB9d6Oj7nMMQSgWCfrt7sUC+yePu8KLFHYIh1nI0HfMpp4e0/Z/B
	VQHVCCJfWmg3lH9fQH2FdHwM6h8do2+rxqCZ/39mfM+teXtPFUEbbFaRYT8Y/s7tp+mpRr
	ZAgCQt0TRRLu0HbJwcZI6UEy7zVDuiE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1712244527;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TLg3oI+nyedwotwsu4q//kXEFRE65MlLwr3LRgpLU+E=;
	b=vnEzIv4fJFZHThMIULIEFuVJlSShztFRfT12dy79zA49nNBpKV12Owr8PplUs4ynZgHWnd
	zY79w3yMshxgAwAQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=m3GzjUM8;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=UQfK3Iad
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1712244526; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TLg3oI+nyedwotwsu4q//kXEFRE65MlLwr3LRgpLU+E=;
	b=m3GzjUM8bt6zsf2RwhY/m+6JpI/iAfCGagNcKY9yunF9K7NfGelqCgFq+vNzTvw1UD3zd1
	IXShfoy2jz8mu+1HlTEmrTzJlvyEnI531jPbHT9eWpY1LajpaiaCRpBgSbeeS2BwrPP+/X
	QdyOcCI6bPh58beq9705qAvPhun8juM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1712244526;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TLg3oI+nyedwotwsu4q//kXEFRE65MlLwr3LRgpLU+E=;
	b=UQfK3IadMOVp06fDar3mQ6NWLnxBx6qitPWPicdNGw6B/JN6iEm0uLAgKSnkDUkwDncCvq
	9pAYnCVsWBNI87BQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id AC1D1139E8;
	Thu,  4 Apr 2024 15:28:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id BiO6KS7HDmbkHAAAn2gu4w
	(envelope-from <vbabka@suse.cz>); Thu, 04 Apr 2024 15:28:46 +0000
From: Vlastimil Babka <vbabka@suse.cz>
To: stable@vger.kernel.org
Cc: Vlastimil Babka <vbabka@suse.cz>,
	Sven van Ashbrook <svenva@chromium.org>,
	Karthikeyan Ramasubramanian <kramasub@chromium.org>,
	Brian Geffon <bgeffon@google.com>,
	Curtis Malainey <cujomalainey@chromium.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Mel Gorman <mgorman@techsingularity.net>,
	Michal Hocko <mhocko@kernel.org>,
	Takashi Iwai <tiwai@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 5.4.y] mm, vmscan: prevent infinite loop for costly GFP_NOIO | __GFP_RETRY_MAYFAIL allocations
Date: Thu,  4 Apr 2024 17:28:42 +0200
Message-ID: <20240404152841.27886-2-vbabka@suse.cz>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <2024032730-triceps-mustang-3ced@gregkh>
References: <2024032730-triceps-mustang-3ced@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: CDD8137CE8
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap2.dmz-prg2.suse.org:helo,imap2.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:email,suse.com:email];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	FROM_EQ_ENVFROM(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[11];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]

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
(cherry picked from commit 803de9000f334b771afacb6ff3e78622916668b0)
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 include/linux/gfp.h |  9 +++++++++
 mm/compaction.c     |  7 +------
 mm/page_alloc.c     | 10 ++++++----
 mm/vmscan.c         |  5 ++++-
 4 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index c89f8456f18d..e499bca54044 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -608,6 +608,15 @@ static inline bool pm_suspended_storage(void)
 }
 #endif /* CONFIG_PM_SLEEP */
 
+/*
+ * Check if the gfp flags allow compaction - GFP_NOIO is a really
+ * tricky context because the migration might require IO.
+ */
+static inline bool gfp_compaction_allowed(gfp_t gfp_mask)
+{
+	return IS_ENABLED(CONFIG_COMPACTION) && (gfp_mask & __GFP_IO);
+}
+
 #ifdef CONFIG_CONTIG_ALLOC
 /* The below functions must be run on a range from a single zone. */
 extern int alloc_contig_range(unsigned long start, unsigned long end,
diff --git a/mm/compaction.c b/mm/compaction.c
index 7a2675dbf3cc..138edfa834b9 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -2343,16 +2343,11 @@ enum compact_result try_to_compact_pages(gfp_t gfp_mask, unsigned int order,
 		unsigned int alloc_flags, const struct alloc_context *ac,
 		enum compact_priority prio, struct page **capture)
 {
-	int may_perform_io = gfp_mask & __GFP_IO;
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
index a3fca320e35a..0ad582945f54 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4445,6 +4445,7 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 						struct alloc_context *ac)
 {
 	bool can_direct_reclaim = gfp_mask & __GFP_DIRECT_RECLAIM;
+	bool can_compact = gfp_compaction_allowed(gfp_mask);
 	const bool costly_order = order > PAGE_ALLOC_COSTLY_ORDER;
 	struct page *page = NULL;
 	unsigned int alloc_flags;
@@ -4510,7 +4511,7 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 	 * Don't try this for allocations that are allowed to ignore
 	 * watermarks, as the ALLOC_NO_WATERMARKS attempt didn't yet happen.
 	 */
-	if (can_direct_reclaim &&
+	if (can_direct_reclaim && can_compact &&
 			(costly_order ||
 			   (order > 0 && ac->migratetype != MIGRATE_MOVABLE))
 			&& !gfp_pfmemalloc_allowed(gfp_mask)) {
@@ -4621,9 +4622,10 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 
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
@@ -4636,7 +4638,7 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 	 * implementation of the compaction depends on the sufficient amount
 	 * of free memory (see __compaction_suitable)
 	 */
-	if (did_some_progress > 0 &&
+	if (did_some_progress > 0 && can_compact &&
 			should_compact_retry(ac, order, alloc_flags,
 				compact_result, &compact_priority,
 				&compaction_retries))
diff --git a/mm/vmscan.c b/mm/vmscan.c
index de94881eaa92..cefd9cd27405 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2691,7 +2691,7 @@ static void shrink_node_memcg(struct pglist_data *pgdat, struct mem_cgroup *memc
 /* Use reclaim/compaction for costly allocs or under memory pressure */
 static bool in_reclaim_compaction(struct scan_control *sc)
 {
-	if (IS_ENABLED(CONFIG_COMPACTION) && sc->order &&
+	if (gfp_compaction_allowed(sc->gfp_mask) && sc->order &&
 			(sc->order > PAGE_ALLOC_COSTLY_ORDER ||
 			 sc->priority < DEF_PRIORITY - 2))
 		return true;
@@ -2940,6 +2940,9 @@ static inline bool compaction_ready(struct zone *zone, struct scan_control *sc)
 	unsigned long watermark;
 	enum compact_result suitable;
 
+	if (!gfp_compaction_allowed(sc->gfp_mask))
+		return false;
+
 	suitable = compaction_suitable(zone, sc->order, 0, sc->reclaim_idx);
 	if (suitable == COMPACT_SUCCESS)
 		/* Allocation should succeed already. Don't reclaim. */
-- 
2.44.0


