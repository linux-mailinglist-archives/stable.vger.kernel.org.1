Return-Path: <stable+bounces-180817-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D09BB8DD65
	for <lists+stable@lfdr.de>; Sun, 21 Sep 2025 17:39:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FB4818983BD
	for <lists+stable@lfdr.de>; Sun, 21 Sep 2025 15:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9CE61DE887;
	Sun, 21 Sep 2025 15:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jVIlDqfc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877EA1A9FAF
	for <stable@vger.kernel.org>; Sun, 21 Sep 2025 15:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758469159; cv=none; b=N36iSNutKWgL9PJKG8RYJoSnn0GE8y9LiUZv/vdCjh30AgD+v5vTsrGE9Aq30sGc9ZcRoZiVXLis3EbGhJab5zJLYcWDtbZ/aoPV1fG4umN6sD2FTHeXVMTN/QFfVsQBHbedZdiBDwVAX5OHyobaUzMi+72j0aAXYVOdKGHzWIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758469159; c=relaxed/simple;
	bh=7XfQP9M6U5cQSD/5Ig1brD6QswcMhHOK2CVzzz3B50Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u/np2nJQfheLbHGHVm42fKp6icU6bD/hGKRR5S1CEaWk0d+IGlLKjeQmT3nnNTuwSa457PCN4LFdQQI7PkrFYkGKeD9/DSWof21sjGkRtw4FAsUJxo/DhbP0syOGQXzJS6Ir+sYNcmVCPpmBr15BjDj85QUTYLnX9b2SeamtpNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jVIlDqfc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 572C4C4CEE7;
	Sun, 21 Sep 2025 15:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758469159;
	bh=7XfQP9M6U5cQSD/5Ig1brD6QswcMhHOK2CVzzz3B50Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jVIlDqfc57vB6X2AS6Fw1NibI/q9AfusSc9l+DaAK0+8zPKqrPKvhct231gn0K8Nb
	 prk7rGL0KZFmce+KrsLmI/VV3Kg+yQvHvvJ9DJ3+lRCXrxFfzoD3es1MOwp9AvqksF
	 KlD4c0gpPa75LwXT+hs6t9ZduZXeVXzoGXypoyt0kHln0zGADBkQQGU45Ah3+9mw7v
	 hDmellv2ikQDigrohYHnuzLTPTo7GY24FMpS5j06kBzbs22ObtyTCppcQMgrz6spCi
	 lPep9fDKlCiKpZZUTgN791HajQzRMpcqUItGbLAno13rdVTIGiP0Qr1ar9mWOp6QtE
	 xR8onQ9AxrzSA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Vasant Hegde <vasant.hegde@amd.com>,
	Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
	Joao Martins <joao.m.martins@oracle.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Joerg Roedel <joerg.roedel@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] iommu/amd/pgtbl: Fix possible race while increase page table level
Date: Sun, 21 Sep 2025 11:39:16 -0400
Message-ID: <20250921153916.2944533-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025092102-unbutton-entire-9371@gregkh>
References: <2025092102-unbutton-entire-9371@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vasant Hegde <vasant.hegde@amd.com>

[ Upstream commit 1e56310b40fd2e7e0b9493da9ff488af145bdd0c ]

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
[ Adapted pgtable->mode and pgtable->root to use domain->iop.mode and domain->iop.root ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/amd/amd_iommu_types.h |  1 +
 drivers/iommu/amd/io_pgtable.c      | 26 ++++++++++++++++++++++----
 2 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 7dc30c2b56b30..d872054b874fa 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -540,6 +540,7 @@ struct amd_irte_ops;
 	container_of((x), struct amd_io_pgtable, pgtbl_cfg)
 
 struct amd_io_pgtable {
+	seqcount_t		seqcount;	/* Protects root/mode update */
 	struct io_pgtable_cfg	pgtbl_cfg;
 	struct io_pgtable	iop;
 	int			mode;
diff --git a/drivers/iommu/amd/io_pgtable.c b/drivers/iommu/amd/io_pgtable.c
index 2892aa1b4dc1d..b785d82399983 100644
--- a/drivers/iommu/amd/io_pgtable.c
+++ b/drivers/iommu/amd/io_pgtable.c
@@ -17,6 +17,7 @@
 #include <linux/slab.h>
 #include <linux/types.h>
 #include <linux/dma-mapping.h>
+#include <linux/seqlock.h>
 
 #include <asm/barrier.h>
 
@@ -171,8 +172,11 @@ static bool increase_address_space(struct protection_domain *domain,
 
 	*pte = PM_LEVEL_PDE(domain->iop.mode, iommu_virt_to_phys(domain->iop.root));
 
+	write_seqcount_begin(&domain->iop.seqcount);
 	domain->iop.root  = pte;
 	domain->iop.mode += 1;
+	write_seqcount_end(&domain->iop.seqcount);
+
 	amd_iommu_update_and_flush_device_table(domain);
 	amd_iommu_domain_flush_complete(domain);
 
@@ -199,6 +203,7 @@ static u64 *alloc_pte(struct protection_domain *domain,
 		      gfp_t gfp,
 		      bool *updated)
 {
+	unsigned int seqcount;
 	int level, end_lvl;
 	u64 *pte, *page;
 
@@ -214,8 +219,14 @@ static u64 *alloc_pte(struct protection_domain *domain,
 	}
 
 
-	level   = domain->iop.mode - 1;
-	pte     = &domain->iop.root[PM_LEVEL_INDEX(level, address)];
+	do {
+		seqcount = read_seqcount_begin(&domain->iop.seqcount);
+
+		level   = domain->iop.mode - 1;
+		pte     = &domain->iop.root[PM_LEVEL_INDEX(level, address)];
+	} while (read_seqcount_retry(&domain->iop.seqcount, seqcount));
+
+
 	address = PAGE_SIZE_ALIGN(address, page_size);
 	end_lvl = PAGE_SIZE_LEVEL(page_size);
 
@@ -292,6 +303,7 @@ static u64 *fetch_pte(struct amd_io_pgtable *pgtable,
 		      unsigned long *page_size)
 {
 	int level;
+	unsigned int seqcount;
 	u64 *pte;
 
 	*page_size = 0;
@@ -299,8 +311,12 @@ static u64 *fetch_pte(struct amd_io_pgtable *pgtable,
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
@@ -524,6 +540,8 @@ static struct io_pgtable *v1_alloc_pgtable(struct io_pgtable_cfg *cfg, void *coo
 	cfg->oas            = IOMMU_OUT_ADDR_BIT_SIZE,
 	cfg->tlb            = &v1_flush_ops;
 
+	seqcount_init(&pgtable->seqcount);
+
 	pgtable->iop.ops.map_pages    = iommu_v1_map_pages;
 	pgtable->iop.ops.unmap_pages  = iommu_v1_unmap_pages;
 	pgtable->iop.ops.iova_to_phys = iommu_v1_iova_to_phys;
-- 
2.51.0


