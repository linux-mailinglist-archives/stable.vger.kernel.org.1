Return-Path: <stable+bounces-33902-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D77893998
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 11:42:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E84891C214F5
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 09:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E3EF10953;
	Mon,  1 Apr 2024 09:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="H4x5kGCo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D655FBFD
	for <stable@vger.kernel.org>; Mon,  1 Apr 2024 09:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711964533; cv=none; b=BHmr54pDOWDhIxLg1xgO5EZy2BUhwX8B3kzKPJvdSapnX7fBrDv6lbAzUvXiJ2eDtUucalkP+XHM47Z1VSAeNxh+7Ugczybiec8lM+13xNVZz+G0L0srxlgly8/Cz8dC4lWHpMPAOjKaRsUXYStfTLq4BZsvv1fhOU6wFd2rvek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711964533; c=relaxed/simple;
	bh=SlfXk4D0dxu9je5cAOEyTRy8gAubj2HTn/OMs8qxNW4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=trm+jOdgxWctoAPrvJncYCT9utUw9JGD/pDJJjrDZrHJ1fnseieh7GCnxQzXihZZq0D6DeaXYhkNU0NdinAf8fbL1pfYB9A3JSXuR+Q2M+fDPXGejNng0A7Y8VGTIzCgeP8mnRxEMPmFqKsOKbWslQVFgRW9k9DtS6aw4SBQpXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=H4x5kGCo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 873F6C433C7;
	Mon,  1 Apr 2024 09:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711964532;
	bh=SlfXk4D0dxu9je5cAOEyTRy8gAubj2HTn/OMs8qxNW4=;
	h=Subject:To:Cc:From:Date:From;
	b=H4x5kGCoP4ViyyH1k60KhaRPNwdgUWQ0nHAwHE6seqXG6G1OAmha5q72E+0/7vuXu
	 XtwaHWuBZ+o/aAgNzyn2UxBiygIjuwqVK8NbomGONzNiAyxT9QZPaR17IofBnOGh8U
	 cvQkxQy9akwJcxAiH+7zCbqQU3hKRlQzFESYCtoE=
Subject: FAILED: patch "[PATCH] usb: dwc3: Properly set system wakeup" failed to apply to 5.4-stable tree
To: Thinh.Nguyen@synopsys.com,Sanath.S@amd.com,gpiccoli@igalia.com,gregkh@linuxfoundation.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 01 Apr 2024 11:42:02 +0200
Message-ID: <2024040102-flatterer-enslave-672e@gregkh>
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
git cherry-pick -x f9aa41130ac69d13a53ce2a153ca79c70d43f39c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024040102-flatterer-enslave-672e@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:

f9aa41130ac6 ("usb: dwc3: Properly set system wakeup")
047161686b81 ("usb: dwc3: Add remote wakeup handling")
63c4c320ccf7 ("usb: dwc3: gadget: Check for L1/L2/U3 for Start Transfer")
40edb52298df ("usb: dwc3: avoid NULL access of usb_gadget_driver")
c560e76319a9 ("usb: dwc3: gadget: Fix START_TRANSFER link state check")
475e8be53d04 ("usb: dwc3: gadget: Check for disabled LPM quirk")
6f0764b5adea ("usb: dwc3: add a power supply for current control")
82c46b8ed9dc ("usb: dwc3: gadget: Introduce a DWC3 VBUS draw callback")
f580170f135a ("usb: dwc3: Add splitdisable quirk for Hisilicon Kirin Soc")
e81a7018d93a ("usb: dwc3: allocate gadget structure dynamically")
c5a7092f4015 ("usb: dwc3: gadget: make starting isoc transfers more robust")
9af21dd6faeb ("usb: dwc3: Add support for DWC_usb32 IP")
8bb14308a869 ("usb: dwc3: core: Use role-switch default dr_mode")
d0550cd20e52 ("usb: dwc3: gadget: Do link recovery for SS and SSP")
d94ea5319813 ("usb: dwc3: gadget: Properly set maxpacket limit")
586f4335700f ("usb: dwc3: Fix GTXFIFOSIZ.TXFDEP macro name")
5eb5afb07853 ("usb: dwc3: use proper initializers for property entries")
9ba3aca8fe82 ("usb: dwc3: Disable phy suspend after power-on reset")

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


