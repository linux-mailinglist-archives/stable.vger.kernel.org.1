Return-Path: <stable+bounces-136928-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A77D1A9F718
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 19:16:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F03FC189A51F
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 17:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4720717B418;
	Mon, 28 Apr 2025 17:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cOv9G9jD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076E916DC28
	for <stable@vger.kernel.org>; Mon, 28 Apr 2025 17:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745860564; cv=none; b=BkYljBpiaQHDtZx3nvSgq5tGY8xr/15AE9xrbPHkPfhyFqqgva4KDcU8Q04RSAi0ytpt5SdPludzS0db9HWGiAgzXebCM7adVtvsbj+DW/RIS8LmwbM/V9ssejXcmGAC8rG0A9RZLn+JFJfvhdRfkP6lF1gKxIUAA2s1o/sUJG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745860564; c=relaxed/simple;
	bh=anDCSbXDFOLY6lSpx7JrsmVLwCCFvYq+jR+JbQu1Eyk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=V4p8TCbgVi9UGiuN4ddZW3D48JEKKJ8perTrjz/fYdp7invTEuvaYT4PLJAEoPFpFmJoZkLy1y6a4l2FGluezpDZv+X44h25+FxeUrsNggfZD292fAK9y5rLWsKRBtNkM5MrOXfRHOeINuygidebEQZbaJ2bpToQK3+c0lg+5ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cOv9G9jD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57711C4CEE4;
	Mon, 28 Apr 2025 17:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745860563;
	bh=anDCSbXDFOLY6lSpx7JrsmVLwCCFvYq+jR+JbQu1Eyk=;
	h=Subject:To:Cc:From:Date:From;
	b=cOv9G9jDnk0lzGh5+wr+TDJL7FqPY0VwO4rY6IZ7uEO3+8o6HPr44oJ31wtlYWpWM
	 QwrBM/iNjjv8zfCBenkBXaiLbs27V4IgaFKgiBEtytnJqTezOSzNWzflYGO+C5+cD7
	 Xxhsuu5DiOfipUdnrnVEdM0fHRMPEGs9BUaz2SPY=
Subject: FAILED: patch "[PATCH] xhci: Limit time spent with xHC interrupts disabled during" failed to apply to 6.1-stable tree
To: mathias.nyman@linux.intel.com,gregkh@linuxfoundation.org,liudingyuan@huawei.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 28 Apr 2025 19:15:52 +0200
Message-ID: <2025042852-proximity-drudge-3cec@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x bea5892d0ed274e03655223d1977cf59f9aff2f2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025042852-proximity-drudge-3cec@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From bea5892d0ed274e03655223d1977cf59f9aff2f2 Mon Sep 17 00:00:00 2001
From: Mathias Nyman <mathias.nyman@linux.intel.com>
Date: Thu, 10 Apr 2025 18:18:27 +0300
Subject: [PATCH] xhci: Limit time spent with xHC interrupts disabled during
 bus resume

Current xhci bus resume implementation prevents xHC host from generating
interrupts during high-speed USB 2 and super-speed USB 3 bus resume.

Only reason to disable interrupts during bus resume would be to prevent
the interrupt handler from interfering with the resume process of USB 2
ports.

Host initiated resume of USB 2 ports is done in two stages.

The xhci driver first transitions the port from 'U3' to 'Resume' state,
then wait in Resume for 20ms, and finally moves port to U0 state.
xhci driver can't prevent interrupts by keeping the xhci spinlock
due to this 20ms sleep.

Limit interrupt disabling to the USB 2 port resume case only.
resuming USB 2 ports in bus resume is only done in special cases where
USB 2 ports had to be forced to suspend during bus suspend.

The current way of preventing interrupts by clearing the 'Interrupt
Enable' (INTE) bit in USBCMD register won't prevent the Interrupter
registers 'Interrupt Pending' (IP), 'Event Handler Busy' (EHB) and
USBSTS register Event Interrupt (EINT) bits from being set.

New interrupts can't be issued before those bits are properly clered.

Disable interrupts by clearing the interrupter register 'Interrupt
Enable' (IE) bit instead. This way IP, EHB and INTE won't be set
before IE is enabled again and a new interrupt is triggered.

Reported-by: Devyn Liu <liudingyuan@huawei.com>
Closes: https://lore.kernel.org/linux-usb/b1a9e2d51b4d4ff7a304f77c5be8164e@huawei.com/
Cc: stable@vger.kernel.org
Tested-by: Devyn Liu <liudingyuan@huawei.com>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Link: https://lore.kernel.org/r/20250410151828.2868740-6-mathias.nyman@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/usb/host/xhci-hub.c b/drivers/usb/host/xhci-hub.c
index c0f226584a40..486347776cb2 100644
--- a/drivers/usb/host/xhci-hub.c
+++ b/drivers/usb/host/xhci-hub.c
@@ -1878,9 +1878,10 @@ int xhci_bus_resume(struct usb_hcd *hcd)
 	int max_ports, port_index;
 	int sret;
 	u32 next_state;
-	u32 temp, portsc;
+	u32 portsc;
 	struct xhci_hub *rhub;
 	struct xhci_port **ports;
+	bool disabled_irq = false;
 
 	rhub = xhci_get_rhub(hcd);
 	ports = rhub->ports;
@@ -1896,17 +1897,20 @@ int xhci_bus_resume(struct usb_hcd *hcd)
 		return -ESHUTDOWN;
 	}
 
-	/* delay the irqs */
-	temp = readl(&xhci->op_regs->command);
-	temp &= ~CMD_EIE;
-	writel(temp, &xhci->op_regs->command);
-
 	/* bus specific resume for ports we suspended at bus_suspend */
-	if (hcd->speed >= HCD_USB3)
+	if (hcd->speed >= HCD_USB3) {
 		next_state = XDEV_U0;
-	else
+	} else {
 		next_state = XDEV_RESUME;
-
+		if (bus_state->bus_suspended) {
+			/*
+			 * prevent port event interrupts from interfering
+			 * with usb2 port resume process
+			 */
+			xhci_disable_interrupter(xhci->interrupters[0]);
+			disabled_irq = true;
+		}
+	}
 	port_index = max_ports;
 	while (port_index--) {
 		portsc = readl(ports[port_index]->addr);
@@ -1974,11 +1978,9 @@ int xhci_bus_resume(struct usb_hcd *hcd)
 	(void) readl(&xhci->op_regs->command);
 
 	bus_state->next_statechange = jiffies + msecs_to_jiffies(5);
-	/* re-enable irqs */
-	temp = readl(&xhci->op_regs->command);
-	temp |= CMD_EIE;
-	writel(temp, &xhci->op_regs->command);
-	temp = readl(&xhci->op_regs->command);
+	/* re-enable interrupter */
+	if (disabled_irq)
+		xhci_enable_interrupter(xhci->interrupters[0]);
 
 	spin_unlock_irqrestore(&xhci->lock, flags);
 	return 0;
diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index ca390beda85b..90eb491267b5 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -322,7 +322,7 @@ static void xhci_zero_64b_regs(struct xhci_hcd *xhci)
 		xhci_info(xhci, "Fault detected\n");
 }
 
-static int xhci_enable_interrupter(struct xhci_interrupter *ir)
+int xhci_enable_interrupter(struct xhci_interrupter *ir)
 {
 	u32 iman;
 
@@ -335,7 +335,7 @@ static int xhci_enable_interrupter(struct xhci_interrupter *ir)
 	return 0;
 }
 
-static int xhci_disable_interrupter(struct xhci_interrupter *ir)
+int xhci_disable_interrupter(struct xhci_interrupter *ir)
 {
 	u32 iman;
 
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index 28b6264f8b87..242ab9fbc8ae 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1890,6 +1890,8 @@ int xhci_alloc_tt_info(struct xhci_hcd *xhci,
 		struct usb_tt *tt, gfp_t mem_flags);
 int xhci_set_interrupter_moderation(struct xhci_interrupter *ir,
 				    u32 imod_interval);
+int xhci_enable_interrupter(struct xhci_interrupter *ir);
+int xhci_disable_interrupter(struct xhci_interrupter *ir);
 
 /* xHCI ring, segment, TRB, and TD functions */
 dma_addr_t xhci_trb_virt_to_dma(struct xhci_segment *seg, union xhci_trb *trb);


