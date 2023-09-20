Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2B57A8070
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235917AbjITMhU (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235334AbjITMhT (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:37:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA735B6
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:37:13 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFE99C433C8;
        Wed, 20 Sep 2023 12:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695213433;
        bh=ivbeCynZxSvRnKVXm/jU0qDpQRtrt4wsNb++YGz1DPg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OzxeL5U1vAMWJeS96xB+KbWzdxKxcMNX/87+65YvdVaILHTVTxfaAEZIvGZ/XpHTf
         sMpsW2bfNn56XybHZyTM2mk0KMvsGvm4WQMI0cEdE4rVSkAQsToiTqURZX2xFB2yg0
         KeA3HzQYCf3KlMNHZ8NuFoERobVbnwPGoj8dve3Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Lech Perczak <lech.perczak@camlingroup.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 235/367] serial: sc16is7xx: fix broken port 0 uart init
Date:   Wed, 20 Sep 2023 13:30:12 +0200
Message-ID: <20230920112904.656415502@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112858.471730572@linuxfoundation.org>
References: <20230920112858.471730572@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

[ Upstream commit 2861ed4d6e6d1a2c9de9bf5b0abd996c2dc673d0 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/sc16is7xx.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index 9b68725d4e9ba..091cf5fe90304 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -1271,6 +1271,12 @@ static int sc16is7xx_probe(struct device *dev,
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
-- 
2.40.1



