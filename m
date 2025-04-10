Return-Path: <stable+bounces-132128-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A843A84795
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 17:18:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC02C19E6CD1
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 15:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CB7E1E0E0B;
	Thu, 10 Apr 2025 15:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y7MWb65q"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF341E9B2F;
	Thu, 10 Apr 2025 15:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744298264; cv=none; b=tSIO8SreJ8bpzFR5VDKXiMUTB9anFbj3ZK6hTBKijpiH0HSUA0f0m/wywToRGgUePwzugrR3F72pMlP0mwSxl2RkITyiDtXQCJUWpXx2XWHe/SU11hiwITNfAWoIqA8x1jB2b3/soU12ghaLdNDr+BtIWjXzz6+IArhD59+WcrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744298264; c=relaxed/simple;
	bh=Jkt5Se38Pf/t3Pe9IkB7jcqZB9143Imd57ts1oxbTJY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K0ukA5iDcqlwtaGQZU42SO9mso4OftgQ8JjjutErueevQEZc+Dw7v+4Ha9+0TkKGTWXdthjsGmzX74eq2UjCCeNG2JRHetqGHbO6IelGgXrKeSLq7YhFyGdUBQhE1Ci82vWq9usXCa9W/g32Ub21L0vi/Izqk3tsTatdLQRkNRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y7MWb65q; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744298263; x=1775834263;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Jkt5Se38Pf/t3Pe9IkB7jcqZB9143Imd57ts1oxbTJY=;
  b=Y7MWb65qGIC3L5yCF2XZKAecgBvUIAccXe/inFuBk9ZK+eXobeWrH9w1
   0zEKWaFGymJMT1t6KNza4kQ7Y40ehg2tXmHY6wuuGnKrAO7diHRG5MA/E
   W/shaRnezN4+jaQg9HWfUsgy8xLguhWZTDkGm7CFfmCIx7VNxVKYvldhT
   6ftE2kc7fMzLN8Qd/i2b1W8hpx3HSWe8DPEzBbE020AG92bWXfzv/9+dx
   cldrccZBUbB/pzuQ0f88GCcyYCEe+dReEWqCRKblIakDURNjMDMoHgvPC
   K24KAPy/mPsau+5n4acGu5fNSSZc4bmHOAXFOMsAZ48xUop8YPbKigSIm
   w==;
X-CSE-ConnectionGUID: UZrGcBX+S0iqdpo3xrhE6g==
X-CSE-MsgGUID: 9usRH7ctSrONTTGiVlHmjQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11400"; a="48534991"
X-IronPort-AV: E=Sophos;i="6.15,202,1739865600"; 
   d="scan'208";a="48534991"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 08:17:42 -0700
X-CSE-ConnectionGUID: j9Xu/5bnTHGGuYA58KhSRw==
X-CSE-MsgGUID: i72DV4cdSrCsqtccQR/5dA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,202,1739865600"; 
   d="scan'208";a="128913263"
Received: from unknown (HELO mattu-haswell.fi.intel.com) ([10.237.72.199])
  by fmviesa007.fm.intel.com with ESMTP; 10 Apr 2025 08:17:41 -0700
From: Mathias Nyman <mathias.nyman@linux.intel.com>
To: <gregkh@linuxfoundation.org>
Cc: <linux-usb@vger.kernel.org>,
	Mathias Nyman <mathias.nyman@linux.intel.com>,
	Devyn Liu <liudingyuan@huawei.com>,
	stable@vger.kernel.org
Subject: [PATCH 5/5] xhci: Limit time spent with xHC interrupts disabled during bus resume
Date: Thu, 10 Apr 2025 18:18:27 +0300
Message-ID: <20250410151828.2868740-6-mathias.nyman@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250410151828.2868740-1-mathias.nyman@linux.intel.com>
References: <20250410151828.2868740-1-mathias.nyman@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
---
 drivers/usb/host/xhci-hub.c | 30 ++++++++++++++++--------------
 drivers/usb/host/xhci.c     |  4 ++--
 drivers/usb/host/xhci.h     |  2 ++
 3 files changed, 20 insertions(+), 16 deletions(-)

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
-- 
2.43.0


