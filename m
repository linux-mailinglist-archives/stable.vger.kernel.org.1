Return-Path: <stable+bounces-247109-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GDVwC4FWBWqAVAIAu9opvQ
	(envelope-from <stable+bounces-247109-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 06:58:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 96A4753DCBB
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 06:58:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9AE453014C5B
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 04:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A71433A3E69;
	Thu, 14 May 2026 04:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MtnYO4TJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE4A1DE894
	for <stable@vger.kernel.org>; Thu, 14 May 2026 04:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778734716; cv=none; b=JkU6UwuMm2cAkPMK9aHds0L4b7xoF5PsyhUDLay3tSfp/bBTPeYw899N3Jzy8fpNZ8wOvG7+KlMGPI6GMjyhujSzqRtcuoxHWExhw7OUj0YIknj6EuOvAQQcaLpW6FfoUgRjTgXvwdfRQA6+J0IVAEAioCDtVfsta7VtLQg7ruc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778734716; c=relaxed/simple;
	bh=LnFCEdmjKP3zBowvz4/rtam+aV5YCBmERQ9hoQLhBrA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SUYfkWHJi38dnJrMJQUV3o5lh4ycMv9W1HLTQ5MyPYkMo9euQqda6+Vuv5/1b6UPKfQMLNLiwJtiraqLYdG3xk6hF5ib2IIuWMZ/F3zQBklfxXUHjMG5aXzoAdzhBXBFuEsqXenCt1c0fbFBoGqFgmQhpDDH+q+6o0uQaH6yBM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MtnYO4TJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81CA9C2BCB7;
	Thu, 14 May 2026 04:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778734716;
	bh=LnFCEdmjKP3zBowvz4/rtam+aV5YCBmERQ9hoQLhBrA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MtnYO4TJickDW8KANzKrMQMdYIUQ+gFjP7CVMSFx/gDdOWbddRCs1mkCD18o226De
	 RoKldg/XOXA3ToJ6gJMMpuxSsq3xyViZcWAWbVON/2la8tst6VPc9IuOZMlyARfyx0
	 4pg3C0LnGF+0Gr7Ij0PYMwvSW2n2fNeFZKc4wBG8XIuVODzKFE4BGQ7yX/jyZ0Gvqd
	 i8fQX1uuE/O8G+0DSi0LrE1bx2NI5hX3H1Dx6wtQdpodCpBb7EwH224ZYP3WNF0QQc
	 VmhL6Fosb60hSdtqMG9ElURx4EUTavPnqzRNC1+7RX85N1ow0kDqkgAzLwAtfQcmLL
	 Z5IyGUgE2HDow==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pei Xiao <xiaopei01@kylinos.cn>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] spi: uniphier: Simplify clock handling with devm_clk_get_enabled()
Date: Thu, 14 May 2026 00:58:32 -0400
Message-ID: <20260514045833.24151-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026051213-catching-hypnotize-7dee@gregkh>
References: <2026051213-catching-hypnotize-7dee@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 96A4753DCBB
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
	TAGGED_FROM(0.00)[bounces-247109-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[socionext.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url,kylinos.cn:email]
X-Rspamd-Action: no action

From: Pei Xiao <xiaopei01@kylinos.cn>

[ Upstream commit fdca270f8f87cae2eb5b619234b9dd11a863ce6b ]

Replace devm_clk_get() followed by clk_prepare_enable() with
devm_clk_get_enabled() for the clock. This removes the need for
explicit clock enable and disable calls, as the managed API automatically
handles clock disabling on device removal or probe failure.

Remove the now-unnecessary clk_disable_unprepare() calls from the probe
error path and the remove callback. Adjust error labels accordingly.

Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
Reviewed-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Link: https://patch.msgid.link/b2deeefd4ef1a4bce71116aabfcb7e81400f6d37.1775546948.git.xiaopei01@kylinos.cn
Signed-off-by: Mark Brown <broonie@kernel.org>
Stable-dep-of: 0245435f7772 ("spi: uniphier: fix controller deregistration")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-uniphier.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/drivers/spi/spi-uniphier.c b/drivers/spi/spi-uniphier.c
index ff2142f87277f..b517c08a13608 100644
--- a/drivers/spi/spi-uniphier.c
+++ b/drivers/spi/spi-uniphier.c
@@ -666,28 +666,24 @@ static int uniphier_spi_probe(struct platform_device *pdev)
 	}
 	priv->base_dma_addr = res->start;
 
-	priv->clk = devm_clk_get(&pdev->dev, NULL);
+	priv->clk = devm_clk_get_enabled(&pdev->dev, NULL);
 	if (IS_ERR(priv->clk)) {
 		dev_err(&pdev->dev, "failed to get clock\n");
 		ret = PTR_ERR(priv->clk);
 		goto out_host_put;
 	}
 
-	ret = clk_prepare_enable(priv->clk);
-	if (ret)
-		goto out_host_put;
-
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
 		ret = irq;
-		goto out_disable_clk;
+		goto out_host_put;
 	}
 
 	ret = devm_request_irq(&pdev->dev, irq, uniphier_spi_handler,
 			       0, "uniphier-spi", priv);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to request IRQ\n");
-		goto out_disable_clk;
+		goto out_host_put;
 	}
 
 	init_completion(&priv->xfer_done);
@@ -717,7 +713,7 @@ static int uniphier_spi_probe(struct platform_device *pdev)
 	if (IS_ERR_OR_NULL(host->dma_tx)) {
 		if (PTR_ERR(host->dma_tx) == -EPROBE_DEFER) {
 			ret = -EPROBE_DEFER;
-			goto out_disable_clk;
+			goto out_host_put;
 		}
 		host->dma_tx = NULL;
 		dma_tx_burst = INT_MAX;
@@ -767,9 +763,6 @@ static int uniphier_spi_probe(struct platform_device *pdev)
 		host->dma_tx = NULL;
 	}
 
-out_disable_clk:
-	clk_disable_unprepare(priv->clk);
-
 out_host_put:
 	spi_controller_put(host);
 	return ret;
@@ -778,14 +771,11 @@ static int uniphier_spi_probe(struct platform_device *pdev)
 static void uniphier_spi_remove(struct platform_device *pdev)
 {
 	struct spi_controller *host = platform_get_drvdata(pdev);
-	struct uniphier_spi_priv *priv = spi_controller_get_devdata(host);
 
 	if (host->dma_tx)
 		dma_release_channel(host->dma_tx);
 	if (host->dma_rx)
 		dma_release_channel(host->dma_rx);
-
-	clk_disable_unprepare(priv->clk);
 }
 
 static const struct of_device_id uniphier_spi_match[] = {
-- 
2.53.0


