Return-Path: <stable+bounces-44392-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76CE78C52A1
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 13:39:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C27D1F21FB9
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 11:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2798613FD9C;
	Tue, 14 May 2024 11:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YQRpAbjx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C774F1E5;
	Tue, 14 May 2024 11:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715686019; cv=none; b=XhWcbqHvVi3QxkG5UmaIoN5gP9nHi2XNnGCDOhET8SgWJjOpxHM3XSbxdWJPf5g8frmfQzjb4ppDQ9Cq+UObODeIKNvpXiYXXlBRxjyigeL/WwCsOLnvzx8nX7GkYSD1BwlV1QHW4sM7sUlFSNetGVjAFc3baGu3SLGA7Bb1x1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715686019; c=relaxed/simple;
	bh=DAwwgOELdP+fjFQLOMwWfB3qhWZLqDbdGBeQ7lJl3y8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ES89+61ggsTC3bROm0606ZEb1j06Sq+Ky3I60CBk0X+Tw0pKhkNxFPBZceuwlXK4EaMs/oPTVCqe8veHtnFR5TVmamcPTDX9SFA71QsToUOZym6fwuwbCqOvn9vWLNL/DwiOGNpzBJtFopUd4R+OldieaF3w2601xk0MJ5wKiCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YQRpAbjx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1278C2BD10;
	Tue, 14 May 2024 11:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715686019;
	bh=DAwwgOELdP+fjFQLOMwWfB3qhWZLqDbdGBeQ7lJl3y8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YQRpAbjxbMwkR3uZrhVFjXS2ZhtiQ43Bus9jQU9q57PZj0i7438gwxEIOiPyHqHbw
	 4BBY5jrMs66e3dwAQRB2dxkVY7Gz8aTDSkpL1G+zisNl1ZvM+TerWe4kerKJ78YuqA
	 VY9UYxqn3b0LgoiISkThQ+72QP69FvWH8IGwuxpY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dan Moulding <dan@danm.net>,
	Dave Airlie <airlied@redhat.com>
Subject: [PATCH 6.6 267/301] Revert "drm/nouveau/firmware: Fix SG_DEBUG error with nvkm_firmware_ctor()"
Date: Tue, 14 May 2024 12:18:58 +0200
Message-ID: <20240514101042.344516025@linuxfoundation.org>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240514101032.219857983@linuxfoundation.org>
References: <20240514101032.219857983@linuxfoundation.org>
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

From: Dave Airlie <airlied@redhat.com>

commit a222a6470d7eea91193946e8162066fa88da64c2 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/nouveau/nvkm/core/firmware.c |   19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

--- a/drivers/gpu/drm/nouveau/nvkm/core/firmware.c
+++ b/drivers/gpu/drm/nouveau/nvkm/core/firmware.c
@@ -187,9 +187,7 @@ nvkm_firmware_dtor(struct nvkm_firmware
 		break;
 	case NVKM_FIRMWARE_IMG_DMA:
 		nvkm_memory_unref(&memory);
-		dma_unmap_single(fw->device->dev, fw->phys, sg_dma_len(&fw->mem.sgl),
-				 DMA_TO_DEVICE);
-		kfree(fw->img);
+		dma_free_coherent(fw->device->dev, sg_dma_len(&fw->mem.sgl), fw->img, fw->phys);
 		break;
 	default:
 		WARN_ON(1);
@@ -213,17 +211,14 @@ nvkm_firmware_ctor(const struct nvkm_fir
 		fw->img = kmemdup(src, fw->len, GFP_KERNEL);
 		break;
 	case NVKM_FIRMWARE_IMG_DMA: {
+		dma_addr_t addr;
+
 		len = ALIGN(fw->len, PAGE_SIZE);
 
-		fw->img = kmalloc(len, GFP_KERNEL);
-		if (!fw->img)
-			return -ENOMEM;
-
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



