Return-Path: <stable+bounces-114473-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3A08A2E3C0
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 06:40:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5225F18866E1
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 05:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1B6B19993D;
	Mon, 10 Feb 2025 05:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JGMdA1De"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B323818FDAB;
	Mon, 10 Feb 2025 05:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739165981; cv=none; b=mWgwUkeOjX0zbZTy3pogXt70lXuxGxyLW0VnjYZaSuwqaFv06Qxv7Un0p8z+QBgnNlINNbJr1R3Y301ZQ8rdHX2CkoAC8/QAI/laVN+20JXTrJJOqaDKt9HsHoulIfttCOtLr+RKZz/2xMRlSrxyugKqsjQDnCWITeiIiToAKOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739165981; c=relaxed/simple;
	bh=lc1WfOtHLL38dYTO0tNdpL4x3ecYIFTJQotuO3oN89A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TD5lm3vLs9Wc3rydWYalZt/1tb0Fwv/KjDPRP7UgjSLSdP+IEKOeMePplLXg5cWhR9mK+/rqFAMBMH1/w+0EXbJSJeXClsJSCXHP7HHVB6/OK5FwzwN46T7RjR+uLfz91YzVEXvIlw0ZMWo5Gig85tY15Dbf8ZEMwrE0pqw3OuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JGMdA1De; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739165980; x=1770701980;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lc1WfOtHLL38dYTO0tNdpL4x3ecYIFTJQotuO3oN89A=;
  b=JGMdA1Dejx84+pmUKA+QusARKQ7/kT514RAYSJ+WXusNws9QPzLnK4zK
   qulR2+ByiBqbjxV6BjZHR6SiUzEgS5QF7/nCY8EGkO+1Bt+AvIDOpr+Tv
   BTNas/tpU9G1+2rQcSe4/8wne8FNhMbznvIcRcSBEcwC4Zfkz156hcil4
   rqlk4Hn0e560sxb3K8I2Cp/bEcyJQkG/B7Ysfugdo2lQi4aY7vo2/y6hQ
   MYPVf4cm1CveEl3lHmRO89klJJ5aLm5YxB2x9tzYjCEkoHS5zHCnIj9jL
   1FDaUzg+mKRM8eH7N0F8i2+3iKXjXLVRWJm+IreF470tXPzWS2MQyal6A
   A==;
X-CSE-ConnectionGUID: MFB1LqUYRjSTW376oas4xg==
X-CSE-MsgGUID: IeNk2ETrRROKF2KYYjEgZA==
X-IronPort-AV: E=McAfee;i="6700,10204,11340"; a="43657934"
X-IronPort-AV: E=Sophos;i="6.13,273,1732608000"; 
   d="scan'208";a="43657934"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2025 21:39:39 -0800
X-CSE-ConnectionGUID: epoIkivSQkid3sN3L33k3A==
X-CSE-MsgGUID: vjvsKXlBRGCR1toba1vrAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,273,1732608000"; 
   d="scan'208";a="112318420"
Received: from pg15swiplab1181.png.altera.com ([10.244.232.167])
  by fmviesa008.fm.intel.com with ESMTP; 09 Feb 2025 21:39:36 -0800
From: niravkumar.l.rabara@intel.com
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Niravkumar L Rabara <niravkumar.l.rabara@intel.com>,
	linux@treblig.org,
	Shen Lichuan <shenlichuan@vivo.com>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	u.kleine-koenig@baylibre.com,
	nirav.rabara@altera.com,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH v3 2/3] mtd: rawnand: cadence: use dma_map_resource for sdma address
Date: Mon, 10 Feb 2025 13:35:50 +0800
Message-Id: <20250210053551.2399716-3-niravkumar.l.rabara@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250210053551.2399716-1-niravkumar.l.rabara@intel.com>
References: <20250210053551.2399716-1-niravkumar.l.rabara@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>

Remap the slave DMA I/O resources to enhance driver portability.
Using a physical address causes DMA translation failure when the
ARM SMMU is enabled.

Fixes: ec4ba01e894d ("mtd: rawnand: Add new Cadence NAND driver to MTD subsystem")
Cc: stable@vger.kernel.org
Signed-off-by: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
---
 .../mtd/nand/raw/cadence-nand-controller.c    | 29 ++++++++++++++++---
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/nand/raw/cadence-nand-controller.c b/drivers/mtd/nand/raw/cadence-nand-controller.c
index fb5f671bdb7b..47950a0ac6d2 100644
--- a/drivers/mtd/nand/raw/cadence-nand-controller.c
+++ b/drivers/mtd/nand/raw/cadence-nand-controller.c
@@ -471,6 +471,8 @@ struct cdns_nand_ctrl {
 	struct {
 		void __iomem *virt;
 		dma_addr_t dma;
+		dma_addr_t iova_dma;
+		u32 size;
 	} io;
 
 	int irq;
@@ -1835,11 +1837,11 @@ static int cadence_nand_slave_dma_transfer(struct cdns_nand_ctrl *cdns_ctrl,
 	}
 
 	if (dir == DMA_FROM_DEVICE) {
-		src_dma = cdns_ctrl->io.dma;
+		src_dma = cdns_ctrl->io.iova_dma;
 		dst_dma = buf_dma;
 	} else {
 		src_dma = buf_dma;
-		dst_dma = cdns_ctrl->io.dma;
+		dst_dma = cdns_ctrl->io.iova_dma;
 	}
 
 	tx = dmaengine_prep_dma_memcpy(cdns_ctrl->dmac, dst_dma, src_dma, len,
@@ -2869,6 +2871,7 @@ cadence_nand_irq_cleanup(int irqnum, struct cdns_nand_ctrl *cdns_ctrl)
 static int cadence_nand_init(struct cdns_nand_ctrl *cdns_ctrl)
 {
 	dma_cap_mask_t mask;
+	struct dma_device *dma_dev = cdns_ctrl->dmac->device;
 	int ret;
 
 	cdns_ctrl->cdma_desc = dma_alloc_coherent(cdns_ctrl->dev,
@@ -2912,6 +2915,16 @@ static int cadence_nand_init(struct cdns_nand_ctrl *cdns_ctrl)
 		}
 	}
 
+	cdns_ctrl->io.iova_dma = dma_map_resource(dma_dev->dev, cdns_ctrl->io.dma,
+						  cdns_ctrl->io.size,
+						  DMA_BIDIRECTIONAL, 0);
+
+	ret = dma_mapping_error(dma_dev->dev, cdns_ctrl->io.iova_dma);
+	if (ret) {
+		dev_err(cdns_ctrl->dev, "Failed to map I/O resource to DMA\n");
+		goto dma_release_chnl;
+	}
+
 	nand_controller_init(&cdns_ctrl->controller);
 	INIT_LIST_HEAD(&cdns_ctrl->chips);
 
@@ -2922,18 +2935,22 @@ static int cadence_nand_init(struct cdns_nand_ctrl *cdns_ctrl)
 	if (ret) {
 		dev_err(cdns_ctrl->dev, "Failed to register MTD: %d\n",
 			ret);
-		goto dma_release_chnl;
+		goto unmap_dma_resource;
 	}
 
 	kfree(cdns_ctrl->buf);
 	cdns_ctrl->buf = kzalloc(cdns_ctrl->buf_size, GFP_KERNEL);
 	if (!cdns_ctrl->buf) {
 		ret = -ENOMEM;
-		goto dma_release_chnl;
+		goto unmap_dma_resource;
 	}
 
 	return 0;
 
+unmap_dma_resource:
+	dma_unmap_resource(dma_dev->dev, cdns_ctrl->io.iova_dma,
+			   cdns_ctrl->io.size, DMA_BIDIRECTIONAL, 0);
+
 dma_release_chnl:
 	if (cdns_ctrl->dmac)
 		dma_release_channel(cdns_ctrl->dmac);
@@ -2955,6 +2972,8 @@ static int cadence_nand_init(struct cdns_nand_ctrl *cdns_ctrl)
 static void cadence_nand_remove(struct cdns_nand_ctrl *cdns_ctrl)
 {
 	cadence_nand_chips_cleanup(cdns_ctrl);
+	dma_unmap_resource(cdns_ctrl->dmac->device->dev, cdns_ctrl->io.iova_dma,
+			   cdns_ctrl->io.size, DMA_BIDIRECTIONAL, 0);
 	cadence_nand_irq_cleanup(cdns_ctrl->irq, cdns_ctrl);
 	kfree(cdns_ctrl->buf);
 	dma_free_coherent(cdns_ctrl->dev, sizeof(struct cadence_nand_cdma_desc),
@@ -3019,7 +3038,9 @@ static int cadence_nand_dt_probe(struct platform_device *ofdev)
 	cdns_ctrl->io.virt = devm_platform_get_and_ioremap_resource(ofdev, 1, &res);
 	if (IS_ERR(cdns_ctrl->io.virt))
 		return PTR_ERR(cdns_ctrl->io.virt);
+
 	cdns_ctrl->io.dma = res->start;
+	cdns_ctrl->io.size = resource_size(res);
 
 	dt->clk = devm_clk_get(cdns_ctrl->dev, "nf_clk");
 	if (IS_ERR(dt->clk))
-- 
2.25.1


