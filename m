Return-Path: <stable+bounces-68562-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C34A9532F2
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 16:12:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 109891F21A26
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 14:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27F261B3F2F;
	Thu, 15 Aug 2024 14:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TPnBVXbs"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD3A1AD9E8;
	Thu, 15 Aug 2024 14:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723730960; cv=none; b=NxonH8KO8My749bPgq4v8Q3e+mw9im8r+Y7vwEGuBqz4nOYXvhhTNFdUR7/Uk7QqqudC2z1yUYekiHLMIWIaMQ6V45yvLOO9Aqq7Pl/k2klnJHxhTlAgIYw/+iEV/KwtQpBKtpirKokmB1InEBrwP7t5QjWwPOWgZQwARpnZY5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723730960; c=relaxed/simple;
	bh=R//JYXLLg67ii2SoH3h/7/uUd8NJdeUOHDDJ8l2oIIQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lYzLeKSEzkPfbfnZRPyHbtq3P7j3uIN27KwOXxJQ3TSqBh8JQydhiN2nBnegrKbZuC0rAlc3WLtlp5Pd4ixrLYjHCuHJV12yyaYyZQGDrM5KrVCj3LyzOmL0l/KhKF95LnOV0zV9G9wKQnuSXQKlQyfaekDvkksowUjEiLSeJUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TPnBVXbs; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723730959; x=1755266959;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=R//JYXLLg67ii2SoH3h/7/uUd8NJdeUOHDDJ8l2oIIQ=;
  b=TPnBVXbsckgWdCaYQSkIpmIDzmwfojRO324vDND9nbGChn5jMIPEdnhu
   aNLNCCEE+6f6J3NHIxvLQEEgX/Iey3x4/9x73X+aymRxgbxp1Z1S27b8Q
   ojKxtcoxTMpSqbpcyiUqX+Oynz4NUCFfSL+cZlG3IZmL8d0kZOwzy1HaU
   t2cYven2tWzt1mU2qXGZcPxR/W48qpE3HnP1XOvipSQBVDsYuUVBg1FiT
   fIt8XrvO5LhYhADFkTK9VCxGNI72EMoIVRK/YeTClNlqt4gClmw0uihl+
   Q4JzX7FhQ22PMqFOe0kS7TGksnKa+PI64PfZSXzI4IFIYCfdkvj6LDyXg
   Q==;
X-CSE-ConnectionGUID: f0YGwTZGTaumYBWEFahJkw==
X-CSE-MsgGUID: KikZN7egRgath8IA6/9JQg==
X-IronPort-AV: E=McAfee;i="6700,10204,11165"; a="25852517"
X-IronPort-AV: E=Sophos;i="6.10,149,1719903600"; 
   d="scan'208";a="25852517"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2024 07:09:18 -0700
X-CSE-ConnectionGUID: jvvbB3RiS3SDmRn0xnVgMw==
X-CSE-MsgGUID: pGv6Tp4ISeOstApqUB+KbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,149,1719903600"; 
   d="scan'208";a="64022926"
Received: from mattu-haswell.fi.intel.com ([10.237.72.199])
  by fmviesa004.fm.intel.com with ESMTP; 15 Aug 2024 07:09:16 -0700
From: Mathias Nyman <mathias.nyman@linux.intel.com>
To: <linux-usb@vger.kernel.org>,
	<gregkh@linuxfoundation.org>
Cc: Mathias Nyman <mathias.nyman@linux.intel.com>,
	Karel Balej <balejk@matfyz.cz>,
	stable@vger.kernel.org
Subject: [PATCH 1/1] xhci: Fix Panther point NULL pointer deref at full-speed re-enumeration
Date: Thu, 15 Aug 2024 17:11:17 +0300
Message-Id: <20240815141117.2702314-2-mathias.nyman@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240815141117.2702314-1-mathias.nyman@linux.intel.com>
References: <20240815141117.2702314-1-mathias.nyman@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

re-enumerating full-speed devices after a failed address device command
can trigger a NULL pointer dereference.

Full-speed devices may need to reconfigure the endpoint 0 Max Packet Size
value during enumeration. Usb core calls usb_ep0_reinit() in this case,
which ends up calling xhci_configure_endpoint().

On Panther point xHC the xhci_configure_endpoint() function will
additionally check and reserve bandwidth in software. Other hosts do
this in hardware

If xHC address device command fails then a new xhci_virt_device structure
is allocated as part of re-enabling the slot, but the bandwidth table
pointers are not set up properly here.
This triggers the NULL pointer dereference the next time usb_ep0_reinit()
is called and xhci_configure_endpoint() tries to check and reserve
bandwidth

[46710.713538] usb 3-1: new full-speed USB device number 5 using xhci_hcd
[46710.713699] usb 3-1: Device not responding to setup address.
[46710.917684] usb 3-1: Device not responding to setup address.
[46711.125536] usb 3-1: device not accepting address 5, error -71
[46711.125594] BUG: kernel NULL pointer dereference, address: 0000000000000008
[46711.125600] #PF: supervisor read access in kernel mode
[46711.125603] #PF: error_code(0x0000) - not-present page
[46711.125606] PGD 0 P4D 0
[46711.125610] Oops: Oops: 0000 [#1] PREEMPT SMP PTI
[46711.125615] CPU: 1 PID: 25760 Comm: kworker/1:2 Not tainted 6.10.3_2 #1
[46711.125620] Hardware name: Gigabyte Technology Co., Ltd.
[46711.125623] Workqueue: usb_hub_wq hub_event [usbcore]
[46711.125668] RIP: 0010:xhci_reserve_bandwidth (drivers/usb/host/xhci.c

Fix this by making sure bandwidth table pointers are set up correctly
after a failed address device command, and additionally by avoiding
checking for bandwidth in cases like this where no actual endpoints are
added or removed, i.e. only context for default control endpoint 0 is
evaluated.

Reported-by: Karel Balej <balejk@matfyz.cz>
Closes: https://lore.kernel.org/linux-usb/D3CKQQAETH47.1MUO22RTCH2O3@matfyz.cz/
Cc: stable@vger.kernel.org
Fixes: 651aaf36a7d7 ("usb: xhci: Handle USB transaction error on address command")
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
---
 drivers/usb/host/xhci.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 0a8cf6c17f82..efdf4c228b8c 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -2837,7 +2837,7 @@ static int xhci_configure_endpoint(struct xhci_hcd *xhci,
 				xhci->num_active_eps);
 		return -ENOMEM;
 	}
-	if ((xhci->quirks & XHCI_SW_BW_CHECKING) &&
+	if ((xhci->quirks & XHCI_SW_BW_CHECKING) && !ctx_change &&
 	    xhci_reserve_bandwidth(xhci, virt_dev, command->in_ctx)) {
 		if ((xhci->quirks & XHCI_EP_LIMIT_QUIRK))
 			xhci_free_host_resources(xhci, ctrl_ctx);
@@ -4200,8 +4200,10 @@ static int xhci_setup_device(struct usb_hcd *hcd, struct usb_device *udev,
 		mutex_unlock(&xhci->mutex);
 		ret = xhci_disable_slot(xhci, udev->slot_id);
 		xhci_free_virt_device(xhci, udev->slot_id);
-		if (!ret)
-			xhci_alloc_dev(hcd, udev);
+		if (!ret) {
+			if (xhci_alloc_dev(hcd, udev) == 1)
+				xhci_setup_addressable_virt_dev(xhci, udev);
+		}
 		kfree(command->completion);
 		kfree(command);
 		return -EPROTO;
-- 
2.25.1


