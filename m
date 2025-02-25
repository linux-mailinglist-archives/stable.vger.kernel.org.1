Return-Path: <stable+bounces-119469-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FFA7A43A9C
	for <lists+stable@lfdr.de>; Tue, 25 Feb 2025 11:04:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 954843A7F0C
	for <lists+stable@lfdr.de>; Tue, 25 Feb 2025 10:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07A8E267AEF;
	Tue, 25 Feb 2025 09:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LiUOpQw1"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D21F264A7E;
	Tue, 25 Feb 2025 09:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740477518; cv=none; b=bgnYAdJLkDdeCUpAOHre0sJA9GqQEfeHcnFt9FaCth8CxYZNdKZmfmFHIcG9O/l1N58mImHJLHZzKiHMW8FFEVzEExhtkLpL5MuygtzQxBBeRT+YJR2Z3AOejKOKH81yc3LaZq7o4SE6nWguaamS5WiQ2Ko3HBtRLc0/UGE37gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740477518; c=relaxed/simple;
	bh=yO83EuW0ggiRy9HujzEC+k9Mmk9GdbJ1j7rWWpFn+qs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q3KXa4te6OYgqfv9JgeGfFbMp7HE59vEPRZDRBmtpd1Zv4uLmWyiFMlzBn3UQcvFCqtoTe/ZSMl1iUhjk6DMW6BM8Q5q4AQc4xhS5wV0nX3LOxJWLc3QpULSAEQ+6D0jkRznPioDa0dmj332tHwDhCXzfIe9sBbRDX/q5K3r5b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LiUOpQw1; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740477518; x=1772013518;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yO83EuW0ggiRy9HujzEC+k9Mmk9GdbJ1j7rWWpFn+qs=;
  b=LiUOpQw10oKYs9ldMDVZ0xHf47tSBmmEL/EPUk0QXzWzzzSHIgg2uByN
   FluLYrzXPzazfZVmzFq8W8M9w5Mg78C8TczF/9TBQRpKMdGOiO5E/MskW
   q5c5rpa1Ds/KL6SE8uIPaFVylRqNJdzjNcx9vGeiXpXfKkcrdZyld49dP
   c7NVuTggNcNKCN7FYv9M398lBX5SGvuK68zPvXKkPY8rgXaL1fFMk6o7p
   DU4zyv6nokPY5YhsICyId55Pfr34oVnR7Lh9k9RtDqEGdkLTcLGjb9cpn
   8FdDu5YYuqGmwgwcI+qmytPdQTiFt9J7RDty1gLo5w0P1w3cFEC7E4m7L
   g==;
X-CSE-ConnectionGUID: DltSWBlXSAGW9F44HXVZgw==
X-CSE-MsgGUID: josQdxzyRpGKcXgHTaD4ZQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11355"; a="45059900"
X-IronPort-AV: E=Sophos;i="6.13,313,1732608000"; 
   d="scan'208";a="45059900"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 01:58:37 -0800
X-CSE-ConnectionGUID: U3BhY+crQQe/0A3MqIGAzQ==
X-CSE-MsgGUID: 4aw723bzTfmUBfYPvi9qSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,313,1732608000"; 
   d="scan'208";a="116966858"
Received: from unknown (HELO mattu-haswell.fi.intel.com) ([10.237.72.199])
  by fmviesa009.fm.intel.com with ESMTP; 25 Feb 2025 01:58:35 -0800
From: Mathias Nyman <mathias.nyman@linux.intel.com>
To: <gregkh@linuxfoundation.org>
Cc: <linux-usb@vger.kernel.org>,
	Michal Pecio <michal.pecio@gmail.com>,
	stable@vger.kernel.org,
	Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: [PATCH 1/1] usb: xhci: Enable the TRB overfetch quirk on VIA VL805
Date: Tue, 25 Feb 2025 11:59:27 +0200
Message-ID: <20250225095927.2512358-2-mathias.nyman@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250225095927.2512358-1-mathias.nyman@linux.intel.com>
References: <20250225095927.2512358-1-mathias.nyman@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michal Pecio <michal.pecio@gmail.com>

Raspberry Pi is a major user of those chips and they discovered a bug -
when the end of a transfer ring segment is reached, up to four TRBs can
be prefetched from the next page even if the segment ends with link TRB
and on page boundary (the chip claims to support standard 4KB pages).

It also appears that if the prefetched TRBs belong to a different ring
whose doorbell is later rung, they may be used without refreshing from
system RAM and the endpoint will stay idle if their cycle bit is stale.

Other users complain about IOMMU faults on x86 systems, unsurprisingly.

Deal with it by using existing quirk which allocates a dummy page after
each transfer ring segment. This was seen to resolve both problems. RPi
came up with a more efficient solution, shortening each segment by four
TRBs, but it complicated the driver and they ditched it for this quirk.

Also rename the quirk and add VL805 device ID macro.

Signed-off-by: Michal Pecio <michal.pecio@gmail.com>
Link: https://github.com/raspberrypi/linux/issues/4685
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=215906
CC: stable@vger.kernel.org
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
---
 drivers/usb/host/xhci-mem.c |  3 ++-
 drivers/usb/host/xhci-pci.c | 10 +++++++---
 drivers/usb/host/xhci.h     |  2 +-
 3 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
index 92703efda1f7..fdf0c1008225 100644
--- a/drivers/usb/host/xhci-mem.c
+++ b/drivers/usb/host/xhci-mem.c
@@ -2437,7 +2437,8 @@ int xhci_mem_init(struct xhci_hcd *xhci, gfp_t flags)
 	 * and our use of dma addresses in the trb_address_map radix tree needs
 	 * TRB_SEGMENT_SIZE alignment, so we pick the greater alignment need.
 	 */
-	if (xhci->quirks & XHCI_ZHAOXIN_TRB_FETCH)
+	if (xhci->quirks & XHCI_TRB_OVERFETCH)
+		/* Buggy HC prefetches beyond segment bounds - allocate dummy space at the end */
 		xhci->segment_pool = dma_pool_create("xHCI ring segments", dev,
 				TRB_SEGMENT_SIZE * 2, TRB_SEGMENT_SIZE * 2, xhci->page_size * 2);
 	else
diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index ad0ff356f6fa..54460d11f7ee 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -38,6 +38,8 @@
 #define PCI_DEVICE_ID_ETRON_EJ168		0x7023
 #define PCI_DEVICE_ID_ETRON_EJ188		0x7052
 
+#define PCI_DEVICE_ID_VIA_VL805			0x3483
+
 #define PCI_DEVICE_ID_INTEL_LYNXPOINT_XHCI		0x8c31
 #define PCI_DEVICE_ID_INTEL_LYNXPOINT_LP_XHCI		0x9c31
 #define PCI_DEVICE_ID_INTEL_WILDCATPOINT_LP_XHCI	0x9cb1
@@ -418,8 +420,10 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
 			pdev->device == 0x3432)
 		xhci->quirks |= XHCI_BROKEN_STREAMS;
 
-	if (pdev->vendor == PCI_VENDOR_ID_VIA && pdev->device == 0x3483)
+	if (pdev->vendor == PCI_VENDOR_ID_VIA && pdev->device == PCI_DEVICE_ID_VIA_VL805) {
 		xhci->quirks |= XHCI_LPM_SUPPORT;
+		xhci->quirks |= XHCI_TRB_OVERFETCH;
+	}
 
 	if (pdev->vendor == PCI_VENDOR_ID_ASMEDIA &&
 		pdev->device == PCI_DEVICE_ID_ASMEDIA_1042_XHCI) {
@@ -467,11 +471,11 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
 
 		if (pdev->device == 0x9202) {
 			xhci->quirks |= XHCI_RESET_ON_RESUME;
-			xhci->quirks |= XHCI_ZHAOXIN_TRB_FETCH;
+			xhci->quirks |= XHCI_TRB_OVERFETCH;
 		}
 
 		if (pdev->device == 0x9203)
-			xhci->quirks |= XHCI_ZHAOXIN_TRB_FETCH;
+			xhci->quirks |= XHCI_TRB_OVERFETCH;
 	}
 
 	if (pdev->vendor == PCI_VENDOR_ID_CDNS &&
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index 8c164340a2c3..779b01dee068 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1632,7 +1632,7 @@ struct xhci_hcd {
 #define XHCI_EP_CTX_BROKEN_DCS	BIT_ULL(42)
 #define XHCI_SUSPEND_RESUME_CLKS	BIT_ULL(43)
 #define XHCI_RESET_TO_DEFAULT	BIT_ULL(44)
-#define XHCI_ZHAOXIN_TRB_FETCH	BIT_ULL(45)
+#define XHCI_TRB_OVERFETCH	BIT_ULL(45)
 #define XHCI_ZHAOXIN_HOST	BIT_ULL(46)
 #define XHCI_WRITE_64_HI_LO	BIT_ULL(47)
 #define XHCI_CDNS_SCTX_QUIRK	BIT_ULL(48)
-- 
2.43.0


