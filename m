Return-Path: <stable+bounces-146428-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FAA3AC4B94
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 11:32:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE6A717D46F
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 09:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA3AF248F4B;
	Tue, 27 May 2025 09:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="jLMzV1FF"
X-Original-To: stable@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13BA11F4CB1
	for <stable@vger.kernel.org>; Tue, 27 May 2025 09:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748338317; cv=none; b=V1PncmahJKd6KzpgYvISg7RJTu2ZzNX34oJK+dBQ5GueSxveLwVCqi4jKHW3QqZSo6lMK8K10k1MgCT1kxeUQKHI9APUK1BT+dd6nPWkqDjwQGXMr62ILfQ/jbSjGFH8rF6+NybeCYqD8CeyhZhuW00MGBP8BvNCIwjl/OmEE5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748338317; c=relaxed/simple;
	bh=U0UIg9LP+4sSr3dQqYeBx8E/ThnysS0h8O/LIWF+2eo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=q2jrkcjMy52lDDTvuQ8u/rWkwPweu6Xlm1jarHIjZNlZ9FQKnBFAfdittN9/ohU7qQGsCkXF5cn0CZFIWa+gODNA8Nsl+oh0/aCC5nBVwMnlmUSCUiFPM7CoufXG5HCQ2WJa6vmldrGapSSAfqqkFNHQx57Q/DzGw2l2EFhl8Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=jLMzV1FF; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20250527093153euoutp01095cde84648ef73982bae4ad6f6d6d0e~DWG7In2qD1718217182euoutp01d
	for <stable@vger.kernel.org>; Tue, 27 May 2025 09:31:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20250527093153euoutp01095cde84648ef73982bae4ad6f6d6d0e~DWG7In2qD1718217182euoutp01d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1748338313;
	bh=vhSC01DGXSNQqg+V1YO3zjMGynr+vEoBkC7zcCPnkho=;
	h=From:To:Cc:Subject:Date:References:From;
	b=jLMzV1FFqWRSHtu6p39Q5EoD8YscvXEidTgo1wa5pzbuBEgp7cGPyhvqeShfi170J
	 p+8iuqteyYogV73gKcGUHDy+1+mtCkrRnWS6gRf1KnxA9yb7/GnMP+GJlfwse2IZ1p
	 5WDSfi4/ZodMHNuqRgu8k22GjFA8MPpWDj9IEfAU=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20250527093152eucas1p24a904b0d973252ebc0d05034a276e9cf~DWG6qpOLo0928509285eucas1p2X;
	Tue, 27 May 2025 09:31:52 +0000 (GMT)
Received: from AMDC4653.digital.local (unknown [106.120.51.32]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250527093152eusmtip13122165a26979724994ec57c21158e87~DWG6Pdlvf2645826458eusmtip1Y;
	Tue, 27 May 2025 09:31:52 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: linux-fpga@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Moritz Fischer
	<mdf@kernel.org>, Wu Hao <hao.wu@intel.com>, Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>, Michal Simek <michal.simek@amd.com>, Jason
	Gunthorpe <jgg@ziepe.ca>, stable@vger.kernel.org
Subject: [PATCH] fpga: zynq-fpga: use sgtable-based scatterlist wrappers
Date: Tue, 27 May 2025 11:31:37 +0200
Message-Id: <20250527093137.505621-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250527093152eucas1p24a904b0d973252ebc0d05034a276e9cf
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250527093152eucas1p24a904b0d973252ebc0d05034a276e9cf
X-EPHeader: CA
X-CMS-RootMailID: 20250527093152eucas1p24a904b0d973252ebc0d05034a276e9cf
References: <CGME20250527093152eucas1p24a904b0d973252ebc0d05034a276e9cf@eucas1p2.samsung.com>

Use common wrappers operating directly on the struct sg_table objects to
fix incorrect use of statterlists related calls. dma_unmap_sg() function
has to be called with the number of elements originally passed to the
dma_map_sg() function, not the one returned in sgtable's nents.

CC: stable@vger.kernel.org
Fixes: 425902f5c8e3 ("fpga zynq: Use the scatterlist interface")
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/fpga/zynq-fpga.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/fpga/zynq-fpga.c b/drivers/fpga/zynq-fpga.c
index f7e08f7ea9ef..9bd39d1d4048 100644
--- a/drivers/fpga/zynq-fpga.c
+++ b/drivers/fpga/zynq-fpga.c
@@ -406,7 +406,7 @@ static int zynq_fpga_ops_write(struct fpga_manager *mgr, struct sg_table *sgt)
 	}
 
 	priv->dma_nelms =
-	    dma_map_sg(mgr->dev.parent, sgt->sgl, sgt->nents, DMA_TO_DEVICE);
+	    dma_map_sgtable(mgr->dev.parent, sgt, DMA_TO_DEVICE);
 	if (priv->dma_nelms == 0) {
 		dev_err(&mgr->dev, "Unable to DMA map (TO_DEVICE)\n");
 		return -ENOMEM;
@@ -478,7 +478,7 @@ static int zynq_fpga_ops_write(struct fpga_manager *mgr, struct sg_table *sgt)
 	clk_disable(priv->clk);
 
 out_free:
-	dma_unmap_sg(mgr->dev.parent, sgt->sgl, sgt->nents, DMA_TO_DEVICE);
+	dma_unmap_sgtable(mgr->dev.parent, sgt, DMA_TO_DEVICE);
 	return err;
 }
 
-- 
2.34.1


