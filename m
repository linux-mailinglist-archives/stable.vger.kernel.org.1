Return-Path: <stable+bounces-173633-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CCFB3B35E39
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 13:54:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A59B1B222EF
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 11:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F158335BC8;
	Tue, 26 Aug 2025 11:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ybrCV2Ob"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BDB518DF9D;
	Tue, 26 Aug 2025 11:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756208755; cv=none; b=hZj0vjr+bHcUFABFFSciwKFPoMxYlLk5RjC6WXrKBsmJ/tdi52Khvfb5PeWUjjywQglakiqz+Jw+M2oTX9zxh8sPEeiz3rwSh3aoN/dxrOwdwDisNTtkFZXL2RHSNkhr7v2xLJzVVEpi2VKAvuzpYNJTttsVQLm/ELqvRPC2G7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756208755; c=relaxed/simple;
	bh=o2oR18zTgKk7qQHqZfB7i9ldOUXqO00iierVG5CyeqI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KAar+cFHKhMvpZLKYXXPEGpBZWw1uO3+9nBQiS2uU/N8fWkZ/kRmVdjos4QKCBocqGlCwyv6yOK07zaM+XrRHKOmxBGWo07bFLwtR2ZQbDejmAz582f9OuSeJ/Xe1eZc4SFlM7WjvxNgleZhyUyq7yk7CrUhfUQ55hejzcPVBrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ybrCV2Ob; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59213C4CEF1;
	Tue, 26 Aug 2025 11:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756208754;
	bh=o2oR18zTgKk7qQHqZfB7i9ldOUXqO00iierVG5CyeqI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ybrCV2ObncVcYlN6cIFD2rqzeMd2LHNO0FEUK6iMqGiGFx9bZTvG84jSCeOyATe2u
	 GhQt3WmA0Z/tpyfqknvj2aQoWoeA0FfvpyNrHIe44m9yEaxIgYUE1KBVExVD8MuIeo
	 MPj066xUiv0YP5oXqYa/+Bjqzh5iCXkda1VcvVJo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Weitao Wang <WeitaoWang-oc@zhaoxin.com>,
	Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: [PATCH 6.12 232/322] usb: xhci: Fix slot_id resource race conflict
Date: Tue, 26 Aug 2025 13:10:47 +0200
Message-ID: <20250826110921.631212506@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110915.169062587@linuxfoundation.org>
References: <20250826110915.169062587@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Weitao Wang <WeitaoWang-oc@zhaoxin.com>

commit 2eb03376151bb8585caa23ed2673583107bb5193 upstream.

xHC controller may immediately reuse a slot_id after it's disabled,
giving it to a new enumerating device before the xhci driver freed
all resources related to the disabled device.

In such a scenario, device-A with slot_id equal to 1 is disconnecting
while device-B is enumerating, device-B will fail to enumerate in the
follow sequence.

1.[device-A] send disable slot command
2.[device-B] send enable slot command
3.[device-A] disable slot command completed and wakeup waiting thread
4.[device-B] enable slot command completed with slot_id equal to 1 and
	     wakeup waiting thread
5.[device-B] driver checks that slot_id is still in use (by device-A) in
	     xhci_alloc_virt_device, and fail to enumerate due to this
	     conflict
6.[device-A] xhci->devs[slot_id] set to NULL in xhci_free_virt_device

To fix driver's slot_id resources conflict, clear xhci->devs[slot_id] and
xhci->dcbba->dev_context_ptrs[slot_id] pointers in the interrupt context
when disable slot command completes successfully. Simultaneously, adjust
function xhci_free_virt_device to accurately handle device release.

[minor smatch warning and commit message fix -Mathias]

Cc: stable@vger.kernel.org
Fixes: 7faac1953ed1 ("xhci: avoid race between disable slot command and host runtime suspend")
Signed-off-by: Weitao Wang <WeitaoWang-oc@zhaoxin.com>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Link: https://lore.kernel.org/r/20250819125844.2042452-2-mathias.nyman@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/host/xhci-hub.c  |    3 +--
 drivers/usb/host/xhci-mem.c  |   22 +++++++++++-----------
 drivers/usb/host/xhci-ring.c |    9 +++++++--
 drivers/usb/host/xhci.c      |   21 ++++++++++++++-------
 drivers/usb/host/xhci.h      |    3 ++-
 5 files changed, 35 insertions(+), 23 deletions(-)

--- a/drivers/usb/host/xhci-hub.c
+++ b/drivers/usb/host/xhci-hub.c
@@ -704,8 +704,7 @@ static int xhci_enter_test_mode(struct x
 		if (!xhci->devs[i])
 			continue;
 
-		retval = xhci_disable_slot(xhci, i);
-		xhci_free_virt_device(xhci, i);
+		retval = xhci_disable_and_free_slot(xhci, i);
 		if (retval)
 			xhci_err(xhci, "Failed to disable slot %d, %d. Enter test mode anyway\n",
 				 i, retval);
--- a/drivers/usb/host/xhci-mem.c
+++ b/drivers/usb/host/xhci-mem.c
@@ -842,21 +842,20 @@ free_tts:
  * will be manipulated by the configure endpoint, allocate device, or update
  * hub functions while this function is removing the TT entries from the list.
  */
-void xhci_free_virt_device(struct xhci_hcd *xhci, int slot_id)
+void xhci_free_virt_device(struct xhci_hcd *xhci, struct xhci_virt_device *dev,
+		int slot_id)
 {
-	struct xhci_virt_device *dev;
 	int i;
 	int old_active_eps = 0;
 
 	/* Slot ID 0 is reserved */
-	if (slot_id == 0 || !xhci->devs[slot_id])
+	if (slot_id == 0 || !dev)
 		return;
 
-	dev = xhci->devs[slot_id];
-
-	xhci->dcbaa->dev_context_ptrs[slot_id] = 0;
-	if (!dev)
-		return;
+	/* If device ctx array still points to _this_ device, clear it */
+	if (dev->out_ctx &&
+	    xhci->dcbaa->dev_context_ptrs[slot_id] == cpu_to_le64(dev->out_ctx->dma))
+		xhci->dcbaa->dev_context_ptrs[slot_id] = 0;
 
 	trace_xhci_free_virt_device(dev);
 
@@ -897,8 +896,9 @@ void xhci_free_virt_device(struct xhci_h
 		dev->udev->slot_id = 0;
 	if (dev->rhub_port && dev->rhub_port->slot_id == slot_id)
 		dev->rhub_port->slot_id = 0;
-	kfree(xhci->devs[slot_id]);
-	xhci->devs[slot_id] = NULL;
+	if (xhci->devs[slot_id] == dev)
+		xhci->devs[slot_id] = NULL;
+	kfree(dev);
 }
 
 /*
@@ -939,7 +939,7 @@ static void xhci_free_virt_devices_depth
 out:
 	/* we are now at a leaf device */
 	xhci_debugfs_remove_slot(xhci, slot_id);
-	xhci_free_virt_device(xhci, slot_id);
+	xhci_free_virt_device(xhci, vdev, slot_id);
 }
 
 int xhci_alloc_virt_device(struct xhci_hcd *xhci, int slot_id,
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -1562,7 +1562,8 @@ static void xhci_handle_cmd_enable_slot(
 		command->slot_id = 0;
 }
 
-static void xhci_handle_cmd_disable_slot(struct xhci_hcd *xhci, int slot_id)
+static void xhci_handle_cmd_disable_slot(struct xhci_hcd *xhci, int slot_id,
+					u32 cmd_comp_code)
 {
 	struct xhci_virt_device *virt_dev;
 	struct xhci_slot_ctx *slot_ctx;
@@ -1577,6 +1578,10 @@ static void xhci_handle_cmd_disable_slot
 	if (xhci->quirks & XHCI_EP_LIMIT_QUIRK)
 		/* Delete default control endpoint resources */
 		xhci_free_device_endpoint_resources(xhci, virt_dev, true);
+	if (cmd_comp_code == COMP_SUCCESS) {
+		xhci->dcbaa->dev_context_ptrs[slot_id] = 0;
+		xhci->devs[slot_id] = NULL;
+	}
 }
 
 static void xhci_handle_cmd_config_ep(struct xhci_hcd *xhci, int slot_id)
@@ -1824,7 +1829,7 @@ static void handle_cmd_completion(struct
 		xhci_handle_cmd_enable_slot(slot_id, cmd, cmd_comp_code);
 		break;
 	case TRB_DISABLE_SLOT:
-		xhci_handle_cmd_disable_slot(xhci, slot_id);
+		xhci_handle_cmd_disable_slot(xhci, slot_id, cmd_comp_code);
 		break;
 	case TRB_CONFIG_EP:
 		if (!cmd->completion)
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -3763,8 +3763,7 @@ static int xhci_discover_or_reset_device
 		 * Obtaining a new device slot to inform the xHCI host that
 		 * the USB device has been reset.
 		 */
-		ret = xhci_disable_slot(xhci, udev->slot_id);
-		xhci_free_virt_device(xhci, udev->slot_id);
+		ret = xhci_disable_and_free_slot(xhci, udev->slot_id);
 		if (!ret) {
 			ret = xhci_alloc_dev(hcd, udev);
 			if (ret == 1)
@@ -3919,7 +3918,7 @@ static void xhci_free_dev(struct usb_hcd
 	xhci_disable_slot(xhci, udev->slot_id);
 
 	spin_lock_irqsave(&xhci->lock, flags);
-	xhci_free_virt_device(xhci, udev->slot_id);
+	xhci_free_virt_device(xhci, virt_dev, udev->slot_id);
 	spin_unlock_irqrestore(&xhci->lock, flags);
 
 }
@@ -3968,6 +3967,16 @@ int xhci_disable_slot(struct xhci_hcd *x
 	return 0;
 }
 
+int xhci_disable_and_free_slot(struct xhci_hcd *xhci, u32 slot_id)
+{
+	struct xhci_virt_device *vdev = xhci->devs[slot_id];
+	int ret;
+
+	ret = xhci_disable_slot(xhci, slot_id);
+	xhci_free_virt_device(xhci, vdev, slot_id);
+	return ret;
+}
+
 /*
  * Checks if we have enough host controller resources for the default control
  * endpoint.
@@ -4074,8 +4083,7 @@ int xhci_alloc_dev(struct usb_hcd *hcd,
 	return 1;
 
 disable_slot:
-	xhci_disable_slot(xhci, udev->slot_id);
-	xhci_free_virt_device(xhci, udev->slot_id);
+	xhci_disable_and_free_slot(xhci, udev->slot_id);
 
 	return 0;
 }
@@ -4211,8 +4219,7 @@ static int xhci_setup_device(struct usb_
 		dev_warn(&udev->dev, "Device not responding to setup %s.\n", act);
 
 		mutex_unlock(&xhci->mutex);
-		ret = xhci_disable_slot(xhci, udev->slot_id);
-		xhci_free_virt_device(xhci, udev->slot_id);
+		ret = xhci_disable_and_free_slot(xhci, udev->slot_id);
 		if (!ret) {
 			if (xhci_alloc_dev(hcd, udev) == 1)
 				xhci_setup_addressable_virt_dev(xhci, udev);
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1774,7 +1774,7 @@ void xhci_dbg_trace(struct xhci_hcd *xhc
 /* xHCI memory management */
 void xhci_mem_cleanup(struct xhci_hcd *xhci);
 int xhci_mem_init(struct xhci_hcd *xhci, gfp_t flags);
-void xhci_free_virt_device(struct xhci_hcd *xhci, int slot_id);
+void xhci_free_virt_device(struct xhci_hcd *xhci, struct xhci_virt_device *dev, int slot_id);
 int xhci_alloc_virt_device(struct xhci_hcd *xhci, int slot_id, struct usb_device *udev, gfp_t flags);
 int xhci_setup_addressable_virt_dev(struct xhci_hcd *xhci, struct usb_device *udev);
 void xhci_copy_ep0_dequeue_into_input_ctx(struct xhci_hcd *xhci,
@@ -1866,6 +1866,7 @@ void xhci_reset_bandwidth(struct usb_hcd
 int xhci_update_hub_device(struct usb_hcd *hcd, struct usb_device *hdev,
 			   struct usb_tt *tt, gfp_t mem_flags);
 int xhci_disable_slot(struct xhci_hcd *xhci, u32 slot_id);
+int xhci_disable_and_free_slot(struct xhci_hcd *xhci, u32 slot_id);
 int xhci_ext_cap_init(struct xhci_hcd *xhci);
 
 int xhci_suspend(struct xhci_hcd *xhci, bool do_wakeup);



