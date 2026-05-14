Return-Path: <stable+bounces-247104-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IK5hAmhRBWo+UwIAu9opvQ
	(envelope-from <stable+bounces-247104-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 06:36:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 04F5253DBBF
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 06:36:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 58E2930093BF
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 04:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99F8A38F621;
	Thu, 14 May 2026 04:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gqe6bLny"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9353AB267
	for <stable@vger.kernel.org>; Thu, 14 May 2026 04:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778733395; cv=none; b=P2qC/e0FAWQyN4cLY0eI7B33qsTEW6TwUG1xKjzO/s1GJd66lq2xJZfwwEnmyPEMaRAnxy1FwITyvCDRKQm2LkqlB0YejiHP+XW5Vz3LqfU1Bqkrsg0Fn8NuwNsKXOBaU7Co/KVAToTitqFfna4mLcVRxsXD+Rk3Yw1X4fg5IH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778733395; c=relaxed/simple;
	bh=NpjBNmhuVgxekzmBStCt7JWuadYs8hVubDKNT0fch1s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KagrAdFgFkKzhko4UruDhNbCRf3WFqC6YqxFluro0UHzkBXPFUGCmgsZ98Syka+WgIjPDSpOGNmSUaRzMp7EOucfyIALp2ZD7u5mXgf5i4gCDEJQNKt9gHfCVuXnUhmvozkF3D5O7Bhyi3ILrKj35vOBVyGHsKQBULM/0PeNwPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gqe6bLny; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F504C2BCC6;
	Thu, 14 May 2026 04:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778733395;
	bh=NpjBNmhuVgxekzmBStCt7JWuadYs8hVubDKNT0fch1s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Gqe6bLnyMlqAn2W7/4lQN3pHIVSoMrL0QhUPFZ38ZEB8muAQqjy3RwF0fD2UO70NC
	 TrnWoq0lesyYWmEpuybENHMdenZWlW+KZkZH44Y86+5lUTSH+7tB3A4ZJAxyY/Mica
	 FhMUn6ue5A+CdPQImPc2QjjkcksgJigZv1Rof5kXzRmJjA5FXCPbrPvk7RjK6fT5UZ
	 zi/5k+b3qVvssHOD0dEObglw/tXqN5sVn1N/vonnzyLvVEDUj707/HYmFYrRbQYbrG
	 yr30VDNiU2CVvB2w65DTasx/rpXT72RxjNVL//8bvUP+9iSLqGfsHXyFjsPaL4FprB
	 hfrCjIZUuVsZw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	Keiji Hayashibara <hayashibara.keiji@socionext.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0.y 2/2] spi: uniphier: fix controller deregistration
Date: Thu, 14 May 2026 00:36:31 -0400
Message-ID: <20260514043631.10946-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260514043631.10946-1-sashal@kernel.org>
References: <2026051212-foam-sharpness-9164@gregkh>
 <20260514043631.10946-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 04F5253DBBF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247104-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[socionext.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,msgid.link:url]
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-uniphier.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-uniphier.c b/drivers/spi/spi-uniphier.c
index 1b815ee2ed1b6..eac6c3e8908bd 100644
--- a/drivers/spi/spi-uniphier.c
+++ b/drivers/spi/spi-uniphier.c
@@ -746,7 +746,7 @@ static int uniphier_spi_probe(struct platform_device *pdev)
 
 	host->max_dma_len = min(dma_tx_burst, dma_rx_burst);
 
-	ret = devm_spi_register_controller(&pdev->dev, host);
+	ret = spi_register_controller(host);
 	if (ret)
 		goto out_release_dma;
 
@@ -771,10 +771,16 @@ static void uniphier_spi_remove(struct platform_device *pdev)
 {
 	struct spi_controller *host = platform_get_drvdata(pdev);
 
+	spi_controller_get(host);
+
+	spi_unregister_controller(host);
+
 	if (host->dma_tx)
 		dma_release_channel(host->dma_tx);
 	if (host->dma_rx)
 		dma_release_channel(host->dma_rx);
+
+	spi_controller_put(host);
 }
 
 static const struct of_device_id uniphier_spi_match[] = {
-- 
2.53.0


