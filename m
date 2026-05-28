Return-Path: <stable+bounces-254698-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gEllHLGfF2oXLggAu9opvQ
	(envelope-from <stable+bounces-254698-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 03:51:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D02F65EB9F7
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 03:51:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 080F230AEA6C
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 01:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ADD7299A87;
	Thu, 28 May 2026 01:50:47 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112FB220F2D;
	Thu, 28 May 2026 01:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779933047; cv=none; b=XxNTVOmDh9gj2XDo/WF9zQ210T37p0TWSSI79+9jC1avOPx/GurC3tkhDBAz0Y+khx4Oax4EPwWwRJE6GndSv/eAMucMI4FBkmO11Ddz+nF4EqmtzuwltrdPj6y14d9swNrM5kzAMBalEVQoKyWOZXB3JpAzCNBEYjtpVYrlC/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779933047; c=relaxed/simple;
	bh=eI6i14DyPEMQk+1Wg3YJaQQ9HsKCab0dw+/AA0HZYTA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=ek+xFOyArjl84bBruXJ3PbltRQ7MPDK50XrhKsiw+0KGRFTDnAxg5t9/wDams92owc8zLPA+5SgeF3uic45Bmzd3McKK1vmjgshmX1yIXTFTCrdI72v18/7jwln7dcnUJn3pB3zGfmNWy0ASe63k4ENOlsqqcyU61qoQcHrBFhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 9cb544e45a3711f1aa26b74ffac11d73-20260528
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:282aa943-77c0-4264-abb4-22c481816947,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:e7bac3a,CLOUDID:1367727cd0c32062577447378b7f979f,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850|865|898,TC:nil,Content:0|15|50,E
	DM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA
	:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 9cb544e45a3711f1aa26b74ffac11d73-20260528
X-User: zenghongling@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <zenghongling@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 2068538524; Thu, 28 May 2026 09:50:32 +0800
From: Hongling Zeng <zenghongling@kylinos.cn>
To: dpenkler@gmail.com,
	gregkh@linuxfoundation.org,
	dominik.karol.piatkowski@protonmail.com,
	kees@kernel.org,
	dan.carpenter@linaro.org,
	lukeyang.dev@gmail.com
Cc: linux-kernel@vger.kernel.org,
	zhongling0719@126.com,
	Hongling Zeng <zenghongling@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH v2] gpib: fmh_gpib: Fix resource leaks in fmh_gpib_attach_impl
Date: Thu, 28 May 2026 09:50:28 +0800
Message-Id: <20260528015028.12802-1-zenghongling@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-254698-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,linuxfoundation.org,protonmail.com,kernel.org,linaro.org];
	DMARC_NA(0.00)[kylinos.cn];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,126.com,kylinos.cn];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zenghongling@kylinos.cn,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.950];
	RCPT_COUNT_SEVEN(0.00)[10];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kylinos.cn:mid,kylinos.cn:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,protonmail.com:email]
X-Rspamd-Queue-Id: D02F65EB9F7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The fmh_gpib_attach_impl() function has multiple resource leaks in its
error handling paths. When any initialization step fails, the function
returns early without properly releasing previously acquired resources.

Fix by adding proper error handling labels and cleanup code that releases
resources in the reverse order they were acquired.

Fixes: 8e4841a0888c7 ("staging: gpib: Add Frank Mori Hess FPGA PCI GPIB driver")
Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
Cc: stable@vger.kernel.org
Suggested-by: Dominik Karol Piątkowski <dominik.karol.piatkowski@protonmail.com>

---
Changes in v2:
 - Fixed unnecessary retval assignments in early error returns
 - Removed extra newline
 - Kept e_priv->irq assignment after request_irq() succeeds,as suggested by Dominik Karol
---
 drivers/gpib/fmh_gpib/fmh_gpib.c | 37 +++++++++++++++++++++++++-------
 1 file changed, 29 insertions(+), 8 deletions(-)

diff --git a/drivers/gpib/fmh_gpib/fmh_gpib.c b/drivers/gpib/fmh_gpib/fmh_gpib.c
index fcafdc02ea2e..404379cd1565 100644
--- a/drivers/gpib/fmh_gpib/fmh_gpib.c
+++ b/drivers/gpib/fmh_gpib/fmh_gpib.c
@@ -1418,7 +1418,8 @@ static int fmh_gpib_attach_impl(struct gpib_board *board, const struct gpib_boar
 				     resource_size(e_priv->gpib_iomem_res));
 	if (!nec_priv->mmiobase) {
 		dev_err(board->dev, "Could not map I/O memory\n");
-		return -ENOMEM;
+		retval = -ENOMEM;
+		goto err_release_gpib_region;
 	}
 	dev_dbg(board->dev, "iobase %pr remapped to %p\n",
 		e_priv->gpib_iomem_res, nec_priv->mmiobase);
@@ -1426,34 +1427,39 @@ static int fmh_gpib_attach_impl(struct gpib_board *board, const struct gpib_boar
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dma_fifos");
 	if (!res) {
 		dev_err(board->dev, "Unable to locate mmio resource for gpib dma port\n");
-		return -ENODEV;
+		retval = -ENODEV;
+		goto err_iounmap_gpib;
 	}
 	if (request_mem_region(res->start,
 			       resource_size(res),
 			       pdev->name) == NULL) {
 		dev_err(board->dev, "cannot claim registers\n");
-		return -ENXIO;
+		retval = -ENXIO;
+		goto err_iounmap_gpib;
 	}
 	e_priv->dma_port_res = res;
 	e_priv->fifo_base = ioremap(e_priv->dma_port_res->start,
 				    resource_size(e_priv->dma_port_res));
 	if (!e_priv->fifo_base) {
 		dev_err(board->dev, "Could not map I/O memory for fifos\n");
-		return -ENOMEM;
+		retval = -ENOMEM;
+		goto err_release_dma_region;
 	}
 	dev_dbg(board->dev, "dma fifos 0x%lx remapped to %p, length=%ld\n",
 		(unsigned long)e_priv->dma_port_res->start, e_priv->fifo_base,
 		(unsigned long)resource_size(e_priv->dma_port_res));
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0)
-		return -EBUSY;
+	if (irq < 0) {
+		retval = -EBUSY;
+		goto err_iounmap_fifo;
+	}
 	retval = request_irq(irq, fmh_gpib_interrupt, IRQF_SHARED, pdev->name, board);
 	if (retval) {
 		dev_err(board->dev,
 			"cannot register interrupt handler err=%d\n",
 			retval);
-		return retval;
+		goto err_iounmap_fifo;
 	}
 	e_priv->irq = irq;
 
@@ -1461,7 +1467,8 @@ static int fmh_gpib_attach_impl(struct gpib_board *board, const struct gpib_boar
 		e_priv->dma_channel = dma_request_slave_channel(board->dev, "rxtx");
 		if (!e_priv->dma_channel) {
 			dev_err(board->dev, "failed to acquire dma channel \"rxtx\".\n");
-			return -EIO;
+			retval = -EIO;
+			goto err_free_irq;
 		}
 	}
 	/*
@@ -1473,6 +1480,20 @@ static int fmh_gpib_attach_impl(struct gpib_board *board, const struct gpib_boar
 		fifo_max_burst_length_mask;
 
 	return fmh_gpib_init(e_priv, board, handshake_mode);
+
+err_free_irq:
+	free_irq(e_priv->irq, board);
+err_iounmap_fifo:
+	iounmap(e_priv->fifo_base);
+err_release_dma_region:
+	release_mem_region(e_priv->dma_port_res->start,
+				resource_size(e_priv->dma_port_res));
+err_iounmap_gpib:
+	iounmap(nec_priv->mmiobase);
+err_release_gpib_region:
+	release_mem_region(e_priv->gpib_iomem_res->start,
+				resource_size(e_priv->gpib_iomem_res));
+	return retval;
 }
 
 int fmh_gpib_attach_holdoff_all(struct gpib_board *board, const struct gpib_board_config *config)
-- 
2.25.1


