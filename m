Return-Path: <stable+bounces-13573-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A2C6837CA7
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 02:13:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49E202845A5
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 01:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EADC146913;
	Tue, 23 Jan 2024 00:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dyoXBy1X"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2F914690D;
	Tue, 23 Jan 2024 00:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705969713; cv=none; b=OVdpJOfzaX+UCEImbvrbKxmEhMFH9cW7r32Qq9u8e9uEh/hpSg98/69bSYiKntnrElG8uLgjMORqRRu2xHuoVD2OJCCmjBPDMMWOGxIuZnCtdXfZCf0Xv6gmpxSS4QRm9s8qJsYTBaoDVMl7/u/IPZBokUew1hv9DLy1ua6ly/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705969713; c=relaxed/simple;
	bh=yIv5SS7Nx25c0zZbfcmnyOl9igjCbST9uE32W/RuqgU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EHK/OLVQ6K9KRvWUKCf8NHCZNpCroRiXHTE9UU76qmtO9gJl40dqZwHALHs5RCeo3gmpszYOVgtXNqndnwM7SmIFLPZ5HIp6OO6VsS8IE7C9WqihQpxnOtkReb17MUwmHxHu3d5srh10ECIY9YG0+lFXgJoex4eUuuPB5acLPfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dyoXBy1X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14296C43390;
	Tue, 23 Jan 2024 00:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705969713;
	bh=yIv5SS7Nx25c0zZbfcmnyOl9igjCbST9uE32W/RuqgU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dyoXBy1X443ss53Kd20mVsgczjFKgfBWjoHLGjinSQeNqBHxa1l28CzdKZ5d8QulP
	 x+c50fGIe4GeJSaXU4B/DwHYNhL3D6DwxwJ/ko+s91faYBpprdZt5bGeYjQzSquPmm
	 uqL2jd0BRZ4U8iHEk1slBaLk8rV5IIwV8iMYV3wI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable <stable@kernel.org>,
	Christoph Niedermaier <cniedermaier@dh-electronics.com>,
	Lukas Wunner <lukas@wunner.de>
Subject: [PATCH 6.7 415/641] serial: imx: Ensure that imx_uart_rs485_config() is called with enabled clock
Date: Mon, 22 Jan 2024 15:55:19 -0800
Message-ID: <20240122235830.956865326@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235818.091081209@linuxfoundation.org>
References: <20240122235818.091081209@linuxfoundation.org>
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

6.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christoph Niedermaier <cniedermaier@dh-electronics.com>

commit 7c45eaa813476bd195ac1227a64b52f9cf2e2030 upstream.

There are register accesses in the function imx_uart_rs485_config(). The
clock must be enabled for these accesses. This was ensured by calling it
via the function uart_rs485_config() in the probe() function within the
range where the clock is enabled. With the commit 7c7f9bc986e6 ("serial:
Deassert Transmit Enable on probe in driver-specific way") it was removed
from the probe() function and is now only called through the function
uart_add_one_port() which is located at the end of the probe() function.
But the clock is already switched off in this area. To ensure that the
clock is enabled during register access, move the disabling of the clock
to the very end of the probe() function. To avoid leaking enabled clocks
on error also add an error path for exiting with disabling the clock.

Fixes: 7c7f9bc986e6 ("serial: Deassert Transmit Enable on probe in driver-specific way")
Cc: stable <stable@kernel.org>
Signed-off-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Reviewed-by: Lukas Wunner <lukas@wunner.de>
Link: https://lore.kernel.org/r/20231226113647.39376-1-cniedermaier@dh-electronics.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/imx.c |   23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -2320,10 +2320,8 @@ static int imx_uart_probe(struct platfor
 	}
 
 	ret = uart_get_rs485_mode(&sport->port);
-	if (ret) {
-		clk_disable_unprepare(sport->clk_ipg);
-		return ret;
-	}
+	if (ret)
+		goto err_clk;
 
 	/*
 	 * If using the i.MX UART RTS/CTS control then the RTS (CTS_B)
@@ -2403,8 +2401,6 @@ static int imx_uart_probe(struct platfor
 		imx_uart_writel(sport, ucr3, UCR3);
 	}
 
-	clk_disable_unprepare(sport->clk_ipg);
-
 	hrtimer_init(&sport->trigger_start_tx, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 	hrtimer_init(&sport->trigger_stop_tx, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 	sport->trigger_start_tx.function = imx_trigger_start_tx;
@@ -2420,7 +2416,7 @@ static int imx_uart_probe(struct platfor
 		if (ret) {
 			dev_err(&pdev->dev, "failed to request rx irq: %d\n",
 				ret);
-			return ret;
+			goto err_clk;
 		}
 
 		ret = devm_request_irq(&pdev->dev, txirq, imx_uart_txint, 0,
@@ -2428,7 +2424,7 @@ static int imx_uart_probe(struct platfor
 		if (ret) {
 			dev_err(&pdev->dev, "failed to request tx irq: %d\n",
 				ret);
-			return ret;
+			goto err_clk;
 		}
 
 		ret = devm_request_irq(&pdev->dev, rtsirq, imx_uart_rtsint, 0,
@@ -2436,14 +2432,14 @@ static int imx_uart_probe(struct platfor
 		if (ret) {
 			dev_err(&pdev->dev, "failed to request rts irq: %d\n",
 				ret);
-			return ret;
+			goto err_clk;
 		}
 	} else {
 		ret = devm_request_irq(&pdev->dev, rxirq, imx_uart_int, 0,
 				       dev_name(&pdev->dev), sport);
 		if (ret) {
 			dev_err(&pdev->dev, "failed to request irq: %d\n", ret);
-			return ret;
+			goto err_clk;
 		}
 	}
 
@@ -2451,7 +2447,12 @@ static int imx_uart_probe(struct platfor
 
 	platform_set_drvdata(pdev, sport);
 
-	return uart_add_one_port(&imx_uart_uart_driver, &sport->port);
+	ret = uart_add_one_port(&imx_uart_uart_driver, &sport->port);
+
+err_clk:
+	clk_disable_unprepare(sport->clk_ipg);
+
+	return ret;
 }
 
 static int imx_uart_remove(struct platform_device *pdev)



