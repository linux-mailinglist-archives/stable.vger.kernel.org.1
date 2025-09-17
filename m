Return-Path: <stable+bounces-179799-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93823B7C6C3
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 14:01:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 063672A6AA0
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 08:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E98B13093AE;
	Wed, 17 Sep 2025 08:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xMY4oXcl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8995D21CA0D
	for <stable@vger.kernel.org>; Wed, 17 Sep 2025 08:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758097535; cv=none; b=HIghUQJp5VrWL+VKZ3ET9MIRBpVHPWv/hs6OBW8OfmrQWuAJ2+qb55kuRar4KOJ0TZEM2VismUWf+2VDo1xmwpi6ApWjO1Msra8/AJG3qHQilnjuwSDMoY+0K9hFpXQ3MB3/0dy+vKtzfzgIH/8Gg7GiVL5vZFMri5on0utuSuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758097535; c=relaxed/simple;
	bh=cKNwfhkoJdrP7TJpermbdUy+qupoRp2tstVzumPow5I=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Ll66PP+w+WUw1IRjqk/bF3C8UDsWaUmN3pnfYgqSmoH7AqfjGRPuBC1ePX4V+O5d/LzYsZdOOoWXanDa+vwB9LpqELA1vUCpAaNGDSWYHjLfZaBLKfn+7WD2uoDdBm6A53i5VSNeuj3kg3++6d4C1QjsmsduM+1xrHvkwd5u+Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xMY4oXcl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 944B3C4CEF0;
	Wed, 17 Sep 2025 08:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758097535;
	bh=cKNwfhkoJdrP7TJpermbdUy+qupoRp2tstVzumPow5I=;
	h=Subject:To:Cc:From:Date:From;
	b=xMY4oXclk1Yb8T0KmcfI6v7V1f7nCBelE3K8Hwgwpv06lB4DLvWLo6CvTIbi3VAuQ
	 i13soep6xYYIJYJ2KaX4twxrxujOk41Xem7yEQ6PrPr7xkbOrm+65xJj108BY14tBt
	 8P9ioBD9lLOpOw4pwdEu6Ay3SD9jiZJAj/UsVJRE=
Subject: FAILED: patch "[PATCH] xhci: dbc: Fix full DbC transfer ring after several" failed to apply to 5.10-stable tree
To: mathias.nyman@linux.intel.com,gregkh@linuxfoundation.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 17 Sep 2025 10:25:31 +0200
Message-ID: <2025091731-subtotal-outcome-6092@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x a5c98e8b1398534ae1feb6e95e2d3ee5215538ed
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025091731-subtotal-outcome-6092@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a5c98e8b1398534ae1feb6e95e2d3ee5215538ed Mon Sep 17 00:00:00 2001
From: Mathias Nyman <mathias.nyman@linux.intel.com>
Date: Tue, 2 Sep 2025 13:53:05 +0300
Subject: [PATCH] xhci: dbc: Fix full DbC transfer ring after several
 reconnects

Pending requests will be flushed on disconnect, and the corresponding
TRBs will be turned into No-op TRBs, which are ignored by the xHC
controller once it starts processing the ring.

If the USB debug cable repeatedly disconnects before ring is started
then the ring will eventually be filled with No-op TRBs.
No new transfers can be queued when the ring is full, and driver will
print the following error message:

    "xhci_hcd 0000:00:14.0: failed to queue trbs"

This is a normal case for 'in' transfers where TRBs are always enqueued
in advance, ready to take on incoming data. If no data arrives, and
device is disconnected, then ring dequeue will remain at beginning of
the ring while enqueue points to first free TRB after last cancelled
No-op TRB.
s
Solve this by reinitializing the rings when the debug cable disconnects
and DbC is leaving the configured state.
Clear the whole ring buffer and set enqueue and dequeue to the beginning
of ring, and set cycle bit to its initial state.

Cc: stable@vger.kernel.org
Fixes: dfba2174dc42 ("usb: xhci: Add DbC support in xHCI driver")
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Link: https://lore.kernel.org/r/20250902105306.877476-3-mathias.nyman@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/usb/host/xhci-dbgcap.c b/drivers/usb/host/xhci-dbgcap.c
index d0faff233e3e..63edf2d8f245 100644
--- a/drivers/usb/host/xhci-dbgcap.c
+++ b/drivers/usb/host/xhci-dbgcap.c
@@ -462,6 +462,25 @@ static void xhci_dbc_ring_init(struct xhci_ring *ring)
 	xhci_initialize_ring_info(ring);
 }
 
+static int xhci_dbc_reinit_ep_rings(struct xhci_dbc *dbc)
+{
+	struct xhci_ring *in_ring = dbc->eps[BULK_IN].ring;
+	struct xhci_ring *out_ring = dbc->eps[BULK_OUT].ring;
+
+	if (!in_ring || !out_ring || !dbc->ctx) {
+		dev_warn(dbc->dev, "Can't re-init unallocated endpoints\n");
+		return -ENODEV;
+	}
+
+	xhci_dbc_ring_init(in_ring);
+	xhci_dbc_ring_init(out_ring);
+
+	/* set ep context enqueue, dequeue, and cycle to initial values */
+	xhci_dbc_init_ep_contexts(dbc);
+
+	return 0;
+}
+
 static struct xhci_ring *
 xhci_dbc_ring_alloc(struct device *dev, enum xhci_ring_type type, gfp_t flags)
 {
@@ -885,7 +904,7 @@ static enum evtreturn xhci_dbc_do_handle_events(struct xhci_dbc *dbc)
 			dev_info(dbc->dev, "DbC cable unplugged\n");
 			dbc->state = DS_ENABLED;
 			xhci_dbc_flush_requests(dbc);
-
+			xhci_dbc_reinit_ep_rings(dbc);
 			return EVT_DISC;
 		}
 
@@ -895,7 +914,7 @@ static enum evtreturn xhci_dbc_do_handle_events(struct xhci_dbc *dbc)
 			writel(portsc, &dbc->regs->portsc);
 			dbc->state = DS_ENABLED;
 			xhci_dbc_flush_requests(dbc);
-
+			xhci_dbc_reinit_ep_rings(dbc);
 			return EVT_DISC;
 		}
 


