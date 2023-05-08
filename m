Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADF176FA8E6
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235113AbjEHKqL (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235082AbjEHKpt (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:45:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFD2C27F13
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:45:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 443F562899
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:45:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C2CEC433A0;
        Mon,  8 May 2023 10:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683542720;
        bh=id41uX/EeD1kMSvewZp9Toeg0eggBYZ96Jd9KGEMYW8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lwLrAfl7Mitz5kTohdqPSFp87nxAtdoOGuHyJYK0ueG+AqgGhRwhZErmqh6Od/7Ml
         krzBNkv+ZbSy9OP/m6WoqXlZmoglQ2Z1joNhnq2aU8MmiK7doWjQv4OjlQgpIn4gi2
         p3gT8xVmeinz7MPM+I9qB5g7NNcmr0oBvAEcmJa4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Florian Fainelli <f.fainelli@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.2 495/663] serial: 8250: Add missing wakeup event reporting
Date:   Mon,  8 May 2023 11:45:21 +0200
Message-Id: <20230508094444.521545251@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094428.384831245@linuxfoundation.org>
References: <20230508094428.384831245@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Florian Fainelli <f.fainelli@gmail.com>

[ Upstream commit 0ba9e3a13c6adfa99e32b2576d20820ab10ad48a ]

An 8250 UART configured as a wake-up source would not have reported
itself through sysfs as being the source of wake-up, correct that.

Fixes: b3b708fa2780 ("wake up from a serial port")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Link: https://lore.kernel.org/r/20230414170241.2016255-1-f.fainelli@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/8250/8250_port.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index b186d6ff12b4a..fa220620511e5 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -15,6 +15,7 @@
 #include <linux/moduleparam.h>
 #include <linux/ioport.h>
 #include <linux/init.h>
+#include <linux/irq.h>
 #include <linux/console.h>
 #include <linux/gpio/consumer.h>
 #include <linux/sysrq.h>
@@ -1925,6 +1926,7 @@ static bool handle_rx_dma(struct uart_8250_port *up, unsigned int iir)
 int serial8250_handle_irq(struct uart_port *port, unsigned int iir)
 {
 	struct uart_8250_port *up = up_to_u8250p(port);
+	struct tty_port *tport = &port->state->port;
 	bool skip_rx = false;
 	unsigned long flags;
 	u16 status;
@@ -1950,6 +1952,8 @@ int serial8250_handle_irq(struct uart_port *port, unsigned int iir)
 		skip_rx = true;
 
 	if (status & (UART_LSR_DR | UART_LSR_BI) && !skip_rx) {
+		if (irqd_is_wakeup_set(irq_get_irq_data(port->irq)))
+			pm_wakeup_event(tport->tty->dev, 0);
 		if (!up->dma || handle_rx_dma(up, iir))
 			status = serial8250_rx_chars(up, status);
 	}
-- 
2.39.2



