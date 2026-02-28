Return-Path: <stable+bounces-220873-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8KAgA5BHo2lM/AQAu9opvQ
	(envelope-from <stable+bounces-220873-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:52:48 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E7741C7757
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:52:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 66ED3315B936
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54F9B41F549;
	Sat, 28 Feb 2026 17:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PjZjTZ4C"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82BE641EE06;
	Sat, 28 Feb 2026 17:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300760; cv=none; b=fUSRLxo74xdIzqAewbt+OSiWs2KCtoAZlbjAAVB96UXMKgzVHVOkJc685LKPOs//c0gPtCQ3dsrPKVNzLGYlPklbVFeA8E197plVLXs9s8GjJlweyyYlW09nU34wC9XfggMMw4rMnokqWudsuzhKkF5FmPOufeza96cbsbcf32Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300760; c=relaxed/simple;
	bh=zp6cO7ZFhELTQw7V6vC4EMFq2kivJRRUtz9gBME0WYE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KtgWdA09wcvGBk4fsHx1TVWXt55xZQnJQfhU7bmfm1Ld/OJ/queb6fSkR/mn7Esb0QZjEsJoN7fCN/HYKzbvPioNEE4oaA2LVpZ2OkZlcvzI0wlll9OZiCT8az+VwGuVmPrltBIxDxSAAX0tmiqz5RFRgdKu8NGpn9PjVvbZ1EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PjZjTZ4C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87A2AC2BC9E;
	Sat, 28 Feb 2026 17:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300760;
	bh=zp6cO7ZFhELTQw7V6vC4EMFq2kivJRRUtz9gBME0WYE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PjZjTZ4Cwy0ZrKdk+EMIxy+qVWLEK/ZsH905v38p/4N2tJIhLysmcP/v8Lyk5k6kR
	 hWmBf7FjaV85hOQncZEBqbUkiggBwqBbul9ox1r+oOv6uKdHJE8THHKATjVAUdxO+l
	 bKgJoMaIbYBqCXPuNA1FUboF6tLnBiqbx/VL2IU3X40sIJEPtYiSs/T9TR+JdZvvpz
	 Yi1nvwXYWxwgS0oV5RhoReeJr9a8B9Zz7nZ8auN9v+heDJx0GBSBv78YQE6jVAaNc4
	 iSwJT8C+Hz/fE3G5prk0RPqIjPjhcJEJavLQL/ISTdyrJh+JdyUfD9sGf2qGQvASjZ
	 YQ1mnIjS0iv0w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Harry Yoo <harry.yoo@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Zi Yan <ziy@nvidia.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@suse.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Suren Baghdasaryan <surenb@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 794/844] mm/page_alloc: skip debug_check_no_{obj,locks}_freed with FPI_TRYLOCK
Date: Sat, 28 Feb 2026 12:31:47 -0500
Message-ID: <20260228173244.1509663-795-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220873-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9E7741C7757
X-Rspamd-Action: no action

From: Harry Yoo <harry.yoo@oracle.com>

[ Upstream commit 338ad1e84d15078a9ae46d7dd7466329ae0bfa61 ]

When CONFIG_DEBUG_OBJECTS_FREE is enabled,
debug_check_no_{obj,locks}_freed() functions are called.

Since both of them spin on a lock, they are not safe to be called if the
FPI_TRYLOCK flag is specified.  This leads to a lockdep splat:

  ================================
  WARNING: inconsistent lock state
  6.19.0-rc5-slab-for-next+ #326 Tainted: G                 N
  --------------------------------
  inconsistent {INITIAL USE} -> {IN-NMI} usage.
  kunit_try_catch/9046 [HC2[2]:SC0[0]:HE0:SE1] takes:
  ffffffff84ed6bf8 (&obj_hash[i].lock){-.-.}-{2:2}, at: __debug_check_no_obj_freed+0xe0/0x300
  {INITIAL USE} state was registered at:
    lock_acquire+0xd9/0x2f0
    _raw_spin_lock_irqsave+0x4c/0x80
    __debug_object_init+0x9d/0x1f0
    debug_object_init+0x34/0x50
    __init_work+0x28/0x40
    init_cgroup_housekeeping+0x151/0x210
    init_cgroup_root+0x3d/0x140
    cgroup_init_early+0x30/0x240
    start_kernel+0x3e/0xcd0
    x86_64_start_reservations+0x18/0x30
    x86_64_start_kernel+0xf3/0x140
    common_startup_64+0x13e/0x148
  irq event stamp: 2998
  hardirqs last  enabled at (2997): [<ffffffff8298b77a>] exc_nmi+0x11a/0x240
  hardirqs last disabled at (2998): [<ffffffff8298b991>] sysvec_irq_work+0x11/0x110
  softirqs last  enabled at (1416): [<ffffffff813c1f72>] __irq_exit_rcu+0x132/0x1c0
  softirqs last disabled at (1303): [<ffffffff813c1f72>] __irq_exit_rcu+0x132/0x1c0

  other info that might help us debug this:
   Possible unsafe locking scenario:

         CPU0
         ----
    lock(&obj_hash[i].lock);
    <Interrupt>
      lock(&obj_hash[i].lock);

   *** DEADLOCK ***

Rename free_pages_prepare() to __free_pages_prepare(), add an fpi_t
parameter, and skip those checks if FPI_TRYLOCK is set.  To keep the fpi_t
definition in mm/page_alloc.c, add a wrapper function free_pages_prepare()
that always passes FPI_NONE and use it in mm/compaction.c.

Link: https://lkml.kernel.org/r/20260209062639.16577-1-harry.yoo@oracle.com
Fixes: 8c57b687e833 ("mm, bpf: Introduce free_pages_nolock()")
Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Acked-by: Zi Yan <ziy@nvidia.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Brendan Jackman <jackmanb@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/page_alloc.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 1af52f568f22d..48af3d7b47849 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1340,8 +1340,8 @@ static inline void pgalloc_tag_sub_pages(struct alloc_tag *tag, unsigned int nr)
 
 #endif /* CONFIG_MEM_ALLOC_PROFILING */
 
-__always_inline bool free_pages_prepare(struct page *page,
-			unsigned int order)
+__always_inline bool __free_pages_prepare(struct page *page,
+					  unsigned int order, fpi_t fpi_flags)
 {
 	int bad = 0;
 	bool skip_kasan_poison = should_skip_kasan_poison(page);
@@ -1434,7 +1434,7 @@ __always_inline bool free_pages_prepare(struct page *page,
 	page_table_check_free(page, order);
 	pgalloc_tag_sub(page, 1 << order);
 
-	if (!PageHighMem(page)) {
+	if (!PageHighMem(page) && !(fpi_flags & FPI_TRYLOCK)) {
 		debug_check_no_locks_freed(page_address(page),
 					   PAGE_SIZE << order);
 		debug_check_no_obj_freed(page_address(page),
@@ -1473,6 +1473,11 @@ __always_inline bool free_pages_prepare(struct page *page,
 	return true;
 }
 
+bool free_pages_prepare(struct page *page, unsigned int order)
+{
+	return __free_pages_prepare(page, order, FPI_NONE);
+}
+
 /*
  * Frees a number of pages from the PCP lists
  * Assumes all pages on list are in same zone.
@@ -1606,7 +1611,7 @@ static void __free_pages_ok(struct page *page, unsigned int order,
 	unsigned long pfn = page_to_pfn(page);
 	struct zone *zone = page_zone(page);
 
-	if (free_pages_prepare(page, order))
+	if (__free_pages_prepare(page, order, fpi_flags))
 		free_one_page(zone, page, pfn, order, fpi_flags);
 }
 
@@ -2970,7 +2975,7 @@ static void __free_frozen_pages(struct page *page, unsigned int order,
 		return;
 	}
 
-	if (!free_pages_prepare(page, order))
+	if (!__free_pages_prepare(page, order, fpi_flags))
 		return;
 
 	/*
@@ -3027,7 +3032,7 @@ void free_unref_folios(struct folio_batch *folios)
 		unsigned long pfn = folio_pfn(folio);
 		unsigned int order = folio_order(folio);
 
-		if (!free_pages_prepare(&folio->page, order))
+		if (!__free_pages_prepare(&folio->page, order, FPI_NONE))
 			continue;
 		/*
 		 * Free orders not handled on the PCP directly to the
-- 
2.51.0


