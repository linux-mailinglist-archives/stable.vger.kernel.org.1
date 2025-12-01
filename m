Return-Path: <stable+bounces-197956-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2569AC98722
	for <lists+stable@lfdr.de>; Mon, 01 Dec 2025 18:12:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 172F14E2776
	for <lists+stable@lfdr.de>; Mon,  1 Dec 2025 17:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19F99335556;
	Mon,  1 Dec 2025 17:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="U096nxzC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9C5334C24
	for <stable@vger.kernel.org>; Mon,  1 Dec 2025 17:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764609115; cv=none; b=IRcsKRYKA1D+8tNYxxQFC0zgAjMh4cRfLdAfCW5+80fsJox+M9Xn0pcrysySdjXDenNOcumMy3bSmQ3ExdPbdWu3pdsmYSUT5j232yYalApIubKi2J90Iz7HHjGi2CN9DfEhUWRHgGtqvVJHfHPrB5zyGtSF2IptbkPRahrxU3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764609115; c=relaxed/simple;
	bh=h2d2hRU3mZKNWQMGYMzwQgwrl34CTXyC+j8/+nDJPcI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Fmpu9ym5dwnH7mwsuX/O6vuOJXWXJCgRGpTJIU2FDhUqorZVhxAxZ+lEQPiYVdXAzKCUio7n/QmzAy3VdRc49QtOGi0Ner072FDUcfvJ3jIfH8CALjHNUP8T4wTU/zSA+inFdKrIm1uH2iuonFo8TFj5//OF8TJ0ZFX8lPuQWjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=U096nxzC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31CD7C4CEF1;
	Mon,  1 Dec 2025 17:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1764609115;
	bh=h2d2hRU3mZKNWQMGYMzwQgwrl34CTXyC+j8/+nDJPcI=;
	h=Subject:To:Cc:From:Date:From;
	b=U096nxzCx4GWYl0YWKKT3md9g8z8RT6TBw6MNyllkxlU7tDE2jTpeIykbRehKuyQc
	 cyE56nEpsUQuDkoIUfsbun3yTZdhbxh6rSXGWWR+0sMD5ePoW5il/jHvYi4GCoXW/B
	 ee2hh7zf0eWK9jufY2+zlzduS0an+FeZr0CxB0ZI=
Subject: FAILED: patch "[PATCH] xhci: fix stale flag preventig URBs after link state error is" failed to apply to 6.1-stable tree
To: mathias.nyman@linux.intel.com,gregkh@linuxfoundation.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 01 Dec 2025 18:11:44 +0100
Message-ID: <2025120144-obedience-unrelated-1f48@gregkh>
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
git cherry-pick -x b69dfcab6894b1fed5362a364411502a7469fce3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025120144-obedience-unrelated-1f48@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b69dfcab6894b1fed5362a364411502a7469fce3 Mon Sep 17 00:00:00 2001
From: Mathias Nyman <mathias.nyman@linux.intel.com>
Date: Fri, 7 Nov 2025 18:28:16 +0200
Subject: [PATCH] xhci: fix stale flag preventig URBs after link state error is
 cleared

A usb device caught behind a link in ss.Inactive error state needs to
be reset to recover. A VDEV_PORT_ERROR flag is used to track this state,
preventing new transfers from being queued until error is cleared.

This flag may be left uncleared if link goes to error state between two
resets, and print the following message:

"xhci_hcd 0000:00:14.0: Can't queue urb, port error, link inactive"

Fix setting and clearing the flag.

The flag is cleared after hub driver has successfully reset the device
when hcd->reset_device is called. xhci-hcd issues an internal "reset
device" command in this callback, and clear all flags once the command
completes successfully.

This command may complete with a context state error if slot was recently
reset and is already in the defauilt state. This is treated as a success
but flag was left uncleared.

The link state field is also unreliable if port is currently in reset,
so don't set the flag in active reset cases.
Also clear the flag immediately when link is no longer in ss.Inactive
state and port event handler detects a completed reset.

This issue was discovered while debugging kernel bugzilla issue 220491.
It is likely one small part of the problem, causing some of the failures,
but root cause remains unknown

Link: https://bugzilla.kernel.org/show_bug.cgi?id=220491
Fixes: b8c3b718087b ("usb: xhci: Don't try to recover an endpoint if port is in error state.")
Cc: stable@vger.kernel.org
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Link: https://patch.msgid.link/20251107162819.1362579-2-mathias.nyman@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 8e209aa33ea7..5bdcf9ab2b99 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -1985,6 +1985,7 @@ static void xhci_cavium_reset_phy_quirk(struct xhci_hcd *xhci)
 
 static void handle_port_status(struct xhci_hcd *xhci, union xhci_trb *event)
 {
+	struct xhci_virt_device *vdev = NULL;
 	struct usb_hcd *hcd;
 	u32 port_id;
 	u32 portsc, cmd_reg;
@@ -2016,6 +2017,9 @@ static void handle_port_status(struct xhci_hcd *xhci, union xhci_trb *event)
 		goto cleanup;
 	}
 
+	if (port->slot_id)
+		vdev = xhci->devs[port->slot_id];
+
 	/* We might get interrupts after shared_hcd is removed */
 	if (port->rhub == &xhci->usb3_rhub && xhci->shared_hcd == NULL) {
 		xhci_dbg(xhci, "ignore port event for removed USB3 hcd\n");
@@ -2038,10 +2042,11 @@ static void handle_port_status(struct xhci_hcd *xhci, union xhci_trb *event)
 		usb_hcd_resume_root_hub(hcd);
 	}
 
-	if (hcd->speed >= HCD_USB3 &&
-	    (portsc & PORT_PLS_MASK) == XDEV_INACTIVE) {
-		if (port->slot_id && xhci->devs[port->slot_id])
-			xhci->devs[port->slot_id]->flags |= VDEV_PORT_ERROR;
+	if (vdev && (portsc & PORT_PLS_MASK) == XDEV_INACTIVE) {
+		if (!(portsc & PORT_RESET))
+			vdev->flags |= VDEV_PORT_ERROR;
+	} else if (vdev && portsc & PORT_RC) {
+		vdev->flags &= ~VDEV_PORT_ERROR;
 	}
 
 	if ((portsc & PORT_PLC) && (portsc & PORT_PLS_MASK) == XDEV_RESUME) {
@@ -2099,7 +2104,7 @@ static void handle_port_status(struct xhci_hcd *xhci, union xhci_trb *event)
 		 * so the roothub behavior is consistent with external
 		 * USB 3.0 hub behavior.
 		 */
-		if (port->slot_id && xhci->devs[port->slot_id])
+		if (vdev)
 			xhci_ring_device(xhci, port->slot_id);
 		if (bus_state->port_remote_wakeup & (1 << hcd_portnum)) {
 			xhci_test_and_clear_bit(xhci, port, PORT_PLC);
diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 0cb45b95e4f5..a148a1280126 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -4007,6 +4007,7 @@ static int xhci_discover_or_reset_device(struct usb_hcd *hcd,
 				xhci_get_slot_state(xhci, virt_dev->out_ctx));
 		xhci_dbg(xhci, "Not freeing device rings.\n");
 		/* Don't treat this as an error.  May change my mind later. */
+		virt_dev->flags = 0;
 		ret = 0;
 		goto command_cleanup;
 	case COMP_SUCCESS:


