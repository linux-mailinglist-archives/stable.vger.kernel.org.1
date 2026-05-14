Return-Path: <stable+bounces-247202-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oFFHHCTJBWqFbQIAu9opvQ
	(envelope-from <stable+bounces-247202-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 15:07:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CCD9D5421DE
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 15:07:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EA634306E678
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 13:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B270A3DEACE;
	Thu, 14 May 2026 13:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GgEC5WiW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 762E318A6CF
	for <stable@vger.kernel.org>; Thu, 14 May 2026 13:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778764001; cv=none; b=ZBIsR0ZiAvEL7xVMsRAQ74us+88ohvlXAHYvfcOxOe7IQI3mcmC/SjZPf4AHYRa9bQSAxwPJow7aNOcyhv2b/uvTEp4styQYcYFrx9qO9SCW0yUii7xSBuE/G6YdwFv0u+xY/nKsyXJFBpkNbHDYDvk54i6HgL//3Tiz0KJkA0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778764001; c=relaxed/simple;
	bh=xvEOOnCge4olF8YpTBC28AzFrMhY9i/xAywFEIPPP0k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GC+Il13uwsERWumXxPwUU9g7Ti8JjF2E/LYV7A7c1m6Y7eTjfNP61r6yqvwiYvMXtYVbDPxBSSCevgYO9Qox90yUU46BXDU07II93OxkMqm+YKktkOy+EF/FBAA6U+aO00Vr9FhG9YnrJeTlbEkBV3RgYpOZtzBclj+QMYYcQLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GgEC5WiW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 925FAC2BCB8;
	Thu, 14 May 2026 13:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778764001;
	bh=xvEOOnCge4olF8YpTBC28AzFrMhY9i/xAywFEIPPP0k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GgEC5WiW3C4GmJsjC05ZUdl4MZ0ZddxvzQ/M/+xSOyioiYMPO1UuiyLFuUpFmdmX3
	 h5VwfdpQ28pa43indUK//qNmcQD1G8XnqYm6S6ZfFyfQXEIL9a2WQTvu13kJlsqApu
	 Jc5VWJpmaexggN+F83CxctHmn3LLjUlrHcsgOKmZ+hWtdC1MNUF5O8B88+0jAZ4vWn
	 0Rp5H5ectijWXupCsN4kHF1pgKFH8rILjK3WA977u9tg/tU3f7fGKTTSL655Ze4dGW
	 jq8n5lPjXiyicyEv1lqJBt+whMnILwd8oFbC/rgggjKJHDfYBdtKTDjwXaAi5kfDwr
	 cTXCcZX+nqaVw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	Keiji Hayashibara <hayashibara.keiji@socionext.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] spi: uniphier: fix controller deregistration
Date: Thu, 14 May 2026 09:06:38 -0400
Message-ID: <20260514130638.228220-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026051214-stoppable-boney-c3ce@gregkh>
References: <2026051214-stoppable-boney-c3ce@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: CCD9D5421DE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247202-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,socionext.com:email]
X-Rspamd-Action: no action

From: Johan Hovold <johan@kernel.org>

[ Upstream commit 0245435f777264ac45945ed2f325dd095a41d1af ]

Make sure to deregister the controller before releasing underlying
resources like DMA during driver unbind.

Note that clocks were also disabled before the recent commit
fdca270f8f87 ("spi: uniphier: Simplify clock handling with
devm_clk_get_enabled()").

Fixes: 5ba155a4d4cc ("spi: add SPI controller driver for UniPhier SoC")
Cc: stable@vger.kernel.org	# 4.19
Cc: Keiji Hayashibara <hayashibara.keiji@socionext.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://patch.msgid.link/20260410081757.503099-25-johan@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
[ renamed spi_*_controller/host APIs to spi_*_master/master aliases and kept the pre-existing clk_disable_unprepare() after unregister ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-uniphier.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-uniphier.c b/drivers/spi/spi-uniphier.c
index ad0088e394723..1b9a8d7ff091d 100644
--- a/drivers/spi/spi-uniphier.c
+++ b/drivers/spi/spi-uniphier.c
@@ -751,7 +751,7 @@ static int uniphier_spi_probe(struct platform_device *pdev)
 
 	master->max_dma_len = min(dma_tx_burst, dma_rx_burst);
 
-	ret = devm_spi_register_master(&pdev->dev, master);
+	ret = spi_register_master(master);
 	if (ret)
 		goto out_release_dma;
 
@@ -780,6 +780,10 @@ static int uniphier_spi_remove(struct platform_device *pdev)
 	struct spi_master *master = platform_get_drvdata(pdev);
 	struct uniphier_spi_priv *priv = spi_master_get_devdata(master);
 
+	spi_master_get(master);
+
+	spi_unregister_master(master);
+
 	if (master->dma_tx)
 		dma_release_channel(master->dma_tx);
 	if (master->dma_rx)
@@ -787,6 +791,8 @@ static int uniphier_spi_remove(struct platform_device *pdev)
 
 	clk_disable_unprepare(priv->clk);
 
+	spi_master_put(master);
+
 	return 0;
 }
 
-- 
2.53.0


