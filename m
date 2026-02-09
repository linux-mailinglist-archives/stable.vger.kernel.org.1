Return-Path: <stable+bounces-215059-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IFF3NavxiWnGEgAAu9opvQ
	(envelope-from <stable+bounces-215059-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 15:39:39 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5161E110A4A
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 15:39:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 86EF93031312
	for <lists+stable@lfdr.de>; Mon,  9 Feb 2026 14:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E65501DE8AD;
	Mon,  9 Feb 2026 14:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OZLA43iS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB82285060;
	Mon,  9 Feb 2026 14:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770647537; cv=none; b=UNO5ljxVQE1t/gJ+x3f82BYdhuBwH8g+q4k8jPUV9AvutCJiJIQPHIC5hygaX7ZlwVSiqgmG3Dg+Kc0Xj+0YN6LR5afiJpu0nnw9Tkmq2LR7luTM/TgYRa9ZTRi3uZ/DKhwjBG2QcfwnMsYxshlQBAv9YAgDfo/HF7WL7V+4IG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770647537; c=relaxed/simple;
	bh=76pVESjc1L/MWtvvI0zAXh3GAQf0THawHyeALekAjag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GdMV1kvpaERZwWYJGTJ1q8UrgwXbHYYoWlnsjwinZiPN8pDDPkcqyl37ftBF6Rnw2eiQa+uap7E3ywauZJs9wV5mjNShGeHFJ4SR39hhUSMqQ4R40hqASjIA7Lxxie9b0DzKbyeppR1ueSSByKZNP6ts9REspxM0MMePS1L3vwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OZLA43iS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 101BAC116C6;
	Mon,  9 Feb 2026 14:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770647537;
	bh=76pVESjc1L/MWtvvI0zAXh3GAQf0THawHyeALekAjag=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OZLA43iSiCcy2OGnjqpGpFSUxBcGVgvaw5Hd3Z1zaZWifGRHgexkv0QWzqiLoAZqW
	 FnOsCYpGfb8vS3GJscXQQTv/vK7zoS7z3vYqQeWFxIOShDmc8VQ4zOBrX0bvx97n0c
	 eUvtYC+AEjZHjm4DU/tzxvNOUv28OyVUvqfrld44=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Devyn Liu <liudingyuan@h-partners.com>,
	Yang Shen <shenyang39@huawei.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 095/175] spi: hisi-kunpeng: Fixed the wrong debugfs node name in hisi_spi debugfs initialization
Date: Mon,  9 Feb 2026 15:22:48 +0100
Message-ID: <20260209142323.843967286@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260209142320.474120190@linuxfoundation.org>
References: <20260209142320.474120190@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-215059-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huawei.com:email,h-partners.com:email]
X-Rspamd-Queue-Id: 5161E110A4A
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Devyn Liu <liudingyuan@h-partners.com>

[ Upstream commit b062a899c997df7b9ce29c62164888baa7a85833 ]

In hisi_spi_debugfs_init, spi controller pointer is calculated
by container_of macro, and the member is hs->dev. But the host
cannot be calculated offset directly by this. (hs->dev) points
to (pdev->dev), and it is the (host->dev.parent) rather than
(host->dev) points to the (pdev->dev), which is set in
__spi_alloc_controller.

In this patch, this issues is fixed by getting the spi_controller
data from pdev->dev by dev_get_drvdata() directly. (dev->driver_data)
points to the spi controller data in the probe stage.

Signed-off-by: Devyn Liu <liudingyuan@h-partners.com>
Reviewed-by: Yang Shen <shenyang39@huawei.com>
Link: https://patch.msgid.link/20260108075323.3831574-1-liudingyuan@h-partners.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-hisi-kunpeng.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/spi/spi-hisi-kunpeng.c b/drivers/spi/spi-hisi-kunpeng.c
index dadf558dd9c0c..80a1a15de0bc3 100644
--- a/drivers/spi/spi-hisi-kunpeng.c
+++ b/drivers/spi/spi-hisi-kunpeng.c
@@ -161,10 +161,8 @@ static const struct debugfs_reg32 hisi_spi_regs[] = {
 static int hisi_spi_debugfs_init(struct hisi_spi *hs)
 {
 	char name[32];
+	struct spi_controller *host = dev_get_drvdata(hs->dev);
 
-	struct spi_controller *host;
-
-	host = container_of(hs->dev, struct spi_controller, dev);
 	snprintf(name, 32, "hisi_spi%d", host->bus_num);
 	hs->debugfs = debugfs_create_dir(name, NULL);
 	if (IS_ERR(hs->debugfs))
-- 
2.51.0




