Return-Path: <stable+bounces-71856-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4175796780E
	for <lists+stable@lfdr.de>; Sun,  1 Sep 2024 18:27:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98C2DB21569
	for <lists+stable@lfdr.de>; Sun,  1 Sep 2024 16:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14BBC183CA3;
	Sun,  1 Sep 2024 16:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="W6byKXPC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C648333987;
	Sun,  1 Sep 2024 16:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725208040; cv=none; b=rWD9Rv6JJ+Fwo42Rq0ZxNS0e/V8j9P/nNlHwmmx9SpiNMZhOX6+R5ZjREugC7Q+nxF9qJo6dafZiNguxt1wcm7UYlF29Z6OhPstS17I96j1po+Zg9L8zo3tC5yYFSQ0ghKJ5fpsZqMbLb1enhrJGb2sJi4AcxdLRv/PqNSULjUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725208040; c=relaxed/simple;
	bh=QgtJeAl8qchVKIN1TMqPvnnYhC+uN4/DSGbwJ5I8hGM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J/FnsJmZpmC012sMum+fjqqgXixHIHgtVLEA5SDIIdZgddchRUXdaCBa41JYXGaLGQklVBZjNaZCTg8OXuM7J4ISXCAu7IvjHtqThgZ44nvMHr7EvhF2UszmJOSCNrPLYpzIbkA3GGyMqb6ETvSccAIf5dvIY4JTkj2n7Q2gJII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=W6byKXPC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35326C4CEC3;
	Sun,  1 Sep 2024 16:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725208040;
	bh=QgtJeAl8qchVKIN1TMqPvnnYhC+uN4/DSGbwJ5I8hGM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W6byKXPCkNZOMkXRDyskAN0LQ+XVTLuOohgFGF88JcYogdi2SiWPyzly5B3QnqCIN
	 s+ydMCgdxGD2nCkPy4fTG0MkIz7Mg+RVQ2zehURTdmHsbpH1oKHrLoRBh+m77pDCPF
	 K67+TTupdkXBysUKKeNFwDoHITQ2rMmmceLvcaRs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jason Gunthorpe <jgg@nvidia.com>,
	Will Deacon <will@kernel.org>,
	Kevin Tian <kevin.tian@intel.com>,
	Joerg Roedel <jroedel@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 55/93] iommu: Do not return 0 from map_pages if it doesnt do anything
Date: Sun,  1 Sep 2024 18:16:42 +0200
Message-ID: <20240901160809.434577460@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240901160807.346406833@linuxfoundation.org>
References: <20240901160807.346406833@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jason Gunthorpe <jgg@nvidia.com>

[ Upstream commit 6093cd582f8e027117a8d4ad5d129a1aacdc53d2 ]

These three implementations of map_pages() all succeed if a mapping is
requested with no read or write. Since they return back to __iommu_map()
leaving the mapped output as 0 it triggers an infinite loop. Therefore
nothing is using no-access protection bits.

Further, VFIO and iommufd rely on iommu_iova_to_phys() to get back PFNs
stored by map, if iommu_map() succeeds but iommu_iova_to_phys() fails that
will create serious bugs.

Thus remove this never used "nothing to do" concept and just fail map
immediately.

Fixes: e5fc9753b1a8 ("iommu/io-pgtable: Add ARMv7 short descriptor support")
Fixes: e1d3c0fd701d ("iommu: add ARM LPAE page table allocator")
Fixes: 745ef1092bcf ("iommu/io-pgtable: Move Apple DART support to its own file")
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Acked-by: Will Deacon <will@kernel.org>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Link: https://lore.kernel.org/r/2-v1-1211e1294c27+4b1-iommu_no_prot_jgg@nvidia.com
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/io-pgtable-arm-v7s.c | 3 +--
 drivers/iommu/io-pgtable-arm.c     | 3 +--
 drivers/iommu/io-pgtable-dart.c    | 3 +--
 3 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm-v7s.c b/drivers/iommu/io-pgtable-arm-v7s.c
index 75f244a3e12df..06ffc683b28fe 100644
--- a/drivers/iommu/io-pgtable-arm-v7s.c
+++ b/drivers/iommu/io-pgtable-arm-v7s.c
@@ -552,9 +552,8 @@ static int arm_v7s_map_pages(struct io_pgtable_ops *ops, unsigned long iova,
 		    paddr >= (1ULL << data->iop.cfg.oas)))
 		return -ERANGE;
 
-	/* If no access, then nothing to do */
 	if (!(prot & (IOMMU_READ | IOMMU_WRITE)))
-		return 0;
+		return -EINVAL;
 
 	while (pgcount--) {
 		ret = __arm_v7s_map(data, iova, paddr, pgsize, prot, 1, data->pgd,
diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index 72dcdd468cf30..934dc97f5df9e 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -480,9 +480,8 @@ static int arm_lpae_map_pages(struct io_pgtable_ops *ops, unsigned long iova,
 	if (WARN_ON(iaext || paddr >> cfg->oas))
 		return -ERANGE;
 
-	/* If no access, then nothing to do */
 	if (!(iommu_prot & (IOMMU_READ | IOMMU_WRITE)))
-		return 0;
+		return -EINVAL;
 
 	prot = arm_lpae_prot_to_pte(data, iommu_prot);
 	ret = __arm_lpae_map(data, iova, paddr, pgsize, pgcount, prot, lvl,
diff --git a/drivers/iommu/io-pgtable-dart.c b/drivers/iommu/io-pgtable-dart.c
index 74b1ef2b96bee..10811e0b773d3 100644
--- a/drivers/iommu/io-pgtable-dart.c
+++ b/drivers/iommu/io-pgtable-dart.c
@@ -250,9 +250,8 @@ static int dart_map_pages(struct io_pgtable_ops *ops, unsigned long iova,
 	if (WARN_ON(paddr >> cfg->oas))
 		return -ERANGE;
 
-	/* If no access, then nothing to do */
 	if (!(iommu_prot & (IOMMU_READ | IOMMU_WRITE)))
-		return 0;
+		return -EINVAL;
 
 	tbl = dart_get_table(data, iova);
 
-- 
2.43.0




