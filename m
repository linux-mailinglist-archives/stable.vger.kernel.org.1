Return-Path: <stable+bounces-33899-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20DC5893995
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 11:42:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4145A1C21540
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 09:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5905C101EB;
	Mon,  1 Apr 2024 09:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XPvneCs9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2FC10788
	for <stable@vger.kernel.org>; Mon,  1 Apr 2024 09:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711964522; cv=none; b=faX0ISDHRoipemlP9Q+Nw7tfbYyUyZGWHNKY7pEv50mInNt3/A0urLUYPkq18fTH4MEOTzy1p8osWECmB2Fpvx/S0Wvzh8Lysm3gLd/Jq80J7DM/Paienr9xz+hXCUYOfUWc8hDukN4QuhDWTB7yvuLB8OhHWeva06VmfdOCE0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711964522; c=relaxed/simple;
	bh=qj4r6vBfDjdnFweToxpsTmfrq6On2fmKJipfzGh5t9o=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=tIJsoi3MsYWSj8QLoIr52d+WC50DOmcsTb7Wnf5WD4kzsD/U9YRrjYZgnKvHVHzcUtmBvBw3pmQ9StZaB/cT+1horklKiz1McFe9GQYKqZoxb045KyKUN47aLkf7TdsOnqx5xBEoZitabsOwa4Oqet1HmAe2uiXIeIidvA38OiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XPvneCs9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CF5DC433C7;
	Mon,  1 Apr 2024 09:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711964522;
	bh=qj4r6vBfDjdnFweToxpsTmfrq6On2fmKJipfzGh5t9o=;
	h=Subject:To:Cc:From:Date:From;
	b=XPvneCs9MghDJP6aj5gM3yBf0MXAwQuda9gWOPac2ESqZFGY0m/gcc+Tgbsqu2lN7
	 r5nhODsf1bv+37UcLSxWx/h17WF/tBKAbZfrj0SnYfjfkJrWlIZy4eak/us0B8vQkj
	 VJlUbS2kS5vOKZNBaB2h3fo7pEZIuq48CWcZJn1M=
Subject: FAILED: patch "[PATCH] usb: dwc3: Properly set system wakeup" failed to apply to 6.1-stable tree
To: Thinh.Nguyen@synopsys.com,Sanath.S@amd.com,gpiccoli@igalia.com,gregkh@linuxfoundation.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 01 Apr 2024 11:41:58 +0200
Message-ID: <2024040158-headrest-purge-7899@gregkh>
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
git cherry-pick -x f9aa41130ac69d13a53ce2a153ca79c70d43f39c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024040158-headrest-purge-7899@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

f9aa41130ac6 ("usb: dwc3: Properly set system wakeup")
047161686b81 ("usb: dwc3: Add remote wakeup handling")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f9aa41130ac69d13a53ce2a153ca79c70d43f39c Mon Sep 17 00:00:00 2001
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Date: Fri, 8 Mar 2024 02:40:25 +0000
Subject: [PATCH] usb: dwc3: Properly set system wakeup

If the device is configured for system wakeup, then make sure that the
xHCI driver knows about it and make sure to permit wakeup only at the
appropriate time.

For host mode, if the controller goes through the dwc3 code path, then a
child xHCI platform device is created. Make sure the platform device
also inherits the wakeup setting for xHCI to enable remote wakeup.

For device mode, make sure to disable system wakeup if no gadget driver
is bound. We may experience unwanted system wakeup due to the wakeup
signal from the controller PMU detecting connection/disconnection when
in low power (D3). E.g. In the case of Steam Deck, the PCI PME prevents
the system staying in suspend.

Cc: stable@vger.kernel.org
Reported-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
Closes: https://lore.kernel.org/linux-usb/70a7692d-647c-9be7-00a6-06fc60f77294@igalia.com/T/#mf00d6669c2eff7b308d1162acd1d66c09f0853c7
Fixes: d07e8819a03d ("usb: dwc3: add xHCI Host support")
Signed-off-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Tested-by: Sanath S <Sanath.S@amd.com>
Tested-by: Guilherme G. Piccoli <gpiccoli@igalia.com> # Steam Deck
Link: https://lore.kernel.org/r/667cfda7009b502e08462c8fb3f65841d103cc0a.1709865476.git.Thinh.Nguyen@synopsys.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 3e55838c0001..31684cdaaae3 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -1519,6 +1519,8 @@ static void dwc3_get_properties(struct dwc3 *dwc)
 	else
 		dwc->sysdev = dwc->dev;
 
+	dwc->sys_wakeup = device_may_wakeup(dwc->sysdev);
+
 	ret = device_property_read_string(dev, "usb-psy-name", &usb_psy_name);
 	if (ret >= 0) {
 		dwc->usb_psy = power_supply_get_by_name(usb_psy_name);
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index c07edfc954f7..7e80dd3d466b 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -1133,6 +1133,7 @@ struct dwc3_scratchpad_array {
  *	3	- Reserved
  * @dis_metastability_quirk: set to disable metastability quirk.
  * @dis_split_quirk: set to disable split boundary.
+ * @sys_wakeup: set if the device may do system wakeup.
  * @wakeup_configured: set if the device is configured for remote wakeup.
  * @suspended: set to track suspend event due to U3/L2.
  * @imod_interval: set the interrupt moderation interval in 250ns
@@ -1357,6 +1358,7 @@ struct dwc3 {
 
 	unsigned		dis_split_quirk:1;
 	unsigned		async_callbacks:1;
+	unsigned		sys_wakeup:1;
 	unsigned		wakeup_configured:1;
 	unsigned		suspended:1;
 
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 40c52dbc28d3..4df2661f6675 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -2955,6 +2955,9 @@ static int dwc3_gadget_start(struct usb_gadget *g,
 	dwc->gadget_driver	= driver;
 	spin_unlock_irqrestore(&dwc->lock, flags);
 
+	if (dwc->sys_wakeup)
+		device_wakeup_enable(dwc->sysdev);
+
 	return 0;
 }
 
@@ -2970,6 +2973,9 @@ static int dwc3_gadget_stop(struct usb_gadget *g)
 	struct dwc3		*dwc = gadget_to_dwc(g);
 	unsigned long		flags;
 
+	if (dwc->sys_wakeup)
+		device_wakeup_disable(dwc->sysdev);
+
 	spin_lock_irqsave(&dwc->lock, flags);
 	dwc->gadget_driver	= NULL;
 	dwc->max_cfg_eps = 0;
@@ -4651,6 +4657,10 @@ int dwc3_gadget_init(struct dwc3 *dwc)
 	else
 		dwc3_gadget_set_speed(dwc->gadget, dwc->maximum_speed);
 
+	/* No system wakeup if no gadget driver bound */
+	if (dwc->sys_wakeup)
+		device_wakeup_disable(dwc->sysdev);
+
 	return 0;
 
 err5:
diff --git a/drivers/usb/dwc3/host.c b/drivers/usb/dwc3/host.c
index 5a5cb6ce9946..0204787df81d 100644
--- a/drivers/usb/dwc3/host.c
+++ b/drivers/usb/dwc3/host.c
@@ -173,6 +173,14 @@ int dwc3_host_init(struct dwc3 *dwc)
 		goto err;
 	}
 
+	if (dwc->sys_wakeup) {
+		/* Restore wakeup setting if switched from device */
+		device_wakeup_enable(dwc->sysdev);
+
+		/* Pass on wakeup setting to the new xhci platform device */
+		device_init_wakeup(&xhci->dev, true);
+	}
+
 	return 0;
 err:
 	platform_device_put(xhci);
@@ -181,6 +189,9 @@ int dwc3_host_init(struct dwc3 *dwc)
 
 void dwc3_host_exit(struct dwc3 *dwc)
 {
+	if (dwc->sys_wakeup)
+		device_init_wakeup(&dwc->xhci->dev, false);
+
 	platform_device_unregister(dwc->xhci);
 	dwc->xhci = NULL;
 }


