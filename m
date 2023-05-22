Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0C2E70C425
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 19:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231460AbjEVRXD (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 13:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231429AbjEVRW5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 13:22:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0867E9
        for <stable@vger.kernel.org>; Mon, 22 May 2023 10:22:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 655A661FFC
        for <stable@vger.kernel.org>; Mon, 22 May 2023 17:22:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88E88C433EF;
        Mon, 22 May 2023 17:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684776175;
        bh=Vq4L4PcFNAvl9VPIEQ48bcOmvnUp7o4gSVMCA0aokHc=;
        h=Subject:To:Cc:From:Date:From;
        b=XnIiU7BpajnMbeLAvphdJtxbhUSAOG3TL2LxZgNAzlTrFpHU+gWqory6AxA6kzYyH
         omq/DnlfkCtJwAl8Nz+XgrrD2gEDVAnxloH/s3vYiN9CP+DG7vIrEd670imH5xO6p2
         yZC+DS7J7HWx7Ms3/nDpZd1zHyE5/PmwDLJ/qSKQ=
Subject: FAILED: patch "[PATCH] usb: dwc3: gadget: Improve dwc3_gadget_suspend() and" failed to apply to 5.10-stable tree
To:     rogerq@kernel.org, Thinh.Nguyen@synopsys.com,
        gregkh@linuxfoundation.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Mon, 22 May 2023 18:22:50 +0100
Message-ID: <2023052250-sassy-sagging-9cf0@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x c8540870af4ce6ddeb27a7bb5498b75fb29b643c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023052250-sassy-sagging-9cf0@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

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

From c8540870af4ce6ddeb27a7bb5498b75fb29b643c Mon Sep 17 00:00:00 2001
From: Roger Quadros <rogerq@kernel.org>
Date: Wed, 3 May 2023 14:00:48 +0300
Subject: [PATCH] usb: dwc3: gadget: Improve dwc3_gadget_suspend() and
 dwc3_gadget_resume()

Prevent -ETIMEDOUT error on .suspend().
e.g. If gadget driver is loaded and we are connected to a USB host,
all transfers must be stopped before stopping the controller else
we will not get a clean stop i.e. dwc3_gadget_run_stop() will take
several seconds to complete and will return -ETIMEDOUT.

Handle error cases properly in dwc3_gadget_suspend().
Simplify dwc3_gadget_resume() by using the introduced helper function.

Fixes: 9f8a67b65a49 ("usb: dwc3: gadget: fix gadget suspend/resume")
Cc: stable@vger.kernel.org
Suggested-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Signed-off-by: Roger Quadros <rogerq@kernel.org>
Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Link: https://lore.kernel.org/r/20230503110048.30617-1-rogerq@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index c0ca4d12f95d..2996bcb4d53d 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -2699,6 +2699,21 @@ static int dwc3_gadget_soft_disconnect(struct dwc3 *dwc)
 	return ret;
 }
 
+static int dwc3_gadget_soft_connect(struct dwc3 *dwc)
+{
+	/*
+	 * In the Synopsys DWC_usb31 1.90a programming guide section
+	 * 4.1.9, it specifies that for a reconnect after a
+	 * device-initiated disconnect requires a core soft reset
+	 * (DCTL.CSftRst) before enabling the run/stop bit.
+	 */
+	dwc3_core_soft_reset(dwc);
+
+	dwc3_event_buffers_setup(dwc);
+	__dwc3_gadget_start(dwc);
+	return dwc3_gadget_run_stop(dwc, true);
+}
+
 static int dwc3_gadget_pullup(struct usb_gadget *g, int is_on)
 {
 	struct dwc3		*dwc = gadget_to_dwc(g);
@@ -2737,21 +2752,10 @@ static int dwc3_gadget_pullup(struct usb_gadget *g, int is_on)
 
 	synchronize_irq(dwc->irq_gadget);
 
-	if (!is_on) {
+	if (!is_on)
 		ret = dwc3_gadget_soft_disconnect(dwc);
-	} else {
-		/*
-		 * In the Synopsys DWC_usb31 1.90a programming guide section
-		 * 4.1.9, it specifies that for a reconnect after a
-		 * device-initiated disconnect requires a core soft reset
-		 * (DCTL.CSftRst) before enabling the run/stop bit.
-		 */
-		dwc3_core_soft_reset(dwc);
-
-		dwc3_event_buffers_setup(dwc);
-		__dwc3_gadget_start(dwc);
-		ret = dwc3_gadget_run_stop(dwc, true);
-	}
+	else
+		ret = dwc3_gadget_soft_connect(dwc);
 
 	pm_runtime_put(dwc->dev);
 
@@ -4655,42 +4659,39 @@ void dwc3_gadget_exit(struct dwc3 *dwc)
 int dwc3_gadget_suspend(struct dwc3 *dwc)
 {
 	unsigned long flags;
+	int ret;
 
 	if (!dwc->gadget_driver)
 		return 0;
 
-	dwc3_gadget_run_stop(dwc, false);
+	ret = dwc3_gadget_soft_disconnect(dwc);
+	if (ret)
+		goto err;
 
 	spin_lock_irqsave(&dwc->lock, flags);
 	dwc3_disconnect_gadget(dwc);
-	__dwc3_gadget_stop(dwc);
 	spin_unlock_irqrestore(&dwc->lock, flags);
 
 	return 0;
+
+err:
+	/*
+	 * Attempt to reset the controller's state. Likely no
+	 * communication can be established until the host
+	 * performs a port reset.
+	 */
+	if (dwc->softconnect)
+		dwc3_gadget_soft_connect(dwc);
+
+	return ret;
 }
 
 int dwc3_gadget_resume(struct dwc3 *dwc)
 {
-	int			ret;
-
 	if (!dwc->gadget_driver || !dwc->softconnect)
 		return 0;
 
-	ret = __dwc3_gadget_start(dwc);
-	if (ret < 0)
-		goto err0;
-
-	ret = dwc3_gadget_run_stop(dwc, true);
-	if (ret < 0)
-		goto err1;
-
-	return 0;
-
-err1:
-	__dwc3_gadget_stop(dwc);
-
-err0:
-	return ret;
+	return dwc3_gadget_soft_connect(dwc);
 }
 
 void dwc3_gadget_process_pending_events(struct dwc3 *dwc)

