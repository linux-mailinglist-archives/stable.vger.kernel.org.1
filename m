Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E04C0790BEF
	for <lists+stable@lfdr.de>; Sun,  3 Sep 2023 14:42:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237155AbjICMmI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 3 Sep 2023 08:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231726AbjICMmH (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 3 Sep 2023 08:42:07 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36DD712D
        for <stable@vger.kernel.org>; Sun,  3 Sep 2023 05:42:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 48750CE09CB
        for <stable@vger.kernel.org>; Sun,  3 Sep 2023 12:42:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F448C433C8;
        Sun,  3 Sep 2023 12:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693744920;
        bh=kOyZaHs1jA6YHGzh5/7UMT0QxhbLn2R4GX2MfoGQL1Q=;
        h=Subject:To:Cc:From:Date:From;
        b=CvQ+QkAqkWLlBypmMGTWTkkCPg7SwbqJXvXkUlQrYfeuOq7xomVhnaIdEI9lmojnb
         zDoIYjsfrnfEPBoKGUF1V3R8CMPq9SEdnxIO1+vdq+xde4zR1xW96OBei8grHiGR75
         pV7XUTtQszqNZS8CsGEePDdP/BD480/lT5F0ZTGs=
Subject: FAILED: patch "[PATCH] serial: sc16is7xx: fix broken port 0 uart init" failed to apply to 4.14-stable tree
To:     hvilleneuve@dimonoff.com, gregkh@linuxfoundation.org,
        ilpo.jarvinen@linux.intel.com, lech.perczak@camlingroup.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sun, 03 Sep 2023 14:41:04 +0200
Message-ID: <2023090303-iciness-cornea-e5c6@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 4.14-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.14.y
git checkout FETCH_HEAD
git cherry-pick -x 2861ed4d6e6d1a2c9de9bf5b0abd996c2dc673d0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023090303-iciness-cornea-e5c6@gregkh' --subject-prefix 'PATCH 4.14.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2861ed4d6e6d1a2c9de9bf5b0abd996c2dc673d0 Mon Sep 17 00:00:00 2001
From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
Date: Mon, 7 Aug 2023 17:45:51 -0400
Subject: [PATCH] serial: sc16is7xx: fix broken port 0 uart init
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The sc16is7xx_config_rs485() function is called only for the second
port (index 1, channel B), causing initialization problems for the
first port.

For the sc16is7xx driver, port->membase and port->mapbase are not set,
and their default values are 0. And we set port->iobase to the device
index. This means that when the first device is registered using the
uart_add_one_port() function, the following values will be in the port
structure:
    port->membase = 0
    port->mapbase = 0
    port->iobase  = 0

Therefore, the function uart_configure_port() in serial_core.c will
exit early because of the following check:
	/*
	 * If there isn't a port here, don't do anything further.
	 */
	if (!port->iobase && !port->mapbase && !port->membase)
		return;

Typically, I2C and SPI drivers do not set port->membase and
port->mapbase.

The max310x driver sets port->membase to ~0 (all ones). By
implementing the same change in this driver, uart_configure_port() is
now correctly executed for all ports.

Fixes: dfeae619d781 ("serial: sc16is7xx")
Cc: stable@vger.kernel.org
Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Lech Perczak <lech.perczak@camlingroup.com>
Tested-by: Lech Perczak <lech.perczak@camlingroup.com>
Link: https://lore.kernel.org/r/20230807214556.540627-2-hugo@hugovil.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index 18a48ce052c2..ffe817309413 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -1438,6 +1438,12 @@ static int sc16is7xx_probe(struct device *dev,
 		s->p[i].port.fifosize	= SC16IS7XX_FIFO_SIZE;
 		s->p[i].port.flags	= UPF_FIXED_TYPE | UPF_LOW_LATENCY;
 		s->p[i].port.iobase	= i;
+		/*
+		 * Use all ones as membase to make sure uart_configure_port() in
+		 * serial_core.c does not abort for SPI/I2C devices where the
+		 * membase address is not applicable.
+		 */
+		s->p[i].port.membase	= (void __iomem *)~0;
 		s->p[i].port.iotype	= UPIO_PORT;
 		s->p[i].port.uartclk	= freq;
 		s->p[i].port.rs485_config = sc16is7xx_config_rs485;

