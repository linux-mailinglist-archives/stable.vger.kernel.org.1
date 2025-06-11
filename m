Return-Path: <stable+bounces-152408-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CC8FAD536C
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 13:14:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3F7C1668AA
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 11:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90D912E6120;
	Wed, 11 Jun 2025 11:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K5EVTs2C"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49632E6111;
	Wed, 11 Jun 2025 11:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749640461; cv=none; b=PRltIDgEI4lXKudC8XphVgH3V6gSjthlczQ2NSF5oYXcJfDauOkDTXlVQPBuGFRxJf+x/Eroifdndoyv6RtyCjHRtE7UAFrz+Fsrri4jConYjeU443eYPEQH9svtwMsukzbETgKGlroPt3KiO94FryyzPv/wwhHI4+jDxMWuhlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749640461; c=relaxed/simple;
	bh=y925YUPVV5s/vp2niWj79RIoOFMnpOxmI/oV+HU43X4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MbXbV5bHroy1SAltIJR/jLsvh9uy1pR5HASHA1L+WExM3NPx4tuyZPSCzP9xTXTEDMgpDkgCt6oVTOx9i+/2/I6lV+KLKRmPxI9CnX035OPnGZclfqemT2SRCvNjWajICerF3xToug/pYXEJ5U0+B+Q4xbWoMCs7+oVlFK8/ilE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K5EVTs2C; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749640460; x=1781176460;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=y925YUPVV5s/vp2niWj79RIoOFMnpOxmI/oV+HU43X4=;
  b=K5EVTs2CjpkoUfxg1s5bv/5CjBQl4fWja7Fo/BphoDsZWCMAcfOscsFp
   2a3cJGCXSINJeV9mt8XPTZ6/BmXlS/XNaUcGStE8Tw9frjc75vAMFHCGF
   a9OWaEhb74qL/jeyUMGqrNz7ImMkivSmgSmar0O6jQC5VGZ8TRQbBAORG
   6IqyTloFrzee0rwM4tnXWoU2IU+FyZcn3mMkeK2D8aycxtX7X5LjYZLI9
   zgOx1e3xqJvbZKn7tORyCbpM/MRbnPOh8tDf6tutDcElsGA7r9UeSkL7h
   qByMnEIk5sOrNkLLy7Hm37p0XLRhfIH2al5cVPKCdUV8MvZMcZYoC50/w
   w==;
X-CSE-ConnectionGUID: xuiwMWvXSrSodmYe2vg2ew==
X-CSE-MsgGUID: TxzrF4h2TL6yW0sEiu/UdA==
X-IronPort-AV: E=McAfee;i="6800,10657,11460"; a="51641391"
X-IronPort-AV: E=Sophos;i="6.16,227,1744095600"; 
   d="scan'208";a="51641391"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 04:14:19 -0700
X-CSE-ConnectionGUID: BtCC/FP3RW+OIba4AN2NGw==
X-CSE-MsgGUID: zo6/TCtHTZ2zD0s0cWfmGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,227,1744095600"; 
   d="scan'208";a="147524461"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmviesa008.fm.intel.com with ESMTP; 11 Jun 2025 04:14:17 -0700
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Mathias Nyman <mathias.nyman@linux.intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Harry Wentland <harry.wentland@amd.com>,
	linux-usb@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v1] usb: acpi: fix device link removal
Date: Wed, 11 Jun 2025 14:14:15 +0300
Message-ID: <20250611111415.2707865-1-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The device link to the USB4 host interface has to be removed
manually since it's no longer auto removed.

Fixes: 623dae3e7084 ("usb: acpi: fix boot hang due to early incorrect 'tunneled' USB3 device links")
Cc: stable@vger.kernel.org
Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/usb/core/hub.c      | 3 +++
 drivers/usb/core/usb-acpi.c | 4 +++-
 include/linux/usb.h         | 2 ++
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 770d1e91183c..14229dcb0952 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -2337,6 +2337,9 @@ void usb_disconnect(struct usb_device **pdev)
 	usb_remove_ep_devs(&udev->ep0);
 	usb_unlock_device(udev);
 
+	if (udev->usb4_link)
+		device_link_del(udev->usb4_link);
+
 	/* Unregister the device.  The device driver is responsible
 	 * for de-configuring the device and invoking the remove-device
 	 * notifier chain (used by usbfs and possibly others).
diff --git a/drivers/usb/core/usb-acpi.c b/drivers/usb/core/usb-acpi.c
index ea1ce8beb0cb..489dbdc96f94 100644
--- a/drivers/usb/core/usb-acpi.c
+++ b/drivers/usb/core/usb-acpi.c
@@ -157,7 +157,7 @@ EXPORT_SYMBOL_GPL(usb_acpi_set_power_state);
  */
 static int usb_acpi_add_usb4_devlink(struct usb_device *udev)
 {
-	const struct device_link *link;
+	struct device_link *link;
 	struct usb_port *port_dev;
 	struct usb_hub *hub;
 
@@ -188,6 +188,8 @@ static int usb_acpi_add_usb4_devlink(struct usb_device *udev)
 	dev_dbg(&port_dev->dev, "Created device link from %s to %s\n",
 		dev_name(&port_dev->child->dev), dev_name(nhi_fwnode->dev));
 
+	udev->usb4_link = link;
+
 	return 0;
 }
 
diff --git a/include/linux/usb.h b/include/linux/usb.h
index 1b2545b4363b..92c752f5446f 100644
--- a/include/linux/usb.h
+++ b/include/linux/usb.h
@@ -614,6 +614,7 @@ struct usb3_lpm_parameters {
  *	FIXME -- complete doc
  * @authenticated: Crypto authentication passed
  * @tunnel_mode: Connection native or tunneled over USB4
+ * @usb4_link: device link to the USB4 host interface
  * @lpm_capable: device supports LPM
  * @lpm_devinit_allow: Allow USB3 device initiated LPM, exit latency is in range
  * @usb2_hw_lpm_capable: device can perform USB2 hardware LPM
@@ -724,6 +725,7 @@ struct usb_device {
 	unsigned reset_resume:1;
 	unsigned port_is_suspended:1;
 	enum usb_link_tunnel_mode tunnel_mode;
+	struct device_link *usb4_link;
 
 	int slot_id;
 	struct usb2_lpm_parameters l1_params;
-- 
2.47.2


