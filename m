Return-Path: <stable+bounces-90101-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECBC39BE3FD
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 11:14:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D4DA1F24DAE
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 10:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36A411DED63;
	Wed,  6 Nov 2024 10:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LxbLwjMw"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765AC1DE2DB;
	Wed,  6 Nov 2024 10:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730888020; cv=none; b=tO04dW49attpXrngifVTR29UpFwYeXkiwNVjzap6JAkgArB/d3K+rW05r1A/yOfULteTsHKdGGB4qMN5TJFT2ZX/+LC20AwSHZAm42NEtWFfIwzz8Ru6zEi4gwZo9ZOFgIqiQ/HvpBOoORS/szAecCHLyCyYpUySmRggx15Hb8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730888020; c=relaxed/simple;
	bh=jbZkr8iZPbdlbgogmpITnZZXPnS0YJL38OY6BQSHpVc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LP0yBhbiwjbrtugu7pCnrIzYwmI6GaeejV7CBEJaxp+YNszwHvt0LV833LFNxaIyPHELIRgHBQMZGoRtcOahSsCt/GFk8y8AlZUYP8RC46euFxhGG4eai0Pf5MbyMGNHNdO08bHq6huhV4f3LOjAPNRAQeuwsYvGLATbVuxNPmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LxbLwjMw; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730888018; x=1762424018;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jbZkr8iZPbdlbgogmpITnZZXPnS0YJL38OY6BQSHpVc=;
  b=LxbLwjMwKESWIdizxGexoykzLyOTvsyi3fJnXY0RonuGuDswyad/BxEI
   FyGv9To2dKoUgQhKyh8yu9qQ4ivtWNh3IjbBihfEvIONSnODbeOBQDwz1
   uwpeLN6ZXc5uP6ukRFMDEweMIU3KFr5sjkJicOUbQGimIsLAth4sdlUyb
   0U3hh8LuzUrTm/6OsVEoDOkBNyF07/0Wm1B/bgOF+d60OA1WO7P/Rvhe/
   hHVSRpFL0Kpo+9O8ixxc4oRSpWMm7JhlZIk5aE12MHyxROrhScjlhcc22
   RBIOcbGeWY7jegkLOCGF+zWomEpKuYmW5eR0hwmITqc6F3roEroSMD/+i
   Q==;
X-CSE-ConnectionGUID: ziuZ7ba6SseN7awJ1XJ0BQ==
X-CSE-MsgGUID: aMKgGTTvQo6Jrw7JaUfDVw==
X-IronPort-AV: E=McAfee;i="6700,10204,11247"; a="42059494"
X-IronPort-AV: E=Sophos;i="6.11,262,1725346800"; 
   d="scan'208";a="42059494"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2024 02:13:38 -0800
X-CSE-ConnectionGUID: nb2mc+XCTfWshh5dspQ1lw==
X-CSE-MsgGUID: 6zE48ppbQ9+j4IHUjQ6sKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,262,1725346800"; 
   d="scan'208";a="84813470"
Received: from mattu-haswell.fi.intel.com ([10.237.72.199])
  by fmviesa010.fm.intel.com with ESMTP; 06 Nov 2024 02:13:37 -0800
From: Mathias Nyman <mathias.nyman@linux.intel.com>
To: <gregkh@linuxfoundation.org>
Cc: <linux-usb@vger.kernel.org>,
	Michal Pecio <michal.pecio@gmail.com>,
	stable@vger.kernel.org,
	Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: [PATCH 33/33] usb: xhci: Avoid queuing redundant Stop Endpoint commands
Date: Wed,  6 Nov 2024 12:14:59 +0200
Message-Id: <20241106101459.775897-34-mathias.nyman@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241106101459.775897-1-mathias.nyman@linux.intel.com>
References: <20241106101459.775897-1-mathias.nyman@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michal Pecio <michal.pecio@gmail.com>

Stop Endpoint command on an already stopped endpoint fails and may be
misinterpreted as a known hardware bug by the completion handler. This
results in an unnecessary delay with repeated retries of the command.

Avoid queuing this command when endpoint state flags indicate that it's
stopped or halted and the command will fail. If commands are pending on
the endpoint, their completion handlers will process cancelled TDs so
it's done. In case of waiting for external operations like clearing TT
buffer, the endpoint is stopped and cancelled TDs can be processed now.

This eliminates practically all unnecessary retries because an endpoint
with pending URBs is maintained in Running state by the driver, unless
aforementioned commands or other operations are pending on it. This is
guaranteed by xhci_ring_ep_doorbell() and by the fact that it is called
every time any of those operations completes.

The only known exceptions are hardware bugs (the endpoint never starts
at all) and Stream Protocol errors not associated with any TRB, which
cause an endpoint reset not followed by restart. Sounds like a bug.

Generally, these retries are only expected to happen when the endpoint
fails to start for unknown/no reason, which is a worse problem itself,
and fixing the bug eliminates the retries too.

All cases were tested and found to work as expected. SET_DEQ_PENDING
was produced by patching uvcvideo to unlink URBs in 100us intervals,
which then runs into this case very often. EP_HALTED was produced by
restarting 'cat /dev/ttyUSB0' on a serial dongle with broken cable.
EP_CLEARING_TT by the same, with the dongle on an external hub.

Fixes: fd9d55d190c0 ("xhci: retry Stop Endpoint on buggy NEC controllers")
CC: stable@vger.kernel.org
Signed-off-by: Michal Pecio <michal.pecio@gmail.com>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
---
 drivers/usb/host/xhci-ring.c | 13 +++++++++++++
 drivers/usb/host/xhci.c      | 19 +++++++++++++++----
 drivers/usb/host/xhci.h      |  1 +
 3 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 55be03be2374..4cf5363875c7 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -1076,6 +1076,19 @@ static int xhci_invalidate_cancelled_tds(struct xhci_virt_ep *ep)
 	return 0;
 }
 
+/*
+ * Erase queued TDs from transfer ring(s) and give back those the xHC didn't
+ * stop on. If necessary, queue commands to move the xHC off cancelled TDs it
+ * stopped on. Those will be given back later when the commands complete.
+ *
+ * Call under xhci->lock on a stopped endpoint.
+ */
+void xhci_process_cancelled_tds(struct xhci_virt_ep *ep)
+{
+	xhci_invalidate_cancelled_tds(ep);
+	xhci_giveback_invalidated_tds(ep);
+}
+
 /*
  * Returns the TD the endpoint ring halted on.
  * Only call for non-running rings without streams.
diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 4977ada0a19e..5ebde8cae4fc 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -1756,10 +1756,21 @@ static int xhci_urb_dequeue(struct usb_hcd *hcd, struct urb *urb, int status)
 		}
 	}
 
-	/* Queue a stop endpoint command, but only if this is
-	 * the first cancellation to be handled.
-	 */
-	if (!(ep->ep_state & EP_STOP_CMD_PENDING)) {
+	/* These completion handlers will sort out cancelled TDs for us */
+	if (ep->ep_state & (EP_STOP_CMD_PENDING | EP_HALTED | SET_DEQ_PENDING)) {
+		xhci_dbg(xhci, "Not queuing Stop Endpoint on slot %d ep %d in state 0x%x\n",
+				urb->dev->slot_id, ep_index, ep->ep_state);
+		goto done;
+	}
+
+	/* In this case no commands are pending but the endpoint is stopped */
+	if (ep->ep_state & EP_CLEARING_TT) {
+		/* and cancelled TDs can be given back right away */
+		xhci_dbg(xhci, "Invalidating TDs instantly on slot %d ep %d in state 0x%x\n",
+				urb->dev->slot_id, ep_index, ep->ep_state);
+		xhci_process_cancelled_tds(ep);
+	} else {
+		/* Otherwise, queue a new Stop Endpoint command */
 		command = xhci_alloc_command(xhci, false, GFP_ATOMIC);
 		if (!command) {
 			ret = -ENOMEM;
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index 6dd3138b2380..4914f0a10cff 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1922,6 +1922,7 @@ void inc_deq(struct xhci_hcd *xhci, struct xhci_ring *ring);
 unsigned int count_trbs(u64 addr, u64 len);
 int xhci_stop_endpoint_sync(struct xhci_hcd *xhci, struct xhci_virt_ep *ep,
 			    int suspend, gfp_t gfp_flags);
+void xhci_process_cancelled_tds(struct xhci_virt_ep *ep);
 
 /* xHCI roothub code */
 void xhci_set_link_state(struct xhci_hcd *xhci, struct xhci_port *port,
-- 
2.25.1


