Return-Path: <stable+bounces-9698-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D8F6824508
	for <lists+stable@lfdr.de>; Thu,  4 Jan 2024 16:33:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A6AD1C22287
	for <lists+stable@lfdr.de>; Thu,  4 Jan 2024 15:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACC5324201;
	Thu,  4 Jan 2024 15:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="r/Z6d3V/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78798241FD
	for <stable@vger.kernel.org>; Thu,  4 Jan 2024 15:33:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A32BC433C8;
	Thu,  4 Jan 2024 15:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704382436;
	bh=O7n8Et8XeZjhnQgAqgh/bLLWflJSf9hNthTXB0CtDl4=;
	h=Subject:To:From:Date:From;
	b=r/Z6d3V/Ymhx7DyFydtwSlv6hu3ip5ETjbgWcEc53bJAqYPCA8h1E3Y3z8hpR56bX
	 rVX4JidFA0w5oKakWvuc0FuKbZzBB4JXG84pNazAWzQmzUEjo7mcZBpf8HmZ6TBGA0
	 p2t5vBpJIlZ4BpLHJdKJosbfnHInSKHmydaEcy4I=
Subject: patch "serial: core: fix sanitizing check for RTS settings" added to tty-testing
To: l.sanfilippo@kunbus.com,gregkh@linuxfoundation.org,ilpo.jarvinen@linux.intel.com,stable@vger.kernel.org
From: <gregkh@linuxfoundation.org>
Date: Thu, 04 Jan 2024 16:33:49 +0100
Message-ID: <2024010449-anemic-anyplace-9b80@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    serial: core: fix sanitizing check for RTS settings

to my tty git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git
in the tty-testing branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will be merged to the tty-next branch sometime soon,
after it passes testing, and the merge window is open.

If you have any questions about this process, please let me know.


From 4afeced55baa391490b61ed9164867e2927353ed Mon Sep 17 00:00:00 2001
From: Lino Sanfilippo <l.sanfilippo@kunbus.com>
Date: Wed, 3 Jan 2024 07:18:14 +0100
Subject: serial: core: fix sanitizing check for RTS settings
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Among other things uart_sanitize_serial_rs485() tests the sanity of the RTS
settings in a RS485 configuration that has been passed by userspace.
If RTS-on-send and RTS-after-send are both set or unset the configuration
is adjusted and RTS-after-send is disabled and RTS-on-send enabled.

This however makes only sense if both RTS modes are actually supported by
the driver.

With commit be2e2cb1d281 ("serial: Sanitize rs485_struct") the code does
take the driver support into account but only checks if one of both RTS
modes are supported. This may lead to the errorneous result of RTS-on-send
being set even if only RTS-after-send is supported.

Fix this by changing the implemented logic: First clear all unsupported
flags in the RS485 configuration, then adjust an invalid RTS setting by
taking into account which RTS mode is supported.

Cc:  <stable@vger.kernel.org>
Fixes: be2e2cb1d281 ("serial: Sanitize rs485_struct")
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Lino Sanfilippo <l.sanfilippo@kunbus.com>
Link: https://lore.kernel.org/r/20240103061818.564-4-l.sanfilippo@kunbus.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/serial_core.c | 32 ++++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 850f24cc53e5..cd8c3a70455e 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -1376,20 +1376,28 @@ static void uart_sanitize_serial_rs485(struct uart_port *port, struct serial_rs4
 		return;
 	}
 
-	/* Pick sane settings if the user hasn't */
-	if ((supported_flags & (SER_RS485_RTS_ON_SEND|SER_RS485_RTS_AFTER_SEND)) &&
-	    !(rs485->flags & SER_RS485_RTS_ON_SEND) ==
-	    !(rs485->flags & SER_RS485_RTS_AFTER_SEND)) {
-		dev_warn_ratelimited(port->dev,
-			"%s (%d): invalid RTS setting, using RTS_ON_SEND instead\n",
-			port->name, port->line);
-		rs485->flags |= SER_RS485_RTS_ON_SEND;
-		rs485->flags &= ~SER_RS485_RTS_AFTER_SEND;
-		supported_flags |= SER_RS485_RTS_ON_SEND|SER_RS485_RTS_AFTER_SEND;
-	}
-
 	rs485->flags &= supported_flags;
 
+	/* Pick sane settings if the user hasn't */
+	if (!(rs485->flags & SER_RS485_RTS_ON_SEND) ==
+	    !(rs485->flags & SER_RS485_RTS_AFTER_SEND)) {
+		if (supported_flags & SER_RS485_RTS_ON_SEND) {
+			rs485->flags |= SER_RS485_RTS_ON_SEND;
+			rs485->flags &= ~SER_RS485_RTS_AFTER_SEND;
+
+			dev_warn_ratelimited(port->dev,
+				"%s (%d): invalid RTS setting, using RTS_ON_SEND instead\n",
+				port->name, port->line);
+		} else {
+			rs485->flags |= SER_RS485_RTS_AFTER_SEND;
+			rs485->flags &= ~SER_RS485_RTS_ON_SEND;
+
+			dev_warn_ratelimited(port->dev,
+				"%s (%d): invalid RTS setting, using RTS_AFTER_SEND instead\n",
+				port->name, port->line);
+		}
+	}
+
 	uart_sanitize_serial_rs485_delays(port, rs485);
 
 	/* Return clean padding area to userspace */
-- 
2.43.0



