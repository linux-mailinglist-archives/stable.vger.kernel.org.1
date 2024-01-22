Return-Path: <stable+bounces-12736-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7324F83725F
	for <lists+stable@lfdr.de>; Mon, 22 Jan 2024 20:22:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D98BBB2D1A4
	for <lists+stable@lfdr.de>; Mon, 22 Jan 2024 19:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D72CD5676C;
	Mon, 22 Jan 2024 18:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Mib0ikpA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941C456767
	for <stable@vger.kernel.org>; Mon, 22 Jan 2024 18:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705948982; cv=none; b=AgEliWYXTz1KC9XVuISPdWCm7TerbgN2lQQtR2UvnLc7rakOmmzpNnYyP7p8Z1Bu9KbQXnBCh//Up4l7An58IjY+XWSjRfNmtp28gtEmDp7f/QJU1nwMAPNpmDzfGaRNpz5QU82OPM2o+/jO2CXL/68OO1gNCq/rYEaRw4Zc6+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705948982; c=relaxed/simple;
	bh=CKVslO/zstXmHVEYZfSHblvViZroty2O1sXDue2geng=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=qdieAzTBhsqCyizgxjnCgxtdCk2+w193qsjp0l0mfj1Ntd+jWXSRHqVNd8dZdOx2fkWlHOuKQg9fzCX+EqrKNI+AovwulYDo7eT8zXPZnIKJu9qMzlzc6KdbMmcAgeDo4z6GkfWcl0m6D0ScfW+SCmXtJs1cpe7FAxssACxuziE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Mib0ikpA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E482FC43399;
	Mon, 22 Jan 2024 18:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705948982;
	bh=CKVslO/zstXmHVEYZfSHblvViZroty2O1sXDue2geng=;
	h=Subject:To:Cc:From:Date:From;
	b=Mib0ikpAooN8u9tKONK0Vqk8NQIrnrEIdJWqVYI5YMUcDqQTliHQBb0IDR4WJ8lF+
	 KXC50ec08Hk+8+Rq0gG8H7UMX21PtG0aSzh3oJmSXF237ytWnfAveKtv+MSzO3wS4P
	 SEoOmB0nqyRrovDW0nmArityT2yver89yc2aQ+Q8=
Subject: FAILED: patch "[PATCH] usb: dwc3: gadget: Queue PM runtime idle on disconnect event" failed to apply to 6.1-stable tree
To: quic_wcheng@quicinc.com,gregkh@linuxfoundation.org,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 22 Jan 2024 10:43:00 -0800
Message-ID: <2024012200-bobbing-scotch-3ddc@gregkh>
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
git cherry-pick -x 3c7af52c7616c3aa6dacd2336ec748d4a65df8f4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024012200-bobbing-scotch-3ddc@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

3c7af52c7616 ("usb: dwc3: gadget: Queue PM runtime idle on disconnect event")
8f40fc080813 ("usb: dwc3: gadget: Refactor EP0 forced stall/restart into a separate API")
02435a739b81 ("usb: dwc3: gadget: Stall and restart EP0 if host is unresponsive")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 3c7af52c7616c3aa6dacd2336ec748d4a65df8f4 Mon Sep 17 00:00:00 2001
From: Wesley Cheng <quic_wcheng@quicinc.com>
Date: Wed, 3 Jan 2024 13:49:46 -0800
Subject: [PATCH] usb: dwc3: gadget: Queue PM runtime idle on disconnect event

There is a scenario where DWC3 runtime suspend is blocked due to the
dwc->connected flag still being true while PM usage_count is zero after
DWC3 giveback is completed and the USB gadget session is being terminated.
This leads to a case where nothing schedules a PM runtime idle for the
device.

The exact condition is seen with the following sequence:
  1.  USB bus reset is issued by the host
  2.  Shortly after, or concurrently, a USB PD DR SWAP request is received
      (sink->source)
  3.  USB bus reset event handler runs and issues
      dwc3_stop_active_transfers(), and pending transfer are stopped
  4.  DWC3 usage_count decremented to 0, and runtime idle occurs while
      dwc->connected == true, returns -EBUSY
  5.  DWC3 disconnect event seen, dwc->connected set to false due to DR
      swap handling
  6.  No runtime idle after this point

Address this by issuing an asynchronous PM runtime idle call after the
disconnect event is completed, as it modifies the dwc->connected flag,
which is what blocks the initial runtime idle.

Fixes: fc8bb91bc83e ("usb: dwc3: implement runtime PM")
Cc:  <stable@vger.kernel.org>
Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
Link: https://lore.kernel.org/r/20240103214946.2596-1-quic_wcheng@quicinc.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index c15e965ea95a..019368f8e9c4 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -3989,6 +3989,13 @@ static void dwc3_gadget_disconnect_interrupt(struct dwc3 *dwc)
 	usb_gadget_set_state(dwc->gadget, USB_STATE_NOTATTACHED);
 
 	dwc3_ep0_reset_state(dwc);
+
+	/*
+	 * Request PM idle to address condition where usage count is
+	 * already decremented to zero, but waiting for the disconnect
+	 * interrupt to set dwc->connected to FALSE.
+	 */
+	pm_request_idle(dwc->dev);
 }
 
 static void dwc3_gadget_reset_interrupt(struct dwc3 *dwc)


