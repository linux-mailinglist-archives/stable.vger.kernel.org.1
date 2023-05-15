Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A023703B6E
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 20:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244258AbjEOSDA (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 14:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244269AbjEOSCh (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 14:02:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4949C18986
        for <stable@vger.kernel.org>; Mon, 15 May 2023 11:00:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DA43363031
        for <stable@vger.kernel.org>; Mon, 15 May 2023 18:00:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFDC8C433D2;
        Mon, 15 May 2023 18:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684173611;
        bh=uBS6u9KRZpoOguLoo0iV2IdKIR/lIL1HR6q1T0AvFaE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vfVw2B9fCmAF7PBJiblDNVmF91R4QOUf6HgqiHfSSll19igJYPJ6s5aUbtbMC+5xw
         hXYX89f+58r5J17eAU6URkQ1w+Bn7Yr1imnF4Hgam6DA1PEgEyTBHCK0l6Ha1S/JZy
         hZ4tWUx1Fr5Tl9a+TxiA+lv/esAZz6AZIgnAvoqI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Florian Fainelli <f.fainelli@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 151/282] serial: 8250: Add missing wakeup event reporting
Date:   Mon, 15 May 2023 18:28:49 +0200
Message-Id: <20230515161726.751095012@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161722.146344674@linuxfoundation.org>
References: <20230515161722.146344674@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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
index 907130244e1f5..3d369481d4db1 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -19,6 +19,7 @@
 #include <linux/moduleparam.h>
 #include <linux/ioport.h>
 #include <linux/init.h>
+#include <linux/irq.h>
 #include <linux/console.h>
 #include <linux/sysrq.h>
 #include <linux/delay.h>
@@ -1840,6 +1841,7 @@ int serial8250_handle_irq(struct uart_port *port, unsigned int iir)
 	unsigned char status;
 	unsigned long flags;
 	struct uart_8250_port *up = up_to_u8250p(port);
+	struct tty_port *tport = &port->state->port;
 	bool skip_rx = false;
 
 	if (iir & UART_IIR_NO_INT)
@@ -1863,6 +1865,8 @@ int serial8250_handle_irq(struct uart_port *port, unsigned int iir)
 		skip_rx = true;
 
 	if (status & (UART_LSR_DR | UART_LSR_BI) && !skip_rx) {
+		if (irqd_is_wakeup_set(irq_get_irq_data(port->irq)))
+			pm_wakeup_event(tport->tty->dev, 0);
 		if (!up->dma || handle_rx_dma(up, iir))
 			status = serial8250_rx_chars(up, status);
 	}
-- 
2.39.2



