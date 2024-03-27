Return-Path: <stable+bounces-32975-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0515088E889
	for <lists+stable@lfdr.de>; Wed, 27 Mar 2024 16:22:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 944BD1F32DDE
	for <lists+stable@lfdr.de>; Wed, 27 Mar 2024 15:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C88A1CA9C;
	Wed, 27 Mar 2024 15:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="z+uYEM5z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA1312FB29
	for <stable@vger.kernel.org>; Wed, 27 Mar 2024 15:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711552018; cv=none; b=XRGNnZbpdJ2C6C5xEFYh88vwg0JuVKOQi4vZdLKMJ7FhNMN/fSCzST4ze/hAgTC3FLzpE/ugz3yhGC9mazQ57sAczblgRBfV/BPBx5oa4MC6nxRrc4F8JpYwDLbHyqZBI25k2/4Zsh6EAManNeRQoFC856Vwj/Cos+2VB1Pnp6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711552018; c=relaxed/simple;
	bh=+78fclx7lF+C4SKysyboaDXz1CfytKNlOMipS0AkmKA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Gx8NM0JweXqvcVdqFkrHfNaF59tfaCxZvJseGRPM3aSOeG9BVQR9/+2G4C5Lm6n1B7xVUTxb+eh7cOGhMCM/pBNaPb/uHPaa2lff9rwl6y0I78aLttXMqnBoFiiKVdQ5rNiupYb6uqR9yG2Pp0SS6K60g1AOvE4EH3oHQgB2Pss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=z+uYEM5z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82183C433F1;
	Wed, 27 Mar 2024 15:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711552017;
	bh=+78fclx7lF+C4SKysyboaDXz1CfytKNlOMipS0AkmKA=;
	h=Subject:To:Cc:From:Date:From;
	b=z+uYEM5ztG0uD6N1JP68l+yDRWlfyFVpO8m+FMvvqJEANypOic7C2lNYoRkEd3Fxh
	 0TcTI02HhQRtdkKsn3cEPA/RaxXj9ZFSKFgKSadK2+9VErMlzLKVpkbSCUIb+RwuYq
	 0t1ZTIRPUWZhHSzw0H8J0FHZ7NTlOTEYkW0PRgQk=
Subject: FAILED: patch "[PATCH] tty: serial: imx: Fix broken RS485" failed to apply to 5.15-stable tree
To: rickaran@axis.com,cniedermaier@dh-electronics.com,gregkh@linuxfoundation.org,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 27 Mar 2024 16:06:47 +0100
Message-ID: <2024032747-spiritism-worsening-c504@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 672448ccf9b6a676f96f9352cbf91f4d35f4084a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024032747-spiritism-worsening-c504@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

672448ccf9b6 ("tty: serial: imx: Fix broken RS485")
ca530cfa968c ("serial: imx: Add support for RS485 RX_DURING_TX output GPIO")
79d0224f6bf2 ("tty: serial: imx: Handle RS485 DE signal active high")
915162460152 ("serial: imx: remove redundant assignment in rs485_config")
028e083832b0 ("tty: serial: imx: disable UCR4_OREN in .stop_rx() instead of .shutdown()")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 672448ccf9b6a676f96f9352cbf91f4d35f4084a Mon Sep 17 00:00:00 2001
From: Rickard x Andersson <rickaran@axis.com>
Date: Wed, 21 Feb 2024 12:53:04 +0100
Subject: [PATCH] tty: serial: imx: Fix broken RS485

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

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 4aa72d5aeafb..e14813250616 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -462,8 +462,7 @@ static void imx_uart_stop_tx(struct uart_port *port)
 	}
 }
 
-/* called with port.lock taken and irqs off */
-static void imx_uart_stop_rx(struct uart_port *port)
+static void imx_uart_stop_rx_with_loopback_ctrl(struct uart_port *port, bool loopback)
 {
 	struct imx_port *sport = (struct imx_port *)port;
 	u32 ucr1, ucr2, ucr4, uts;
@@ -485,7 +484,7 @@ static void imx_uart_stop_rx(struct uart_port *port)
 	/* See SER_RS485_ENABLED/UTS_LOOP comment in imx_uart_probe() */
 	if (port->rs485.flags & SER_RS485_ENABLED &&
 	    port->rs485.flags & SER_RS485_RTS_ON_SEND &&
-	    sport->have_rtscts && !sport->have_rtsgpio) {
+	    sport->have_rtscts && !sport->have_rtsgpio && loopback) {
 		uts = imx_uart_readl(sport, imx_uart_uts_reg(sport));
 		uts |= UTS_LOOP;
 		imx_uart_writel(sport, uts, imx_uart_uts_reg(sport));
@@ -497,6 +496,16 @@ static void imx_uart_stop_rx(struct uart_port *port)
 	imx_uart_writel(sport, ucr2, UCR2);
 }
 
+/* called with port.lock taken and irqs off */
+static void imx_uart_stop_rx(struct uart_port *port)
+{
+	/*
+	 * Stop RX and enable loopback in order to make sure RS485 bus
+	 * is not blocked. Se comment in imx_uart_probe().
+	 */
+	imx_uart_stop_rx_with_loopback_ctrl(port, true);
+}
+
 /* called with port.lock taken and irqs off */
 static void imx_uart_enable_ms(struct uart_port *port)
 {
@@ -682,9 +691,14 @@ static void imx_uart_start_tx(struct uart_port *port)
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
 


