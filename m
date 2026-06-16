Return-Path: <stable+bounces-264124-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id d2YaGU1vMWoDjQUAu9opvQ
	(envelope-from <stable+bounces-264124-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:44:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BE54691594
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:44:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=sMaTfECN;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-264124-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-264124-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A1D083048F9E
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 15:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C5EC44CAE0;
	Tue, 16 Jun 2026 15:37:38 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0E43AB267;
	Tue, 16 Jun 2026 15:37:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781624258; cv=none; b=EYNjjfGV1J8wLXXPeCOWDMTECiq9tzNi5FAyV9NKU6To1664NdD/Hg0i53hNsslRW+txjD9n0Z35XuGUV5jm7Rqf/Wol6cZvaZitzn18c12y6dvW8hXZxCLtFsY6CAXvuTcopRbkZV+aQEfh/gAg/XSUo3hxIb9zamLXxX7eXWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781624258; c=relaxed/simple;
	bh=Zjm9XREAi4aUzDgZnK3Xg2vx4+kC3Ft/O+IGoEqXaH8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KRjoKdpEVvIWkKfkLTCTW49+7dYnjEB22hX1DFOwb34czh4q7y0mmZz2YVyKjPOZCA3B15hvThxxhjQ8VGHg2NYKCbElJFuCAF01babCQdx8iOsMkBLdUbLf/dC1FkuQ4DVJ5NDYEaUMyDIDuT7W0ZAx5C9aSKdZKQTtQ+YXlLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sMaTfECN; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F2B01F000E9;
	Tue, 16 Jun 2026 15:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781624257;
	bh=n7Hm1FyLZ/JZSLBMCdN9I83+5xXvXrGzfZXFCxKo8X4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=sMaTfECNFac4qtNBWimnuyqf66vbGmtha08YLDErGqA9m8onQNS1bqR08U/kqRHDE
	 LvtUibbP66Ey7VzTt6csN6t8HQOT1K5QErbK8icyv8xW6TsKeUlhJXJbILkLqUJpXY
	 2xgLyNvGlhkO4Ytk+6cCgRqKFbuKeI7SUgiL98to=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Carlos Song <carlos.song@nxp.com>,
	Frank Li <Frank.Li@nxp.com>,
	Andi Shyti <andi.shyti@kernel.org>
Subject: [PATCH 7.0 269/378] i2c: imx-lpi2c: fix resource leaks switching to devm_dma_request_chan()
Date: Tue, 16 Jun 2026 20:28:20 +0530
Message-ID: <20260616145124.271129905@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145109.744539446@linuxfoundation.org>
References: <20260616145109.744539446@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-264124-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:carlos.song@nxp.com,m:Frank.Li@nxp.com,m:andi.shyti@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,nxp.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2BE54691594

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Carlos Song <carlos.song@nxp.com>

commit 695fcefd4a81466ef9c529790b4e96f1ea2ba051 upstream.

The LPI2C driver requests DMA channels using dma_request_chan(), but
never releases them in lpi2c_imx_remove(), resulting in DMA channel
leaks every time the driver is unloaded.

Additionally, when lpi2c_dma_init() successfully requests the TX DMA
channel but fails to request the RX DMA channel, the probe falls back
to PIO mode and completes successfully. Since probe succeeds, the devres
framework will not trigger any cleanup, leaving the TX DMA channel and
the memory allocated for the dma structure held for the lifetime of the
device even though DMA is never used.

Switch to devm_dma_request_chan() to let the device core manage DMA
channel lifetime automatically. Wrap all allocations within a devres
group so that devres_release_group() can release all partially acquired
resources when DMA init fails and probe continues in PIO mode.

Fixes: a09c8b3f9047 ("i2c: imx-lpi2c: add eDMA mode support for LPI2C")
Signed-off-by: Carlos Song <carlos.song@nxp.com>
Cc: <stable@vger.kernel.org> # v6.14+
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Andi Shyti <andi.shyti@kernel.org>
Link: https://lore.kernel.org/r/20260520093323.2882070-1-carlos.song@oss.nxp.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/i2c/busses/i2c-imx-lpi2c.c |   53 ++++++++++++++++++++++---------------
 1 file changed, 32 insertions(+), 21 deletions(-)

--- a/drivers/i2c/busses/i2c-imx-lpi2c.c
+++ b/drivers/i2c/busses/i2c-imx-lpi2c.c
@@ -1383,55 +1383,66 @@ static int lpi2c_imx_init_recovery_info(
 	return 0;
 }
 
-static void dma_exit(struct device *dev, struct lpi2c_imx_dma *dma)
-{
-	if (dma->chan_rx)
-		dma_release_channel(dma->chan_rx);
-
-	if (dma->chan_tx)
-		dma_release_channel(dma->chan_tx);
-
-	devm_kfree(dev, dma);
-}
-
 static int lpi2c_dma_init(struct device *dev, dma_addr_t phy_addr)
 {
 	struct lpi2c_imx_struct *lpi2c_imx = dev_get_drvdata(dev);
 	struct lpi2c_imx_dma *dma;
+	void *group;
 	int ret;
 
-	dma = devm_kzalloc(dev, sizeof(*dma), GFP_KERNEL);
-	if (!dma)
+	/*
+	 * Open a devres group so that all resources allocated within
+	 * this function can be released together if DMA init fails but
+	 * probe continues in PIO mode.
+	 */
+	group = devres_open_group(dev, NULL, GFP_KERNEL);
+	if (!group)
 		return -ENOMEM;
 
+	dma = devm_kzalloc(dev, sizeof(*dma), GFP_KERNEL);
+	if (!dma) {
+		ret = -ENOMEM;
+		goto release_group;
+	}
+
 	dma->phy_addr = phy_addr;
 
 	/* Prepare for TX DMA: */
-	dma->chan_tx = dma_request_chan(dev, "tx");
+	dma->chan_tx = devm_dma_request_chan(dev, "tx");
 	if (IS_ERR(dma->chan_tx)) {
 		ret = PTR_ERR(dma->chan_tx);
 		if (ret != -ENODEV && ret != -EPROBE_DEFER)
 			dev_err(dev, "can't request DMA tx channel (%d)\n", ret);
-		dma->chan_tx = NULL;
-		goto dma_exit;
+		goto release_group;
 	}
 
 	/* Prepare for RX DMA: */
-	dma->chan_rx = dma_request_chan(dev, "rx");
+	dma->chan_rx = devm_dma_request_chan(dev, "rx");
 	if (IS_ERR(dma->chan_rx)) {
 		ret = PTR_ERR(dma->chan_rx);
 		if (ret != -ENODEV && ret != -EPROBE_DEFER)
 			dev_err(dev, "can't request DMA rx channel (%d)\n", ret);
-		dma->chan_rx = NULL;
-		goto dma_exit;
+		goto release_group;
 	}
 
+	/*
+	 * DMA init succeeded. Remove the group marker but keep all resources
+	 * bound to the device, they will be freed at device removal.
+	 */
+	devres_remove_group(dev, group);
+
 	lpi2c_imx->can_use_dma = true;
 	lpi2c_imx->dma = dma;
 	return 0;
 
-dma_exit:
-	dma_exit(dev, dma);
+release_group:
+	/*
+	 * DMA init failed. Release ALL resources allocated inside this
+	 * group (dma memory, TX channel if already acquired, etc.) so
+	 * that a successful PIO-mode probe does not hold unused resources
+	 * for the entire device lifetime.
+	 */
+	devres_release_group(dev, group);
 	return ret;
 }
 



