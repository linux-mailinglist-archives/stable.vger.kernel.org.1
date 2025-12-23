Return-Path: <stable+bounces-203317-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AD84CD9F6B
	for <lists+stable@lfdr.de>; Tue, 23 Dec 2025 17:29:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 59B483035A62
	for <lists+stable@lfdr.de>; Tue, 23 Dec 2025 16:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A0812C11E9;
	Tue, 23 Dec 2025 16:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sSfW0lvD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1DD32874FF
	for <stable@vger.kernel.org>; Tue, 23 Dec 2025 16:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766507231; cv=none; b=oaBRKy9E43u/q2/NFn/s/kxQuy77NZvpxPqpOdLUZruZOoa71sqSuB6Qfrl4/aHiq3OsnV0ZbFPIN8mA3fhW2bhm05HzBDDrAqshflJCNqHjPufUHK1vEVupOA2ERGI51znYkzFHwTfp6OZL4KCA5OvC1OltQ2fVZQWzUVtJGms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766507231; c=relaxed/simple;
	bh=XrjDOO377BIJmXIJ6rDppFgUef/uNh+7qKDowFPObaU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=buoX4j1S/yKm2zrVivl4l+DCHE9aMbXQDmpkHofFKS5ByU6YpispGvUjmmtnvRX37u9QpJ5Blr2pchFnWKVZrXw9URoEnxv7fOrDHnqUxFRBxa8F7gYgU/kD7X4emKuNp8N/DRYoGiEdEa99nMjLsru70qwgcwV8PTCrfk6+/z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sSfW0lvD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C50ECC116C6;
	Tue, 23 Dec 2025 16:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1766507230;
	bh=XrjDOO377BIJmXIJ6rDppFgUef/uNh+7qKDowFPObaU=;
	h=Subject:To:Cc:From:Date:From;
	b=sSfW0lvDJKZE/njFg1l4yBoLGAyX/aP8fOr1BxuNHp4Ch8Pa78Jal9B9dyh05ihjG
	 Q44s5lC4Khkrc1u3WigJevnwbKSM9McVMSi6HtEyBPExLZnYHZ4KC3bhrgkjVVGPpn
	 d1YU5NGyROHPjqxhsgTAsIfEHa/XxpIrsXKOOv+Y=
Subject: FAILED: patch "[PATCH] can: gs_usb: gs_can_open(): fix error handling" failed to apply to 6.1-stable tree
To: mkl@pengutronix.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 23 Dec 2025 17:27:06 +0100
Message-ID: <2025122306-hurry-upstream-964e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 3e54d3b4a8437b6783d4145c86962a2aa51022f3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025122306-hurry-upstream-964e@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 3e54d3b4a8437b6783d4145c86962a2aa51022f3 Mon Sep 17 00:00:00 2001
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Mon, 1 Dec 2025 19:26:38 +0100
Subject: [PATCH] can: gs_usb: gs_can_open(): fix error handling

Commit 2603be9e8167 ("can: gs_usb: gs_can_open(): improve error handling")
added missing error handling to the gs_can_open() function.

The driver uses 2 USB anchors to track the allocated URBs: the TX URBs in
struct gs_can::tx_submitted for each netdev and the RX URBs in struct
gs_usb::rx_submitted for the USB device. gs_can_open() allocates the RX
URBs, while TX URBs are allocated during gs_can_start_xmit().

The cleanup in gs_can_open() kills all anchored dev->tx_submitted
URBs (which is not necessary since the netdev is not yet registered), but
misses the parent->rx_submitted URBs.

Fix the problem by killing the rx_submitted instead of the tx_submitted.

Fixes: 2603be9e8167 ("can: gs_usb: gs_can_open(): improve error handling")
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20251210-gs_usb-fix-error-handling-v1-1-d6a5a03f10bb@pengutronix.de
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index e29e85b67fd4..a0233e550a5a 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -1074,7 +1074,7 @@ static int gs_can_open(struct net_device *netdev)
 	usb_free_urb(urb);
 out_usb_kill_anchored_urbs:
 	if (!parent->active_channels) {
-		usb_kill_anchored_urbs(&dev->tx_submitted);
+		usb_kill_anchored_urbs(&parent->rx_submitted);
 
 		if (dev->feature & GS_CAN_FEATURE_HW_TIMESTAMP)
 			gs_usb_timestamp_stop(parent);


