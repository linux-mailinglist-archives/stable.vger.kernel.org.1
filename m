Return-Path: <stable+bounces-220729-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YJYIAUZBo2kR+wQAu9opvQ
	(envelope-from <stable+bounces-220729-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:25:58 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BF861C6FAD
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:25:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CA077313857D
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB7623FFAAB;
	Sat, 28 Feb 2026 17:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mo0AK2th"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E80F3FFAA1;
	Sat, 28 Feb 2026 17:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300610; cv=none; b=DxNijYkf7YSqaMu6b63TGLKwTGsUiTCTUrC3pctxLTOJG1EclyXhrY2P4m2lCVCrTrGkvVH1D+YBoMuSGpUbAEiSR39ICq1qJP8BS56GE2HdjC2/0Ss93gkI1/HSIJXJN/ESTBNeFAlmN5nQ/hkkVUXlglzUWPsVATbMFQX5xN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300610; c=relaxed/simple;
	bh=SYAvbUPBTIIJtIjD/wMStO6QYPKYZW9xNsUaYMKwkMY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WJl8bFKVFTrnUc+FKQe3v03pCS4w4TijBitQ11dhi/CqSPDJDqb3t7Vh0jI9ZkHD3LpvZEetkAscoJDHMPiCxWBiG0EmsAPq1jH5aHGykiSoosFTd4LL7yOV14YwhJG+UajDRFytGxFkZ2EphCN/UDSL6GDPoRXU+7N5/OZepQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mo0AK2th; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2C21C4AF09;
	Sat, 28 Feb 2026 17:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300610;
	bh=SYAvbUPBTIIJtIjD/wMStO6QYPKYZW9xNsUaYMKwkMY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Mo0AK2thyK6u84Nh66D8uonpH1SadLnf11BQzqQyeOcoUg+7Ju//vFuEIGWvcOvAP
	 cnqRBwzL8dB6cughXJM7DwuLQavC/xXXU7O1ctb4hNakniPsx8WVEtUhtvJx4Pkkic
	 bzdr/P4QHBvU/vL8OYmNgaXS8W1spEWqiVsH99D+H2PE/u3U2mYCnPrUuycN5ij6VJ
	 qUvalyVmYMNLM6AS/uUqXU5ekQDbhSpVDuT+rxQ5yiFoPW6Cqbee7W4UoLY3mlbmDC
	 338RQ5PYkuebjzQPe10CzHhILVN5UtGKx7oWZnuYHLdTIqKpYneXW/jeQwBifcur4F
	 3FedKmM5cKtbQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Xu Yang <xu.yang_2@nxp.com>,
	Frank Li <Frank.Li@nxp.com>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 650/844] phy: fsl-imx8mq-usb: set platform driver data
Date: Sat, 28 Feb 2026 12:29:23 -0500
Message-ID: <20260228173244.1509663-651-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220729-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,msgid.link:url,nxp.com:email]
X-Rspamd-Queue-Id: 9BF861C6FAD
X-Rspamd-Action: no action

From: Xu Yang <xu.yang_2@nxp.com>

[ Upstream commit debf8326a435ac746f48173e4742a574810f1ff4 ]

Add missing platform_set_drvdata() as the data will be used in remove().

Fixes: b58f0f86fd61 ("phy: fsl-imx8mq-usb: add tca function driver for imx95")
Cc: stable@vger.kernel.org
Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Link: https://patch.msgid.link/20260120111646.3159766-1-xu.yang_2@nxp.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/phy/freescale/phy-fsl-imx8mq-usb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/phy/freescale/phy-fsl-imx8mq-usb.c b/drivers/phy/freescale/phy-fsl-imx8mq-usb.c
index b30d01f345d20..9c340c889c80c 100644
--- a/drivers/phy/freescale/phy-fsl-imx8mq-usb.c
+++ b/drivers/phy/freescale/phy-fsl-imx8mq-usb.c
@@ -676,6 +676,8 @@ static int imx8mq_usb_phy_probe(struct platform_device *pdev)
 	if (!imx_phy)
 		return -ENOMEM;
 
+	platform_set_drvdata(pdev, imx_phy);
+
 	imx_phy->clk = devm_clk_get(dev, "phy");
 	if (IS_ERR(imx_phy->clk)) {
 		dev_err(dev, "failed to get imx8mq usb phy clock\n");
-- 
2.51.0


