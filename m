Return-Path: <stable+bounces-172653-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 005FDB32A11
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 17:59:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6857582D45
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 15:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40F062E975B;
	Sat, 23 Aug 2025 15:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hHG7UMZs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24D92EBBA2
	for <stable@vger.kernel.org>; Sat, 23 Aug 2025 15:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755964678; cv=none; b=N8ff9/BxABpfH2d5rXM1twaSP9CL8c4ZvmQVucETgEdB5OZTS5C0yT0dXB3Pg9zVKAPZLgAciYFWlnp86uZ+Qqm34z663ULknrhQ585fkoZnRZXzbllNGF6RBwqtWDqEZ2IN3Mq0Oaa925bu5Bzt3g9uC6HOEtj4RwQTM6gevYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755964678; c=relaxed/simple;
	bh=7I0fmBM86lznD1LhUTnYje7Ae3LU+Z2aOdHFE2k/Vc8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=iD2Fy67Vk+qprZjYIoMzzkhgXWwHPpzZyN0PU7bNwnsVV4C6YjbaF3aKzuy8lNPiLZQWh0G0n0CmppfySsTv//Q7v60AUBNGHx3SnP3vpv66rDeqIfpLBzeFrWcnq3xXN5VBJR66Gok/Iukcx8cWW5KnmUjz/hfFYRM08tYqVAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hHG7UMZs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77230C4CEE7;
	Sat, 23 Aug 2025 15:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755964677;
	bh=7I0fmBM86lznD1LhUTnYje7Ae3LU+Z2aOdHFE2k/Vc8=;
	h=Subject:To:Cc:From:Date:From;
	b=hHG7UMZsXhxpzE5zpLdCg2jwqo0J0UkmqeHfGyxe0KUEpuzoqub7UOcd37ttl+iAa
	 Dveq73vb9z74y37T6TtKGbr5ILHJ/tFFafxurxmZkEvB2931GoPel0miZS06H7Z/y+
	 cslXxOOvgzd8omgmsvUkeKZ/Wdl+e4ek4M9EL9W8=
Subject: FAILED: patch "[PATCH] usb: dwc3: Remove WARN_ON for device endpoint command" failed to apply to 5.4-stable tree
To: selvarasu.g@samsung.com,Thinh.Nguyen@synopsys.com,akash.m5@samsung.com,bigeasy@linutronix.de,gregkh@linuxfoundation.org,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 23 Aug 2025 17:57:47 +0200
Message-ID: <2025082347-mounting-plausible-6994@gregkh>
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
git cherry-pick -x 45eae113dccaf8e502090ecf5b3d9e9b805add6f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025082347-mounting-plausible-6994@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 45eae113dccaf8e502090ecf5b3d9e9b805add6f Mon Sep 17 00:00:00 2001
From: Selvarasu Ganesan <selvarasu.g@samsung.com>
Date: Fri, 8 Aug 2025 18:23:05 +0530
Subject: [PATCH] usb: dwc3: Remove WARN_ON for device endpoint command
 timeouts

This commit addresses a rarely observed endpoint command timeout
which causes kernel panic due to warn when 'panic_on_warn' is enabled
and unnecessary call trace prints when 'panic_on_warn' is disabled.
It is seen during fast software-controlled connect/disconnect testcases.
The following is one such endpoint command timeout that we observed:

1. Connect
   =======
->dwc3_thread_interrupt
 ->dwc3_ep0_interrupt
  ->configfs_composite_setup
   ->composite_setup
    ->usb_ep_queue
     ->dwc3_gadget_ep0_queue
      ->__dwc3_gadget_ep0_queue
       ->__dwc3_ep0_do_control_data
        ->dwc3_send_gadget_ep_cmd

2. Disconnect
   ==========
->dwc3_thread_interrupt
 ->dwc3_gadget_disconnect_interrupt
  ->dwc3_ep0_reset_state
   ->dwc3_ep0_end_control_data
    ->dwc3_send_gadget_ep_cmd

In the issue scenario, in Exynos platforms, we observed that control
transfers for the previous connect have not yet been completed and end
transfer command sent as a part of the disconnect sequence and
processing of USB_ENDPOINT_HALT feature request from the host timeout.
This maybe an expected scenario since the controller is processing EP
commands sent as a part of the previous connect. It maybe better to
remove WARN_ON in all places where device endpoint commands are sent to
avoid unnecessary kernel panic due to warn.

Cc: stable <stable@kernel.org>
Co-developed-by: Akash M <akash.m5@samsung.com>
Signed-off-by: Akash M <akash.m5@samsung.com>
Signed-off-by: Selvarasu Ganesan <selvarasu.g@samsung.com>
Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Link: https://lore.kernel.org/r/20250808125315.1607-1-selvarasu.g@samsung.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
index 666ac432f52d..b4229aa13f37 100644
--- a/drivers/usb/dwc3/ep0.c
+++ b/drivers/usb/dwc3/ep0.c
@@ -288,7 +288,9 @@ void dwc3_ep0_out_start(struct dwc3 *dwc)
 	dwc3_ep0_prepare_one_trb(dep, dwc->ep0_trb_addr, 8,
 			DWC3_TRBCTL_CONTROL_SETUP, false);
 	ret = dwc3_ep0_start_trans(dep);
-	WARN_ON(ret < 0);
+	if (ret < 0)
+		dev_err(dwc->dev, "ep0 out start transfer failed: %d\n", ret);
+
 	for (i = 2; i < DWC3_ENDPOINTS_NUM; i++) {
 		struct dwc3_ep *dwc3_ep;
 
@@ -1061,7 +1063,9 @@ static void __dwc3_ep0_do_control_data(struct dwc3 *dwc,
 		ret = dwc3_ep0_start_trans(dep);
 	}
 
-	WARN_ON(ret < 0);
+	if (ret < 0)
+		dev_err(dwc->dev,
+			"ep0 data phase start transfer failed: %d\n", ret);
 }
 
 static int dwc3_ep0_start_control_status(struct dwc3_ep *dep)
@@ -1078,7 +1082,12 @@ static int dwc3_ep0_start_control_status(struct dwc3_ep *dep)
 
 static void __dwc3_ep0_do_control_status(struct dwc3 *dwc, struct dwc3_ep *dep)
 {
-	WARN_ON(dwc3_ep0_start_control_status(dep));
+	int	ret;
+
+	ret = dwc3_ep0_start_control_status(dep);
+	if (ret)
+		dev_err(dwc->dev,
+			"ep0 status phase start transfer failed: %d\n", ret);
 }
 
 static void dwc3_ep0_do_control_status(struct dwc3 *dwc,
@@ -1121,7 +1130,10 @@ void dwc3_ep0_end_control_data(struct dwc3 *dwc, struct dwc3_ep *dep)
 	cmd |= DWC3_DEPCMD_PARAM(dep->resource_index);
 	memset(&params, 0, sizeof(params));
 	ret = dwc3_send_gadget_ep_cmd(dep, cmd, &params);
-	WARN_ON_ONCE(ret);
+	if (ret)
+		dev_err_ratelimited(dwc->dev,
+			"ep0 data phase end transfer failed: %d\n", ret);
+
 	dep->resource_index = 0;
 }
 
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 68fa2813e5f4..554f997eb8c4 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -1772,7 +1772,11 @@ static int __dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force, bool int
 		dep->flags |= DWC3_EP_DELAY_STOP;
 		return 0;
 	}
-	WARN_ON_ONCE(ret);
+
+	if (ret)
+		dev_err_ratelimited(dep->dwc->dev,
+				"end transfer failed: %d\n", ret);
+
 	dep->resource_index = 0;
 
 	if (!interrupt)
@@ -4048,7 +4052,9 @@ static void dwc3_clear_stall_all_ep(struct dwc3 *dwc)
 		dep->flags &= ~DWC3_EP_STALL;
 
 		ret = dwc3_send_clear_stall_ep_cmd(dep);
-		WARN_ON_ONCE(ret);
+		if (ret)
+			dev_err_ratelimited(dwc->dev,
+				"failed to clear STALL on %s\n", dep->name);
 	}
 }
 


