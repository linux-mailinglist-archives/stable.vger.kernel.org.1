Return-Path: <stable+bounces-159026-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 455FFAEE8D0
	for <lists+stable@lfdr.de>; Mon, 30 Jun 2025 23:00:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D874C44236C
	for <lists+stable@lfdr.de>; Mon, 30 Jun 2025 20:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABDED28C031;
	Mon, 30 Jun 2025 20:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d3CRPkfj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6533C23497B;
	Mon, 30 Jun 2025 20:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751317177; cv=none; b=nRZazKiDfz5DGJlh/9ib+vbwltc48kKXLUSvBbS01uOjRP6CN+kr2RgCAxjTmkA4V1lB9Tt5WE4B5/4WA1/KgqF3gI0uEE0i5YPRvEQxhM/+idaW/wS9E3LfOlqJgLaKMOXezPkeNQDfc+QaAYWu+pS+8ps12+Mz7ngrb6Ugau0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751317177; c=relaxed/simple;
	bh=0qprEGj29hPGczkpEiGBUq79+GLeNUl8SGPoZBPJ1+s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gnY3FglqlMGoklq2mnKlI3JhieQclL7FVHwBZuijW3L7DBRSHV/x4eDSRNQ0PUoFT2Zt9U1eO+6Pq0aDJKLc9n9S0FdtiRSIdoAzWMFDsrThndQjmZq1BYQUauw3YmK5mSpauYAKqnPXGe7/tKg0ROOC0+oCTQW4XMlTTMHss0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d3CRPkfj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 096DCC4CEEB;
	Mon, 30 Jun 2025 20:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751317177;
	bh=0qprEGj29hPGczkpEiGBUq79+GLeNUl8SGPoZBPJ1+s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d3CRPkfjUBNRtCcmJmYG6dihoInqqenIHt1ZonwSMzLcwwwODcdYMQ/GHd4STCGg6
	 ZWnvToSugMinUr7HQ2SqFSbjbhFzm9Prfoaz1Zkxb8a2hcsSF+mlrRa+VURyyYGjp5
	 itU+VfOJXvSE9P6T9m2iljybWaKAMlQZWk0gthUwcH5Z97ugL/c0eacWIL3Tn5qGuZ
	 ZvOui2Vd3gtDBlDIUD3X9KNiZSUr4MAIPCtcbkKNqXNBodNMjFnVMcH7f+bKiM9b62
	 ON8iYSy1al+d/ZAz//PdFcDSEXKUGg2flp6JAFewppJ2P6j/XprQGHexihlJ+ae2C2
	 sPA3AUoZwfwIw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Thomas Fourier <fourier.thomas@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	3chas3@gmail.com,
	linux-atm-general@lists.sourceforge.net,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 02/21] atm: idt77252: Add missing `dma_map_error()`
Date: Mon, 30 Jun 2025 16:45:17 -0400
Message-Id: <20250630204536.1358327-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250630204536.1358327-1-sashal@kernel.org>
References: <20250630204536.1358327-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.35
Content-Transfer-Encoding: 8bit

From: Thomas Fourier <fourier.thomas@gmail.com>

[ Upstream commit c4890963350dcf4e9a909bae23665921fba4ad27 ]

The DMA map functions can fail and should be tested for errors.

Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20250624064148.12815-3-fourier.thomas@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

**YES**

This commit should be backported to stable kernel trees.

## Detailed Analysis:

**Nature of the fix:**
The commit adds missing error checking for `dma_map_single()` calls in
two locations within the idt77252 ATM driver:

1. **In `queue_skb()` function (line 853-854):**
  ```c
  IDT77252_PRV_PADDR(skb) = dma_map_single(&card->pcidev->dev,
  skb->data,
  skb->len, DMA_TO_DEVICE);
  +if (dma_mapping_error(&card->pcidev->dev, IDT77252_PRV_PADDR(skb)))
  +    return -ENOMEM;
  ```
  This correctly returns -ENOMEM before reaching the errout label,
  avoiding any cleanup issues since the DMA mapping never succeeded.

2. **In `add_rx_skb()` function (line 1857-1860):**
  ```c
  paddr = dma_map_single(&card->pcidev->dev, skb->data,
  skb_end_pointer(skb) - skb->data,
  DMA_FROM_DEVICE);
  +if (dma_mapping_error(&card->pcidev->dev, paddr))
  +    goto outpoolrm;
  ```
  This properly jumps to the new `outpoolrm` label which removes the SKB
  from the pool before freeing it, maintaining correct cleanup order.

**Why this qualifies for stable backporting:**

1. **Fixes a real bug**: Missing DMA mapping error checks can cause
   system crashes or data corruption, especially on systems with IOMMU
   or SWIOTLB where DMA mapping failures are more likely.

2. **Simple and contained**: The fix adds only 5 lines of error checking
   code with no architectural changes.

3. **Similar to approved backports**: This follows the exact same
   pattern as Similar Commits #1 (eni driver) and #2 (aic94xx driver)
   which were both marked "YES" for backporting.

4. **Long-standing issue**: The driver has existed since at least 2005
   (Linux 2.6.12-rc2), meaning this bug has been present for nearly 20
   years.

5. **Minimal regression risk**: The changes only add error checking;
   they don't modify any existing logic paths.

6. **Proper error handling**: Both error paths are correctly implemented
   with appropriate cleanup sequences.

The commit clearly meets all stable tree criteria as an important bug
fix with minimal risk and should be backported to protect users from
potential DMA-related crashes.

 drivers/atm/idt77252.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/atm/idt77252.c b/drivers/atm/idt77252.c
index a876024d8a05f..63d41320cd5cf 100644
--- a/drivers/atm/idt77252.c
+++ b/drivers/atm/idt77252.c
@@ -852,6 +852,8 @@ queue_skb(struct idt77252_dev *card, struct vc_map *vc,
 
 	IDT77252_PRV_PADDR(skb) = dma_map_single(&card->pcidev->dev, skb->data,
 						 skb->len, DMA_TO_DEVICE);
+	if (dma_mapping_error(&card->pcidev->dev, IDT77252_PRV_PADDR(skb)))
+		return -ENOMEM;
 
 	error = -EINVAL;
 
@@ -1857,6 +1859,8 @@ add_rx_skb(struct idt77252_dev *card, int queue,
 		paddr = dma_map_single(&card->pcidev->dev, skb->data,
 				       skb_end_pointer(skb) - skb->data,
 				       DMA_FROM_DEVICE);
+		if (dma_mapping_error(&card->pcidev->dev, paddr))
+			goto outpoolrm;
 		IDT77252_PRV_PADDR(skb) = paddr;
 
 		if (push_rx_skb(card, skb, queue)) {
@@ -1871,6 +1875,7 @@ add_rx_skb(struct idt77252_dev *card, int queue,
 	dma_unmap_single(&card->pcidev->dev, IDT77252_PRV_PADDR(skb),
 			 skb_end_pointer(skb) - skb->data, DMA_FROM_DEVICE);
 
+outpoolrm:
 	handle = IDT77252_PRV_POOL(skb);
 	card->sbpool[POOL_QUEUE(handle)].skb[POOL_INDEX(handle)] = NULL;
 
-- 
2.39.5


