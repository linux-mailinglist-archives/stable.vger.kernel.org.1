Return-Path: <stable+bounces-12751-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD52683723F
	for <lists+stable@lfdr.de>; Mon, 22 Jan 2024 20:17:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61E27291E45
	for <lists+stable@lfdr.de>; Mon, 22 Jan 2024 19:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FED44B5A0;
	Mon, 22 Jan 2024 19:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="k6apMoh4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26AA3FB26
	for <stable@vger.kernel.org>; Mon, 22 Jan 2024 19:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705950546; cv=none; b=Lu3x3lLvpeZpv05HKTwSL7UbWtELEOiocSjQVv/SUk/wlOY4up6fDl/yUnPkkFw2o3hSNz3+QWNjoO8rwTGlsqaB3vHJNPnaWIFiLcYvqnQTz4NfjGexQe9PmEPWDsbZpLlY6pkfaK7tz4kzxSIkELwS3gc+bErBvPXYFh9V/Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705950546; c=relaxed/simple;
	bh=qdrI3lGrTXaf3g22G/XJJRPWEdByaFZCgaR3kgBJiuk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=MqxnPsm1SN7N2gpvqXTWH7Q5H59hexO5bdid5rwGKWO2HrC65/YRUcMuuWt+BPOu7MjFe74o4zfdYl5OObQOidw83vctibeFlDPzXJvrVf2I2Blrcl+fhHgrhdua6caZtkffOZGBGtKz11sW/VnsRjO+la7BUN+Me0DAXernBA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=k6apMoh4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F4F6C433C7;
	Mon, 22 Jan 2024 19:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705950546;
	bh=qdrI3lGrTXaf3g22G/XJJRPWEdByaFZCgaR3kgBJiuk=;
	h=Subject:To:Cc:From:Date:From;
	b=k6apMoh4qMKCnF/W7+p8SLbydc+T3EEAca2D3I+gKhd6jkprh/Dz7ul77ggrh6M4f
	 r4s7EZCOxQ4ZAZs9Hx+3Hni8bS+ND1WLbDWtzvWPIUpyxb1Bv7SePz8Baq60wPA4RS
	 fnLNlgork3oh993KzDg+oPTcVG91uS/i7i5jsSWw=
Subject: FAILED: patch "[PATCH] usb: dwc3: gadget: Handle EP0 request dequeuing properly" failed to apply to 6.1-stable tree
To: quic_wcheng@quicinc.com,Thinh.Nguyen@synopsys.com,gregkh@linuxfoundation.org,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 22 Jan 2024 11:09:03 -0800
Message-ID: <2024012203-spiffy-elongated-5d0b@gregkh>
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
git cherry-pick -x 730e12fbec53ab59dd807d981a204258a4cfb29a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024012203-spiffy-elongated-5d0b@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

730e12fbec53 ("usb: dwc3: gadget: Handle EP0 request dequeuing properly")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 730e12fbec53ab59dd807d981a204258a4cfb29a Mon Sep 17 00:00:00 2001
From: Wesley Cheng <quic_wcheng@quicinc.com>
Date: Wed, 6 Dec 2023 12:18:14 -0800
Subject: [PATCH] usb: dwc3: gadget: Handle EP0 request dequeuing properly

Current EP0 dequeue path will share the same as other EPs.  However, there
are some special considerations that need to be made for EP0 transfers:

  - EP0 transfers never transition into the started_list
  - EP0 only has one active request at a time

In case there is a vendor specific control message for a function over USB
FFS, then there is no guarantee on the timeline which the DATA/STATUS stage
is responded to.  While this occurs, any attempt to end transfers on
non-control EPs will end up having the DWC3_EP_DELAY_STOP flag set, and
defer issuing of the end transfer command.  If the USB FFS application
decides to timeout the control transfer, or if USB FFS AIO path exits, the
USB FFS driver will issue a call to usb_ep_dequeue() for the ep0 request.

In case of the AIO exit path, the AIO FS blocks until all pending USB
requests utilizing the AIO path is completed.  However, since the dequeue
of ep0 req does not happen properly, all non-control EPs with the
DWC3_EP_DELAY_STOP flag set will not be handled, and the AIO exit path will
be stuck waiting for the USB FFS data endpoints to receive a completion
callback.

Fix is to utilize dwc3_ep0_reset_state() in the dequeue API to ensure EP0
is brought back to the SETUP state, and ensures that any deferred end
transfer commands are handled.  This also will end any active transfers
on EP0, compared to the previous implementation which directly called
giveback only.

Fixes: fcd2def66392 ("usb: dwc3: gadget: Refactor dwc3_gadget_ep_dequeue")
Cc: stable <stable@kernel.org>
Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Link: https://lore.kernel.org/r/20231206201814.32664-1-quic_wcheng@quicinc.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 858fe4c299b7..88d8d589f014 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -2103,7 +2103,17 @@ static int dwc3_gadget_ep_dequeue(struct usb_ep *ep,
 
 	list_for_each_entry(r, &dep->pending_list, list) {
 		if (r == req) {
-			dwc3_gadget_giveback(dep, req, -ECONNRESET);
+			/*
+			 * Explicitly check for EP0/1 as dequeue for those
+			 * EPs need to be handled differently.  Control EP
+			 * only deals with one USB req, and giveback will
+			 * occur during dwc3_ep0_stall_and_restart().  EP0
+			 * requests are never added to started_list.
+			 */
+			if (dep->number > 1)
+				dwc3_gadget_giveback(dep, req, -ECONNRESET);
+			else
+				dwc3_ep0_reset_state(dwc);
 			goto out;
 		}
 	}


