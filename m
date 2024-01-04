Return-Path: <stable+bounces-9697-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C035F824507
	for <lists+stable@lfdr.de>; Thu,  4 Jan 2024 16:33:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 739CF1F2634C
	for <lists+stable@lfdr.de>; Thu,  4 Jan 2024 15:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2FD224206;
	Thu,  4 Jan 2024 15:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YbywqPyi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2AA241FE
	for <stable@vger.kernel.org>; Thu,  4 Jan 2024 15:33:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0B0BC433C7;
	Thu,  4 Jan 2024 15:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704382433;
	bh=Gr+dl7M2Vz9EAf6FUqGw1VllikHaqL2j1Sz9Yz+u/84=;
	h=Subject:To:From:Date:From;
	b=YbywqPyi7jCY4uhDypYouVvnyPUq7WVvasiJEOcOM04JMNcMa8rLnkl6KdHAQJL0s
	 QalTBUqjanxebIRh9Hak309NkTev8QJhYQCaNCH671yJKC9dq8y2Sja360PSUI86YY
	 c400Qn0oq/Go/ava3x5AD2RaB9Eo9COpAJ5K//DY=
Subject: patch "serial: core: set missing supported flag for RX during TX GPIO" added to tty-testing
To: l.sanfilippo@kunbus.com,gregkh@linuxfoundation.org,ilpo.jarvinen@linux.intel.com,stable@vger.kernel.org
From: <gregkh@linuxfoundation.org>
Date: Thu, 04 Jan 2024 16:33:48 +0100
Message-ID: <2024010448-thursday-stature-b232@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    serial: core: set missing supported flag for RX during TX GPIO

to my tty git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git
in the tty-testing branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will be merged to the tty-next branch sometime soon,
after it passes testing, and the merge window is open.

If you have any questions about this process, please let me know.


From 1a33e33ca0e80d485458410f149265cdc0178cfa Mon Sep 17 00:00:00 2001
From: Lino Sanfilippo <l.sanfilippo@kunbus.com>
Date: Wed, 3 Jan 2024 07:18:13 +0100
Subject: serial: core: set missing supported flag for RX during TX GPIO
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

If the RS485 feature RX-during-TX is supported by means of a GPIO set the
according supported flag. Otherwise setting this feature from userspace may
not be possible, since in uart_sanitize_serial_rs485() the passed RS485
configuration is matched against the supported features and unsupported
settings are thereby removed and thus take no effect.

Cc:  <stable@vger.kernel.org>
Fixes: 163f080eb717 ("serial: core: Add option to output RS485 RX_DURING_TX state via GPIO")
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Lino Sanfilippo <l.sanfilippo@kunbus.com>
Link: https://lore.kernel.org/r/20240103061818.564-3-l.sanfilippo@kunbus.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/serial_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 8d381c283cec..850f24cc53e5 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -3649,6 +3649,8 @@ int uart_get_rs485_mode(struct uart_port *port)
 	if (IS_ERR(desc))
 		return dev_err_probe(dev, PTR_ERR(desc), "Cannot get rs485-rx-during-tx-gpios\n");
 	port->rs485_rx_during_tx_gpio = desc;
+	if (port->rs485_rx_during_tx_gpio)
+		port->rs485_supported.flags |= SER_RS485_RX_DURING_TX;
 
 	return 0;
 }
-- 
2.43.0



