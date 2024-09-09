Return-Path: <stable+bounces-73963-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9085B970EAA
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 08:56:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5117228277E
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 06:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E8511AD411;
	Mon,  9 Sep 2024 06:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PPfd8KbQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0461AD3EE
	for <stable@vger.kernel.org>; Mon,  9 Sep 2024 06:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725864989; cv=none; b=oibf8FxllKh5eZeHzZbPGirLGoGos74QMIv5x1wpjonSYmoWkuEBQcwaAt0k4OBhznu9Md9/98WHU8p50Oi5nsnp5YuPfSslbLYs81llWV4ky/P0Kzwu9/6+NFwm0IbIaLqzJfHDBqi8rGlKuXLEB3EGP5CyqGdhYrmBA3rzWB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725864989; c=relaxed/simple;
	bh=ngp/pe6IHiqATDUAzmd696atj3O5/d1xd+Fr1yRMNms=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ofSlC9Na3BgRRnh3+Nf8k8Z3UGu4881wM9dHuBu8upcJ0Oz+iIFIYedgWjT6m5Qrutv0XTKGiuR2jEYk/NcNUi7K441jMs4b9PlWX5NtBYmB7LOkeNKMYxAgm2TQoCDfL5qiZjoVVvjd30OHd1UVc/kHzEX8IR0Au4OeBtxpvxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PPfd8KbQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A89DC4CEC5;
	Mon,  9 Sep 2024 06:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725864988;
	bh=ngp/pe6IHiqATDUAzmd696atj3O5/d1xd+Fr1yRMNms=;
	h=Subject:To:Cc:From:Date:From;
	b=PPfd8KbQvZ9AXMyfD1u8QmgzmslJdCYqc+RTiFemu5sdArYXG4SMA+hpcfhAqo7aZ
	 Jcb1NNu5Y2zMbUPxIcuBiOWRpwv7m7I98bkX1CovlJxQ1W1lOxk0SlWX+pMJv6g2+3
	 J79HpkU3VqOolTgHbM4BhJUzGUxJABwYz4ZlsL5Q=
Subject: FAILED: patch "[PATCH] usb: dwc3: Avoid waking up gadget during startxfer" failed to apply to 5.15-stable tree
To: quic_prashk@quicinc.com,Thinh.Nguyen@synopsys.com,gregkh@linuxfoundation.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 09 Sep 2024 08:56:22 +0200
Message-ID: <2024090922-shrewdly-bright-07e5@gregkh>
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
git cherry-pick -x 00dcf2fa449f23a263343d7fe051741bdde65d0b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024090922-shrewdly-bright-07e5@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

00dcf2fa449f ("usb: dwc3: Avoid waking up gadget during startxfer")
047161686b81 ("usb: dwc3: Add remote wakeup handling")
a02a26eb0aea ("usb: dwc3: gadget: Ignore Update Transfer cmd params")
63c4c320ccf7 ("usb: dwc3: gadget: Check for L1/L2/U3 for Start Transfer")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 00dcf2fa449f23a263343d7fe051741bdde65d0b Mon Sep 17 00:00:00 2001
From: Prashanth K <quic_prashk@quicinc.com>
Date: Wed, 28 Aug 2024 12:13:02 +0530
Subject: [PATCH] usb: dwc3: Avoid waking up gadget during startxfer

When operating in High-Speed, it is observed that DSTS[USBLNKST] doesn't
update link state immediately after receiving the wakeup interrupt. Since
wakeup event handler calls the resume callbacks, there is a chance that
function drivers can perform an ep queue, which in turn tries to perform
remote wakeup from send_gadget_ep_cmd(STARTXFER). This happens because
DSTS[[21:18] wasn't updated to U0 yet, it's observed that the latency of
DSTS can be in order of milli-seconds. Hence avoid calling gadget_wakeup
during startxfer to prevent unnecessarily issuing remote wakeup to host.

Fixes: c36d8e947a56 ("usb: dwc3: gadget: put link to U0 before Start Transfer")
Cc: stable@vger.kernel.org
Suggested-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Signed-off-by: Prashanth K <quic_prashk@quicinc.com>
Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Link: https://lore.kernel.org/r/20240828064302.3796315-1-quic_prashk@quicinc.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 89fc690fdf34..291bc549935b 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -287,6 +287,23 @@ static int __dwc3_gadget_wakeup(struct dwc3 *dwc, bool async);
  *
  * Caller should handle locking. This function will issue @cmd with given
  * @params to @dep and wait for its completion.
+ *
+ * According to the programming guide, if the link state is in L1/L2/U3,
+ * then sending the Start Transfer command may not complete. The
+ * programming guide suggested to bring the link state back to ON/U0 by
+ * performing remote wakeup prior to sending the command. However, don't
+ * initiate remote wakeup when the user/function does not send wakeup
+ * request via wakeup ops. Send the command when it's allowed.
+ *
+ * Notes:
+ * For L1 link state, issuing a command requires the clearing of
+ * GUSB2PHYCFG.SUSPENDUSB2, which turns on the signal required to complete
+ * the given command (usually within 50us). This should happen within the
+ * command timeout set by driver. No additional step is needed.
+ *
+ * For L2 or U3 link state, the gadget is in USB suspend. Care should be
+ * taken when sending Start Transfer command to ensure that it's done after
+ * USB resume.
  */
 int dwc3_send_gadget_ep_cmd(struct dwc3_ep *dep, unsigned int cmd,
 		struct dwc3_gadget_ep_cmd_params *params)
@@ -327,30 +344,6 @@ int dwc3_send_gadget_ep_cmd(struct dwc3_ep *dep, unsigned int cmd,
 			dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
 	}
 
-	if (DWC3_DEPCMD_CMD(cmd) == DWC3_DEPCMD_STARTTRANSFER) {
-		int link_state;
-
-		/*
-		 * Initiate remote wakeup if the link state is in U3 when
-		 * operating in SS/SSP or L1/L2 when operating in HS/FS. If the
-		 * link state is in U1/U2, no remote wakeup is needed. The Start
-		 * Transfer command will initiate the link recovery.
-		 */
-		link_state = dwc3_gadget_get_link_state(dwc);
-		switch (link_state) {
-		case DWC3_LINK_STATE_U2:
-			if (dwc->gadget->speed >= USB_SPEED_SUPER)
-				break;
-
-			fallthrough;
-		case DWC3_LINK_STATE_U3:
-			ret = __dwc3_gadget_wakeup(dwc, false);
-			dev_WARN_ONCE(dwc->dev, ret, "wakeup failed --> %d\n",
-					ret);
-			break;
-		}
-	}
-
 	/*
 	 * For some commands such as Update Transfer command, DEPCMDPARn
 	 * registers are reserved. Since the driver often sends Update Transfer


