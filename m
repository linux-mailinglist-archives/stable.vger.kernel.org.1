Return-Path: <stable+bounces-178043-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B374AB47BE5
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 16:56:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 798B5189BEEE
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 14:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D762277C95;
	Sun,  7 Sep 2025 14:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W2Mgjmng"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531F61A0BD0
	for <stable@vger.kernel.org>; Sun,  7 Sep 2025 14:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757256993; cv=none; b=CnaCeEXWUb7qVwSXgIg+XP7Vy9EPH5a9RQeUfeunxNOGANwaQM9WMWOw0PBCp8fUSXR037hO2sLIxuwyEs4jyorCRkn5UIE0FWk80bgLH16q4OSVQbf1RizzVMqmTJIpH8lXjkmom2U15oqm/Cmf4JaDKDawI2XSH/Kxv8QUvvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757256993; c=relaxed/simple;
	bh=nYDx8/X7EkgtH16/xZDgHapmSXQiAj9LW4FGo/VdAO8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MgxTUZcsUw2h/YdJc+6IM1JRi9jkLGw/11etRgrEbart6yAc9NFMTSLoAn9mnzcu00O3/BKma7rHyCSuHBki1QBDlV1lmyaGhj4FCcwRKg3MS0TdfytPqw92MoIo5KKZPw4SJSrQIiShiuNZrcQy0Qpql3jBp6nlPfSYEdxAdrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W2Mgjmng; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BC37C4CEF5;
	Sun,  7 Sep 2025 14:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757256991;
	bh=nYDx8/X7EkgtH16/xZDgHapmSXQiAj9LW4FGo/VdAO8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W2MgjmngIBlESx+cMLoznHKul2ti9z9CksvA1/ZCpREmnbyhrzBYi/VUAgXujpuIa
	 eJpKqmvB1XpjTiHLrXfUP35MYfF0UBAJpBJherIVryw0UxRqWxcYVARvp8wLdCkqzL
	 sywMrdbsLe/4ig9f8VII6IgD6JgRSKPgbyY8KyJRA92KJko9B0SY7v7BHSH8TYIJ6h
	 gVK9AJenr47rbzHp+8lVq1e9HIdJ6ZWUurp7DNfaaVGld/qfnLJXwpU7wgANKadeF4
	 aq3dJGl+Vh6+JtVecLB87ajkrXohlCbMJW2bi5ETeeS5l3UUSOeWFtLqIIfJK6ADGG
	 v8WiW2PwPLjxQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: yangshiguang <yangshiguang@xiaomi.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] mm: slub: avoid wake up kswapd in set_track_prepare
Date: Sun,  7 Sep 2025 10:56:28 -0400
Message-ID: <20250907145628.635865-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250907145628.635865-1-sashal@kernel.org>
References: <2025090634-predator-composite-c799@gregkh>
 <20250907145628.635865-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: yangshiguang <yangshiguang@xiaomi.com>

[ Upstream commit 850470a8413a8a78e772c4f6bd9fe81ec6bd5b0f ]

set_track_prepare() can incur lock recursion.
The issue is that it is called from hrtimer_start_range_ns
holding the per_cpu(hrtimer_bases)[n].lock, but when enabled
CONFIG_DEBUG_OBJECTS_TIMERS, may wake up kswapd in set_track_prepare,
and try to hold the per_cpu(hrtimer_bases)[n].lock.

Avoid deadlock caused by implicitly waking up kswapd by passing in
allocation flags, which do not contain __GFP_KSWAPD_RECLAIM in the
debug_objects_fill_pool() case. Inside stack depot they are processed by
gfp_nested_mask().
Since ___slab_alloc() has preemption disabled, we mask out
__GFP_DIRECT_RECLAIM from the flags there.

The oops looks something like:

BUG: spinlock recursion on CPU#3, swapper/3/0
 lock: 0xffffff8a4bf29c80, .magic: dead4ead, .owner: swapper/3/0, .owner_cpu: 3
Hardware name: Qualcomm Technologies, Inc. Popsicle based on SM8850 (DT)
Call trace:
spin_bug+0x0
_raw_spin_lock_irqsave+0x80
hrtimer_try_to_cancel+0x94
task_contending+0x10c
enqueue_dl_entity+0x2a4
dl_server_start+0x74
enqueue_task_fair+0x568
enqueue_task+0xac
do_activate_task+0x14c
ttwu_do_activate+0xcc
try_to_wake_up+0x6c8
default_wake_function+0x20
autoremove_wake_function+0x1c
__wake_up+0xac
wakeup_kswapd+0x19c
wake_all_kswapds+0x78
__alloc_pages_slowpath+0x1ac
__alloc_pages_noprof+0x298
stack_depot_save_flags+0x6b0
stack_depot_save+0x14
set_track_prepare+0x5c
___slab_alloc+0xccc
__kmalloc_cache_noprof+0x470
__set_page_owner+0x2bc
post_alloc_hook[jt]+0x1b8
prep_new_page+0x28
get_page_from_freelist+0x1edc
__alloc_pages_noprof+0x13c
alloc_slab_page+0x244
allocate_slab+0x7c
___slab_alloc+0x8e8
kmem_cache_alloc_noprof+0x450
debug_objects_fill_pool+0x22c
debug_object_activate+0x40
enqueue_hrtimer[jt]+0xdc
hrtimer_start_range_ns+0x5f8
...

Signed-off-by: yangshiguang <yangshiguang@xiaomi.com>
Fixes: 5cf909c553e9 ("mm/slub: use stackdepot to save stack trace in objects")
Cc: stable@vger.kernel.org
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/slub.c | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index b7ee815d5d6cd..305b0eca6146c 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -771,19 +771,19 @@ static struct track *get_track(struct kmem_cache *s, void *object,
 }
 
 #ifdef CONFIG_STACKDEPOT
-static noinline depot_stack_handle_t set_track_prepare(void)
+static noinline depot_stack_handle_t set_track_prepare(gfp_t gfp_flags)
 {
 	depot_stack_handle_t handle;
 	unsigned long entries[TRACK_ADDRS_COUNT];
 	unsigned int nr_entries;
 
 	nr_entries = stack_trace_save(entries, ARRAY_SIZE(entries), 3);
-	handle = stack_depot_save(entries, nr_entries, GFP_NOWAIT);
+	handle = stack_depot_save(entries, nr_entries, gfp_flags);
 
 	return handle;
 }
 #else
-static inline depot_stack_handle_t set_track_prepare(void)
+static inline depot_stack_handle_t set_track_prepare(gfp_t gfp_flags)
 {
 	return 0;
 }
@@ -805,9 +805,9 @@ static void set_track_update(struct kmem_cache *s, void *object,
 }
 
 static __always_inline void set_track(struct kmem_cache *s, void *object,
-				      enum track_item alloc, unsigned long addr)
+				      enum track_item alloc, unsigned long addr, gfp_t gfp_flags)
 {
-	depot_stack_handle_t handle = set_track_prepare();
+	depot_stack_handle_t handle = set_track_prepare(gfp_flags);
 
 	set_track_update(s, object, alloc, addr, handle);
 }
@@ -1733,9 +1733,9 @@ static inline bool free_debug_processing(struct kmem_cache *s,
 static inline void slab_pad_check(struct kmem_cache *s, struct slab *slab) {}
 static inline int check_object(struct kmem_cache *s, struct slab *slab,
 			void *object, u8 val) { return 1; }
-static inline depot_stack_handle_t set_track_prepare(void) { return 0; }
+static inline depot_stack_handle_t set_track_prepare(gfp_t gfp_flags) { return 0; }
 static inline void set_track(struct kmem_cache *s, void *object,
-			     enum track_item alloc, unsigned long addr) {}
+			     enum track_item alloc, unsigned long addr, gfp_t gfp_flags) {}
 static inline void add_full(struct kmem_cache *s, struct kmem_cache_node *n,
 					struct slab *slab) {}
 static inline void remove_full(struct kmem_cache *s, struct kmem_cache_node *n,
@@ -3229,9 +3229,14 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 			 * For debug caches here we had to go through
 			 * alloc_single_from_partial() so just store the
 			 * tracking info and return the object.
+			 *
+			 * Due to disabled preemption we need to disallow
+			 * blocking. The flags are further adjusted by
+			 * gfp_nested_mask() in stack_depot itself.
 			 */
 			if (s->flags & SLAB_STORE_USER)
-				set_track(s, freelist, TRACK_ALLOC, addr);
+				set_track(s, freelist, TRACK_ALLOC, addr,
+					  gfpflags & ~(__GFP_DIRECT_RECLAIM));
 
 			return freelist;
 		}
@@ -3257,7 +3262,8 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 			goto new_objects;
 
 		if (s->flags & SLAB_STORE_USER)
-			set_track(s, freelist, TRACK_ALLOC, addr);
+			set_track(s, freelist, TRACK_ALLOC, addr,
+				  gfpflags & ~(__GFP_DIRECT_RECLAIM));
 
 		return freelist;
 	}
@@ -3545,8 +3551,12 @@ static noinline void free_to_partial_list(
 	unsigned long flags;
 	depot_stack_handle_t handle = 0;
 
+	/*
+	 * We cannot use GFP_NOWAIT as there are callsites where waking up
+	 * kswapd could deadlock
+	 */
 	if (s->flags & SLAB_STORE_USER)
-		handle = set_track_prepare();
+		handle = set_track_prepare(__GFP_NOWARN);
 
 	spin_lock_irqsave(&n->list_lock, flags);
 
-- 
2.51.0


