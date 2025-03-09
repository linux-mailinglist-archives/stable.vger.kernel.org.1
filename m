Return-Path: <stable+bounces-121613-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3134A58811
	for <lists+stable@lfdr.de>; Sun,  9 Mar 2025 21:22:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39F77168FB3
	for <lists+stable@lfdr.de>; Sun,  9 Mar 2025 20:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E212C2144AE;
	Sun,  9 Mar 2025 20:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lT7wIewY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923CA211C
	for <stable@vger.kernel.org>; Sun,  9 Mar 2025 20:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741551724; cv=none; b=jvjakW4TQulL8nUHjOKcXe7ZP7f34yGhRNyZV66wZkafo4xCgz/GrPSE3N+JZn06uDsXmMSP7cNR6bMVsZ8MO9675rr/V7EVtmfpuZBg6nJTsTMGHR0fa4NPB/5bkvI5/phsR/Mdu4jkR2g8PX9uX/+nkl/2HjsxBwXEFV4ZOYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741551724; c=relaxed/simple;
	bh=G7fIEO7/ghUncwLFRCnUB0BMZXd3Fp0DOt2RLouOqVE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=XjG/nQm7nToMaDHBBSo2dGeNFfZzqMMWukgLx/L7w+R0t4Rqg5VokWPzp84ypOGnM0+vqO3NGhRrjmmQoD/3dCd4vsk0p40bKII8yA04wGMf2avGcP0clkufyGRJCn4FRrPOJ3pZDWHMJO9pkYqu8nW9ZxS9zg1FNk6OVh6GPto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lT7wIewY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2B71C4CEE3;
	Sun,  9 Mar 2025 20:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741551724;
	bh=G7fIEO7/ghUncwLFRCnUB0BMZXd3Fp0DOt2RLouOqVE=;
	h=Subject:To:Cc:From:Date:From;
	b=lT7wIewYk9WMOF3r7yCAFB9o1aJZBl7SM/3UMf9f3tEcosDt7mGqcrBo90VXE3K97
	 IQvoHWCZXc3lxSGx5+EsxkbAgRUnT5ZB57g2I9BBGjyE6W9Wl5X+hroHaUsdWWUzJm
	 zsGkZhq6/u5ECle28irFdisaISz1XILkMQLppv3Q=
Subject: FAILED: patch "[PATCH] usb: xhci: Enable the TRB overfetch quirk on VIA VL805" failed to apply to 6.1-stable tree
To: michal.pecio@gmail.com,gregkh@linuxfoundation.org,mathias.nyman@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 09 Mar 2025 21:21:59 +0100
Message-ID: <2025030959-character-delouse-db17@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x c133ec0e5717868c9967fa3df92a55e537b1aead
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025030959-character-delouse-db17@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c133ec0e5717868c9967fa3df92a55e537b1aead Mon Sep 17 00:00:00 2001
From: Michal Pecio <michal.pecio@gmail.com>
Date: Tue, 25 Feb 2025 11:59:27 +0200
Subject: [PATCH] usb: xhci: Enable the TRB overfetch quirk on VIA VL805

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
Link: https://lore.kernel.org/r/20250225095927.2512358-2-mathias.nyman@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

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


