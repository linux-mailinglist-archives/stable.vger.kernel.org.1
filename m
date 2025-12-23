Return-Path: <stable+bounces-203309-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 010C9CD97DE
	for <lists+stable@lfdr.de>; Tue, 23 Dec 2025 14:51:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 901B73024D53
	for <lists+stable@lfdr.de>; Tue, 23 Dec 2025 13:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D22A6279DCA;
	Tue, 23 Dec 2025 13:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="D2qA2H0D"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2DA2750ED
	for <stable@vger.kernel.org>; Tue, 23 Dec 2025 13:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766497844; cv=none; b=j7QP8ozBOOig1gAQUSSkeJuzwRB61DJtLu8Iz8tF+ZJgFJHWv/JUpTcdCFr/Pce7LcPinrvDkHwnvaOzPIUDAkfJPkr73IhzMIENVZ3d4phlLSrYsvNCaJ0EBdYn/vuNmWC0rnv4peY6nGH6HWSUfIW8WVsJwPdsOUwcj1l4PIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766497844; c=relaxed/simple;
	bh=6ZSYMN2SKXVTTfYd0IARyp5Sd5OHsSjCDdnQL0dBWGA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sS3WVzweXW5jqvxj3Oy+VeKWf4eRYEV2gXzFjhrhSxYWXTNgGFOXOwvPUKAsUcyqxG8wGU7XPzDNFxdk75v3q00oWBxBYKAsS7ftEc6wudIfi2xojw/z0FdTlaXLe6qYGhpj2juidxosz1ubtWayDxauTPlLevrrSTYmWHryVqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=D2qA2H0D; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4775ae5684fso17780245e9.1
        for <stable@vger.kernel.org>; Tue, 23 Dec 2025 05:50:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1766497841; x=1767102641; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gLvTm305m57LTYmm1aI4ieZDb54ktZ6C9ruLi16NB8I=;
        b=D2qA2H0DzGKjYswYFXadFnb09xtAoVX0qtHfEywD7pD8Oftm1wKbwrwlA7BTYR9IQ6
         Uj8J9UNrSwBg4Yx6SatY7LkmHEiBuLZ/rv9Jc+Xp/8X3B5M4Ywjaw7gB2K25RfAEGvXg
         3cvBuG/HKVz8UM2JMHp63J8wbNb/TEQ9tR5Ff4FOx3cXwjnAlNawWA1TNKDq/QGBH7HX
         rZ0cLlQlg8Na/Hk4JYAMXM2LusUxyiVy1FkMQF8sYwLyK1bglVWyDpKZ9GFcxhiB0qxj
         QDPAsuWQT5R7H/Xb8e8e74Kh/uRGZ5bf1j2kUXjoDYvIjWJ7KreIiFatmH3s7zDjTIE1
         Gnww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766497841; x=1767102641;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gLvTm305m57LTYmm1aI4ieZDb54ktZ6C9ruLi16NB8I=;
        b=kjsrK0b76XYZQTlVe3q3gSJW3MIfT0Tf7wgSLrdbuntBhOCxb5/r6+dvoNX1Rmx5qF
         aMhNJtV4+OLdGQdAkngShIvsXGIr2Q4d+PL5dhJgHPXYYvYsr8wijia/FolmcSI/yL5h
         DHFewwTHSZAJoAr7d/IskiBmq+dDcrDbiuB0vZ7VwC2VHOYtRg8GISyC9YPn3YXvmQOG
         mYXKtr10xFG5+AoUQ0hpddASt4bcw/K3wh7c2nqZ56r9NGoR9fnW656viCwStpbaMMCh
         1w7dkyuqpCbid6rTs1M6QBKwpumQoUUFpdQV/3oDTOM3HTj7vQCjYZzQbwlnCm/D48Kv
         n8PQ==
X-Forwarded-Encrypted: i=1; AJvYcCXO/o5FohkJJwyFaH15XutV1WAPsmtLsSzTIqf7tzFtPnJmwlS2WzEp2uKsfaGK/IVXgWJsrXY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOudisg2QTNqiYht4HB4XsW/6Radpy6aoWnKyCfEiHkO28TUr6
	Ay0UoYA27VQgNPSXAjBbts35US9zoafhonGSbw4OzupgaziAi7kxgpAscTEZ0XvMZsc=
X-Gm-Gg: AY/fxX6GG/v7zSictWlyToYEn7pDyVVxAQHyzMenZtRrOA+7nfE7jHqla06TGpp5H7Y
	ro9xh7clu/G4SQRrAnxprjzLuafrwuwxCalG+TELqSJD7OEBsKhQ730X9zs9KkwhA10z/HWv/Ak
	bD48Xz1UxR+mK/xSkrxkjZA7463mZxiSngBjQxFG73q+FGHRXlKi0DQX/W5loz3JtV4RbFj14UZ
	bHZrsioG2Ve40Ez/p1Y8ptpLP2BMhcvA/rymaetcBOo9Un0+rY/M8iV/llZVqPL0EioJj3E/hjz
	Bf+CyL2PV+iGbRY9brHdVUphay5pXvC6395cqQGBF63e2cCI3cIJmc7sinlNlEQbNWerYGx5xUB
	GKOmnsSy26UMbaIENXs6ZHigHtDDPxAooaFklDGAr9pellWkL6FQQd6R2BcmAg6nu2Lg9c5yORW
	mioI2QWl8nPtzlaTVn2k//86IKKbmw+l8OaelPRJpvrRw103KV+UqF6M4X4FxsG8XSM8gZhVA=
X-Google-Smtp-Source: AGHT+IEHaI451aDZyjBnBK6G77N/7eVYDQxAvy5RL96QV1B2EAWVR4YQBYxfsbJGhMmbq7yO9N9+Ww==
X-Received: by 2002:a05:600c:4f42:b0:477:55ce:f3c2 with SMTP id 5b1f17b1804b1-47d19556d02mr172647885e9.14.1766497840923;
        Tue, 23 Dec 2025 05:50:40 -0800 (PST)
Received: from claudiu-TUXEDO-InfinityBook-Pro-AMD-Gen9.. ([2a02:2f04:620a:8300:4258:c40f:5faf:7af5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d192e88f5sm237921025e9.0.2025.12.23.05.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 05:50:40 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: vkoul@kernel.org,
	biju.das.jz@bp.renesas.com,
	fabrizio.castro.jz@renesas.com,
	geert+renesas@glider.be,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Cc: claudiu.beznea@tuxon.dev,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	stable@vger.kernel.org
Subject: [PATCH v6 1/8] dmaengine: sh: rz-dmac: Protect the driver specific lists
Date: Tue, 23 Dec 2025 15:49:45 +0200
Message-ID: <20251223134952.460284-2-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251223134952.460284-1-claudiu.beznea.uj@bp.renesas.com>
References: <20251223134952.460284-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

The driver lists (ld_free, ld_queue) are used in
rz_dmac_free_chan_resources(), rz_dmac_terminate_all(),
rz_dmac_issue_pending(), and rz_dmac_irq_handler_thread(), all under
the virtual channel lock. Take the same lock in rz_dmac_prep_slave_sg()
and rz_dmac_prep_dma_memcpy() as well to avoid concurrency issues, since
these functions also check whether the lists are empty and update or
remove list entries.

Fixes: 5000d37042a6 ("dmaengine: sh: Add DMAC driver for RZ/G2L SoC")
Cc: stable@vger.kernel.org
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v6:
- none

Changes in v5:
- none, this patch is new

 drivers/dma/sh/rz-dmac.c | 57 ++++++++++++++++++++++------------------
 1 file changed, 32 insertions(+), 25 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index 9e5f088355e2..c8e3d9f77b8a 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -10,6 +10,7 @@
  */
 
 #include <linux/bitfield.h>
+#include <linux/cleanup.h>
 #include <linux/dma-mapping.h>
 #include <linux/dmaengine.h>
 #include <linux/interrupt.h>
@@ -448,6 +449,7 @@ static int rz_dmac_alloc_chan_resources(struct dma_chan *chan)
 		if (!desc)
 			break;
 
+		/* No need to lock. This is called only for the 1st client. */
 		list_add_tail(&desc->node, &channel->ld_free);
 		channel->descs_allocated++;
 	}
@@ -503,18 +505,21 @@ rz_dmac_prep_dma_memcpy(struct dma_chan *chan, dma_addr_t dest, dma_addr_t src,
 	dev_dbg(dmac->dev, "%s channel: %d src=0x%pad dst=0x%pad len=%zu\n",
 		__func__, channel->index, &src, &dest, len);
 
-	if (list_empty(&channel->ld_free))
-		return NULL;
+	scoped_guard(spinlock_irqsave, &channel->vc.lock) {
+		if (list_empty(&channel->ld_free))
+			return NULL;
+
+		desc = list_first_entry(&channel->ld_free, struct rz_dmac_desc, node);
 
-	desc = list_first_entry(&channel->ld_free, struct rz_dmac_desc, node);
+		desc->type = RZ_DMAC_DESC_MEMCPY;
+		desc->src = src;
+		desc->dest = dest;
+		desc->len = len;
+		desc->direction = DMA_MEM_TO_MEM;
 
-	desc->type = RZ_DMAC_DESC_MEMCPY;
-	desc->src = src;
-	desc->dest = dest;
-	desc->len = len;
-	desc->direction = DMA_MEM_TO_MEM;
+		list_move_tail(channel->ld_free.next, &channel->ld_queue);
+	}
 
-	list_move_tail(channel->ld_free.next, &channel->ld_queue);
 	return vchan_tx_prep(&channel->vc, &desc->vd, flags);
 }
 
@@ -530,27 +535,29 @@ rz_dmac_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 	int dma_length = 0;
 	int i = 0;
 
-	if (list_empty(&channel->ld_free))
-		return NULL;
+	scoped_guard(spinlock_irqsave, &channel->vc.lock) {
+		if (list_empty(&channel->ld_free))
+			return NULL;
 
-	desc = list_first_entry(&channel->ld_free, struct rz_dmac_desc, node);
+		desc = list_first_entry(&channel->ld_free, struct rz_dmac_desc, node);
 
-	for_each_sg(sgl, sg, sg_len, i) {
-		dma_length += sg_dma_len(sg);
-	}
+		for_each_sg(sgl, sg, sg_len, i)
+			dma_length += sg_dma_len(sg);
 
-	desc->type = RZ_DMAC_DESC_SLAVE_SG;
-	desc->sg = sgl;
-	desc->sgcount = sg_len;
-	desc->len = dma_length;
-	desc->direction = direction;
+		desc->type = RZ_DMAC_DESC_SLAVE_SG;
+		desc->sg = sgl;
+		desc->sgcount = sg_len;
+		desc->len = dma_length;
+		desc->direction = direction;
 
-	if (direction == DMA_DEV_TO_MEM)
-		desc->src = channel->src_per_address;
-	else
-		desc->dest = channel->dst_per_address;
+		if (direction == DMA_DEV_TO_MEM)
+			desc->src = channel->src_per_address;
+		else
+			desc->dest = channel->dst_per_address;
+
+		list_move_tail(channel->ld_free.next, &channel->ld_queue);
+	}
 
-	list_move_tail(channel->ld_free.next, &channel->ld_queue);
 	return vchan_tx_prep(&channel->vc, &desc->vd, flags);
 }
 
-- 
2.43.0


