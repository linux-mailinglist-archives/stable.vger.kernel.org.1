Return-Path: <stable+bounces-204281-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 23284CEA8D1
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 20:49:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 90C323017EE3
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 19:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2F7623B62B;
	Tue, 30 Dec 2025 19:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SyoNNLy2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F80721ABAC
	for <stable@vger.kernel.org>; Tue, 30 Dec 2025 19:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767124147; cv=none; b=Rt+5ALa0k80bh4dOmpiad+gMwdhcrJhU4wQJQ9S/wiyuvw5mp/Qk/VBlNmuRx/URfU0mHlsjpauDktzmnW+/sMiUjxxdqZCRmdCCiOl8odEPQRLR73u3cWu+7Jk46BDN84f+AX6AuMEdNvgP9h9UPne+vGfcLRXh0pbcijQozWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767124147; c=relaxed/simple;
	bh=/2g+gJSrGPntZWKnegvyX89eWH1g3E9bVanK0M3gYrQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D+fVhEX4IHX+JmOlY2bvgMR+aWAohCmp4K+HYcSTgz6Ukowrt8Ks20XuRpIsvHwsfgxcB8DdNGM8ZRKLKONwsXGnfCISpd+1SBc11xyRe0nO5mqV2UErCpaGy3LDDOzrxV8l2poI1YtfAtv/UpDWinthSUtaFGbYOl4ggQBOEPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SyoNNLy2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6F1EC4CEFB;
	Tue, 30 Dec 2025 19:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767124147;
	bh=/2g+gJSrGPntZWKnegvyX89eWH1g3E9bVanK0M3gYrQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SyoNNLy2xRMjet1kiHkoppJg1kGg3Tttpx8zSvXdMRuG6d+2qbcine1nTlWqIFkQn
	 +YK9CSsB50bnQCyO5hDFY+JTcg04T2tWId927yOVJbuoG2FuI6kriX9/Lc7PHNZi0p
	 SHDu25pOdu2itjw4XRUeDgFHDsvhOEg9Wi5B+qU1J16NPAn8DCpBB7zv2z8xP71dgX
	 3DrI+3GGCjsZPEF+QLWLO2QttYprOdBEdmcnwhN+YYaQRlEG7AtXOxpdcIyxwuJpMx
	 CnZwoejVWIUvncVDfrNsfpWDNorgtBIPQn3E2S6NJQpGfSxohn+QszneFhgZ+GxNxQ
	 0W/IJCmBrh6hQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/3] serial: Make uart_remove_one_port() return void
Date: Tue, 30 Dec 2025 14:49:02 -0500
Message-ID: <20251230194904.2442970-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025122918-sagging-divisible-a4a4@gregkh>
References: <2025122918-sagging-divisible-a4a4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

[ Upstream commit d5b3d02d0b107345f2a6ecb5b06f98356f5c97ab ]

The return value is only ever used as a return value for remove callbacks
of platform drivers. This return value is ignored by the driver core.
(The only effect is an error message, but uart_remove_one_port() already
emitted one in this case.)

So the return value isn't used at all and uart_remove_one_port() can be
changed to return void without any loss. Also this better matches the
Linux device model as remove functions are not supposed to fail.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Link: https://lore.kernel.org/r/20230512173810.131447-3-u.kleine-koenig@pengutronix.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: 74098cc06e75 ("xhci: dbgtty: fix device unregister: fixup")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/atmel_serial.c           |  5 ++---
 drivers/tty/serial/clps711x.c               |  4 +++-
 drivers/tty/serial/cpm_uart/cpm_uart_core.c |  5 ++++-
 drivers/tty/serial/imx.c                    |  4 +++-
 drivers/tty/serial/lantiq.c                 |  4 +++-
 drivers/tty/serial/serial_core.c            |  6 +-----
 drivers/tty/serial/st-asc.c                 |  4 +++-
 drivers/tty/serial/uartlite.c               | 12 ++++--------
 drivers/tty/serial/xilinx_uartps.c          |  5 ++---
 include/linux/serial_core.h                 |  2 +-
 10 files changed, 26 insertions(+), 25 deletions(-)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index b3463cdd1d4b..e11f89355d17 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -3022,14 +3022,13 @@ static int atmel_serial_remove(struct platform_device *pdev)
 {
 	struct uart_port *port = platform_get_drvdata(pdev);
 	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
-	int ret = 0;
 
 	tasklet_kill(&atmel_port->tasklet_rx);
 	tasklet_kill(&atmel_port->tasklet_tx);
 
 	device_init_wakeup(&pdev->dev, 0);
 
-	ret = uart_remove_one_port(&atmel_uart, port);
+	uart_remove_one_port(&atmel_uart, port);
 
 	kfree(atmel_port->rx_ring.buf);
 
@@ -3039,7 +3038,7 @@ static int atmel_serial_remove(struct platform_device *pdev)
 
 	pdev->dev.of_node = NULL;
 
-	return ret;
+	return 0;
 }
 
 static SIMPLE_DEV_PM_OPS(atmel_serial_pm_ops, atmel_serial_suspend,
diff --git a/drivers/tty/serial/clps711x.c b/drivers/tty/serial/clps711x.c
index 404b43a5ae33..6d5fab8840a3 100644
--- a/drivers/tty/serial/clps711x.c
+++ b/drivers/tty/serial/clps711x.c
@@ -515,7 +515,9 @@ static int uart_clps711x_remove(struct platform_device *pdev)
 {
 	struct clps711x_port *s = platform_get_drvdata(pdev);
 
-	return uart_remove_one_port(&clps711x_uart, &s->port);
+	uart_remove_one_port(&clps711x_uart, &s->port);
+
+	return 0;
 }
 
 static const struct of_device_id __maybe_unused clps711x_uart_dt_ids[] = {
diff --git a/drivers/tty/serial/cpm_uart/cpm_uart_core.c b/drivers/tty/serial/cpm_uart/cpm_uart_core.c
index bb25691f5000..863c26a263ed 100644
--- a/drivers/tty/serial/cpm_uart/cpm_uart_core.c
+++ b/drivers/tty/serial/cpm_uart/cpm_uart_core.c
@@ -1428,7 +1428,10 @@ static int cpm_uart_probe(struct platform_device *ofdev)
 static int cpm_uart_remove(struct platform_device *ofdev)
 {
 	struct uart_cpm_port *pinfo = platform_get_drvdata(ofdev);
-	return uart_remove_one_port(&cpm_reg, &pinfo->port);
+
+	uart_remove_one_port(&cpm_reg, &pinfo->port);
+
+	return 0;
 }
 
 static const struct of_device_id cpm_uart_match[] = {
diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index e1d88a499554..47e59664dbde 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -2538,7 +2538,9 @@ static int imx_uart_remove(struct platform_device *pdev)
 {
 	struct imx_port *sport = platform_get_drvdata(pdev);
 
-	return uart_remove_one_port(&imx_uart_uart_driver, &sport->port);
+	uart_remove_one_port(&imx_uart_uart_driver, &sport->port);
+
+	return 0;
 }
 
 static void imx_uart_restore_context(struct imx_port *sport)
diff --git a/drivers/tty/serial/lantiq.c b/drivers/tty/serial/lantiq.c
index 112a2f5f6ac3..5a3e826d2909 100644
--- a/drivers/tty/serial/lantiq.c
+++ b/drivers/tty/serial/lantiq.c
@@ -918,7 +918,9 @@ static int lqasc_remove(struct platform_device *pdev)
 {
 	struct uart_port *port = platform_get_drvdata(pdev);
 
-	return uart_remove_one_port(&lqasc_reg, port);
+	uart_remove_one_port(&lqasc_reg, port);
+
+	return 0;
 }
 
 static const struct ltq_soc_data soc_data_lantiq = {
diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 19a53801ff9e..534720a646f4 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -3186,13 +3186,12 @@ EXPORT_SYMBOL(uart_add_one_port);
  * This unhooks (and hangs up) the specified port structure from the core
  * driver. No further calls will be made to the low-level code for this port.
  */
-int uart_remove_one_port(struct uart_driver *drv, struct uart_port *uport)
+void uart_remove_one_port(struct uart_driver *drv, struct uart_port *uport)
 {
 	struct uart_state *state = drv->state + uport->line;
 	struct tty_port *port = &state->port;
 	struct uart_port *uart_port;
 	struct tty_struct *tty;
-	int ret = 0;
 
 	mutex_lock(&port_mutex);
 
@@ -3208,7 +3207,6 @@ int uart_remove_one_port(struct uart_driver *drv, struct uart_port *uport)
 
 	if (!uart_port) {
 		mutex_unlock(&port->mutex);
-		ret = -EINVAL;
 		goto out;
 	}
 	uport->flags |= UPF_DEAD;
@@ -3251,8 +3249,6 @@ int uart_remove_one_port(struct uart_driver *drv, struct uart_port *uport)
 	mutex_unlock(&port->mutex);
 out:
 	mutex_unlock(&port_mutex);
-
-	return ret;
 }
 EXPORT_SYMBOL(uart_remove_one_port);
 
diff --git a/drivers/tty/serial/st-asc.c b/drivers/tty/serial/st-asc.c
index fcecea689a0d..806f12c2744b 100644
--- a/drivers/tty/serial/st-asc.c
+++ b/drivers/tty/serial/st-asc.c
@@ -834,7 +834,9 @@ static int asc_serial_remove(struct platform_device *pdev)
 {
 	struct uart_port *port = platform_get_drvdata(pdev);
 
-	return uart_remove_one_port(&asc_uart_driver, port);
+	uart_remove_one_port(&asc_uart_driver, port);
+
+	return 0;
 }
 
 #ifdef CONFIG_PM_SLEEP
diff --git a/drivers/tty/serial/uartlite.c b/drivers/tty/serial/uartlite.c
index a75677d5cbef..40db763eac9d 100644
--- a/drivers/tty/serial/uartlite.c
+++ b/drivers/tty/serial/uartlite.c
@@ -686,18 +686,15 @@ static int ulite_assign(struct device *dev, int id, phys_addr_t base, int irq,
  *
  * @dev: pointer to device structure
  */
-static int ulite_release(struct device *dev)
+static void ulite_release(struct device *dev)
 {
 	struct uart_port *port = dev_get_drvdata(dev);
-	int rc = 0;
 
 	if (port) {
-		rc = uart_remove_one_port(&ulite_uart_driver, port);
+		uart_remove_one_port(&ulite_uart_driver, port);
 		dev_set_drvdata(dev, NULL);
 		port->mapbase = 0;
 	}
-
-	return rc;
 }
 
 /**
@@ -891,14 +888,13 @@ static int ulite_remove(struct platform_device *pdev)
 {
 	struct uart_port *port = dev_get_drvdata(&pdev->dev);
 	struct uartlite_data *pdata = port->private_data;
-	int rc;
 
 	clk_disable_unprepare(pdata->clk);
-	rc = ulite_release(&pdev->dev);
+	ulite_release(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_set_suspended(&pdev->dev);
 	pm_runtime_dont_use_autosuspend(&pdev->dev);
-	return rc;
+	return 0;
 }
 
 /* work with hotplug and coldplug */
diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 29afcc6d9bb7..2f51f46e3bd8 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -1670,14 +1670,13 @@ static int cdns_uart_remove(struct platform_device *pdev)
 {
 	struct uart_port *port = platform_get_drvdata(pdev);
 	struct cdns_uart *cdns_uart_data = port->private_data;
-	int rc;
 
 	/* Remove the cdns_uart port from the serial core */
 #ifdef CONFIG_COMMON_CLK
 	clk_notifier_unregister(cdns_uart_data->uartclk,
 			&cdns_uart_data->clk_rate_change_nb);
 #endif
-	rc = uart_remove_one_port(cdns_uart_data->cdns_uart_driver, port);
+	uart_remove_one_port(cdns_uart_data->cdns_uart_driver, port);
 	port->mapbase = 0;
 	clk_disable_unprepare(cdns_uart_data->uartclk);
 	clk_disable_unprepare(cdns_uart_data->pclk);
@@ -1693,7 +1692,7 @@ static int cdns_uart_remove(struct platform_device *pdev)
 
 	if (!--instances)
 		uart_unregister_driver(cdns_uart_data->cdns_uart_driver);
-	return rc;
+	return 0;
 }
 
 static struct platform_driver cdns_uart_platform_driver = {
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 5a83db0ac763..762cbf400ec6 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -847,7 +847,7 @@ void uart_console_write(struct uart_port *port, const char *s,
 int uart_register_driver(struct uart_driver *uart);
 void uart_unregister_driver(struct uart_driver *uart);
 int uart_add_one_port(struct uart_driver *reg, struct uart_port *port);
-int uart_remove_one_port(struct uart_driver *reg, struct uart_port *port);
+void uart_remove_one_port(struct uart_driver *reg, struct uart_port *port);
 bool uart_match_port(const struct uart_port *port1,
 		const struct uart_port *port2);
 
-- 
2.51.0


