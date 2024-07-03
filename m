Return-Path: <stable+bounces-57936-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 197E3926265
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 15:57:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B78FF1F23E36
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 13:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1475017B436;
	Wed,  3 Jul 2024 13:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WKp1qtMX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA17D17A59A
	for <stable@vger.kernel.org>; Wed,  3 Jul 2024 13:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720015027; cv=none; b=TZQLgi/vfzIDs+AGKhZ7ax7/XnFCDlXwortJeRA5OglnszS6MyDrX7DfbTfIqDjwTh9nAXoLSfMvYpwSRTrZ6+vgUkPzF6HXx4ORhIpg6AvMBv4JAs6KGvb0Qup21nSe5yaZdOf1TEPiwui2sH4Vm8gsNNbKEeXXJfmyzLthk1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720015027; c=relaxed/simple;
	bh=Vp7j8r5yGtvYTmIWi5wRGWKVm16jSuKVePLxxJyoW3I=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=j5kkLIatu3mMpD//b0CB1NKHrvw/rVducxRqpDjB5F3EP4KOX+7eCp7V2Ug7/uM+La3J15+cuYQDRDSwBaHirWU3IUAcJvBgDLb5OnHowY5HrbHY2cEeExuOHQ8dEmeZuuydYW/nrnAziHg5iXjscG/F6emC2PCMbVU5oIYeGfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WKp1qtMX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50CEEC2BD10;
	Wed,  3 Jul 2024 13:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720015027;
	bh=Vp7j8r5yGtvYTmIWi5wRGWKVm16jSuKVePLxxJyoW3I=;
	h=Subject:To:Cc:From:Date:From;
	b=WKp1qtMXtkSYxTnpv9Mt2/gjGJOnsv8C4xUUovtyV217VXecBmMElva4oBK5DC4n1
	 uekta0I/AhO+xveQ9OI7FWIVg6G1fw2X05uL6EWeCHqA1nT5kdVJcQRPSU+ZwZhO4Y
	 0EOgeeRSYHksgcEplPJPR3WxC7tbCltqzLjbkjA4=
Subject: FAILED: patch "[PATCH] serial: imx: only set receiver level if it is zero" failed to apply to 4.19-stable tree
To: stefan.eichenberger@toradex.com,gregkh@linuxfoundation.org,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 03 Jul 2024 15:56:52 +0200
Message-ID: <2024070352-machinist-blemish-148b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x 9706fc87b4cff0ac4f5d5d62327be83fe72e3108
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024070352-machinist-blemish-148b@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9706fc87b4cff0ac4f5d5d62327be83fe72e3108 Mon Sep 17 00:00:00 2001
From: Stefan Eichenberger <stefan.eichenberger@toradex.com>
Date: Wed, 3 Jul 2024 13:25:40 +0200
Subject: [PATCH] serial: imx: only set receiver level if it is zero

With commit a81dbd0463ec ("serial: imx: set receiver level before
starting uart") we set the receiver level to its default value. This
caused a regression when using SDMA, where the receiver level is 9
instead of 8 (default). This change will first check if the receiver
level is zero and only then set it to the default. This still avoids the
interrupt storm when the receiver level is zero.

Fixes: a81dbd0463ec ("serial: imx: set receiver level before starting uart")
Cc: stable <stable@kernel.org>
Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
Link: https://lore.kernel.org/r/20240703112543.148304-1-eichest@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index f4f40c9373c2..e22be8f45c93 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -120,6 +120,7 @@
 #define UCR4_OREN	(1<<1)	/* Receiver overrun interrupt enable */
 #define UCR4_DREN	(1<<0)	/* Recv data ready interrupt enable */
 #define UFCR_RXTL_SHF	0	/* Receiver trigger level shift */
+#define UFCR_RXTL_MASK	0x3F	/* Receiver trigger 6 bits wide */
 #define UFCR_DCEDTE	(1<<6)	/* DCE/DTE mode select */
 #define UFCR_RFDIV	(7<<7)	/* Reference freq divider mask */
 #define UFCR_RFDIV_REG(x)	(((x) < 7 ? 6 - (x) : 6) << 7)
@@ -1933,7 +1934,7 @@ static int imx_uart_rs485_config(struct uart_port *port, struct ktermios *termio
 				 struct serial_rs485 *rs485conf)
 {
 	struct imx_port *sport = (struct imx_port *)port;
-	u32 ucr2;
+	u32 ucr2, ufcr;
 
 	if (rs485conf->flags & SER_RS485_ENABLED) {
 		/* Enable receiver if low-active RTS signal is requested */
@@ -1953,7 +1954,10 @@ static int imx_uart_rs485_config(struct uart_port *port, struct ktermios *termio
 	/* Make sure Rx is enabled in case Tx is active with Rx disabled */
 	if (!(rs485conf->flags & SER_RS485_ENABLED) ||
 	    rs485conf->flags & SER_RS485_RX_DURING_TX) {
-		imx_uart_setup_ufcr(sport, TXTL_DEFAULT, RXTL_DEFAULT);
+		/* If the receiver trigger is 0, set it to a default value */
+		ufcr = imx_uart_readl(sport, UFCR);
+		if ((ufcr & UFCR_RXTL_MASK) == 0)
+			imx_uart_setup_ufcr(sport, TXTL_DEFAULT, RXTL_DEFAULT);
 		imx_uart_start_rx(port);
 	}
 


