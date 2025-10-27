Return-Path: <stable+bounces-191083-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D90AEC11063
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 20:30:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 786B3501E87
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 19:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BBD632BF52;
	Mon, 27 Oct 2025 19:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bqVTvnx0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB8432ABF1
	for <stable@vger.kernel.org>; Mon, 27 Oct 2025 19:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761592968; cv=none; b=pLa/T2zcPhBCU7sA1ms61jjJbdkDhAwIsgZV4R5tTAxmKCmUJGt0LvWy4rqFvQdYOBIlpDU3mhKO2mRJ0ARRSv6a+mP29KUnPx7q3vHtWP0JgvZHDkYPw9ae4GU0AnKEBb323D3vxkj29ueGpAomWtElBGXXCfOl9ChSlmuTFY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761592968; c=relaxed/simple;
	bh=TsnjcNBrc5m64G4wdAVLD8TLsvgdYo5aVSJ4KISGt5w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LhWcs6/8TMRl81h6b6HaQwtcgsTCbwUDmni6GkHg3HNReBYoLW0LEVWpQtjgmHhqJb72zDiTrloZ0agRqTgnti0ujralYynBNR7wFCYlwuO6g8JxGWmtQGdphT89n28ECDFh7NKklYGqgL+UGgdfQxJBXAB0VqjbTXQNbIEWaOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bqVTvnx0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9215FC4CEFD;
	Mon, 27 Oct 2025 19:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761592968;
	bh=TsnjcNBrc5m64G4wdAVLD8TLsvgdYo5aVSJ4KISGt5w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bqVTvnx0LJau1IKmXVXa2++1tvOxjIxH1m+eILynaSft8NUHu+pDGyCITU55m/Lce
	 B0WagS8eRq0KW1XqqCGXHAomKdlIzX5UwdG/iIb03U5BpZSYpA55YShNXTKWKOZTAm
	 vZcpoGHircoZixCvsr2e1+Eel4ScOf6xU29/0LRIoJjWXcEFjyYEpJYBBd9zHngKLx
	 HXjCLYQYI3L4atoEg1RlsxpEXg0McdvNw/zpXLO0oFWdpmUIrlCB6pCXa3pq7mOHBk
	 r/MZTq5H0QbAcccN5ME2OOvEVDO4m8S2v7hnUaTBVltheQ0esEBVUso5bDA55gAIuN
	 rrNV1pyACB70g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4.y 1/3] serial: 8250_dw: Use devm_clk_get_optional() to get the input clock
Date: Mon, 27 Oct 2025 15:22:43 -0400
Message-ID: <20251027192245.660757-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025102701-scabby-entrust-a162@gregkh>
References: <2025102701-scabby-entrust-a162@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

[ Upstream commit a8afc193558a42d5df724c84436ae3b2446d8a30 ]

Simplify the code which fetches the input clock by using
devm_clk_get_optional(). This comes with a small functional change: previously
all errors were ignored except deferred probe. Now all errors are
treated as errors. If no input clock is present devm_clk_get_optional() will
return NULL instead of an error which matches the behavior of the old code.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Link: https://lore.kernel.org/r/20190925162617.30368-1-andriy.shevchenko@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: daeb4037adf7 ("serial: 8250_dw: handle reset control deassert error")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/8250/8250_dw.c | 75 +++++++++++++------------------
 1 file changed, 32 insertions(+), 43 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index 2d5a039229acf..bd2901798f316 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -283,9 +283,6 @@ static void dw8250_set_termios(struct uart_port *p, struct ktermios *termios,
 	long rate;
 	int ret;
 
-	if (IS_ERR(d->clk))
-		goto out;
-
 	clk_disable_unprepare(d->clk);
 	rate = clk_round_rate(d->clk, baud * 16);
 	if (rate < 0)
@@ -296,8 +293,10 @@ static void dw8250_set_termios(struct uart_port *p, struct ktermios *termios,
 		ret = clk_set_rate(d->clk, rate);
 	clk_prepare_enable(d->clk);
 
-	if (!ret)
-		p->uartclk = rate;
+	if (ret)
+		goto out;
+
+	p->uartclk = rate;
 
 out:
 	p->status &= ~UPSTAT_AUTOCTS;
@@ -473,19 +472,18 @@ static int dw8250_probe(struct platform_device *pdev)
 	device_property_read_u32(dev, "clock-frequency", &p->uartclk);
 
 	/* If there is separate baudclk, get the rate from it. */
-	data->clk = devm_clk_get(dev, "baudclk");
-	if (IS_ERR(data->clk) && PTR_ERR(data->clk) != -EPROBE_DEFER)
-		data->clk = devm_clk_get(dev, NULL);
-	if (IS_ERR(data->clk) && PTR_ERR(data->clk) == -EPROBE_DEFER)
-		return -EPROBE_DEFER;
-	if (!IS_ERR_OR_NULL(data->clk)) {
-		err = clk_prepare_enable(data->clk);
-		if (err)
-			dev_warn(dev, "could not enable optional baudclk: %d\n",
-				 err);
-		else
-			p->uartclk = clk_get_rate(data->clk);
-	}
+	data->clk = devm_clk_get_optional(dev, "baudclk");
+	if (data->clk == NULL)
+		data->clk = devm_clk_get_optional(dev, NULL);
+	if (IS_ERR(data->clk))
+		return PTR_ERR(data->clk);
+
+	err = clk_prepare_enable(data->clk);
+	if (err)
+		dev_warn(dev, "could not enable optional baudclk: %d\n", err);
+
+	if (data->clk)
+		p->uartclk = clk_get_rate(data->clk);
 
 	/* If no clock rate is defined, fail. */
 	if (!p->uartclk) {
@@ -494,17 +492,16 @@ static int dw8250_probe(struct platform_device *pdev)
 		goto err_clk;
 	}
 
-	data->pclk = devm_clk_get(dev, "apb_pclk");
-	if (IS_ERR(data->pclk) && PTR_ERR(data->pclk) == -EPROBE_DEFER) {
-		err = -EPROBE_DEFER;
+	data->pclk = devm_clk_get_optional(dev, "apb_pclk");
+	if (IS_ERR(data->pclk)) {
+		err = PTR_ERR(data->pclk);
 		goto err_clk;
 	}
-	if (!IS_ERR(data->pclk)) {
-		err = clk_prepare_enable(data->pclk);
-		if (err) {
-			dev_err(dev, "could not enable apb_pclk\n");
-			goto err_clk;
-		}
+
+	err = clk_prepare_enable(data->pclk);
+	if (err) {
+		dev_err(dev, "could not enable apb_pclk\n");
+		goto err_clk;
 	}
 
 	data->rst = devm_reset_control_get_optional_exclusive(dev, NULL);
@@ -547,12 +544,10 @@ static int dw8250_probe(struct platform_device *pdev)
 	reset_control_assert(data->rst);
 
 err_pclk:
-	if (!IS_ERR(data->pclk))
-		clk_disable_unprepare(data->pclk);
+	clk_disable_unprepare(data->pclk);
 
 err_clk:
-	if (!IS_ERR(data->clk))
-		clk_disable_unprepare(data->clk);
+	clk_disable_unprepare(data->clk);
 
 	return err;
 }
@@ -568,11 +563,9 @@ static int dw8250_remove(struct platform_device *pdev)
 
 	reset_control_assert(data->rst);
 
-	if (!IS_ERR(data->pclk))
-		clk_disable_unprepare(data->pclk);
+	clk_disable_unprepare(data->pclk);
 
-	if (!IS_ERR(data->clk))
-		clk_disable_unprepare(data->clk);
+	clk_disable_unprepare(data->clk);
 
 	pm_runtime_disable(dev);
 	pm_runtime_put_noidle(dev);
@@ -605,11 +598,9 @@ static int dw8250_runtime_suspend(struct device *dev)
 {
 	struct dw8250_data *data = dev_get_drvdata(dev);
 
-	if (!IS_ERR(data->clk))
-		clk_disable_unprepare(data->clk);
+	clk_disable_unprepare(data->clk);
 
-	if (!IS_ERR(data->pclk))
-		clk_disable_unprepare(data->pclk);
+	clk_disable_unprepare(data->pclk);
 
 	return 0;
 }
@@ -618,11 +609,9 @@ static int dw8250_runtime_resume(struct device *dev)
 {
 	struct dw8250_data *data = dev_get_drvdata(dev);
 
-	if (!IS_ERR(data->pclk))
-		clk_prepare_enable(data->pclk);
+	clk_prepare_enable(data->pclk);
 
-	if (!IS_ERR(data->clk))
-		clk_prepare_enable(data->clk);
+	clk_prepare_enable(data->clk);
 
 	return 0;
 }
-- 
2.51.0


