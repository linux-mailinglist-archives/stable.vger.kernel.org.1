Return-Path: <stable+bounces-43592-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF07F8C3689
	for <lists+stable@lfdr.de>; Sun, 12 May 2024 14:35:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D8B71F21F6A
	for <lists+stable@lfdr.de>; Sun, 12 May 2024 12:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01D2118641;
	Sun, 12 May 2024 12:35:50 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from wxsgout04.xfusion.com (wxsgout04.xfusion.com [36.139.87.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44FDF9445
	for <stable@vger.kernel.org>; Sun, 12 May 2024 12:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=36.139.87.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715517349; cv=none; b=Otfkwe7fPeTzrfOzuUclVXb9v3S1gMXuLvNFBHperZzaTh65Ufo6MohLCIC9r8VvXLmsDiUJS5frYJb1LdzUTuAzZFwm8fxUUY7msIpaA0xZVWb9w1YqbOXfgp+I4+ueow68Ewr0Y7XHsPr2AdDvZSWzOP8dmaINuO4HSm/eOQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715517349; c=relaxed/simple;
	bh=hShI9i/MxDROhw5ouvixjH+MmJ+PWoRJeFR2q+Uv5uA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ePaWkNP15Dg77Rtt+3U/xfVzkyq1CLHSujXyosb0AUx1pnanUPpbvw5pMVCDIzOWdqMjxYK1HsGkYiELxC+St/0Tf0bkMUYPeCL7Ic0AThWf5Ffe3/ih5Fap2Nho+xN+/kEwJ7mBM2A2yfV8b8HlVAPyGs89BD+Wjivg1z1hzYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xfusion.com; spf=pass smtp.mailfrom=xfusion.com; arc=none smtp.client-ip=36.139.87.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xfusion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xfusion.com
Received: from wuxshcsitd00600.xfusion.com (unknown [10.32.133.213])
	by wxsgout04.xfusion.com (SkyGuard) with ESMTPS id 4VchPW6YmdzB35qy;
	Sun, 12 May 2024 20:14:23 +0800 (CST)
Received: from wsip-70-182-158-199.br.br.cox.net (10.81.22.2) by
 wuxshcsitd00600.xfusion.com (10.32.133.213) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 12 May 2024 20:16:44 +0800
From: Wang Jinchao <wangjinchao@xfusion.com>
To: <wangjinchao@xfusion.com>
CC: Dave Airlie <airlied@redhat.com>, Dan Moulding <dan@danm.net>,
	<stable@vger.kernel.org>
Subject: [PATCH] Revert "drm/nouveau/firmware: Fix SG_DEBUG error with nvkm_firmware_ctor()"
Date: Sun, 12 May 2024 20:16:13 +0800
Message-ID: <20240512121630.23898-1-wangjinchao@xfusion.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: wuxshcsitd00602.xfusion.com (10.32.132.250) To
 wuxshcsitd00600.xfusion.com (10.32.133.213)

From: Dave Airlie <airlied@redhat.com>

This reverts commit 52a6947bf576b97ff8e14bb0a31c5eaf2d0d96e2.

This causes loading failures in
[    0.367379] nouveau 0000:01:00.0: NVIDIA GP104 (134000a1)
[    0.474499] nouveau 0000:01:00.0: bios: version 86.04.50.80.13
[    0.474620] nouveau 0000:01:00.0: pmu: firmware unavailable
[    0.474977] nouveau 0000:01:00.0: fb: 8192 MiB GDDR5
[    0.484371] nouveau 0000:01:00.0: sec2(acr): mbox 00000001 00000000
[    0.484377] nouveau 0000:01:00.0: sec2(acr):load: boot failed: -5
[    0.484379] nouveau 0000:01:00.0: acr: init failed, -5
[    0.484466] nouveau 0000:01:00.0: init failed with -5
[    0.484468] nouveau: DRM-master:00000000:00000080: init failed with -5
[    0.484470] nouveau 0000:01:00.0: DRM-master: Device allocation failed: -5
[    0.485078] nouveau 0000:01:00.0: probe with driver nouveau failed with error -50

I tried tracking it down but ran out of time this week, will revisit next week.

Reported-by: Dan Moulding <dan@danm.net>
Cc: stable@vger.kernel.org
Signed-off-by: Dave Airlie <airlied@redhat.com>
---
 drivers/gpu/drm/nouveau/nvkm/core/firmware.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/core/firmware.c b/drivers/gpu/drm/nouveau/nvkm/core/firmware.c
index 141b0a513bf5..adc60b25f8e6 100644
--- a/drivers/gpu/drm/nouveau/nvkm/core/firmware.c
+++ b/drivers/gpu/drm/nouveau/nvkm/core/firmware.c
@@ -205,9 +205,7 @@ nvkm_firmware_dtor(struct nvkm_firmware *fw)
 		break;
 	case NVKM_FIRMWARE_IMG_DMA:
 		nvkm_memory_unref(&memory);
-		dma_unmap_single(fw->device->dev, fw->phys, sg_dma_len(&fw->mem.sgl),
-				 DMA_TO_DEVICE);
-		kfree(fw->img);
+		dma_free_coherent(fw->device->dev, sg_dma_len(&fw->mem.sgl), fw->img, fw->phys);
 		break;
 	case NVKM_FIRMWARE_IMG_SGT:
 		nvkm_memory_unref(&memory);
@@ -237,17 +235,14 @@ nvkm_firmware_ctor(const struct nvkm_firmware_func *func, const char *name,
 		fw->img = kmemdup(src, fw->len, GFP_KERNEL);
 		break;
 	case NVKM_FIRMWARE_IMG_DMA: {
-		len = ALIGN(fw->len, PAGE_SIZE);
+		dma_addr_t addr;
 
-		fw->img = kmalloc(len, GFP_KERNEL);
-		if (!fw->img)
-			return -ENOMEM;
+		len = ALIGN(fw->len, PAGE_SIZE);
 
-		memcpy(fw->img, src, fw->len);
-		fw->phys = dma_map_single(fw->device->dev, fw->img, len, DMA_TO_DEVICE);
-		if (dma_mapping_error(fw->device->dev, fw->phys)) {
-			kfree(fw->img);
-			return -EFAULT;
+		fw->img = dma_alloc_coherent(fw->device->dev, len, &addr, GFP_KERNEL);
+		if (fw->img) {
+			memcpy(fw->img, src, fw->len);
+			fw->phys = addr;
 		}
 
 		sg_init_one(&fw->mem.sgl, fw->img, len);
-- 
2.45.0


