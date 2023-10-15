Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31CE37C9AA7
	for <lists+stable@lfdr.de>; Sun, 15 Oct 2023 20:15:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbjJOSPv (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 15 Oct 2023 14:15:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjJOSPv (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 15 Oct 2023 14:15:51 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6811AB
        for <stable@vger.kernel.org>; Sun, 15 Oct 2023 11:15:49 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2221FC433C8;
        Sun, 15 Oct 2023 18:15:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697393749;
        bh=DZrpVnJg2c0M3rZRkkvCZpQdJ352CJVfnJfhOkhoGzI=;
        h=Subject:To:Cc:From:Date:From;
        b=2n4phn7uZsLXZOcu0Keuy7pRU3A+I5WOpXiEmnIwImCNB8z0foDqy+d2PG2KZBFSd
         OkrbLZ2oaNy8ZmWUxdvjtybvHECKessRoEP9x90ZMRZ0xpRS73mHs00qgawXCmdgfZ
         KJRt1wHT3wiMLEafTh2Vi+g8qGOxDQDDD+u+TbZU=
Subject: FAILED: patch "[PATCH] serial: Reduce spinlocked portion of uart_rs485_config()" failed to apply to 5.10-stable tree
To:     lukas@wunner.de, LinoSanfilippo@gmx.de, gregkh@linuxfoundation.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sun, 15 Oct 2023 20:15:36 +0200
Message-ID: <2023101536-grunt-january-a885@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
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


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 8679328eb859d06a1984ab48d90ac35d11bbcaf1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023101536-grunt-january-a885@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8679328eb859d06a1984ab48d90ac35d11bbcaf1 Mon Sep 17 00:00:00 2001
From: Lukas Wunner <lukas@wunner.de>
Date: Thu, 21 Sep 2023 16:52:33 +0200
Subject: [PATCH] serial: Reduce spinlocked portion of uart_rs485_config()

Commit 44b27aec9d96 ("serial: core, 8250: set RS485 termination GPIO in
serial core") enabled support for RS485 termination GPIOs behind i2c
expanders by setting the GPIO outside of the critical section protected
by the port spinlock.  Access to the i2c expander may sleep, which
caused a splat with the port spinlock held.

Commit 7c7f9bc986e6 ("serial: Deassert Transmit Enable on probe in
driver-specific way") erroneously regressed that by spinlocking the
GPIO manipulation again.

Fix by moving uart_rs485_config() (the function manipulating the GPIO)
outside of the spinlocked section and acquiring the spinlock inside of
uart_rs485_config() for the invocation of ->rs485_config() only.

This gets us one step closer to pushing the spinlock down into the
->rs485_config() callbacks which actually need it.  (Some callbacks
do not want to be spinlocked because they perform sleepable register
accesses, see e.g. sc16is7xx_config_rs485().)

Stack trace for posterity:

 Voluntary context switch within RCU read-side critical section!
 WARNING: CPU: 0 PID: 56 at kernel/rcu/tree_plugin.h:318 rcu_note_context_switch
 Call trace:
 rcu_note_context_switch
 __schedule
 schedule
 schedule_timeout
 wait_for_completion_timeout
 bcm2835_i2c_xfer
 __i2c_transfer
 i2c_transfer
 i2c_transfer_buffer_flags
 regmap_i2c_write
 _regmap_raw_write_impl
 _regmap_bus_raw_write
 _regmap_write
 _regmap_update_bits
 regmap_update_bits_base
 pca953x_gpio_set_value
 gpiod_set_raw_value_commit
 gpiod_set_value_nocheck
 gpiod_set_value_cansleep
 uart_rs485_config
 uart_add_one_port
 pl011_register_port
 pl011_probe

Fixes: 7c7f9bc986e6 ("serial: Deassert Transmit Enable on probe in driver-specific way")
Suggested-by: Lino Sanfilippo <LinoSanfilippo@gmx.de>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: stable@vger.kernel.org # v6.1+
Link: https://lore.kernel.org/r/f3a35967c28b32f3c6432d0aa5936e6a9908282d.1695307688.git.lukas@wunner.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 7bdc21d5e13b..ca26a8aef2cb 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -1404,12 +1404,18 @@ static void uart_set_rs485_termination(struct uart_port *port,
 static int uart_rs485_config(struct uart_port *port)
 {
 	struct serial_rs485 *rs485 = &port->rs485;
+	unsigned long flags;
 	int ret;
 
+	if (!(rs485->flags & SER_RS485_ENABLED))
+		return 0;
+
 	uart_sanitize_serial_rs485(port, rs485);
 	uart_set_rs485_termination(port, rs485);
 
+	spin_lock_irqsave(&port->lock, flags);
 	ret = port->rs485_config(port, NULL, rs485);
+	spin_unlock_irqrestore(&port->lock, flags);
 	if (ret)
 		memset(rs485, 0, sizeof(*rs485));
 
@@ -2474,11 +2480,10 @@ int uart_resume_port(struct uart_driver *drv, struct uart_port *uport)
 			if (ret == 0) {
 				if (tty)
 					uart_change_line_settings(tty, state, NULL);
+				uart_rs485_config(uport);
 				spin_lock_irq(&uport->lock);
 				if (!(uport->rs485.flags & SER_RS485_ENABLED))
 					ops->set_mctrl(uport, uport->mctrl);
-				else
-					uart_rs485_config(uport);
 				ops->start_tx(uport);
 				spin_unlock_irq(&uport->lock);
 				tty_port_set_initialized(port, true);
@@ -2587,10 +2592,10 @@ uart_configure_port(struct uart_driver *drv, struct uart_state *state,
 		port->mctrl &= TIOCM_DTR;
 		if (!(port->rs485.flags & SER_RS485_ENABLED))
 			port->ops->set_mctrl(port, port->mctrl);
-		else
-			uart_rs485_config(port);
 		spin_unlock_irqrestore(&port->lock, flags);
 
+		uart_rs485_config(port);
+
 		/*
 		 * If this driver supports console, and it hasn't been
 		 * successfully registered yet, try to re-register it.

