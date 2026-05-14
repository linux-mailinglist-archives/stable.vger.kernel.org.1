Return-Path: <stable+bounces-247195-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4BHRGRPDBWpMbAIAu9opvQ
	(envelope-from <stable+bounces-247195-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 14:41:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 15256541CD4
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 14:41:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 985AB302C352
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 12:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E8F23C0A15;
	Thu, 14 May 2026 12:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ceqZS9cE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22AB422068D
	for <stable@vger.kernel.org>; Thu, 14 May 2026 12:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778762487; cv=none; b=K5ijV5shnvkrjl6XvJyM4CsJHFz0pwql3iLc9FApqWdEJmpXnHpuXfbGNJONhPT0LVESZhp+c/cQ9Ou5vGIRVhnW/H10X+Qo8yJJuD8rYesFtzT43nJRgOXmAM7nMfklAT/3vDXKeGKQtiL1OCYKbuCudy9zG74JVEve8HIt7Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778762487; c=relaxed/simple;
	bh=8XLfVOyCfJGPtpoL8jKbGTOHeW9v9rT94B4kspV4F4A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pgajoT46K0+X+Zd4JF6/xaGckahKoBctEKlBJOCbdGcq4pJudtQZU80RW9BAHL0UdBG0dZfjetEnXpjg7IqBY8EMi16/J8602W2noiXaCV7TSSvNgwLO35gDklQH3ZzgfII3kEhG4r+j0NhOK6PhGh4ZCIf2IJcXE5fCYtST7oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ceqZS9cE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 328B0C2BCB3;
	Thu, 14 May 2026 12:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778762486;
	bh=8XLfVOyCfJGPtpoL8jKbGTOHeW9v9rT94B4kspV4F4A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ceqZS9cEo53h/pXEb4vaEFXWqyCdcBKbncUFr9OmEWUhLydvOnC6ayEQZztJDBij6
	 YcTTLfHDuUW+Ax1a6M49e4knB19wWHD7MZ8WEa6Je/U8+xRe+BiBu1GKMLy9udZSr9
	 gwQwio5ECZBQ95wHiU1VjIdmIBpG8vDqYe2c7OprBBF2J0skKqdJVON9fcnpdelLL6
	 gZGlorf0jeWJc2MuFmFeAQqvfQ0wgj5TgyH8kvlgeviUSI6IRGjm/G6fC4j/UbNVyp
	 CJOmIpJ8F9YXuw0DKpz8PyCvV5Z6nX22dTWBoTrISLkjg3qONS0sQuEBDlHZsldCyH
	 ki66btlR6wJkQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	Keiji Hayashibara <hayashibara.keiji@socionext.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] spi: uniphier: fix controller deregistration
Date: Thu, 14 May 2026 08:41:24 -0400
Message-ID: <20260514124124.212147-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026051214-aching-old-35ed@gregkh>
References: <2026051214-aching-old-35ed@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 15256541CD4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247195-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
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
index cc0da48222311..05f43d67d6243 100644
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


