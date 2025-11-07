Return-Path: <stable+bounces-192744-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7404BC40E35
	for <lists+stable@lfdr.de>; Fri, 07 Nov 2025 17:31:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A33754F3E0F
	for <lists+stable@lfdr.de>; Fri,  7 Nov 2025 16:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CF8627E056;
	Fri,  7 Nov 2025 16:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N//hDvRD"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D0C2874F6;
	Fri,  7 Nov 2025 16:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762532922; cv=none; b=qe+YEjQxh6shnQVHXWO74Z8GHW2ffvcQKPX5zOcwWcMe5FGnESnFDEfs4TiIpctvuEvhtI5n0zEXsGMBpryZzP2j8CYV2Q746fqhR/DzN7HHo0gz6iakqVpwYtJhvaFUsf9BUAYy6aDFD0tldH5CZyGsJlJCHYR66nC5Rw0jKHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762532922; c=relaxed/simple;
	bh=z/6y2TuwEjthwLYrrzdV0KzP7tPR7oG0JJ8YHoUwzLI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NKdmFXKoBWdVNKQySwkFtL5FxsGych7Cw/bX71JbYnJmETuDTIUq3vOWIs5gyW6Ys0uACr5AcixjuXMLO8BeHpdWkjXubGNCXCS6jzmJ0CvHXmPd5A5fj19n/wRJBbN0H2Y4owUwoXaJgtgPijItCWzOEKtCJzgQqk2RtYd8TuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N//hDvRD; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762532919; x=1794068919;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=z/6y2TuwEjthwLYrrzdV0KzP7tPR7oG0JJ8YHoUwzLI=;
  b=N//hDvRD+YBSz55IZfmxzvdAvHpx0TpBEtAhjaq+kLRysgko3gS7KKze
   KA/zUgkh/R6zZ7VMt+aPMEPw8VQsYatWfNBvb5BtG4ZeVYzXStFUxPc4T
   ziYUH1StR7mO1VezXR76zxdqQvBzTzEcjX+6kSuW3LbdECL7mfJ6JGRm7
   vFRPQqpFQG4jck7oek73RcyBju+2nao5qX6llwBhkgNff05GA+zKx1wLO
   AnHtQTbXQsKczNKMLseTmDs9VHv6E6FRd/0btwKK3Mi33kBM3b7S9UW1v
   Tgr/a6Uc29ebE/TgTA6Cn5qrML4T9QYIesSJXJ12XsvfJjCYl664pfg4H
   A==;
X-CSE-ConnectionGUID: 2UAUkQ+oSlqijo/9h4i09g==
X-CSE-MsgGUID: uULJifcERCiyurh1KM0JqA==
X-IronPort-AV: E=McAfee;i="6800,10657,11606"; a="74979454"
X-IronPort-AV: E=Sophos;i="6.19,287,1754982000"; 
   d="scan'208";a="74979454"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2025 08:28:38 -0800
X-CSE-ConnectionGUID: exg1YIsMRyKhhVLYxoCCQQ==
X-CSE-MsgGUID: ghXZz0aTQbKZQ4AChyzbfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,287,1754982000"; 
   d="scan'208";a="187328933"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO mnyman-desk.intel.com) ([10.245.245.61])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2025 08:28:36 -0800
From: Mathias Nyman <mathias.nyman@linux.intel.com>
To: <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org,
	Mathias Nyman <mathias.nyman@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/3] xhci: fix stale flag preventig URBs after link state error is cleared
Date: Fri,  7 Nov 2025 18:28:16 +0200
Message-ID: <20251107162819.1362579-2-mathias.nyman@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251107162819.1362579-1-mathias.nyman@linux.intel.com>
References: <20251107162819.1362579-1-mathias.nyman@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
---
 drivers/usb/host/xhci-ring.c | 15 ++++++++++-----
 drivers/usb/host/xhci.c      |  1 +
 2 files changed, 11 insertions(+), 5 deletions(-)

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
-- 
2.43.0


