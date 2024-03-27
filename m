Return-Path: <stable+bounces-32974-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83BF688EAED
	for <lists+stable@lfdr.de>; Wed, 27 Mar 2024 17:17:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C667DB22898
	for <lists+stable@lfdr.de>; Wed, 27 Mar 2024 15:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C40EB12E1FB;
	Wed, 27 Mar 2024 15:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fQKsHI6Y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8162D81AD2
	for <stable@vger.kernel.org>; Wed, 27 Mar 2024 15:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711552010; cv=none; b=YQjicuqvlBO8XqYzGkLUHE+DLZTvpFzkU+t5oIf49/BUzWZS7zLBYIeY/J3C842r+WKhYjS+KXaHpDzNBBl93MrZ2c2FRcv27OpLV9Sq6KWLguOcadoPJyh4Jut6VpHucVEHcCP3BMOKexiEclIUhOHiJDTPnD5jFTAkTVMZfkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711552010; c=relaxed/simple;
	bh=o2i3pmpv4/VDk7hXnY2gUBEYm/5O8SUSnJI5ZUcsJP8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Sx5s+YuOZn57rUaBIhBWbPAuwiRNIgrJmSorDw+Fw8tp3e+4ZGEiDqHFdrW/pnNod3FE9jeYR3DNvc0yGPHL20YxBaRYH0uqVSBjdsoCTJZTIGwMYL6bz4me9YbFYtB6rZaCQVQNji8EbEUpMw0eIXTPibr6TGAX0KfrNjIjxi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fQKsHI6Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BCFCC433F1;
	Wed, 27 Mar 2024 15:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711552010;
	bh=o2i3pmpv4/VDk7hXnY2gUBEYm/5O8SUSnJI5ZUcsJP8=;
	h=Subject:To:Cc:From:Date:From;
	b=fQKsHI6YduY0xprY+nrLOqAXRPA3CqYy6WkynTkf6ZghQtVbjVAAZYIeOa9hDRPs5
	 EXysLCb5tLEiO+rY6IJH5/8tq/F7MiByNziEvBaXvCJu4xfREZsHACq8Wr3DyIYHqp
	 Q7tbkMLksFJ1TKjfIsyOlSzAUjUq7Kg5CkaUyHrE=
Subject: FAILED: patch "[PATCH] tty: serial: imx: Fix broken RS485" failed to apply to 6.1-stable tree
To: rickaran@axis.com,cniedermaier@dh-electronics.com,gregkh@linuxfoundation.org,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 27 Mar 2024 16:06:46 +0100
Message-ID: <2024032746-stilt-vaporizer-fb22@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 672448ccf9b6a676f96f9352cbf91f4d35f4084a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024032746-stilt-vaporizer-fb22@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

672448ccf9b6 ("tty: serial: imx: Fix broken RS485")
ca530cfa968c ("serial: imx: Add support for RS485 RX_DURING_TX output GPIO")
79d0224f6bf2 ("tty: serial: imx: Handle RS485 DE signal active high")

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
 


