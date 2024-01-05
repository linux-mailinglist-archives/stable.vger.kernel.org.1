Return-Path: <stable+bounces-9754-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D3C58250BB
	for <lists+stable@lfdr.de>; Fri,  5 Jan 2024 10:22:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EA7A1C22CC9
	for <lists+stable@lfdr.de>; Fri,  5 Jan 2024 09:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A005C23747;
	Fri,  5 Jan 2024 09:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="N1i9LiDz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694A022F13
	for <stable@vger.kernel.org>; Fri,  5 Jan 2024 09:22:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A0FDC433C8;
	Fri,  5 Jan 2024 09:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704446542;
	bh=e2s4Am2FcQhx4iX86h+FsFBCtEYuzGYLFVQk/ISe0Og=;
	h=Subject:To:From:Date:From;
	b=N1i9LiDzQRuW3ssxmoBx7lHBt9t0j2my6s40PuTvdJM6E5NsEs4xjwhyhIqkeCxPb
	 XC9rla3KUZzr7zrfzSE4BNm25Gu8s7zgTMgqUE+oHx/eXj+Om2kel/IeOzO5b8g5+v
	 2S0cWAmaNqBGxg6Wd/f7OKP/TLg+aAYIpN/U0PfQ=
Subject: patch "serial: core: set missing supported flag for RX during TX GPIO" added to tty-next
To: l.sanfilippo@kunbus.com,gregkh@linuxfoundation.org,ilpo.jarvinen@linux.intel.com,stable@vger.kernel.org
From: <gregkh@linuxfoundation.org>
Date: Fri, 05 Jan 2024 10:21:46 +0100
Message-ID: <2024010546-obtrusive-capital-d0fe@gregkh>
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
in the tty-next branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will also be merged in the next major kernel release
during the merge window.

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



