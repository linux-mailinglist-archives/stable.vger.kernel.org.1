Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10DC270C431
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 19:24:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231557AbjEVRYG (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 13:24:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231538AbjEVRYF (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 13:24:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A560E118
        for <stable@vger.kernel.org>; Mon, 22 May 2023 10:24:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0E10661D76
        for <stable@vger.kernel.org>; Mon, 22 May 2023 17:24:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A1E6C4339B;
        Mon, 22 May 2023 17:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684776241;
        bh=XEJg1jFFUgnNQZtti5FxvZ8rHigHvBjzyvhZxUTrVIQ=;
        h=Subject:To:Cc:From:Date:From;
        b=DCV0Z0cbzgI1gERERNulpAsg9DWgPAJv4wl/+6ErpwOii+CKcDLsqszQg84lx64hq
         jy/Q/UmoKJl/CnFGsBY5NzcDUGXBE5iSyB+HpOUiWET8ZCaJLXr2gk2yjbqlXQnz6H
         wydBaNB5VkThNC87ZDtKd0pgGRFmpC5xwM0jazYE=
Subject: FAILED: patch "[PATCH] usb: dwc3: fix gadget mode suspend interrupt handler issue" failed to apply to 5.15-stable tree
To:     quic_linyyuan@quicinc.com, Thinh.Nguyen@synopsys.com,
        gregkh@linuxfoundation.org, stable@kernel.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Mon, 22 May 2023 18:23:55 +0100
Message-ID: <2023052255-basics-sixfold-353c@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 4e8ef34e36f2839ef8c8da521ab7035956436818
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023052255-basics-sixfold-353c@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

4e8ef34e36f2 ("usb: dwc3: fix gadget mode suspend interrupt handler issue")
92c08a84b53e ("usb: dwc3: Add function suspend and function wakeup support")
047161686b81 ("usb: dwc3: Add remote wakeup handling")
63c4c320ccf7 ("usb: dwc3: gadget: Check for L1/L2/U3 for Start Transfer")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 4e8ef34e36f2839ef8c8da521ab7035956436818 Mon Sep 17 00:00:00 2001
From: Linyu Yuan <quic_linyyuan@quicinc.com>
Date: Fri, 12 May 2023 08:45:24 +0800
Subject: [PATCH] usb: dwc3: fix gadget mode suspend interrupt handler issue

When work in gadget mode, currently driver doesn't update software level
link_state correctly as link state change event is not enabled for most
devices, in function dwc3_gadget_suspend_interrupt(), it will only pass
suspend event to UDC core when software level link state changes, so when
interrupt generated in sequences of suspend -> reset -> conndone ->
suspend, link state is not updated during reset and conndone, so second
suspend interrupt event will not pass to UDC core.

Remove link_state compare in dwc3_gadget_suspend_interrupt() and add a
suspended flag to replace the compare function.

Fixes: 799e9dc82968 ("usb: dwc3: gadget: conditionally disable Link State change events")
Cc: stable <stable@kernel.org>
Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Signed-off-by: Linyu Yuan <quic_linyyuan@quicinc.com>
Link: https://lore.kernel.org/r/20230512004524.31950-1-quic_linyyuan@quicinc.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index d56457c02996..1f043c31a096 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -1116,6 +1116,7 @@ struct dwc3_scratchpad_array {
  * @dis_metastability_quirk: set to disable metastability quirk.
  * @dis_split_quirk: set to disable split boundary.
  * @wakeup_configured: set if the device is configured for remote wakeup.
+ * @suspended: set to track suspend event due to U3/L2.
  * @imod_interval: set the interrupt moderation interval in 250ns
  *			increments or 0 to disable.
  * @max_cfg_eps: current max number of IN eps used across all USB configs.
@@ -1332,6 +1333,7 @@ struct dwc3 {
 	unsigned		dis_split_quirk:1;
 	unsigned		async_callbacks:1;
 	unsigned		wakeup_configured:1;
+	unsigned		suspended:1;
 
 	u16			imod_interval;
 
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 2996bcb4d53d..d831f5acf7b5 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -2440,6 +2440,7 @@ static int dwc3_gadget_func_wakeup(struct usb_gadget *g, int intf_id)
 			return -EINVAL;
 		}
 		dwc3_resume_gadget(dwc);
+		dwc->suspended = false;
 		dwc->link_state = DWC3_LINK_STATE_U0;
 	}
 
@@ -3942,6 +3943,8 @@ static void dwc3_gadget_disconnect_interrupt(struct dwc3 *dwc)
 {
 	int			reg;
 
+	dwc->suspended = false;
+
 	dwc3_gadget_set_link_state(dwc, DWC3_LINK_STATE_RX_DET);
 
 	reg = dwc3_readl(dwc->regs, DWC3_DCTL);
@@ -3966,6 +3969,8 @@ static void dwc3_gadget_reset_interrupt(struct dwc3 *dwc)
 {
 	u32			reg;
 
+	dwc->suspended = false;
+
 	/*
 	 * Ideally, dwc3_reset_gadget() would trigger the function
 	 * drivers to stop any active transfers through ep disable.
@@ -4184,6 +4189,8 @@ static void dwc3_gadget_conndone_interrupt(struct dwc3 *dwc)
 
 static void dwc3_gadget_wakeup_interrupt(struct dwc3 *dwc, unsigned int evtinfo)
 {
+	dwc->suspended = false;
+
 	/*
 	 * TODO take core out of low power mode when that's
 	 * implemented.
@@ -4281,6 +4288,7 @@ static void dwc3_gadget_linksts_change_interrupt(struct dwc3 *dwc,
 		if (dwc->gadget->wakeup_armed) {
 			dwc3_gadget_enable_linksts_evts(dwc, false);
 			dwc3_resume_gadget(dwc);
+			dwc->suspended = false;
 		}
 		break;
 	case DWC3_LINK_STATE_U1:
@@ -4307,8 +4315,10 @@ static void dwc3_gadget_suspend_interrupt(struct dwc3 *dwc,
 {
 	enum dwc3_link_state next = evtinfo & DWC3_LINK_STATE_MASK;
 
-	if (dwc->link_state != next && next == DWC3_LINK_STATE_U3)
+	if (!dwc->suspended && next == DWC3_LINK_STATE_U3) {
+		dwc->suspended = true;
 		dwc3_suspend_gadget(dwc);
+	}
 
 	dwc->link_state = next;
 }

