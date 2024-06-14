Return-Path: <stable+bounces-52127-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4490908176
	for <lists+stable@lfdr.de>; Fri, 14 Jun 2024 04:16:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C19D2834C2
	for <lists+stable@lfdr.de>; Fri, 14 Jun 2024 02:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 813C42AE75;
	Fri, 14 Jun 2024 02:16:19 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C39BBA49
	for <stable@vger.kernel.org>; Fri, 14 Jun 2024 02:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718331379; cv=none; b=f1nkJhkqfnonVEbjJZ1+Z5c1bGcPUbTf2WbEwnIUZ72XbUAAwoOW6hFsBQRul6j45C6ZbK9rVTiY1E6QhSBhuoya2yu003WRvgddgGYSzMQ4m0GNLMgNVvY48psE4kvEBxS2roSXObHUds4AePwlw+oEVrV7Ox9hDWMGghLYqEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718331379; c=relaxed/simple;
	bh=YtMc26Ol+UJngE0aCBz98PcCB5KSrSgnii1fT5OLsdc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WuCJLs82plqVci4ybGCnqJoJPtE/SVgmI0rkOArXaoPvc0+q2t3wLAF9mCaojI8TCSrS2LbSh1QlZSjRnGu8KgoLEzJWOafi0Tec001662H0cZff/HFWrCTxHHd02tKQLf9RU1rcIpHro2DzU8uV0LTqK5PaqSsVBnwMQbcIDXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 45E2E5ZK058868;
	Fri, 14 Jun 2024 10:14:05 +0800 (+08)
	(envelope-from zhaoyang.huang@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4W0jQf632tz2QqFKS;
	Fri, 14 Jun 2024 10:09:46 +0800 (CST)
Received: from bj03382pcu01.spreadtrum.com (10.0.73.40) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Fri, 14 Jun 2024 10:13:56 +0800
From: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
To: Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki
	<urezki@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Lorenzo Stoakes
	<lstoakes@gmail.com>, Baoquan He <bhe@redhat.com>,
        Thomas Gleixner
	<tglx@linutronix.de>,
        hailong liu <hailong.liu@oppo.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        Zhaoyang Huang
	<huangzhaoyang@gmail.com>, <steve.kang@unisoc.com>
CC: <stable@vger.kernel.org>
Subject: [update PATCHv5 1/1] mm: fix incorrect vbq reference in purge_fragmented_block
Date: Fri, 14 Jun 2024 10:13:52 +0800
Message-ID: <20240614021352.1822225-1-zhaoyang.huang@unisoc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SHCAS01.spreadtrum.com (10.0.1.201) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL:SHSQR01.spreadtrum.com 45E2E5ZK058868

From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

The function xa_for_each() in _vm_unmap_aliases() loops through all
vbs. However, since commit 062eacf57ad9 ("mm: vmalloc: remove a global
vmap_blocks xarray") the vb from xarray may not be on the corresponding
CPU vmap_block_queue. Consequently, purge_fragmented_block() might
use the wrong vbq->lock to protect the free list, leading to vbq->free
breakage.

Incorrect lock protection can exhaust all vmalloc space as follows:
CPU0                                            CPU1
+--------------------------------------------+
|    +--------------------+     +-----+      |
+--> |                    |---->|     |------+
     | CPU1:vbq free_list |     | vb1 |
+--- |                    |<----|     |<-----+
|    +--------------------+     +-----+      |
+--------------------------------------------+

_vm_unmap_aliases()                             vb_alloc()
                                                new_vmap_block()
xa_for_each(&vbq->vmap_blocks, idx, vb)
--> vb in CPU1:vbq->freelist

purge_fragmented_block(vb)
spin_lock(&vbq->lock)                           spin_lock(&vbq->lock)
--> use CPU0:vbq->lock                          --> use CPU1:vbq->lock

list_del_rcu(&vb->free_list)                    list_add_tail_rcu(&vb->free_list, &vbq->free)
    __list_del(vb->prev, vb->next)
        next->prev = prev
    +--------------------+
    |                    |
    | CPU1:vbq free_list |
+---|                    |<--+
|   +--------------------+   |
+----------------------------+
                                                __list_add(new, head->prev, head)
+--------------------------------------------+
|    +--------------------+     +-----+      |
+--> |                    |---->|     |------+
     | CPU1:vbq free_list |     | vb2 |
+--- |                    |<----|     |<-----+
|    +--------------------+     +-----+      |
+--------------------------------------------+

        prev->next = next
+--------------------------------------------+
|----------------------------+               |
|    +--------------------+  |  +-----+      |
+--> |                    |--+  |     |------+
     | CPU1:vbq free_list |     | vb2 |
+--- |                    |<----|     |<-----+
|    +--------------------+     +-----+      |
+--------------------------------------------+
Here’s a list breakdown. All vbs, which were to be added to
‘prev’, cannot be used by list_for_each_entry_rcu(vb, &vbq->free,
free_list) in vb_alloc(). Thus, vmalloc space is exhausted.

This issue affects both erofs and f2fs, the stacktrace is as follows:
erofs:
[<ffffffd4ffb93ad4>] __switch_to+0x174
[<ffffffd4ffb942f0>] __schedule+0x624
[<ffffffd4ffb946f4>] schedule+0x7c
[<ffffffd4ffb947cc>] schedule_preempt_disabled+0x24
[<ffffffd4ffb962ec>] __mutex_lock+0x374
[<ffffffd4ffb95998>] __mutex_lock_slowpath+0x14
[<ffffffd4ffb95954>] mutex_lock+0x24
[<ffffffd4fef2900c>] reclaim_and_purge_vmap_areas+0x44
[<ffffffd4fef25908>] alloc_vmap_area+0x2e0
[<ffffffd4fef24ea0>] vm_map_ram+0x1b0
[<ffffffd4ff1b46f4>] z_erofs_lz4_decompress+0x278
[<ffffffd4ff1b8ac4>] z_erofs_decompress_queue+0x650
[<ffffffd4ff1b8328>] z_erofs_runqueue+0x7f4
[<ffffffd4ff1b66a8>] z_erofs_read_folio+0x104
[<ffffffd4feeb6fec>] filemap_read_folio+0x6c
[<ffffffd4feeb68c4>] filemap_fault+0x300
[<ffffffd4fef0ecac>] __do_fault+0xc8
[<ffffffd4fef0c908>] handle_mm_fault+0xb38
[<ffffffd4ffb9f008>] do_page_fault+0x288
[<ffffffd4ffb9ed64>] do_translation_fault[jt]+0x40
[<ffffffd4fec39c78>] do_mem_abort+0x58
[<ffffffd4ffb8c3e4>] el0_ia+0x70
[<ffffffd4ffb8c260>] el0t_64_sync_handler[jt]+0xb0
[<ffffffd4fec11588>] ret_to_user[jt]+0x0

f2fs:
[<ffffffd4ffb93ad4>] __switch_to+0x174
[<ffffffd4ffb942f0>] __schedule+0x624
[<ffffffd4ffb946f4>] schedule+0x7c
[<ffffffd4ffb947cc>] schedule_preempt_disabled+0x24
[<ffffffd4ffb962ec>] __mutex_lock+0x374
[<ffffffd4ffb95998>] __mutex_lock_slowpath+0x14
[<ffffffd4ffb95954>] mutex_lock+0x24
[<ffffffd4fef2900c>] reclaim_and_purge_vmap_areas+0x44
[<ffffffd4fef25908>] alloc_vmap_area+0x2e0
[<ffffffd4fef24ea0>] vm_map_ram+0x1b0
[<ffffffd4ff1a3b60>] f2fs_prepare_decomp_mem+0x144
[<ffffffd4ff1a6c24>] f2fs_alloc_dic+0x264
[<ffffffd4ff175468>] f2fs_read_multi_pages+0x428
[<ffffffd4ff17b46c>] f2fs_mpage_readpages+0x314
[<ffffffd4ff1785c4>] f2fs_readahead+0x50
[<ffffffd4feec3384>] read_pages+0x80
[<ffffffd4feec32c0>] page_cache_ra_unbounded+0x1a0
[<ffffffd4feec39e8>] page_cache_ra_order+0x274
[<ffffffd4feeb6cec>] do_sync_mmap_readahead+0x11c
[<ffffffd4feeb6764>] filemap_fault+0x1a0
[<ffffffd4ff1423bc>] f2fs_filemap_fault+0x28
[<ffffffd4fef0ecac>] __do_fault+0xc8
[<ffffffd4fef0c908>] handle_mm_fault+0xb38
[<ffffffd4ffb9f008>] do_page_fault+0x288
[<ffffffd4ffb9ed64>] do_translation_fault[jt]+0x40
[<ffffffd4fec39c78>] do_mem_abort+0x58
[<ffffffd4ffb8c3e4>] el0_ia+0x70
[<ffffffd4ffb8c260>] el0t_64_sync_handler[jt]+0xb0
[<ffffffd4fec11588>] ret_to_user[jt]+0x0

To fix this, introducing cpu within vmap_block to record which this vb
belongs to.

Fixes: fc1e0d980037 ("mm/vmalloc: prevent stale TLBs in fully utilized blocks")

Cc: stable@vger.kernel.org
Suggested-by: Hailong.Liu <hailong.liu@oppo.com>
Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
---
v2: introduce cpu in vmap_block to record the right CPU number
v3: use get_cpu/put_cpu to prevent schedule between core
v4: replace get_cpu/put_cpu by another API to avoid disabling preemption
v5: update the commit message by Hailong.Liu
---
---
 mm/vmalloc.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 22aa63f4ef63..89eb034f4ac6 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2458,6 +2458,7 @@ struct vmap_block {
 	struct list_head free_list;
 	struct rcu_head rcu_head;
 	struct list_head purge;
+	unsigned int cpu;
 };
 
 /* Queue of free and dirty vmap blocks, for allocation and flushing purposes */
@@ -2585,8 +2586,15 @@ static void *new_vmap_block(unsigned int order, gfp_t gfp_mask)
 		free_vmap_area(va);
 		return ERR_PTR(err);
 	}
-
-	vbq = raw_cpu_ptr(&vmap_block_queue);
+	/*
+	 * list_add_tail_rcu could happened in another core
+	 * rather than vb->cpu due to task migration, which
+	 * is safe as list_add_tail_rcu will ensure the list's
+	 * integrity together with list_for_each_rcu from read
+	 * side.
+	 */
+	vb->cpu = raw_smp_processor_id();
+	vbq = per_cpu_ptr(&vmap_block_queue, vb->cpu);
 	spin_lock(&vbq->lock);
 	list_add_tail_rcu(&vb->free_list, &vbq->free);
 	spin_unlock(&vbq->lock);
@@ -2614,9 +2622,10 @@ static void free_vmap_block(struct vmap_block *vb)
 }
 
 static bool purge_fragmented_block(struct vmap_block *vb,
-		struct vmap_block_queue *vbq, struct list_head *purge_list,
-		bool force_purge)
+		struct list_head *purge_list, bool force_purge)
 {
+	struct vmap_block_queue *vbq = &per_cpu(vmap_block_queue, vb->cpu);
+
 	if (vb->free + vb->dirty != VMAP_BBMAP_BITS ||
 	    vb->dirty == VMAP_BBMAP_BITS)
 		return false;
@@ -2664,7 +2673,7 @@ static void purge_fragmented_blocks(int cpu)
 			continue;
 
 		spin_lock(&vb->lock);
-		purge_fragmented_block(vb, vbq, &purge, true);
+		purge_fragmented_block(vb, &purge, true);
 		spin_unlock(&vb->lock);
 	}
 	rcu_read_unlock();
@@ -2801,7 +2810,7 @@ static void _vm_unmap_aliases(unsigned long start, unsigned long end, int flush)
 			 * not purgeable, check whether there is dirty
 			 * space to be flushed.
 			 */
-			if (!purge_fragmented_block(vb, vbq, &purge_list, false) &&
+			if (!purge_fragmented_block(vb, &purge_list, false) &&
 			    vb->dirty_max && vb->dirty != VMAP_BBMAP_BITS) {
 				unsigned long va_start = vb->va->va_start;
 				unsigned long s, e;
-- 
2.25.1


