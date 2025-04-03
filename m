Return-Path: <stable+bounces-127770-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D05A7AAD9
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 21:16:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE6C4189981C
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 19:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 340A125EFAB;
	Thu,  3 Apr 2025 19:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XKlrhCll"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E375B255236;
	Thu,  3 Apr 2025 19:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707053; cv=none; b=IN0n07IIQjQTi0HckahjF90vnI3bjsx1Kf6QrQuTf3x1/bB+1Uut9ppsqiUFnfNorRuXRUWpsU97n4XCJgZFj/4NWtM7tJSSk6f9EKDickTerxZCU6Yc5tD9N8plaDn0w3qqJm8rIj5nncpqKmLKNYMS8GfK0LaUaSM0Pdsmvtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707053; c=relaxed/simple;
	bh=/t8vcH3qynDQfOLkw7QMZ8Gv/WuYDCcCpzwNN7E5DRU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qTHCg+vP2IERZELEG6s+6jcNacJrD9N8SPiqzj+81ZspP6T1wNsnZqyQHMd93fsJCsuWFM85rm6b7edcjMNGHEU+FeO7VF0HK3ErV2AJ88ssqN6ULL5X4OEoJg7mVJFISoFpADoCx7IDV108yxX7OwTbv+lC3lho5GJs7KhZw9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XKlrhCll; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80F88C4CEE3;
	Thu,  3 Apr 2025 19:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707052;
	bh=/t8vcH3qynDQfOLkw7QMZ8Gv/WuYDCcCpzwNN7E5DRU=;
	h=From:To:Cc:Subject:Date:From;
	b=XKlrhCllBpd6lApHwNFlnFV+IPcGn5oE9FZEDOD305ypims0Lp+Toobb3k7FiJ881
	 Ulbb+FegmJM9O2IGnoXIT6ciRZnV6V++0ZAYZRO4fpN1j91G8++eUYeJRrWdJk+PrV
	 Is0IiW+qRjPhTW63kbtk+rgkqqqbtCv7HsL2mDiIl1orvn0TLixChLpBFu8TT1G4+4
	 yhB2bM5PSCVoeVYVex0QJtUgBXxavXE8mcUBXZRU1mc/9hHOLGoLFyo1b13wvUX1kD
	 l5kI0Bn4oWmGtfgXjlLJFlNsJRhEe+YmLa2gSAXbwv22N4vrZ7qFdor+iJTFK6M5Lz
	 DU5vqYj6KFJNw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: P Praneesh <quic_ppranees@quicinc.com>,
	Tim Harvey <tharvey@gateworks.com>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>,
	jjohnson@kernel.org,
	ath11k@lists.infradead.org
Subject: [PATCH AUTOSEL 6.13 01/49] wifi: ath11k: Fix DMA buffer allocation to resolve SWIOTLB issues
Date: Thu,  3 Apr 2025 15:03:20 -0400
Message-Id: <20250403190408.2676344-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.9
Content-Transfer-Encoding: 8bit

From: P Praneesh <quic_ppranees@quicinc.com>

[ Upstream commit 1bcd20981834928ccc5d981aacb806bb523d8b29 ]

Currently, the driver allocates cacheable DMA buffers for rings like
HAL_REO_DST and HAL_WBM2SW_RELEASE. The buffers for HAL_WBM2SW_RELEASE
are large (1024 KiB), exceeding the SWIOTLB slot size of 256 KiB. This
leads to "swiotlb buffer is full" error messages on systems without an
IOMMU that use SWIOTLB, causing driver initialization failures. The driver
calls dma_map_single() with these large buffers obtained from kzalloc(),
resulting in ring initialization errors on systems without an IOMMU that
use SWIOTLB.

To address these issues, replace the flawed buffer allocation mechanism
with the appropriate DMA API. Specifically, use dma_alloc_noncoherent()
for cacheable DMA buffers, ensuring proper freeing of buffers with
dma_free_noncoherent().

Error log:
[   10.194343] ath11k_pci 0000:04:00.0: swiotlb buffer is full (sz:1048583 bytes), total 32768 (slots), used 2529 (slots)
[   10.194406] ath11k_pci 0000:04:00.0: failed to set up tcl_comp ring (0) :-12
[   10.194781] ath11k_pci 0000:04:00.0: failed to init DP: -12

Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1
Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3

Reported-by: Tim Harvey <tharvey@gateworks.com>
Closes: https://lore.kernel.org/all/20241210041133.GA17116@lst.de/
Signed-off-by: P Praneesh <quic_ppranees@quicinc.com>
Tested-by: Tim Harvey <tharvey@gateworks.com>
Link: https://patch.msgid.link/20250119164219.647059-2-quic_ppranees@quicinc.com
Signed-off-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath11k/dp.c | 35 +++++++++-------------------
 1 file changed, 11 insertions(+), 24 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/dp.c b/drivers/net/wireless/ath/ath11k/dp.c
index fbf666d0ecf1d..f124b7329e1ac 100644
--- a/drivers/net/wireless/ath/ath11k/dp.c
+++ b/drivers/net/wireless/ath/ath11k/dp.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #include <crypto/hash.h>
@@ -104,14 +104,12 @@ void ath11k_dp_srng_cleanup(struct ath11k_base *ab, struct dp_srng *ring)
 	if (!ring->vaddr_unaligned)
 		return;
 
-	if (ring->cached) {
-		dma_unmap_single(ab->dev, ring->paddr_unaligned, ring->size,
-				 DMA_FROM_DEVICE);
-		kfree(ring->vaddr_unaligned);
-	} else {
+	if (ring->cached)
+		dma_free_noncoherent(ab->dev, ring->size, ring->vaddr_unaligned,
+				     ring->paddr_unaligned, DMA_FROM_DEVICE);
+	else
 		dma_free_coherent(ab->dev, ring->size, ring->vaddr_unaligned,
 				  ring->paddr_unaligned);
-	}
 
 	ring->vaddr_unaligned = NULL;
 }
@@ -249,25 +247,14 @@ int ath11k_dp_srng_setup(struct ath11k_base *ab, struct dp_srng *ring,
 		default:
 			cached = false;
 		}
-
-		if (cached) {
-			ring->vaddr_unaligned = kzalloc(ring->size, GFP_KERNEL);
-			if (!ring->vaddr_unaligned)
-				return -ENOMEM;
-
-			ring->paddr_unaligned = dma_map_single(ab->dev,
-							       ring->vaddr_unaligned,
-							       ring->size,
-							       DMA_FROM_DEVICE);
-			if (dma_mapping_error(ab->dev, ring->paddr_unaligned)) {
-				kfree(ring->vaddr_unaligned);
-				ring->vaddr_unaligned = NULL;
-				return -ENOMEM;
-			}
-		}
 	}
 
-	if (!cached)
+	if (cached)
+		ring->vaddr_unaligned = dma_alloc_noncoherent(ab->dev, ring->size,
+							      &ring->paddr_unaligned,
+							      DMA_FROM_DEVICE,
+							      GFP_KERNEL);
+	else
 		ring->vaddr_unaligned = dma_alloc_coherent(ab->dev, ring->size,
 							   &ring->paddr_unaligned,
 							   GFP_KERNEL);
-- 
2.39.5


