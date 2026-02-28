Return-Path: <stable+bounces-220817-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kAFeAZ9Yo2nW/AQAu9opvQ
	(envelope-from <stable+bounces-220817-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 22:05:35 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 20D291C8C40
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 22:05:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4407A355E372
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EF5F4138DF;
	Sat, 28 Feb 2026 17:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S/PwK+aA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD17E2D23A5;
	Sat, 28 Feb 2026 17:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300702; cv=none; b=nACSPsqjxPHDkEhOthzXaTRaVZj1mIhBVSSHAJdj/r64tkL4VzvKUK/NH3wSfP0/GOQbBOnGw/c/BBgGLIdLxRjOT51wMVrkMBW5QV6UE0KcWIsvFsoy5wOx1rZ3pvCsIyLIbZ2QQE47lg091gTNBafbsPiHtN40G476NbbFOmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300702; c=relaxed/simple;
	bh=0qRTXaOIE4LNkwWI98+IZd+MNx2AL1wQd1q54OWNNZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X0C/EoimvuyBb0j77tdH4y7ISlQzuBlMnU5/Fe/SDuizDy/jAKgaQ4xHDXmLTgKJMJQI4NWIyhjwwHU4o1bJS0T7Xy/Z/abFH9zkAJa0zRs1zoN5FbG7WQZUGDfHLyVy0LVNaqPkFh397Z7eJ2MQvA3CRKa0nHM9ZaiZ9arQo9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S/PwK+aA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECED0C116D0;
	Sat, 28 Feb 2026 17:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300702;
	bh=0qRTXaOIE4LNkwWI98+IZd+MNx2AL1wQd1q54OWNNZY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S/PwK+aAH7hmufkQXq4/3oieFFX6x24aeulixvEWSyqKFmWg/teLNtFyjUFZzUs7g
	 Omt7IRyXSYNrCexRQZIblj7fKVr5YnDkkYDa348KGd8KEbkuF4Etr0jXBDYNgl16f4
	 mxosdPo8B+b4wLiakzTgbnyi1qtZPaR2WQ5p3R9yib1JMIs2Y9U+byax2BLDgGtqms
	 6JQ57Me0MAgW2ghhApnfSd5U8xWgQm1dUadIlXuR35CAbxP9gvNmq6Bg2k5Sg3Djox
	 RC/liQW00nHqEnbhCnmElNS064yXTWwVn6ugGJ4MgaKsxyh+49TjKAdCzNQbtpSWK+
	 EXgSB42pshwHg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Harry Yoo <harry.yoo@oracle.com>,
	kernel test robot <oliver.sang@intel.com>,
	Hao Li <hao.li@linux.dev>,
	Vlastimil Babka <vbabka@suse.cz>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 738/844] mm/slab: avoid allocating slabobj_ext array from its own slab
Date: Sat, 28 Feb 2026 12:30:51 -0500
Message-ID: <20260228173244.1509663-739-sashal@kernel.org>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220817-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:email,msgid.link:url,intel.com:email,suse.cz:email,oracle.com:email]
X-Rspamd-Queue-Id: 20D291C8C40
X-Rspamd-Action: no action

From: Harry Yoo <harry.yoo@oracle.com>

[ Upstream commit 280ea9c3154b2af7d841f992c9fc79e9d6534e03 ]

When allocating slabobj_ext array in alloc_slab_obj_exts(), the array
can be allocated from the same slab we're allocating the array for.
This led to obj_exts_in_slab() incorrectly returning true [1],
although the array is not allocated from wasted space of the slab.

Vlastimil Babka observed that this problem should be fixed even when
ignoring its incompatibility with obj_exts_in_slab(), because it creates
slabs that are never freed as there is always at least one allocated
object.

To avoid this, use the next kmalloc size or large kmalloc when
the array can be allocated from the same cache we're allocating
the array for.

In case of random kmalloc caches, there are multiple kmalloc caches
for the same size and the cache is selected based on the caller address.
Because it is fragile to ensure the same caller address is passed to
kmalloc_slab(), kmalloc_noprof(), and kmalloc_node_noprof(), bump the
size to (s->object_size + 1) when the sizes are equal, instead of
directly comparing the kmem_cache pointers.

Note that this doesn't happen when memory allocation profiling is
disabled, as when the allocation of the array is triggered by memory
cgroup (KMALLOC_CGROUP), the array is allocated from KMALLOC_NORMAL.

Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202601231457.f7b31e09-lkp@intel.com [1]
Cc: stable@vger.kernel.org
Fixes: 4b8736964640 ("mm/slab: add allocation accounting into slab allocation and free paths")
Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
Link: https://patch.msgid.link/20260126125714.88008-1-harry.yoo@oracle.com
Reviewed-by: Hao Li <hao.li@linux.dev>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/slub.c | 60 ++++++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 53 insertions(+), 7 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index e1583757331e7..9a7c2fec6208a 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2095,6 +2095,49 @@ static inline void init_slab_obj_exts(struct slab *slab)
 	slab->obj_exts = 0;
 }
 
+/*
+ * Calculate the allocation size for slabobj_ext array.
+ *
+ * When memory allocation profiling is enabled, the obj_exts array
+ * could be allocated from the same slab cache it's being allocated for.
+ * This would prevent the slab from ever being freed because it would
+ * always contain at least one allocated object (its own obj_exts array).
+ *
+ * To avoid this, increase the allocation size when we detect the array
+ * may come from the same cache, forcing it to use a different cache.
+ */
+static inline size_t obj_exts_alloc_size(struct kmem_cache *s,
+					 struct slab *slab, gfp_t gfp)
+{
+	size_t sz = sizeof(struct slabobj_ext) * slab->objects;
+	struct kmem_cache *obj_exts_cache;
+
+	/*
+	 * slabobj_ext array for KMALLOC_CGROUP allocations
+	 * are served from KMALLOC_NORMAL caches.
+	 */
+	if (!mem_alloc_profiling_enabled())
+		return sz;
+
+	if (sz > KMALLOC_MAX_CACHE_SIZE)
+		return sz;
+
+	if (!is_kmalloc_normal(s))
+		return sz;
+
+	obj_exts_cache = kmalloc_slab(sz, NULL, gfp, 0);
+	/*
+	 * We can't simply compare s with obj_exts_cache, because random kmalloc
+	 * caches have multiple caches per size, selected by caller address.
+	 * Since caller address may differ between kmalloc_slab() and actual
+	 * allocation, bump size when sizes are equal.
+	 */
+	if (s->object_size == obj_exts_cache->object_size)
+		return obj_exts_cache->object_size + 1;
+
+	return sz;
+}
+
 int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
 		        gfp_t gfp, bool new_slab)
 {
@@ -2103,26 +2146,26 @@ int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
 	unsigned long new_exts;
 	unsigned long old_exts;
 	struct slabobj_ext *vec;
+	size_t sz;
 
 	gfp &= ~OBJCGS_CLEAR_MASK;
 	/* Prevent recursive extension vector allocation */
 	gfp |= __GFP_NO_OBJ_EXT;
 
+	sz = obj_exts_alloc_size(s, slab, gfp);
+
 	/*
 	 * Note that allow_spin may be false during early boot and its
 	 * restricted GFP_BOOT_MASK. Due to kmalloc_nolock() only supporting
 	 * architectures with cmpxchg16b, early obj_exts will be missing for
 	 * very early allocations on those.
 	 */
-	if (unlikely(!allow_spin)) {
-		size_t sz = objects * sizeof(struct slabobj_ext);
-
+	if (unlikely(!allow_spin))
 		vec = kmalloc_nolock(sz, __GFP_ZERO | __GFP_NO_OBJ_EXT,
 				     slab_nid(slab));
-	} else {
-		vec = kcalloc_node(objects, sizeof(struct slabobj_ext), gfp,
-				   slab_nid(slab));
-	}
+	else
+		vec = kmalloc_node(sz, gfp | __GFP_ZERO, slab_nid(slab));
+
 	if (!vec) {
 		/*
 		 * Try to mark vectors which failed to allocate.
@@ -2136,6 +2179,9 @@ int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
 		return -ENOMEM;
 	}
 
+	VM_WARN_ON_ONCE(virt_to_slab(vec) != NULL &&
+			virt_to_slab(vec)->slab_cache == s);
+
 	new_exts = (unsigned long)vec;
 	if (unlikely(!allow_spin))
 		new_exts |= OBJEXTS_NOSPIN_ALLOC;
-- 
2.51.0


