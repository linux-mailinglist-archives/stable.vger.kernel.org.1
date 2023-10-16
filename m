Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8F467CAC57
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 16:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233685AbjJPOxQ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 10:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233095AbjJPOxP (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 10:53:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 393EEE3
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 07:53:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A81CC433C8;
        Mon, 16 Oct 2023 14:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697467993;
        bh=fAo8h631qxTWGgqHEUXo+SxewrQbn8zH5Rr2qsHb51E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IW/69oF/VEg409zP2qA43PW62uZK0CgyeSdRlGa/fR9eLdEG/U+YjyMZYzwuxvipU
         TkQDPN/aEjceqLwr0ZVG6u/HdJeLX9Zke/MJjsm3IuL8XZYmScSRcjN3ZZuDvUupFX
         bUz1ja+zD+Q0IwhDFofY3WRc5BWO7JFZzHJVnq6k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Lino Sanfilippo <LinoSanfilippo@gmx.de>,
        Lukas Wunner <lukas@wunner.de>
Subject: [PATCH 6.5 131/191] serial: Reduce spinlocked portion of uart_rs485_config()
Date:   Mon, 16 Oct 2023 10:41:56 +0200
Message-ID: <20231016084018.449563641@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231016084015.400031271@linuxfoundation.org>
References: <20231016084015.400031271@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lukas Wunner <lukas@wunner.de>

commit 8679328eb859d06a1984ab48d90ac35d11bbcaf1 upstream.

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
---
 drivers/tty/serial/serial_core.c |   13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -1410,12 +1410,18 @@ static void uart_set_rs485_termination(s
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
 
@@ -2480,11 +2486,10 @@ int uart_resume_port(struct uart_driver
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
@@ -2593,10 +2598,10 @@ uart_configure_port(struct uart_driver *
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


