Return-Path: <stable+bounces-48011-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3708F8FCB21
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 13:54:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 272A81C20FF6
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 11:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DB211974FA;
	Wed,  5 Jun 2024 11:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g4nIStZw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB4E1974EE;
	Wed,  5 Jun 2024 11:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717588211; cv=none; b=o9HRPtQk+fhN4KDd5hyazFRsSFR/jWG4B3GI15UY3vrJGu37FILRMUbuwvoMTM16xnZ4czrjJZbGwdamU0qODL5Xbdh5FZ19mPUezWhxdHbmNM5UqebA4YTFzBKUv+OT2+n4bl3WKf/q2z75+P5ImR5r3UVteWmhIyXikuGwk7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717588211; c=relaxed/simple;
	bh=A5zpdyyeSFrZwf+rhOiMQ3bJtXoyJuww8Kp6CsWnv1U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dt7KxxCf0FcJrDcyfOQiWHQVqER1p9ITQnP7izkvEx/y/iFyNEDJC2INVvXrB8/vqppj3wYc4KkM7CfxkXOQ3k94jjtZ7LYEVfuqjoGCLIbWVGTGSKj4dY785kjT8sE4ESFHWe+zN+5ppSeZfOhfOuRSsxh24B9ogkmSlBr8xv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g4nIStZw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88821C32781;
	Wed,  5 Jun 2024 11:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717588210;
	bh=A5zpdyyeSFrZwf+rhOiMQ3bJtXoyJuww8Kp6CsWnv1U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g4nIStZw80/RuJUG/lqdDnq8FgKirwIIzqTuSdRs6RdaKAdGgzadwO7VZMvDMSlqG
	 CoKqIzFhQ8IELzvYpPxzKjEWt6T/6xftQJfex4AsaykJNGdadg5Yh9xSg6bqkHLkeF
	 v+gHmVtjaypL0Z2gBrZEFM7VosP9sQmGkQF59CjSdkZXX+esg1WW2/NCcWUmTwIj68
	 /wwYzLUH2MBSLpSkOJJlFAeGU2uFnlwkskL4i7evTK/8nd2ObVQN4p5j8m0X8oAXOL
	 f49p6H3jZpGEwJqd/xC8KF/IHN2hkrf3kpaxO5ry+fekI1bZ5pPdwhIMnqw/7Iea4L
	 txfP8mPp2ZJ7A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mathias Nyman <mathias.nyman@linux.intel.com>,
	Niklas Neronin <niklas.neronin@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	mathias.nyman@intel.com,
	linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 6.9 18/28] xhci: remove XHCI_TRUST_TX_LENGTH quirk
Date: Wed,  5 Jun 2024 07:48:47 -0400
Message-ID: <20240605114927.2961639-18-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605114927.2961639-1-sashal@kernel.org>
References: <20240605114927.2961639-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.9.3
Content-Transfer-Encoding: 8bit

From: Mathias Nyman <mathias.nyman@linux.intel.com>

[ Upstream commit 34b67198244f2d7d8409fa4eb76204c409c0c97e ]

If this quirk was set then driver would treat transfer events with
'Success' completion code as 'Short packet' if there were untransferred
bytes left.

This is so common that turn it into default behavior.

xhci_warn_ratelimited() is no longer used after this, so remove it.

A success event with untransferred bytes left doesn't always mean a
misbehaving controller. If there was an error mid a multi-TRB TD it's
allowed to issue a success event for the last TRB in that TD.

See xhci 1.2 spec 4.9.1 Transfer Descriptors

"Note: If an error is detected while processing a multi-TRB TD, the xHC
 shall generate a Transfer Event for the TRB that the error was detected
 on with the appropriate error Condition Code, then may advance to the
 next TD. If in the process of advancing to the next TD, a Transfer TRB
 is encountered with its IOC flag set, then the Condition Code of the
 Transfer Event generated for that Transfer TRB should be Success,
 because there was no error actually associated with the TRB that
 generated the Event. However, an xHC implementation may redundantly
 assert the original error Condition Code."

Co-developed-by: Niklas Neronin <niklas.neronin@linux.intel.com>
Signed-off-by: Niklas Neronin <niklas.neronin@linux.intel.com>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Link: https://lore.kernel.org/r/20240429140245.3955523-10-mathias.nyman@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/host/xhci-pci.c  | 15 ++-------------
 drivers/usb/host/xhci-rcar.c |  6 ++----
 drivers/usb/host/xhci-ring.c | 15 +++++----------
 drivers/usb/host/xhci.h      |  4 +---
 4 files changed, 10 insertions(+), 30 deletions(-)

diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index 93b6976480188..653b47c45591d 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -270,17 +270,12 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
 				"QUIRK: Fresco Logic revision %u "
 				"has broken MSI implementation",
 				pdev->revision);
-		xhci->quirks |= XHCI_TRUST_TX_LENGTH;
 	}
 
 	if (pdev->vendor == PCI_VENDOR_ID_FRESCO_LOGIC &&
 			pdev->device == PCI_DEVICE_ID_FRESCO_LOGIC_FL1009)
 		xhci->quirks |= XHCI_BROKEN_STREAMS;
 
-	if (pdev->vendor == PCI_VENDOR_ID_FRESCO_LOGIC &&
-			pdev->device == PCI_DEVICE_ID_FRESCO_LOGIC_FL1100)
-		xhci->quirks |= XHCI_TRUST_TX_LENGTH;
-
 	if (pdev->vendor == PCI_VENDOR_ID_NEC)
 		xhci->quirks |= XHCI_NEC_HOST;
 
@@ -307,11 +302,8 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
 		xhci->quirks |= XHCI_RESET_ON_RESUME;
 	}
 
-	if (pdev->vendor == PCI_VENDOR_ID_AMD) {
-		xhci->quirks |= XHCI_TRUST_TX_LENGTH;
-		if (pdev->device == 0x43f7)
-			xhci->quirks |= XHCI_DEFAULT_PM_RUNTIME_ALLOW;
-	}
+	if (pdev->vendor == PCI_VENDOR_ID_AMD && pdev->device == 0x43f7)
+		xhci->quirks |= XHCI_DEFAULT_PM_RUNTIME_ALLOW;
 
 	if ((pdev->vendor == PCI_VENDOR_ID_AMD) &&
 		((pdev->device == PCI_DEVICE_ID_AMD_PROMONTORYA_4) ||
@@ -399,12 +391,10 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
 	if (pdev->vendor == PCI_VENDOR_ID_ETRON &&
 			pdev->device == PCI_DEVICE_ID_EJ168) {
 		xhci->quirks |= XHCI_RESET_ON_RESUME;
-		xhci->quirks |= XHCI_TRUST_TX_LENGTH;
 		xhci->quirks |= XHCI_BROKEN_STREAMS;
 	}
 	if (pdev->vendor == PCI_VENDOR_ID_RENESAS &&
 	    pdev->device == 0x0014) {
-		xhci->quirks |= XHCI_TRUST_TX_LENGTH;
 		xhci->quirks |= XHCI_ZERO_64B_REGS;
 	}
 	if (pdev->vendor == PCI_VENDOR_ID_RENESAS &&
@@ -434,7 +424,6 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
 	}
 	if (pdev->vendor == PCI_VENDOR_ID_ASMEDIA &&
 		pdev->device == PCI_DEVICE_ID_ASMEDIA_1042A_XHCI) {
-		xhci->quirks |= XHCI_TRUST_TX_LENGTH;
 		xhci->quirks |= XHCI_NO_64BIT_SUPPORT;
 	}
 	if (pdev->vendor == PCI_VENDOR_ID_ASMEDIA &&
diff --git a/drivers/usb/host/xhci-rcar.c b/drivers/usb/host/xhci-rcar.c
index ab9c5969e4624..8b357647728c2 100644
--- a/drivers/usb/host/xhci-rcar.c
+++ b/drivers/usb/host/xhci-rcar.c
@@ -214,8 +214,7 @@ static int xhci_rcar_resume_quirk(struct usb_hcd *hcd)
  */
 #define SET_XHCI_PLAT_PRIV_FOR_RCAR(firmware)				\
 	.firmware_name = firmware,					\
-	.quirks = XHCI_NO_64BIT_SUPPORT | XHCI_TRUST_TX_LENGTH |	\
-		  XHCI_SLOW_SUSPEND,					\
+	.quirks = XHCI_NO_64BIT_SUPPORT |  XHCI_SLOW_SUSPEND,		\
 	.init_quirk = xhci_rcar_init_quirk,				\
 	.plat_start = xhci_rcar_start,					\
 	.resume_quirk = xhci_rcar_resume_quirk,
@@ -229,8 +228,7 @@ static const struct xhci_plat_priv xhci_plat_renesas_rcar_gen3 = {
 };
 
 static const struct xhci_plat_priv xhci_plat_renesas_rzv2m = {
-	.quirks = XHCI_NO_64BIT_SUPPORT | XHCI_TRUST_TX_LENGTH |
-		  XHCI_SLOW_SUSPEND,
+	.quirks = XHCI_NO_64BIT_SUPPORT | XHCI_SLOW_SUSPEND,
 	.init_quirk = xhci_rzv2m_init_quirk,
 	.plat_start = xhci_rzv2m_start,
 };
diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 575f0fd9c9f11..e9ba5bc321bd1 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -2399,8 +2399,7 @@ static int process_isoc_td(struct xhci_hcd *xhci, struct xhci_virt_ep *ep,
 			break;
 		if (remaining) {
 			frame->status = short_framestatus;
-			if (xhci->quirks & XHCI_TRUST_TX_LENGTH)
-				sum_trbs_for_length = true;
+			sum_trbs_for_length = true;
 			break;
 		}
 		frame->status = 0;
@@ -2650,15 +2649,11 @@ static int handle_tx_event(struct xhci_hcd *xhci,
 	 * transfer type
 	 */
 	case COMP_SUCCESS:
-		if (EVENT_TRB_LEN(le32_to_cpu(event->transfer_len)) == 0)
-			break;
-		if (xhci->quirks & XHCI_TRUST_TX_LENGTH ||
-		    ep_ring->last_td_was_short)
+		if (EVENT_TRB_LEN(le32_to_cpu(event->transfer_len)) != 0) {
 			trb_comp_code = COMP_SHORT_PACKET;
-		else
-			xhci_warn_ratelimited(xhci,
-					      "WARN Successful completion on short TX for slot %u ep %u: needs XHCI_TRUST_TX_LENGTH quirk?\n",
-					      slot_id, ep_index);
+			xhci_dbg(xhci, "Successful completion on short TX for slot %u ep %u with last td short %d\n",
+				 slot_id, ep_index, ep_ring->last_td_was_short);
+		}
 		break;
 	case COMP_SHORT_PACKET:
 		break;
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index 6f4bf98a62824..cdca3126b302b 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1589,7 +1589,7 @@ struct xhci_hcd {
 #define XHCI_RESET_ON_RESUME	BIT_ULL(7)
 #define	XHCI_SW_BW_CHECKING	BIT_ULL(8)
 #define XHCI_AMD_0x96_HOST	BIT_ULL(9)
-#define XHCI_TRUST_TX_LENGTH	BIT_ULL(10)
+#define XHCI_TRUST_TX_LENGTH	BIT_ULL(10) /* Deprecated */
 #define XHCI_LPM_SUPPORT	BIT_ULL(11)
 #define XHCI_INTEL_HOST		BIT_ULL(12)
 #define XHCI_SPURIOUS_REBOOT	BIT_ULL(13)
@@ -1729,8 +1729,6 @@ static inline bool xhci_has_one_roothub(struct xhci_hcd *xhci)
 	dev_err(xhci_to_hcd(xhci)->self.controller , fmt , ## args)
 #define xhci_warn(xhci, fmt, args...) \
 	dev_warn(xhci_to_hcd(xhci)->self.controller , fmt , ## args)
-#define xhci_warn_ratelimited(xhci, fmt, args...) \
-	dev_warn_ratelimited(xhci_to_hcd(xhci)->self.controller , fmt , ## args)
 #define xhci_info(xhci, fmt, args...) \
 	dev_info(xhci_to_hcd(xhci)->self.controller , fmt , ## args)
 
-- 
2.43.0


