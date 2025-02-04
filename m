Return-Path: <stable+bounces-112169-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8415CA27415
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 15:09:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 922D41888D4B
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 14:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B053212B27;
	Tue,  4 Feb 2025 14:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wtepIc/u"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A94E20FA81
	for <stable@vger.kernel.org>; Tue,  4 Feb 2025 14:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738677780; cv=none; b=UgsAIul4lVIw286yLQ3A7UPrv9s2UPuu/LQMUY5F2EK9A2z9eTBiTHbg0lRxT5hzldB4/wed5ppo2c54dxBacfi953RlbKAG3IrnX1iwRBmdQszB2PNKHmbhuCi4wBzr+2IwSs/B6sogzOJzJotoYM73gHYJ4qBgHQSbZtGI2Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738677780; c=relaxed/simple;
	bh=MfmRYxie5vw3h4Sxd2wINYCQ4xOSKj/yMEtdbgCa+hQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=g4zqqyZASEOcAgoMz4AsJDuXbbs2vqRsevGwHDKYcNSF1rlonc/mYtDR0ixamtXWGDLodL4P+CItmBlC/oZ8QK3OcxH5PQfMiDW8JrOuTTy0SX4na6I94ADs48ttKRdpMVjiuJg2TnTcOmiHkmG4F4tg8ci9rWptzTKShOyhhjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wtepIc/u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAB7AC4CEDF;
	Tue,  4 Feb 2025 14:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738677780;
	bh=MfmRYxie5vw3h4Sxd2wINYCQ4xOSKj/yMEtdbgCa+hQ=;
	h=Subject:To:Cc:From:Date:From;
	b=wtepIc/uP5LLY/1OsU5t2TqBZgGID3DFwbzRP/rLJIUfgF3G1jhRGa6ssaytTLSgI
	 Mn1quf99tNH2rQGsZKd8c7Sln5hGEBtPZ1tDGag8fN9ujcd3BlmAvXc7SfcpZHWIuJ
	 0oC20d9GOTIv7WmCEfIH+Gp3eGFUzedhwqRjBMz4=
Subject: FAILED: patch "[PATCH] usb: xhci: Fix NULL pointer dereference on certain command" failed to apply to 5.15-stable tree
To: michal.pecio@gmail.com,gregkh@linuxfoundation.org,mathias.nyman@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 04 Feb 2025 15:02:57 +0100
Message-ID: <2025020457-afternoon-avert-fefb@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 1e0a19912adb68a4b2b74fd77001c96cd83eb073
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025020457-afternoon-avert-fefb@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1e0a19912adb68a4b2b74fd77001c96cd83eb073 Mon Sep 17 00:00:00 2001
From: Michal Pecio <michal.pecio@gmail.com>
Date: Fri, 27 Dec 2024 14:01:40 +0200
Subject: [PATCH] usb: xhci: Fix NULL pointer dereference on certain command
 aborts

If a command is queued to the final usable TRB of a ring segment, the
enqueue pointer is advanced to the subsequent link TRB and no further.
If the command is later aborted, when the abort completion is handled
the dequeue pointer is advanced to the first TRB of the next segment.

If no further commands are queued, xhci_handle_stopped_cmd_ring() sees
the ring pointers unequal and assumes that there is a pending command,
so it calls xhci_mod_cmd_timer() which crashes if cur_cmd was NULL.

Don't attempt timer setup if cur_cmd is NULL. The subsequent doorbell
ring likely is unnecessary too, but it's harmless. Leave it alone.

This is probably Bug 219532, but no confirmation has been received.

The issue has been independently reproduced and confirmed fixed using
a USB MCU programmed to NAK the Status stage of SET_ADDRESS forever.
Everything continued working normally after several prevented crashes.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=219532
Fixes: c311e391a7ef ("xhci: rework command timeout and cancellation,")
CC: stable@vger.kernel.org
Signed-off-by: Michal Pecio <michal.pecio@gmail.com>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Link: https://lore.kernel.org/r/20241227120142.1035206-4-mathias.nyman@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 09b05a62375e..dfe1a676d487 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -422,7 +422,8 @@ static void xhci_handle_stopped_cmd_ring(struct xhci_hcd *xhci,
 	if ((xhci->cmd_ring->dequeue != xhci->cmd_ring->enqueue) &&
 	    !(xhci->xhc_state & XHCI_STATE_DYING)) {
 		xhci->current_cmd = cur_cmd;
-		xhci_mod_cmd_timer(xhci);
+		if (cur_cmd)
+			xhci_mod_cmd_timer(xhci);
 		xhci_ring_cmd_db(xhci);
 	}
 }


