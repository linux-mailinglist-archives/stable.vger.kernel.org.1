Return-Path: <stable+bounces-172757-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A088B33189
	for <lists+stable@lfdr.de>; Sun, 24 Aug 2025 18:49:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55045189954F
	for <lists+stable@lfdr.de>; Sun, 24 Aug 2025 16:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C124F1BD9D0;
	Sun, 24 Aug 2025 16:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i3qCPohT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DDA2275AED
	for <stable@vger.kernel.org>; Sun, 24 Aug 2025 16:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756054188; cv=none; b=DUuORWUJQVpc4AG2AT/UQuydpMasW9z8MMrvIDIiJZCfk/HzlIJoJEwyXcrGx4VnPLAZc6ChPtiz0jkMxUCmCw72iH0nENlO3mmrLq7O4dbe8hYlBiHKxJ4jD9/HKc2cXVLYsZS4XcsgZlDkTNJzh0FCGu018LcohhXvj62nZHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756054188; c=relaxed/simple;
	bh=0PXd6BCawbkKnFobY4q2dWI4/KXs4E/cEwzMRha6AaA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MQbAlGxq3oDt4hqTL4VJVsX9PHLSfJhG/q1IBp3i6c6cYm6X0FFeuzKLyGRzigZ0SYxZadqgcAbrxShU4vGs1kMYzRamd9AHxbzsNT6TYbkBKCNkhgjg21yvQlRznZaZug92ga8DJTf9U2Hh8Fo3TvDgduiN2uY0ZfpUWSe6nnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i3qCPohT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0179C4CEEB;
	Sun, 24 Aug 2025 16:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756054188;
	bh=0PXd6BCawbkKnFobY4q2dWI4/KXs4E/cEwzMRha6AaA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i3qCPohTlHLQCGUHGdRF0+cNIiJDHUH1aUm9hUP2aphrfd9/0dNL4yp3AG4a3LjDx
	 f2a447pC8ZJ5WwGXSZ0LayfrVdfvufmoGRHoAkh8qJVNEM+v5PtkmT15G3MknjSNQy
	 x9iAo596J8B3SIdAc7GjFGPrfHLoOOFHPxpKpy9cxK8KO2fZ1RGu6V8aDdc0r29JIa
	 JM9XL5mX6OH7TWmscWPYa67ynYMBdGspqIuq/dOlkqiiq2uoVvN9Iy8RnFG+2bW8PW
	 PfLhP7m58N8mNiHL4YvHuizkGTtktJrczPoqr5Kb4tN69mwbVlYcSOUS8yNovYUpSF
	 rX8OEN9CJMI3w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Weitao Wang <WeitaoWang-oc@zhaoxin.com>,
	Mathias Nyman <mathias.nyman@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] usb: xhci: Fix slot_id resource race conflict
Date: Sun, 24 Aug 2025 12:49:45 -0400
Message-ID: <20250824164945.4151696-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025082307-civic-sleeve-30a6@gregkh>
References: <2025082307-civic-sleeve-30a6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Weitao Wang <WeitaoWang-oc@zhaoxin.com>

[ Upstream commit 2eb03376151bb8585caa23ed2673583107bb5193 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/host/xhci-hub.c  |  3 +--
 drivers/usb/host/xhci-mem.c  | 22 +++++++++++-----------
 drivers/usb/host/xhci-ring.c |  9 +++++++--
 drivers/usb/host/xhci.c      | 18 +++++++++++++-----
 drivers/usb/host/xhci.h      |  3 ++-
 5 files changed, 34 insertions(+), 21 deletions(-)

diff --git a/drivers/usb/host/xhci-hub.c b/drivers/usb/host/xhci-hub.c
index e92f920256b2..05f119e7178c 100644
--- a/drivers/usb/host/xhci-hub.c
+++ b/drivers/usb/host/xhci-hub.c
@@ -630,8 +630,7 @@ static int xhci_enter_test_mode(struct xhci_hcd *xhci,
 		if (!xhci->devs[i])
 			continue;
 
-		retval = xhci_disable_slot(xhci, i);
-		xhci_free_virt_device(xhci, i);
+		retval = xhci_disable_and_free_slot(xhci, i);
 		if (retval)
 			xhci_err(xhci, "Failed to disable slot %d, %d. Enter test mode anyway\n",
 				 i, retval);
diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
index 5b0e00978322..ab790b976442 100644
--- a/drivers/usb/host/xhci-mem.c
+++ b/drivers/usb/host/xhci-mem.c
@@ -888,21 +888,20 @@ int xhci_alloc_tt_info(struct xhci_hcd *xhci,
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
 
@@ -941,8 +940,9 @@ void xhci_free_virt_device(struct xhci_hcd *xhci, int slot_id)
 
 	if (dev->udev && dev->udev->slot_id)
 		dev->udev->slot_id = 0;
-	kfree(xhci->devs[slot_id]);
-	xhci->devs[slot_id] = NULL;
+	if (xhci->devs[slot_id] == dev)
+		xhci->devs[slot_id] = NULL;
+	kfree(dev);
 }
 
 /*
@@ -984,7 +984,7 @@ static void xhci_free_virt_devices_depth_first(struct xhci_hcd *xhci, int slot_i
 out:
 	/* we are now at a leaf device */
 	xhci_debugfs_remove_slot(xhci, slot_id);
-	xhci_free_virt_device(xhci, slot_id);
+	xhci_free_virt_device(xhci, vdev, slot_id);
 }
 
 int xhci_alloc_virt_device(struct xhci_hcd *xhci, int slot_id,
diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 954cd962e113..403f53a11b1f 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -1381,7 +1381,8 @@ static void xhci_handle_cmd_enable_slot(struct xhci_hcd *xhci, int slot_id,
 		command->slot_id = 0;
 }
 
-static void xhci_handle_cmd_disable_slot(struct xhci_hcd *xhci, int slot_id)
+static void xhci_handle_cmd_disable_slot(struct xhci_hcd *xhci, int slot_id,
+					u32 cmd_comp_code)
 {
 	struct xhci_virt_device *virt_dev;
 	struct xhci_slot_ctx *slot_ctx;
@@ -1396,6 +1397,10 @@ static void xhci_handle_cmd_disable_slot(struct xhci_hcd *xhci, int slot_id)
 	if (xhci->quirks & XHCI_EP_LIMIT_QUIRK)
 		/* Delete default control endpoint resources */
 		xhci_free_device_endpoint_resources(xhci, virt_dev, true);
+	if (cmd_comp_code == COMP_SUCCESS) {
+		xhci->dcbaa->dev_context_ptrs[slot_id] = 0;
+		xhci->devs[slot_id] = NULL;
+	}
 }
 
 static void xhci_handle_cmd_config_ep(struct xhci_hcd *xhci, int slot_id,
@@ -1635,7 +1640,7 @@ static void handle_cmd_completion(struct xhci_hcd *xhci,
 		xhci_handle_cmd_enable_slot(xhci, slot_id, cmd, cmd_comp_code);
 		break;
 	case TRB_DISABLE_SLOT:
-		xhci_handle_cmd_disable_slot(xhci, slot_id);
+		xhci_handle_cmd_disable_slot(xhci, slot_id, cmd_comp_code);
 		break;
 	case TRB_CONFIG_EP:
 		if (!cmd->completion)
diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 908445cff24f..b46f4a5f7d2d 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -3956,7 +3956,7 @@ static void xhci_free_dev(struct usb_hcd *hcd, struct usb_device *udev)
 	xhci_disable_slot(xhci, udev->slot_id);
 
 	spin_lock_irqsave(&xhci->lock, flags);
-	xhci_free_virt_device(xhci, udev->slot_id);
+	xhci_free_virt_device(xhci, virt_dev, udev->slot_id);
 	spin_unlock_irqrestore(&xhci->lock, flags);
 
 }
@@ -4005,6 +4005,16 @@ int xhci_disable_slot(struct xhci_hcd *xhci, u32 slot_id)
 	return ret;
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
@@ -4110,8 +4120,7 @@ int xhci_alloc_dev(struct usb_hcd *hcd, struct usb_device *udev)
 	return 1;
 
 disable_slot:
-	xhci_disable_slot(xhci, udev->slot_id);
-	xhci_free_virt_device(xhci, udev->slot_id);
+	xhci_disable_and_free_slot(xhci, udev->slot_id);
 
 	return 0;
 }
@@ -4247,8 +4256,7 @@ static int xhci_setup_device(struct usb_hcd *hcd, struct usb_device *udev,
 		dev_warn(&udev->dev, "Device not responding to setup %s.\n", act);
 
 		mutex_unlock(&xhci->mutex);
-		ret = xhci_disable_slot(xhci, udev->slot_id);
-		xhci_free_virt_device(xhci, udev->slot_id);
+		ret = xhci_disable_and_free_slot(xhci, udev->slot_id);
 		if (!ret) {
 			if (xhci_alloc_dev(hcd, udev) == 1)
 				xhci_setup_addressable_virt_dev(xhci, udev);
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index 2d2e9c59add6..6bb1ddc3918c 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -2012,7 +2012,7 @@ void xhci_dbg_trace(struct xhci_hcd *xhci, void (*trace)(struct va_format *),
 /* xHCI memory management */
 void xhci_mem_cleanup(struct xhci_hcd *xhci);
 int xhci_mem_init(struct xhci_hcd *xhci, gfp_t flags);
-void xhci_free_virt_device(struct xhci_hcd *xhci, int slot_id);
+void xhci_free_virt_device(struct xhci_hcd *xhci, struct xhci_virt_device *dev, int slot_id);
 int xhci_alloc_virt_device(struct xhci_hcd *xhci, int slot_id, struct usb_device *udev, gfp_t flags);
 int xhci_setup_addressable_virt_dev(struct xhci_hcd *xhci, struct usb_device *udev);
 void xhci_copy_ep0_dequeue_into_input_ctx(struct xhci_hcd *xhci,
@@ -2104,6 +2104,7 @@ void xhci_reset_bandwidth(struct usb_hcd *hcd, struct usb_device *udev);
 int xhci_update_hub_device(struct usb_hcd *hcd, struct usb_device *hdev,
 			   struct usb_tt *tt, gfp_t mem_flags);
 int xhci_disable_slot(struct xhci_hcd *xhci, u32 slot_id);
+int xhci_disable_and_free_slot(struct xhci_hcd *xhci, u32 slot_id);
 int xhci_ext_cap_init(struct xhci_hcd *xhci);
 
 int xhci_suspend(struct xhci_hcd *xhci, bool do_wakeup);
-- 
2.50.1


