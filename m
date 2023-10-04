Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20D957B87C1
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243865AbjJDSI5 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243869AbjJDSI4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:08:56 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 997AE9E
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:08:53 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E08BEC433C8;
        Wed,  4 Oct 2023 18:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696442933;
        bh=JxGGROTa7RUNnjENM6zM9ruagc7cbO362YyZhKdr/Vk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RPX9+ia1QleQmKc6iDjj3iepPieHeYicKweUK7h9R4N86/gesexjYAKJ22pT5RIyA
         bRC/BfzqTfJpZQa+22xceZ913D7CHJdVf8lvK1U8j2tP+1w9qbdNSiBOazsSMmCYx/
         UJxAmBeActmTgcOyzy0ZqpUTomi87pFTbYpueS48=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, stable <stable@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>
Subject: [PATCH 5.15 161/183] serial: 8250_port: Check IRQ data before use
Date:   Wed,  4 Oct 2023 19:56:32 +0200
Message-ID: <20231004175210.769788265@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175203.943277832@linuxfoundation.org>
References: <20231004175203.943277832@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1930,7 +1930,10 @@ int serial8250_handle_irq(struct uart_po
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


