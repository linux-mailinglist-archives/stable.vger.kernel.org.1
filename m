Return-Path: <stable+bounces-152704-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2E51ADAFDD
	for <lists+stable@lfdr.de>; Mon, 16 Jun 2025 14:09:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A18F27A5756
	for <lists+stable@lfdr.de>; Mon, 16 Jun 2025 12:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 727052E4240;
	Mon, 16 Jun 2025 12:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="EiMAQ/Qm"
X-Original-To: stable@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED592E4241
	for <stable@vger.kernel.org>; Mon, 16 Jun 2025 12:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750075786; cv=none; b=G3rMVyri8vT8bJEM7RzpXFmJ2wj7JgRP1e9XRlqMO8Q1u4jt7awWyXrDhg7LaizLI7VAPJex5L9t8PKvjo9hhKnzjdDSVrw310zm17PZZin/f+JJicMlh7tbowjzEnV4BEIySIYDJI5+0SK8vibH6KOMJIoc8ZcvRUIJwUx7/So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750075786; c=relaxed/simple;
	bh=EYrrDilvdga+E1vzHBnZRq3OykAxV9itkfRuMPAXZ+M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=BIuHLodY/BOKlFR388xJkjylBZrJGlxgW5FElBZkv7+SyXhM+hKQHguMH4tjwB/i0fICQdQHzvOff+xIhDyQJPiHAD+TSYa2BxCyaKHXmXOWbN/xRfDKk84I8LC9WeusVQkPuDIn/AC5TGTuC3R2xQlowxftFtt06vf8yxuR1ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=EiMAQ/Qm; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20250616120941euoutp027ae62a1b5a177fa307879bb7d57dc0f2~JhKalpHrF3006030060euoutp02-
	for <stable@vger.kernel.org>; Mon, 16 Jun 2025 12:09:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20250616120941euoutp027ae62a1b5a177fa307879bb7d57dc0f2~JhKalpHrF3006030060euoutp02-
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1750075781;
	bh=JJMZlZ/EXjEkuE1I03QKBankQc62X7dLkhxQ/QdZRGY=;
	h=From:To:Cc:Subject:Date:References:From;
	b=EiMAQ/QmH2eYiaUqGw4WMbN2SONw8s3+AofBiZgcUXdUMM4X4y6JVtS8zixkaLtha
	 hDqwFUJSXi1X/L6BeSLK8RIRAC1tZ/dADPh8QMN7rwBkLLjt5rURcikukSlK2EL0jF
	 ZdvWR7BTBynBoJLvWghddxGsoQw4XG43JujvqUEk=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20250616120941eucas1p2329f4080332615953fa77ba5ad0c0155~JhKaR2O-O1539115391eucas1p2w;
	Mon, 16 Jun 2025 12:09:41 +0000 (GMT)
Received: from AMDC4653.digital.local (unknown [106.120.51.32]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250616120940eusmtip12e7864750bb508173ef4a2860829f61e~JhKZ1-4y20132101321eusmtip1J;
	Mon, 16 Jun 2025 12:09:40 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: linux-fpga@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Moritz Fischer
	<mdf@kernel.org>, Wu Hao <hao.wu@intel.com>, Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>, Michal Simek <michal.simek@amd.com>, Jason
	Gunthorpe <jgg@ziepe.ca>, stable@vger.kernel.org
Subject: [PATCH v2] zynq_fpga: use sgtable-based scatterlist wrappers
Date: Mon, 16 Jun 2025 14:09:32 +0200
Message-Id: <20250616120932.1090614-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250616120941eucas1p2329f4080332615953fa77ba5ad0c0155
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250616120941eucas1p2329f4080332615953fa77ba5ad0c0155
X-EPHeader: CA
X-CMS-RootMailID: 20250616120941eucas1p2329f4080332615953fa77ba5ad0c0155
References: <CGME20250616120941eucas1p2329f4080332615953fa77ba5ad0c0155@eucas1p2.samsung.com>

Use common wrappers operating directly on the struct sg_table objects to
fix incorrect use of statterlists related calls. dma_unmap_sg() function
has to be called with the number of elements originally passed to the
dma_map_sg() function, not the one returned in sgtable's nents.

CC: stable@vger.kernel.org
Fixes: 425902f5c8e3 ("fpga zynq: Use the scatterlist interface")
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
v2:
- fixed build break (missing flags parameter)
---
 drivers/fpga/zynq-fpga.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git drivers/fpga/zynq-fpga.c drivers/fpga/zynq-fpga.c
index f7e08f7ea9ef..0be0d569589d 100644
--- drivers/fpga/zynq-fpga.c
+++ drivers/fpga/zynq-fpga.c
@@ -406,7 +406,7 @@ static int zynq_fpga_ops_write(struct fpga_manager *mgr, struct sg_table *sgt)
 	}
 
 	priv->dma_nelms =
-	    dma_map_sg(mgr->dev.parent, sgt->sgl, sgt->nents, DMA_TO_DEVICE);
+	    dma_map_sgtable(mgr->dev.parent, sgt, DMA_TO_DEVICE, 0);
 	if (priv->dma_nelms == 0) {
 		dev_err(&mgr->dev, "Unable to DMA map (TO_DEVICE)\n");
 		return -ENOMEM;
@@ -478,7 +478,7 @@ static int zynq_fpga_ops_write(struct fpga_manager *mgr, struct sg_table *sgt)
 	clk_disable(priv->clk);
 
 out_free:
-	dma_unmap_sg(mgr->dev.parent, sgt->sgl, sgt->nents, DMA_TO_DEVICE);
+	dma_unmap_sgtable(mgr->dev.parent, sgt, DMA_TO_DEVICE, 0);
 	return err;
 }
 
-- 
2.34.1


