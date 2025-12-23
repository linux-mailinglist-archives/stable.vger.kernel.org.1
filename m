Return-Path: <stable+bounces-203310-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B50DCD97F3
	for <lists+stable@lfdr.de>; Tue, 23 Dec 2025 14:51:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3984530181B1
	for <lists+stable@lfdr.de>; Tue, 23 Dec 2025 13:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA84E274FD0;
	Tue, 23 Dec 2025 13:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="QVgACvO4"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41FC827E049
	for <stable@vger.kernel.org>; Tue, 23 Dec 2025 13:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766497846; cv=none; b=pHFZny06eZuWNOMzbSYB3pjtvkrNNxp3Vt7abEiWhaa/ajGyWOgBNWHk3e9xF1im4psvMjfhncO5v2my46LLf/KOg7heCSJgC+3CpsjcLkYy8w7ne/tV86xjX3KK+7ppdFXAiOvdxpyhc7pZNCCEzYLDRHC3U6XqYJJRPFXoJo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766497846; c=relaxed/simple;
	bh=NuLQyH+VwGHRR72oMwwugrjxP5H7eBUcMTxjyn0Mn3E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kEwhuj4G5lCN1lxZDP3TKS+KwsazRIrbyGJ67sBKPjHuh7efiEUTYhr6bpzrRi4sAXFsPGEp/AX0Ng+qLAmMoZeeNDWE+ycs18T7Gv8htTsIzSD2glrhgjCiRYRnu1qDZchWWu3PfCRXykbeKJDB1Un/nvP8MuTpU8yAdwjqdAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=QVgACvO4; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-47d3ba3a4deso355235e9.2
        for <stable@vger.kernel.org>; Tue, 23 Dec 2025 05:50:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1766497843; x=1767102643; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hZ9+0Yi+2nkzLK6cHQIgso5yqDARPMTK/Jx14dRo/m8=;
        b=QVgACvO4Ji2edDIbIDuO4Epac+uxD68+ax1NZRPHt/iGFWtY8dqRK4jBGlLKD1siKu
         d8gpyewQulDCmeRGgeCnRo4iCquWHqc/ErC5uu0fQyBxxahp8bNSyRpDIV2/hJrjHBm9
         4uudbx68z4IoY621r37QMcv7SgmJmO+DE22P6oMlUUtl78f9LVI4XbkSMQKLqBquhqTD
         zgXOY4NU2GBu5tNWJNTMl46A8peu66vO++kkCUOwmD7IuCC6hczzFJ9fqCi993oNQsKz
         +j/BfxiNZYW3sANhjffLVS7rucZKNlg9zn2OcOQomP9HRW1pYZ9vgDvakUnMN+gVWvLN
         pJvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766497843; x=1767102643;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hZ9+0Yi+2nkzLK6cHQIgso5yqDARPMTK/Jx14dRo/m8=;
        b=pTex3sUctqNj/j6h0PXF8+J+A/fHnCy/M1A04RGKUQsj2rBuieYGM9a7rLmFsV9TK5
         RFeLKNDK1L4cRLFeixBr9Ba9GnRcfAIec60BNh73YlSdpbusapojlMWuzDP24xWEYLKT
         4G1GoZRQ9siOjCEBLVsLOYJHeFJX3HJP/dGfxb5USjMzjO1zkL3MH14OAiew2UdIR3RK
         LITcpxjnqeu65j+25Zq+qcphIBBMFUejsmZdIXFVpaYT1e3lFkbWb6AJJGaZ1Ryyxta2
         NNJ90MHBPbPBTh06SgulOJ3f+hSqFa++fJrWYtQ6qSb9tMr7U2YA8dzlAsxNAR9lOOv4
         9tnw==
X-Forwarded-Encrypted: i=1; AJvYcCVwd+fuIPpmvqTF3yYb0Y22HTtcFLRUg3pzvcATz2j2PZp4V00kgKCoXOBheLpWATv+nszN+Aw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzIxQFbBu5micnbkp8krboUXerVjt94XPMy3BikBe4SruZth51
	dANog7v6i5sowszXUUm3CGfEzxDpFFN8ai0isPuaaGBbQfCYwbW8o394NiAsW+Kr3u0=
X-Gm-Gg: AY/fxX7N4FGdZ54O9u9rWD+vHtzf+abBgc9DxiGr0oY4Mf255zA9gvO2bthTEtVTXXW
	NBFId8jO7JGr/VaCcpy0XRFBBiH5fcCdt8+O3w7YkGSi32NIq4scDKbm+DH0HmQ0zLtsaFeXtQQ
	my44MgKZjFAMbhNEqVayhX0SK6mNE8a7EnQheck/x+n0yed4ZEHr4YbG36TZc/D3h4gd1tzD5H6
	hWybPuiEnNfwOARPfZMLjj1MkOIjn5TNR191dVcHuvRggfDsl8cdH8ZYPyA++eNnb3YYRtvjvrs
	S3GGS25ZnVZufADxBMV1P4OmrkEIYZ90LVN1nbY79penq7X1v8lHfXCpyAT5/QO1vRc4yLZGwqg
	F1sw7g0lGn0jafQbS+ItQMcqNRc+A1yXc8DIOv1W9HZZXaJ1l48IWQSQCYu1NxtedCXK5wrdcyh
	gaGryu0vVXX39K2uY26Y4pr4qDA3KLszL+EAYN4uLWV4DQgBpd11xRDrgqMlVpCM8/5xmCs9U=
X-Google-Smtp-Source: AGHT+IHKxYmc9Jyegqhg5MAp6RDYOMSBp3GbrsFKuRyQtLXF0v+7GhMm6p7R8YXuU3Tk5WSJGR2hMg==
X-Received: by 2002:a05:600c:8b6d:b0:475:dd8d:2f52 with SMTP id 5b1f17b1804b1-47d1959d1d8mr152368795e9.32.1766497842594;
        Tue, 23 Dec 2025 05:50:42 -0800 (PST)
Received: from claudiu-TUXEDO-InfinityBook-Pro-AMD-Gen9.. ([2a02:2f04:620a:8300:4258:c40f:5faf:7af5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d192e88f5sm237921025e9.0.2025.12.23.05.50.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 05:50:42 -0800 (PST)
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
Subject: [PATCH v6 2/8] dmaengine: sh: rz-dmac: Move CHCTRL updates under spinlock
Date: Tue, 23 Dec 2025 15:49:46 +0200
Message-ID: <20251223134952.460284-3-claudiu.beznea.uj@bp.renesas.com>
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

Both rz_dmac_disable_hw() and rz_dmac_irq_handle_channel() update the
CHCTRL register. To avoid concurrency issues when configuring
functionalities exposed by this registers, take the virtual channel lock.
All other CHCTRL updates were already protected by the same lock.

Previously, rz_dmac_disable_hw() disabled and re-enabled local IRQs, before
accessing CHCTRL registers but this does not ensure race-free access.
Remove the local IRQ disable/enable code as well.

Fixes: 5000d37042a6 ("dmaengine: sh: Add DMAC driver for RZ/G2L SoC")
Cc: stable@vger.kernel.org
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v6:
- update patch title and description
- in rz_dmac_irq_handle_channel() lock only around the
  updates for the error path and continued using the vc lock
  as this is the error path and the channel will anyway be
  stopped; this avoids updating the code with another lock
  as it was suggested in the review process of v5 and the code
  remain simpler for a fix, w/o any impact on performance

Changes in v5:
- none, this patch is new

 drivers/dma/sh/rz-dmac.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index c8e3d9f77b8a..818d1ef6f0bf 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -298,13 +298,10 @@ static void rz_dmac_disable_hw(struct rz_dmac_chan *channel)
 {
 	struct dma_chan *chan = &channel->vc.chan;
 	struct rz_dmac *dmac = to_rz_dmac(chan->device);
-	unsigned long flags;
 
 	dev_dbg(dmac->dev, "%s channel %d\n", __func__, channel->index);
 
-	local_irq_save(flags);
 	rz_dmac_ch_writel(channel, CHCTRL_DEFAULT, CHCTRL, 1);
-	local_irq_restore(flags);
 }
 
 static void rz_dmac_set_dmars_register(struct rz_dmac *dmac, int nr, u32 dmars)
@@ -569,8 +566,8 @@ static int rz_dmac_terminate_all(struct dma_chan *chan)
 	unsigned int i;
 	LIST_HEAD(head);
 
-	rz_dmac_disable_hw(channel);
 	spin_lock_irqsave(&channel->vc.lock, flags);
+	rz_dmac_disable_hw(channel);
 	for (i = 0; i < DMAC_NR_LMDESC; i++)
 		lmdesc[i].header = 0;
 
@@ -707,7 +704,9 @@ static void rz_dmac_irq_handle_channel(struct rz_dmac_chan *channel)
 	if (chstat & CHSTAT_ER) {
 		dev_err(dmac->dev, "DMAC err CHSTAT_%d = %08X\n",
 			channel->index, chstat);
-		rz_dmac_ch_writel(channel, CHCTRL_DEFAULT, CHCTRL, 1);
+
+		scoped_guard(spinlock_irqsave, &channel->vc.lock)
+			rz_dmac_ch_writel(channel, CHCTRL_DEFAULT, CHCTRL, 1);
 		goto done;
 	}
 
-- 
2.43.0


