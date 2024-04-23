Return-Path: <stable+bounces-40659-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 575418AE6CA
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 14:48:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C8D5282396
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 12:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86A2812C474;
	Tue, 23 Apr 2024 12:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0liEbypA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439B485C48
	for <stable@vger.kernel.org>; Tue, 23 Apr 2024 12:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713876272; cv=none; b=nj8KTBCny8tN2So5HpqIh/4REkoZHUSHLck0iWZfFvCqj4QIpjX/X64LhVkwMjLeWlOBNZlaLCA/rt43zNF9BejLXw/8wlorLZE306pKFofl4RbWV/pwkLCmiX/FwMStsZRgaMUOhDZCgMjsBGPI5N1+2teL2I8tJCLfC206uwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713876272; c=relaxed/simple;
	bh=rDYVPXYJn2Qx7YaN0XQS6DOHw39w8xvFtUfrvPbaklM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=c1U6puZXqa7te+TlZ1RESnTTZ4WrN3KRtYjrrn1mx+DIvUesmGziqosEulaEw8vQ/oxY7DZvmvJwcmJT9OX/UvpsbXqeCDm24PRa3dTc+oZGQlh8e90Gc5Fk0h8ZesNKYR/BbJHJlBG5iymhHekFvPgbhnebl6m1qt23hcC1uhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0liEbypA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD5C7C116B1;
	Tue, 23 Apr 2024 12:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713876271;
	bh=rDYVPXYJn2Qx7YaN0XQS6DOHw39w8xvFtUfrvPbaklM=;
	h=Subject:To:Cc:From:Date:From;
	b=0liEbypABzu+I7F0iYUSABDEAmcoA8qMNWWiCenev7D+cftoiMbqCDiAPnZDlBu58
	 wUodNJHQ44awkVlpY879e/e1nJEbNMl/MMcXXg31Jz5eZqNRMZBwIn0vSh0l4wuwoQ
	 Y8tYFwnqubfG/4T0ajPZcQaw32VZCgRh4s/Grlgo=
Subject: FAILED: patch "[PATCH] usb: xhci: correct return value in case of STS_HCE" failed to apply to 6.8-stable tree
To: oneukum@suse.com,gregkh@linuxfoundation.org,mathias.nyman@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 23 Apr 2024 05:44:22 -0700
Message-ID: <2024042322-lunchbox-flint-5a2b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.8-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.8.y
git checkout FETCH_HEAD
git cherry-pick -x 5bfc311dd6c376d350b39028b9000ad766ddc934
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024042322-lunchbox-flint-5a2b@gregkh' --subject-prefix 'PATCH 6.8.y' HEAD^..

Possible dependencies:

5bfc311dd6c3 ("usb: xhci: correct return value in case of STS_HCE")
84ac5e4fa517 ("xhci: move event processing for one interrupter to a separate function")
e30e9ad9ed66 ("xhci: update event ring dequeue pointer position to controller correctly")
143e64df1bda ("xhci: remove unnecessary event_ring_deq parameter from xhci_handle_event()")
becbd202af84 ("xhci: make isoc_bei_interval variable interrupter specific.")
4f022aad80dc ("xhci: Add interrupt pending autoclear flag to each interrupter")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5bfc311dd6c376d350b39028b9000ad766ddc934 Mon Sep 17 00:00:00 2001
From: Oliver Neukum <oneukum@suse.com>
Date: Thu, 4 Apr 2024 15:11:05 +0300
Subject: [PATCH] usb: xhci: correct return value in case of STS_HCE

If we get STS_HCE we give up on the interrupt, but for the purpose
of IRQ handling that still counts as ours. We may return IRQ_NONE
only if we are positive that it wasn't ours. Hence correct the default.

Fixes: 2a25e66d676d ("xhci: print warning when HCE was set")
Cc: stable@vger.kernel.org # v6.2+
Signed-off-by: Oliver Neukum <oneukum@suse.com>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Link: https://lore.kernel.org/r/20240404121106.2842417-2-mathias.nyman@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 52278afea94b..575f0fd9c9f1 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -3133,7 +3133,7 @@ static int xhci_handle_events(struct xhci_hcd *xhci, struct xhci_interrupter *ir
 irqreturn_t xhci_irq(struct usb_hcd *hcd)
 {
 	struct xhci_hcd *xhci = hcd_to_xhci(hcd);
-	irqreturn_t ret = IRQ_NONE;
+	irqreturn_t ret = IRQ_HANDLED;
 	u32 status;
 
 	spin_lock(&xhci->lock);
@@ -3141,12 +3141,13 @@ irqreturn_t xhci_irq(struct usb_hcd *hcd)
 	status = readl(&xhci->op_regs->status);
 	if (status == ~(u32)0) {
 		xhci_hc_died(xhci);
-		ret = IRQ_HANDLED;
 		goto out;
 	}
 
-	if (!(status & STS_EINT))
+	if (!(status & STS_EINT)) {
+		ret = IRQ_NONE;
 		goto out;
+	}
 
 	if (status & STS_HCE) {
 		xhci_warn(xhci, "WARNING: Host Controller Error\n");
@@ -3156,7 +3157,6 @@ irqreturn_t xhci_irq(struct usb_hcd *hcd)
 	if (status & STS_FATAL) {
 		xhci_warn(xhci, "WARNING: Host System Error\n");
 		xhci_halt(xhci);
-		ret = IRQ_HANDLED;
 		goto out;
 	}
 
@@ -3167,7 +3167,6 @@ irqreturn_t xhci_irq(struct usb_hcd *hcd)
 	 */
 	status |= STS_EINT;
 	writel(status, &xhci->op_regs->status);
-	ret = IRQ_HANDLED;
 
 	/* This is the handler of the primary interrupter */
 	xhci_handle_events(xhci, xhci->interrupters[0]);


