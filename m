Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03F5D755661
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232830AbjGPUuB (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:50:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232850AbjGPUtz (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:49:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4CCFE5D
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:49:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4B69E60E9E
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:49:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D4D2C433C7;
        Sun, 16 Jul 2023 20:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689540593;
        bh=Vfbj6mqGQcx16PxbsYVKOs27NtH+3mcO06Yer8Puhlg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D7YZNUOn1savx/u16VCXAVocMynXPRfopo5ZPpNUv1ApjpiOiLOGSzxcpiEwPxTrV
         JqKhkCbeUpvCZfDwOaqN1nspdl2vgWHvy52ZsmMNy8oJjffF1+Ors3nwOkAhITbmC9
         ktsdSJcrGZWQ34e/aI7IrsLduDd5EFKsJJzWhyeE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, John Ogness <john.ogness@linutronix.de>,
        Tony Lindgren <tony@atomide.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 419/591] serial: 8250: lock port for UART_IER access in omap8250_irq()
Date:   Sun, 16 Jul 2023 21:49:18 +0200
Message-ID: <20230716194934.755989603@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194923.861634455@linuxfoundation.org>
References: <20230716194923.861634455@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: John Ogness <john.ogness@linutronix.de>

[ Upstream commit 25614735a647693c1260f253dc3ab32127697806 ]

omap8250_irq() accesses UART_IER. This register is modified twice
by each console write (serial8250_console_write()) under the port
lock. omap8250_irq() must also take the port lock to guanentee
synchronized access to UART_IER.

Since the port lock is already being taken for the stop_rx() callback
and since it is safe to call cancel_delayed_work() while holding the
port lock, simply extend the port lock region to include UART_IER
access.

Fixes: 1fe0e1fa3209 ("serial: 8250_omap: Handle optional overrun-throttle-ms property")
Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Tony Lindgren <tony@atomide.com>
Link: https://lore.kernel.org/r/20230525093159.223817-8-john.ogness@linutronix.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/8250/8250_omap.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index 7ecd2d379292b..17a230281ebe0 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -639,17 +639,18 @@ static irqreturn_t omap8250_irq(int irq, void *dev_id)
 	if ((lsr & UART_LSR_OE) && up->overrun_backoff_time_ms > 0) {
 		unsigned long delay;
 
+		/* Synchronize UART_IER access against the console. */
+		spin_lock(&port->lock);
 		up->ier = port->serial_in(port, UART_IER);
 		if (up->ier & (UART_IER_RLSI | UART_IER_RDI)) {
-			spin_lock(&port->lock);
 			port->ops->stop_rx(port);
-			spin_unlock(&port->lock);
 		} else {
 			/* Keep restarting the timer until
 			 * the input overrun subsides.
 			 */
 			cancel_delayed_work(&up->overrun_backoff);
 		}
+		spin_unlock(&port->lock);
 
 		delay = msecs_to_jiffies(up->overrun_backoff_time_ms);
 		schedule_delayed_work(&up->overrun_backoff, delay);
-- 
2.39.2



