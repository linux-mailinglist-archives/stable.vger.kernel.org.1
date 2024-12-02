Return-Path: <stable+bounces-96094-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 364669E07BA
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 16:57:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27FC2163B28
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 15:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83C7320A5C6;
	Mon,  2 Dec 2024 15:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LBNdXU5f"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C1A209673
	for <stable@vger.kernel.org>; Mon,  2 Dec 2024 15:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733152773; cv=none; b=gcYu5kF0EH/JEIuoPInnvdtJHXxY/KelzEIG+Zp0MMErfCcGwkzxwwfdAaxUylEkeZQkTNDETPvBBgWeHLawH0crmucKCEsqLh6m/3Pq4WuG1BToHeEkMZGCtSaSVn8KpCd3u3SAU0qX8izd1n6RdsmlpddvyIn8Qm074eb90vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733152773; c=relaxed/simple;
	bh=xJ33M1yfG/Y4Q6MVSnlyl+joaJ7CBK6h2oUb9evS3wo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ZW2YG9Qc8AgrlD8AqJKj8u+NlMsSVfpdbNPYa8/5AlNbPSVhd90fcNUFTG2hyROplWCINDvgYQ2/EGwVeysEITq7twHSSG1+CVmaxkNJAbp6FantNLl0zib7wHrfe0V0DlYm2mUUFCyNKI6pVUaOy9VnQ6TSYuXEEtKpDHUUHLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LBNdXU5f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6718DC4CED1;
	Mon,  2 Dec 2024 15:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733152772;
	bh=xJ33M1yfG/Y4Q6MVSnlyl+joaJ7CBK6h2oUb9evS3wo=;
	h=Subject:To:Cc:From:Date:From;
	b=LBNdXU5fckSUW6eSocyWW723UaPs0oij58luR/r8bQYbkiFRkcJ7znQ0b34XFiyp3
	 fkIzhYpSYQVncCJTh/hzIdtn6EKOIaW+aaP6yzWi3iMlDxmIFY6w5/42AOrxFex/0L
	 5wt6uId7cmootbEabkqmoG+06tlEFuuFQcXXIRQ8=
Subject: FAILED: patch "[PATCH] xhci: Don't issue Reset Device command to Etron xHCI host" failed to apply to 5.15-stable tree
To: ki.chiang65@gmail.com,gregkh@linuxfoundation.org,mathias.nyman@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 02 Dec 2024 16:19:27 +0100
Message-ID: <2024120227-yapping-outright-27f7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 76d98856b1c6d06ce18f32c20527a4f9d283e660
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024120227-yapping-outright-27f7@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 76d98856b1c6d06ce18f32c20527a4f9d283e660 Mon Sep 17 00:00:00 2001
From: Kuangyi Chiang <ki.chiang65@gmail.com>
Date: Wed, 6 Nov 2024 12:14:44 +0200
Subject: [PATCH] xhci: Don't issue Reset Device command to Etron xHCI host

Sometimes the hub driver does not recognize the USB device connected
to the external USB2.0 hub when the system resumes from S4.

After the SetPortFeature(PORT_RESET) request is completed, the hub
driver calls the HCD reset_device callback, which will issue a Reset
Device command and free all structures associated with endpoints
that were disabled.

This happens when the xHCI driver issue a Reset Device command to
inform the Etron xHCI host that the USB device associated with a
device slot has been reset. Seems that the Etron xHCI host can not
perform this command correctly, affecting the USB device.

To work around this, the xHCI driver should obtain a new device slot
with reference to commit 651aaf36a7d7 ("usb: xhci: Handle USB transaction
error on address command"), which is another way to inform the Etron
xHCI host that the USB device has been reset.

Add a new XHCI_ETRON_HOST quirk flag to invoke the workaround in
xhci_discover_or_reset_device().

Fixes: 2a8f82c4ceaf ("USB: xhci: Notify the xHC when a device is reset.")
Cc: stable@vger.kernel.org
Signed-off-by: Kuangyi Chiang <ki.chiang65@gmail.com>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Link: https://lore.kernel.org/r/20241106101459.775897-19-mathias.nyman@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index db3c7e738213..4b8c93e59d6d 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -396,6 +396,7 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
 	if (pdev->vendor == PCI_VENDOR_ID_ETRON &&
 	    (pdev->device == PCI_DEVICE_ID_EJ168 ||
 	     pdev->device == PCI_DEVICE_ID_EJ188)) {
+		xhci->quirks |= XHCI_ETRON_HOST;
 		xhci->quirks |= XHCI_RESET_ON_RESUME;
 		xhci->quirks |= XHCI_BROKEN_STREAMS;
 	}
diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index aa8c877f47ac..ae16253b53fb 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -3733,6 +3733,8 @@ void xhci_free_device_endpoint_resources(struct xhci_hcd *xhci,
 				xhci->num_active_eps);
 }
 
+static void xhci_free_dev(struct usb_hcd *hcd, struct usb_device *udev);
+
 /*
  * This submits a Reset Device Command, which will set the device state to 0,
  * set the device address to 0, and disable all the endpoints except the default
@@ -3803,6 +3805,23 @@ static int xhci_discover_or_reset_device(struct usb_hcd *hcd,
 						SLOT_STATE_DISABLED)
 		return 0;
 
+	if (xhci->quirks & XHCI_ETRON_HOST) {
+		/*
+		 * Obtaining a new device slot to inform the xHCI host that
+		 * the USB device has been reset.
+		 */
+		ret = xhci_disable_slot(xhci, udev->slot_id);
+		xhci_free_virt_device(xhci, udev->slot_id);
+		if (!ret) {
+			ret = xhci_alloc_dev(hcd, udev);
+			if (ret == 1)
+				ret = 0;
+			else
+				ret = -EINVAL;
+		}
+		return ret;
+	}
+
 	trace_xhci_discover_or_reset_device(slot_ctx);
 
 	xhci_dbg(xhci, "Resetting device with slot ID %u\n", slot_id);
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index d3b250c736b8..a0204e10486d 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1631,6 +1631,7 @@ struct xhci_hcd {
 #define XHCI_ZHAOXIN_HOST	BIT_ULL(46)
 #define XHCI_WRITE_64_HI_LO	BIT_ULL(47)
 #define XHCI_CDNS_SCTX_QUIRK	BIT_ULL(48)
+#define XHCI_ETRON_HOST	BIT_ULL(49)
 
 	unsigned int		num_active_eps;
 	unsigned int		limit_active_eps;


