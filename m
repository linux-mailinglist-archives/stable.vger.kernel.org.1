Return-Path: <stable+bounces-144375-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51E31AB6C90
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 15:25:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FDA719E4C3B
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 13:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78FAB2798E6;
	Wed, 14 May 2025 13:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GPRcTkS1"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 265E4278163;
	Wed, 14 May 2025 13:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747229134; cv=none; b=oX6Zg0Xs32e3D+gmcR96V5KaUgd2YY+uwgPLdk88oygU1XKAsSpwa0kuDBMQp0nmK/V0weO6bQztPf6QSyeUxofui/UdLS40S79Oa4DzoID2XDoVUkfJiPRupkfmIb0LS0THGxXaL6eSr9sTG/G48mo5BKPoq88VbNdAhe0uSW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747229134; c=relaxed/simple;
	bh=53vLwrSVby7htUFGZTClrn1Qd9Y6i8EySf11HbAypBs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cF686j/jw5DSgKIvkMC29nwmdasFBWaF7uUHtGUMP8lrGptTyDcYQaimSUD+tXbsZzzZ9aj7gBqbmtDoB71NGHQvn0lOI+afGF4VeDd0l3Kx+iw66pnzCa7b+wNWoSNVb2E366hqPW4ObSqXSsp1p3rgUCFhJzFlEPzD5hP2s6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GPRcTkS1; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747229132; x=1778765132;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=53vLwrSVby7htUFGZTClrn1Qd9Y6i8EySf11HbAypBs=;
  b=GPRcTkS171Zc1m4BBY1CoxLAvsP4t3VLQfr+LY9qSJmawNPsRAFKL1qv
   gAY75N01wzR2JmGxNFbRp73paEO17VhZwYLa1G/Sl0VXITRAqFWDgz4YF
   7ANgnqklmjCTiCqanUJqumD3fbMrkf3i+hUxy/xrvCGTp3p00p0NT/YBS
   d3feq4mwmGu/t73xEh0h4GileD6mUCdLCf6msARu6s6KvR1Yank8u30uX
   VjonK12VGqb/zZ0EK0GrBEcrgska/1KPXOHy17mf1Ge5SRibAfq1Aswp2
   gnyZoXPCW9a8r3b+yfRfvGbkpQCh5WINnhhZXSmxrl+LV0WXVFCC2DbxK
   w==;
X-CSE-ConnectionGUID: Bb4Y9gURTHGdtiWOIsk4rA==
X-CSE-MsgGUID: jf1ZsSkLRM6AQy9z3wLyKw==
X-IronPort-AV: E=McAfee;i="6700,10204,11433"; a="51764768"
X-IronPort-AV: E=Sophos;i="6.15,288,1739865600"; 
   d="scan'208";a="51764768"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2025 06:25:31 -0700
X-CSE-ConnectionGUID: VxiB1UZVS/CLHZU4GY9yPA==
X-CSE-MsgGUID: cCjn3g7hS0GZkas/TQmBxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,288,1739865600"; 
   d="scan'208";a="168982290"
Received: from unknown (HELO mnyman-desk.fi.intel.com) ([10.237.72.199])
  by orviesa002.jf.intel.com with ESMTP; 14 May 2025 06:25:30 -0700
From: Mathias Nyman <mathias.nyman@linux.intel.com>
To: <gregkh@linuxfoundation.org>
Cc: <linux-usb@vger.kernel.org>,
	<stern@rowland.harvard.edu>,
	michal.pecio@gmail.com,
	Mathias Nyman <mathias.nyman@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH] usb: Flush altsetting 0 endpoints before reinitializating them after reset.
Date: Wed, 14 May 2025 16:25:20 +0300
Message-ID: <20250514132520.225345-1-mathias.nyman@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

usb core avoids sending a Set-Interface altsetting 0 request after device
reset, and instead relies on calling usb_disable_interface() and
usb_enable_interface() to flush and reset host-side of those endpoints.

xHCI hosts allocate and set up endpoint ring buffers and host_ep->hcpriv
during usb_hcd_alloc_bandwidth() callback, which in this case is called
before flushing the endpoint in usb_disable_interface().

Call usb_disable_interface() before usb_hcd_alloc_bandwidth() to ensure
URBs are flushed before new ring buffers for the endpoints are allocated.

Otherwise host driver will attempt to find and remove old stale URBs
from a freshly allocated new ringbuffer.

Cc: stable@vger.kernel.org
Fixes: 4fe0387afa89 ("USB: don't send Set-Interface after reset")
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
---
 drivers/usb/core/hub.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 0e1dd6ef60a7..9f19fc7494e0 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -6133,6 +6133,7 @@ static int usb_reset_and_verify_device(struct usb_device *udev)
 	struct usb_hub			*parent_hub;
 	struct usb_hcd			*hcd = bus_to_hcd(udev->bus);
 	struct usb_device_descriptor	descriptor;
+	struct usb_interface		*intf;
 	struct usb_host_bos		*bos;
 	int				i, j, ret = 0;
 	int				port1 = udev->portnum;
@@ -6190,6 +6191,18 @@ static int usb_reset_and_verify_device(struct usb_device *udev)
 	if (!udev->actconfig)
 		goto done;
 
+	/*
+	 * Some devices can't handle setting default altsetting 0 with a
+	 * Set-Interface request. Disable host-side endpoints of those
+	 * interfaces here. Enable and reset them back after host has set
+	 * its internal endpoint structures during usb_hcd_alloc_bandwith()
+	 */
+	for (i = 0; i < udev->actconfig->desc.bNumInterfaces; i++) {
+		intf = udev->actconfig->interface[i];
+		if (intf->cur_altsetting->desc.bAlternateSetting == 0)
+			usb_disable_interface(udev, intf, true);
+	}
+
 	mutex_lock(hcd->bandwidth_mutex);
 	ret = usb_hcd_alloc_bandwidth(udev, udev->actconfig, NULL, NULL);
 	if (ret < 0) {
@@ -6221,12 +6234,11 @@ static int usb_reset_and_verify_device(struct usb_device *udev)
 	 */
 	for (i = 0; i < udev->actconfig->desc.bNumInterfaces; i++) {
 		struct usb_host_config *config = udev->actconfig;
-		struct usb_interface *intf = config->interface[i];
 		struct usb_interface_descriptor *desc;
 
+		intf = config->interface[i];
 		desc = &intf->cur_altsetting->desc;
 		if (desc->bAlternateSetting == 0) {
-			usb_disable_interface(udev, intf, true);
 			usb_enable_interface(udev, intf, true);
 			ret = 0;
 		} else {
-- 
2.43.0


