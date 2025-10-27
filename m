Return-Path: <stable+bounces-190055-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB9EFC0FA90
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 18:31:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F10A3427ECC
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 17:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 593DD3161BC;
	Mon, 27 Oct 2025 17:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IkTVx6w1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17ED530F55E
	for <stable@vger.kernel.org>; Mon, 27 Oct 2025 17:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761586309; cv=none; b=HA5Y1CcPFwUq4lu1B6fh19Gop7lBwNLboFboyCZ79O9hCiQrqL3oof6P495A8RegfkbKoxszQp7AJnYWdLVK+ZZ3nrFG+lQKyEfuqW2FDjqIhgjkqKlgrcXu1y0pEQPp0qVd6QaCLYcNOIeSBVk0snQbHVEFmCNn/AXJB4bhEz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761586309; c=relaxed/simple;
	bh=Ckwe6bHp0CdVI6m0xvtOxnT6bprh/v1lMkEQpLjYPug=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hOkArCeNaRwGbAQ3HGIMXSTARimbYbBjZ669H4bWFoChpBnGw/maJD5dMKowecL161vHvb29PIbykW8NnP9OEQLjDzw0uk2OWsI79el7CYBI6SNRJJwD1MiOYHeBq1yJ+WFytljWLBGxDo9QMm+kDmsndcaHxtiNsytwJz7gplc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IkTVx6w1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CCE6C4CEF1;
	Mon, 27 Oct 2025 17:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761586307;
	bh=Ckwe6bHp0CdVI6m0xvtOxnT6bprh/v1lMkEQpLjYPug=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IkTVx6w1pzJMjKscUeQhbnA6nzvDYnHKYj7Rv9/7bdDy90s9pSPBBu7hSZR4uNPMs
	 jkkb1P2D6CMDvjNjHSvV8WYAfPeudnX0eOn+AOzmzNzm/Ls4CvzEp7uaT8vk4fic9x
	 VzW0l0EIKod1E4mJfNDj9a0d7rcDjTvtcutc/Dmignn7xkKpBIm4C/QEwshsZbEiSL
	 2xdz3/xRv87q4g5XiN4O3cR+ejjHbzPOWEmcQkfGsI6MYxrGtdaStpCDKwJHjqyOkv
	 QFVgx2daWEOL4xGhtr/XrJMhdw8Ftbbf5hLRu0hAp0B07BAqT5DFpYsKS77yaK0l0l
	 r2P0JMVwSDXwA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] serial: 8250_dw: Use devm_add_action_or_reset()
Date: Mon, 27 Oct 2025 13:31:44 -0400
Message-ID: <20251027173145.608096-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025102700-impish-precook-5377@gregkh>
References: <2025102700-impish-precook-5377@gregkh>
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
index ace221afeb039..6abdebb63ecbe 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -438,6 +438,16 @@ static void dw8250_quirks(struct uart_port *p, struct dw8250_data *data)
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
@@ -539,35 +549,43 @@ static int dw8250_probe(struct platform_device *pdev)
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
@@ -585,10 +603,8 @@ static int dw8250_probe(struct platform_device *pdev)
 	}
 
 	data->data.line = serial8250_register_8250_port(up);
-	if (data->data.line < 0) {
-		err = data->data.line;
-		goto err_reset;
-	}
+	if (data->data.line < 0)
+		return data->data.line;
 
 	/*
 	 * Some platforms may provide a reference clock shared between several
@@ -609,17 +625,6 @@ static int dw8250_probe(struct platform_device *pdev)
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
@@ -637,12 +642,6 @@ static int dw8250_remove(struct platform_device *pdev)
 
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


