Return-Path: <stable+bounces-50153-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2607F903B63
	for <lists+stable@lfdr.de>; Tue, 11 Jun 2024 14:04:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FD161F23EDA
	for <lists+stable@lfdr.de>; Tue, 11 Jun 2024 12:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BCE417BB34;
	Tue, 11 Jun 2024 12:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L40SV94K"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941AC17BB28;
	Tue, 11 Jun 2024 12:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718107476; cv=none; b=FLN5acvmJmjbXfdQbubViTKJYA//R3dftTAmaMeIMPqQMpyLHjNcDRcUi4bTEcXKCMpC5JfW44q4vMqlKJ96VVm4Fa7BS0xTybipotm3q3UiWDXTVnSZa6mCGqjJ5GqI2POegvF/KXXCTQWUg+aRr+rP3oS9K9WKMCkOso8Zrj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718107476; c=relaxed/simple;
	bh=ne7wuQL9I2SgZ6QG3Rspi4VyIajsSMl3qDn2zbrMZ8k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dZTqbO2FLHNkuOHf359uVpx5MpEf2DeXANVHSlk1kzhFA0lWZxi4iOr5cUs8Gqon3K30MxSJLPSeTjU49KmnJSOwjiBs54QqHehl+CYsSRj4HlaokOhv8C6OqeJeAaezCbxXFjwmYgzefAdVhVAPU8QVjsKtryXqtxMpc58yWyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L40SV94K; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718107474; x=1749643474;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ne7wuQL9I2SgZ6QG3Rspi4VyIajsSMl3qDn2zbrMZ8k=;
  b=L40SV94KSK4y03toeH4q6l5eU3hSe8jF4wM3v9y6UhVY/2+LIKLLZEbJ
   QaEdq03v5v60FleyKwa/AUqiUQBeWLrP0d4NlEChxeJ/agkatUtJ9H3DP
   iLwqox2Q9D++CcUPSI4EOE+QmwarUhKccBEXHDo0mKi1BwF5DuMaCWwdt
   tcJz2WocG9Cyp2lcq/pBMgEzL/XuCAnhaF1tfkms6yEBGpzlwcEV38OdI
   wjEMfcUR2mjAxrZxq4EAjUuAKRU+Tpy4RLP1AgxcXri6kgXyr/wN+/o2I
   QxdkMm4C1Wb5/RZTRvaY9S4Bw7rnz/krShStQsPUCoqkMKMhNkQunSdVZ
   w==;
X-CSE-ConnectionGUID: E1e3YLgnQkytLAWUIWHTAA==
X-CSE-MsgGUID: ybMhcltvTbWiol7GxskG2g==
X-IronPort-AV: E=McAfee;i="6600,9927,11099"; a="18641764"
X-IronPort-AV: E=Sophos;i="6.08,230,1712646000"; 
   d="scan'208";a="18641764"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2024 05:04:34 -0700
X-CSE-ConnectionGUID: 3boQbHSkT9GMRlH+g6zM/w==
X-CSE-MsgGUID: N4SZk4ITQY2pQBGGcp3TmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,230,1712646000"; 
   d="scan'208";a="76879670"
Received: from mattu-haswell.fi.intel.com ([10.237.72.199])
  by orviesa001.jf.intel.com with ESMTP; 11 Jun 2024 05:04:33 -0700
From: Mathias Nyman <mathias.nyman@linux.intel.com>
To: <gregkh@linuxfoundation.org>
Cc: <linux-usb@vger.kernel.org>,
	Hector Martin <marcan@marcan.st>,
	stable@vger.kernel.org,
	security@kernel.org,
	Neal Gompa <neal@gompa.dev>,
	Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: [PATCH 4/4] xhci: Handle TD clearing for multiple streams case
Date: Tue, 11 Jun 2024 15:06:10 +0300
Message-Id: <20240611120610.3264502-5-mathias.nyman@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240611120610.3264502-1-mathias.nyman@linux.intel.com>
References: <20240611120610.3264502-1-mathias.nyman@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hector Martin <marcan@marcan.st>

When multiple streams are in use, multiple TDs might be in flight when
an endpoint is stopped. We need to issue a Set TR Dequeue Pointer for
each, to ensure everything is reset properly and the caches cleared.
Change the logic so that any N>1 TDs found active for different streams
are deferred until after the first one is processed, calling
xhci_invalidate_cancelled_tds() again from xhci_handle_cmd_set_deq() to
queue another command until we are done with all of them. Also change
the error/"should never happen" paths to ensure we at least clear any
affected TDs, even if we can't issue a command to clear the hardware
cache, and complain loudly with an xhci_warn() if this ever happens.

This problem case dates back to commit e9df17eb1408 ("USB: xhci: Correct
assumptions about number of rings per endpoint.") early on in the XHCI
driver's life, when stream support was first added.
It was then identified but not fixed nor made into a warning in commit
674f8438c121 ("xhci: split handling halted endpoints into two steps"),
which added a FIXME comment for the problem case (without materially
changing the behavior as far as I can tell, though the new logic made
the problem more obvious).

Then later, in commit 94f339147fc3 ("xhci: Fix failure to give back some
cached cancelled URBs."), it was acknowledged again.

[Mathias: commit 94f339147fc3 ("xhci: Fix failure to give back some cached
cancelled URBs.") was a targeted regression fix to the previously mentioned
patch. Users reported issues with usb stuck after unmounting/disconnecting
UAS devices. This rolled back the TD clearing of multiple streams to its
original state.]

Apparently the commit author was aware of the problem (yet still chose
to submit it): It was still mentioned as a FIXME, an xhci_dbg() was
added to log the problem condition, and the remaining issue was mentioned
in the commit description. The choice of making the log type xhci_dbg()
for what is, at this point, a completely unhandled and known broken
condition is puzzling and unfortunate, as it guarantees that no actual
users would see the log in production, thereby making it nigh
undebuggable (indeed, even if you turn on DEBUG, the message doesn't
really hint at there being a problem at all).

It took me *months* of random xHC crashes to finally find a reliable
repro and be able to do a deep dive debug session, which could all have
been avoided had this unhandled, broken condition been actually reported
with a warning, as it should have been as a bug intentionally left in
unfixed (never mind that it shouldn't have been left in at all).

> Another fix to solve clearing the caches of all stream rings with
> cancelled TDs is needed, but not as urgent.

3 years after that statement and 14 years after the original bug was
introduced, I think it's finally time to fix it. And maybe next time
let's not leave bugs unfixed (that are actually worse than the original
bug), and let's actually get people to review kernel commits please.

Fixes xHC crashes and IOMMU faults with UAS devices when handling
errors/faults. Easiest repro is to use `hdparm` to mark an early sector
(e.g. 1024) on a disk as bad, then `cat /dev/sdX > /dev/null` in a loop.
At least in the case of JMicron controllers, the read errors end up
having to cancel two TDs (for two queued requests to different streams)
and the one that didn't get cleared properly ends up faulting the xHC
entirely when it tries to access DMA pages that have since been unmapped,
referred to by the stale TDs. This normally happens quickly (after two
or three loops). After this fix, I left the `cat` in a loop running
overnight and experienced no xHC failures, with all read errors
recovered properly. Repro'd and tested on an Apple M1 Mac Mini
(dwc3 host).

On systems without an IOMMU, this bug would instead silently corrupt
freed memory, making this a security bug (even on systems with IOMMUs
this could silently corrupt memory belonging to other USB devices on the
same controller, so it's still a security bug). Given that the kernel
autoprobes partition tables, I'm pretty sure a malicious USB device
pretending to be a UAS device and reporting an error with the right
timing could deliberately trigger a UAF and write to freed memory, with
no user action.

[Mathias: Commit message and code comment edit, original at:]
https://lore.kernel.org/linux-usb/20240524-xhci-streams-v1-1-6b1f13819bea@marcan.st/

Fixes: e9df17eb1408 ("USB: xhci: Correct assumptions about number of rings per endpoint.")
Fixes: 94f339147fc3 ("xhci: Fix failure to give back some cached cancelled URBs.")
Fixes: 674f8438c121 ("xhci: split handling halted endpoints into two steps")
Cc: stable@vger.kernel.org
Cc: security@kernel.org
Reviewed-by: Neal Gompa <neal@gompa.dev>
Signed-off-by: Hector Martin <marcan@marcan.st>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
---
 drivers/usb/host/xhci-ring.c | 54 ++++++++++++++++++++++++++++--------
 drivers/usb/host/xhci.h      |  1 +
 2 files changed, 44 insertions(+), 11 deletions(-)

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 1db61bb2b9b5..fd0cde3d1569 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -1031,13 +1031,27 @@ static int xhci_invalidate_cancelled_tds(struct xhci_virt_ep *ep)
 				break;
 			case TD_DIRTY: /* TD is cached, clear it */
 			case TD_HALTED:
+			case TD_CLEARING_CACHE_DEFERRED:
+				if (cached_td) {
+					if (cached_td->urb->stream_id != td->urb->stream_id) {
+						/* Multiple streams case, defer move dq */
+						xhci_dbg(xhci,
+							 "Move dq deferred: stream %u URB %p\n",
+							 td->urb->stream_id, td->urb);
+						td->cancel_status = TD_CLEARING_CACHE_DEFERRED;
+						break;
+					}
+
+					/* Should never happen, but clear the TD if it does */
+					xhci_warn(xhci,
+						  "Found multiple active URBs %p and %p in stream %u?\n",
+						  td->urb, cached_td->urb,
+						  td->urb->stream_id);
+					td_to_noop(xhci, ring, cached_td, false);
+					cached_td->cancel_status = TD_CLEARED;
+				}
+
 				td->cancel_status = TD_CLEARING_CACHE;
-				if (cached_td)
-					/* FIXME  stream case, several stopped rings */
-					xhci_dbg(xhci,
-						 "Move dq past stream %u URB %p instead of stream %u URB %p\n",
-						 td->urb->stream_id, td->urb,
-						 cached_td->urb->stream_id, cached_td->urb);
 				cached_td = td;
 				break;
 			}
@@ -1057,10 +1071,16 @@ static int xhci_invalidate_cancelled_tds(struct xhci_virt_ep *ep)
 	if (err) {
 		/* Failed to move past cached td, just set cached TDs to no-op */
 		list_for_each_entry_safe(td, tmp_td, &ep->cancelled_td_list, cancelled_td_list) {
-			if (td->cancel_status != TD_CLEARING_CACHE)
+			/*
+			 * Deferred TDs need to have the deq pointer set after the above command
+			 * completes, so if that failed we just give up on all of them (and
+			 * complain loudly since this could cause issues due to caching).
+			 */
+			if (td->cancel_status != TD_CLEARING_CACHE &&
+			    td->cancel_status != TD_CLEARING_CACHE_DEFERRED)
 				continue;
-			xhci_dbg(xhci, "Failed to clear cancelled cached URB %p, mark clear anyway\n",
-				 td->urb);
+			xhci_warn(xhci, "Failed to clear cancelled cached URB %p, mark clear anyway\n",
+				  td->urb);
 			td_to_noop(xhci, ring, td, false);
 			td->cancel_status = TD_CLEARED;
 		}
@@ -1346,6 +1366,7 @@ static void xhci_handle_cmd_set_deq(struct xhci_hcd *xhci, int slot_id,
 	struct xhci_ep_ctx *ep_ctx;
 	struct xhci_slot_ctx *slot_ctx;
 	struct xhci_td *td, *tmp_td;
+	bool deferred = false;
 
 	ep_index = TRB_TO_EP_INDEX(le32_to_cpu(trb->generic.field[3]));
 	stream_id = TRB_TO_STREAM_ID(le32_to_cpu(trb->generic.field[2]));
@@ -1432,6 +1453,8 @@ static void xhci_handle_cmd_set_deq(struct xhci_hcd *xhci, int slot_id,
 			xhci_dbg(ep->xhci, "%s: Giveback cancelled URB %p TD\n",
 				 __func__, td->urb);
 			xhci_td_cleanup(ep->xhci, td, ep_ring, td->status);
+		} else if (td->cancel_status == TD_CLEARING_CACHE_DEFERRED) {
+			deferred = true;
 		} else {
 			xhci_dbg(ep->xhci, "%s: Keep cancelled URB %p TD as cancel_status is %d\n",
 				 __func__, td->urb, td->cancel_status);
@@ -1441,8 +1464,17 @@ static void xhci_handle_cmd_set_deq(struct xhci_hcd *xhci, int slot_id,
 	ep->ep_state &= ~SET_DEQ_PENDING;
 	ep->queued_deq_seg = NULL;
 	ep->queued_deq_ptr = NULL;
-	/* Restart any rings with pending URBs */
-	ring_doorbell_for_active_rings(xhci, slot_id, ep_index);
+
+	if (deferred) {
+		/* We have more streams to clear */
+		xhci_dbg(ep->xhci, "%s: Pending TDs to clear, continuing with invalidation\n",
+			 __func__);
+		xhci_invalidate_cancelled_tds(ep);
+	} else {
+		/* Restart any rings with pending URBs */
+		xhci_dbg(ep->xhci, "%s: All TDs cleared, ring doorbell\n", __func__);
+		ring_doorbell_for_active_rings(xhci, slot_id, ep_index);
+	}
 }
 
 static void xhci_handle_cmd_reset_ep(struct xhci_hcd *xhci, int slot_id,
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index 30415158ed3c..78d014c4d884 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1276,6 +1276,7 @@ enum xhci_cancelled_td_status {
 	TD_DIRTY = 0,
 	TD_HALTED,
 	TD_CLEARING_CACHE,
+	TD_CLEARING_CACHE_DEFERRED,
 	TD_CLEARED,
 };
 
-- 
2.25.1


