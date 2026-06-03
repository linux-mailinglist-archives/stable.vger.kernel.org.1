Return-Path: <stable+bounces-260212-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1YTEEl25IGq57AAAu9opvQ
	(envelope-from <stable+bounces-260212-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 04 Jun 2026 01:31:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 987C863BDDB
	for <lists+stable@lfdr.de>; Thu, 04 Jun 2026 01:31:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux-foundation.org header.s=korg header.b=kE2K9bWR;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260212-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-260212-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0202A3022964
	for <lists+stable@lfdr.de>; Wed,  3 Jun 2026 23:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D2794DC55B;
	Wed,  3 Jun 2026 23:26:33 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2AB74D90A3;
	Wed,  3 Jun 2026 23:26:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780529192; cv=none; b=lG6ZZVTIz1L+MlLRdncaJM4cfwFQVfqcbgwFNTEi/GvEjQsplyksT2F4KnXqqveLM3XGKCtEZLX6gW0i1v0SDpRkffJIOyMBd51GVZuc9CrVBEu+/rFF5P/QSe7Yl9hw4/iZK5aPQhsAmrcrld2t/koZccqlNp++ntUFHFRZRgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780529192; c=relaxed/simple;
	bh=2t2MLzdaGXJGsav2c1PZveaVdsWKdu4yPlftA9c0PyU=;
	h=Date:To:From:Subject:Message-Id; b=awjOsTmWXP+xfZrQsJP5gfAZO39efbKkLprjr/rj7FJTHlx3X1+qdCqmmZlZ3bmiEm94PitwAzdIzXEzNyhjwWpDcH8FsUaArpuqFZHDk+H/SlYkT5uYAfK40b3mFkjNVoywM6pQR1tVTiZZfCgmsivSJG16KB08WpRIUaaHZU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=kE2K9bWR; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9548D1F00898;
	Wed,  3 Jun 2026 23:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1780529191;
	bh=ck6ml1iYq+Rkt9mPqYYSruFH+OZ88K3AYa86J1KfjtA=;
	h=Date:To:From:Subject;
	b=kE2K9bWRiuWcsUVST53uHELvrV6iqztHeYPKGRpFM0clbZUdUSyYN/HeJKv1sM3tK
	 EuONevOrH/tnLqqdBjcd5QWs61WZLBzwVmxoGxmtqhMX/RawdpgLc6PDFi6f9O72M9
	 LmZgEQW3p3X5d7O2fmwtJa5079MaMNVa3l0tujQM=
Date: Wed, 03 Jun 2026 16:26:31 -0700
To: mm-commits@vger.kernel.org,stable@vger.kernel.org,roman.gushchin@linux.dev,muchun.song@linux.dev,kasong@tencent.com,hannes@cmpxchg.org,david@fromorbit.com,clm@fb.com,shakeel.butt@linux.dev,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: [merged mm-hotfixes-stable] mm-list_lru-drain-before-clearing-xarray-entry-on-reparent.patch removed from -mm tree
Message-Id: <20260603232631.9548D1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-260212-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:mm-commits@vger.kernel.org,m:stable@vger.kernel.org,m:roman.gushchin@linux.dev,m:muchun.song@linux.dev,m:kasong@tencent.com,m:hannes@cmpxchg.org,m:david@fromorbit.com,m:clm@fb.com,m:shakeel.butt@linux.dev,m:akpm@linux-foundation.org,s:lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	DMARC_NA(0.00)[linux-foundation.org];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,smtp.kernel.org:mid,linux-foundation.org:dkim,linux-foundation.org:from_mime,linux-foundation.org:email,fromorbit.com:email,linux.dev:email,vger.kernel.org:from_smtp,cmpxchg.org:email,tencent.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 987C863BDDB


The quilt patch titled
     Subject: mm/list_lru: drain before clearing xarray entry on reparent
has been removed from the -mm tree.  Its filename was
     mm-list_lru-drain-before-clearing-xarray-entry-on-reparent.patch

This patch was dropped because it was merged into the mm-hotfixes-stable branch
of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

------------------------------------------------------
From: Shakeel Butt <shakeel.butt@linux.dev>
Subject: mm/list_lru: drain before clearing xarray entry on reparent
Date: Mon, 1 Jun 2026 09:15:01 -0700

memcg_reparent_list_lrus() clears the dying memcg's xarray entry with
xas_store(&xas, NULL) before reparenting its per-node lists into the
parent.  This opens a window where a concurrent list_lru_del() arriving
for the dying memcg sees xa_load() == NULL, walks to the parent in
lock_list_lru_of_memcg(), takes the parent's per-node lock, and calls
list_del_init() on an item still physically linked on the dying memcg's
list.

If another in-flight thread holds the dying memcg's per-node lock at the
same moment (another list_lru_del, or a list_lru_walk_one running an
isolate callback), both threads modify ->next/->prev pointers on the same
physical list under different locks.  Adjacent items can corrupt each
other's links.

Fix it by reversing the order: reparent each per-node list and mark the
child's list lru dead and then clear the xarray entry.  Any concurrent
list_lru op that finds the still-set xarray entry either takes the dying
memcg's per-node lock (synchronizing with the drain) or sees LONG_MIN and
walks to the parent, where the items now live.

Link: https://lore.kernel.org/20260601161501.1444829-1-shakeel.butt@linux.dev
Fixes: fb56fdf8b9a2 ("mm/list_lru: split the lock to per-cgroup scope")
Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
Reported-by: Chris Mason <clm@fb.com>
Reviewed-by: Kairui Song <kasong@tencent.com>
Acked-by: Muchun Song <muchun.song@linux.dev>
Cc: Dave Chinner <david@fromorbit.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Roman Gushchin <roman.gushchin@linux.dev>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/list_lru.c |   21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

--- a/mm/list_lru.c~mm-list_lru-drain-before-clearing-xarray-entry-on-reparent
+++ a/mm/list_lru.c
@@ -473,26 +473,29 @@ void memcg_reparent_list_lrus(struct mem
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
_

Patches currently in -mm which might be from shakeel.butt@linux.dev are



