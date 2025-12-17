Return-Path: <stable+bounces-202840-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F640CC81A3
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 15:14:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 909AB3073921
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 14:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 595B12D836D;
	Wed, 17 Dec 2025 13:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="PJNOqyrK"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44AB33C190
	for <stable@vger.kernel.org>; Wed, 17 Dec 2025 13:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765979553; cv=none; b=K48mpTEP0uiwKnc/mFOxrjo/86VWVQJ6DHw/ZXVWFQYZoY2j8PhytN1wqrhcNxDklWqDaDLEs3OZ33Rsb92HA1VzudZV59FWHzllK9+rBXARwbuH2nIftuRZ3Cdrft28TWDBubFP1jFMm4PSgChASNqXr3RKJnaDVB57A6SIWb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765979553; c=relaxed/simple;
	bh=wu45FRjAX5rr5XwRhmViBxUJ1/TuJ66eIVeI/gV2slw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eGhfz5kkTPCnpDVVRENIZDtoaU7AY92Pt5T5rLMcHBLSOTEGrqrBUOCvY/zCkY+iTbwa3Je1fieTShnxopdXcZiPzs7WPQoYrr27m1lFfPgNSp3lq/GNAj4JgoZ/gVL//dyx+2MCqJXixbmr9FVcZD6xDUgcq3p0faznggcpZyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=PJNOqyrK; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4775ae77516so68638795e9.1
        for <stable@vger.kernel.org>; Wed, 17 Dec 2025 05:52:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1765979547; x=1766584347; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1dmhSbGa11aoCwa2QR/4pZlPF5BdvQSf+YWgIGdjTtY=;
        b=PJNOqyrKYpSL6m+VlK/lFhP2/JrwSDRhD+pFYQsPgufCOYbK3FuIgXVlu+Z5vHqzik
         3awWcliwdqnCqnilf7nhlGmkVhvktoIMVUwIvrVC1DjYh+8SGXInBoOnX1weillXIpSX
         uGvRXrWLteFW6Rs1ZjfRFQQUc2egSHJxmbufv8o+BXfl6HeLaSI0BKYIBjxPny5R4ON/
         UjJg+FMp4AM+u83bMBNi5eBWjUJw6cCn83DYyen7pMNGt/AMSk5sH9wpisGcoahqTacC
         mgqNjKzKWNZH5fVWcjR0saG2ZPciQfZWF3R0JcsHrVqLQzeython6hKS+hlxFw9Qp4Uy
         +CvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765979547; x=1766584347;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1dmhSbGa11aoCwa2QR/4pZlPF5BdvQSf+YWgIGdjTtY=;
        b=OWaOvn/C6J5YR85pFr/HhmN3IaLtjUB1taphxpvV4YsayIdSMni8/mlyViLobs/60S
         1T04FUDxOSpEZtzE2+xVoQpNeEsZJdqaFhA/wnZOoKHqF+7saY4R8MdMd7p4C6sUzg8j
         Qr4FUo4P7jHysicESFP/gye4QktzDN3vuC+5PdYuuOhyYjrviRW6ZvPm8QZ3a58kx4Hn
         L9DajT5lO7aye0O9eikEO7OHvT2OzhSkrTBSgayxigytt2tS4LLY57dh4/vCBX/u0Fm3
         uRABjFpJvODoY9TNFFnz/ysgTzTrClcExtYS2iUCZVvNMY8+TAuRysknDkaBUnNLjDPI
         4eyw==
X-Forwarded-Encrypted: i=1; AJvYcCVoWtLUNSYGxwkjKIN/W0ojOkCcldInJ62KRCH4rQC7plTUkEEeFVxkcNQl3wiqu++H6qOG7jo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkFjzjYikAcUTnj1cjHXE/HQlp0LxmkBrQ+d19FHNA1/Ym8r6K
	IqQIoZypBKsR07WC6HEc8sL56oCJM+cyk4L5/EILmSdoff2j2K0EaExXZY2VycbNeWk=
X-Gm-Gg: AY/fxX7cSNkvu2qozbvsEfAl33NRXQxmKAG8dbH8feTMXmfWUj69To8cJ6zLg+sTCoP
	lbJHFPI+oXH8m1gvw3TVGEYMVy2pkantQDg1j9gt02MGoZSFPXOf8NAMcvGkgL+yPSKQDnqSkrS
	cks+4rEX2HUgUvd+m601GG5ShrDiU9P/koinIgCtl1Q94MEA78b1AphanGXq4zKRk/2wQXFL7pO
	+PAJNrvEPAgyVPqYV1JRI/NLdjeIWFTDgkWxtNJi6H7QCwM3AETZJ9P/BKMrxWwPe2gXn1B70UV
	VZTTGbVptzHa33JN6pNkOB4kBGNYrFRI66RwQQPs96EEQUR4skWe/zkaAVWPm6W9JSprNYrum5c
	bMBBs+Mzp45PDSVQSLgiF05K/f0cdbXskve1cLeiqmoQD/xTU5DuHGYGhFLpfSRZiRgnvfisM7Z
	388zP0F8YNHY0Sk2lY/WxLaY7DRNAT/GI8I4oPPxrbnNTX8eguQz4=
X-Google-Smtp-Source: AGHT+IFjWbNp9ucqit01hx4uiVylzLOMEnMuaieIZHHMFtzLDbezGqZEhZIONXkeIMCVRRvem4vK/A==
X-Received: by 2002:a05:600c:444b:b0:477:9b4a:a82 with SMTP id 5b1f17b1804b1-47a8f91561cmr176856225e9.35.1765979546692;
        Wed, 17 Dec 2025 05:52:26 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4310adf701csm4508000f8f.42.2025.12.17.05.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 05:52:26 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: vkoul@kernel.org,
	fabrizio.castro.jz@renesas.com,
	biju.das.jz@bp.renesas.com,
	geert+renesas@glider.be,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Cc: claudiu.beznea@tuxon.dev,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	stable@vger.kernel.org
Subject: [PATCH v5 1/6] dmaengine: sh: rz-dmac: Protect the driver specific lists
Date: Wed, 17 Dec 2025 15:52:08 +0200
Message-ID: <20251217135213.400280-2-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251217135213.400280-1-claudiu.beznea.uj@bp.renesas.com>
References: <20251217135213.400280-1-claudiu.beznea.uj@bp.renesas.com>
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


