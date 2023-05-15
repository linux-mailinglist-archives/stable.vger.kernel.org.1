Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3076B703334
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 18:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242759AbjEOQec (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 12:34:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242749AbjEOQeZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 12:34:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8B4B10F3
        for <stable@vger.kernel.org>; Mon, 15 May 2023 09:34:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CA3A9627CB
        for <stable@vger.kernel.org>; Mon, 15 May 2023 16:34:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1B6FC433EF;
        Mon, 15 May 2023 16:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684168457;
        bh=gLbZkO7xSdLFvxVHi8FHbnFZcOSRJv88/qAESEmgFn0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tj5zmzvKPDLjT4zLhPsNuRW9Cs98Q0l30+hYv0huC41Bo3rmNkCzxHnPlBYU7Vpal
         8Fi9nws96OG1DIBys/KA5wuS/b+SrpF2el3LbFGIluuGFZmje8bD8i5zL81is5ZdnZ
         kA29bZLEnJLQStiPjEAQHyq7SfJHz4hCvjiIBrjs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Florian Fainelli <f.fainelli@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 054/116] serial: 8250: Add missing wakeup event reporting
Date:   Mon, 15 May 2023 18:25:51 +0200
Message-Id: <20230515161700.061737554@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161658.228491273@linuxfoundation.org>
References: <20230515161658.228491273@linuxfoundation.org>
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
index fe1de63269d1a..cdc1b2b0f4bc6 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -23,6 +23,7 @@
 #include <linux/moduleparam.h>
 #include <linux/ioport.h>
 #include <linux/init.h>
+#include <linux/irq.h>
 #include <linux/console.h>
 #include <linux/sysrq.h>
 #include <linux/delay.h>
@@ -1886,6 +1887,7 @@ int serial8250_handle_irq(struct uart_port *port, unsigned int iir)
 	unsigned char status;
 	unsigned long flags;
 	struct uart_8250_port *up = up_to_u8250p(port);
+	struct tty_port *tport = &port->state->port;
 	bool skip_rx = false;
 
 	if (iir & UART_IIR_NO_INT)
@@ -1909,6 +1911,8 @@ int serial8250_handle_irq(struct uart_port *port, unsigned int iir)
 		skip_rx = true;
 
 	if (status & (UART_LSR_DR | UART_LSR_BI) && !skip_rx) {
+		if (irqd_is_wakeup_set(irq_get_irq_data(port->irq)))
+			pm_wakeup_event(tport->tty->dev, 0);
 		if (!up->dma || handle_rx_dma(up, iir))
 			status = serial8250_rx_chars(up, status);
 	}
-- 
2.39.2



