Return-Path: <stable+bounces-180764-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA1ADB8DAC8
	for <lists+stable@lfdr.de>; Sun, 21 Sep 2025 14:25:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E6133B591A
	for <lists+stable@lfdr.de>; Sun, 21 Sep 2025 12:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 522DD1EB5CE;
	Sun, 21 Sep 2025 12:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yzkcc/0H"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025F52E40B
	for <stable@vger.kernel.org>; Sun, 21 Sep 2025 12:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758457506; cv=none; b=NLwfXhz/WSwuTZjCBpm9qEDkzkk5oG1z6PaQ0xskky7krEZBFS5+Y/WePVjxZ6CmKdCbJl6ZLnmzYCfSE7+ENkwhKGD+9StjWi/spwKdXXsBz2jtA+mXxVk7U0LGoXJb5V1tAlTOfRNnB/S0TBBTLWi7D/cEH2mbdfX/MvfZTUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758457506; c=relaxed/simple;
	bh=oso2rzVMqfwA6DAm64A/Xd8+oShJuGX1FUDFggBy0jI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Wvs6nbBL5bjQgTo8bauHKDtCI6ctcrUjqhWNwqx1UAeIT+SXQixHlpo6RcXwhxKenhxs+LK2EiO0Xa7/5zkX62ahSNKAY0INX3yjdZsO7vIzW6jcxgbj1gUz/FOG6fmtjy1JvYRTOIKG6N7p4a4dZoZ8OD1pVkKDIS43mIsJ00k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yzkcc/0H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D1A2C4CEE7;
	Sun, 21 Sep 2025 12:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758457504;
	bh=oso2rzVMqfwA6DAm64A/Xd8+oShJuGX1FUDFggBy0jI=;
	h=Subject:To:Cc:From:Date:From;
	b=yzkcc/0HcHODrHz0+y8gTUTfBUzVzsVxRAHgymw+N9NQVoY5RJOyPs2KK2fI2W5Ko
	 LaSqx5KGn9n6W2VmDjjn49Ly2CavDtEY+CfairsSXT/ZoUwOeZz7so8vVSw5RI3U36
	 YBPsnkHuvc4guEx4Gb2J/N5L8eSSiY393HiOx9ng=
Subject: FAILED: patch "[PATCH] iommu/amd/pgtbl: Fix possible race while increase page table" failed to apply to 6.6-stable tree
To: vasant.hegde@amd.com,alejandro.j.jimenez@oracle.com,joao.m.martins@oracle.com,joerg.roedel@amd.com,suravee.suthikulpanit@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 21 Sep 2025 14:25:02 +0200
Message-ID: <2025092102-unbutton-entire-9371@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 1e56310b40fd2e7e0b9493da9ff488af145bdd0c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025092102-unbutton-entire-9371@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1e56310b40fd2e7e0b9493da9ff488af145bdd0c Mon Sep 17 00:00:00 2001
From: Vasant Hegde <vasant.hegde@amd.com>
Date: Sat, 13 Sep 2025 06:26:57 +0000
Subject: [PATCH] iommu/amd/pgtbl: Fix possible race while increase page table
 level

The AMD IOMMU host page table implementation supports dynamic page table levels
(up to 6 levels), starting with a 3-level configuration that expands based on
IOVA address. The kernel maintains a root pointer and current page table level
to enable proper page table walks in alloc_pte()/fetch_pte() operations.

The IOMMU IOVA allocator initially starts with 32-bit address and onces its
exhuasted it switches to 64-bit address (max address is determined based
on IOMMU and device DMA capability). To support larger IOVA, AMD IOMMU
driver increases page table level.

But in unmap path (iommu_v1_unmap_pages()), fetch_pte() reads
pgtable->[root/mode] without lock. So its possible that in exteme corner case,
when increase_address_space() is updating pgtable->[root/mode], fetch_pte()
reads wrong page table level (pgtable->mode). It does compare the value with
level encoded in page table and returns NULL. This will result is
iommu_unmap ops to fail and upper layer may retry/log WARN_ON.

CPU 0                                         CPU 1
------                                       ------
map pages                                    unmap pages
alloc_pte() -> increase_address_space()      iommu_v1_unmap_pages() -> fetch_pte()
  pgtable->root = pte (new root value)
                                             READ pgtable->[mode/root]
					       Reads new root, old mode
  Updates mode (pgtable->mode += 1)

Since Page table level updates are infrequent and already synchronized with a
spinlock, implement seqcount to enable lock-free read operations on the read path.

Fixes: 754265bcab7 ("iommu/amd: Fix race in increase_address_space()")
Reported-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Cc: stable@vger.kernel.org
Cc: Joao Martins <joao.m.martins@oracle.com>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Joerg Roedel <joerg.roedel@amd.com>

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 5219d7ddfdaa..95f63c5f6159 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -555,6 +555,7 @@ struct gcr3_tbl_info {
 };
 
 struct amd_io_pgtable {
+	seqcount_t		seqcount;	/* Protects root/mode update */
 	struct io_pgtable	pgtbl;
 	int			mode;
 	u64			*root;
diff --git a/drivers/iommu/amd/io_pgtable.c b/drivers/iommu/amd/io_pgtable.c
index a91e71f981ef..70c2f5b1631b 100644
--- a/drivers/iommu/amd/io_pgtable.c
+++ b/drivers/iommu/amd/io_pgtable.c
@@ -17,6 +17,7 @@
 #include <linux/slab.h>
 #include <linux/types.h>
 #include <linux/dma-mapping.h>
+#include <linux/seqlock.h>
 
 #include <asm/barrier.h>
 
@@ -130,8 +131,11 @@ static bool increase_address_space(struct amd_io_pgtable *pgtable,
 
 	*pte = PM_LEVEL_PDE(pgtable->mode, iommu_virt_to_phys(pgtable->root));
 
+	write_seqcount_begin(&pgtable->seqcount);
 	pgtable->root  = pte;
 	pgtable->mode += 1;
+	write_seqcount_end(&pgtable->seqcount);
+
 	amd_iommu_update_and_flush_device_table(domain);
 
 	pte = NULL;
@@ -153,6 +157,7 @@ static u64 *alloc_pte(struct amd_io_pgtable *pgtable,
 {
 	unsigned long last_addr = address + (page_size - 1);
 	struct io_pgtable_cfg *cfg = &pgtable->pgtbl.cfg;
+	unsigned int seqcount;
 	int level, end_lvl;
 	u64 *pte, *page;
 
@@ -170,8 +175,14 @@ static u64 *alloc_pte(struct amd_io_pgtable *pgtable,
 	}
 
 
-	level   = pgtable->mode - 1;
-	pte     = &pgtable->root[PM_LEVEL_INDEX(level, address)];
+	do {
+		seqcount = read_seqcount_begin(&pgtable->seqcount);
+
+		level   = pgtable->mode - 1;
+		pte     = &pgtable->root[PM_LEVEL_INDEX(level, address)];
+	} while (read_seqcount_retry(&pgtable->seqcount, seqcount));
+
+
 	address = PAGE_SIZE_ALIGN(address, page_size);
 	end_lvl = PAGE_SIZE_LEVEL(page_size);
 
@@ -249,6 +260,7 @@ static u64 *fetch_pte(struct amd_io_pgtable *pgtable,
 		      unsigned long *page_size)
 {
 	int level;
+	unsigned int seqcount;
 	u64 *pte;
 
 	*page_size = 0;
@@ -256,8 +268,12 @@ static u64 *fetch_pte(struct amd_io_pgtable *pgtable,
 	if (address > PM_LEVEL_SIZE(pgtable->mode))
 		return NULL;
 
-	level	   =  pgtable->mode - 1;
-	pte	   = &pgtable->root[PM_LEVEL_INDEX(level, address)];
+	do {
+		seqcount = read_seqcount_begin(&pgtable->seqcount);
+		level	   =  pgtable->mode - 1;
+		pte	   = &pgtable->root[PM_LEVEL_INDEX(level, address)];
+	} while (read_seqcount_retry(&pgtable->seqcount, seqcount));
+
 	*page_size =  PTE_LEVEL_PAGE_SIZE(level);
 
 	while (level > 0) {
@@ -541,6 +557,7 @@ static struct io_pgtable *v1_alloc_pgtable(struct io_pgtable_cfg *cfg, void *coo
 	if (!pgtable->root)
 		return NULL;
 	pgtable->mode = PAGE_MODE_3_LEVEL;
+	seqcount_init(&pgtable->seqcount);
 
 	cfg->pgsize_bitmap  = amd_iommu_pgsize_bitmap;
 	cfg->ias            = IOMMU_IN_ADDR_BIT_SIZE;


