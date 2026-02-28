Return-Path: <stable+bounces-220300-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UDrwAqk0o2mX+QQAu9opvQ
	(envelope-from <stable+bounces-220300-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:32:09 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 61A0E1C5E92
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:32:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 56045318F928
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31C6B38C59B;
	Sat, 28 Feb 2026 17:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PQndlpQj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E621338C591;
	Sat, 28 Feb 2026 17:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300204; cv=none; b=X31ypbe8jrJvFY/aa0RfVQM2+UWAWYT58GhwnnHvxm/O3iFEjSFKPVJr/7ev2FEEUZzmnnTXkQImdTZDXQ+5lX5mgdbEhMwSeORXb4bcD/Xgag294m87LDn1bbqpRq2I2+VZbZ0Wb/zMcT9XMXj2KsrQp8SUEha6Hj96I+4USyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300204; c=relaxed/simple;
	bh=hP6cVlLON+uh6FuJSf/xYghLQsTOr3q/hDuSMfwlsow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mSehLgx5rKxINaxScbiVeHEc1iPnizkA9QQHJbCA17sbl6Hm85VygEfPO96siil09ksdjGRyUFd7mKclPZg/klGMxjs+Oz7CdVqc21MgFFv0oKX6oCxBvIf+UZfAuKolel5lRZkc9zgLaq2DuYB16Jv7G6bv/P48+DZ2vZtbAJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PQndlpQj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A9C2C19423;
	Sat, 28 Feb 2026 17:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300203;
	bh=hP6cVlLON+uh6FuJSf/xYghLQsTOr3q/hDuSMfwlsow=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PQndlpQjfUFg14dgTkcY0/XafVsc1PURH/YwPJn39+lXbVeN68XGJHiwKO0i6teiW
	 Q58uh96TqslcUPZ4orrqd9Etr/w2sErwZpAtHJqy0ISj8LG++CdxUPc97/xF67F8a0
	 brZtkQHf1vo7DbwojFHUz5R9NyddrQBYrwglEyKo81zdTQF4RQ20MWOoH9AdOZLowP
	 ihbqUDs3tk2JjYtkb2mWErYxjxJ57TgZwLQh9wejhOaDjzbwicFMSo9IDKMMUgP7Cj
	 UPyaWB7qhvMgMIvuJ43LMQvXqDs9WLbcvccQlWyvim+ARQpvrjDTz/45fyAV8+Ikin
	 KfNi1C50Ofm3A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Miquel Raynal (Schneider Electric)" <miquel.raynal@bootlin.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Santhosh Kumar K <s-k6@ti.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 222/844] spi: cadence-qspi: Fix probe error path and remove
Date: Sat, 28 Feb 2026 12:22:15 -0500
Message-ID: <20260228173244.1509663-223-sashal@kernel.org>
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
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220300-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.979];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,renesas];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 61A0E1C5E92
X-Rspamd-Action: no action

From: "Miquel Raynal (Schneider Electric)" <miquel.raynal@bootlin.com>

[ Upstream commit f18c8cfa4f1af2cf7d68d86989a7d6109acfa1bb ]

The probe has been modified by many different users, it is hard to track
history, but for sure its current state is partially broken. One easy
rule to follow is to drop/free/release the resources in the opposite
order they have been queried.

Fix the labels, the order for freeing the resources, and add the
missing DMA channel step. Replicate these changes in the remove path as
well.

Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Miquel Raynal (Schneider Electric) <miquel.raynal@bootlin.com>
Tested-by: Santhosh Kumar K <s-k6@ti.com>
Link: https://patch.msgid.link/20260122-schneider-6-19-rc1-qspi-v4-8-f9c21419a3e6@bootlin.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-cadence-quadspi.c | 44 ++++++++++++++++++-------------
 1 file changed, 25 insertions(+), 19 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index b1cf182d65665..ab74808debe98 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -1891,7 +1891,7 @@ static int cqspi_probe(struct platform_device *pdev)
 	ret = clk_prepare_enable(cqspi->clk);
 	if (ret) {
 		dev_err(dev, "Cannot enable QSPI clock.\n");
-		goto probe_clk_failed;
+		goto disable_rpm;
 	}
 
 	/* Obtain QSPI reset control */
@@ -1899,14 +1899,14 @@ static int cqspi_probe(struct platform_device *pdev)
 	if (IS_ERR(rstc)) {
 		ret = PTR_ERR(rstc);
 		dev_err(dev, "Cannot get QSPI reset.\n");
-		goto probe_reset_failed;
+		goto disable_clk;
 	}
 
 	rstc_ocp = devm_reset_control_get_optional_exclusive(dev, "qspi-ocp");
 	if (IS_ERR(rstc_ocp)) {
 		ret = PTR_ERR(rstc_ocp);
 		dev_err(dev, "Cannot get QSPI OCP reset.\n");
-		goto probe_reset_failed;
+		goto disable_clk;
 	}
 
 	if (of_device_is_compatible(pdev->dev.of_node, "starfive,jh7110-qspi")) {
@@ -1914,7 +1914,7 @@ static int cqspi_probe(struct platform_device *pdev)
 		if (IS_ERR(rstc_ref)) {
 			ret = PTR_ERR(rstc_ref);
 			dev_err(dev, "Cannot get QSPI REF reset.\n");
-			goto probe_reset_failed;
+			goto disable_clk;
 		}
 		reset_control_assert(rstc_ref);
 		reset_control_deassert(rstc_ref);
@@ -1956,7 +1956,7 @@ static int cqspi_probe(struct platform_device *pdev)
 		if (ddata->jh7110_clk_init) {
 			ret = cqspi_jh7110_clk_init(pdev, cqspi);
 			if (ret)
-				goto probe_reset_failed;
+				goto disable_clk;
 		}
 		if (ddata->quirks & CQSPI_DISABLE_STIG_MODE)
 			cqspi->disable_stig_mode = true;
@@ -1964,7 +1964,7 @@ static int cqspi_probe(struct platform_device *pdev)
 		if (ddata->quirks & CQSPI_DMA_SET_MASK) {
 			ret = dma_set_mask(&pdev->dev, DMA_BIT_MASK(64));
 			if (ret)
-				goto probe_reset_failed;
+				goto disable_clks;
 		}
 	}
 
@@ -1975,7 +1975,7 @@ static int cqspi_probe(struct platform_device *pdev)
 			       pdev->name, cqspi);
 	if (ret) {
 		dev_err(dev, "Cannot request IRQ.\n");
-		goto probe_reset_failed;
+		goto disable_clks;
 	}
 
 	cqspi_wait_idle(cqspi);
@@ -2002,31 +2002,36 @@ static int cqspi_probe(struct platform_device *pdev)
 		ret = cqspi_request_mmap_dma(cqspi);
 		if (ret == -EPROBE_DEFER) {
 			dev_err_probe(&pdev->dev, ret, "Failed to request mmap DMA\n");
-			goto probe_setup_failed;
+			goto disable_controller;
 		}
 	}
 
 	ret = spi_register_controller(host);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to register SPI ctlr %d\n", ret);
-		goto probe_setup_failed;
+		goto release_dma_chan;
 	}
 
 	if (!(ddata && (ddata->quirks & CQSPI_DISABLE_RUNTIME_PM)))
 		pm_runtime_put_autosuspend(dev);
 
 	return 0;
-probe_setup_failed:
-	if (!(ddata && (ddata->quirks & CQSPI_DISABLE_RUNTIME_PM)))
-		pm_runtime_disable(dev);
+
+release_dma_chan:
+	if (cqspi->rx_chan)
+		dma_release_channel(cqspi->rx_chan);
+disable_controller:
 	cqspi_controller_enable(cqspi, 0);
-probe_reset_failed:
+disable_clks:
 	if (cqspi->is_jh7110)
 		cqspi_jh7110_disable_clk(pdev, cqspi);
-
+disable_clk:
 	if (pm_runtime_get_sync(&pdev->dev) >= 0)
 		clk_disable_unprepare(cqspi->clk);
-probe_clk_failed:
+disable_rpm:
+	if (!(ddata && (ddata->quirks & CQSPI_DISABLE_RUNTIME_PM)))
+		pm_runtime_disable(dev);
+
 	return ret;
 }
 
@@ -2044,18 +2049,19 @@ static void cqspi_remove(struct platform_device *pdev)
 		cqspi_wait_idle(cqspi);
 
 	spi_unregister_controller(cqspi->host);
-	cqspi_controller_enable(cqspi, 0);
 
 	if (cqspi->rx_chan)
 		dma_release_channel(cqspi->rx_chan);
 
-	if (!(ddata && (ddata->quirks & CQSPI_DISABLE_RUNTIME_PM)))
-		if (pm_runtime_get_sync(&pdev->dev) >= 0)
-			clk_disable(cqspi->clk);
+	cqspi_controller_enable(cqspi, 0);
 
 	if (cqspi->is_jh7110)
 		cqspi_jh7110_disable_clk(pdev, cqspi);
 
+	if (!(ddata && (ddata->quirks & CQSPI_DISABLE_RUNTIME_PM)))
+		if (pm_runtime_get_sync(&pdev->dev) >= 0)
+			clk_disable(cqspi->clk);
+
 	if (!(ddata && (ddata->quirks & CQSPI_DISABLE_RUNTIME_PM))) {
 		pm_runtime_put_sync(&pdev->dev);
 		pm_runtime_disable(&pdev->dev);
-- 
2.51.0


