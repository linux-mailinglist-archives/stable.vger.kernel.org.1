Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E10D7614AE
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:21:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234434AbjGYLVz (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234443AbjGYLVx (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:21:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7655B19AD
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:21:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 311506167D
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:21:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BE16C433C7;
        Tue, 25 Jul 2023 11:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690284104;
        bh=HaBgYXY2kiHj3nSgJee2RC8MPmA+pZaBWOzGw6WgdN4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sa2qcIqsyMVcCu609KLeTFuGR8FzPyv54qZ12c267RVot+NJ4sh6LEO+VksHH5sWf
         Q4OdNwx1oZBf9Qx0jt/TES5CkTUGHkZy5U1KYvoV8KcH0QHY7QRLgwLHfpL6aGUjJO
         1iFmA8IoCFum3bxwfgKIf9oa5MzQ+57LhSVD8688=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, John Ogness <john.ogness@linutronix.de>,
        Tony Lindgren <tony@atomide.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 236/509] serial: 8250: lock port for UART_IER access in omap8250_irq()
Date:   Tue, 25 Jul 2023 12:42:55 +0200
Message-ID: <20230725104604.566609564@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104553.588743331@linuxfoundation.org>
References: <20230725104553.588743331@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
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
index 6043d4fa08cc2..af39a2c4c2eee 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -653,17 +653,18 @@ static irqreturn_t omap8250_irq(int irq, void *dev_id)
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



