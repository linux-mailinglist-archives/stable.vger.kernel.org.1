Return-Path: <stable+bounces-20471-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE9B38598B4
	for <lists+stable@lfdr.de>; Sun, 18 Feb 2024 19:56:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6485A281502
	for <lists+stable@lfdr.de>; Sun, 18 Feb 2024 18:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3615922061;
	Sun, 18 Feb 2024 18:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DybAVu7K"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8921D696
	for <stable@vger.kernel.org>; Sun, 18 Feb 2024 18:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708282586; cv=none; b=U487jddF8IT5JUDa5yUukQ8u6jtyf3GQ1BUZ3/I74nwVm23NdfYwM9xIs8UMKyG4evkrTgXR7R9oifcZ55+e0GQByPkmCiTSCMoVMFa14BC7RgkMaBWJktu35aNfG7YqMacMWU5+F3Pnq84OSqA3xLmd09NnjX7wAWTytW5ytOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708282586; c=relaxed/simple;
	bh=5sVCc6Edleiv+uoDwbYOlUBDMM6iUo1Uaz+RkkKC6qc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=udoE0XAJvTC/roD107PzpS/TZO8yCg2mjQvTAS9IIl3ChQJrFBrgjQGqJJ+IxFmi08z6gfh1DkjZFakgRasSQ3ApVE1DiCF5Qmdvs6P13ZDazDZ3YHWqAryr6EbTkqJ7Z9DSIEzB/cFaYrVoq/Ayc0IdBCBmK6MhTGcPlzLAYsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DybAVu7K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1987FC433C7;
	Sun, 18 Feb 2024 18:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708282585;
	bh=5sVCc6Edleiv+uoDwbYOlUBDMM6iUo1Uaz+RkkKC6qc=;
	h=Subject:To:Cc:From:Date:From;
	b=DybAVu7K0vtjlyQgxzI9SOWM2jCgt8UgYo0z6PzuqwMjVQABpVzEo20UHQaJqTl8B
	 WAJhsJc1ivJlwHwkIq+l9TUmfvv6viGzKH0XYTodzf8t57X/sarU4ppVxOzPWjjY3O
	 Rj/JPhavwvCbR3jxRSPixE8lxNpXvYqZZM+uIdpk=
Subject: FAILED: patch "[PATCH] usb: dwc3: gadget: Fix NULL pointer dereference in" failed to apply to 5.4-stable tree
To: quic_uaggarwa@quicinc.com,Thinh.Nguyen@synopsys.com,gregkh@linuxfoundation.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 18 Feb 2024 19:56:14 +0100
Message-ID: <2024021814-anointer-vanish-667b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 61a348857e869432e6a920ad8ea9132e8d44c316
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024021814-anointer-vanish-667b@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

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


