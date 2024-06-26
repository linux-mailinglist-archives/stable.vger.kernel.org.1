Return-Path: <stable+bounces-55842-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EC4391815D
	for <lists+stable@lfdr.de>; Wed, 26 Jun 2024 14:49:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 132B71F24FED
	for <lists+stable@lfdr.de>; Wed, 26 Jun 2024 12:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9298186E45;
	Wed, 26 Jun 2024 12:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B6wfdRip"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F51A186E40;
	Wed, 26 Jun 2024 12:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719406035; cv=none; b=axQ/L0U2GgzJkLeEIZn2pxft6Nwvfi9XMAOq29OsF3UQEVXHxUf7JOCLicw1TcrrSe4Knmx/1+dX0tiC6ju3EAhC2MqmE3OMcrCBgH7oyqjbv+FdKJCSNquFsHJPenxJgVwEaXUITZ/6hUPQ3OcHzF4arIoSipWz86KYzVReECA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719406035; c=relaxed/simple;
	bh=P9g/6krIxhfi7Sdu03FqW5zX9/IBp2+EqMPlCK0xQSE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nCLEjGJZT3knsrr2cIpsVUx/LKAFoV024hVsRqeDleIolhHtjsKExTsSVANOCAGfdVwjstAOEEK+ONDPehHFQfr23Xqvm6pQB9YtdmA7nUCLU+MS5LcxqSk79b3voF8xNf9Xwl2Ad1QmvuOsBIAojzG5eIeE6KA3erZr+3QUSwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B6wfdRip; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719406034; x=1750942034;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=P9g/6krIxhfi7Sdu03FqW5zX9/IBp2+EqMPlCK0xQSE=;
  b=B6wfdRip2WefpZ5t7jMXfZmtTz/auQjL2HWM2gGA+su4oJCCRnp9QeAW
   yWp2+PL9IJ0lMdmB1fhWwN03QfizJyYXTkBWquW/FXRnFwjmnrn0EHXKz
   6Ts8ZzKRTzJJKLoNsi3eYTdy0fW6BJQr+ltOTpUWgEl6B8ZThLugEVen/
   R5fdb0rXIaTSvxjeAYA56XYpGNl6HWgZ0K9CaAkGGyq123UtU7YjBaeDv
   9S4o8jyce1iawP647UczoIeMM4OnrcuTt6vmz73sQKfttdiQtkzh2usDz
   IGwZ23vGkZcnSabYrqcEd2qH5T5quTulKD8XTSojxriKef47lbJ/euLvS
   A==;
X-CSE-ConnectionGUID: 2yhParNkQ+GYgo6nRNc1PA==
X-CSE-MsgGUID: fmwXxm8+Td+yJSZKIc+3lA==
X-IronPort-AV: E=McAfee;i="6700,10204,11114"; a="16353435"
X-IronPort-AV: E=Sophos;i="6.08,266,1712646000"; 
   d="scan'208";a="16353435"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2024 05:47:14 -0700
X-CSE-ConnectionGUID: XPKMWaXcR6yG86aGqaqG6A==
X-CSE-MsgGUID: pnBievJeQdiocOfUJECxSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,266,1712646000"; 
   d="scan'208";a="48442770"
Received: from mattu-haswell.fi.intel.com ([10.237.72.199])
  by fmviesa005.fm.intel.com with ESMTP; 26 Jun 2024 05:47:11 -0700
From: Mathias Nyman <mathias.nyman@linux.intel.com>
To: <gregkh@linuxfoundation.org>
Cc: <linux-usb@vger.kernel.org>,
	niklas.neronin@linux.intel.com,
	Reka Norman <rekanorman@chromium.org>,
	stable@vger.kernel.org,
	Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: [PATCH 20/21] xhci: Apply XHCI_RESET_TO_DEFAULT quirk to TGL
Date: Wed, 26 Jun 2024 15:48:34 +0300
Message-Id: <20240626124835.1023046-21-mathias.nyman@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240626124835.1023046-1-mathias.nyman@linux.intel.com>
References: <20240626124835.1023046-1-mathias.nyman@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Reka Norman <rekanorman@chromium.org>

TGL systems have the same issue as ADL, where a large boot firmware
delay is seen if USB ports are left in U3 at shutdown. So apply the
XHCI_RESET_TO_DEFAULT quirk to TGL as well.

The issue it fixes is a ~20s boot time delay when booting from S5. It
affects TGL devices, and TGL support was added starting from v5.3.

Cc: stable@vger.kernel.org
Signed-off-by: Reka Norman <rekanorman@chromium.org>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
---
 drivers/usb/host/xhci-pci.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index 05881153883e..dc1e345ab67e 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -50,6 +50,7 @@
 #define PCI_DEVICE_ID_INTEL_DENVERTON_XHCI		0x19d0
 #define PCI_DEVICE_ID_INTEL_ICE_LAKE_XHCI		0x8a13
 #define PCI_DEVICE_ID_INTEL_TIGER_LAKE_XHCI		0x9a13
+#define PCI_DEVICE_ID_INTEL_TIGER_LAKE_PCH_XHCI		0xa0ed
 #define PCI_DEVICE_ID_INTEL_COMET_LAKE_XHCI		0xa3af
 #define PCI_DEVICE_ID_INTEL_ALDER_LAKE_PCH_XHCI		0x51ed
 #define PCI_DEVICE_ID_INTEL_ALDER_LAKE_N_PCH_XHCI	0x54ed
@@ -373,7 +374,8 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
 		xhci->quirks |= XHCI_MISSING_CAS;
 
 	if (pdev->vendor == PCI_VENDOR_ID_INTEL &&
-	    (pdev->device == PCI_DEVICE_ID_INTEL_ALDER_LAKE_PCH_XHCI ||
+	    (pdev->device == PCI_DEVICE_ID_INTEL_TIGER_LAKE_PCH_XHCI ||
+	     pdev->device == PCI_DEVICE_ID_INTEL_ALDER_LAKE_PCH_XHCI ||
 	     pdev->device == PCI_DEVICE_ID_INTEL_ALDER_LAKE_N_PCH_XHCI))
 		xhci->quirks |= XHCI_RESET_TO_DEFAULT;
 
-- 
2.25.1


