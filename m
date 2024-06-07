Return-Path: <stable+bounces-49942-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89EC88FF9F7
	for <lists+stable@lfdr.de>; Fri,  7 Jun 2024 04:34:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBEB12866AC
	for <lists+stable@lfdr.de>; Fri,  7 Jun 2024 02:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E2A810799;
	Fri,  7 Jun 2024 02:33:58 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E987411185
	for <stable@vger.kernel.org>; Fri,  7 Jun 2024 02:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717727638; cv=none; b=qReTs3xnD6MQ1ySlO3f9Dt494nWoklRKfsaE+A2XW0OaH0DoPFn5h6wexV70QJji6QJtFz+b9gSazqtwqS/zWYUUwLcCxLweAIyJbUI2srkvFumiodXo3MoeS5cVHXXVw7HpUlf+YP4HP7XQDxWkU+QOqzKJul33Ewisj1tJv6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717727638; c=relaxed/simple;
	bh=j7SmNnf2IJ7HtGtXQrqOdQgWBu66WrwLsS5J2Vr5gCE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TWN/wlT6PCiuj/AVszd1wq69zuDX7c4PmbfVjPCWbcwCnMToMLsE1oDU3aELTwnQVxydtkXurATm/GlVe+6ny7Q5fr0bubWPziTSH6qdkN+ikFwnVqVIAnKblj4uKwJni6ng3qx4bhR/QJH2l3Upb/57A5wihsdE/zhz8BTEV+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 4572VNQe079441;
	Fri, 7 Jun 2024 10:31:23 +0800 (+08)
	(envelope-from zhaoyang.huang@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4VwQ870Jdyz2QNRs5;
	Fri,  7 Jun 2024 10:27:19 +0800 (CST)
Received: from bj03382pcu01.spreadtrum.com (10.0.73.40) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Fri, 7 Jun 2024 10:31:20 +0800
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
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>,
        Zhaoyang Huang <huangzhaoyang@gmail.com>, <steve.kang@unisoc.com>
Subject: [Resend PATCHv4 1/1] mm: fix incorrect vbq reference in purge_fragmented_block
Date: Fri, 7 Jun 2024 10:31:16 +0800
Message-ID: <20240607023116.1720640-1-zhaoyang.huang@unisoc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHCAS01.spreadtrum.com (10.0.1.201) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL:SHSQR01.spreadtrum.com 4572VNQe079441

From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

vmalloc area runs out in our ARM64 system during an erofs test as
vm_map_ram failed[1]. By following the debug log, we find that
vm_map_ram()->vb_alloc() will allocate new vb->va which corresponding
to 4MB vmalloc area as list_for_each_entry_rcu returns immediately
when vbq->free->next points to vbq->free. That is to say, 65536 times
of page fault after the list's broken will run out of the whole
vmalloc area. This should be introduced by one vbq->free->next point to
vbq->free which makes list_for_each_entry_rcu can not iterate the list
and find the BUG.

[1]
PID: 1        TASK: ffffff80802b4e00  CPU: 6    COMMAND: "init"
 #0 [ffffffc08006afe0] __switch_to at ffffffc08111d5cc
 #1 [ffffffc08006b040] __schedule at ffffffc08111dde0
 #2 [ffffffc08006b0a0] schedule at ffffffc08111e294
 #3 [ffffffc08006b0d0] schedule_preempt_disabled at ffffffc08111e3f0
 #4 [ffffffc08006b140] __mutex_lock at ffffffc08112068c
 #5 [ffffffc08006b180] __mutex_lock_slowpath at ffffffc08111f8f8
 #6 [ffffffc08006b1a0] mutex_lock at ffffffc08111f834
 #7 [ffffffc08006b1d0] reclaim_and_purge_vmap_areas at ffffffc0803ebc3c
 #8 [ffffffc08006b290] alloc_vmap_area at ffffffc0803e83fc
 #9 [ffffffc08006b300] vm_map_ram at ffffffc0803e78c0

Fixes: fc1e0d980037 ("mm/vmalloc: prevent stale TLBs in fully utilized blocks")

For detailed reason of broken list, please refer to below URL
https://lore.kernel.org/all/20240531024820.5507-1-hailong.liu@oppo.com/

Suggested-by: Hailong.Liu <hailong.liu@oppo.com>
Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
---
v2: introduce cpu in vmap_block to record the right CPU number
v3: use get_cpu/put_cpu to prevent schedule between core
v4: replace get_cpu/put_cpu by another API to avoid disabling preemption
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


