Return-Path: <stable+bounces-78408-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0A7198B975
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 12:22:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D71B1C21BE4
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 10:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A25219C561;
	Tue,  1 Oct 2024 10:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xFWdSXrL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A47E3209
	for <stable@vger.kernel.org>; Tue,  1 Oct 2024 10:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727778143; cv=none; b=UiNBnGI3St9PbZxlaMDeQ4KveWrvr8GqjqlCmLXZ/7GPJXCQbBvB7WxnRro3cYThgkiq6EyZ6xyu9LTv2lmkDjvEfICh08f92L93TGoxXJpPiGz3jD5xRgXVAABam+6OyPLbG2CrcfInXuH8gPy9mJr4RhWAtwTTC0tQ1DrByNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727778143; c=relaxed/simple;
	bh=8qWQOpHfgXJMGfb+PjYn+YCwAwnQuotBTCrJExMNoTo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Isqsehjuxk61j0iVrPLfty+0cb/sZbx3yMoZxiSS2/OAfDBEny3T9zZnOEEi5qFOKS7nr9c1p6G75lzk4a8leuGP2N3n/jfFT2HjL+d4pZecscm4z7ucOSUq6GfaBEOI34/osqKoyvF9GEYYsyy9QUSUNivLKfw3/sCDajVNG+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xFWdSXrL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C21BEC4CEC6;
	Tue,  1 Oct 2024 10:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727778143;
	bh=8qWQOpHfgXJMGfb+PjYn+YCwAwnQuotBTCrJExMNoTo=;
	h=Subject:To:Cc:From:Date:From;
	b=xFWdSXrLmO/xzBIvSg1c0C0pNEHsqevGfRPa0oLA5bNcm2DkwcYV9nSDwt31yhH5V
	 Htwc6pwjk1bcjvMRUOTa77wPfMxFV9xe+VRiD1s7ZWFrEiDYvgzztWW5hhO9VfL3E2
	 YEztU0IUYDJqk44o4zuwdbDhaL6i1FLfCyEFHmHM=
Subject: FAILED: patch "[PATCH] usb: xhci: fix loss of data on Cadence xHC" failed to apply to 6.6-stable tree
To: pawell@cadence.com,gregkh@linuxfoundation.org,peter.chen@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 01 Oct 2024 12:22:15 +0200
Message-ID: <2024100115-hurled-related-db8b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x e5fa8db0be3e8757e8641600c518425a4589b85c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024100115-hurled-related-db8b@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

e5fa8db0be3e ("usb: xhci: fix loss of data on Cadence xHC")
bc162403e33e ("xhci: Add a quirk for writing ERST in high-low order")
18a6be674306 ("usb: cdnsp: blocked some cdns3 specific code")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e5fa8db0be3e8757e8641600c518425a4589b85c Mon Sep 17 00:00:00 2001
From: Pawel Laszczak <pawell@cadence.com>
Date: Thu, 5 Sep 2024 07:03:28 +0000
Subject: [PATCH] usb: xhci: fix loss of data on Cadence xHC

Streams should flush their TRB cache, re-read TRBs, and start executing
TRBs from the beginning of the new dequeue pointer after a 'Set TR Dequeue
Pointer' command.

Cadence controllers may fail to start from the beginning of the dequeue
TRB as it doesn't clear the Opaque 'RsvdO' field of the stream context
during 'Set TR Dequeue' command. This stream context area is where xHC
stores information about the last partially executed TD when a stream
is stopped. xHC uses this information to resume the transfer where it left
mid TD, when the stream is restarted.

Patch fixes this by clearing out all RsvdO fields before initializing new
Stream transfer using a 'Set TR Dequeue Pointer' command.

Fixes: 3d82904559f4 ("usb: cdnsp: cdns3 Add main part of Cadence USBSSP DRD Driver")
cc: stable@vger.kernel.org
Signed-off-by: Pawel Laszczak <pawell@cadence.com>
Reviewed-by: Peter Chen <peter.chen@kernel.org>
Link: https://lore.kernel.org/r/PH7PR07MB95386A40146E3EC64086F409DD9D2@PH7PR07MB9538.namprd07.prod.outlook.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/usb/cdns3/host.c b/drivers/usb/cdns3/host.c
index ceca4d839dfd..7ba760ee62e3 100644
--- a/drivers/usb/cdns3/host.c
+++ b/drivers/usb/cdns3/host.c
@@ -62,7 +62,9 @@ static const struct xhci_plat_priv xhci_plat_cdns3_xhci = {
 	.resume_quirk = xhci_cdns3_resume_quirk,
 };
 
-static const struct xhci_plat_priv xhci_plat_cdnsp_xhci;
+static const struct xhci_plat_priv xhci_plat_cdnsp_xhci = {
+	.quirks = XHCI_CDNS_SCTX_QUIRK,
+};
 
 static int __cdns_host_init(struct cdns *cdns)
 {
diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index 8a5df569221a..91dccd25a551 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -81,6 +81,9 @@
 #define PCI_DEVICE_ID_ASMEDIA_2142_XHCI			0x2142
 #define PCI_DEVICE_ID_ASMEDIA_3242_XHCI			0x3242
 
+#define PCI_DEVICE_ID_CADENCE				0x17CD
+#define PCI_DEVICE_ID_CADENCE_SSP			0x0200
+
 static const char hcd_name[] = "xhci_hcd";
 
 static struct hc_driver __read_mostly xhci_pci_hc_driver;
@@ -474,6 +477,10 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
 			xhci->quirks |= XHCI_ZHAOXIN_TRB_FETCH;
 	}
 
+	if (pdev->vendor == PCI_DEVICE_ID_CADENCE &&
+	    pdev->device == PCI_DEVICE_ID_CADENCE_SSP)
+		xhci->quirks |= XHCI_CDNS_SCTX_QUIRK;
+
 	/* xHC spec requires PCI devices to support D3hot and D3cold */
 	if (xhci->hci_version >= 0x120)
 		xhci->quirks |= XHCI_DEFAULT_PM_RUNTIME_ALLOW;
diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index a4383735b16c..4d664ba53fe9 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -1399,6 +1399,20 @@ static void xhci_handle_cmd_set_deq(struct xhci_hcd *xhci, int slot_id,
 			struct xhci_stream_ctx *ctx =
 				&ep->stream_info->stream_ctx_array[stream_id];
 			deq = le64_to_cpu(ctx->stream_ring) & SCTX_DEQ_MASK;
+
+			/*
+			 * Cadence xHCI controllers store some endpoint state
+			 * information within Rsvd0 fields of Stream Endpoint
+			 * context. This field is not cleared during Set TR
+			 * Dequeue Pointer command which causes XDMA to skip
+			 * over transfer ring and leads to data loss on stream
+			 * pipe.
+			 * To fix this issue driver must clear Rsvd0 field.
+			 */
+			if (xhci->quirks & XHCI_CDNS_SCTX_QUIRK) {
+				ctx->reserved[0] = 0;
+				ctx->reserved[1] = 0;
+			}
 		} else {
 			deq = le64_to_cpu(ep_ctx->deq) & ~EP_CTX_CYCLE_MASK;
 		}
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index 1e50ebbe9514..620502de971a 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1623,6 +1623,7 @@ struct xhci_hcd {
 #define XHCI_ZHAOXIN_TRB_FETCH	BIT_ULL(45)
 #define XHCI_ZHAOXIN_HOST	BIT_ULL(46)
 #define XHCI_WRITE_64_HI_LO	BIT_ULL(47)
+#define XHCI_CDNS_SCTX_QUIRK	BIT_ULL(48)
 
 	unsigned int		num_active_eps;
 	unsigned int		limit_active_eps;


