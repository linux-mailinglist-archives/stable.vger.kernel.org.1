Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D9127B88EE
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244003AbjJDSVG (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:21:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244017AbjJDSVG (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:21:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 450E19E
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:21:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85288C433C8;
        Wed,  4 Oct 2023 18:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696443661;
        bh=DGfsvxRTN74dnqX81BjiS8TBez3Hf/5l3SpAW8gDtGA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zT3h/H/I6AC31ZLsDBDA0LNRtKshI/+fMeHEketrFI+ZjlnT1FV4Ci9EvAiorQkkA
         BK0HFtjGsSX13CjT0N0v6IN9hOVejzXJjvBJcL7lAHP8rctQVyb/7hYTCr6XiO/BnE
         +eKLEyKP/ho+PPifbjcQCIZcyH1uuXkI+9AWniqI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, stable <stable@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>
Subject: [PATCH 6.1 218/259] serial: 8250_port: Check IRQ data before use
Date:   Wed,  4 Oct 2023 19:56:31 +0200
Message-ID: <20231004175227.329124087@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175217.404851126@linuxfoundation.org>
References: <20231004175217.404851126@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

commit cce7fc8b29961b64fadb1ce398dc5ff32a79643b upstream.

In case the leaf driver wants to use IRQ polling (irq = 0) and
IIR register shows that an interrupt happened in the 8250 hardware
the IRQ data can be NULL. In such a case we need to skip the wake
event as we came to this path from the timer interrupt and quite
likely system is already awake.

Without this fix we have got an Oops:

    serial8250: ttyS0 at I/O 0x3f8 (irq = 0, base_baud = 115200) is a 16550A
    ...
    BUG: kernel NULL pointer dereference, address: 0000000000000010
    RIP: 0010:serial8250_handle_irq+0x7c/0x240
    Call Trace:
     ? serial8250_handle_irq+0x7c/0x240
     ? __pfx_serial8250_timeout+0x10/0x10

Fixes: 0ba9e3a13c6a ("serial: 8250: Add missing wakeup event reporting")
Cc: stable <stable@kernel.org>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Link: https://lore.kernel.org/r/20230831222555.614426-1-andriy.shevchenko@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/8250/8250_port.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -1953,7 +1953,10 @@ int serial8250_handle_irq(struct uart_po
 		skip_rx = true;
 
 	if (status & (UART_LSR_DR | UART_LSR_BI) && !skip_rx) {
-		if (irqd_is_wakeup_set(irq_get_irq_data(port->irq)))
+		struct irq_data *d;
+
+		d = irq_get_irq_data(port->irq);
+		if (d && irqd_is_wakeup_set(d))
 			pm_wakeup_event(tport->tty->dev, 0);
 		if (!up->dma || handle_rx_dma(up, iir))
 			status = serial8250_rx_chars(up, status);


