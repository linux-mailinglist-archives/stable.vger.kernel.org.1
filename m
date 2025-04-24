Return-Path: <stable+bounces-136512-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6707AA9A106
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 08:09:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0FE7C7AAD2D
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 06:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6FD91DED40;
	Thu, 24 Apr 2025 06:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mvista.com header.i=@mvista.com header.b="GGcZ3FcQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A692701B8
	for <stable@vger.kernel.org>; Thu, 24 Apr 2025 06:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745474952; cv=none; b=QZKVMRDPDiSpLRKcQ/n5fFhGYX6rElv1J+cM7OLkmBbL4INz/nXK4jluhZEmgJ+4uLPyYNiCkcNQbjkNPwCr267KEBzpjHmfQLwqRRmFlwg+hLi+riEMzlt9MGHjnLqbpgLxrFGDaHoTfZli/5zh+rNb8Ws0zYgYL9SbXmMtNV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745474952; c=relaxed/simple;
	bh=gLFSpYmD8ONSJbnQBJYLOWFVUctx7f/baNXQ2NpJp7I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T2W7NSTkqQkJa2kLNdxcDTi+gb8BoG32lJMW/R03fZ3Mj4xkdTmo3V37qqEW+t1udGYe/G4iuGmvTo5Lx8REnndWVMccN6Fk7eUJLiSvuLOjubG122g8x2HWkIX3XX5BIEd3LOtm2ulmL6feipC4YaKpiuN6t/wkexQFRX1s9v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mvista.com; spf=pass smtp.mailfrom=mvista.com; dkim=pass (1024-bit key) header.d=mvista.com header.i=@mvista.com header.b=GGcZ3FcQ; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mvista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mvista.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-225df540edcso18809835ad.0
        for <stable@vger.kernel.org>; Wed, 23 Apr 2025 23:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista.com; s=google; t=1745474949; x=1746079749; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EQ7Q9tjvr7nUGClVHmNZzE4OnV7iE8hbak84x1umV64=;
        b=GGcZ3FcQ/7tnNQE0JGp9IFPXxZ1p7hrnbEIVsPxFK+O4MIbbnckAl/+U/YZFRWgd/l
         Maj707OHXFhOgwClXePqRK2PiP4BqPfkYW02+Dci3IE0XV7Nq3LeqDd/ntJM9AfBQaAi
         2pHhWOPDJ4GjcPGggvBsac6awp6pw47hsTMT0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745474949; x=1746079749;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EQ7Q9tjvr7nUGClVHmNZzE4OnV7iE8hbak84x1umV64=;
        b=WEWA0Sp0wyT6O1vTN7JY3mjoJSC+nWdL/kGd76vU553DqhJE9hfIzCgMgyrc5vMPRu
         NZPVJTGhKdbraGTKBNfkjLqi4Y6WqpLGFm0gIGr73LUyjhrgi/5DD3PsU3KOs0V36/9i
         Dp1Yc6N3nMhKSSozztUr2WdulL8vP49FHsC2wZUy2xHg0tKyhVPiZDcESrnZU7k2l91E
         w24hgYd7uvvhLwGrco9/PSXH7aC6Op+i66IGlfuFGEzkuxvI+01p6/PfNOnjvJ43r59M
         7goYmX+leDTBRsCo359NYoJ/HHwFEdyHARNMbl45Js7UJaG73NIaumzElfxqWP4kHLla
         ST2A==
X-Gm-Message-State: AOJu0Yw0yL6oUikcnFhTI59rlYTXcL15xxuMntUe22JpNVu8gI/5Cl8q
	dA9Tx8T1pnMgEaStZGlOImIgIxwOplbdq53RnOf6zKYkl57hPdZi7ebi+K0IFLJTTAjggfB9U6A
	sdAhAhg==
X-Gm-Gg: ASbGncsz6J50u3QKV8qQzKS/1uFeQ2ErlQtqcs/jujYYibbcSNgT0eeuCu8NkmEFHS9
	+LeGTwEMF4348KXkEJrcfOwlO7sUTOvyi12d7rNOwdCLHSGUALfcbMxvfP+w+21XKsMYu8Ioptr
	ClY3epemWsdxuHPSeONnNvLBgsTak1WY9GYkKLrBInZhQOpbzuJShEPsf3xCsKsor6hJjsq9ky+
	ynxecYvVKdUZ8lMlk54JuSZaw1LPj+eBHpgwGpJ6pvjNA2cCjlWHlZTzQ8Xc9S3yWFb8cMzZVZY
	thdLzaGD1WPuoJ2yhIRDY/1FmzDmBnrKjN4zkplTUQXZoQ==
X-Google-Smtp-Source: AGHT+IEmzVLGLtsqsVh2LWaFj6w9NMgjXrUYFR/8IU1Yd1UQVVhK4FrxkCJDMpIH708V94maqy3NwA==
X-Received: by 2002:a17:902:cf0b:b0:224:7a4:b31 with SMTP id d9443c01a7336-22db47e4848mr14066715ad.6.1745474948963;
        Wed, 23 Apr 2025 23:09:08 -0700 (PDT)
Received: from testing.mvista.com ([182.74.28.237])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db4db99d3sm4922615ad.53.2025.04.23.23.09.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 23:09:08 -0700 (PDT)
From: Hardik Gohil <hgohil@mvista.com>
To: stable@vger.kernel.org
Cc: peter.ujfalusi@ti.com,
	vkoul@kernel.org,
	Hardik Gohil <hgohil@mvista.com>
Subject: [PATCH 1/3 v5.4.y] dmaengine: ti: edma: Add support for handling reserved channels
Date: Thu, 24 Apr 2025 06:08:54 +0000
Message-Id: <20250424060854.50783-1-hgohil@mvista.com>
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

From: Peter Ujfalusi <peter.ujfalusi@ti.com>

Like paRAM slots, channels could be used by other cores and in this case
we need to make sure that the driver do not alter these channels.

Handle the generic dma-channel-mask property to mark channels in a bitmap
which can not be used by Linux and convert the legacy rsv_chans if it is
provided by platform_data.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Link: https://lore.kernel.org/r/20191025073056.25450-4-peter.ujfalusi@ti.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Hardik Gohil <hgohil@mvista.com>
---
The patch [dmaengine: ti: edma: Add some null pointer checks to the edma_probe] fix for CVE-2024-26771                                   needs to be backported to v5.4.y kernel.

 drivers/dma/ti/edma.c | 59 ++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 53 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/ti/edma.c b/drivers/dma/ti/edma.c
index 01089e5c565f..47423bbd7bc7 100644
--- a/drivers/dma/ti/edma.c
+++ b/drivers/dma/ti/edma.c
@@ -259,6 +259,13 @@ struct edma_cc {
 	 */
 	unsigned long *slot_inuse;
 
+	/*
+	 * For tracking reserved channels used by DSP.
+	 * If the bit is cleared, the channel is allocated to be used by DSP
+	 * and Linux must not touch it.
+	 */
+	unsigned long *channels_mask;
+
 	struct dma_device		dma_slave;
 	struct dma_device		*dma_memcpy;
 	struct edma_chan		*slave_chans;
@@ -715,6 +722,12 @@ static int edma_alloc_channel(struct edma_chan *echan,
 	struct edma_cc *ecc = echan->ecc;
 	int channel = EDMA_CHAN_SLOT(echan->ch_num);
 
+	if (!test_bit(echan->ch_num, ecc->channels_mask)) {
+		dev_err(ecc->dev, "Channel%d is reserved, can not be used!\n",
+			echan->ch_num);
+		return -EINVAL;
+	}
+
 	/* ensure access through shadow region 0 */
 	edma_or_array2(ecc, EDMA_DRAE, 0, EDMA_REG_ARRAY_INDEX(channel),
 		       EDMA_CHANNEL_BIT(channel));
@@ -2249,7 +2262,7 @@ static int edma_probe(struct platform_device *pdev)
 	struct edma_soc_info	*info = pdev->dev.platform_data;
 	s8			(*queue_priority_mapping)[2];
 	int			i, off;
-	const s16		(*rsv_slots)[2];
+	const s16               (*reserved)[2];
 	const s16		(*xbar_chans)[2];
 	int			irq;
 	char			*irq_name;
@@ -2330,15 +2343,32 @@ static int edma_probe(struct platform_device *pdev)
 	if (!ecc->slot_inuse)
 		return -ENOMEM;
 
+	ecc->channels_mask = devm_kcalloc(dev,
+					   BITS_TO_LONGS(ecc->num_channels),
+					   sizeof(unsigned long), GFP_KERNEL);
+	if (!ecc->channels_mask)
+		return -ENOMEM;
+
+	/* Mark all channels available initially */
+	bitmap_fill(ecc->channels_mask, ecc->num_channels);
+
 	ecc->default_queue = info->default_queue;
 
 	if (info->rsv) {
 		/* Set the reserved slots in inuse list */
-		rsv_slots = info->rsv->rsv_slots;
-		if (rsv_slots) {
-			for (i = 0; rsv_slots[i][0] != -1; i++)
-				bitmap_set(ecc->slot_inuse, rsv_slots[i][0],
-					   rsv_slots[i][1]);
+		reserved = info->rsv->rsv_slots;
+		if (reserved) {
+			for (i = 0; reserved[i][0] != -1; i++)
+				bitmap_set(ecc->slot_inuse, reserved[i][0],
+					   reserved[i][1]);
+		}
+
+		/* Clear channels not usable for Linux */
+		reserved = info->rsv->rsv_chans;
+		if (reserved) {
+			for (i = 0; reserved[i][0] != -1; i++)
+				bitmap_clear(ecc->channels_mask, reserved[i][0],
+					     reserved[i][1]);
 		}
 	}
 
@@ -2398,6 +2428,7 @@ static int edma_probe(struct platform_device *pdev)
 
 	if (!ecc->legacy_mode) {
 		int lowest_priority = 0;
+		unsigned int array_max;
 		struct of_phandle_args tc_args;
 
 		ecc->tc_list = devm_kcalloc(dev, ecc->num_tc,
@@ -2421,6 +2452,18 @@ static int edma_probe(struct platform_device *pdev)
 			}
 			of_node_put(tc_args.np);
 		}
+
+		/* See if we have optional dma-channel-mask array */
+		array_max = DIV_ROUND_UP(ecc->num_channels, BITS_PER_TYPE(u32));
+		ret = of_property_read_variable_u32_array(node,
+						"dma-channel-mask",
+						(u32 *)ecc->channels_mask,
+						1, array_max);
+		if (ret > 0 && ret != array_max)
+			dev_warn(dev, "dma-channel-mask is not complete.\n");
+		else if (ret == -EOVERFLOW || ret == -ENODATA)
+			dev_warn(dev,
+				 "dma-channel-mask is out of range or empty\n");
 	}
 
 	/* Event queue priority mapping */
@@ -2438,6 +2481,10 @@ static int edma_probe(struct platform_device *pdev)
 	edma_dma_init(ecc, legacy_mode);
 
 	for (i = 0; i < ecc->num_channels; i++) {
+		/* Do not touch reserved channels */
+		if (!test_bit(i, ecc->channels_mask))
+			continue;
+
 		/* Assign all channels to the default queue */
 		edma_assign_channel_eventq(&ecc->slave_chans[i],
 					   info->default_queue);
-- 
2.25.1


