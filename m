Return-Path: <stable+bounces-57934-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E033F926262
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 15:57:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95BB2281096
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 13:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A911917106E;
	Wed,  3 Jul 2024 13:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="agJ5Q7fK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6694985624
	for <stable@vger.kernel.org>; Wed,  3 Jul 2024 13:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720015022; cv=none; b=goDapj9PKmkPIpQqN5szWsxFLcjII928MzSfxVRvhMnb46/UbEvCbQgEX3IOgfmyu+OtbKJ1rxcDEefdS4seHxotphELoCv0RSCSSIO0eua3k5Qry7GnejuJTLMzDLAK5kERFmQYaGPGeC+UMCz98vvPdn5/YeJWQeI0YVMLWb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720015022; c=relaxed/simple;
	bh=5q9az4W8cvskSnAdLgVBqZtxBrZwtNZIjh3SDMoQ9PM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=G6N09X/waYRGEoImiNg9uXlWMopiTwM1vADo/KB6MMPsjoHkePNynx0Tny46AOTr92/C93QsR4IiTuIIJQmNAd4QDJOCTcAitSaCo2fMmbw2Vl+4/7COJkpuhQLeoAdd63azVHkPxT4SnzE9WuGJaTopP4D704iRcP3gd5Qrokw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=agJ5Q7fK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9069AC2BD10;
	Wed,  3 Jul 2024 13:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720015022;
	bh=5q9az4W8cvskSnAdLgVBqZtxBrZwtNZIjh3SDMoQ9PM=;
	h=Subject:To:Cc:From:Date:From;
	b=agJ5Q7fKKVFINNPI4VJLXpYfI4/eCGv5TpWgwA5XNvNMbf3ONvnw2uziAoOMiqeJH
	 1Ubq+X9M80lFaUD6fAUljGUv2/VMlAqsS02/GMn7T/z2tDeUELCbL3ikxtbEy3mAXS
	 1FE+ccwT6QSg1TaQNBZzzPe4+uuvGTy4Ds9FQaaE=
Subject: FAILED: patch "[PATCH] serial: imx: only set receiver level if it is zero" failed to apply to 5.4-stable tree
To: stefan.eichenberger@toradex.com,gregkh@linuxfoundation.org,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 03 Jul 2024 15:56:51 +0200
Message-ID: <2024070351-precinct-imperfect-ed7d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 9706fc87b4cff0ac4f5d5d62327be83fe72e3108
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024070351-precinct-imperfect-ed7d@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

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
 


