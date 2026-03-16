Return-Path: <stable+bounces-225539-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SG3+NykHuGkWYQEAu9opvQ
	(envelope-from <stable+bounces-225539-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 14:35:37 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0008029A861
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 14:35:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4CCC73014899
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 13:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3719239A049;
	Mon, 16 Mar 2026 13:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="Y3cleuAq"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A1D398916
	for <stable@vger.kernel.org>; Mon, 16 Mar 2026 13:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773667987; cv=none; b=bdcCAC+2HEI9Hgu2r/DtJR8SskEYFlVPxs9gD9Vrfm/+17XCK0Hz5YtYeQDjhahxNhWNjA1YjAf0Yym+DH1wzEqd3ixJagD+KDeVdFg3i+gyYi2gnBBSlFBw9+lYrNw02Kbh2K7Z3Vg/7VawdX9TYrRWr59kO/SJUChsoWDuKWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773667987; c=relaxed/simple;
	bh=5vNGiQOV9z2LuY7BexBTaM4+b8WdnI5Dm+Qs8Ojt3x4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RUM5uS2GOjckBTOuGl2zTaP4RbtKoaCOAGGrt4mczTnFWNqTKVxBAvwHOXzgb3SzhNFR+IhG8zIggzJzH3m2mvXs0dJQtTPiWnDBwzCNegWG117xhZS0evY1CveI4A9noce2fHlUHJEMQsn4FRLESL+Pvu0hvIMgiMjsAnCVto0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=Y3cleuAq; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6618bc129acso5823051a12.2
        for <stable@vger.kernel.org>; Mon, 16 Mar 2026 06:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1773667984; x=1774272784; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3+W56HzNycC2wMkiULlWF3cNiCiN6FevvWbhSc6vRfM=;
        b=Y3cleuAqHMD2a1ulTa1eWT8AYviCDnSgUM1AjUDk3vEQfxmWIN1okEtY2l/sUvGgLl
         hoYhqQGkCZH1YOQAmJ/Q+hRM5TsSbvmrbD0u4XVRbar9sKzQO4E3H0FKVpBwwaaNf1RB
         OQVVM15AxdJ/KwTYgCxt1jdcdfl4wMj3a9L70LDq0SKSLhQh/ToEDQnrV0wGzrzF6egR
         3mM+Niqtg7eKyq3Ai36fl5QliY9C0gEt1NyZAdAVWhPkuLFlpdT1rmXurk6Lpc0sqQFB
         Pdjzj5d8YQ+LlqlLTbgv8LAjIzwjKFgyBdtZS6DCREyQWR8JTAmfaQsgWH2uPZov9axC
         xx2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773667984; x=1774272784;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3+W56HzNycC2wMkiULlWF3cNiCiN6FevvWbhSc6vRfM=;
        b=PPQWdIJgcEXv3zjm2lX/n52+UfeTBZ862xuHqGPWFTp0u1WgDMr9l5a6zOe9weZuGT
         6hrxcBYlSMpANPwxEk+sJDeiq2mlSwASsiYr1yjgSM073r45khTxGJ89NBMdddO1+4Mm
         AU2lBBx8gJX/zqJIZs0LjhaGj4J0OYkgobXoIUE9w1DnWEQAtmTai9QAcGfv93BGrBgx
         Pr41Fcm09+0bSyzKs8d+OY2Ntcq+vC/vauugQu6p/jYFm5uvXhKNKj5BWUweciUPe4Rb
         gHArCs2AHbg/SGK7bKGr5wriA30X1JsXsaN63YHjmS2DZioafzQWbfHYpIJTvzY0b3ie
         44Lg==
X-Forwarded-Encrypted: i=1; AJvYcCUh00NEHFFtfzb2GnLqWbrYi/cdV/B8vuMTshXMCDXaxZ6P0GJzVqkxXxYu+OgDiVsVvWYg8U0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpxjOespxqPkMhCPDZprH/C/oby0oH+M1fjWzNZ3E7i10DNSeA
	jyaNWkrfBahiGJRzl1mc6Dgh/lB+HIyt9RyXN4D6PAiF6izyO1VzvXQ7NL882yIyOkw=
X-Gm-Gg: ATEYQzxNBSZie4DOAiJwMNulz26SNxsjNAOLGNnTGQCNE3Sz6L9uAVYwbDO7GgpYK+o
	g6q+78prfEJZBayGAefwXQa90xwnhSC1OjxNlEnxNOF+uNyAOzST9x/GSgZswv+iPy34cG+c6BO
	qE4FF0QWGk4lp0Xc3TYqvIzl3OsvR+vidzeqcpLCr5Pelksl/hRZ9aCuaI/HLsgPiHVemomXH9J
	8TRFAWB+9PP6JyaSXpWcWM6aCuDOsLNpl69seM0RcvCmGTBYav8O51WBw+Gu7wgqDES9lKVxmPC
	3lLGKBLVItqTFphLMrLT3s4af5MTN6s4gUR6SVwJfSpg1OGyl/J1XeqDX+VPpaKsMgdE31kM9Ob
	vHA2+nbUxHzWbhn7WcxDtnuyBnjnRiiB1333UnL73cvARk1J6dZaURdk9QgQfowpy/jGGKATm8K
	tGL0npq0ijV+fB9dOF7K3S5Y11xE+QdfNB3+/iYiKMvoa6/2BmwEAvYkl29id0bE7YZmZt/wVD5
	jDI874=
X-Received: by 2002:a17:907:2982:b0:b93:5405:9260 with SMTP id a640c23a62f3a-b976519a1e1mr613963966b.30.1773667983963;
        Mon, 16 Mar 2026 06:33:03 -0700 (PDT)
Received: from claudiu-TUXEDO-InfinityBook-Pro-AMD-Gen9.. ([2a02:2f04:6208:0:c5e3:3624:ad1c:6b4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b419270efsm11629888f8f.16.2026.03.16.06.33.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 06:33:03 -0700 (PDT)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
To: vkoul@kernel.org,
	Frank.Li@kernel.org,
	geert+renesas@glider.be,
	biju.das.jz@bp.renesas.com,
	john.madieu.xa@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Cc: claudiu.beznea@tuxon.dev,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	stable@vger.kernel.org,
	Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v10 1/8] dmaengine: sh: rz-dmac: Protect the driver specific lists
Date: Mon, 16 Mar 2026 15:32:45 +0200
Message-ID: <20260316133252.240348-2-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260316133252.240348-1-claudiu.beznea.uj@bp.renesas.com>
References: <20260316133252.240348-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[tuxon.dev:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[tuxon.dev];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-225539-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[claudiu.beznea@tuxon.dev,stable@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[tuxon.dev:+];
	TAGGED_RCPT(0.00)[stable,renesas];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[renesas.com:email,tuxon.dev:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,bp.renesas.com:mid,nxp.com:email]
X-Rspamd-Queue-Id: 0008029A861
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The driver lists (ld_free, ld_queue) are used in
rz_dmac_free_chan_resources(), rz_dmac_terminate_all(),
rz_dmac_issue_pending(), and rz_dmac_irq_handler_thread(), all under
the virtual channel lock. Take the same lock in rz_dmac_prep_slave_sg()
and rz_dmac_prep_dma_memcpy() as well to avoid concurrency issues, since
these functions also check whether the lists are empty and update or
remove list entries.

Fixes: 5000d37042a6 ("dmaengine: sh: Add DMAC driver for RZ/G2L SoC")
Cc: stable@vger.kernel.org
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v10:
- none

Changes in v9:
- collected tags

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
index c75e9202e239..ec1b6b00af76 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -10,6 +10,7 @@
  */
 
 #include <linux/bitfield.h>
+#include <linux/cleanup.h>
 #include <linux/dma-mapping.h>
 #include <linux/dmaengine.h>
 #include <linux/interrupt.h>
@@ -452,6 +453,7 @@ static int rz_dmac_alloc_chan_resources(struct dma_chan *chan)
 		if (!desc)
 			break;
 
+		/* No need to lock. This is called only for the 1st client. */
 		list_add_tail(&desc->node, &channel->ld_free);
 		channel->descs_allocated++;
 	}
@@ -507,18 +509,21 @@ rz_dmac_prep_dma_memcpy(struct dma_chan *chan, dma_addr_t dest, dma_addr_t src,
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
 
@@ -534,27 +539,29 @@ rz_dmac_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
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


