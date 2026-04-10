Return-Path: <stable+bounces-235597-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CBWVFoyy2Gk8hAgAu9opvQ
	(envelope-from <stable+bounces-235597-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 10:19:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 433ED3D3EC0
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 10:19:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4F3703006120
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 08:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4D703B0ADC;
	Fri, 10 Apr 2026 08:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hzJ+aOVJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34DEB3ACF0B;
	Fri, 10 Apr 2026 08:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775809137; cv=none; b=BjtwqcdlfLrUxpL2uqhgyfhgt6y4nr6DWB45VbViFjArTHJuXrcZjmQ/jQFKmxznME25/HaBufVbgMlz5mpRUEwDoS7kgMpovLT51OQO0i7+Jb35u+oRFYEKgR5xC7ASzP2Sh6C4fueGTmaIBXfpzkzOwr1dDwHEWJ+cyf2IaYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775809137; c=relaxed/simple;
	bh=SHAf3I+yXF6tFQdQ6E9G7b2TWAaGV8lr5L4tBHqtFGM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mV0SnXH3iiZjGXw0AaGeSOwIzlALXw3C/MpggQIGKGAi6ffwz5pgXHVV80fe6VB3lT2/iY0diFgqZ8eXQ9s9g5UqU/Bwaj3vpwqTgP2cu7hzwSdYs+6cOKy3JTrkmCMg/5yTEIJHQ7fmDODPANQ/YksU++NdG7nR4WUAxLyuCQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hzJ+aOVJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96E53C2BCC6;
	Fri, 10 Apr 2026 08:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775809136;
	bh=SHAf3I+yXF6tFQdQ6E9G7b2TWAaGV8lr5L4tBHqtFGM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hzJ+aOVJBjwWhkmSrUOop98ozUK83FJJdEV5izdavhefnuzW/xjNw8E28I6xEg491
	 TGmhx+WSJI166QJvzBIDpIp39ngKL4jiitoWRmCmNzJo5Zz3QoyGEF6vBe3PDRu1Ks
	 YG/yjU9NWjIZW0OWKkWmfFxobFiwGUeIBaneyUGLa6FClAGV4eskOd0HRSEsq9/ZjC
	 pSYiJAm1JdcYoLrMWTRfBG3v2eYD2dr05I1pm2nCm7nKcOWCegWkAvuUgNMLaK/5yR
	 CIgm+2RSrQTRZ/BIKSvJe8LszO8RbJ8WQFfs+gxsE8PuQNV5mB6EqfdnJwK1AgvtoX
	 +YA5uhFYvQuMQ==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wB74n-000000026ue-3vCw;
	Fri, 10 Apr 2026 10:18:53 +0200
From: Johan Hovold <johan@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Avi Fishman <avifishman70@gmail.com>,
	Tomer Maimon <tmaimon77@gmail.com>,
	Tali Perry <tali.perry1@gmail.com>,
	Linus Walleij <linusw@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Paul Walmsley <pjw@kernel.org>,
	Samuel Holland <samuel.holland@sifive.com>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Masahisa Kojima <kojima.masahisa@socionext.com>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Laxman Dewangan <ldewangan@nvidia.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Michal Simek <michal.simek@amd.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH 12/26] spi: sh-hspi: fix controller deregistration
Date: Fri, 10 Apr 2026 10:17:42 +0200
Message-ID: <20260410081757.503099-13-johan@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260410081757.503099-1-johan@kernel.org>
References: <20260410081757.503099-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,collabora.com,nxp.com,pengutronix.de,codeconstruct.com.au,kernel.org,linaro.org,sifive.com,linux.alibaba.com,socionext.com,nvidia.com,amd.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[27];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-235597-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johan@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 433ED3D3EC0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Make sure to deregister the controller before releasing underlying
resources like clocks during driver unbind.

Fixes: 49e599b8595f ("spi: sh-hspi: control spi clock more correctly")
Cc: stable@vger.kernel.org	# 3.4
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/spi/spi-sh-hspi.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-sh-hspi.c b/drivers/spi/spi-sh-hspi.c
index e03eaca1b1a7..1e3ca718ca73 100644
--- a/drivers/spi/spi-sh-hspi.c
+++ b/drivers/spi/spi-sh-hspi.c
@@ -257,9 +257,9 @@ static int hspi_probe(struct platform_device *pdev)
 	ctlr->transfer_one_message = hspi_transfer_one_message;
 	ctlr->bits_per_word_mask = SPI_BPW_MASK(8);
 
-	ret = devm_spi_register_controller(&pdev->dev, ctlr);
+	ret = spi_register_controller(ctlr);
 	if (ret < 0) {
-		dev_err(&pdev->dev, "devm_spi_register_controller error.\n");
+		dev_err(&pdev->dev, "failed to register controller\n");
 		goto error2;
 	}
 
@@ -279,9 +279,15 @@ static void hspi_remove(struct platform_device *pdev)
 {
 	struct hspi_priv *hspi = platform_get_drvdata(pdev);
 
+	spi_controller_get(hspi->ctlr);
+
+	spi_unregister_controller(hspi->ctlr);
+
 	pm_runtime_disable(&pdev->dev);
 
 	clk_put(hspi->clk);
+
+	spi_controller_put(hspi->ctlr);
 }
 
 static const struct of_device_id hspi_of_match[] = {
-- 
2.52.0


