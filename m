Return-Path: <stable+bounces-15814-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D40D683C683
	for <lists+stable@lfdr.de>; Thu, 25 Jan 2024 16:26:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04427B21F4A
	for <lists+stable@lfdr.de>; Thu, 25 Jan 2024 15:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35CEB73176;
	Thu, 25 Jan 2024 15:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UQq4lMVl"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72B073171;
	Thu, 25 Jan 2024 15:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706196377; cv=none; b=ofbhXsrq7GAFBaikyRZauH1V9/NonH6F3xeRZcOFDY9wkDBf847+KRdJBHBWCjX+ePJBCJGHPi20Sxz+EXrFJOvq9ZGV94t9BVdjc6KeWEoYQebWttO2FF9xnhjXOkfcWvHkvIRhE/+fuoh2Q1F5ZAkmHSWNI526Fn8kECy8pTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706196377; c=relaxed/simple;
	bh=T6uBCKYEgzrQLc6KKBjDCx5r0prG5DgNIGrjEuNhl0o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TGSAtiPt+atrx6dzkZOLOtVFW2cT+Ar5lXaX1IHDX6WfSkzRUKuMzsKyEfaHSNz5MrzlGkJxReiGPIpVcrAN4KFIkGycMF/nQIJ+66elVFdKs8hana2IEJrmsgC8t7QWLfHTWB2UZy4s825n38p77SS65LiT6m+/eaJ5FeXGmOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UQq4lMVl; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706196375; x=1737732375;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=T6uBCKYEgzrQLc6KKBjDCx5r0prG5DgNIGrjEuNhl0o=;
  b=UQq4lMVl+piCi0layQJJELIW6MrqfHSeGsKDa8lg6T9YQbRdWYYj0QrE
   CJkAz11l2JnUlGWi3CrITnYABsWc1SchJ0vtgjVYinb8UAtG9jpnS1Wuc
   /l9eTPj+xiaYBI/8h7tUjkjddWe8/j1r3o2bFpTQP3XjlBuLY/zbMwt1H
   pJSRqu9sjkHZ2VzJ7wYshBLA5tdebcU1gjYYNjhWRDHQyvc+UiwGqLeea
   RY5C14xoAHm7HwpvEOpmPVOscU9I6/5I2+BS7mejVxRRAJMQI1pG7pgZb
   mjEKStfIRkRXdD7SufsuNMEjTrk+H1jSKkWYbZaLCjtYJU0TK/Fa7YRqS
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="23651358"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="23651358"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 07:26:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="857099929"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="857099929"
Received: from mattu-haswell.fi.intel.com ([10.237.72.199])
  by fmsmga004.fm.intel.com with ESMTP; 25 Jan 2024 07:26:12 -0800
From: Mathias Nyman <mathias.nyman@linux.intel.com>
To: <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org,
	Mathias Nyman <mathias.nyman@linux.intel.com>,
	=?UTF-8?q?Micha=C5=82=20Pecio?= <michal.pecio@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 3/4] xhci: process isoc TD properly when there was a transaction error mid TD.
Date: Thu, 25 Jan 2024 17:27:36 +0200
Message-Id: <20240125152737.2983959-4-mathias.nyman@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240125152737.2983959-1-mathias.nyman@linux.intel.com>
References: <20240125152737.2983959-1-mathias.nyman@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The last TRB of a isoc TD might not trigger an event if there was
an error event for a TRB mid TD. This is seen on a NEC Corporation
uPD720200 USB 3.0 Host

After an error mid a multi-TRB TD the xHC should according to xhci 4.9.1
generate events for passed TRBs with IOC flag set if it proceeds to the
next TD. This event is either a copy of the original error, or a
"success" transfer event.

If that event is missing then the driver and xHC host get out of sync as
the driver is still expecting a transfer event for that first TD, while
xHC host is already sending events for the next TD in the list.
This leads to
"Transfer event TRB DMA ptr not part of current TD" messages.

As a solution we tag the isoc TDs that get error events mid TD.
If an event doesn't match the first TD, then check if the tag is
set, and event points to the next TD.
In that case give back the fist TD and process the next TD normally

Make sure TD status and transferred length stay valid in both cases
with and without final TD completion event.

Reported-by: Michał Pecio <michal.pecio@gmail.com>
Closes: https://lore.kernel.org/linux-usb/20240112235205.1259f60c@foxbook/
Tested-by: Michał Pecio <michal.pecio@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
---
 drivers/usb/host/xhci-ring.c | 74 +++++++++++++++++++++++++++++-------
 drivers/usb/host/xhci.h      |  1 +
 2 files changed, 61 insertions(+), 14 deletions(-)

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 33806ae966f9..41be7d31a36e 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -2376,6 +2376,9 @@ static int process_isoc_td(struct xhci_hcd *xhci, struct xhci_virt_ep *ep,
 	/* handle completion code */
 	switch (trb_comp_code) {
 	case COMP_SUCCESS:
+		/* Don't overwrite status if TD had an error, see xHCI 4.9.1 */
+		if (td->error_mid_td)
+			break;
 		if (remaining) {
 			frame->status = short_framestatus;
 			if (xhci->quirks & XHCI_TRUST_TX_LENGTH)
@@ -2401,8 +2404,9 @@ static int process_isoc_td(struct xhci_hcd *xhci, struct xhci_virt_ep *ep,
 		break;
 	case COMP_USB_TRANSACTION_ERROR:
 		frame->status = -EPROTO;
+		sum_trbs_for_length = true;
 		if (ep_trb != td->last_trb)
-			return 0;
+			td->error_mid_td = true;
 		break;
 	case COMP_STOPPED:
 		sum_trbs_for_length = true;
@@ -2422,6 +2426,9 @@ static int process_isoc_td(struct xhci_hcd *xhci, struct xhci_virt_ep *ep,
 		break;
 	}
 
+	if (td->urb_length_set)
+		goto finish_td;
+
 	if (sum_trbs_for_length)
 		frame->actual_length = sum_trb_lengths(xhci, ep->ring, ep_trb) +
 			ep_trb_len - remaining;
@@ -2430,6 +2437,14 @@ static int process_isoc_td(struct xhci_hcd *xhci, struct xhci_virt_ep *ep,
 
 	td->urb->actual_length += frame->actual_length;
 
+finish_td:
+	/* Don't give back TD yet if we encountered an error mid TD */
+	if (td->error_mid_td && ep_trb != td->last_trb) {
+		xhci_dbg(xhci, "Error mid isoc TD, wait for final completion event\n");
+		td->urb_length_set = true;
+		return 0;
+	}
+
 	return finish_td(xhci, ep, ep_ring, td, trb_comp_code);
 }
 
@@ -2808,17 +2823,51 @@ static int handle_tx_event(struct xhci_hcd *xhci,
 		}
 
 		if (!ep_seg) {
-			if (!ep->skip ||
-			    !usb_endpoint_xfer_isoc(&td->urb->ep->desc)) {
-				/* Some host controllers give a spurious
-				 * successful event after a short transfer.
-				 * Ignore it.
-				 */
-				if ((xhci->quirks & XHCI_SPURIOUS_SUCCESS) &&
-						ep_ring->last_td_was_short) {
-					ep_ring->last_td_was_short = false;
-					goto cleanup;
+
+			if (ep->skip && usb_endpoint_xfer_isoc(&td->urb->ep->desc)) {
+				skip_isoc_td(xhci, td, ep, status);
+				goto cleanup;
+			}
+
+			/*
+			 * Some hosts give a spurious success event after a short
+			 * transfer. Ignore it.
+			 */
+			if ((xhci->quirks & XHCI_SPURIOUS_SUCCESS) &&
+			    ep_ring->last_td_was_short) {
+				ep_ring->last_td_was_short = false;
+				goto cleanup;
+			}
+
+			/*
+			 * xhci 4.10.2 states isoc endpoints should continue
+			 * processing the next TD if there was an error mid TD.
+			 * So host like NEC don't generate an event for the last
+			 * isoc TRB even if the IOC flag is set.
+			 * xhci 4.9.1 states that if there are errors in mult-TRB
+			 * TDs xHC should generate an error for that TRB, and if xHC
+			 * proceeds to the next TD it should genete an event for
+			 * any TRB with IOC flag on the way. Other host follow this.
+			 * So this event might be for the next TD.
+			 */
+			if (td->error_mid_td &&
+			    !list_is_last(&td->td_list, &ep_ring->td_list)) {
+				struct xhci_td *td_next = list_next_entry(td, td_list);
+
+				ep_seg = trb_in_td(xhci, td_next->start_seg, td_next->first_trb,
+						   td_next->last_trb, ep_trb_dma, false);
+				if (ep_seg) {
+					/* give back previous TD, start handling new */
+					xhci_dbg(xhci, "Missing TD completion event after mid TD error\n");
+					ep_ring->dequeue = td->last_trb;
+					ep_ring->deq_seg = td->last_trb_seg;
+					inc_deq(xhci, ep_ring);
+					xhci_td_cleanup(xhci, td, ep_ring, td->status);
+					td = td_next;
 				}
+			}
+
+			if (!ep_seg) {
 				/* HC is busted, give up! */
 				xhci_err(xhci,
 					"ERROR Transfer event TRB DMA ptr not "
@@ -2830,9 +2879,6 @@ static int handle_tx_event(struct xhci_hcd *xhci,
 					  ep_trb_dma, true);
 				return -ESHUTDOWN;
 			}
-
-			skip_isoc_td(xhci, td, ep, status);
-			goto cleanup;
 		}
 		if (trb_comp_code == COMP_SHORT_PACKET)
 			ep_ring->last_td_was_short = true;
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index a5c72a634e6a..6f82d404883f 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1549,6 +1549,7 @@ struct xhci_td {
 	struct xhci_segment	*bounce_seg;
 	/* actual_length of the URB has already been set */
 	bool			urb_length_set;
+	bool			error_mid_td;
 	unsigned int		num_trbs;
 };
 
-- 
2.25.1


