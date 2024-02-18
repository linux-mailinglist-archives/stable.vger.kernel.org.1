Return-Path: <stable+bounces-20472-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E478598B5
	for <lists+stable@lfdr.de>; Sun, 18 Feb 2024 19:56:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C35EA1F21A24
	for <lists+stable@lfdr.de>; Sun, 18 Feb 2024 18:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 731EC6F084;
	Sun, 18 Feb 2024 18:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZAglBIVN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B131D696
	for <stable@vger.kernel.org>; Sun, 18 Feb 2024 18:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708282589; cv=none; b=tGTsAMLJzw7JPooMyYGnNHkuMfkIQYerwvhucss8ZsMn75ROIAqzUBbwxSTUZC1h7DkXx76hfcWGx0iOuHz0porLYJRETAcNJYs+n/1g0mfHvPAA5dckMxvurZRAFSqpbgnvz2Zbjbp0O5ztZsXDs6ZLbuFlWFU7gxVt1089W90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708282589; c=relaxed/simple;
	bh=tgmb4cWY2lx+SGho9UlfLyWIXR0ets2/tslkVtCdB6Q=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ZQWO/FNhncoD3EEbkKe+pQxy1BaeOQoVeqMrVxQjbpMeMcmG1p9KuUJj6O5MdbFqpnsA35mKHu9UrvN/JZSArMh1PyLBS26/eBNfFnByLi4QFM/OfsBsTVdTFRx231ykwRanQrygTBgIA9yQXEZ/Bfz1o8WE1enFzTrgTm186pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZAglBIVN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44664C433F1;
	Sun, 18 Feb 2024 18:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708282588;
	bh=tgmb4cWY2lx+SGho9UlfLyWIXR0ets2/tslkVtCdB6Q=;
	h=Subject:To:Cc:From:Date:From;
	b=ZAglBIVNqAHllW9gpY106B/fdQbJwpOIzfmi/BsCFAnM5b5ofzRJwKLUg/Mlxigqq
	 LJn4JXUdQx/5gSVX4tHaO10dUABjMnBlJi6ayCE3WEyr+ikx1yuMDsMrnaXFbPgbzu
	 4Wbpkb/ju8YLmS2KLppSlMdVPwhAW2dMEdjIc4ko=
Subject: FAILED: patch "[PATCH] usb: dwc3: gadget: Fix NULL pointer dereference in" failed to apply to 4.19-stable tree
To: quic_uaggarwa@quicinc.com,Thinh.Nguyen@synopsys.com,gregkh@linuxfoundation.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 18 Feb 2024 19:56:15 +0100
Message-ID: <2024021815-crate-unsettled-85a8@gregkh>
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
git cherry-pick -x 61a348857e869432e6a920ad8ea9132e8d44c316
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024021815-crate-unsettled-85a8@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:

61a348857e86 ("usb: dwc3: gadget: Fix NULL pointer dereference in dwc3_gadget_suspend")
c8540870af4c ("usb: dwc3: gadget: Improve dwc3_gadget_suspend() and dwc3_gadget_resume()")
bdb19d01026a ("USB: dwc3: gadget: drop dead hibernation code")
af870d93c706 ("usb: dwc3: Fix typos in gadget.c")
5265397f9442 ("usb: dwc3: Remove DWC3 locking during gadget suspend/resume")
9711c67de748 ("usb: dwc3: gadget: Synchronize IRQ between soft connect/disconnect")
8f8034f493b5 ("usb: dwc3: gadget: Don't modify GEVNTCOUNT in pullup()")
861c010a2ee1 ("usb: dwc3: gadget: Refactor pullup()")
0066472de157 ("usb: dwc3: Issue core soft reset before enabling run/stop")
8217f07a5023 ("usb: dwc3: gadget: Avoid starting DWC3 gadget during UDC unbind")
8212937305f8 ("usb: dwc3: gadget: Disable gadget IRQ during pullup disable")
f09ddcfcb8c5 ("usb: dwc3: gadget: Prevent EP queuing while stopping transfers")
a66a7d48f34a ("Merge 5.11-rc3 into usb-next")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 61a348857e869432e6a920ad8ea9132e8d44c316 Mon Sep 17 00:00:00 2001
From: Uttkarsh Aggarwal <quic_uaggarwa@quicinc.com>
Date: Fri, 19 Jan 2024 15:18:25 +0530
Subject: [PATCH] usb: dwc3: gadget: Fix NULL pointer dereference in
 dwc3_gadget_suspend

In current scenario if Plug-out and Plug-In performed continuously
there could be a chance while checking for dwc->gadget_driver in
dwc3_gadget_suspend, a NULL pointer dereference may occur.

Call Stack:

	CPU1:                           CPU2:
	gadget_unbind_driver            dwc3_suspend_common
	dwc3_gadget_stop                dwc3_gadget_suspend
                                        dwc3_disconnect_gadget

CPU1 basically clears the variable and CPU2 checks the variable.
Consider CPU1 is running and right before gadget_driver is cleared
and in parallel CPU2 executes dwc3_gadget_suspend where it finds
dwc->gadget_driver which is not NULL and resumes execution and then
CPU1 completes execution. CPU2 executes dwc3_disconnect_gadget where
it checks dwc->gadget_driver is already NULL because of which the
NULL pointer deference occur.

Cc: stable@vger.kernel.org
Fixes: 9772b47a4c29 ("usb: dwc3: gadget: Fix suspend/resume during device mode")
Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Signed-off-by: Uttkarsh Aggarwal <quic_uaggarwa@quicinc.com>
Link: https://lore.kernel.org/r/20240119094825.26530-1-quic_uaggarwa@quicinc.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 019368f8e9c4..564976b3e2b9 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -4709,15 +4709,13 @@ int dwc3_gadget_suspend(struct dwc3 *dwc)
 	unsigned long flags;
 	int ret;
 
-	if (!dwc->gadget_driver)
-		return 0;
-
 	ret = dwc3_gadget_soft_disconnect(dwc);
 	if (ret)
 		goto err;
 
 	spin_lock_irqsave(&dwc->lock, flags);
-	dwc3_disconnect_gadget(dwc);
+	if (dwc->gadget_driver)
+		dwc3_disconnect_gadget(dwc);
 	spin_unlock_irqrestore(&dwc->lock, flags);
 
 	return 0;


