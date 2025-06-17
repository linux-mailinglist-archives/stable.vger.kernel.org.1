Return-Path: <stable+bounces-152874-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AE99ADCFCD
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 16:30:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EE012C02CA
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 14:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D358C2EF670;
	Tue, 17 Jun 2025 14:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="llWolan1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915F62EF665
	for <stable@vger.kernel.org>; Tue, 17 Jun 2025 14:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750170251; cv=none; b=EDMLjntgyRiNIqW8Musi8bGFSt6QahZOHv1sj73K+0KByVAwtWdshPnC7Ksm1F1hCpkMt0UMl6Mp2fLrcec1U1A0KUOG/8oGUCBKMcxh6RvUP40GP1lQtOFgO/mZz5yZSEPcwMBeGga3WlC0CMpyusqaB4KTx6e8fq1K5DmNMSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750170251; c=relaxed/simple;
	bh=OTr5B4JB9MFvmca+GqSW8Jrx3Pdi/8Zn5za98O+GYZU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=pbNgqfcAKM1APHJ04e1Ev7YpNhi3TWZDwWiCeNDV+y9ThbRvkFCxJ45plW7PB4xWqOO77uJtCqX/PONgytyGDlIyEJpE35zSyfBGq3wCQ7TQJzSoQO0FG/PwXb8jIFttx7qgbkuWdyqp8yDbpImt8FM4CVY2GsNnIWv3lBug2F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=llWolan1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 653B6C4CEE7;
	Tue, 17 Jun 2025 14:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750170251;
	bh=OTr5B4JB9MFvmca+GqSW8Jrx3Pdi/8Zn5za98O+GYZU=;
	h=Subject:To:Cc:From:Date:From;
	b=llWolan1wIrCpMVMowxSq6soJ81sfLu+r4eExgsfMAaOG2QYzJoTNwVhFvHoYcngX
	 kJw6HOsB4+6XWrLiYdgtBwtdME40giugHdL7HLEGEHsf962cWS6QjM0n0Ht7RYczHO
	 PRFkQgtyVPW6fika5VzYTcIQC/Lt8wkMOJqJwEwU=
Subject: FAILED: patch "[PATCH] usb: cdnsp: Fix issue with detecting command completion event" failed to apply to 5.10-stable tree
To: pawell@cadence.com,gregkh@linuxfoundation.org,peter.chen@kernel.org,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 17 Jun 2025 16:24:07 +0200
Message-ID: <2025061707-putt-mutable-5fb5@gregkh>
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
git cherry-pick -x f4ecdc352646f7d23f348e5c544dbe3212c94fc8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025061707-putt-mutable-5fb5@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f4ecdc352646f7d23f348e5c544dbe3212c94fc8 Mon Sep 17 00:00:00 2001
From: Pawel Laszczak <pawell@cadence.com>
Date: Tue, 13 May 2025 05:30:09 +0000
Subject: [PATCH] usb: cdnsp: Fix issue with detecting command completion event

In some cases, there is a small-time gap in which CMD_RING_BUSY can be
cleared by controller but adding command completion event to event ring
will be delayed. As the result driver will return error code.

This behavior has been detected on usbtest driver (test 9) with
configuration including ep1in/ep1out bulk and ep2in/ep2out isoc
endpoint.

Probably this gap occurred because controller was busy with adding some
other events to event ring.

The CMD_RING_BUSY is cleared to '0' when the Command Descriptor has been
executed and not when command completion event has been added to event
ring.

To fix this issue for this test the small delay is sufficient less than
10us) but to make sure the problem doesn't happen again in the future
the patch introduces 10 retries to check with delay about 20us before
returning error code.

Fixes: 3d82904559f4 ("usb: cdnsp: cdns3 Add main part of Cadence USBSSP DRD Driver")
Cc: stable <stable@kernel.org>
Signed-off-by: Pawel Laszczak <pawell@cadence.com>
Acked-by: Peter Chen <peter.chen@kernel.org>
Link: https://lore.kernel.org/r/PH7PR07MB9538AA45362ACCF1B94EE9B7DD96A@PH7PR07MB9538.namprd07.prod.outlook.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/usb/cdns3/cdnsp-gadget.c b/drivers/usb/cdns3/cdnsp-gadget.c
index cd1e00daf43f..55f95f41b3b4 100644
--- a/drivers/usb/cdns3/cdnsp-gadget.c
+++ b/drivers/usb/cdns3/cdnsp-gadget.c
@@ -548,6 +548,7 @@ int cdnsp_wait_for_cmd_compl(struct cdnsp_device *pdev)
 	dma_addr_t cmd_deq_dma;
 	union cdnsp_trb *event;
 	u32 cycle_state;
+	u32 retry = 10;
 	int ret, val;
 	u64 cmd_dma;
 	u32  flags;
@@ -579,8 +580,23 @@ int cdnsp_wait_for_cmd_compl(struct cdnsp_device *pdev)
 		flags = le32_to_cpu(event->event_cmd.flags);
 
 		/* Check the owner of the TRB. */
-		if ((flags & TRB_CYCLE) != cycle_state)
+		if ((flags & TRB_CYCLE) != cycle_state) {
+			/*
+			 * Give some extra time to get chance controller
+			 * to finish command before returning error code.
+			 * Checking CMD_RING_BUSY is not sufficient because
+			 * this bit is cleared to '0' when the Command
+			 * Descriptor has been executed by controller
+			 * and not when command completion event has
+			 * be added to event ring.
+			 */
+			if (retry--) {
+				udelay(20);
+				continue;
+			}
+
 			return -EINVAL;
+		}
 
 		cmd_dma = le64_to_cpu(event->event_cmd.cmd_trb);
 


