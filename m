Return-Path: <stable+bounces-259616-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KBd+FU2xHWphdAkAu9opvQ
	(envelope-from <stable+bounces-259616-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 01 Jun 2026 18:20:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E9FD56227A8
	for <lists+stable@lfdr.de>; Mon, 01 Jun 2026 18:20:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 09D2230243B0
	for <lists+stable@lfdr.de>; Mon,  1 Jun 2026 16:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45202296BBA;
	Mon,  1 Jun 2026 16:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UHPu02Cw"
X-Original-To: stable@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3D91DC1AB
	for <stable@vger.kernel.org>; Mon,  1 Jun 2026 16:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780330557; cv=none; b=boQaLw5M97lUjPF7QGzhfjfYax9jQe4P6I5DgVUcczNLOY8PGPouP7jWPDUq7tuYUBOg4C8r+PvYFEDRzloaj6LV1lj2OI8p9eCcgY6To9rNoJFRZIn55QycQWvrE32RW5vnz148gI9FUqJCEefrXVdVqSFAUmySMXSLtp28BBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780330557; c=relaxed/simple;
	bh=urwtJXD2L8n5ZYqmLSGDTT4EVINn0D7g03jnqLp5ppw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hjTkwpABZFW7COgVl8FsRkXDBpi+TKXJn+cX4USt/EeGkYML6IQuL1XYNuO1ADZ1pqcMPB24JtgCkG24d4QzSDMtqMKl1b0sVgfsp+DvEmCvGsbK27GCz9nGJ2AZr2HJ+0sfRSPcab8rRVrXeGA99iCGQJX7fnvOpgck3UYU8dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UHPu02Cw; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780330543;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rQzi2gONxiIcDHLm2VrGnw9O4REpeifQom+6RrcJBmg=;
	b=UHPu02CwuMbgjZG0+HMELc4RBe5U3EZ7RKAqtpyPIJnXvVryWYBOOtyJ7bZCGkqOgMiXHC
	xufUOXPsuX9osPAjao2KYXDh3t8t9BASS6p/vuIulI5fCZ3OLzGDdWQj/ym+QC2kyUbw8Q
	LtEq5I5DMjlJPvNettYkKG+F0+CQDlk=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Dave Chinner <david@fromorbit.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Qi Zheng <qi.zheng@linux.dev>,
	Kairui Song <kasong@tencent.com>,
	Meta kernel team <kernel-team@meta.com>,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chris Mason <clm@fb.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] mm/list_lru: drain before clearing xarray entry on reparent
Date: Mon,  1 Jun 2026 09:15:01 -0700
Message-ID: <20260601161501.1444829-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259616-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_COUNT_THREE(0.00)[3];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shakeel.butt@linux.dev,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linux.dev:email,linux.dev:mid,linux.dev:dkim]
X-Rspamd-Queue-Id: E9FD56227A8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

memcg_reparent_list_lrus() clears the dying memcg's xarray entry with
xas_store(&xas, NULL) before reparenting its per-node lists into the
parent. This opens a window where a concurrent list_lru_del() arriving
for the dying memcg sees xa_load() == NULL, walks to the parent in
lock_list_lru_of_memcg(), takes the parent's per-node lock, and calls
list_del_init() on an item still physically linked on the dying
memcg's list.

If another in-flight thread holds the dying memcg's per-node lock at
the same moment (another list_lru_del, or a list_lru_walk_one running
an isolate callback), both threads modify ->next/->prev pointers on the
same physical list under different locks. Adjacent items can corrupt
each other's links.

Fix it by reversing the order: reparent each per-node list and mark the
child's list lru dead and then clear the xarray entry. Any concurrent
list_lru op that finds the still-set xarray entry either takes the dying
memcg's per-node lock (synchronizing with the drain) or sees LONG_MIN
and walks to the parent, where the items now live.

Fixes: fb56fdf8b9a2 ("mm/list_lru: split the lock to per-cgroup scope")
Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
Reported-by: Chris Mason <clm@fb.com>
Cc: stable@vger.kernel.org
---
Changes since v1:
- Use xa_erase_irq() instead of xa_erase() (Sashiko & Claude).
- Added comment on CSS_DYING check in memcg_list_lru_alloc avoiding a new mlru
  allocation.

 mm/list_lru.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/mm/list_lru.c b/mm/list_lru.c
index dd29bcf8eb5f..d454bce9a78e 100644
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -473,26 +473,29 @@ void memcg_reparent_list_lrus(struct mem_cgroup *memcg, struct mem_cgroup *paren
 	mutex_lock(&list_lrus_mutex);
 	list_for_each_entry(lru, &memcg_list_lrus, list) {
 		struct list_lru_memcg *mlru;
-		XA_STATE(xas, &lru->xa, memcg->kmemcg_id);
 
 		/*
-		 * Lock the Xarray to ensure no on going list_lru_memcg
-		 * allocation and further allocation will see css_is_dying().
+		 * css_is_dying() check in memcg_list_lru_alloc() avoids
+		 * allocating a new mlru since CSS_DYING is already set for this
+		 * memcg a rcu grace period ago.
 		 */
-		xas_lock_irq(&xas);
-		mlru = xas_store(&xas, NULL);
-		xas_unlock_irq(&xas);
+		mlru = xa_load(&lru->xa, memcg->kmemcg_id);
 		if (!mlru)
 			continue;
 
 		/*
-		 * With Xarray value set to NULL, holding the lru lock below
-		 * prevents list_lru_{add,del,isolate} from touching the lru,
-		 * safe to reparent.
+		 * Reparent each per-node list and mark the child dead
+		 * (LONG_MIN) before clearing xarray entry otherwise a
+		 * concurrent list_lru_del() may corrupt the list if it arrives
+		 * after xarray clear but before reparenting as
+		 * lock_list_lru_of_memcg will acquire parent's lock while the
+		 * item is still on child's list.
 		 */
 		for_each_node(i)
 			memcg_reparent_list_lru_one(lru, i, &mlru->node[i], parent);
 
+		xa_erase_irq(&lru->xa, memcg->kmemcg_id);
+
 		/*
 		 * Here all list_lrus corresponding to the cgroup are guaranteed
 		 * to remain empty, we can safely free this lru, any further
-- 
2.53.0-Meta


