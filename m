Return-Path: <stable+bounces-9699-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62499824509
	for <lists+stable@lfdr.de>; Thu,  4 Jan 2024 16:34:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70FF41C221A0
	for <lists+stable@lfdr.de>; Thu,  4 Jan 2024 15:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8C2A241FE;
	Thu,  4 Jan 2024 15:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="baJX1tvA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D14A241F7
	for <stable@vger.kernel.org>; Thu,  4 Jan 2024 15:33:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A42FC433C8;
	Thu,  4 Jan 2024 15:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704382439;
	bh=hZ2zc/GWIWNUUm+7KxQUC9a3A77iUuUPIl6Wu4IPBrI=;
	h=Subject:To:From:Date:From;
	b=baJX1tvANDSt6uvFoRFOYip7UsH2AR2CkifrmxGWbBq2qkHTBpherVKHDVSTgWFvI
	 NPnzGPornZknIBxp+RU2Sk7P2aynSN7sB/Dl5ji8i1z05jtfkP7czEA7PgFZ1MdCdB
	 Fw13v/GT4lrJcx7aTimHC0Yk7MXyoA8OEn2cKI30=
Subject: patch "serial: core: make sure RS485 cannot be enabled when it is not" added to tty-testing
To: l.sanfilippo@kunbus.com,gregkh@linuxfoundation.org,ilpo.jarvinen@linux.intel.com,s.hauer@pengutronix.de,shawnguo@kernel.org,stable@vger.kernel.org
From: <gregkh@linuxfoundation.org>
Date: Thu, 04 Jan 2024 16:33:50 +0100
Message-ID: <2024010450-snub-grandly-6611@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    serial: core: make sure RS485 cannot be enabled when it is not

to my tty git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git
in the tty-testing branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will be merged to the tty-next branch sometime soon,
after it passes testing, and the merge window is open.

If you have any questions about this process, please let me know.


From c73986913fa47e71e0b1ad7f039f6444915e8810 Mon Sep 17 00:00:00 2001
From: Lino Sanfilippo <l.sanfilippo@kunbus.com>
Date: Wed, 3 Jan 2024 07:18:15 +0100
Subject: serial: core: make sure RS485 cannot be enabled when it is not
 supported
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Some uart drivers specify a rs485_config() function and then decide later
to disable RS485 support for some reason (e.g. imx and ar933).

In these cases userspace may be able to activate RS485 via TIOCSRS485
nevertheless, since in uart_set_rs485_config() an existing rs485_config()
function indicates that RS485 is supported.

Make sure that this is not longer possible by checking the uarts
rs485_supported.flags instead and bailing out if SER_RS485_ENABLED is not
set.

Furthermore instead of returning an empty structure return -ENOTTY if the
RS485 configuration is requested via TIOCGRS485 but RS485 is not supported.
This has a small impact on userspace visibility but it is consistent with
the -ENOTTY error for TIOCGRS485.

Fixes: e849145e1fdd ("serial: ar933x: Fill in rs485_supported")
Fixes: 55e18c6b6d42 ("serial: imx: Remove serial_rs485 sanitization")
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc:  <stable@vger.kernel.org>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Lino Sanfilippo <l.sanfilippo@kunbus.com>
Link: https://lore.kernel.org/r/20240103061818.564-5-l.sanfilippo@kunbus.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/serial_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index cd8c3a70455e..b9606db78c92 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -1474,7 +1474,7 @@ static int uart_set_rs485_config(struct tty_struct *tty, struct uart_port *port,
 	int ret;
 	unsigned long flags;
 
-	if (!port->rs485_config)
+	if (!(port->rs485_supported.flags & SER_RS485_ENABLED))
 		return -ENOTTY;
 
 	if (copy_from_user(&rs485, rs485_user, sizeof(*rs485_user)))
-- 
2.43.0



