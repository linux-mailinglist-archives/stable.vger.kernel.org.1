Return-Path: <stable+bounces-223335-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8GOpG97NqmkNXQEAu9opvQ
	(envelope-from <stable+bounces-223335-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 06 Mar 2026 13:51:42 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CDAE022100C
	for <lists+stable@lfdr.de>; Fri, 06 Mar 2026 13:51:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E08BF31A4C4C
	for <lists+stable@lfdr.de>; Fri,  6 Mar 2026 12:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DFFC283FDC;
	Fri,  6 Mar 2026 12:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="RVWOeo7C"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6EC92701B6
	for <stable@vger.kernel.org>; Fri,  6 Mar 2026 12:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772800901; cv=none; b=L4RNpS1Klj1P4jVh6i7+KjsMCVuc2fxUAfUq4CDB6lhsJcAiauSOLzy5XzLGLY0eHT0ssmCOXh7KjADZI881zpGoMkQd1ANaJbmJ1aMpJUn6N370tfPkzelkXsWpaf0QQlH85tXQsuJ5dlzvZQWsdBheNo6Ev8OqD/IoCtCh9bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772800901; c=relaxed/simple;
	bh=RN3Xvj39V/yKMYYPWCiHYcUQb1LTVs8M5GbjU78OU3c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tsBMOsFvU8nqDLCgSwSVBZiuAhzLfSpgEXRJ9YnUmv2H7xQNrHzWSfOdDpBmWvyAS3nojNiI/SB679px+rJ463PahLhrMlKJUeJSeS9rl77fKzyJ4Aly9ZEdiSZTeeTGFfFM9ljEghcRbfhi5FA0VXecESNNfmM9bHDgHs3+aD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=RVWOeo7C; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-439cd6b09f8so1648883f8f.3
        for <stable@vger.kernel.org>; Fri, 06 Mar 2026 04:41:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1772800898; x=1773405698; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JtXHbNPdEBg9KTwTT66W1+1GRh4EUiwex5QWGP93Nrc=;
        b=RVWOeo7CE058x4pBoPeHmEvS293hHs+QKwqnHkENZwvtidN7/KMhlnwHt+mGd/VQ5Q
         X5lbP7fQ/fGFjRfM0PifMT/Hz3kxtjMiNXwOoJMam4H9MIduxKGUkTOFdObcOt/AMKWV
         HsSN8lFae/NrXks2R0u+txhrnl6gVoFcJ4w0vjFP+sVubZ+ZgOb6ijVoF+c+Nz2bWtxo
         2AzAsaf1D7i6cBB0FzTYW7LCyR7LXIjZKQqYFyxNWLFZJI8G9qy20xEMo36VMQ/aDIMW
         WCe3qOaLmdEZj6nbzb3EZFo/8Nem5z6/mKWi06TzHE/Cg1n1+NYWydTVeoqIjSWgB9iR
         vRJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772800898; x=1773405698;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JtXHbNPdEBg9KTwTT66W1+1GRh4EUiwex5QWGP93Nrc=;
        b=TnYsBl06Z7/H0T5iCuGP1jqWmC6xWhCWT6c79qoBlktJOR27f6cOPXO/b3DQ3VCdXv
         tzYtGd2M6rRSEzbU5lad6A4MP8qmjfFxgOI+IFRbFeOJYi1xLgRK98OAfl7KA2RutPAC
         c4XX3OdrjLA3a+/EAgygA+MWWJ1BWVYxjYsF1H06lGU+3NXFbFbvHuUJUP0aglDtVW4m
         PAqqX3cgLCdmGDMYgah1Yl1pMlme1D6HfFyRgYI8sd8MptxdbjK7rYhhTZ54XL7wOm/P
         A3teRM2SS9GZee6cSZpjGw9cJIDZIVipXjGLEypxhnchsnWDsO1elEBboxjDtvx2vaaO
         ruFQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2Q0KMi42MbwxLk34Dkaumk3bxWBfQ9y1hFITvZsh2kGo/3hiD49KTPKweHnXi7U1aUVtQK5c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFc4x2hwV+dnzfdw792kC+nQL196TfepDY6C55KCCBn38LpNmj
	HeyoLaGyQaV2h9drPJwjBu4vnZrWs7aaPc9Y2+Zj4kNEkF+Dcpr9r5LlVwSHdX6R8Y4=
X-Gm-Gg: ATEYQzz6U3LloqlbDMhnJeLYpEjSnh1T1enE5C6kxD6W7PUoNHEQF2Kn8EEPhYKz+0m
	RcasOfkurX7xJ8zgF/zRozlKB23rMqBNxDvcp7g8KlyOboWM85nig+DmQBEfN9uoi/5ryXzl8lJ
	0Cne4MLkpTvXCt130jGFQdNGui88YaOz54CaDPioGfd1Zo2fIOiXgz5GB69nemdZiSiARofEgDu
	hiYZUHHIumCXzB9yQiw1+nZLyo21hCuV3ZUADz4SzV6JV5SFH9YhH9DzWZ00pUO2KUPeWtvyZRG
	YC9F5+6fjeOys0QPTzH5p6ishFyIcxrAhFMjNXSMvGlxNQXpJsRzgwRGVRl4l/BEdB3jADDbuz/
	75gbvHjLIdcBAAbmes1VgiOAVwSNh1NP7oU36ND/8KTQP3/pbdYtP34zb3oFZiPWT5zMMIdHEpR
	EOLjqkvlE95WYrMmkI11L5Iuq8ScvbXPtuwXSWfT2FhdznID8yE08A
X-Received: by 2002:a05:600c:a086:b0:483:75f1:54f with SMTP id 5b1f17b1804b1-48526982991mr30474875e9.31.1772800898064;
        Fri, 06 Mar 2026 04:41:38 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-485276b0c38sm38150505e9.9.2026.03.06.04.41.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 04:41:37 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: vkoul@kernel.org,
	Frank.Li@kernel.org,
	biju.das.jz@bp.renesas.com,
	geert+renesas@glider.be,
	fabrizio.castro.jz@renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Cc: claudiu.beznea@tuxon.dev,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	stable@vger.kernel.org,
	Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v9 1/8] dmaengine: sh: rz-dmac: Protect the driver specific lists
Date: Fri,  6 Mar 2026 14:41:26 +0200
Message-ID: <20260306124133.2304687-2-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306124133.2304687-1-claudiu.beznea.uj@bp.renesas.com>
References: <20260306124133.2304687-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: CDAE022100C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[tuxon.dev:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[tuxon.dev];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-223335-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nxp.com:email,tuxon.dev:dkim,renesas.com:email,bp.renesas.com:mid]
X-Rspamd-Action: no action

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
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

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
index d84ca551b2bf..089e1ab29159 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -10,6 +10,7 @@
  */
 
 #include <linux/bitfield.h>
+#include <linux/cleanup.h>
 #include <linux/dma-mapping.h>
 #include <linux/dmaengine.h>
 #include <linux/interrupt.h>
@@ -447,6 +448,7 @@ static int rz_dmac_alloc_chan_resources(struct dma_chan *chan)
 		if (!desc)
 			break;
 
+		/* No need to lock. This is called only for the 1st client. */
 		list_add_tail(&desc->node, &channel->ld_free);
 		channel->descs_allocated++;
 	}
@@ -502,18 +504,21 @@ rz_dmac_prep_dma_memcpy(struct dma_chan *chan, dma_addr_t dest, dma_addr_t src,
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
 
@@ -529,27 +534,29 @@ rz_dmac_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
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


