Return-Path: <stable+bounces-64918-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56AED943C64
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 02:37:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8816A1C20D9B
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 00:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1FF31BF313;
	Thu,  1 Aug 2024 00:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c4DFNPgc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583D01BF308;
	Thu,  1 Aug 2024 00:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722471424; cv=none; b=N3KOrmjX7PhH49w5uN46ay8oE/0IekjWjnuY/4cuPenF1pDgDg9j6sDmrXyrWOPmF70AQQ6z2h0aZsWLAlgIEw/mpPpMl92Bz9x+iPPU1QKX/71YvGbmfPntu203FEYOnwnyzyhD5CdJJ/d0tK3g8HS18KKJWWVYRhdXvT3Vno0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722471424; c=relaxed/simple;
	bh=Cu9u7/IC/vzqe1yfpc+sjG23kEBqYrFG0a0R4YHkCa4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EsKAlyZSB7sCAQ7mpaAS5f80FL8Q123Q+9qN6us7qXVQorWTu9JbFuaWLsIMAf3jCSyDmLREnyRt0h7YjhiMSQhFnlxcnVdCW+LvfjFL2vC6NR7iQXWvV8tAGNfcGLoW+d0dBJAUqUhV7lTHxanuNInqbHCozDrW9h/oy6GfxMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c4DFNPgc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBB24C116B1;
	Thu,  1 Aug 2024 00:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722471424;
	bh=Cu9u7/IC/vzqe1yfpc+sjG23kEBqYrFG0a0R4YHkCa4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c4DFNPgcCmrNRB7Jo45QkQicBPXl+Q2H522FxHoHdpwI6HxmZDFifs6SugmgtM1jG
	 BDaRz3qSegkNLtiJhcJZCgYBdWAbBuGybjLBn2Ih2UBxW9g5FHm4hDg6l/SVc3TdzJ
	 eDYTDe0WS+H303or0iGBlwjj4Y2rkHhNhWLCuWI35glJNqodN8udiLOluuvEuu8fyy
	 FxLBAzhb+eEnxGqyd6MPWOA7JUa+4FWUxXXVgp/UeMq3pm2rLaxPlfq7TRtzJMVc2b
	 GK+T1wIWLjGjRrmUeZchD2vEs65YtEt9fygCWiJS/g+YqqSI07Wyx7hiWA1ZhKCxRF
	 /2T2k7+LH9glA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andre Przywara <andre.przywara@arm.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Joerg Roedel <jroedel@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	joro@8bytes.org,
	will@kernel.org,
	jernej.skrabec@gmail.com,
	samuel@sholland.org,
	iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev
Subject: [PATCH AUTOSEL 6.10 093/121] iommu: sun50i: allocate page tables from below 4 GiB
Date: Wed, 31 Jul 2024 20:00:31 -0400
Message-ID: <20240801000834.3930818-93-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801000834.3930818-1-sashal@kernel.org>
References: <20240801000834.3930818-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.2
Content-Transfer-Encoding: 8bit

From: Andre Przywara <andre.przywara@arm.com>

[ Upstream commit 7b9331a3ae93adfae54c6a56d23513e1f7db5dcb ]

The Allwinner IOMMU is a strict 32-bit device, with its input addresses,
the page table root pointer as well as both level's page tables and also
the target addresses all required to be below 4GB.
The Allwinner H6 SoC only supports 32-bit worth of physical addresses
anyway, so this isn't a problem so far, but the H616 and later SoCs extend
the PA space beyond 32 bit to accommodate more DRAM.
To make sure we stay within the 32-bit PA range required by the IOMMU,
force the memory for the page tables to come from below 4GB. by using
allocations with the DMA32 flag.
Also reject any attempt to map target addresses beyond 4GB, and print a
warning to give users a hint while this fails.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Reviewed-by: Chen-Yu Tsai <wens@csie.org>
Link: https://lore.kernel.org/r/20240616224056.29159-3-andre.przywara@arm.com
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/sun50i-iommu.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/sun50i-iommu.c b/drivers/iommu/sun50i-iommu.c
index c519b991749d7..b5221579c9815 100644
--- a/drivers/iommu/sun50i-iommu.c
+++ b/drivers/iommu/sun50i-iommu.c
@@ -601,6 +601,14 @@ static int sun50i_iommu_map(struct iommu_domain *domain, unsigned long iova,
 	u32 *page_table, *pte_addr;
 	int ret = 0;
 
+	/* the IOMMU can only handle 32-bit addresses, both input and output */
+	if ((uint64_t)paddr >> 32) {
+		ret = -EINVAL;
+		dev_warn_once(iommu->dev,
+			      "attempt to map address beyond 4GB\n");
+		goto out;
+	}
+
 	page_table = sun50i_dte_get_page_table(sun50i_domain, iova, gfp);
 	if (IS_ERR(page_table)) {
 		ret = PTR_ERR(page_table);
@@ -681,7 +689,8 @@ sun50i_iommu_domain_alloc_paging(struct device *dev)
 	if (!sun50i_domain)
 		return NULL;
 
-	sun50i_domain->dt = iommu_alloc_pages(GFP_KERNEL, get_order(DT_SIZE));
+	sun50i_domain->dt = iommu_alloc_pages(GFP_KERNEL | GFP_DMA32,
+					      get_order(DT_SIZE));
 	if (!sun50i_domain->dt)
 		goto err_free_domain;
 
@@ -996,7 +1005,7 @@ static int sun50i_iommu_probe(struct platform_device *pdev)
 
 	iommu->pt_pool = kmem_cache_create(dev_name(&pdev->dev),
 					   PT_SIZE, PT_SIZE,
-					   SLAB_HWCACHE_ALIGN,
+					   SLAB_HWCACHE_ALIGN | SLAB_CACHE_DMA32,
 					   NULL);
 	if (!iommu->pt_pool)
 		return -ENOMEM;
-- 
2.43.0


