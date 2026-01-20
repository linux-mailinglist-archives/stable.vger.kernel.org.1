Return-Path: <stable+bounces-210548-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2IQYIfJxcGktYAAAu9opvQ
	(envelope-from <stable+bounces-210548-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 07:28:02 +0100
X-Original-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2550A520BE
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 07:28:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 843F458BFD6
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 13:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D67AC436362;
	Tue, 20 Jan 2026 13:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="CixNRAjb"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA3042E001
	for <stable@vger.kernel.org>; Tue, 20 Jan 2026 13:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768916025; cv=none; b=IayrPZE/7fYvvQ9ADpqtqQNR00KAk/6ZeHw3K0x2hdU1muZBs9iplBupCFxouQLfNGWqu76VIrjAO+6nImfM3h4yI37TIa8gPyFsn4wn0SoJUFRJtTuMHK9BRvnd6IK6o/Jbn8q6GLRKoTlfVYPKHA3VEVwJfrZZ0vhix/MxjAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768916025; c=relaxed/simple;
	bh=7+lvctd+mOS+R5PxlA728yD1a8tDc2B4cTOJJy3B6f8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nvf4VMNmU7T8wBgAf8wUdLtBtc73bAuAbGwkpM1mf4z+GKasmEwwjnOhyZUj83rDrXI6a7dC7o6IbehHpnZ7VOolfkjsYMiUIxY3QBWJ9lipnPDvWc8DB2l5sKhZkX+T4qgNZT/SmkZ1ZQ0oIBnolYwrw8Wy8JUAI6iUaUJ0NpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=CixNRAjb; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-47ee4539adfso44757055e9.3
        for <stable@vger.kernel.org>; Tue, 20 Jan 2026 05:33:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1768916022; x=1769520822; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qrf/4ha8LTjYdiPZBpuP6fOy7D8F/H7Z7s3chjS0gfM=;
        b=CixNRAjb1G7T/nvjjGu1aiejOEP11qt1eKZW0mQqAGGRuYhR27bOOZXWbccdlt4dWb
         ji4onEXm2JU308Fc5rQpT4eDvd3w4QFlZwDeV3HUGLTCT9VkRQQDP/0WaYSgQM6n3NLs
         CM2lp1cOY0k/PjunQMV+nBt3j6c4SiN644V8eZS09FRMrObhEdpoCNLQQEEJWBOk7J4Q
         BD50aL7qo5VaO4GojuqlrliqWVmymr9/q7Mm91QrMP6EBLxVkUGXwwzfH5MxrZb7ERQ4
         7rgyU4mIwRP9liiBCdRdPypFfmeK6A1ezHtQtdt2EPTqL2dF7Q0Sin2z2i3LyDgfdjRU
         2FxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768916022; x=1769520822;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Qrf/4ha8LTjYdiPZBpuP6fOy7D8F/H7Z7s3chjS0gfM=;
        b=UsYCzm9ATsYNxYOypisZFki2F/CJse0VCqeoU09JT67QASf92lAHTf4L2KoJNO8eOc
         CAoy440cFCZTwbiybDh3ZXzLNtJsF26dEl1HAIwemic00LoU9jtVNT7OJnPVmjMaeuzv
         rHw8aKmRbdGwd+KhtBtyrVmBR4imWCUSV9dTto3q3VEdjCbAfSLmYdaUhWNes5in7gzQ
         W3eZ/LF2364WI0Y8csfdNojGSZETcNISDi36BLYAOFVF5CJlKBPJRb8U/3VQl7rMW7yN
         pW/1FlxSrFfaTytLgVH4ISrtqR3wE+/nUx1F2/AkpN5lNIr2y7r7Pg2jqdCdP4+zJSC4
         oe+g==
X-Forwarded-Encrypted: i=1; AJvYcCUkCyfM4lKx5cx0JGDpuNGwqz/R+qTY4HSgp/wOjnN6Kr/H9rFdPeJWKRDZJr4cp6uamoGLlHI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUTZY5YOKk6Q+8BCMH5PKVzOwZJry23CVDtkTkj7ZlgcL3mk5D
	5CvPAn2X7gUM638PgJeeDsXH6E4NF+1JgVXrzsp6v585saxt6Husn6klsgaS5tcKn34lJF4mG5y
	5mBlq
X-Gm-Gg: AZuq6aKinw4MAF92ueZcsIWrAbVBVtwgAAHjVMSXzJ5M2J3tYtMxnNwmH+JcS9HO6Aw
	Tf48KSTdwkNCN3cCTOz18NqT12epjZkGAJOtEMa/h3dXyDgyRb0v/QD12JmF+NDMXkKDqNuVPz/
	2/as6Hsza1HvHjau5VshwPU79ebgfyEeGHnjg9tBZF42SYcwaNNRVOOzwlIQYjrYjSo6HXSiKLH
	vyz0QBCHUafCQW7VUTpoFhBVUpIoKYSI7sM8yIWKA2oO3c5bNK3jKKql0gf7wVMTuk2+DciPypl
	gjjI/utRbMe25VTM59iUQ3ptexe/eTTkSVqmSk+9r2c4vEwJyTdKKi3tLO7VewT4knTIX+Hfv1x
	Fe26/OE36QW8f1TBDzvgE1NghAQw/fPJnv8dd+wBdiF3hdKhHw3P+fDP0sl0UJS3ZDrqRkvp05+
	B2StPi2XyDFMuRBAQF/X1RS5MRGEUixPaTu3BPxRI=
X-Received: by 2002:a05:6000:2481:b0:430:fdfc:7dd3 with SMTP id ffacd0b85a97d-4358ff62780mr2583333f8f.50.1768916021652;
        Tue, 20 Jan 2026 05:33:41 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4356996dad0sm29331439f8f.27.2026.01.20.05.33.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 05:33:41 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: vkoul@kernel.org,
	geert+renesas@glider.be,
	biju.das.jz@bp.renesas.com,
	fabrizio.castro.jz@renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Cc: claudiu.beznea@tuxon.dev,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	stable@vger.kernel.org
Subject: [PATCH v8 1/8] dmaengine: sh: rz-dmac: Protect the driver specific lists
Date: Tue, 20 Jan 2026 15:33:23 +0200
Message-ID: <20260120133330.3738850-2-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260120133330.3738850-1-claudiu.beznea.uj@bp.renesas.com>
References: <20260120133330.3738850-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[tuxon.dev:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-210548-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[tuxon.dev];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[tuxon.dev:+];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	FROM_NEQ_ENVFROM(0.00)[claudiu.beznea@tuxon.dev,stable@vger.kernel.org];
	RCVD_COUNT_FIVE(0.00)[5];
	R_SPF_SOFTFAIL(0.00)[~all];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,renesas];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,renesas.com:email,bp.renesas.com:mid,tuxon.dev:dkim]
X-Rspamd-Queue-Id: 2550A520BE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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

Changes in v8:
- none

Changes in v7:
- none

Changes in v6:
- none

Changes in v5:
- none, this patch is new

 drivers/dma/sh/rz-dmac.c | 57 ++++++++++++++++++++++------------------
 1 file changed, 32 insertions(+), 25 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index 3dde4b006bcc..36f5fc80a17a 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -10,6 +10,7 @@
  */
 
 #include <linux/bitfield.h>
+#include <linux/cleanup.h>
 #include <linux/dma-mapping.h>
 #include <linux/dmaengine.h>
 #include <linux/interrupt.h>
@@ -453,6 +454,7 @@ static int rz_dmac_alloc_chan_resources(struct dma_chan *chan)
 		if (!desc)
 			break;
 
+		/* No need to lock. This is called only for the 1st client. */
 		list_add_tail(&desc->node, &channel->ld_free);
 		channel->descs_allocated++;
 	}
@@ -508,18 +510,21 @@ rz_dmac_prep_dma_memcpy(struct dma_chan *chan, dma_addr_t dest, dma_addr_t src,
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
 
@@ -535,27 +540,29 @@ rz_dmac_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
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


