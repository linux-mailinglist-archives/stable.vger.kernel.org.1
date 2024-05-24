Return-Path: <stable+bounces-46050-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 064B48CE429
	for <lists+stable@lfdr.de>; Fri, 24 May 2024 12:29:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 257271C21505
	for <lists+stable@lfdr.de>; Fri, 24 May 2024 10:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E7148529D;
	Fri, 24 May 2024 10:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marcan.st header.i=@marcan.st header.b="tPvi+eZt"
X-Original-To: stable@vger.kernel.org
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104D51AACC;
	Fri, 24 May 2024 10:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.63.210.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716546537; cv=none; b=KBDGd+xm+sLZ4rSERStRICCdlZyH0D18XQWazFkBW3WOYs5jIwTHSVQ4dPQPe10EzVR3xXhNn+M2IQ2MnCDyDV6yFQzjpUA2zKDDG9wNPyikqNszpOGJvth9V4pV+THi25V8TUWWYjeQRJdbz3GJUf+c9FY49FKZZer267lPMwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716546537; c=relaxed/simple;
	bh=pEUfJ7+mV2gms1M8RUY/bxsE4rbmpPheNfRQk1aw5xE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=QRbqLhc0toZHJsWnkolLgH4rFHaqS2dodmx+V1lDLFHk1geXj7Amn58qzZityrVkIzstifVkRtSmVoYodT1t0mxDIuWFgNBJsOYvz7hxgcnDk0QWYJRPc8CQFKqOZK/nMMSuNOKDPvWz+Hr/4r6wFOa3V5J5xYgSnsSwh76CSrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marcan.st; spf=pass smtp.mailfrom=marcan.st; dkim=pass (2048-bit key) header.d=marcan.st header.i=@marcan.st header.b=tPvi+eZt; arc=none smtp.client-ip=212.63.210.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marcan.st
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marcan.st
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sendonly@marcansoft.com)
	by mail.marcansoft.com (Postfix) with ESMTPSA id E7DD041A36;
	Fri, 24 May 2024 10:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
	t=1716546530; bh=pEUfJ7+mV2gms1M8RUY/bxsE4rbmpPheNfRQk1aw5xE=;
	h=From:Date:Subject:To:Cc;
	b=tPvi+eZtcjnKWcJD+fCUZj8Y+mJ9vPdpsiV27ns2EZSYvDavpUMes3I4SKJCRM80d
	 dfYJfzjayEdsQntw8rkrn5ElRUYmcQgKRh1nrfGzH1LIMx9BhlWLx2RHjkzYs/jkCK
	 qVZDMIjxecftblszLQTXsRZdDxh9zQuG8VIM+bpvdk50gavC2u4G15kFoYTYnSVl9p
	 0jBS+Qsj6cXPMXbvFLoJl4KAA35UFAQ3d9/TlOHxg/R8oZErKpXNA+tseJCSleW41M
	 DnswXleFVDu+fs0ox0wOXEndFv8k+6RkervP8KWM4gbScaPaka25hr65PfBQqZ72eh
	 IR7s+eKcq0NxQ==
From: Hector Martin <marcan@marcan.st>
Date: Fri, 24 May 2024 19:28:36 +0900
Subject: [PATCH] xhci: Handle TD clearing for multiple streams case
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240524-xhci-streams-v1-1-6b1f13819bea@marcan.st>
X-B4-Tracking: v=1; b=H4sIANNrUGYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDUyMT3YqM5Ezd4pKi1MTcYl1DI5NUC4uUJFOjVDMloJaCotS0zAqwcdG
 xtbUA1xUFeV4AAAA=
To: Mathias Nyman <mathias.nyman@intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 asahi@lists.linux.dev, stable@vger.kernel.org, security@kernel.org, 
 Hector Martin <marcan@marcan.st>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9781; i=marcan@marcan.st;
 h=from:subject:message-id; bh=pEUfJ7+mV2gms1M8RUY/bxsE4rbmpPheNfRQk1aw5xE=;
 b=owGbwMvMwCUm+yP4NEe/cRLjabUkhrSA7Hs1F6ZZ3LqT/iHS0PqZeslp2RtCGQtu/dow6WRYQ
 Nq9Ob/9O0pZGMS4GGTFFFkaT/Se6vacfk5dNWU6zBxWJpAhDFycAjCRa7wM/+wyVk5rP77d4PYK
 s1dmbjclDuXna9xWP18wKyXv2l53NyVGhpVp+lbNhV2f5F8f+dV9m3NpHstUhd2rL6j5yIrf9zf
 S4QMA
X-Developer-Key: i=marcan@marcan.st; a=openpgp;
 fpr=FC18F00317968B7BE86201CBE22A629A4C515DD5

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
driver's life, when stream support was first added. At that point, this
condition would cause TDs to not be given back at all, causing hanging
transfers - but no security bug. It was then identified but not fixed
nor made into a warning in commit 674f8438c121 ("xhci: split handling
halted endpoints into two steps"), which added a FIXME comment for the
problem case (without materially changing the behavior as far as I can
tell, though the new logic made the problem more obvious).

Then later, in commit 94f339147fc3 ("xhci: Fix failure to give back some
cached cancelled URBs."), it was acknowledged again. This commit was
unfortunately not reviewed at all, as it was authored by the maintainer
directly. Had it been, perhaps a second set of eyes would've noticed
that it does not fix the bug, but rather just makes it (much) worse.
It turns the "transfers hang" bug into a "random memory corruption" bug,
by blindly marking TDs as complete without actually clearing them at all
nor moving the dequeue pointer past them, which means they aren't actually
complete, and the xHC will try to transfer data to/from them when the
endpoint resumes, now to freed memory buffers.

This could have been a legitimate oversight, but apparently the commit
author was aware of the problem (yet still chose to submit it): It was
still mentioned as a FIXME, an xhci_dbg() was added to log the problem
condition, and the remaining issue was mentioned in the commit
description. The choice of making the log type xhci_dbg() for what is,
at this point, a completely unhandled and known broken condition is
puzzling and unfortunate, as it guarantees that no actual users would
see the log in production, thereby making it nigh undebuggable (indeed,
even if you turn on DEBUG, the message doesn't really hint at there
being a problem at all).

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

Fixes: e9df17eb1408 ("USB: xhci: Correct assumptions about number of rings per endpoint.")
Fixes: 94f339147fc3 ("xhci: Fix failure to give back some cached cancelled URBs.")
Fixes: 674f8438c121 ("xhci: split handling halted endpoints into two steps")
Cc: stable@vger.kernel.org
Cc: security@kernel.org
Signed-off-by: Hector Martin <marcan@marcan.st>
---
 drivers/usb/host/xhci-ring.c | 54 +++++++++++++++++++++++++++++++++++---------
 drivers/usb/host/xhci.h      |  1 +
 2 files changed, 44 insertions(+), 11 deletions(-)

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 575f0fd9c9f1..9c06502be098 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -1034,13 +1034,27 @@ static int xhci_invalidate_cancelled_tds(struct xhci_virt_ep *ep)
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
+					/* Should never happen, at least try to clear the TD if it does */
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
@@ -1060,10 +1074,16 @@ static int xhci_invalidate_cancelled_tds(struct xhci_virt_ep *ep)
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
@@ -1350,6 +1370,7 @@ static void xhci_handle_cmd_set_deq(struct xhci_hcd *xhci, int slot_id,
 	struct xhci_ep_ctx *ep_ctx;
 	struct xhci_slot_ctx *slot_ctx;
 	struct xhci_td *td, *tmp_td;
+	bool deferred = false;
 
 	ep_index = TRB_TO_EP_INDEX(le32_to_cpu(trb->generic.field[3]));
 	stream_id = TRB_TO_STREAM_ID(le32_to_cpu(trb->generic.field[2]));
@@ -1436,6 +1457,8 @@ static void xhci_handle_cmd_set_deq(struct xhci_hcd *xhci, int slot_id,
 			xhci_dbg(ep->xhci, "%s: Giveback cancelled URB %p TD\n",
 				 __func__, td->urb);
 			xhci_td_cleanup(ep->xhci, td, ep_ring, td->status);
+		} else if (td->cancel_status == TD_CLEARING_CACHE_DEFERRED) {
+			deferred = true;
 		} else {
 			xhci_dbg(ep->xhci, "%s: Keep cancelled URB %p TD as cancel_status is %d\n",
 				 __func__, td->urb, td->cancel_status);
@@ -1445,8 +1468,17 @@ static void xhci_handle_cmd_set_deq(struct xhci_hcd *xhci, int slot_id,
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
index 6f4bf98a6282..aa4379bdb90c 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1276,6 +1276,7 @@ enum xhci_cancelled_td_status {
 	TD_DIRTY = 0,
 	TD_HALTED,
 	TD_CLEARING_CACHE,
+	TD_CLEARING_CACHE_DEFERRED,
 	TD_CLEARED,
 };
 

---
base-commit: a38297e3fb012ddfa7ce0321a7e5a8daeb1872b6
change-id: 20240524-xhci-streams-124e88db52e6

Best regards,
-- 
Hector Martin <marcan@marcan.st>


