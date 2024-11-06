Return-Path: <stable+bounces-90096-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62B1F9BE3E8
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 11:13:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99C8DB23FB5
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 10:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A4A01DE3BC;
	Wed,  6 Nov 2024 10:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GbNiTgMo"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570D71DDC34;
	Wed,  6 Nov 2024 10:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730887995; cv=none; b=MO6MwLK14PKiDOcF+Od8FKf4Buml4Homid3nz4Bq/XlsDNhCIJnWWtVvcT1/D2JjDe3tXiePloZyAd1+AuLt5/QoDJTuuxMsFen1B5y9XI308lsBERrzuU4K3rMYFuR0G9Yy0xvsEBdnkKVYbj9rsFRjpMqbcsEEfSBjJyWMtA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730887995; c=relaxed/simple;
	bh=krBrUnrDXKOWS6KLWA1yXNW6r5YeI2/fZUDjEkKibr8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FbPOcmeAcHpwhHP3iHjuRnKK6IA/YHFDL3KkjVHDRNr5wO5wxrglTgZQvQuGkQ+mb9++FPa5fzGBrw7xVUJRxXE1+0fBxeV6VcvXwRkAp0RA7NOO64V8uzo6qiDVJTJcRysmsEoU5Mrc/Yd5/JytsxO9zI3JUQZ32zFWi0mDIvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GbNiTgMo; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730887994; x=1762423994;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=krBrUnrDXKOWS6KLWA1yXNW6r5YeI2/fZUDjEkKibr8=;
  b=GbNiTgMousA4Wi8jhc63Z4A5au5F+vF6oeN+UMGonZ14vwQGrtsGv1a6
   7+G1aVoLCiQDINpc04cB8F5ER6mYKc/m+ZWBSsELyX1/V4WEtsa/+5z8n
   LEFTepRkx/ukmW+mm3fGorAqNeBSccNbqulYCrYsRFIrLKzUuuc4Uzyaj
   2Zoy/6Wss6iCFgNUNBI6VjBqE1x/O9AlkCuMK6otTArwq6BDpKkKSdqx4
   rz8i/ogfcfxJaulGRZzbu6pXXLTv/Ipzayu5V9mJPgm1WmtAxF6i5YyaH
   BOcL2dfgXWNpQAErPNAdoJ88dq8HnkiPG8AzcVN7cyqnkmpnAYqnidL15
   g==;
X-CSE-ConnectionGUID: Qjv2DgcXStGBZuR6MctZ6Q==
X-CSE-MsgGUID: egKh/BCTQpad20j0JmU5dQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11247"; a="42059423"
X-IronPort-AV: E=Sophos;i="6.11,262,1725346800"; 
   d="scan'208";a="42059423"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2024 02:13:14 -0800
X-CSE-ConnectionGUID: vxkLHDEtTQOhBl8qqu/qHA==
X-CSE-MsgGUID: xrBOZABrQ1uTqIin/oDkFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,262,1725346800"; 
   d="scan'208";a="84813235"
Received: from mattu-haswell.fi.intel.com ([10.237.72.199])
  by fmviesa010.fm.intel.com with ESMTP; 06 Nov 2024 02:13:13 -0800
From: Mathias Nyman <mathias.nyman@linux.intel.com>
To: <gregkh@linuxfoundation.org>
Cc: <linux-usb@vger.kernel.org>,
	Kuangyi Chiang <ki.chiang65@gmail.com>,
	stable@vger.kernel.org,
	Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: [PATCH 18/33] xhci: Don't issue Reset Device command to Etron xHCI host
Date: Wed,  6 Nov 2024 12:14:44 +0200
Message-Id: <20241106101459.775897-19-mathias.nyman@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241106101459.775897-1-mathias.nyman@linux.intel.com>
References: <20241106101459.775897-1-mathias.nyman@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kuangyi Chiang <ki.chiang65@gmail.com>

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
Cc: <stable@vger.kernel.org>
Signed-off-by: Kuangyi Chiang <ki.chiang65@gmail.com>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
---
 drivers/usb/host/xhci-pci.c |  1 +
 drivers/usb/host/xhci.c     | 19 +++++++++++++++++++
 drivers/usb/host/xhci.h     |  1 +
 3 files changed, 21 insertions(+)

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
-- 
2.25.1


