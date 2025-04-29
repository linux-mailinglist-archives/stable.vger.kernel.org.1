Return-Path: <stable+bounces-138073-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6601DAA16C3
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 19:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEFD0984CF3
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 17:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEBB524E000;
	Tue, 29 Apr 2025 17:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Y/8FjeDq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1A324729E;
	Tue, 29 Apr 2025 17:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745948047; cv=none; b=uP9vHOz5qe/dTHPLCn5obw8Aema3HDzx3OOeSEVyGxIuCdQbS+TwZ2GkxelW23Ya/zItCdV4M52Mw/zllRLAswfAHqH6PWgO2KUQXs7hc2C3ZWuoydIjUOTrG3FjxlAE1Tsvhv4ruowe9R2CP0CftfUrHONR3ClZvXzSdczyGKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745948047; c=relaxed/simple;
	bh=3XHg6V3LmSnJQGekK/5z0LfvW8XW1up7CbuxEZgfS60=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GaA3Oz40x2NhLA1X1hbrkhUQT+1bafJb3TCNPZSbjbEvKCdTGRKTJnpXzFH4xwUPmKln1Vw5x+KcIw8mWJFpPy/VkGl2aM4TdpWl5byRWG0ngZuGuKlIPoHO7SvCJWQG4SE9XIfQC8R/62d8U2h3mT25z7tkaFjEfQxpDXRy7+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Y/8FjeDq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34350C4CEE3;
	Tue, 29 Apr 2025 17:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745948047;
	bh=3XHg6V3LmSnJQGekK/5z0LfvW8XW1up7CbuxEZgfS60=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y/8FjeDqDXoj5fdhoiTck5P7xcWYK5Gnh3t+7iK/krFWGnR9+RP1SHvZKNNqhNcIx
	 x41vYCK7LjnpmiIp3XN+FGO17Nsv4T93qjn2qC/m2GBDps8Mha8N59Yb8/TtcukJaB
	 Z55toQWIolOy52tcjEmORLDI7CMbu9spXZu072t4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kuangyi Chiang <ki.chiang65@gmail.com>,
	Michal Pecio <michal.pecio@gmail.com>,
	Mathias Nyman <mathias.nyman@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 178/280] xhci: Handle spurious events on Etron host isoc enpoints
Date: Tue, 29 Apr 2025 18:41:59 +0200
Message-ID: <20250429161122.390925659@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429161115.008747050@linuxfoundation.org>
References: <20250429161115.008747050@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index 6eb297b168fa4..653e24bb3e9ad 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -2642,6 +2642,22 @@ static int handle_transferless_tx_event(struct xhci_hcd *xhci, struct xhci_virt_
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
@@ -2696,8 +2712,8 @@ static int handle_tx_event(struct xhci_hcd *xhci,
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
@@ -2851,7 +2867,7 @@ static int handle_tx_event(struct xhci_hcd *xhci,
 		if (trb_comp_code != COMP_STOPPED &&
 		    trb_comp_code != COMP_STOPPED_LENGTH_INVALID &&
 		    !ring_xrun_event &&
-		    !ep_ring->last_td_was_short) {
+		    !xhci_spurious_success_tx_event(xhci, ep_ring)) {
 			xhci_warn(xhci, "Event TRB for slot %u ep %u with no TDs queued\n",
 				  slot_id, ep_index);
 		}
@@ -2903,11 +2919,12 @@ static int handle_tx_event(struct xhci_hcd *xhci,
 
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
 
@@ -2935,15 +2952,12 @@ static int handle_tx_event(struct xhci_hcd *xhci,
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
 	trace_xhci_handle_transfer(ep_ring, (struct xhci_generic_trb *) ep_trb);
 
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index 017a156953d72..2a954efa53e80 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1360,7 +1360,7 @@ struct xhci_ring {
 	unsigned int		num_trbs_free; /* used only by xhci DbC */
 	unsigned int		bounce_buf_len;
 	enum xhci_ring_type	type;
-	bool			last_td_was_short;
+	u32			old_trb_comp_code;
 	struct radix_tree_root	*trb_address_map;
 };
 
-- 
2.39.5




