Return-Path: <stable+bounces-9760-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 747FB8250C1
	for <lists+stable@lfdr.de>; Fri,  5 Jan 2024 10:22:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 984CA1C22D7A
	for <lists+stable@lfdr.de>; Fri,  5 Jan 2024 09:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F009422F17;
	Fri,  5 Jan 2024 09:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="U3GqD/9d"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA57822F0C
	for <stable@vger.kernel.org>; Fri,  5 Jan 2024 09:22:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCA9AC433C8;
	Fri,  5 Jan 2024 09:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704446567;
	bh=qg4FVdgLfbvjhmQN0nlB0e7gPazNDV3h34aZcvNDJ2E=;
	h=Subject:To:From:Date:From;
	b=U3GqD/9dhuZQ8KYMRmSypo18xgb/UfuR3ue5i6yZEDaXUMi/OFRSygs8pL7CI59/b
	 DCYf6qTa9D85rfqduZMZJfIBSCMf/lrHibdEP2tYU8/9NCdM8JXV52+sDFzMI5S2Us
	 oJmxpdkvJ0oko3jHtHZw6lX/m7WvpEPcBGLAiI7c=
Subject: patch "serial: 8250_exar: Set missing rs485_supported flag" added to tty-next
To: l.sanfilippo@kunbus.com,gregkh@linuxfoundation.org,ilpo.jarvinen@linux.intel.com,stable@vger.kernel.org
From: <gregkh@linuxfoundation.org>
Date: Fri, 05 Jan 2024 10:21:52 +0100
Message-ID: <2024010551-provider-unkempt-a832@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    serial: 8250_exar: Set missing rs485_supported flag

to my tty git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git
in the tty-next branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will also be merged in the next major kernel release
during the merge window.

If you have any questions about this process, please let me know.


From 0c2a5f471ce58bca8f8ab5fcb911aff91eaaa5eb Mon Sep 17 00:00:00 2001
From: Lino Sanfilippo <l.sanfilippo@kunbus.com>
Date: Wed, 3 Jan 2024 07:18:18 +0100
Subject: serial: 8250_exar: Set missing rs485_supported flag
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The UART supports an auto-RTS mode in which the RTS pin is automatically
activated during transmission. So mark this mode as being supported even
if RTS is not controlled by the driver but the UART.

Also the serial core expects now at least one of both modes rts-on-send or
rts-after-send to be supported. This is since during sanitization
unsupported flags are deleted from a RS485 configuration set by userspace.
However if the configuration ends up with both flags unset, the core prints
a warning since it considers such a configuration invalid (see
uart_sanitize_serial_rs485()).

Cc:  <stable@vger.kernel.org>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Lino Sanfilippo <l.sanfilippo@kunbus.com>
Link: https://lore.kernel.org/r/20240103061818.564-8-l.sanfilippo@kunbus.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/8250/8250_exar.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
index 6085d356ad86..23366f868ae3 100644
--- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -480,7 +480,7 @@ static int sealevel_rs485_config(struct uart_port *port, struct ktermios *termio
 }
 
 static const struct serial_rs485 generic_rs485_supported = {
-	.flags = SER_RS485_ENABLED,
+	.flags = SER_RS485_ENABLED | SER_RS485_RTS_ON_SEND,
 };
 
 static const struct exar8250_platform exar8250_default_platform = {
@@ -524,7 +524,8 @@ static int iot2040_rs485_config(struct uart_port *port, struct ktermios *termios
 }
 
 static const struct serial_rs485 iot2040_rs485_supported = {
-	.flags = SER_RS485_ENABLED | SER_RS485_RX_DURING_TX | SER_RS485_TERMINATE_BUS,
+	.flags = SER_RS485_ENABLED | SER_RS485_RTS_ON_SEND |
+		 SER_RS485_RX_DURING_TX | SER_RS485_TERMINATE_BUS,
 };
 
 static const struct property_entry iot2040_gpio_properties[] = {
-- 
2.43.0



