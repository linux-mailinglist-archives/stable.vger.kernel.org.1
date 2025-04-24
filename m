Return-Path: <stable+bounces-136509-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA266A9A0E0
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 08:07:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F6EB5A0B1E
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 06:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE24D1B043E;
	Thu, 24 Apr 2025 06:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mvista.com header.i=@mvista.com header.b="U98o6Zd6"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF062701B8
	for <stable@vger.kernel.org>; Thu, 24 Apr 2025 06:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745474857; cv=none; b=tHuRgjy+zPSdfq39lJyXVJbE8NIqcOnSLlYrNmnrd5Fl+WR3rYmKJpzKwydVi7N1o+cPqytByJIYPN9wqPSYSxMTpZIo6jjLJzQMRhHRkt4cpiaFMKmbxY8tCABFk1I3YBntbZE7aaQfQzzHo2o/PbZ0la+LPvEdr+E5psLesX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745474857; c=relaxed/simple;
	bh=0b/R1nHY7V4R4VF6eol3AP60XK3eHsDrsVpfr3ILhgQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BFd7pvnamic87uMfn80kO87luwsekEPuROxrw5l08vMFCxhLSspISyGcVDgMKP76eLpA1G9o5bIvBNZFtINELCJ6DM7kJr5ukMNUkyaJ5eb4u/eazQ/ZXfjq+EK6+WXFo0wJc+nanXc17WawGHXoCWPz4yI5OFi8MTt6Cp+i2Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mvista.com; spf=pass smtp.mailfrom=mvista.com; dkim=pass (1024-bit key) header.d=mvista.com header.i=@mvista.com header.b=U98o6Zd6; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mvista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mvista.com
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-7376e311086so741136b3a.3
        for <stable@vger.kernel.org>; Wed, 23 Apr 2025 23:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista.com; s=google; t=1745474855; x=1746079655; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YlKSisneaOipm06EHw6Ecrusi3Y8yxs4Gfk7bO22X1U=;
        b=U98o6Zd6DYXQW4Gpagiefc7DkcMGox9bRIXdAtH/8/tWgEC2b8HwIMQDxEorv9fNmb
         vkDkyY8e7aZ9GRaegDlY7Ka0gRxktv6QoGZpDiM99zlw/PvP/haOqhRDeYxLdM7OxTY1
         oLJeLdKgmhZAB0/1oyAI0jkJLWHfKMigXJ49c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745474855; x=1746079655;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YlKSisneaOipm06EHw6Ecrusi3Y8yxs4Gfk7bO22X1U=;
        b=TFRHF5FjkOVeyxXFNEHlF732IIzUYUSQY1IDeGbK+In1wqjDAOG+kJaD4akX61Degn
         HDA5+kTMowvHPnl8vPwKqFTT4fEyX4Y6rhfmSYFhQacihsWtvvjYwkAsu0mKHC+iD9Wl
         XYrK3w5q5glYYCY00SL+SVxk5SsoC93rKjKGRvTPkthytcgqR57uNlrvv5hC7ydVAw90
         uAdIzsOoWTQlGpLajymPizDxPmrndMTKjatUUp6zufhp6Npx0VPxWkjCL92ru4sj/9Mt
         gihynrqf4alGM/brlXu9k/7LwB5LDyqiSJX+qgQbn6BuW09Nif+sVC/dzH6UVhZDG8Jn
         oJmQ==
X-Gm-Message-State: AOJu0Yz3au8/G/fvzgYmmIl0TWsZCAaB2E9isWwjeF25VsRfHgZDSAEk
	LY4AH+KzBaiDx+ZChVXRd0xxdzbDnhFYwwha5xGi/y4uZaXTt2ewkaaqSDBjpbbMK9l5jJFZ4Wq
	TzhrMAQ==
X-Gm-Gg: ASbGncsK2z5lpYLWy054+WFrX4xVzHwfoiexvgR6wI2F73M3errskBGAeZMt0I8tkhn
	CnT+gbhEPsQQLKjae17pDteGSa6Q0ccfp9GL6qx1zW3nVwPD6B5QgE9YUV0DMHVtFvtPWHUI3EZ
	EvkN3r67sBkLVNcTrhZgrM/FlhxoDOx0FjhRXQwM4rZt6zxUo2dVQGJipykDUIsZ0Jhd6EjTAR6
	te2CRNc5zsj6D6MuKtw5rcBxqcMYghKPl8JIOibX8ZQ3YcYYpCFkTncqzn4azlIi1fQrKLzo+ma
	gu4KnSAT0QWb2JWlmDjugu2gtNlNL4LTyR+uNul+njQpGg==
X-Google-Smtp-Source: AGHT+IFJeYNmT4WRvwEalUB3hnJpbhhTuWKYOVULgHnhCelKEeyK60P6QMYVmhr7yHLf7dR8CcIQ3Q==
X-Received: by 2002:a05:6a00:391b:b0:737:6e1f:29da with SMTP id d2e1a72fcca58-73e24e05a1cmr2179235b3a.21.1745474854718;
        Wed, 23 Apr 2025 23:07:34 -0700 (PDT)
Received: from testing.mvista.com ([182.74.28.237])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73e25912bf3sm600512b3a.32.2025.04.23.23.07.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 23:07:34 -0700 (PDT)
From: Hardik Gohil <hgohil@mvista.com>
To: stable@vger.kernel.org
Cc: peter.ujfalusi@ti.com,
	vkoul@kernel.org,
	Chuhong Yuan <hslester96@gmail.com>,
	Hardik Gohil <hgohil@mvista.com>
Subject: [PATCH 2/3 v5.4.y] dmaengine: ti: edma: add missed operations
Date: Thu, 24 Apr 2025 06:06:33 +0000
Message-Id: <20250424060634.50722-1-hgohil@mvista.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <2025042315-tamer-gaffe-8de0@gregkh>
References: <2025042315-tamer-gaffe-8de0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuhong Yuan <hslester96@gmail.com>

The driver forgets to call pm_runtime_disable and pm_runtime_put_sync in
probe failure and remove.
Add the calls and modify probe failure handling to fix it.

To simplify the fix, the patch adjusts the calling order and merges checks
for devm_kcalloc.

Fixes: 2b6b3b742019 ("ARM/dmaengine: edma: Merge the two drivers under drivers/dma/")
Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Link: https://lore.kernel.org/r/20191124052855.6472-1-hslester96@gmail.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Hardik Gohil <hgohil@mvista.com>
---
 drivers/dma/ti/edma.c | 37 ++++++++++++++++++++-----------------
 1 file changed, 20 insertions(+), 17 deletions(-)

diff --git a/drivers/dma/ti/edma.c b/drivers/dma/ti/edma.c
index 47423bbd7bc7..4fea8688b596 100644
--- a/drivers/dma/ti/edma.c
+++ b/drivers/dma/ti/edma.c
@@ -2290,13 +2290,6 @@ static int edma_probe(struct platform_device *pdev)
 	if (!info)
 		return -ENODEV;
 
-	pm_runtime_enable(dev);
-	ret = pm_runtime_get_sync(dev);
-	if (ret < 0) {
-		dev_err(dev, "pm_runtime_get_sync() failed\n");
-		return ret;
-	}
-
 	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
 	if (ret)
 		return ret;
@@ -2327,27 +2320,31 @@ static int edma_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, ecc);
 
+	pm_runtime_enable(dev);
+	ret = pm_runtime_get_sync(dev);
+	if (ret < 0) {
+		dev_err(dev, "pm_runtime_get_sync() failed\n");
+		pm_runtime_disable(dev);
+		return ret;
+	}
+
 	/* Get eDMA3 configuration from IP */
 	ret = edma_setup_from_hw(dev, info, ecc);
 	if (ret)
-		return ret;
+		goto err_disable_pm;
 
 	/* Allocate memory based on the information we got from the IP */
 	ecc->slave_chans = devm_kcalloc(dev, ecc->num_channels,
 					sizeof(*ecc->slave_chans), GFP_KERNEL);
-	if (!ecc->slave_chans)
-		return -ENOMEM;
 
 	ecc->slot_inuse = devm_kcalloc(dev, BITS_TO_LONGS(ecc->num_slots),
 				       sizeof(unsigned long), GFP_KERNEL);
-	if (!ecc->slot_inuse)
-		return -ENOMEM;
 
 	ecc->channels_mask = devm_kcalloc(dev,
 					   BITS_TO_LONGS(ecc->num_channels),
 					   sizeof(unsigned long), GFP_KERNEL);
-	if (!ecc->channels_mask)
-		return -ENOMEM;
+	if (!ecc->slave_chans || !ecc->slot_inuse || !ecc->channels_mask)
+		goto err_disable_pm;
 
 	/* Mark all channels available initially */
 	bitmap_fill(ecc->channels_mask, ecc->num_channels);
@@ -2397,7 +2394,7 @@ static int edma_probe(struct platform_device *pdev)
 				       ecc);
 		if (ret) {
 			dev_err(dev, "CCINT (%d) failed --> %d\n", irq, ret);
-			return ret;
+			goto err_disable_pm;
 		}
 		ecc->ccint = irq;
 	}
@@ -2413,7 +2410,7 @@ static int edma_probe(struct platform_device *pdev)
 				       ecc);
 		if (ret) {
 			dev_err(dev, "CCERRINT (%d) failed --> %d\n", irq, ret);
-			return ret;
+			goto err_disable_pm;
 		}
 		ecc->ccerrint = irq;
 	}
@@ -2421,7 +2418,8 @@ static int edma_probe(struct platform_device *pdev)
 	ecc->dummy_slot = edma_alloc_slot(ecc, EDMA_SLOT_ANY);
 	if (ecc->dummy_slot < 0) {
 		dev_err(dev, "Can't allocate PaRAM dummy slot\n");
-		return ecc->dummy_slot;
+		ret = ecc->dummy_slot;
+		goto err_disable_pm;
 	}
 
 	queue_priority_mapping = info->queue_priority_mapping;
@@ -2521,6 +2519,9 @@ static int edma_probe(struct platform_device *pdev)
 
 err_reg1:
 	edma_free_slot(ecc, ecc->dummy_slot);
+err_disable_pm:
+	pm_runtime_put_sync(dev);
+	pm_runtime_disable(dev);
 	return ret;
 }
 
@@ -2551,6 +2552,8 @@ static int edma_remove(struct platform_device *pdev)
 	if (ecc->dma_memcpy)
 		dma_async_device_unregister(ecc->dma_memcpy);
 	edma_free_slot(ecc, ecc->dummy_slot);
+	pm_runtime_put_sync(dev);
+	pm_runtime_disable(dev);
 
 	return 0;
 }
-- 
2.25.1


