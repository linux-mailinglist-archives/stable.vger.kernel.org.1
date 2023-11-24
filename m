Return-Path: <stable+bounces-1938-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1C0C7F8211
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 20:04:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E00BB23029
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BF7F364B7;
	Fri, 24 Nov 2023 19:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="arRyMxib"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2044E2C85B;
	Fri, 24 Nov 2023 19:04:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F0CDC433C8;
	Fri, 24 Nov 2023 19:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700852645;
	bh=Zub3oEnmoVZwX0IkcvHfikrYLYv7Vy0VaUdjVf/BBVE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=arRyMxibbeexuKkLug2dujh5s8DXtsY7vdeaZUrVQCrKxj7gRZUbZFaem2i5XdBea
	 PPgK2JaliOYiL3xLVLC4wQ8y56X8R/n240qfmHw5vmy0OqcnWWA8OyhtDiepFXKLzG
	 /njyb75PFpywvezc9cG24XxS3omwKPBwn1rSNaT4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mathias Nyman <mathias.nyman@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 059/193] xhci: turn cancelled td cleanup to its own function
Date: Fri, 24 Nov 2023 17:53:06 +0000
Message-ID: <20231124171949.616149759@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124171947.127438872@linuxfoundation.org>
References: <20231124171947.127438872@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mathias Nyman <mathias.nyman@linux.intel.com>

[ Upstream commit 4db356924a50f72a00834ae04f11202d9703faeb ]

Refactor handler for stop endpoint command completion. Yank out the part
that invalidates cancelled TDs and turn it into a separate function.

Invalidating cancelled TDs should be done while the ring is stopped,
but not exclusively in the stop endpoint command completeion handler.

We will need to invalidate TDs after resetting endpoints as well.

Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Link: https://lore.kernel.org/r/20210129130044.206855-20-mathias.nyman@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: a5f928db5951 ("usb: host: xhci-plat: fix possible kernel oops while resuming")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/host/xhci-ring.c | 108 +++++++++++++++++------------------
 1 file changed, 53 insertions(+), 55 deletions(-)

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 5ee095a5d38aa..eb70f07e3623a 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -868,6 +868,58 @@ static void xhci_handle_halted_endpoint(struct xhci_hcd *xhci,
 	xhci_ring_cmd_db(xhci);
 }
 
+/*
+ * Fix up the ep ring first, so HW stops executing cancelled TDs.
+ * We have the xHCI lock, so nothing can modify this list until we drop it.
+ * We're also in the event handler, so we can't get re-interrupted if another
+ * Stop Endpoint command completes.
+ */
+
+static int xhci_invalidate_cancelled_tds(struct xhci_virt_ep *ep,
+					 struct xhci_dequeue_state *deq_state)
+{
+	struct xhci_hcd		*xhci;
+	struct xhci_td		*td = NULL;
+	struct xhci_td		*tmp_td = NULL;
+	struct xhci_ring	*ring;
+	u64			hw_deq;
+
+	xhci = ep->xhci;
+
+	list_for_each_entry_safe(td, tmp_td, &ep->cancelled_td_list, cancelled_td_list) {
+		xhci_dbg_trace(xhci, trace_xhci_dbg_cancel_urb,
+				"Removing canceled TD starting at 0x%llx (dma).",
+				(unsigned long long)xhci_trb_virt_to_dma(
+					td->start_seg, td->first_trb));
+		list_del_init(&td->td_list);
+		ring = xhci_urb_to_transfer_ring(xhci, td->urb);
+		if (!ring) {
+			xhci_warn(xhci, "WARN Cancelled URB %p has invalid stream ID %u.\n",
+				  td->urb, td->urb->stream_id);
+			continue;
+		}
+		/*
+		 * If ring stopped on the TD we need to cancel, then we have to
+		 * move the xHC endpoint ring dequeue pointer past this TD.
+		 */
+		hw_deq = xhci_get_hw_deq(xhci, ep->vdev, ep->ep_index,
+					 td->urb->stream_id);
+		hw_deq &= ~0xf;
+
+		if (trb_in_td(xhci, td->start_seg, td->first_trb,
+			      td->last_trb, hw_deq, false)) {
+			xhci_find_new_dequeue_state(xhci, ep->vdev->slot_id,
+						    ep->ep_index,
+						    td->urb->stream_id,
+						    td, deq_state);
+		} else {
+			td_to_noop(xhci, ring, td, false);
+		}
+
+	}
+	return 0;
+}
+
 /*
  * When we get a command completion for a Stop Endpoint Command, we need to
  * unlink any cancelled TDs from the ring.  There are two ways to do that:
@@ -888,7 +940,6 @@ static void xhci_handle_cmd_stop_ep(struct xhci_hcd *xhci, int slot_id,
 	struct xhci_td *last_unlinked_td;
 	struct xhci_ep_ctx *ep_ctx;
 	struct xhci_virt_device *vdev;
-	u64 hw_deq;
 	struct xhci_dequeue_state deq_state;
 
 	if (unlikely(TRB_TO_SUSPEND_PORT(le32_to_cpu(trb->generic.field[3])))) {
@@ -919,60 +970,7 @@ static void xhci_handle_cmd_stop_ep(struct xhci_hcd *xhci, int slot_id,
 		return;
 	}
 
-	/* Fix up the ep ring first, so HW stops executing cancelled TDs.
-	 * We have the xHCI lock, so nothing can modify this list until we drop
-	 * it.  We're also in the event handler, so we can't get re-interrupted
-	 * if another Stop Endpoint command completes
-	 */
-	list_for_each_entry(cur_td, &ep->cancelled_td_list, cancelled_td_list) {
-		xhci_dbg_trace(xhci, trace_xhci_dbg_cancel_urb,
-				"Removing canceled TD starting at 0x%llx (dma).",
-				(unsigned long long)xhci_trb_virt_to_dma(
-					cur_td->start_seg, cur_td->first_trb));
-		ep_ring = xhci_urb_to_transfer_ring(xhci, cur_td->urb);
-		if (!ep_ring) {
-			/* This shouldn't happen unless a driver is mucking
-			 * with the stream ID after submission.  This will
-			 * leave the TD on the hardware ring, and the hardware
-			 * will try to execute it, and may access a buffer
-			 * that has already been freed.  In the best case, the
-			 * hardware will execute it, and the event handler will
-			 * ignore the completion event for that TD, since it was
-			 * removed from the td_list for that endpoint.  In
-			 * short, don't muck with the stream ID after
-			 * submission.
-			 */
-			xhci_warn(xhci, "WARN Cancelled URB %p "
-					"has invalid stream ID %u.\n",
-					cur_td->urb,
-					cur_td->urb->stream_id);
-			goto remove_finished_td;
-		}
-		/*
-		 * If we stopped on the TD we need to cancel, then we have to
-		 * move the xHC endpoint ring dequeue pointer past this TD.
-		 */
-		hw_deq = xhci_get_hw_deq(xhci, vdev, ep_index,
-					 cur_td->urb->stream_id);
-		hw_deq &= ~0xf;
-
-		if (trb_in_td(xhci, cur_td->start_seg, cur_td->first_trb,
-			      cur_td->last_trb, hw_deq, false)) {
-			xhci_find_new_dequeue_state(xhci, slot_id, ep_index,
-						    cur_td->urb->stream_id,
-						    cur_td, &deq_state);
-		} else {
-			td_to_noop(xhci, ep_ring, cur_td, false);
-		}
-
-remove_finished_td:
-		/*
-		 * The event handler won't see a completion for this TD anymore,
-		 * so remove it from the endpoint ring's TD list.  Keep it in
-		 * the cancelled TD list for URB completion later.
-		 */
-		list_del_init(&cur_td->td_list);
-	}
+	xhci_invalidate_cancelled_tds(ep, &deq_state);
 
 	xhci_stop_watchdog_timer_in_irq(xhci, ep);
 
-- 
2.42.0




