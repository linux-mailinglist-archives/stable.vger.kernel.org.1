Return-Path: <stable+bounces-172760-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D3A35B3320F
	for <lists+stable@lfdr.de>; Sun, 24 Aug 2025 20:31:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E3C27A7FEC
	for <lists+stable@lfdr.de>; Sun, 24 Aug 2025 18:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0401F823DD;
	Sun, 24 Aug 2025 18:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kcD3JySi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B551F2CCC5
	for <stable@vger.kernel.org>; Sun, 24 Aug 2025 18:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756060253; cv=none; b=mchT8c2q+o3qgX1sfMsnOjOL072FqGhNnaqvXxS7QT+WzUWAIJNuBNo9bFj25XEGFXe4uavw/E1380NGiGSuxwwm4hP4ZODGRJpH/9NWY426yuDCbTQpGvHtFX0nJy/UK3gSS8pPi0QijfGzWjMYzydL6PrfrOkcmugRWTizQRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756060253; c=relaxed/simple;
	bh=Nbw6DvolaVJBIbKrSePbgv+Mb8yXzOOrprqTM+tL2N0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JFLrAuA43WDOeA260ZT9Iio6YqIGv8D/zWIe7+lqAaL8ZWphNI7/sDhSPyJKehfBNp9rHw8tFI6aDXIpA5oqnF4llTMBNALdAjBLziyYuoXSd4paaWxVKndahaSXJS5b32Ss8Io8CdUVpE3U1wUwCMWVPCOh5KlT0+x5mQyEm/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kcD3JySi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DDF3C4CEEB;
	Sun, 24 Aug 2025 18:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756060252;
	bh=Nbw6DvolaVJBIbKrSePbgv+Mb8yXzOOrprqTM+tL2N0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kcD3JySi34zeskwXtmw0RU9FiIY7x18JP0yGEE72pNr5Nmat4lzv1FO7t860JEs1i
	 ZMTc/22iKwUItZh5Bow1eYEJnFlZkayARJDjhtigAujANUX7+F25P9k5lIM4LRw0uP
	 w9C4RzG6bSbmPd73aXyd3STL6kK6fNtx9mZpBrkkBGPJKT40bGtrfn9xG9gAMLBPAW
	 vow6ET5BcgwHucjXlli17tULbVufg/Ncdn4U+85FzlwydxfC+C0AbsV0RCBfnZE4Pt
	 cjx9zq/pBey7kskXu9m4zPGaynVZb8YPFhWte1UqdLmYOQ7ERV8YJofgdRnWfxLs3D
	 f+YTIjpTySvJw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Weitao Wang <WeitaoWang-oc@zhaoxin.com>,
	Mathias Nyman <mathias.nyman@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4.y] usb: xhci: Fix slot_id resource race conflict
Date: Sun, 24 Aug 2025 14:30:49 -0400
Message-ID: <20250824183049.708602-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025082308-crafty-citable-521f@gregkh>
References: <2025082308-crafty-citable-521f@gregkh>
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
index 66cb9f08bff1..2c9015f2a7d3 100644
--- a/drivers/usb/host/xhci-hub.c
+++ b/drivers/usb/host/xhci-hub.c
@@ -628,8 +628,7 @@ static int xhci_enter_test_mode(struct xhci_hcd *xhci,
 		if (!xhci->devs[i])
 			continue;
 
-		retval = xhci_disable_slot(xhci, i);
-		xhci_free_virt_device(xhci, i);
+		retval = xhci_disable_and_free_slot(xhci, i);
 		if (retval)
 			xhci_err(xhci, "Failed to disable slot %d, %d. Enter test mode anyway\n",
 				 i, retval);
diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
index 610190bf62da..19faec119999 100644
--- a/drivers/usb/host/xhci-mem.c
+++ b/drivers/usb/host/xhci-mem.c
@@ -879,21 +879,20 @@ int xhci_alloc_tt_info(struct xhci_hcd *xhci,
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
 
@@ -932,8 +931,9 @@ void xhci_free_virt_device(struct xhci_hcd *xhci, int slot_id)
 
 	if (dev->udev && dev->udev->slot_id)
 		dev->udev->slot_id = 0;
-	kfree(xhci->devs[slot_id]);
-	xhci->devs[slot_id] = NULL;
+	if (xhci->devs[slot_id] == dev)
+		xhci->devs[slot_id] = NULL;
+	kfree(dev);
 }
 
 /*
@@ -975,7 +975,7 @@ static void xhci_free_virt_devices_depth_first(struct xhci_hcd *xhci, int slot_i
 out:
 	/* we are now at a leaf device */
 	xhci_debugfs_remove_slot(xhci, slot_id);
-	xhci_free_virt_device(xhci, slot_id);
+	xhci_free_virt_device(xhci, vdev, slot_id);
 }
 
 int xhci_alloc_virt_device(struct xhci_hcd *xhci, int slot_id,
diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 08b016864fc0..70a35e2139bb 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -1255,7 +1255,8 @@ static void xhci_handle_cmd_enable_slot(struct xhci_hcd *xhci, int slot_id,
 		command->slot_id = 0;
 }
 
-static void xhci_handle_cmd_disable_slot(struct xhci_hcd *xhci, int slot_id)
+static void xhci_handle_cmd_disable_slot(struct xhci_hcd *xhci, int slot_id,
+					u32 cmd_comp_code)
 {
 	struct xhci_virt_device *virt_dev;
 	struct xhci_slot_ctx *slot_ctx;
@@ -1270,6 +1271,10 @@ static void xhci_handle_cmd_disable_slot(struct xhci_hcd *xhci, int slot_id)
 	if (xhci->quirks & XHCI_EP_LIMIT_QUIRK)
 		/* Delete default control endpoint resources */
 		xhci_free_device_endpoint_resources(xhci, virt_dev, true);
+	if (cmd_comp_code == COMP_SUCCESS) {
+		xhci->dcbaa->dev_context_ptrs[slot_id] = 0;
+		xhci->devs[slot_id] = NULL;
+	}
 }
 
 static void xhci_handle_cmd_config_ep(struct xhci_hcd *xhci, int slot_id,
@@ -1509,7 +1514,7 @@ static void handle_cmd_completion(struct xhci_hcd *xhci,
 		xhci_handle_cmd_enable_slot(xhci, slot_id, cmd, cmd_comp_code);
 		break;
 	case TRB_DISABLE_SLOT:
-		xhci_handle_cmd_disable_slot(xhci, slot_id);
+		xhci_handle_cmd_disable_slot(xhci, slot_id, cmd_comp_code);
 		break;
 	case TRB_CONFIG_EP:
 		if (!cmd->completion)
diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 3383d7f0c88f..9752ff321584 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -3945,7 +3945,7 @@ static void xhci_free_dev(struct usb_hcd *hcd, struct usb_device *udev)
 	xhci_disable_slot(xhci, udev->slot_id);
 
 	spin_lock_irqsave(&xhci->lock, flags);
-	xhci_free_virt_device(xhci, udev->slot_id);
+	xhci_free_virt_device(xhci, virt_dev, udev->slot_id);
 	spin_unlock_irqrestore(&xhci->lock, flags);
 
 }
@@ -3994,6 +3994,16 @@ int xhci_disable_slot(struct xhci_hcd *xhci, u32 slot_id)
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
@@ -4099,8 +4109,7 @@ int xhci_alloc_dev(struct usb_hcd *hcd, struct usb_device *udev)
 	return 1;
 
 disable_slot:
-	xhci_disable_slot(xhci, udev->slot_id);
-	xhci_free_virt_device(xhci, udev->slot_id);
+	xhci_disable_and_free_slot(xhci, udev->slot_id);
 
 	return 0;
 }
@@ -4236,8 +4245,7 @@ static int xhci_setup_device(struct usb_hcd *hcd, struct usb_device *udev,
 		dev_warn(&udev->dev, "Device not responding to setup %s.\n", act);
 
 		mutex_unlock(&xhci->mutex);
-		ret = xhci_disable_slot(xhci, udev->slot_id);
-		xhci_free_virt_device(xhci, udev->slot_id);
+		ret = xhci_disable_and_free_slot(xhci, udev->slot_id);
 		if (!ret) {
 			if (xhci_alloc_dev(hcd, udev) == 1)
 				xhci_setup_addressable_virt_dev(xhci, udev);
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index d27b08d43e39..d6fa03b21349 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1997,7 +1997,7 @@ void xhci_dbg_trace(struct xhci_hcd *xhci, void (*trace)(struct va_format *),
 /* xHCI memory management */
 void xhci_mem_cleanup(struct xhci_hcd *xhci);
 int xhci_mem_init(struct xhci_hcd *xhci, gfp_t flags);
-void xhci_free_virt_device(struct xhci_hcd *xhci, int slot_id);
+void xhci_free_virt_device(struct xhci_hcd *xhci, struct xhci_virt_device *dev, int slot_id);
 int xhci_alloc_virt_device(struct xhci_hcd *xhci, int slot_id, struct usb_device *udev, gfp_t flags);
 int xhci_setup_addressable_virt_dev(struct xhci_hcd *xhci, struct usb_device *udev);
 void xhci_copy_ep0_dequeue_into_input_ctx(struct xhci_hcd *xhci,
@@ -2087,6 +2087,7 @@ void xhci_reset_bandwidth(struct usb_hcd *hcd, struct usb_device *udev);
 int xhci_update_hub_device(struct usb_hcd *hcd, struct usb_device *hdev,
 			   struct usb_tt *tt, gfp_t mem_flags);
 int xhci_disable_slot(struct xhci_hcd *xhci, u32 slot_id);
+int xhci_disable_and_free_slot(struct xhci_hcd *xhci, u32 slot_id);
 int xhci_ext_cap_init(struct xhci_hcd *xhci);
 
 int xhci_suspend(struct xhci_hcd *xhci, bool do_wakeup);
-- 
2.50.1


