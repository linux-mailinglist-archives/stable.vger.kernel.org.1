Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEF0C7CA38B
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 11:07:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbjJPJHy (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 05:07:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232734AbjJPIqS (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 04:46:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F326F9
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 01:46:13 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80B03C433C9;
        Mon, 16 Oct 2023 08:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697445973;
        bh=2FV6gitFNP99iKQNjWHOGvGJOHNX5d/GeR/ZaN80H5s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Clg2qXRW1HXoiRkQBzpjJl2FQEHyhzNmX+P8IqvjUmzURONCQXHYvc9pPoShEKAcl
         DbGi286eSIPKPcEkPp7F9GnFQoO94y3JjEczV/9P+W4Vb2wfE8+nTKP7tWvvJ4i0JT
         YFCgTA0Z9RYb9iOukt4jaV9FwPLcLzHZ3yHD5K+E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, stable@kernel.org,
        Hongyu Xie <xiehongyu1@kylinos.cn>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Prashanth K <quic_prashk@quicinc.com>
Subject: [PATCH 5.15 048/102] xhci: Keep interrupt disabled in initialization until host is running.
Date:   Mon, 16 Oct 2023 10:40:47 +0200
Message-ID: <20231016083954.978292229@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231016083953.689300946@linuxfoundation.org>
References: <20231016083953.689300946@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hongyu Xie <xy521521@gmail.com>

commit a808925075fb750804a60ff0710614466c396db4 upstream.

irq is disabled in xhci_quiesce(called by xhci_halt, with bit:2 cleared
in USBCMD register), but xhci_run(called by usb_add_hcd) re-enable it.
It's possible that you will receive thousands of interrupt requests
after initialization for 2.0 roothub. And you will get a lot of
warning like, "xHCI dying, ignoring interrupt. Shouldn't IRQs be
disabled?". This amount of interrupt requests will cause the entire
system to freeze.
This problem was first found on a device with ASM2142 host controller
on it.

[tidy up old code while moving it, reword header -Mathias]

Cc: stable@kernel.org
Signed-off-by: Hongyu Xie <xiehongyu1@kylinos.cn>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Link: https://lore.kernel.org/r/20220623111945.1557702-2-mathias.nyman@linux.intel.com
Signed-off-by: Prashanth K <quic_prashk@quicinc.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/host/xhci.c |   35 ++++++++++++++++++++++-------------
 1 file changed, 22 insertions(+), 13 deletions(-)

--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -611,8 +611,27 @@ static int xhci_init(struct usb_hcd *hcd
 
 static int xhci_run_finished(struct xhci_hcd *xhci)
 {
+	unsigned long	flags;
+	u32		temp;
+
+	/*
+	 * Enable interrupts before starting the host (xhci 4.2 and 5.5.2).
+	 * Protect the short window before host is running with a lock
+	 */
+	spin_lock_irqsave(&xhci->lock, flags);
+
+	xhci_dbg_trace(xhci, trace_xhci_dbg_init, "Enable interrupts");
+	temp = readl(&xhci->op_regs->command);
+	temp |= (CMD_EIE);
+	writel(temp, &xhci->op_regs->command);
+
+	xhci_dbg_trace(xhci, trace_xhci_dbg_init, "Enable primary interrupter");
+	temp = readl(&xhci->ir_set->irq_pending);
+	writel(ER_IRQ_ENABLE(temp), &xhci->ir_set->irq_pending);
+
 	if (xhci_start(xhci)) {
 		xhci_halt(xhci);
+		spin_unlock_irqrestore(&xhci->lock, flags);
 		return -ENODEV;
 	}
 	xhci->shared_hcd->state = HC_STATE_RUNNING;
@@ -623,6 +642,9 @@ static int xhci_run_finished(struct xhci
 
 	xhci_dbg_trace(xhci, trace_xhci_dbg_init,
 			"Finished xhci_run for USB3 roothub");
+
+	spin_unlock_irqrestore(&xhci->lock, flags);
+
 	return 0;
 }
 
@@ -671,19 +693,6 @@ int xhci_run(struct usb_hcd *hcd)
 	temp |= (xhci->imod_interval / 250) & ER_IRQ_INTERVAL_MASK;
 	writel(temp, &xhci->ir_set->irq_control);
 
-	/* Set the HCD state before we enable the irqs */
-	temp = readl(&xhci->op_regs->command);
-	temp |= (CMD_EIE);
-	xhci_dbg_trace(xhci, trace_xhci_dbg_init,
-			"// Enable interrupts, cmd = 0x%x.", temp);
-	writel(temp, &xhci->op_regs->command);
-
-	temp = readl(&xhci->ir_set->irq_pending);
-	xhci_dbg_trace(xhci, trace_xhci_dbg_init,
-			"// Enabling event ring interrupter %p by writing 0x%x to irq_pending",
-			xhci->ir_set, (unsigned int) ER_IRQ_ENABLE(temp));
-	writel(ER_IRQ_ENABLE(temp), &xhci->ir_set->irq_pending);
-
 	if (xhci->quirks & XHCI_NEC_HOST) {
 		struct xhci_command *command;
 


