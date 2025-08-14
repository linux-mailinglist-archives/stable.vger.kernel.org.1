Return-Path: <stable+bounces-169528-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87B43B26405
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 13:18:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D48F51781CE
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 11:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CA233C26;
	Thu, 14 Aug 2025 11:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="LhIyxLw3"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74030318132;
	Thu, 14 Aug 2025 11:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755170297; cv=none; b=k/HB/jY+fSmtykdzlZww2k1vB6eA4iUA3bvNTUW4cpQvgG6PcPa8AHi/A7SQAXt2V49p5MrM170UQLK7AB+ux8TD1bNDPzc4DKtn5FuK7xsuXLDwZuuCjuoK9gh0jrnUjqo9ITtsicBzfA366RNOaEOITRxGl4CzSVkvNS0xZrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755170297; c=relaxed/simple;
	bh=eFYWsp08n6SVVedh4zbV4bDxYJdUahuYEnIagp/WlB8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V0tLRw38qPTIpce/sLOZ8W1eqT2+GVEIU64cdq0XHUfcfeAgJShDhqvYQwMKnq6Dptr/4K7q8G3fBzmmfbdifkHZYN283rG0rfONKYbimyjYHAfytWXWhhg98fwTjzNaxd4ED8ze7LfMD6kCQmEvIsOKDqszDYhAODhFCyU1VXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=LhIyxLw3; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=E0
	2voVBQAU1rJD41PTsszXfus1cHekX350eLoFLGHrY=; b=LhIyxLw3gMDvP7o+qj
	XhM+eOjzEBncHGNWm1AsBj1VRIW/TTvyjIL/2fVEWorzr3XrVES85ckEnp9FjG6D
	YPGbw/nW34SQ9uKxI5Nw14/tCvPRKMCnEop03kYYkX4GAKTwuzEhGzR1QJWRv7QM
	1sJ9DdNyj86j/NryHBVaHa6sw=
Received: from mi-work.mioffice.cn (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wA3sla6xZ1ofjt8Bw--.11362S4;
	Thu, 14 Aug 2025 19:17:15 +0800 (CST)
From: yangshiguang1011@163.com
To: harry.yoo@oracle.com
Cc: vbabka@suse.cz,
	akpm@linux-foundation.org,
	cl@gentwo.org,
	rientjes@google.com,
	roman.gushchin@linux.dev,
	glittao@gmail.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	yangshiguang <yangshiguang@xiaomi.com>
Subject: [PATCH v2] mm: slub: avoid wake up kswapd in set_track_prepare
Date: Thu, 14 Aug 2025 19:16:42 +0800
Message-ID: <20250814111641.380629-2-yangshiguang1011@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wA3sla6xZ1ofjt8Bw--.11362S4
X-Coremail-Antispam: 1Uf129KBjvJXoW3Jr43XFWkKF1UCFWkWryUWrg_yoW7XFyrpF
	W7GFy3JF48JryjqFWUAw4Uur1SvrZ3CrW8CF43Wa4ruFyYqr48GFW7tFyjvFWrArykuanF
	ka1UuFn3Ww4UZaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jZTmDUUUUU=
X-CM-SenderInfo: 51dqw25klj3ttqjriiqr6rljoofrz/1tbiSAWp5WidxSUN3gAAsH

From: yangshiguang <yangshiguang@xiaomi.com>

From: yangshiguang <yangshiguang@xiaomi.com>

set_track_prepare() can incur lock recursion.
The issue is that it is called from hrtimer_start_range_ns
holding the per_cpu(hrtimer_bases)[n].lock, but when enabled
CONFIG_DEBUG_OBJECTS_TIMERS, may wake up kswapd in set_track_prepare,
and try to hold the per_cpu(hrtimer_bases)[n].lock.

So avoid waking up kswapd.The oops looks something like:

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
---
v1 -> v2:
    propagate gfp flags to set_track_prepare()

[1]https://lore.kernel.org/all/20250801065121.876793-1-yangshiguang1011@163.com/
---
 mm/slub.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 30003763d224..dba905bf1e03 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -962,19 +962,20 @@ static struct track *get_track(struct kmem_cache *s, void *object,
 }
 
 #ifdef CONFIG_STACKDEPOT
-static noinline depot_stack_handle_t set_track_prepare(void)
+static noinline depot_stack_handle_t set_track_prepare(gfp_t gfp_flags)
 {
 	depot_stack_handle_t handle;
 	unsigned long entries[TRACK_ADDRS_COUNT];
 	unsigned int nr_entries;
+	gfp_flags &= GFP_NOWAIT;
 
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
@@ -996,9 +997,9 @@ static void set_track_update(struct kmem_cache *s, void *object,
 }
 
 static __always_inline void set_track(struct kmem_cache *s, void *object,
-				      enum track_item alloc, unsigned long addr)
+				      enum track_item alloc, unsigned long addr, gfp_t gfp_flags)
 {
-	depot_stack_handle_t handle = set_track_prepare();
+	depot_stack_handle_t handle = set_track_prepare(gfp_flags);
 
 	set_track_update(s, object, alloc, addr, handle);
 }
@@ -1921,9 +1922,9 @@ static inline bool free_debug_processing(struct kmem_cache *s,
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
@@ -3878,7 +3879,7 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 			 * tracking info and return the object.
 			 */
 			if (s->flags & SLAB_STORE_USER)
-				set_track(s, freelist, TRACK_ALLOC, addr);
+				set_track(s, freelist, TRACK_ALLOC, addr, gfpflags);
 
 			return freelist;
 		}
@@ -3910,7 +3911,7 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 			goto new_objects;
 
 		if (s->flags & SLAB_STORE_USER)
-			set_track(s, freelist, TRACK_ALLOC, addr);
+			set_track(s, freelist, TRACK_ALLOC, addr, gfpflags);
 
 		return freelist;
 	}
@@ -4422,7 +4423,7 @@ static noinline void free_to_partial_list(
 	depot_stack_handle_t handle = 0;
 
 	if (s->flags & SLAB_STORE_USER)
-		handle = set_track_prepare();
+		handle = set_track_prepare(GFP_NOWAIT);
 
 	spin_lock_irqsave(&n->list_lock, flags);
 
-- 
2.43.0


