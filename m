Return-Path: <stable+bounces-142102-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24DDFAAE636
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 18:14:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AD5B188D945
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 16:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3B4228BABB;
	Wed,  7 May 2025 16:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="SOXVt8LF"
X-Original-To: stable@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20E828B7EF
	for <stable@vger.kernel.org>; Wed,  7 May 2025 16:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746634166; cv=none; b=s68eu0CiaAou+fU+QbN/kJgTAJODevU+/oxTJdO1MGeV7a9SFp4XcFwlT4A3gVSie5YIUPHIX1WxuSx7A+Kle/QQqQoIEC2QsOhYlTtfacQc2EvDVxUca0SrCmi4bLObuEU/w36M+rKbz+1V8vZ46YAgElhjFwhyfUjZbMmiW6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746634166; c=relaxed/simple;
	bh=C1Zh/oHyK0/BfwolEQN5DbNFpAIruxrpIIoT/GoBXv0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=BniD+cOvgHAXBJG4j9UCfmnUmUOHSRTQfDULSh8ndfaBu+2sAVEqjY3U1Pir5O681gPU8RBGLpC0ujuDP+dZ1GOOqlnJHM7mSM5lnAtcobVvjPxPJqWGfGbjXZWhxqz1fslBavQSUB00UsJ/if6WMIYnaPD/GpiUsvzOIO2IFpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=SOXVt8LF; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20250507160923euoutp015d62082a883928be9cb039384f2912dd~9SoR57AJP3224232242euoutp01d
	for <stable@vger.kernel.org>; Wed,  7 May 2025 16:09:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20250507160923euoutp015d62082a883928be9cb039384f2912dd~9SoR57AJP3224232242euoutp01d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1746634163;
	bh=B5ofrGVzRIMScS1uJ8Qx33aDiHf23TB+5NVMssxdhR4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SOXVt8LFUL47GUo0HIBkrFfvL9tI7H8zyXyJ+MTkVhxxXQra/1X34O9MEf5yC8Hzc
	 fIMiTZY+7YJeiJ9JRkEX7SNRDLKTPPQiRqWjkk0Zgf6KikBweKEoHp08+ix8Bm8uSX
	 2fCx640ipYBp6emzIsGydEykX0wbPCdCQrq5ye9U=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250507160923eucas1p1a344e74759410b49143e2be42ef43ded~9SoRm5WVO0255402554eucas1p1m;
	Wed,  7 May 2025 16:09:23 +0000 (GMT)
Received: from AMDC4653.digital.local (unknown [106.120.51.32]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250507160922eusmtip1108f8ea3c7b457c173c3fe5b53ef5572~9SoRJFrVq0592705927eusmtip1Z;
	Wed,  7 May 2025 16:09:22 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
	iommu@lists.linux.dev
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Laurent Pinchart
	<laurent.pinchart@ideasonboard.com>, Sakari Ailus
	<sakari.ailus@linux.intel.com>, Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil@xs4all.nl>, Robin Murphy <robin.murphy@arm.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 3/3] media: omap3isp: use sgtable-based scatterlist
 wrappers
Date: Wed,  7 May 2025 18:09:13 +0200
Message-Id: <20250507160913.2084079-4-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250507160913.2084079-1-m.szyprowski@samsung.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250507160923eucas1p1a344e74759410b49143e2be42ef43ded
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250507160923eucas1p1a344e74759410b49143e2be42ef43ded
X-EPHeader: CA
X-CMS-RootMailID: 20250507160923eucas1p1a344e74759410b49143e2be42ef43ded
References: <20250507160913.2084079-1-m.szyprowski@samsung.com>
	<CGME20250507160923eucas1p1a344e74759410b49143e2be42ef43ded@eucas1p1.samsung.com>

Use common wrappers operating directly on the struct sg_table objects to
fix incorrect use of scatterlists sync calls. dma_sync_sg_for_*()
functions have to be called with the number of elements originally passed
to dma_map_sg_*() function, not the one returned in sgtable's nents.

Fixes: d33186d0be18 ("[media] omap3isp: ccdc: Use the DMA API for LSC")
Fixes: 0e24e90f2ca7 ("[media] omap3isp: stat: Use the DMA API")
CC: stable@vger.kernel.org
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/media/platform/ti/omap3isp/ispccdc.c | 8 ++++----
 drivers/media/platform/ti/omap3isp/ispstat.c | 6 ++----
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/media/platform/ti/omap3isp/ispccdc.c b/drivers/media/platform/ti/omap3isp/ispccdc.c
index dd375c4e180d..7d0c723dcd11 100644
--- a/drivers/media/platform/ti/omap3isp/ispccdc.c
+++ b/drivers/media/platform/ti/omap3isp/ispccdc.c
@@ -446,8 +446,8 @@ static int ccdc_lsc_config(struct isp_ccdc_device *ccdc,
 		if (ret < 0)
 			goto done;
 
-		dma_sync_sg_for_cpu(isp->dev, req->table.sgt.sgl,
-				    req->table.sgt.nents, DMA_TO_DEVICE);
+		dma_sync_sgtable_for_cpu(isp->dev, &req->table.sgt,
+					 DMA_TO_DEVICE);
 
 		if (copy_from_user(req->table.addr, config->lsc,
 				   req->config.size)) {
@@ -455,8 +455,8 @@ static int ccdc_lsc_config(struct isp_ccdc_device *ccdc,
 			goto done;
 		}
 
-		dma_sync_sg_for_device(isp->dev, req->table.sgt.sgl,
-				       req->table.sgt.nents, DMA_TO_DEVICE);
+		dma_sync_sgtable_for_device(isp->dev, &req->table.sgt,
+					    DMA_TO_DEVICE);
 	}
 
 	spin_lock_irqsave(&ccdc->lsc.req_lock, flags);
diff --git a/drivers/media/platform/ti/omap3isp/ispstat.c b/drivers/media/platform/ti/omap3isp/ispstat.c
index 359a846205b0..d3da68408ecb 100644
--- a/drivers/media/platform/ti/omap3isp/ispstat.c
+++ b/drivers/media/platform/ti/omap3isp/ispstat.c
@@ -161,8 +161,7 @@ static void isp_stat_buf_sync_for_device(struct ispstat *stat,
 	if (ISP_STAT_USES_DMAENGINE(stat))
 		return;
 
-	dma_sync_sg_for_device(stat->isp->dev, buf->sgt.sgl,
-			       buf->sgt.nents, DMA_FROM_DEVICE);
+	dma_sync_sgtable_for_device(stat->isp->dev, &buf->sgt, DMA_FROM_DEVICE);
 }
 
 static void isp_stat_buf_sync_for_cpu(struct ispstat *stat,
@@ -171,8 +170,7 @@ static void isp_stat_buf_sync_for_cpu(struct ispstat *stat,
 	if (ISP_STAT_USES_DMAENGINE(stat))
 		return;
 
-	dma_sync_sg_for_cpu(stat->isp->dev, buf->sgt.sgl,
-			    buf->sgt.nents, DMA_FROM_DEVICE);
+	dma_sync_sgtable_for_cpu(stat->isp->dev, &buf->sgt, DMA_FROM_DEVICE);
 }
 
 static void isp_stat_buf_clear(struct ispstat *stat)
-- 
2.34.1


