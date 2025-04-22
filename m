Return-Path: <stable+bounces-135144-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE827A97047
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 17:17:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC43F172633
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 15:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C517B2857C9;
	Tue, 22 Apr 2025 15:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mvista.com header.i=@mvista.com header.b="RB7+OfCG"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13FCEEBB
	for <stable@vger.kernel.org>; Tue, 22 Apr 2025 15:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745335042; cv=none; b=kMCqc3l5FQYjYHvCOBnA2TjKkzt0KUir5I4EVmhCekz6rhfOBLkyyTW5JXAq37CqLX1znC+wTJFgNRVt8efnHvpBBPc5gb4KjsT05jolFQ6gRuc4NAsVxhRaEzL/hFizf2XBPal36/h3cAMhq//imwtm6IdWusUv0Diiklpj9Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745335042; c=relaxed/simple;
	bh=lhEDCA6ryevSgMFUVRXltE7gVHUxsYeWvSl3vFFBy3Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jsk/psMwVDgSXObSOa2MxVIUs2b94iALGl/Ix1M8f8ZcML6i3N0eoSbB/xH2vIcowXtYAv2HFy8kVV3M7prHSaU0N2fAEY+2p368L7k8DpXXVAw/lXPCMqKabsTGPJVdUfBDt/WmHvucUd/2JWny8tqGAEBg2zJz3lUXcdrYmpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mvista.com; spf=pass smtp.mailfrom=mvista.com; dkim=pass (1024-bit key) header.d=mvista.com header.i=@mvista.com header.b=RB7+OfCG; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mvista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mvista.com
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-224191d92e4so52178985ad.3
        for <stable@vger.kernel.org>; Tue, 22 Apr 2025 08:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista.com; s=google; t=1745335039; x=1745939839; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cLmORHiDkWMQMVFrxaFecWSzQF9PxjI86pIsUSWMxpA=;
        b=RB7+OfCGEnDciw+f6OJQLPubdXvs7yK0rXM8w08LuUfVK30dI/9UqN4CUZGiqd3Mg6
         FcjbPg7siCW6w3kD93acUrOh6loZguoo3oFX33+YAfjkqR8boV3WS8iI3m6b22oboJMa
         L5xDU3XZvOwy0IZ/qkmfhowTMWoyG6wufP2fs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745335039; x=1745939839;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cLmORHiDkWMQMVFrxaFecWSzQF9PxjI86pIsUSWMxpA=;
        b=MCUo7gAtCfl8nWGSC+/0nobFU9d3LiFoJOjQpqQIO0XyMxB27YBrZfXofBiZCkWQ7P
         UbyRG/Z/zvI+hZOz6pVVguud1qgbk21Q1dP32nG47dXLPtfQZ+I6oSpytN1jdKKCjbiH
         tbRbkmULFLQR03JI96fnuvDWUCtnfzxo3LQ1k3L2HYeQF/AdgKsuxl0xITPnsOtH4qpg
         SgPufak5U/JyqqBVTEVGPdSGabc6I6HgfY3d9X0MCxVnt9a+NTv/n1zHMU8SkT/xy6pk
         d8ALONjehNWejFlWY0hVtzeL5tmWQniy7wpX1zE2lEypP8CKUMOoJK2rHpkyaeRknYws
         av5Q==
X-Gm-Message-State: AOJu0Yy85kOoQBjWKRlXRIT+nlZm02oJywqjgFBBdjjSvnyyWal2GWkn
	9SjyTe9WDGCr8eW6o3VfhzPljMYht2h6vG6z40ozW8Ge7u7RcWqZyitWhdrrNabG/GrI4ACV0Wa
	WznM7uA==
X-Gm-Gg: ASbGnctP2ORvsxImIZG0nTKA92Vd0eeiFrB22EPwUsZ69C9dmkgHTg96ku91raF9HET
	nMz50/MK+JomzEmAsRD5SJGmuQKfQh0CiSpADJPD6zmR5Gx3ahfd/CyaeVyblKqccPWE3i/yVD7
	SvP7iGYc/y0PjJ7CLXlq9qVUkZ/JvidA4B/KVeyZO6OhQbL4I9i0gAgn+tCZFw37HZ8Ax9/rcXR
	bh1IlLB5ZNnu4lb6L1neg8J/VtHGnu1kUzVFYaUIybopT8CHmVbRKvnMoWOiPlE+VE/U03hWrPG
	hNYt78FEp5urwsp53i2xygUM9+C8SrVYpdAapxR3NM0ptQ==
X-Google-Smtp-Source: AGHT+IF1uwiqNSBKvwpDLhjsUzzXla3pVam96durKo8HSMDc1VTkzPZS5jTr/tcyBw2vSFXkYV0YmA==
X-Received: by 2002:a17:902:ce01:b0:223:569d:9a8b with SMTP id d9443c01a7336-22c53580d1dmr198700565ad.18.1745335039677;
        Tue, 22 Apr 2025 08:17:19 -0700 (PDT)
Received: from testing.mvista.com ([182.74.28.237])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c50bdac14sm86563985ad.26.2025.04.22.08.17.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 08:17:19 -0700 (PDT)
From: Hardik Gohil <hgohil@mvista.com>
To: stable@vger.kernel.org
Cc: peter.ujfalusi@ti.com,
	vkoul@kernel.org,
	Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH 2/3 v5.4.y] dmaengine: ti: edma: add missed operations
Date: Tue, 22 Apr 2025 15:17:08 +0000
Message-Id: <20250422151709.26646-1-hgohil@mvista.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <2025042230-equation-mule-2f3d@gregkh>
References: <2025042230-equation-mule-2f3d@gregkh>
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
---
 drivers/dma/ti/edma.c | 37 ++++++++++++++++++++-----------------
 1 file changed, 20 insertions(+), 17 deletions(-)

diff --git a/drivers/dma/ti/edma.c b/drivers/dma/ti/edma.c
index 756a3c951dc7..0628ee4bf1b4 100644
--- a/drivers/dma/ti/edma.c
+++ b/drivers/dma/ti/edma.c
@@ -2289,13 +2289,6 @@ static int edma_probe(struct platform_device *pdev)
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
@@ -2326,27 +2319,31 @@ static int edma_probe(struct platform_device *pdev)
 
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
@@ -2388,7 +2385,7 @@ static int edma_probe(struct platform_device *pdev)
 				       ecc);
 		if (ret) {
 			dev_err(dev, "CCINT (%d) failed --> %d\n", irq, ret);
-			return ret;
+			goto err_disable_pm;
 		}
 		ecc->ccint = irq;
 	}
@@ -2404,7 +2401,7 @@ static int edma_probe(struct platform_device *pdev)
 				       ecc);
 		if (ret) {
 			dev_err(dev, "CCERRINT (%d) failed --> %d\n", irq, ret);
-			return ret;
+			goto err_disable_pm;
 		}
 		ecc->ccerrint = irq;
 	}
@@ -2412,7 +2409,8 @@ static int edma_probe(struct platform_device *pdev)
 	ecc->dummy_slot = edma_alloc_slot(ecc, EDMA_SLOT_ANY);
 	if (ecc->dummy_slot < 0) {
 		dev_err(dev, "Can't allocate PaRAM dummy slot\n");
-		return ecc->dummy_slot;
+		ret = ecc->dummy_slot;
+		goto err_disable_pm;
 	}
 
 	queue_priority_mapping = info->queue_priority_mapping;
@@ -2512,6 +2510,9 @@ static int edma_probe(struct platform_device *pdev)
 
 err_reg1:
 	edma_free_slot(ecc, ecc->dummy_slot);
+err_disable_pm:
+	pm_runtime_put_sync(dev);
+	pm_runtime_disable(dev);
 	return ret;
 }
 
@@ -2542,6 +2543,8 @@ static int edma_remove(struct platform_device *pdev)
 	if (ecc->dma_memcpy)
 		dma_async_device_unregister(ecc->dma_memcpy);
 	edma_free_slot(ecc, ecc->dummy_slot);
+	pm_runtime_put_sync(dev);
+	pm_runtime_disable(dev);
 
 	return 0;
 }
-- 
2.25.1


