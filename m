Return-Path: <stable+bounces-96110-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FD279E0BB3
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 20:08:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 116A0B334CB
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 15:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C7763D96D;
	Mon,  2 Dec 2024 15:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JdySsC3r"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DEA1BA53
	for <stable@vger.kernel.org>; Mon,  2 Dec 2024 15:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733154665; cv=none; b=bkevd3IWc/yq+3OmsxW255IBMMFldERL5ruYkJBLP2gmJwHhqITxYX2h0FcNHIqnyQGFKrXP88M/bm/nQH5plrAXesjz1sVMbvjUOJxoSclP4yAX3vz3wrP7y4PrTjoLo7yaW8w7hpkh6MmB7YYP2d4RdUmHvbnpwSvHY+jIZcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733154665; c=relaxed/simple;
	bh=smBBnNZKAZK9nWVC/KB0imiOK6TP4DUfKRVXvjkNsmo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=eNKZrTU3s4UQ7H6nN14K/PFoyODdMC4evctCbZhKgbeINTWJwEqhxzF/tPmFrbiR6rNbt26/7Z6Ze54WsBiiLz3KCXdRrsxffe0xgmhpMKWjaR1lMyn18H2pwkdGYfaEhIJ0hvd+0FzHfDTK1va3lPsh6VBJsHwpvFjEfGimAwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JdySsC3r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0634FC4CED1;
	Mon,  2 Dec 2024 15:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733154664;
	bh=smBBnNZKAZK9nWVC/KB0imiOK6TP4DUfKRVXvjkNsmo=;
	h=Subject:To:Cc:From:Date:From;
	b=JdySsC3r4uY2/KxbhsmWAvjdEST6B1LPQ7MZq7l0SWP0Nh0II09ZCaTBpIZNVnf5h
	 THbt1EUIC7HGVlRzWGEPao2BFlfDWjAqGNs/rorS5YJdoVyJkQ2EELKWBFqE/fotGH
	 3YDhsHNWIruhcmoPCZWapD7NniwyEZunIrVhCjzk=
Subject: FAILED: patch "[PATCH] xhci: Fix control transfer error on Etron xHCI host" failed to apply to 6.6-stable tree
To: ki.chiang65@gmail.com,gregkh@linuxfoundation.org,mathias.nyman@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 02 Dec 2024 16:50:48 +0100
Message-ID: <2024120248-scuff-roster-854c@gregkh>
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
git cherry-pick -x 5e1c67abc9301d05130b7e267c204e7005503b33
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024120248-scuff-roster-854c@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5e1c67abc9301d05130b7e267c204e7005503b33 Mon Sep 17 00:00:00 2001
From: Kuangyi Chiang <ki.chiang65@gmail.com>
Date: Wed, 6 Nov 2024 12:14:45 +0200
Subject: [PATCH] xhci: Fix control transfer error on Etron xHCI host

Performing a stability stress test on a USB3.0 2.5G ethernet adapter
results in errors like this:

[   91.441469] r8152 2-3:1.0 eth3: get_registers -71
[   91.458659] r8152 2-3:1.0 eth3: get_registers -71
[   91.475911] r8152 2-3:1.0 eth3: get_registers -71
[   91.493203] r8152 2-3:1.0 eth3: get_registers -71
[   91.510421] r8152 2-3:1.0 eth3: get_registers -71

The r8152 driver will periodically issue lots of control-IN requests
to access the status of ethernet adapter hardware registers during
the test.

This happens when the xHCI driver enqueue a control TD (which cross
over the Link TRB between two ring segments, as shown) in the endpoint
zero's transfer ring. Seems the Etron xHCI host can not perform this
TD correctly, causing the USB transfer error occurred, maybe the upper
driver retry that control-IN request can solve problem, but not all
drivers do this.

|     |
-------
| TRB | Setup Stage
-------
| TRB | Link
-------
-------
| TRB | Data Stage
-------
| TRB | Status Stage
-------
|     |

To work around this, the xHCI driver should enqueue a No Op TRB if
next available TRB is the Link TRB in the ring segment, this can
prevent the Setup and Data Stage TRB to be breaked by the Link TRB.

Check if the XHCI_ETRON_HOST quirk flag is set before invoking the
workaround in xhci_queue_ctrl_tx().

Fixes: d0e96f5a71a0 ("USB: xhci: Control transfer support.")
Cc: stable@vger.kernel.org
Signed-off-by: Kuangyi Chiang <ki.chiang65@gmail.com>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Link: https://lore.kernel.org/r/20241106101459.775897-20-mathias.nyman@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index f62b243d0fc4..517df97ef496 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -3733,6 +3733,20 @@ int xhci_queue_ctrl_tx(struct xhci_hcd *xhci, gfp_t mem_flags,
 	if (!urb->setup_packet)
 		return -EINVAL;
 
+	if ((xhci->quirks & XHCI_ETRON_HOST) &&
+	    urb->dev->speed >= USB_SPEED_SUPER) {
+		/*
+		 * If next available TRB is the Link TRB in the ring segment then
+		 * enqueue a No Op TRB, this can prevent the Setup and Data Stage
+		 * TRB to be breaked by the Link TRB.
+		 */
+		if (trb_is_link(ep_ring->enqueue + 1)) {
+			field = TRB_TYPE(TRB_TR_NOOP) | ep_ring->cycle_state;
+			queue_trb(xhci, ep_ring, false, 0, 0,
+					TRB_INTR_TARGET(0), field);
+		}
+	}
+
 	/* 1 TRB for setup, 1 for status */
 	num_trbs = 2;
 	/*


