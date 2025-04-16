Return-Path: <stable+bounces-132829-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55EFDA8B0E2
	for <lists+stable@lfdr.de>; Wed, 16 Apr 2025 08:46:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6AE45A088A
	for <lists+stable@lfdr.de>; Wed, 16 Apr 2025 06:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D999622E41C;
	Wed, 16 Apr 2025 06:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mvista.com header.i=@mvista.com header.b="c1iZErt1"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F01239066
	for <stable@vger.kernel.org>; Wed, 16 Apr 2025 06:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744785851; cv=none; b=JBoSDodTJ3ivJF1UxyTWC4euv8NVVzFCfMCr/ErpFci3HO9In0oc/SjnP0Xk1XyAFDU6YJ60qNu3nr0ogRSEThgmseZ6QOuhP5v9jfqVC/P3QTJ2oOaXXBP85mbk3+bXFEeH6iLdTFM3Aw0CZ3wJUqSuCAr0+2Wn3mKTv5Uu5MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744785851; c=relaxed/simple;
	bh=ZsgW43t9Zq+y0UBxbO0wiFH7+4N/t/EsQC3UZ1eFldc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=stizu+Lx01k6EDiUrCtnkFONA75uLROKt75e79Y+qapWOAZaw02K3jaeBGNRHhI5JL12Y+V59zCPwC5E5gi0o0Oyh3V7cBy+C1pYrM0D90Al+3tzqkb9BwPUm179+sXRobVYnZWekKrVlAa83f82wkV7ZQkaHWpxniHwIYutVVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mvista.com; spf=pass smtp.mailfrom=mvista.com; dkim=pass (1024-bit key) header.d=mvista.com header.i=@mvista.com header.b=c1iZErt1; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mvista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mvista.com
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-7399a2dc13fso8474766b3a.2
        for <stable@vger.kernel.org>; Tue, 15 Apr 2025 23:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista.com; s=google; t=1744785848; x=1745390648; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ShXdLlJyHOq//Y0gSmV/d4FkJhqGFJTU5M4C26XQC4M=;
        b=c1iZErt1ZMch2+Fu1XPtor3qy17dC9y5OgN/Ta4FlbfhUWNTA/d//Btggx0Rth6bRh
         9/c59jZI9/tpr+OF8fqnZjTtRZpIbjv17yIlyxv4Z/1omwOpi0Pm0zXraRsCUA2eKDcT
         A/3urRlQ5YOz8cEvrn9yk5rTA0cwdY3I4W+BE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744785848; x=1745390648;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ShXdLlJyHOq//Y0gSmV/d4FkJhqGFJTU5M4C26XQC4M=;
        b=aiLjw9OZ4wQAw1Uidyrzr1lq+R2HPLLm6Dht5OF75kLAWstGkS13bqwTSUUFKxAE+I
         XTFJPs5bTD/M2w3VpRaSYFbRVyruL/RyMiQuh6X+9Hm1ryEwPOd9UlEwngjHILKJf2Tf
         g2iyDjma+m3xHP/SsVkPjKvOzuATn2O6VAY7xUTNOYW9dlw6GXajxYbVfQPgD4gl3EYN
         rdhxUpJXinc3+B/JS4WPOheQ3yguzx1lSX+Ho8mAY9+UnaXdRKYJfZ3U2M30PK5W86VD
         CErPHv6AGoe7eS+sbKZm3EOGten1FQqfc+/b/tf8vhX+AdbSwBgPYI/0fwTO2h/9yZIn
         +6JA==
X-Gm-Message-State: AOJu0YxzukZOlezy6agmWfJF2NUnAQ+1nTmK36hpr49jlica4BrYM5I1
	aa9KBZhW79YfpfthgAI4ASYLkEanCjMR2/gMKsTm55Icc/rS8vbZ/vUVw686ry8YVJjRicrpsTv
	MH3/o5lbi
X-Gm-Gg: ASbGnctBaukCHqwV564l8qDjj49DMnXa24m5AMas7uhAh+gRyFW5IRsEhHWi6P8VMPR
	URxe9TNcT9LiCcvaIZXGYqssQbQOxkxVrADI1c6o5iJUeDxKPc21xCG/i4e6etNKQaPkjT2iKV+
	VppjjGgxYsP0XqjJF8Ve2JtYQkP25yOeDG6wjuusVZwwEH9Rj5XzokF03A+lcg3QZNd6QFgTcD8
	rL2EPcGKjm27UMf9yy/WQr6OGbbwrgPo0XY27HibBE6taPaquD+z9Z1M0yUEEKL2hiWKZieTrdX
	P5VGtxDo4hr0fxKtY93RW99oU4+XZWLmOkd1ccytVLmEGw==
X-Google-Smtp-Source: AGHT+IGJ+CI5dy4HasZ/L0xjkr4sJjqq6e5PehyCbu3l7M0Nfl4Z1HzgLlsFV9g8n7NLunF7bPXr7Q==
X-Received: by 2002:a05:6a00:801b:b0:736:5545:5b84 with SMTP id d2e1a72fcca58-73c266beee1mr1227408b3a.3.1744785848518;
        Tue, 15 Apr 2025 23:44:08 -0700 (PDT)
Received: from testing.mvista.com ([182.74.28.237])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bd1fe6b4esm9662581b3a.0.2025.04.15.23.44.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 23:44:08 -0700 (PDT)
From: Hardik Gohil <hgohil@mvista.com>
To: stable@vger.kernel.org
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>,
	Vinod Koul <vkoul@kernel.org>,
	Hardik Gohil <hgohil@mvista.com>
Subject: [PATCH 1/3 v5.4.y] dmaengine: ti: edma: Add support for handling reserved channels
Date: Wed, 16 Apr 2025 06:43:25 +0000
Message-Id: <20250416064325.1979211-1-hgohil@mvista.com>
X-Mailer: git-send-email 2.25.1
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

patch 2/3 
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=v5.10.235&id=2a03c1314506557277829562dd2ec5c11a6ea914 
patch 3/3
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=linux-5.10.y&id=c432094aa7c9970f2fa10d2305d550d3810657ce

patch 2 and 3 are cleanly applicable to v5.4.y, build test was sucessful.

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


