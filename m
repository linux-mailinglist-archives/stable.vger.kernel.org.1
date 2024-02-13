Return-Path: <stable+bounces-19717-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A1758531B2
	for <lists+stable@lfdr.de>; Tue, 13 Feb 2024 14:22:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD47E1C20EDC
	for <lists+stable@lfdr.de>; Tue, 13 Feb 2024 13:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17D9455C27;
	Tue, 13 Feb 2024 13:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="urC/9jVP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC33622089
	for <stable@vger.kernel.org>; Tue, 13 Feb 2024 13:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707830544; cv=none; b=hSnYRmKXYkb0ebcdaOexB+bhAFpT60wWti+HcP1WCUKQGfEJidT+TFVZpARVWGbjmfbO8dIy9oL37fyIzx1gFsZckUsfJBXDOh+h9oj72uI4jeHSfowWX+PtvgTiLiWih2qGvMYJMhhJb56ttdKHth7ILDymZeTnuMNWCNcPMEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707830544; c=relaxed/simple;
	bh=exidzn32bfuZ5R5MyUmP1lt+870mmh8Z0r0gYP6wJGs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=tnRU9LCYt7k5chzWvTvzMlNVOoxJ/3RyWMuMPMFGDIvMEPBklM3J9ZJodltRsG9ZxC9My/d8HCTIc8dO/tLMIJ4vKcBcixDDh8BhaZP4oZNqeUtX2EdOCjNyHTBU7LIwxjniq3oJmnRCQ5VWXq3FRtRYYPd7jGFVrwGnxDIx3q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=urC/9jVP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80F3AC433F1;
	Tue, 13 Feb 2024 13:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707830544;
	bh=exidzn32bfuZ5R5MyUmP1lt+870mmh8Z0r0gYP6wJGs=;
	h=Subject:To:Cc:From:Date:From;
	b=urC/9jVPnNSJopFExzMcQBcpOp6wYGdQJs2VnQFx/vK/5/CsrBhOzFuf7ODu7jaOT
	 lZZO9Fz+SKORszYmHOlBTcEJ+Mq5NpDPoYJNX4pZbksRovK4wzAyxo5l3m4sIt/aFl
	 8RDyAUbZnjCu6xIefbulITEmTUQqS78JGz5PLE8E=
Subject: FAILED: patch "[PATCH] xhci: handle isoc Babble and Buffer Overrun events properly" failed to apply to 4.19-stable tree
To: michal.pecio@gmail.com,gregkh@linuxfoundation.org,mathias.nyman@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 13 Feb 2024 14:22:11 +0100
Message-ID: <2024021310-prelaunch-earmark-e533@gregkh>
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
git cherry-pick -x 7c4650ded49e5b88929ecbbb631efb8b0838e811
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024021310-prelaunch-earmark-e533@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:

7c4650ded49e ("xhci: handle isoc Babble and Buffer Overrun events properly")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7c4650ded49e5b88929ecbbb631efb8b0838e811 Mon Sep 17 00:00:00 2001
From: Michal Pecio <michal.pecio@gmail.com>
Date: Thu, 25 Jan 2024 17:27:37 +0200
Subject: [PATCH] xhci: handle isoc Babble and Buffer Overrun events properly

xHCI 4.9 explicitly forbids assuming that the xHC has released its
ownership of a multi-TRB TD when it reports an error on one of the
early TRBs. Yet the driver makes such assumption and releases the TD,
allowing the remaining TRBs to be freed or overwritten by new TDs.

The xHC should also report completion of the final TRB due to its IOC
flag being set by us, regardless of prior errors. This event cannot
be recognized if the TD has already been freed earlier, resulting in
"Transfer event TRB DMA ptr not part of current TD" error message.

Fix this by reusing the logic for processing isoc Transaction Errors.
This also handles hosts which fail to report the final completion.

Fix transfer length reporting on Babble errors. They may be caused by
device malfunction, no guarantee that the buffer has been filled.

Signed-off-by: Michal Pecio <michal.pecio@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Link: https://lore.kernel.org/r/20240125152737.2983959-5-mathias.nyman@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 41be7d31a36e..f0d8a607ff21 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -2394,9 +2394,13 @@ static int process_isoc_td(struct xhci_hcd *xhci, struct xhci_virt_ep *ep,
 	case COMP_BANDWIDTH_OVERRUN_ERROR:
 		frame->status = -ECOMM;
 		break;
-	case COMP_ISOCH_BUFFER_OVERRUN:
 	case COMP_BABBLE_DETECTED_ERROR:
+		sum_trbs_for_length = true;
+		fallthrough;
+	case COMP_ISOCH_BUFFER_OVERRUN:
 		frame->status = -EOVERFLOW;
+		if (ep_trb != td->last_trb)
+			td->error_mid_td = true;
 		break;
 	case COMP_INCOMPATIBLE_DEVICE_ERROR:
 	case COMP_STALL_ERROR:


