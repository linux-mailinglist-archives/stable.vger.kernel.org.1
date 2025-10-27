Return-Path: <stable+bounces-191085-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EB58C10E83
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 20:24:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DD673353084
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 19:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 551DE32C93B;
	Mon, 27 Oct 2025 19:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GN78Kgyq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155D432C92D
	for <stable@vger.kernel.org>; Mon, 27 Oct 2025 19:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761592969; cv=none; b=hRBxoK85H0ZXum4UHvbBtdHiHPnvF+7yZJBb12IfUuVSekLpvzCVpqAEEfh2nqy3nG09tQSNyg9ZTvcJmP9uNSJA3X5lLNjf7teCA8VVIMDKiYlFOCpo/rXUNTlYloVoxxzIhUYyf1gNfzIx/KXrSTKxkDw1LVlo1x33Wu3Mliw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761592969; c=relaxed/simple;
	bh=IL0cZKp3Bhel6SXhuDxyCIoRj41eB6JHuKgn3rGpMZI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CluUKvTpQ7wqH4xZMo1BRlixf40gH7qEmwr78wrf72c/majnFH2AHl11wvXGL2c4ji/+Y3tzh3ShmVQiHQLhGzNycUGNZe07x/6ZW0zZVatJfqj/3hA+0rtf8dkgDsfSbjdmcZvygU6R2JOUK8/Ig5vXt5apfmUSXEOTXwciHxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GN78Kgyq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F911C116B1;
	Mon, 27 Oct 2025 19:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761592968;
	bh=IL0cZKp3Bhel6SXhuDxyCIoRj41eB6JHuKgn3rGpMZI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GN78KgyqRMc0sPkgDEtstdKRhAN5Iyja+gMYN02v0lOut3jYts2VeSVhI0g8euN60
	 UcYotWsmHjgDzUqdbH9qmfY8gQtYNgtZYH1XQqIjwHMmA6BN9FUknjUG7aCuywDxk6
	 gWg4bpSdybUli0Ac9kGO3yDSGQu5c4Gb2m+FiC2FphMTE19RMA3fuFk3U814t/sVTL
	 cZ1hfTMhNWJRuAEet5Uol8ySOCy4YrZRGeg3fX99kq3Yf7j2/pxlYpvKC7hYnd0tiS
	 LqWmpPwZXq8UxJgvtKIUCAhHM1ccDnee3ntwV9yzzAfjCndcskkCDU51L6VD5C1aYN
	 hJtHQKxoXQ3+A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4.y 2/3] serial: 8250_dw: Use devm_add_action_or_reset()
Date: Mon, 27 Oct 2025 15:22:44 -0400
Message-ID: <20251027192245.660757-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251027192245.660757-1-sashal@kernel.org>
References: <2025102701-scabby-entrust-a162@gregkh>
 <20251027192245.660757-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

[ Upstream commit 295b09128d12fb1a7a67f771cc0ae0df869eafaf ]

Slightly simplify ->probe() and drop a few goto labels by using
devm_add_action_or_reset() for clock and reset cleanup.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Link: https://lore.kernel.org/r/20220509172129.37770-1-andriy.shevchenko@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: daeb4037adf7 ("serial: 8250_dw: handle reset control deassert error")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/8250/8250_dw.c | 63 +++++++++++++++----------------
 1 file changed, 31 insertions(+), 32 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index bd2901798f316..56506668a10c8 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -384,6 +384,16 @@ static void dw8250_quirks(struct uart_port *p, struct dw8250_data *data)
 	}
 }
 
+static void dw8250_clk_disable_unprepare(void *data)
+{
+	clk_disable_unprepare(data);
+}
+
+static void dw8250_reset_control_assert(void *data)
+{
+	reset_control_assert(data);
+}
+
 static int dw8250_probe(struct platform_device *pdev)
 {
 	struct uart_8250_port uart = {}, *up = &uart;
@@ -482,35 +492,43 @@ static int dw8250_probe(struct platform_device *pdev)
 	if (err)
 		dev_warn(dev, "could not enable optional baudclk: %d\n", err);
 
+	err = devm_add_action_or_reset(dev, dw8250_clk_disable_unprepare, data->clk);
+	if (err)
+		return err;
+
 	if (data->clk)
 		p->uartclk = clk_get_rate(data->clk);
 
 	/* If no clock rate is defined, fail. */
 	if (!p->uartclk) {
 		dev_err(dev, "clock rate not defined\n");
-		err = -EINVAL;
-		goto err_clk;
+		return -EINVAL;
 	}
 
 	data->pclk = devm_clk_get_optional(dev, "apb_pclk");
-	if (IS_ERR(data->pclk)) {
-		err = PTR_ERR(data->pclk);
-		goto err_clk;
-	}
+	if (IS_ERR(data->pclk))
+		return PTR_ERR(data->pclk);
 
 	err = clk_prepare_enable(data->pclk);
 	if (err) {
 		dev_err(dev, "could not enable apb_pclk\n");
-		goto err_clk;
+		return err;
 	}
 
+	err = devm_add_action_or_reset(dev, dw8250_clk_disable_unprepare, data->pclk);
+	if (err)
+		return err;
+
 	data->rst = devm_reset_control_get_optional_exclusive(dev, NULL);
-	if (IS_ERR(data->rst)) {
-		err = PTR_ERR(data->rst);
-		goto err_pclk;
-	}
+	if (IS_ERR(data->rst))
+		return PTR_ERR(data->rst);
+
 	reset_control_deassert(data->rst);
 
+	err = devm_add_action_or_reset(dev, dw8250_reset_control_assert, data->rst);
+	if (err)
+		return err;
+
 	dw8250_quirks(p, data);
 
 	/* If the Busy Functionality is not implemented, don't handle it */
@@ -528,10 +546,8 @@ static int dw8250_probe(struct platform_device *pdev)
 	}
 
 	data->data.line = serial8250_register_8250_port(up);
-	if (data->data.line < 0) {
-		err = data->data.line;
-		goto err_reset;
-	}
+	if (data->data.line < 0)
+		return data->data.line;
 
 	platform_set_drvdata(pdev, data);
 
@@ -539,17 +555,6 @@ static int dw8250_probe(struct platform_device *pdev)
 	pm_runtime_enable(dev);
 
 	return 0;
-
-err_reset:
-	reset_control_assert(data->rst);
-
-err_pclk:
-	clk_disable_unprepare(data->pclk);
-
-err_clk:
-	clk_disable_unprepare(data->clk);
-
-	return err;
 }
 
 static int dw8250_remove(struct platform_device *pdev)
@@ -561,12 +566,6 @@ static int dw8250_remove(struct platform_device *pdev)
 
 	serial8250_unregister_port(data->data.line);
 
-	reset_control_assert(data->rst);
-
-	clk_disable_unprepare(data->pclk);
-
-	clk_disable_unprepare(data->clk);
-
 	pm_runtime_disable(dev);
 	pm_runtime_put_noidle(dev);
 
-- 
2.51.0


