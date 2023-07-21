Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8863675D4AE
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 21:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232204AbjGUTXz (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 15:23:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232206AbjGUTXy (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 15:23:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 135322D7F
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:23:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A3DF661B1C
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 19:23:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5DF3C433C7;
        Fri, 21 Jul 2023 19:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689967432;
        bh=BAgm6WRvlXtxDvOALlBp+GypJiNiT5K1hygsApGbHYo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wmi696toEkkMU31970YxMv8KG1mU85YEwpDYv5pqfsqDrr/3MsOOM6IgI/2lkJPTt
         sVI4qj9zzFUdWw5bjR5/n48dE9x548PUG8OKvY7QysjcMo66HLL0s6yJoC3KXfs7Bk
         BRvU0s+bW2iv0Agb/bc41IAW0X60cmOVJStduAQE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Martin Fuzzey <martin.fuzzey@flowbird.group>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 6.1 160/223] tty: serial: imx: fix rs485 rx after tx
Date:   Fri, 21 Jul 2023 18:06:53 +0200
Message-ID: <20230721160527.700771637@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160520.865493356@linuxfoundation.org>
References: <20230721160520.865493356@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Martin Fuzzey <martin.fuzzey@flowbird.group>

commit 639949a7031e04c59ec91614eceb9543e9120f43 upstream.

Since commit 79d0224f6bf2 ("tty: serial: imx: Handle RS485 DE signal
active high") RS485 reception no longer works after a transmission.

The following scenario shows the problem:
	1) Open a port in RS485 mode
	2) Receive data from remote (OK)
	3) Transmit data to remote (OK)
	4) Receive data from remote (Nothing received)

In RS485 mode, imx_uart_start_tx() calls imx_uart_stop_rx() and, when the
transmission is complete, imx_uart_stop_tx() calls imx_uart_start_rx().

Since the above commit imx_uart_stop_rx() now sets the loopback bit but
imx_uart_start_rx() does not clear it causing the hardware to remain in
loopback mode and not receive external data.

Fix this by moving the existing loopback disable code to a helper function
and calling it from imx_uart_start_rx() too.

Fixes: 79d0224f6bf2 ("tty: serial: imx: Handle RS485 DE signal active high")
Cc: stable@vger.kernel.org
Signed-off-by: Martin Fuzzey <martin.fuzzey@flowbird.group>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Link: https://lore.kernel.org/r/20230616104838.2729694-1-martin.fuzzey@flowbird.group
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/imx.c |   18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -397,6 +397,16 @@ static void start_hrtimer_ms(struct hrti
        hrtimer_start(hrt, ms_to_ktime(msec), HRTIMER_MODE_REL);
 }
 
+static void imx_uart_disable_loopback_rs485(struct imx_port *sport)
+{
+	unsigned int uts;
+
+	/* See SER_RS485_ENABLED/UTS_LOOP comment in imx_uart_probe() */
+	uts = imx_uart_readl(sport, imx_uart_uts_reg(sport));
+	uts &= ~UTS_LOOP;
+	imx_uart_writel(sport, uts, imx_uart_uts_reg(sport));
+}
+
 /* called with port.lock taken and irqs off */
 static void imx_uart_start_rx(struct uart_port *port)
 {
@@ -418,6 +428,7 @@ static void imx_uart_start_rx(struct uar
 	/* Write UCR2 first as it includes RXEN */
 	imx_uart_writel(sport, ucr2, UCR2);
 	imx_uart_writel(sport, ucr1, UCR1);
+	imx_uart_disable_loopback_rs485(sport);
 }
 
 /* called with port.lock taken and irqs off */
@@ -1404,7 +1415,7 @@ static int imx_uart_startup(struct uart_
 	int retval, i;
 	unsigned long flags;
 	int dma_is_inited = 0;
-	u32 ucr1, ucr2, ucr3, ucr4, uts;
+	u32 ucr1, ucr2, ucr3, ucr4;
 
 	retval = clk_prepare_enable(sport->clk_per);
 	if (retval)
@@ -1509,10 +1520,7 @@ static int imx_uart_startup(struct uart_
 		imx_uart_writel(sport, ucr2, UCR2);
 	}
 
-	/* See SER_RS485_ENABLED/UTS_LOOP comment in imx_uart_probe() */
-	uts = imx_uart_readl(sport, imx_uart_uts_reg(sport));
-	uts &= ~UTS_LOOP;
-	imx_uart_writel(sport, uts, imx_uart_uts_reg(sport));
+	imx_uart_disable_loopback_rs485(sport);
 
 	spin_unlock_irqrestore(&sport->port.lock, flags);
 


