Return-Path: <stable+bounces-96100-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B55379E07B1
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 16:56:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7A98B3F969
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 15:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CDE7209F23;
	Mon,  2 Dec 2024 15:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FZr/749b"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CDE9208992
	for <stable@vger.kernel.org>; Mon,  2 Dec 2024 15:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733153234; cv=none; b=SAZ1cyEB9pkMPTZY6ViiWUtrBQTn0DON1tIfvtVyWMz82HPOjIhl0obAKYXjuDN1sE7yNDkD5g3Un67Qj42NYMJmXV5gMy/WUwvpIqQH0XXZxKvhND5yupu2Lv77B6zzhPg6MP/UOEsTeiMKHuN8TP2hoggsiQoOaBIg5Vghewo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733153234; c=relaxed/simple;
	bh=MQx3I7TDEz6/aVllqz6/f/qo7zl+B5ED6Jdj+1HIKGc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=UNahl10PF9tofr4SzaM/NPO+jfJG6hzdti3GZrwh523J3sE2fngLJojHlHtvfr5NJayAIa2klLCFbmxoyM0ZV5C0rCAp8es2RGjgR86x0n0T+lbbbHPMFqfiUOG2uyEdXPgkwIJsWECvzcVBZHJHSjpa2cBm6IWHiiL9/3mc7is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FZr/749b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A599C4CED1;
	Mon,  2 Dec 2024 15:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733153233;
	bh=MQx3I7TDEz6/aVllqz6/f/qo7zl+B5ED6Jdj+1HIKGc=;
	h=Subject:To:Cc:From:Date:From;
	b=FZr/749b+mWm8Ni/TDIVCH/LNIZGrppVqIJ3lgHU6Zj+TY7m7qbM9J0YktxH/jwtT
	 7Pk5bvtbNGsFlu9BENbswGvC0g02rYU8/zHtEgO+k+9pWLHfzqznmlCwNUT1rGNpda
	 3gsYkUf36bPunRJkKrvq8kUZc8cXhbPsKPMWOrUE=
Subject: FAILED: patch "[PATCH] xhci: Fix control transfer error on Etron xHCI host" failed to apply to 4.19-stable tree
To: ki.chiang65@gmail.com,gregkh@linuxfoundation.org,mathias.nyman@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 02 Dec 2024 16:27:10 +0100
Message-ID: <2024120210-tastiness-guru-3aba@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x 5e1c67abc9301d05130b7e267c204e7005503b33
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024120210-tastiness-guru-3aba@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

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


