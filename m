Return-Path: <stable+bounces-56666-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C06AA924573
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 19:22:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2632FB221A1
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 17:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0D821BD51A;
	Tue,  2 Jul 2024 17:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mxl/XLUH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6819D15218A;
	Tue,  2 Jul 2024 17:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719940946; cv=none; b=XwjFV/Ms7i65G+AUbcDRaM2AdC4qegYCcGCwne/3ZNqPg4QjlN/o/mEo1/spMFNHCGKH9X95WxPklFYx8TiP9UBz/djdJXUZtudgVQvyF6Zt2DW2AwwRB8Y0M9WcTgHvJscgiuWoCvkp/uDwwqG7Mohhq8EWooLwXkHWgJRgGkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719940946; c=relaxed/simple;
	bh=j9bUT9153Szy/mwE+/IGsvcGOxK9iu4hdNHmABO49bM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NyjmRv8uKf7rMvlZtenivFXRTXBINYfVs0ocnOHMZx90eX8Ml9wX7VgXjA7I3+DF1u5/VO7NUM2AqzoG0b9RsrkSzRF1d+8qN6/Tt6o4Uzz6c56bSp7pxYe6ocRbMXI+D7AVgGBpZVPa7wkTmNET52Y8KYJmftqPGHHfgAMxAKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mxl/XLUH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2A31C116B1;
	Tue,  2 Jul 2024 17:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719940946;
	bh=j9bUT9153Szy/mwE+/IGsvcGOxK9iu4hdNHmABO49bM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mxl/XLUHZ5cAHIdeUDYQrIw/rI5/MQNMoz5G2xuFLQ8vbcxayuGNsaM0MowH8JGX8
	 co26Bqkw5b40OBWY9l4s270YnkCQkk2LpYDZ07sc3gGzVoLOuL3+Do8zvGjWKYgTvM
	 g/3eG/RQ3gLR4SQtdpmIXPpbh2vsrmGPIBQw+PpY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
	"Hailong.Liu" <hailong.liu@oppo.com>,
	"Uladzislau Rezki (Sony)" <urezki@gmail.com>,
	Baoquan He <bhe@redhat.com>,
	Christoph Hellwig <hch@infradead.org>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.6 084/163] mm: fix incorrect vbq reference in purge_fragmented_block
Date: Tue,  2 Jul 2024 19:03:18 +0200
Message-ID: <20240702170236.244894977@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240702170233.048122282@linuxfoundation.org>
References: <20240702170233.048122282@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

commit 8c61291fd8500e3b35c7ec0c781b273d8cc96cde upstream.

xa_for_each() in _vm_unmap_aliases() loops through all vbs.  However,
since commit 062eacf57ad9 ("mm: vmalloc: remove a global vmap_blocks
xarray") the vb from xarray may not be on the corresponding CPU
vmap_block_queue.  Consequently, purge_fragmented_block() might use the
wrong vbq->lock to protect the free list, leading to vbq->free breakage.

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

To fix this, introducee cpu within vmap_block to record which this vb
belongs to.

Link: https://lkml.kernel.org/r/20240614021352.1822225-1-zhaoyang.huang@unisoc.com
Link: https://lkml.kernel.org/r/20240607023116.1720640-1-zhaoyang.huang@unisoc.com
Fixes: fc1e0d980037 ("mm/vmalloc: prevent stale TLBs in fully utilized blocks")
Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
Suggested-by: Hailong.Liu <hailong.liu@oppo.com>
Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Lorenzo Stoakes <lstoakes@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/vmalloc.c |   21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -1939,6 +1939,7 @@ struct vmap_block {
 	struct list_head free_list;
 	struct rcu_head rcu_head;
 	struct list_head purge;
+	unsigned int cpu;
 };
 
 /* Queue of free and dirty vmap blocks, for allocation and flushing purposes */
@@ -2066,8 +2067,15 @@ static void *new_vmap_block(unsigned int
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
@@ -2093,9 +2101,10 @@ static void free_vmap_block(struct vmap_
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
@@ -2143,7 +2152,7 @@ static void purge_fragmented_blocks(int
 			continue;
 
 		spin_lock(&vb->lock);
-		purge_fragmented_block(vb, vbq, &purge, true);
+		purge_fragmented_block(vb, &purge, true);
 		spin_unlock(&vb->lock);
 	}
 	rcu_read_unlock();
@@ -2280,7 +2289,7 @@ static void _vm_unmap_aliases(unsigned l
 			 * not purgeable, check whether there is dirty
 			 * space to be flushed.
 			 */
-			if (!purge_fragmented_block(vb, vbq, &purge_list, false) &&
+			if (!purge_fragmented_block(vb, &purge_list, false) &&
 			    vb->dirty_max && vb->dirty != VMAP_BBMAP_BITS) {
 				unsigned long va_start = vb->va->va_start;
 				unsigned long s, e;



