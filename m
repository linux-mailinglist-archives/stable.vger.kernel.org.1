Return-Path: <stable+bounces-269863-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dehRD30tQ2osTgoAu9opvQ
	(envelope-from <stable+bounces-269863-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 30 Jun 2026 04:44:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B641F6DFD71
	for <lists+stable@lfdr.de>; Tue, 30 Jun 2026 04:44:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=JOg43IoH;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269863-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-269863-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 80AE73007CA4
	for <lists+stable@lfdr.de>; Tue, 30 Jun 2026 02:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C6483672B1;
	Tue, 30 Jun 2026 02:44:08 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1B1279DCA
	for <stable@vger.kernel.org>; Tue, 30 Jun 2026 02:44:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782787448; cv=none; b=eTmpkwBkTrQIEoK67O2RMj6FPkdKBjq3m2Vrdv/YrvFSYrGNusP2FH0B/YWEGdlS/GCQ9aAPUAmNaXbHHSYk2SwHrXXX5M40C+q6GuCIFuZFgBTffAgKsEkccsqIMIgPWkG+xLY5LD56zLc5cezNbxVkjMfihZU4k4GiDkVkYEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782787448; c=relaxed/simple;
	bh=eBSBGs6aNScPUCKpo+vT+qvFs9XAbRAhYVfZTVQpduA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iXVF5QHU/K1BKT8pPt3OKixkjwznhUuv5tlzvhyNswDAtrEoKsop8/TiH+D1O0Ovwf3rUJYXkJgDJWfrseshtbi8OvOzNrQkUA8i5bOo24k8MEL1EfmfDqK/fuQIQHQ6OIMvw4+MqAuStsFlA9dPgq1XielDjf4r+kxFSH5brs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JOg43IoH; arc=none smtp.client-ip=91.218.175.185
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782787443;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=przQJnpstYbr3eVo4htMKq85wkvryQTqcf4xu3NpvDY=;
	b=JOg43IoH/WE5Oo93MNa7XuGTzkdCdWIfByQQECpkoeup9Vvtuzez//jZzxPlCLNseepAwL
	gQAUnp0FhKuIW1XBMoYMn6Ioe1EdJFBpxOqS8A/oE1S5CYsvxPv/Xp/EYX0Zdny3E02UDw
	aqHK+MCn95+QgNTaeLnn+b3NzgpNlxs=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Vlastimil Babka <vbabka@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Harry Yoo <harry@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hao Li <hao.li@linux.dev>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Usama Arif <usama.arif@linux.dev>,
	Meta kernel team <kernel-team@meta.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Danielle Costantino <dcostantino@meta.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] mm/slub: serve slabobj_ext array from a strictly larger kmalloc cache
Date: Mon, 29 Jun 2026 19:43:57 -0700
Message-ID: <20260630024357.3591304-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269863-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS(0.00)[m:vbabka@kernel.org,m:akpm@linux-foundation.org,m:harry@kernel.org,m:roman.gushchin@linux.dev,m:hao.li@linux.dev,m:cl@gentwo.org,m:rientjes@google.com,m:surenb@google.com,m:usama.arif@linux.dev,m:kernel-team@meta.com,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:dcostantino@meta.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[shakeel.butt@linux.dev,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shakeel.butt@linux.dev,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:dkim,linux.dev:email,linux.dev:mid,linux.dev:from_mime,meta.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B641F6DFD71

A production host in the Meta fleet (6.16 kernel, memory allocation
profiling enabled) panicked with a kernel stack overflow while a kernel
driver was freeing a resource:

  BUG: TASK stack guard page was hit
  Oops: stack guard page
  RIP: 0010:kfree+0x8/0x5d0
  Call Trace:
   __free_slab+0x66/0xc0
   kfree+0x3f0/0x5d0
   ... ( ~125x __free_slab <-> kfree ) ...
   <kernel driver freeing a resource>
   do_syscall_64

The crash dump shows a 125-deep __free_slab<->kfree recursion that
overflowed the 16 KiB kernel stack.

What happened: a KMALLOC_NORMAL slab's obj_exts array (used by allocation
profiling / memcg accounting) is itself kmalloc()'d from a KMALLOC_NORMAL
cache, so the "slab holds another slab's obj_exts array" relation can form
cycles.  With sizeof(struct slabobj_ext) == 16 and the host's geometry:

  - kmalloc-512 has 64 objects/slab -> array is 64*16 == 1024 bytes,
    served from kmalloc-1k;
  - kmalloc-1k  has 32 objects/slab -> array is 32*16 ==  512 bytes,
    served from kmalloc-512.

A kmalloc-512 slab and a kmalloc-1k slab therefore hold each other's
obj_exts array.  Discarding one frees the other's array, which empties and
discards that slab, which frees the first's array, and so on:
__free_slab() -> free_slab_obj_exts() -> kfree() -> discard_slab() ->
__free_slab() recurses along the cycle until the stack is exhausted.  The
dump confirms it: the recursion's slabs strictly alternate kmalloc-512
(obj_exts in kmalloc-1k) and kmalloc-1k (obj_exts in kmalloc-512), and
mem_alloc_profiling_key was enabled.

Commit 280ea9c3154b ("mm/slab: avoid allocating slabobj_ext array from
its own slab") is not sufficient: it bumps the allocation size only when
the array would come from the *same* cache (object_size ==).  At the
geometry above neither cache is self-referential (512 != 1024 and
1024 != 512), so the bump never triggers and the kmalloc-512 <-> kmalloc-1k
cross cycle remains.

Fix it structurally by removing cycles of every shape: serve the array
from a cache strictly larger than the one it describes whenever it would
otherwise come from the same or a smaller cache.  Every reference edge
then points from a smaller to a larger cache (here kmalloc-1k's array
moves to kmalloc-2k), so the relation is a DAG and cannot contain a cycle.
No slab can be self- or cross-pinned, the tear-down recursion is bounded
by the number of kmalloc size classes (it terminates at the large-kmalloc
path, which carries no obj_exts), and profiling/accounting coverage is
unchanged - the array is still allocated, only relocated.

Reproduced on next-20260623 at the same geometry: churning
kmalloc-512/kmalloc-1k under vm.mem_profiling and then shrinking leaves
kmalloc-512 with thousands of unreclaimable objects without this patch
(8056) and at baseline with it (847).

Fixes: 4b8736964640 ("mm/slab: add allocation accounting into slab allocation and free paths")
Reported-by: Danielle Costantino <dcostantino@meta.com>
Cc: stable@vger.kernel.org
Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---
Changes in v2:
- Drop the now-stale comment above the object_size comparison (Harry Yoo).
- Add a comment above the !is_kmalloc_normal() check explaining that the
  size is bumped only when the object itself comes from KMALLOC_NORMAL,
  i.e. via memory allocation profiling or memcg on SLUB_TINY (Harry Yoo).
- Add Cc: stable; v6.12 and v6.18 are affected (Harry Yoo).
- Restore the Reported-by tag.
No functional change from v1 (comments and tags only).

v1: https://lore.kernel.org/all/20260625230029.703750-1-shakeel.butt@linux.dev/

 mm/slub.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 9ec774dc7009..0c30d689820a 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2124,15 +2124,14 @@ static inline void init_slab_obj_exts(struct slab *slab)
 }
 
 /*
- * Calculate the allocation size for slabobj_ext array.
+ * Size of the slabobj_ext array for @slab.
  *
- * When memory allocation profiling is enabled, the obj_exts array
- * could be allocated from the same slab cache it's being allocated for.
- * This would prevent the slab from ever being freed because it would
- * always contain at least one allocated object (its own obj_exts array).
- *
- * To avoid this, increase the allocation size when we detect the array
- * may come from the same cache, forcing it to use a different cache.
+ * The array is itself kmalloc()'d. If it came from the same or a smaller
+ * kmalloc cache than @s, the "slab holds another slab's array" relation could
+ * form a cycle (self, or e.g. kmalloc-512 <-> kmalloc-1k) that pins the slabs
+ * forever and recurses via free_slab_obj_exts() -> kfree() -> discard_slab()
+ * at teardown. Force it into a strictly larger cache to keep that relation a
+ * DAG (acyclic).
  */
 static inline size_t obj_exts_alloc_size(struct kmem_cache *s,
 					 struct slab *slab, gfp_t gfp)
@@ -2143,18 +2142,19 @@ static inline size_t obj_exts_alloc_size(struct kmem_cache *s,
 	if (sz > KMALLOC_MAX_CACHE_SIZE)
 		return sz;
 
+	/*
+	 * Only bump the size when the object (not the obj_exts array) is
+	 * allocated from KMALLOC_NORMAL, either by memory allocation profiling
+	 * or memcg on SLUB_TINY with __GFP_RECLAIMABLE|__GFP_ACCOUNT.
+	 * Otherwise, obj_exts allocations cannot form a cycle between
+	 * kmalloc caches.
+	 */
 	if (!is_kmalloc_normal(s))
 		return sz;
 
 	obj_exts_cache = kmalloc_slab(sz, NULL, gfp, __kmalloc_token(0));
-	/*
-	 * We can't simply compare s with obj_exts_cache, because partitioned kmalloc
-	 * caches have multiple caches per size, selected by caller address or type.
-	 * Since caller address or type may differ between kmalloc_slab() and actual
-	 * allocation, bump size when sizes are equal.
-	 */
-	if (s->object_size == obj_exts_cache->object_size)
-		return obj_exts_cache->object_size + 1;
+	if (obj_exts_cache->object_size <= s->object_size)
+		return s->object_size + 1;
 
 	return sz;
 }
-- 
2.53.0-Meta


