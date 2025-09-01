Return-Path: <stable+bounces-176799-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A305B3DC9C
	for <lists+stable@lfdr.de>; Mon,  1 Sep 2025 10:37:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E70A3189D85E
	for <lists+stable@lfdr.de>; Mon,  1 Sep 2025 08:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F2972F39AE;
	Mon,  1 Sep 2025 08:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="WEgcQAeL"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CF292FAC0E
	for <stable@vger.kernel.org>; Mon,  1 Sep 2025 08:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756715799; cv=none; b=tujSkr4WYrAWHZeaIqUd+ZGAL6URknjCkWEOLCHL9R3IX0Gtu6nrxQOCcA8/jWQcwR9AZz/gQz7G50v1NOs0Dbmke8BgckIdetvlWvCOwCcR+C7K0ehJUh4ggsFixzAkjeNH3NxpIprxQblKeU9aCIS8sps9qvvonOxeWRBgWbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756715799; c=relaxed/simple;
	bh=2Z/2giYlnJAYjuwfKEXgXaulO85yZSVyVfwZ6W4j1YI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hZidnjHyDU1XVvPxUkUlulyn6nGEHTQ8l75l4LIUFiBA8OZ8aJkWFqzkiFKQgtVLHAZ+sY2fa0U+rOUfv0X4T/w3LjEX5Q1XXIQ+ujSDsJGTVdTrN0NmKQ+eMX+5fgvbRck3A0QOJ3e2UiyeIAyvBVymeyszqdXsebI4Zml5+TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=WEgcQAeL; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=7i
	W/cz5lhIUrPi/Ko95IMunrIbAditDEI3mzA2HhDKE=; b=WEgcQAeLoxlMqayz/C
	vUWhoR3EN3gDK+Niqto9QvpIbXMkQOjhS/2rox+V0SlXZMbdmaOB/qgfwhei5T3z
	Zg1VzkXSxpj+4MmSkByFybuCRiS3XRiGDiesa37BwEn5WPRnf/mrKLepj8ojI89u
	AwHLG0pNVYsRT47DHcLC30P+Y=
Received: from mi-work.mioffice.cn (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wBXpfEQW7Vok7z4Fg--.41681S4;
	Mon, 01 Sep 2025 16:36:33 +0800 (CST)
From: yangshiguang1011@163.com
To: yangshiguang@xiaomi.com
Cc: stable@vger.kernel.org
Subject: [PATCH v5] mm: slub: avoid wake up kswapd in set_track_prepare
Date: Mon,  1 Sep 2025 16:36:31 +0800
Message-ID: <20250901083631.90774-1-yangshiguang1011@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBXpfEQW7Vok7z4Fg--.41681S4
X-Coremail-Antispam: 1Uf129KBjvJXoW3Jr43XFWkKF1UCFWkWryUWrg_yoW7KFy5pF
	W7WFy3JF48AF1jvFWDCa1Uur1SvrZ3CrW8CF43Wa4rua4Yvr48WFZrtFyjvFW5ArykuanF
	k3W09Fnagw4jqaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Um0PhUUUUU=
X-CM-SenderInfo: 51dqw25klj3ttqjriiqr6rljoofrz/xtbBMRG75Wi1Tx-TjAAGsq

From: yangshiguang <yangshiguang@xiaomi.com>

From: yangshiguang <yangshiguang@xiaomi.com>

set_track_prepare() can incur lock recursion.
The issue is that it is called from hrtimer_start_range_ns
holding the per_cpu(hrtimer_bases)[n].lock, but when enabled
CONFIG_DEBUG_OBJECTS_TIMERS, may wake up kswapd in set_track_prepare,
and try to hold the per_cpu(hrtimer_bases)[n].lock.

Avoid deadlock caused by implicitly waking up kswapd by
passing in allocation flags. And the slab caller context has
preemption disabled, so __GFP_DIRECT_RECLAIM must not appear in gfp_flags.

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
---

v1 -> v2:
    propagate gfp flags to set_track_prepare()
v2 -> v3:
    Remove the gfp restriction in set_track_prepare()
v3 -> v4:
    Re-describe the comments in set_track_prepare.
v4 -> v5:
    Modify the patch commit.

[1]https://lore.kernel.org/all/20250801065121.876793-1-yangshiguang1011@163.com/
[2]https://lore.kernel.org/all/20250814111641.380629-2-yangshiguang1011@163.com/
[3]https://lore.kernel.org/all/20250825121737.2535732-1-yangshiguang1011@163.com/
[4]https://lore.kernel.org/all/20250830020946.1767573-1-yangshiguang1011@163.com/
---
 mm/slub.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 30003763d224..b0af51a5321b 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -962,19 +962,25 @@ static struct track *get_track(struct kmem_cache *s, void *object,
 }
 
 #ifdef CONFIG_STACKDEPOT
-static noinline depot_stack_handle_t set_track_prepare(void)
+static noinline depot_stack_handle_t set_track_prepare(gfp_t gfp_flags)
 {
 	depot_stack_handle_t handle;
 	unsigned long entries[TRACK_ADDRS_COUNT];
 	unsigned int nr_entries;
+	/*
+	 * Preemption is disabled in ___slab_alloc() so we need to disallow
+	 * blocking. The flags are further adjusted by gfp_nested_mask() in
+	 * stack_depot itself.
+	 */
+	gfp_flags &= ~(__GFP_DIRECT_RECLAIM);
 
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
@@ -996,9 +1002,9 @@ static void set_track_update(struct kmem_cache *s, void *object,
 }
 
 static __always_inline void set_track(struct kmem_cache *s, void *object,
-				      enum track_item alloc, unsigned long addr)
+				      enum track_item alloc, unsigned long addr, gfp_t gfp_flags)
 {
-	depot_stack_handle_t handle = set_track_prepare();
+	depot_stack_handle_t handle = set_track_prepare(gfp_flags);
 
 	set_track_update(s, object, alloc, addr, handle);
 }
@@ -1921,9 +1927,9 @@ static inline bool free_debug_processing(struct kmem_cache *s,
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
@@ -3878,7 +3884,7 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 			 * tracking info and return the object.
 			 */
 			if (s->flags & SLAB_STORE_USER)
-				set_track(s, freelist, TRACK_ALLOC, addr);
+				set_track(s, freelist, TRACK_ALLOC, addr, gfpflags);
 
 			return freelist;
 		}
@@ -3910,7 +3916,7 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 			goto new_objects;
 
 		if (s->flags & SLAB_STORE_USER)
-			set_track(s, freelist, TRACK_ALLOC, addr);
+			set_track(s, freelist, TRACK_ALLOC, addr, gfpflags);
 
 		return freelist;
 	}
@@ -4422,7 +4428,7 @@ static noinline void free_to_partial_list(
 	depot_stack_handle_t handle = 0;
 
 	if (s->flags & SLAB_STORE_USER)
-		handle = set_track_prepare();
+		handle = set_track_prepare(__GFP_NOWARN);
 
 	spin_lock_irqsave(&n->list_lock, flags);
 
-- 
2.43.0


