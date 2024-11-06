Return-Path: <stable+bounces-90099-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE559BE3F9
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 11:14:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 941691F24DBD
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 10:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 208FE1DED40;
	Wed,  6 Nov 2024 10:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OkW4Bc6o"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ACDC1DED4B;
	Wed,  6 Nov 2024 10:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730888016; cv=none; b=GHiJHUlyPqOgzI/O8wGehr6Ze0+ZvONV1GkcjuhX31DAygtkz2H8i3FYxV3Ikjia82AktI5avLYNzYVMVvAJjKBxuIHAA/wmUjr20huSSz5SWcRw17EUgwKAM1fomx/QWF1W/HTZonKSID49ssU3r/HoNLIy2XVVjuOvM1tjaj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730888016; c=relaxed/simple;
	bh=sr47Jg1ARBWRZFZAicQnKkNylUiP8ygX3xVGB/s1QeM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DLOdVGCcAwy6uXPW9ZpGIPJz6VRmxnH3VAmrjFCAuFaCYTyKItbFhvjEHHl2yEaxqS81vohGYvalhydYdfRKxvqELDOeaNaEIX0wzddQvk9HwrKldJwn7SZDCInsUxKQYRKY+TA4oKhbVhFf4dFhjzxgO4d4s/vVFqqUqKt/h/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OkW4Bc6o; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730888015; x=1762424015;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sr47Jg1ARBWRZFZAicQnKkNylUiP8ygX3xVGB/s1QeM=;
  b=OkW4Bc6ohotLE4xm77x3CP3XpLaOnVAlIDbEFc3TsTMivcSPF8b+SZq3
   4XLViEjym2K0QXNO0sfvRfrOAP5XQiyQrqagt6FxZxjvEIys/Csiu6BIl
   NFqgIMCCHHUJZ6rfg6BJjE4iCLxvKXc8J5Tu1Sa6E0tCUTVq5QObrjk05
   8jyDbAw+m/ffpvc8UkSIzwW6A71g7eLgTGf5c/l9j8sdTbYclRQeUKFLZ
   IjY7yrKde3F4cLXBKGM1oDzxXOnSVPQYsCBLGDvEWrclTL05GvkHvpf4R
   h7gnzSKmyQnvbqMhsMDraGtfIDb1UMTvoGsT/DZd2pOfjW2a1qr24DZpl
   Q==;
X-CSE-ConnectionGUID: h+JdgrK/TVi3Z5KX9TvUIQ==
X-CSE-MsgGUID: xW2r0lJqS8a5c+OPVG0aLQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11247"; a="42059487"
X-IronPort-AV: E=Sophos;i="6.11,262,1725346800"; 
   d="scan'208";a="42059487"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2024 02:13:34 -0800
X-CSE-ConnectionGUID: 6LLWRGRbQXyTr8B7Dl7NGw==
X-CSE-MsgGUID: hGMMr3a6Q66j18noWcNQwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,262,1725346800"; 
   d="scan'208";a="84813467"
Received: from mattu-haswell.fi.intel.com ([10.237.72.199])
  by fmviesa010.fm.intel.com with ESMTP; 06 Nov 2024 02:13:33 -0800
From: Mathias Nyman <mathias.nyman@linux.intel.com>
To: <gregkh@linuxfoundation.org>
Cc: <linux-usb@vger.kernel.org>,
	Michal Pecio <michal.pecio@gmail.com>,
	stable@vger.kernel.org,
	Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: [PATCH 31/33] usb: xhci: Limit Stop Endpoint retries
Date: Wed,  6 Nov 2024 12:14:57 +0200
Message-Id: <20241106101459.775897-32-mathias.nyman@linux.intel.com>
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

Some host controllers fail to atomically transition an endpoint to the
Running state on a doorbell ring and enter a hidden "Restarting" state,
which looks very much like Stopped, with the important difference that
it will spontaneously transition to Running anytime soon.

A Stop Endpoint command queued in the Restarting state typically fails
with Context State Error and the completion handler sees the Endpoint
Context State as either still Stopped or already Running. Even a case
of Halted was observed, when an error occurred right after the restart.

The Halted state is already recovered from by resetting the endpoint.
The Running state is handled by retrying Stop Endpoint.

The Stopped state was recognized as a problem on NEC controllers and
worked around also by retrying, because the endpoint soon restarts and
then stops for good. But there is a risk: the command may fail if the
endpoint is "stopped for good" already, and retries will fail forever.

The possibility of this was not realized at the time, but a number of
cases were discovered later and reproduced. Some proved difficult to
deal with, and it is outright impossible to predict if an endpoint may
fail to ever start at all due to a hardware bug. One such bug (albeit
on ASM3142, not on NEC) was found to be reliably triggered simply by
toggling an AX88179 NIC up/down in a tight loop for a few seconds.

An endless retries storm is quite nasty. Besides putting needless load
on the xHC and CPU, it causes URBs never to be given back, paralyzing
the device and connection/disconnection logic for the whole bus if the
device is unplugged. User processes waiting for URBs become unkillable,
drivers and kworker threads lock up and xhci_hcd cannot be reloaded.

For peace of mind, impose a timeout on Stop Endpoint retries in this
case. If they don't succeed in 100ms, consider the endpoint stopped
permanently for some reason and just give back the unlinked URBs. This
failure case is rare already and work is under way to make it rarer.

Start this work today by also handling one simple case of race with
Reset Endpoint, because it costs just two lines to implement.

Fixes: fd9d55d190c0 ("xhci: retry Stop Endpoint on buggy NEC controllers")
CC: stable@vger.kernel.org
Signed-off-by: Michal Pecio <michal.pecio@gmail.com>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
---
 drivers/usb/host/xhci-ring.c | 28 ++++++++++++++++++++++++----
 drivers/usb/host/xhci.c      |  2 ++
 drivers/usb/host/xhci.h      |  1 +
 3 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index c9c0c4a7588a..dd23596ccd84 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -52,6 +52,7 @@
  *   endpoint rings; it generates events on the event ring for these.
  */
 
+#include <linux/jiffies.h>
 #include <linux/scatterlist.h>
 #include <linux/slab.h>
 #include <linux/dma-mapping.h>
@@ -1158,16 +1159,35 @@ static void xhci_handle_cmd_stop_ep(struct xhci_hcd *xhci, int slot_id,
 			return;
 		case EP_STATE_STOPPED:
 			/*
-			 * NEC uPD720200 sometimes sets this state and fails with
-			 * Context Error while continuing to process TRBs.
-			 * Be conservative and trust EP_CTX_STATE on other chips.
+			 * Per xHCI 4.6.9, Stop Endpoint command on a Stopped
+			 * EP is a Context State Error, and EP stays Stopped.
+			 *
+			 * But maybe it failed on Halted, and somebody ran Reset
+			 * Endpoint later. EP state is now Stopped and EP_HALTED
+			 * still set because Reset EP handler will run after us.
+			 */
+			if (ep->ep_state & EP_HALTED)
+				break;
+			/*
+			 * On some HCs EP state remains Stopped for some tens of
+			 * us to a few ms or more after a doorbell ring, and any
+			 * new Stop Endpoint fails without aborting the restart.
+			 * This handler may run quickly enough to still see this
+			 * Stopped state, but it will soon change to Running.
+			 *
+			 * Assume this bug on unexpected Stop Endpoint failures.
+			 * Keep retrying until the EP starts and stops again, on
+			 * chips where this is known to help. Wait for 100ms.
 			 */
 			if (!(xhci->quirks & XHCI_NEC_HOST))
 				break;
+			if (time_is_before_jiffies(ep->stop_time + msecs_to_jiffies(100)))
+				break;
 			fallthrough;
 		case EP_STATE_RUNNING:
 			/* Race, HW handled stop ep cmd before ep was running */
-			xhci_dbg(xhci, "Stop ep completion ctx error, ep is running\n");
+			xhci_dbg(xhci, "Stop ep completion ctx error, ctx_state %d\n",
+					GET_EP_CTX_STATE(ep_ctx));
 
 			command = xhci_alloc_command(xhci, false, GFP_ATOMIC);
 			if (!command) {
diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index bc477cf99805..4977ada0a19e 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -8,6 +8,7 @@
  * Some code borrowed from the Linux EHCI driver.
  */
 
+#include <linux/jiffies.h>
 #include <linux/pci.h>
 #include <linux/iommu.h>
 #include <linux/iopoll.h>
@@ -1764,6 +1765,7 @@ static int xhci_urb_dequeue(struct usb_hcd *hcd, struct urb *urb, int status)
 			ret = -ENOMEM;
 			goto done;
 		}
+		ep->stop_time = jiffies;
 		ep->ep_state |= EP_STOP_CMD_PENDING;
 		xhci_queue_stop_endpoint(xhci, command, urb->dev->slot_id,
 					 ep_index, 0);
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index a0e992c3db0d..6dd3138b2380 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -691,6 +691,7 @@ struct xhci_virt_ep {
 	/* Bandwidth checking storage */
 	struct xhci_bw_info	bw_info;
 	struct list_head	bw_endpoint_list;
+	unsigned long		stop_time;
 	/* Isoch Frame ID checking storage */
 	int			next_frame_id;
 	/* Use new Isoch TRB layout needed for extended TBC support */
-- 
2.25.1


