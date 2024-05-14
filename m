Return-Path: <stable+bounces-44477-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F22878C5308
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 13:42:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FB0C1C20AA3
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 11:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE114139572;
	Tue, 14 May 2024 11:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="s0JKObBt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E37C58AC4;
	Tue, 14 May 2024 11:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715686275; cv=none; b=oxnY7i2k1NWoUi0zS0SH42ltzxYDeRj+eLie/RYSqHLohHFTNgEycmF1dEEAVBAZ0C+QLOxY6Mk7kmu6qc7+WU9XW1+cBBC9z3D35lCMtkt4hJ4B8uPefpPiDJ3+AGLapZuhMwg9pv9ALeuIBndZvOlrogr8aUtvUpuxvhBzF44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715686275; c=relaxed/simple;
	bh=wKVNulgnpH2fVJt+y81Fs094StNO0qwJdVYPvyKp3Fo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HZzBCdFgfUqH+blYFEcZG55OSUSCKhrLN19HTnF8u3TxKfoh7wLyuc40I8HJk7+LkJc7r9DKHC0BwCv5HftRvzRuYyWfMVYtm/vGa7NnXRcUxtxrBW/hxLH788MIyrFNeLQsDzW9jBqJc6xqyD1g9GxyGnNGS+YYD/GrLAGkx+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=s0JKObBt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC0EEC2BD10;
	Tue, 14 May 2024 11:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715686275;
	bh=wKVNulgnpH2fVJt+y81Fs094StNO0qwJdVYPvyKp3Fo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s0JKObBt7N01qFY8Oh2TqOsJ5ZeIwdtbF93PxWV0u2GEPDYAH7CImpPZUAN9dBeP3
	 m0u9jHpdivIHOA9xzJcN7nt1Zpi2/5+SWaLLXD216Qfneb8nkwrQtoNyFTcWRt3r7J
	 /IzK9TQkcKR4AfgBvcnOcj1a342BKZNUqquuuXUU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Lechner <dlechner@baylibre.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 049/236] spi: axi-spi-engine: use devm_spi_alloc_host()
Date: Tue, 14 May 2024 12:16:51 +0200
Message-ID: <20240514101022.206362719@linuxfoundation.org>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240514101020.320785513@linuxfoundation.org>
References: <20240514101020.320785513@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Lechner <dlechner@baylibre.com>

[ Upstream commit e12cd96e8e93044646fdf4b2c9a1de62cfa01e7c ]

This modifies the AXI SPI Engine driver to use devm_spi_alloc_host()
instead of spi_alloc_host() to simplify the code a bit.

In addition to simplifying the error paths in the probe function, we
can also remove spi_controller_get/put() calls in the remove function
since devm_spi_alloc_host() sets a flag to no longer decrement the
controller reference count in the spi_unregister_controller() function.

Signed-off-by: David Lechner <dlechner@baylibre.com>
Link: https://lore.kernel.org/r/20231117-axi-spi-engine-series-1-v1-4-cc59db999b87@baylibre.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Stable-dep-of: 0064db9ce4aa ("spi: axi-spi-engine: fix version format string")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-axi-spi-engine.c | 31 ++++++++++---------------------
 1 file changed, 10 insertions(+), 21 deletions(-)

diff --git a/drivers/spi/spi-axi-spi-engine.c b/drivers/spi/spi-axi-spi-engine.c
index 492882213bb2f..69c4ff142baae 100644
--- a/drivers/spi/spi-axi-spi-engine.c
+++ b/drivers/spi/spi-axi-spi-engine.c
@@ -473,7 +473,7 @@ static int spi_engine_probe(struct platform_device *pdev)
 	if (irq <= 0)
 		return -ENXIO;
 
-	host = spi_alloc_host(&pdev->dev, sizeof(*spi_engine));
+	host = devm_spi_alloc_host(&pdev->dev, sizeof(*spi_engine));
 	if (!host)
 		return -ENOMEM;
 
@@ -482,22 +482,16 @@ static int spi_engine_probe(struct platform_device *pdev)
 	spin_lock_init(&spi_engine->lock);
 
 	spi_engine->clk = devm_clk_get_enabled(&pdev->dev, "s_axi_aclk");
-	if (IS_ERR(spi_engine->clk)) {
-		ret = PTR_ERR(spi_engine->clk);
-		goto err_put_host;
-	}
+	if (IS_ERR(spi_engine->clk))
+		return PTR_ERR(spi_engine->clk);
 
 	spi_engine->ref_clk = devm_clk_get_enabled(&pdev->dev, "spi_clk");
-	if (IS_ERR(spi_engine->ref_clk)) {
-		ret = PTR_ERR(spi_engine->ref_clk);
-		goto err_put_host;
-	}
+	if (IS_ERR(spi_engine->ref_clk))
+		return PTR_ERR(spi_engine->ref_clk);
 
 	spi_engine->base = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(spi_engine->base)) {
-		ret = PTR_ERR(spi_engine->base);
-		goto err_put_host;
-	}
+	if (IS_ERR(spi_engine->base))
+		return PTR_ERR(spi_engine->base);
 
 	version = readl(spi_engine->base + SPI_ENGINE_REG_VERSION);
 	if (SPI_ENGINE_VERSION_MAJOR(version) != 1) {
@@ -505,8 +499,7 @@ static int spi_engine_probe(struct platform_device *pdev)
 			SPI_ENGINE_VERSION_MAJOR(version),
 			SPI_ENGINE_VERSION_MINOR(version),
 			SPI_ENGINE_VERSION_PATCH(version));
-		ret = -ENODEV;
-		goto err_put_host;
+		return -ENODEV;
 	}
 
 	writel_relaxed(0x00, spi_engine->base + SPI_ENGINE_REG_RESET);
@@ -515,7 +508,7 @@ static int spi_engine_probe(struct platform_device *pdev)
 
 	ret = request_irq(irq, spi_engine_irq, 0, pdev->name, host);
 	if (ret)
-		goto err_put_host;
+		return ret;
 
 	host->dev.of_node = pdev->dev.of_node;
 	host->mode_bits = SPI_CPOL | SPI_CPHA | SPI_3WIRE;
@@ -533,14 +526,12 @@ static int spi_engine_probe(struct platform_device *pdev)
 	return 0;
 err_free_irq:
 	free_irq(irq, host);
-err_put_host:
-	spi_controller_put(host);
 	return ret;
 }
 
 static void spi_engine_remove(struct platform_device *pdev)
 {
-	struct spi_controller *host = spi_controller_get(platform_get_drvdata(pdev));
+	struct spi_controller *host = platform_get_drvdata(pdev);
 	struct spi_engine *spi_engine = spi_controller_get_devdata(host);
 	int irq = platform_get_irq(pdev, 0);
 
@@ -548,8 +539,6 @@ static void spi_engine_remove(struct platform_device *pdev)
 
 	free_irq(irq, host);
 
-	spi_controller_put(host);
-
 	writel_relaxed(0xff, spi_engine->base + SPI_ENGINE_REG_INT_PENDING);
 	writel_relaxed(0x00, spi_engine->base + SPI_ENGINE_REG_INT_ENABLE);
 	writel_relaxed(0x01, spi_engine->base + SPI_ENGINE_REG_RESET);
-- 
2.43.0




