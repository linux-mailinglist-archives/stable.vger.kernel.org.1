Return-Path: <stable+bounces-34205-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89C73893E58
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 18:02:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C6DF281143
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 16:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8D431CA8F;
	Mon,  1 Apr 2024 16:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SsFrP8BD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759D14779E;
	Mon,  1 Apr 2024 16:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711987339; cv=none; b=qpfD5mr+dKtfxVffJ7tsynsefJCvCcd+3UTenOlz5Hb6nIMUxl7udNi9boGcbzn34iR6A0jqOB7p3KVeFYmHRIE5rQ/KnA41diM1som0AfPMwvYJLWb2cWL4bcaMhV8Z75z5nmXddTs59z/SRQMSp9TH44kuqXyuNW+dHjd3BIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711987339; c=relaxed/simple;
	bh=ieriJczQcn7Y8HYIPLPK5PwLap4XkWTMmj/6NsViTg8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fdHeuZoVo4SrVXU7twz17FyQGOdPOegW//7U1Q7AsMf1jKuS0+8zJYdSqXtXqAjpSqX2IWwcyaqL2Tbga8T3MPcZ3xloaasVmdN6hiIDfFxuTkHM/sm61Ii4ItDSmXOzyGlxt06U6B4w/e5pHPrP94yqQfOp1G8rhvuPGH3DWfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SsFrP8BD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFC9FC433F1;
	Mon,  1 Apr 2024 16:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711987339;
	bh=ieriJczQcn7Y8HYIPLPK5PwLap4XkWTMmj/6NsViTg8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SsFrP8BDUrIZy9Wt7ulqcDqIG68HG3+BP0ZSHXLtI3wtGaxO7tCYpkSib501wmkQ0
	 0Fc4fzjvuB6NLBIqci9m2pDxeUK9QHRGo77bhEA8PpCj62kXlPAZDwDXXcjFn3Riqo
	 bsrzaxIsOge+w9o36HZpcoZRoc3b0W8Xxg1z8HOg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Will Deacon <will@kernel.org>,
	Michael Kelley <mhklinux@outlook.com>,
	Petr Tesarik <petr.tesarik1@huawei-partners.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 257/399] swiotlb: Fix double-allocation of slots due to broken alignment handling
Date: Mon,  1 Apr 2024 17:43:43 +0200
Message-ID: <20240401152556.845241983@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240401152549.131030308@linuxfoundation.org>
References: <20240401152549.131030308@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.8-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Will Deacon <will@kernel.org>

[ Upstream commit 04867a7a33324c9c562ee7949dbcaab7aaad1fb4 ]

Commit bbb73a103fbb ("swiotlb: fix a braino in the alignment check fix"),
which was a fix for commit 0eee5ae10256 ("swiotlb: fix slot alignment
checks"), causes a functional regression with vsock in a virtual machine
using bouncing via a restricted DMA SWIOTLB pool.

When virtio allocates the virtqueues for the vsock device using
dma_alloc_coherent(), the SWIOTLB search can return page-unaligned
allocations if 'area->index' was left unaligned by a previous allocation
from the buffer:

 # Final address in brackets is the SWIOTLB address returned to the caller
 | virtio-pci 0000:00:07.0: orig_addr 0x0 alloc_size 0x2000, iotlb_align_mask 0x800 stride 0x2: got slot 1645-1649/7168 (0x98326800)
 | virtio-pci 0000:00:07.0: orig_addr 0x0 alloc_size 0x2000, iotlb_align_mask 0x800 stride 0x2: got slot 1649-1653/7168 (0x98328800)
 | virtio-pci 0000:00:07.0: orig_addr 0x0 alloc_size 0x2000, iotlb_align_mask 0x800 stride 0x2: got slot 1653-1657/7168 (0x9832a800)

This ends badly (typically buffer corruption and/or a hang) because
swiotlb_alloc() is expecting a page-aligned allocation and so blindly
returns a pointer to the 'struct page' corresponding to the allocation,
therefore double-allocating the first half (2KiB slot) of the 4KiB page.

Fix the problem by treating the allocation alignment separately to any
additional alignment requirements from the device, using the maximum
of the two as the stride to search the buffer slots and taking care
to ensure a minimum of page-alignment for buffers larger than a page.

This also resolves swiotlb allocation failures occuring due to the
inclusion of ~PAGE_MASK in 'iotlb_align_mask' for large allocations and
resulting in alignment requirements exceeding swiotlb_max_mapping_size().

Fixes: bbb73a103fbb ("swiotlb: fix a braino in the alignment check fix")
Fixes: 0eee5ae10256 ("swiotlb: fix slot alignment checks")
Signed-off-by: Will Deacon <will@kernel.org>
Reviewed-by: Michael Kelley <mhklinux@outlook.com>
Reviewed-by: Petr Tesarik <petr.tesarik1@huawei-partners.com>
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Tested-by: Michael Kelley <mhklinux@outlook.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/dma/swiotlb.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index b079a9a8e0879..2ec2cc81f1a27 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -982,7 +982,7 @@ static int swiotlb_search_pool_area(struct device *dev, struct io_tlb_pool *pool
 		phys_to_dma_unencrypted(dev, pool->start) & boundary_mask;
 	unsigned long max_slots = get_max_slots(boundary_mask);
 	unsigned int iotlb_align_mask =
-		dma_get_min_align_mask(dev) | alloc_align_mask;
+		dma_get_min_align_mask(dev) & ~(IO_TLB_SIZE - 1);
 	unsigned int nslots = nr_slots(alloc_size), stride;
 	unsigned int offset = swiotlb_align_offset(dev, orig_addr);
 	unsigned int index, slots_checked, count = 0, i;
@@ -994,18 +994,17 @@ static int swiotlb_search_pool_area(struct device *dev, struct io_tlb_pool *pool
 	BUG_ON(area_index >= pool->nareas);
 
 	/*
-	 * For allocations of PAGE_SIZE or larger only look for page aligned
-	 * allocations.
+	 * For mappings with an alignment requirement don't bother looping to
+	 * unaligned slots once we found an aligned one.
 	 */
-	if (alloc_size >= PAGE_SIZE)
-		iotlb_align_mask |= ~PAGE_MASK;
-	iotlb_align_mask &= ~(IO_TLB_SIZE - 1);
+	stride = get_max_slots(max(alloc_align_mask, iotlb_align_mask));
 
 	/*
-	 * For mappings with an alignment requirement don't bother looping to
-	 * unaligned slots once we found an aligned one.
+	 * For allocations of PAGE_SIZE or larger only look for page aligned
+	 * allocations.
 	 */
-	stride = (iotlb_align_mask >> IO_TLB_SHIFT) + 1;
+	if (alloc_size >= PAGE_SIZE)
+		stride = umax(stride, PAGE_SHIFT - IO_TLB_SHIFT + 1);
 
 	spin_lock_irqsave(&area->lock, flags);
 	if (unlikely(nslots > pool->area_nslabs - area->used))
@@ -1015,11 +1014,14 @@ static int swiotlb_search_pool_area(struct device *dev, struct io_tlb_pool *pool
 	index = area->index;
 
 	for (slots_checked = 0; slots_checked < pool->area_nslabs; ) {
+		phys_addr_t tlb_addr;
+
 		slot_index = slot_base + index;
+		tlb_addr = slot_addr(tbl_dma_addr, slot_index);
 
-		if (orig_addr &&
-		    (slot_addr(tbl_dma_addr, slot_index) &
-		     iotlb_align_mask) != (orig_addr & iotlb_align_mask)) {
+		if ((tlb_addr & alloc_align_mask) ||
+		    (orig_addr && (tlb_addr & iotlb_align_mask) !=
+				  (orig_addr & iotlb_align_mask))) {
 			index = wrap_area_index(pool, index + 1);
 			slots_checked++;
 			continue;
-- 
2.43.0




