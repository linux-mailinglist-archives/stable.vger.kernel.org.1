Return-Path: <stable+bounces-128612-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BBACA7E9D8
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 20:20:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3E8C1886B77
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 18:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6439F2561B8;
	Mon,  7 Apr 2025 18:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hzdcomkh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8E32566D7;
	Mon,  7 Apr 2025 18:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744049494; cv=none; b=SFSfKLcVhZ0WN3ty6ectYZ0x2unvslzzNFJqtp47ckMH87syI3M38q2bm5GE+6ktZy6XW5M2iRwC+F/yIoL23hlJaf5ZgG/trTYACrvhz8ptJgBESxAiKVPx7WNBpiBVk4nEa27OLq2hpClF/lXEljOvlsGNft8S/qBZrjzFt2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744049494; c=relaxed/simple;
	bh=FnCfF83V7mWAARGPankAvQHPnR4jsAR/IXmxlzSd3Ys=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QMfWkOb9wXENUWXqPAyYyvMZfs2IwPs3ThwyMAz0z/SvvdEYAyCrJigq1lEVCQg6OHPa/E2ICjzpsqw7pzqCeeWiRlGQxdLv+N0iDYcotNE8C78PCZP9LkamL3xYlfjgKcGfYu2HZsQNN0eD8KfPzmOmYR8xZ31g1BTk6Gncpu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hzdcomkh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F17DFC4CEDD;
	Mon,  7 Apr 2025 18:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744049494;
	bh=FnCfF83V7mWAARGPankAvQHPnR4jsAR/IXmxlzSd3Ys=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hzdcomkhvNS6IVgTZBUODMvBLzHBFhE2QxOxLMdG1rdjZi0IJppeEyVB9TuRVAFga
	 foa9QUrE/BMdMxmfhDk9sZnY+345g0Jm46qaHU1Ff7tI5Y56KGta7E+zcAJCkYByQe
	 eAF1BMs5O9xcVqXnzwhbrG7OJXFc2XkpNjJVMZVZssK5cO6xYulGu2//MVQU5jb+xL
	 pVgajCD4HSO107GDs9EmuiI8RCAv6MA8IhaygqFb0kwiO9Td3xZUo/jL3vzUm6g035
	 20+bMgJ/mJ/LUGSLcL2Y/mS2x+cj6sB0iLZabQ7kFnDcTftQqGO/Xtv2VSwt6K9NIV
	 KrVv9GAI4ULCw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mathias Nyman <mathias.nyman@linux.intel.com>,
	Kuangyi Chiang <ki.chiang65@gmail.com>,
	Michal Pecio <michal.pecio@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	mathias.nyman@intel.com,
	linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 15/31] xhci: Handle spurious events on Etron host isoc enpoints
Date: Mon,  7 Apr 2025 14:10:31 -0400
Message-Id: <20250407181054.3177479-15-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250407181054.3177479-1-sashal@kernel.org>
References: <20250407181054.3177479-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.1
Content-Transfer-Encoding: 8bit

From: Mathias Nyman <mathias.nyman@linux.intel.com>

[ Upstream commit b331a3d8097fad4e541d212684192f21fedbd6e5 ]

Unplugging a USB3.0 webcam from Etron hosts while streaming results
in errors like this:

[ 2.646387] xhci_hcd 0000:03:00.0: ERROR Transfer event TRB DMA ptr not part of current TD ep_index 18 comp_code 13
[ 2.646446] xhci_hcd 0000:03:00.0: Looking for event-dma 000000002fdf8630 trb-start 000000002fdf8640 trb-end 000000002fdf8650
[ 2.646560] xhci_hcd 0000:03:00.0: ERROR Transfer event TRB DMA ptr not part of current TD ep_index 18 comp_code 13
[ 2.646568] xhci_hcd 0000:03:00.0: Looking for event-dma 000000002fdf8660 trb-start 000000002fdf8670 trb-end 000000002fdf8670

Etron xHC generates two transfer events for the TRB if an error is
detected while processing the last TRB of an isoc TD.

The first event can be any sort of error (like USB Transaction or
Babble Detected, etc), and the final event is Success.

The xHCI driver will handle the TD after the first event and remove it
from its internal list, and then print an "Transfer event TRB DMA ptr
not part of current TD" error message after the final event.

Commit 5372c65e1311 ("xhci: process isoc TD properly when there was a
transaction error mid TD.") is designed to address isoc transaction
errors, but unfortunately it doesn't account for this scenario.

This issue is similar to the XHCI_SPURIOUS_SUCCESS case where a success
event follows a 'short transfer' event, but the TD the event points to
is already given back.

Expand the spurious success 'short transfer' event handling to cover
the spurious success after error on Etron hosts.

Kuangyi Chiang reported this issue and submitted a different solution
based on using error_mid_td. This commit message is mostly taken
from that patch.

Reported-by: Kuangyi Chiang <ki.chiang65@gmail.com>
Closes: https://lore.kernel.org/linux-usb/20241028025337.6372-6-ki.chiang65@gmail.com/
Tested-by: Kuangyi Chiang <ki.chiang65@gmail.com>
Tested-by: Michal Pecio <michal.pecio@gmail.com>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Link: https://lore.kernel.org/r/20250306144954.3507700-16-mathias.nyman@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/host/xhci-ring.c | 38 ++++++++++++++++++++++++------------
 drivers/usb/host/xhci.h      |  2 +-
 2 files changed, 27 insertions(+), 13 deletions(-)

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 26d95d3c80b0a..d3dd1ecaf6208 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -2644,6 +2644,22 @@ static int handle_transferless_tx_event(struct xhci_hcd *xhci, struct xhci_virt_
 	return 0;
 }
 
+static bool xhci_spurious_success_tx_event(struct xhci_hcd *xhci,
+					   struct xhci_ring *ring)
+{
+	switch (ring->old_trb_comp_code) {
+	case COMP_SHORT_PACKET:
+		return xhci->quirks & XHCI_SPURIOUS_SUCCESS;
+	case COMP_USB_TRANSACTION_ERROR:
+	case COMP_BABBLE_DETECTED_ERROR:
+	case COMP_ISOCH_BUFFER_OVERRUN:
+		return xhci->quirks & XHCI_ETRON_HOST &&
+			ring->type == TYPE_ISOC;
+	default:
+		return false;
+	}
+}
+
 /*
  * If this function returns an error condition, it means it got a Transfer
  * event with a corrupted Slot ID, Endpoint ID, or TRB DMA address.
@@ -2698,8 +2714,8 @@ static int handle_tx_event(struct xhci_hcd *xhci,
 	case COMP_SUCCESS:
 		if (EVENT_TRB_LEN(le32_to_cpu(event->transfer_len)) != 0) {
 			trb_comp_code = COMP_SHORT_PACKET;
-			xhci_dbg(xhci, "Successful completion on short TX for slot %u ep %u with last td short %d\n",
-				 slot_id, ep_index, ep_ring->last_td_was_short);
+			xhci_dbg(xhci, "Successful completion on short TX for slot %u ep %u with last td comp code %d\n",
+				 slot_id, ep_index, ep_ring->old_trb_comp_code);
 		}
 		break;
 	case COMP_SHORT_PACKET:
@@ -2850,7 +2866,7 @@ static int handle_tx_event(struct xhci_hcd *xhci,
 		if (trb_comp_code != COMP_STOPPED &&
 		    trb_comp_code != COMP_STOPPED_LENGTH_INVALID &&
 		    !ring_xrun_event &&
-		    !ep_ring->last_td_was_short) {
+		    !xhci_spurious_success_tx_event(xhci, ep_ring)) {
 			xhci_warn(xhci, "Event TRB for slot %u ep %u with no TDs queued\n",
 				  slot_id, ep_index);
 		}
@@ -2898,11 +2914,12 @@ static int handle_tx_event(struct xhci_hcd *xhci,
 
 			/*
 			 * Some hosts give a spurious success event after a short
-			 * transfer. Ignore it.
+			 * transfer or error on last TRB. Ignore it.
 			 */
-			if ((xhci->quirks & XHCI_SPURIOUS_SUCCESS) &&
-			    ep_ring->last_td_was_short) {
-				ep_ring->last_td_was_short = false;
+			if (xhci_spurious_success_tx_event(xhci, ep_ring)) {
+				xhci_dbg(xhci, "Spurious event dma %pad, comp_code %u after %u\n",
+					 &ep_trb_dma, trb_comp_code, ep_ring->old_trb_comp_code);
+				ep_ring->old_trb_comp_code = trb_comp_code;
 				return 0;
 			}
 
@@ -2930,15 +2947,12 @@ static int handle_tx_event(struct xhci_hcd *xhci,
 	 */
 	} while (ep->skip);
 
+	ep_ring->old_trb_comp_code = trb_comp_code;
+
 	/* Get out if a TD was queued at enqueue after the xrun occurred */
 	if (ring_xrun_event)
 		return 0;
 
-	if (trb_comp_code == COMP_SHORT_PACKET)
-		ep_ring->last_td_was_short = true;
-	else
-		ep_ring->last_td_was_short = false;
-
 	ep_trb = &ep_seg->trbs[(ep_trb_dma - ep_seg->dma) / sizeof(*ep_trb)];
 	trace_xhci_handle_transfer(ep_ring, (struct xhci_generic_trb *) ep_trb, ep_trb_dma);
 
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index 779b01dee068f..b7109e5ec93db 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1371,7 +1371,7 @@ struct xhci_ring {
 	unsigned int		num_trbs_free; /* used only by xhci DbC */
 	unsigned int		bounce_buf_len;
 	enum xhci_ring_type	type;
-	bool			last_td_was_short;
+	u32			old_trb_comp_code;
 	struct radix_tree_root	*trb_address_map;
 };
 
-- 
2.39.5


