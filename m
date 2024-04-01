Return-Path: <stable+bounces-35028-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E68B8941F9
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 18:48:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D91971F229A3
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 16:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DCD1482CA;
	Mon,  1 Apr 2024 16:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BA1v78bV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE17433DA;
	Mon,  1 Apr 2024 16:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711990104; cv=none; b=GLStNVWmIiR9tyJibM2TYOlzT4D+XPJF/nyyaIgOf5JRXZiB3Z0zNgghOcJ8aAyvZgPPy7A4qIaDh4p9i8yene0uG4/ptMVAnE6YPySOY74m0KAV9hiCW7hlywns9qEagWQpemCSuMjcS5kvXV4aXz2g9DGLtoYTjxYgLvkpKVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711990104; c=relaxed/simple;
	bh=lO/H2E/tyzehi22GrI423JoHey0zk+cWaTh4aIYdrPE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L8eRx4ZRYn8p9dbXZzA81hB7QY6Y8Kxxt+O/+Fv7AYlVwcfaDjQXltxvrajjGW+Gs74X1Uf5J2IveUnOQJmal6KD6pZVBH6Vsh5Xo1XVMGbF5WlL+Oe4Yb+Vrd078cfmu2WgqGu+S+gJfHoymJiyqrIPAxL0v99OfG+84cWJUUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BA1v78bV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D91EC433C7;
	Mon,  1 Apr 2024 16:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711990103;
	bh=lO/H2E/tyzehi22GrI423JoHey0zk+cWaTh4aIYdrPE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BA1v78bVkvSL6NuTtr994NLw3xmssdYIzVelE1ggZxZARRUKLAsSvRjhpYlj5j895
	 TwHDBVFqNNM4wsdqzF0B3+Lp2zGHVdg6+dZatNo72UuCz28NujSXEz6Wxu43fZcGJG
	 gM5LnoKsSavreMlyrWnNWboMmTr8jrfRe5JkctS0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable <stable@kernel.org>,
	Rickard x Andersson <rickaran@axis.com>,
	Christoph Niedermaier <cniedermaier@dh-electronics.com>
Subject: [PATCH 6.6 218/396] tty: serial: imx: Fix broken RS485
Date: Mon,  1 Apr 2024 17:44:27 +0200
Message-ID: <20240401152554.420737808@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240401152547.867452742@linuxfoundation.org>
References: <20240401152547.867452742@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rickard x Andersson <rickaran@axis.com>

commit 672448ccf9b6a676f96f9352cbf91f4d35f4084a upstream.

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
---
 drivers/tty/serial/imx.c |   22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -468,8 +468,7 @@ static void imx_uart_stop_tx(struct uart
 	}
 }
 
-/* called with port.lock taken and irqs off */
-static void imx_uart_stop_rx(struct uart_port *port)
+static void imx_uart_stop_rx_with_loopback_ctrl(struct uart_port *port, bool loopback)
 {
 	struct imx_port *sport = (struct imx_port *)port;
 	u32 ucr1, ucr2, ucr4, uts;
@@ -491,7 +490,7 @@ static void imx_uart_stop_rx(struct uart
 	/* See SER_RS485_ENABLED/UTS_LOOP comment in imx_uart_probe() */
 	if (port->rs485.flags & SER_RS485_ENABLED &&
 	    port->rs485.flags & SER_RS485_RTS_ON_SEND &&
-	    sport->have_rtscts && !sport->have_rtsgpio) {
+	    sport->have_rtscts && !sport->have_rtsgpio && loopback) {
 		uts = imx_uart_readl(sport, imx_uart_uts_reg(sport));
 		uts |= UTS_LOOP;
 		imx_uart_writel(sport, uts, imx_uart_uts_reg(sport));
@@ -504,6 +503,16 @@ static void imx_uart_stop_rx(struct uart
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
@@ -688,9 +697,14 @@ static void imx_uart_start_tx(struct uar
 				imx_uart_rts_inactive(sport, &ucr2);
 			imx_uart_writel(sport, ucr2, UCR2);
 
+			/*
+			 * Since we are about to transmit we can not stop RX
+			 * with loopback enabled because that will make our
+			 * transmitted data being just looped to RX.
+			 */
 			if (!(port->rs485.flags & SER_RS485_RX_DURING_TX) &&
 			    !port->rs485_rx_during_tx_gpio)
-				imx_uart_stop_rx(port);
+				imx_uart_stop_rx_with_loopback_ctrl(port, false);
 
 			sport->tx_state = WAIT_AFTER_RTS;
 



