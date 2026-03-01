Return-Path: <stable+bounces-221466-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sP1FKjiYo2neHgUAu9opvQ
	(envelope-from <stable+bounces-221466-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:36:56 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DCAA71CB253
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:36:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 04756303AB77
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDA85284662;
	Sun,  1 Mar 2026 01:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ui2p/pOk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B274D274B42
	for <stable@vger.kernel.org>; Sun,  1 Mar 2026 01:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772328334; cv=none; b=uxF079Ev3w6UNfG2qhy44ccm57Pib3nlh/uJzOGZWPXK8jwge6oBT0UaXAbZEGi7hX7JtyqajzBHZnOIhDnWtQQD9ct1MOI262qykMsAM0+UKAR92P/IznRaRE73alXsXga5njRnWRTTOYSMrWZMo/TutfA2Ab1ikxhQakyUS/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772328334; c=relaxed/simple;
	bh=Q9Okaugaz+aU0hKuYTjGGh7QDKeQjLlPanWsAccytIw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dEUj1mDgMSQRURuN0JeC9HvZVzs5mu3nJJa1BCm18jv/pW3K1OlesgLJtsEd47i2wi5beh0lV+fmLPoXkm2PnjMC31hHV7cHAg+EJG4rJ/MWEM+EginN6fZAPf0TiiyKjdaPClIpF8KMBA3hoHRRjQODhurSMb36v88cs8aSFCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ui2p/pOk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED820C19421;
	Sun,  1 Mar 2026 01:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772328334;
	bh=Q9Okaugaz+aU0hKuYTjGGh7QDKeQjLlPanWsAccytIw=;
	h=From:To:Cc:Subject:Date:From;
	b=ui2p/pOkcfTuuorty0OjyEd6wRdFiDR1P8vsT4Ex/N4fGLh7I2xuMY2j9ez/rka45
	 Jf6kBnTJjIfAdMtv8eINU+kF153ogMcmuKUoletB9iff6ooFxslpDPDB0eH68ChpjL
	 757CqX4X9m6/mctp9CIewriTJKZiPkXtdEiet/niGB8ScYlicU52a8tmj6jsnak/g0
	 vlDmn/3o41zrooyx0XnQ3u0rxtT0UUqdn9E8aH1XZDymk9bGkVGbgQ/uELU/qzIWBc
	 CbtV57pg9HVOvcyP0dJxP0AQki5UP0aRanczetkDEhnXyntu06kvkRpEgPLF9Y2t79
	 fsayBc0JSeQiw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	harry.yoo@oracle.com
Cc: kernel test robot <oliver.sang@intel.com>,
	Hao Li <hao.li@linux.dev>,
	Vlastimil Babka <vbabka@suse.cz>,
	linux-mm@kvack.org
Subject: FAILED: Patch "mm/slab: avoid allocating slabobj_ext array from its own slab" failed to apply to 6.12-stable tree
Date: Sat, 28 Feb 2026 20:25:32 -0500
Message-ID: <20260301012532.1682677-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-221466-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: DCAA71CB253
X-Rspamd-Action: no action

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 280ea9c3154b2af7d841f992c9fc79e9d6534e03 Mon Sep 17 00:00:00 2001
From: Harry Yoo <harry.yoo@oracle.com>
Date: Mon, 26 Jan 2026 21:57:14 +0900
Subject: [PATCH] mm/slab: avoid allocating slabobj_ext array from its own slab

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
---
 mm/slub.c | 60 ++++++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 53 insertions(+), 7 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index afc3e511ff395..65b6d07ef20e6 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2092,6 +2092,49 @@ static inline void init_slab_obj_exts(struct slab *slab)
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
@@ -2100,26 +2143,26 @@ int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
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
@@ -2133,6 +2176,9 @@ int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
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





