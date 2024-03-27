Return-Path: <stable+bounces-33023-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE9A788EED8
	for <lists+stable@lfdr.de>; Wed, 27 Mar 2024 20:07:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 454BF1F285B2
	for <lists+stable@lfdr.de>; Wed, 27 Mar 2024 19:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 261C6150996;
	Wed, 27 Mar 2024 19:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dh-electronics.com header.i=@dh-electronics.com header.b="OxTwfr1i"
X-Original-To: stable@vger.kernel.org
Received: from mx2.securetransport.de (mx2.securetransport.de [188.68.39.254])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A5A214D42C
	for <stable@vger.kernel.org>; Wed, 27 Mar 2024 19:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.68.39.254
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711566419; cv=none; b=MtxOuvmRQzIrX6gmpXv2of6kNNhgFj/rbLhIT1AFdMiIkSq/p7zVgaVjlY44PlPomeGr6bR1cwceqpxZ8rUxAWRk6jiaq0gGuV0sMFVy9WTPo3D5crBmpZIUVivCcC1rHJ4AzNkxLjd7hVzdt6kwRhF6zU+VwFnnGn0hJVUuRXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711566419; c=relaxed/simple;
	bh=931da/ylSqjuimSE4V14Ta8oO1CeMdXlHV82S24KDaQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aQK8DEa8eaz/Gg3bEwZzYecTRs5nYNz43ovFsDeLwH4GBRKkOmOqhYw2tCu2iJDMyg24XnqliOZw7hY58qG4tCynEuyEXScnVxssj+hwWE+DclJymLe+ZOAH/a9omOVlgd1HgMitgC6uKObAA1f/JMzcIqcH6aFFQDRrU9z0v1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dh-electronics.com; spf=pass smtp.mailfrom=dh-electronics.com; dkim=pass (2048-bit key) header.d=dh-electronics.com header.i=@dh-electronics.com header.b=OxTwfr1i; arc=none smtp.client-ip=188.68.39.254
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dh-electronics.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dh-electronics.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
	s=dhelectronicscom; t=1711565832;
	bh=2lyz0TIKSDHRRsHUIZCqG670coNOFK3jcKjBJWOJKig=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=OxTwfr1iACpW4MQJWyx+SndKfWkT2gwcBA3zOfGF2l7EiWYLdoqoZ8lk71+d87+Xc
	 F2d1phd+L+hWTX4IgQx6fhOCIKNkQCeuj3mOU/KsSKrDDQSsfsDZQm+VkaLdvy6Cdm
	 SHVf2YDYUpGBYrwkqP1Lukz+6O6DVaYTiGAFXRA9Nj+V2L+LkXrAwDqFq8YfRN1Iqe
	 x/a16vH6gRw3rAquHl/oIXoj3+jCxjgFAcqJRf6X5T9XZRym016fy7uy7QPdkn9fdJ
	 H23xe8zeK4UWdinwZAEcJDZBA1Zh8Xbt3Kk6xUxSCCAvtt3ISy1MAxA8l6Lg8cgyhC
	 ax6IaSNJgttrw==
From: Christoph Niedermaier <cniedermaier@dh-electronics.com>
To: <stable@vger.kernel.org>
CC: Rickard x Andersson <rickaran@axis.com>, stable <stable@kernel.org>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, Christoph Niedermaier
	<cniedermaier@dh-electronics.com>
Subject: [PATCH 6.1.y] tty: serial: imx: Fix broken RS485
Date: Wed, 27 Mar 2024 19:54:59 +0100
Message-ID: <20240327185459.4717-1-cniedermaier@dh-electronics.com>
X-klartext: yes
In-Reply-To: <2024032746-stilt-vaporizer-fb22@gregkh>
References: <2024032746-stilt-vaporizer-fb22@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

From: Rickard x Andersson <rickaran@axis.com>

When about to transmit the function imx_uart_start_tx is called and in
some RS485 configurations this function will call imx_uart_stop_rx. The
problem is that imx_uart_stop_rx will enable loopback in order to
release the RS485 bus, but when loopback is enabled transmitted data
will just be looped to RX.

This patch fixes the above problem by not enabling loopback when about
to transmit.

This driver now works well when used for RS485 half duplex master
configurations.

Fixes: 79d0224f6bf2 ("tty: serial: imx: Handle RS485 DE signal active high")
Cc: stable <stable@kernel.org>
Signed-off-by: Rickard x Andersson <rickaran@axis.com>
Tested-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Link: https://lore.kernel.org/r/20240221115304.509811-1-rickaran@axis.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
(cherry picked from commit 672448ccf9b6a676f96f9352cbf91f4d35f4084a)
Signed-off-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>
---
 drivers/tty/serial/imx.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index f8962a3d4421..573bf7e9b797 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -496,8 +496,7 @@ static void imx_uart_stop_tx(struct uart_port *port)
 	}
 }
 
-/* called with port.lock taken and irqs off */
-static void imx_uart_stop_rx(struct uart_port *port)
+static void imx_uart_stop_rx_with_loopback_ctrl(struct uart_port *port, bool loopback)
 {
 	struct imx_port *sport = (struct imx_port *)port;
 	u32 ucr1, ucr2, ucr4, uts;
@@ -519,7 +518,7 @@ static void imx_uart_stop_rx(struct uart_port *port)
 	/* See SER_RS485_ENABLED/UTS_LOOP comment in imx_uart_probe() */
 	if (port->rs485.flags & SER_RS485_ENABLED &&
 	    port->rs485.flags & SER_RS485_RTS_ON_SEND &&
-	    sport->have_rtscts && !sport->have_rtsgpio) {
+	    sport->have_rtscts && !sport->have_rtsgpio && loopback) {
 		uts = imx_uart_readl(sport, imx_uart_uts_reg(sport));
 		uts |= UTS_LOOP;
 		imx_uart_writel(sport, uts, imx_uart_uts_reg(sport));
@@ -532,6 +531,16 @@ static void imx_uart_stop_rx(struct uart_port *port)
 }
 
 /* called with port.lock taken and irqs off */
+static void imx_uart_stop_rx(struct uart_port *port)
+{
+	/*
+	 * Stop RX and enable loopback in order to make sure RS485 bus
+	 * is not blocked. Se comment in imx_uart_probe().
+	 */
+	imx_uart_stop_rx_with_loopback_ctrl(port, true);
+}
+
+/* called with port.lock taken and irqs off */
 static void imx_uart_enable_ms(struct uart_port *port)
 {
 	struct imx_port *sport = (struct imx_port *)port;
@@ -719,8 +728,13 @@ static void imx_uart_start_tx(struct uart_port *port)
 				imx_uart_rts_inactive(sport, &ucr2);
 			imx_uart_writel(sport, ucr2, UCR2);
 
+			/*
+			 * Since we are about to transmit we can not stop RX
+			 * with loopback enabled because that will make our
+			 * transmitted data being just looped to RX.
+			 */
 			if (!(port->rs485.flags & SER_RS485_RX_DURING_TX))
-				imx_uart_stop_rx(port);
+				imx_uart_stop_rx_with_loopback_ctrl(port, false);
 
 			sport->tx_state = WAIT_AFTER_RTS;
 
-- 
2.11.0


