Return-Path: <stable+bounces-33022-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5474F88EECB
	for <lists+stable@lfdr.de>; Wed, 27 Mar 2024 20:01:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0ED6429E365
	for <lists+stable@lfdr.de>; Wed, 27 Mar 2024 19:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E6F614F134;
	Wed, 27 Mar 2024 19:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dh-electronics.com header.i=@dh-electronics.com header.b="DDOkuAMZ"
X-Original-To: stable@vger.kernel.org
Received: from mx2.securetransport.de (mx2.securetransport.de [188.68.39.254])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CA4014C5A8
	for <stable@vger.kernel.org>; Wed, 27 Mar 2024 19:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.68.39.254
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711566093; cv=none; b=Ze0nd9zJIbfsgaCm0Ug9OCys/kjkfeY0cxbl3Rq7xx06S+S0hssxcC0mL+zUXYaVCScxI2fNmuey9tjv9+7DgkNMqFCBsLFdNcTQNC6rhdlJ8uwuYnUOzxpAEDNchBn5yY+T4+UW/x9ihvt9fW3kRJ2B7/T0DJ+/1ZB4IyRVccQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711566093; c=relaxed/simple;
	bh=qrgl+ZWpA/DjzAvGcU1iRmRlqrtPWq1IsOKXBjQx10s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z1mt8OQJUcgixjsPw+Ap6QXowI3Hq/erjFB9/PACsgfxGHI4gQbuU/9iABGxdH2PSi4ktKkHQuSI7vOcLWYap+qE5Ejvnz+atAJ8v1HmP7XJ5mEzGysmlGzQ2WY4tMaoE2Kes5mVUa9x8N9QeLZLFqyFc2ansGtdDaUritA55Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dh-electronics.com; spf=pass smtp.mailfrom=dh-electronics.com; dkim=pass (2048-bit key) header.d=dh-electronics.com header.i=@dh-electronics.com header.b=DDOkuAMZ; arc=none smtp.client-ip=188.68.39.254
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dh-electronics.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dh-electronics.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
	s=dhelectronicscom; t=1711566070;
	bh=8WlR25MI/MkzRRWYW4HcJ/0ECBjIgsrzAcoYD5gz2KQ=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=DDOkuAMZ3I8wdV2SM72FzMo2d89YowTOPrkmL2zZswDipNQ2+hgQ/1HbK7qgeqpRt
	 w9MRTlf/mUMt0q7ScdTGxtcKMSMgJIf6iTMSYpBlrJQFKJKmDWxbYJFWV3B+8aK7AW
	 Mh+PcXgPe0zZaEk2R2KBTVzqKqzs7XSmAuShm/U5tgjT0PvI33e829HjjZvE7+JLZy
	 LUGaxnsBBVuv6Acy4wuB21bVqgp5hJ72467vxHRj8WwHXv/1WI9iuhYSIDggqe6+iw
	 umidgWsDGLoZAmEOI8CjUL528bihYv/BPGjjDD8BoSU4AaI7TL76R3tDDVLF+KhoFT
	 XjJI6GdqQwpKQ==
From: Christoph Niedermaier <cniedermaier@dh-electronics.com>
To: <stable@vger.kernel.org>
CC: Rickard x Andersson <rickaran@axis.com>, stable <stable@kernel.org>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, Christoph Niedermaier
	<cniedermaier@dh-electronics.com>
Subject: [PATCH 5.15.y] tty: serial: imx: Fix broken RS485
Date: Wed, 27 Mar 2024 19:59:54 +0100
Message-ID: <20240327185954.5129-1-cniedermaier@dh-electronics.com>
X-klartext: yes
In-Reply-To: <2024032747-spiritism-worsening-c504@gregkh>
References: <2024032747-spiritism-worsening-c504@gregkh>
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
index 4504b5fcc171..0587beaaea08 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -491,8 +491,7 @@ static void imx_uart_stop_tx(struct uart_port *port)
 	}
 }
 
-/* called with port.lock taken and irqs off */
-static void imx_uart_stop_rx(struct uart_port *port)
+static void imx_uart_stop_rx_with_loopback_ctrl(struct uart_port *port, bool loopback)
 {
 	struct imx_port *sport = (struct imx_port *)port;
 	u32 ucr1, ucr2, ucr4, uts;
@@ -514,7 +513,7 @@ static void imx_uart_stop_rx(struct uart_port *port)
 	/* See SER_RS485_ENABLED/UTS_LOOP comment in imx_uart_probe() */
 	if (port->rs485.flags & SER_RS485_ENABLED &&
 	    port->rs485.flags & SER_RS485_RTS_ON_SEND &&
-	    sport->have_rtscts && !sport->have_rtsgpio) {
+	    sport->have_rtscts && !sport->have_rtsgpio && loopback) {
 		uts = imx_uart_readl(sport, imx_uart_uts_reg(sport));
 		uts |= UTS_LOOP;
 		imx_uart_writel(sport, uts, imx_uart_uts_reg(sport));
@@ -527,6 +526,16 @@ static void imx_uart_stop_rx(struct uart_port *port)
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
@@ -714,8 +723,13 @@ static void imx_uart_start_tx(struct uart_port *port)
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
 			start_hrtimer_ms(&sport->trigger_start_tx,
-- 
2.11.0


