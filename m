Return-Path: <stable+bounces-178049-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0487B47BF4
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 17:13:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 496E517B81F
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 15:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A89EB264A9C;
	Sun,  7 Sep 2025 15:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aYopAAJf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675391991C9
	for <stable@vger.kernel.org>; Sun,  7 Sep 2025 15:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757258010; cv=none; b=sQ9054vZ4ihsbiZcutvZdZrVGx9Ec39RrdqXyE5kHXLFTWJxCVQ+ArnRFnmV+IF0DI4lFPxm1fe3uwDyIxEw5ez6fsRuOwInAPSSsLJIk9mKqHO4w0B0pCf7Qk/kdLor8QZ1hqv3kMuqg4CxFUUqGr0Xe+1GHhOYwA5A8fMTGsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757258010; c=relaxed/simple;
	bh=kszrTjpACq2P7ZUwcIU4+hOlYZiQlTmJpKdz1aGsooc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bld2WYbz+Jm6H/VBWzkIULNjah8vyJHs1QAXIu6tqI2GqoV2vHtD2vyujaT6BCvWF2XYfcOex+hK0yZNf4IC8Rv17VWHxcD5ndb7RQhIHqYp6Jd1/YFFE4R5ZKbtizMjLAM+r0uLFyESXKq37jveXv2mJ2/Qi/55dSxFBI6j9qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aYopAAJf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 584EFC4CEF0;
	Sun,  7 Sep 2025 15:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757258010;
	bh=kszrTjpACq2P7ZUwcIU4+hOlYZiQlTmJpKdz1aGsooc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aYopAAJfE0jv14tfzNGF0G9d/4CgdWVBmo5BlB07Cw5B3W03zvt7DYlvNT5u97YnD
	 77LZqL1Ge8/RyX3995KbFzUXvFqV2HD4LM3gUSYJ+hCeQyab/Twfb9nUNTm0ogQNFr
	 U+QoDvJMqR+4nqu/GhhmzTNSYtKLNcEa+XVPmHBf7ETRJmWWBGLTRI/hYCN8BQKK5/
	 e7YtDnXTu0UUwkc6YXXA/DesISE7elpHZVBR4w2iwkQawG45kPJouUCD9XoClynF2k
	 sCuoM33ghd7/AkJUB9Y+YkOgmpW2EiphHvX+xU6A+epI7bCYcFWC3jjKj6s5aXCwUG
	 9ROzRDgaxlzgQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@linux.ibm.com>,
	Christoph Lameter <cl@linux.com>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/3] mm, slub: refactor free debug processing
Date: Sun,  7 Sep 2025 11:13:25 -0400
Message-ID: <20250907151327.641468-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025090635-affluent-reputable-419b@gregkh>
References: <2025090635-affluent-reputable-419b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vlastimil Babka <vbabka@suse.cz>

[ Upstream commit fa9b88e459d710cadf3b01e8a64eda00cc91cdd6 ]

Since commit c7323a5ad078 ("mm/slub: restrict sysfs validation to debug
caches and make it safe"), caches with debugging enabled use the
free_debug_processing() function to do both freeing checks and actual
freeing to partial list under list_lock, bypassing the fast paths.

We will want to use the same path for CONFIG_SLUB_TINY, but without the
debugging checks, so refactor the code so that free_debug_processing()
does only the checks, while the freeing is handled by a new function
free_to_partial_list().

For consistency, change return parameter alloc_debug_processing() from
int to bool and correct the !SLUB_DEBUG variant to return true and not
false. This didn't matter until now, but will in the following changes.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
Acked-by: Mike Rapoport <rppt@linux.ibm.com>
Reviewed-by: Christoph Lameter <cl@linux.com>
Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Stable-dep-of: 850470a8413a ("mm: slub: avoid wake up kswapd in set_track_prepare")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/slub.c | 154 +++++++++++++++++++++++++++++-------------------------
 1 file changed, 83 insertions(+), 71 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 157527d7101be..4190125deceb6 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1363,7 +1363,7 @@ static inline int alloc_consistency_checks(struct kmem_cache *s,
 	return 1;
 }
 
-static noinline int alloc_debug_processing(struct kmem_cache *s,
+static noinline bool alloc_debug_processing(struct kmem_cache *s,
 			struct slab *slab, void *object, int orig_size)
 {
 	if (s->flags & SLAB_CONSISTENCY_CHECKS) {
@@ -1375,7 +1375,7 @@ static noinline int alloc_debug_processing(struct kmem_cache *s,
 	trace(s, slab, object, 1);
 	set_orig_size(s, object, orig_size);
 	init_object(s, object, SLUB_RED_ACTIVE);
-	return 1;
+	return true;
 
 bad:
 	if (folio_test_slab(slab_folio(slab))) {
@@ -1388,7 +1388,7 @@ static noinline int alloc_debug_processing(struct kmem_cache *s,
 		slab->inuse = slab->objects;
 		slab->freelist = NULL;
 	}
-	return 0;
+	return false;
 }
 
 static inline int free_consistency_checks(struct kmem_cache *s,
@@ -1641,17 +1641,17 @@ static inline void setup_object_debug(struct kmem_cache *s, void *object) {}
 static inline
 void setup_slab_debug(struct kmem_cache *s, struct slab *slab, void *addr) {}
 
-static inline int alloc_debug_processing(struct kmem_cache *s,
-	struct slab *slab, void *object, int orig_size) { return 0; }
+static inline bool alloc_debug_processing(struct kmem_cache *s,
+	struct slab *slab, void *object, int orig_size) { return true; }
 
-static inline void free_debug_processing(
-	struct kmem_cache *s, struct slab *slab,
-	void *head, void *tail, int bulk_cnt,
-	unsigned long addr) {}
+static inline bool free_debug_processing(struct kmem_cache *s,
+	struct slab *slab, void *head, void *tail, int *bulk_cnt,
+	unsigned long addr, depot_stack_handle_t handle) { return true; }
 
 static inline void slab_pad_check(struct kmem_cache *s, struct slab *slab) {}
 static inline int check_object(struct kmem_cache *s, struct slab *slab,
 			void *object, u8 val) { return 1; }
+static inline depot_stack_handle_t set_track_prepare(void) { return 0; }
 static inline void set_track(struct kmem_cache *s, void *object,
 			     enum track_item alloc, unsigned long addr) {}
 static inline void add_full(struct kmem_cache *s, struct kmem_cache_node *n,
@@ -2828,38 +2828,28 @@ static inline unsigned long node_nr_objs(struct kmem_cache_node *n)
 }
 
 /* Supports checking bulk free of a constructed freelist */
-static noinline void free_debug_processing(
-	struct kmem_cache *s, struct slab *slab,
-	void *head, void *tail, int bulk_cnt,
-	unsigned long addr)
+static inline bool free_debug_processing(struct kmem_cache *s,
+	struct slab *slab, void *head, void *tail, int *bulk_cnt,
+	unsigned long addr, depot_stack_handle_t handle)
 {
-	struct kmem_cache_node *n = get_node(s, slab_nid(slab));
-	struct slab *slab_free = NULL;
+	bool checks_ok = false;
 	void *object = head;
 	int cnt = 0;
-	unsigned long flags;
-	bool checks_ok = false;
-	depot_stack_handle_t handle = 0;
-
-	if (s->flags & SLAB_STORE_USER)
-		handle = set_track_prepare();
-
-	spin_lock_irqsave(&n->list_lock, flags);
 
 	if (s->flags & SLAB_CONSISTENCY_CHECKS) {
 		if (!check_slab(s, slab))
 			goto out;
 	}
 
-	if (slab->inuse < bulk_cnt) {
+	if (slab->inuse < *bulk_cnt) {
 		slab_err(s, slab, "Slab has %d allocated objects but %d are to be freed\n",
-			 slab->inuse, bulk_cnt);
+			 slab->inuse, *bulk_cnt);
 		goto out;
 	}
 
 next_object:
 
-	if (++cnt > bulk_cnt)
+	if (++cnt > *bulk_cnt)
 		goto out_cnt;
 
 	if (s->flags & SLAB_CONSISTENCY_CHECKS) {
@@ -2881,57 +2871,18 @@ static noinline void free_debug_processing(
 	checks_ok = true;
 
 out_cnt:
-	if (cnt != bulk_cnt)
+	if (cnt != *bulk_cnt) {
 		slab_err(s, slab, "Bulk free expected %d objects but found %d\n",
-			 bulk_cnt, cnt);
-
-out:
-	if (checks_ok) {
-		void *prior = slab->freelist;
-
-		/* Perform the actual freeing while we still hold the locks */
-		slab->inuse -= cnt;
-		set_freepointer(s, tail, prior);
-		slab->freelist = head;
-
-		/*
-		 * If the slab is empty, and node's partial list is full,
-		 * it should be discarded anyway no matter it's on full or
-		 * partial list.
-		 */
-		if (slab->inuse == 0 && n->nr_partial >= s->min_partial)
-			slab_free = slab;
-
-		if (!prior) {
-			/* was on full list */
-			remove_full(s, n, slab);
-			if (!slab_free) {
-				add_partial(n, slab, DEACTIVATE_TO_TAIL);
-				stat(s, FREE_ADD_PARTIAL);
-			}
-		} else if (slab_free) {
-			remove_partial(n, slab);
-			stat(s, FREE_REMOVE_PARTIAL);
-		}
+			 *bulk_cnt, cnt);
+		*bulk_cnt = cnt;
 	}
 
-	if (slab_free) {
-		/*
-		 * Update the counters while still holding n->list_lock to
-		 * prevent spurious validation warnings
-		 */
-		dec_slabs_node(s, slab_nid(slab_free), slab_free->objects);
-	}
-
-	spin_unlock_irqrestore(&n->list_lock, flags);
+out:
 
 	if (!checks_ok)
 		slab_fix(s, "Object at 0x%p not freed", object);
 
-	if (slab_free) {
-		stat(s, FREE_SLAB);
-		free_slab(s, slab_free);
-	}
+	return checks_ok;
 }
 #endif /* CONFIG_SLUB_DEBUG */
 
@@ -3448,6 +3399,67 @@ void *kmem_cache_alloc_node(struct kmem_cache *s, gfp_t gfpflags, int node)
 }
 EXPORT_SYMBOL(kmem_cache_alloc_node);
 
+static noinline void free_to_partial_list(
+	struct kmem_cache *s, struct slab *slab,
+	void *head, void *tail, int bulk_cnt,
+	unsigned long addr)
+{
+	struct kmem_cache_node *n = get_node(s, slab_nid(slab));
+	struct slab *slab_free = NULL;
+	int cnt = bulk_cnt;
+	unsigned long flags;
+	depot_stack_handle_t handle = 0;
+
+	if (s->flags & SLAB_STORE_USER)
+		handle = set_track_prepare();
+
+	spin_lock_irqsave(&n->list_lock, flags);
+
+	if (free_debug_processing(s, slab, head, tail, &cnt, addr, handle)) {
+		void *prior = slab->freelist;
+
+		/* Perform the actual freeing while we still hold the locks */
+		slab->inuse -= cnt;
+		set_freepointer(s, tail, prior);
+		slab->freelist = head;
+
+		/*
+		 * If the slab is empty, and node's partial list is full,
+		 * it should be discarded anyway no matter it's on full or
+		 * partial list.
+		 */
+		if (slab->inuse == 0 && n->nr_partial >= s->min_partial)
+			slab_free = slab;
+
+		if (!prior) {
+			/* was on full list */
+			remove_full(s, n, slab);
+			if (!slab_free) {
+				add_partial(n, slab, DEACTIVATE_TO_TAIL);
+				stat(s, FREE_ADD_PARTIAL);
+			}
+		} else if (slab_free) {
+			remove_partial(n, slab);
+			stat(s, FREE_REMOVE_PARTIAL);
+		}
+	}
+
+	if (slab_free) {
+		/*
+		 * Update the counters while still holding n->list_lock to
+		 * prevent spurious validation warnings
+		 */
+		dec_slabs_node(s, slab_nid(slab_free), slab_free->objects);
+	}
+
+	spin_unlock_irqrestore(&n->list_lock, flags);
+
+	if (slab_free) {
+		stat(s, FREE_SLAB);
+		free_slab(s, slab_free);
+	}
+}
+
 /*
  * Slow path handling. This may still be called frequently since objects
  * have a longer lifetime than the cpu slabs in most processing loads.
@@ -3474,7 +3486,7 @@ static void __slab_free(struct kmem_cache *s, struct slab *slab,
 		return;
 
 	if (kmem_cache_debug(s)) {
-		free_debug_processing(s, slab, head, tail, cnt, addr);
+		free_to_partial_list(s, slab, head, tail, cnt, addr);
 		return;
 	}
 
-- 
2.51.0


