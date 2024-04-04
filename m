Return-Path: <stable+bounces-35942-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81F74898B15
	for <lists+stable@lfdr.de>; Thu,  4 Apr 2024 17:27:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 389682838D2
	for <lists+stable@lfdr.de>; Thu,  4 Apr 2024 15:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 812402C189;
	Thu,  4 Apr 2024 15:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VLUHsA7g";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="vCM1LUn6";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VLUHsA7g";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="vCM1LUn6"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA9E1BC57
	for <stable@vger.kernel.org>; Thu,  4 Apr 2024 15:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712244414; cv=none; b=BT26pCQVwqCdp2bs9UJOmLrCVa2tOfI4QdyRIzZuu7vfS8TJekORabzAedGseSA7K1ZE5QSJsC0HwxFLqJOLsg6S63MMlBbEjBeFc8j+6eBXFN1ivUslxFdIt8SXUyaSsdmYUtR2JRTYZcEaUDqZSsy2ijXuQFbmmrpbLIxPJpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712244414; c=relaxed/simple;
	bh=E8n0TmVStuqECoNOK5XLM3PbGBqMSP24qBd+v2CVc9E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L6w97auWV8sKuDu6bf9E1jbKaSUbysolsHn0CgD5fSZfwaF3gzoPUh6/uYTYjj6CJXY0h2WU2tf++dMTrTMmwPoiVl+Hk/faZMhSzsB+oVDbIJkG6EvrophwoNUS2KYVPDV/uO7v689M+u1zlk4iUfs6Zeq4R3GNm54JGdy+Zo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=VLUHsA7g; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=vCM1LUn6; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=VLUHsA7g; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=vCM1LUn6; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 47DBD37CE0;
	Thu,  4 Apr 2024 15:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1712244410; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vbjbj4gB3+xqiUdgKiBq08Z4dKf07Pqc57dWU/Xv4co=;
	b=VLUHsA7gdPiWhFzL2jQaY2bjC40zzThYjy6Pyx+YLy1Sba7r6CzREcXehDopQYjUF72sGv
	F6/KP+qAhc0IaBL9R5uZXLIBbCTC6LhRtawebGOwNpSt1dLFbz5TrGmw2svxylXDNStyo+
	cXA9m5KgJqep51gN1s6FmTATUynYtdI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1712244410;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vbjbj4gB3+xqiUdgKiBq08Z4dKf07Pqc57dWU/Xv4co=;
	b=vCM1LUn6ggihY0+WGbeUBTyT4phkcB7KvmJw46lt3T5l+LCfvF6O7Ptf4fYWz+GlUiFgV5
	9m/5rrtEiIlqL4Cg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1712244410; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vbjbj4gB3+xqiUdgKiBq08Z4dKf07Pqc57dWU/Xv4co=;
	b=VLUHsA7gdPiWhFzL2jQaY2bjC40zzThYjy6Pyx+YLy1Sba7r6CzREcXehDopQYjUF72sGv
	F6/KP+qAhc0IaBL9R5uZXLIBbCTC6LhRtawebGOwNpSt1dLFbz5TrGmw2svxylXDNStyo+
	cXA9m5KgJqep51gN1s6FmTATUynYtdI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1712244410;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vbjbj4gB3+xqiUdgKiBq08Z4dKf07Pqc57dWU/Xv4co=;
	b=vCM1LUn6ggihY0+WGbeUBTyT4phkcB7KvmJw46lt3T5l+LCfvF6O7Ptf4fYWz+GlUiFgV5
	9m/5rrtEiIlqL4Cg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 30636139E8;
	Thu,  4 Apr 2024 15:26:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id E22CC7rGDmZVHAAAn2gu4w
	(envelope-from <vbabka@suse.cz>); Thu, 04 Apr 2024 15:26:50 +0000
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
Subject: [PATCH 5.10.y] mm, vmscan: prevent infinite loop for costly GFP_NOIO | __GFP_RETRY_MAYFAIL allocations
Date: Thu,  4 Apr 2024 17:26:49 +0200
Message-ID: <20240404152648.21827-2-vbabka@suse.cz>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <2024032727-pastel-sincerity-a986@gregkh>
References: <2024032727-pastel-sincerity-a986@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email,imap2.dmz-prg2.suse.org:helo,imap2.dmz-prg2.suse.org:rdns];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

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
index c603237e006c..973f4143f9f6 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -623,6 +623,15 @@ static inline bool pm_suspended_storage(void)
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
index b58021666e1a..77ca5e6f4980 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -2466,16 +2466,11 @@ enum compact_result try_to_compact_pages(gfp_t gfp_mask, unsigned int order,
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
index 124ab9324610..ed66601044be 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4644,6 +4644,7 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 						struct alloc_context *ac)
 {
 	bool can_direct_reclaim = gfp_mask & __GFP_DIRECT_RECLAIM;
+	bool can_compact = gfp_compaction_allowed(gfp_mask);
 	const bool costly_order = order > PAGE_ALLOC_COSTLY_ORDER;
 	struct page *page = NULL;
 	unsigned int alloc_flags;
@@ -4709,7 +4710,7 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 	 * Don't try this for allocations that are allowed to ignore
 	 * watermarks, as the ALLOC_NO_WATERMARKS attempt didn't yet happen.
 	 */
-	if (can_direct_reclaim &&
+	if (can_direct_reclaim && can_compact &&
 			(costly_order ||
 			   (order > 0 && ac->migratetype != MIGRATE_MOVABLE))
 			&& !gfp_pfmemalloc_allowed(gfp_mask)) {
@@ -4806,9 +4807,10 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 
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
@@ -4821,7 +4823,7 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 	 * implementation of the compaction depends on the sufficient amount
 	 * of free memory (see __compaction_suitable)
 	 */
-	if (did_some_progress > 0 &&
+	if (did_some_progress > 0 && can_compact &&
 			should_compact_retry(ac, order, alloc_flags,
 				compact_result, &compact_priority,
 				&compaction_retries))
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 51ccd80e70b6..e2b8cee1dbc3 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2546,7 +2546,7 @@ static void shrink_lruvec(struct lruvec *lruvec, struct scan_control *sc)
 /* Use reclaim/compaction for costly allocs or under memory pressure */
 static bool in_reclaim_compaction(struct scan_control *sc)
 {
-	if (IS_ENABLED(CONFIG_COMPACTION) && sc->order &&
+	if (gfp_compaction_allowed(sc->gfp_mask) && sc->order &&
 			(sc->order > PAGE_ALLOC_COSTLY_ORDER ||
 			 sc->priority < DEF_PRIORITY - 2))
 		return true;
@@ -2873,6 +2873,9 @@ static inline bool compaction_ready(struct zone *zone, struct scan_control *sc)
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


