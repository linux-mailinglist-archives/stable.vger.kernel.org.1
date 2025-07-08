Return-Path: <stable+bounces-160468-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CBE82AFC647
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 10:55:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09B0D1AA4115
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 08:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF93A2BE654;
	Tue,  8 Jul 2025 08:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZnnBuaU1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0D82BDC06
	for <stable@vger.kernel.org>; Tue,  8 Jul 2025 08:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751964885; cv=none; b=NGKVEfM5pfwKWPFG2pZ0MDW/HtO8oAJk8K8HDuDogwNGvcPmIx7g6zp7lJXQhxpUm9ngTlb7GwbMdg8JJwRFiIDuZUqPtsty2N6ohT6T1Wr/N95pR2G/jnk453N1TBF8HphSsXIhGLw2bq8xKyb+YuTx0QmRig8WiXq1J/WmEl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751964885; c=relaxed/simple;
	bh=PGiBbuWIqvkmetJ65v7E4lDT9yg3YJkDuZAcV9n5KKw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=pYlKlfQzFmWD5zA1oUbPaZNYI5CAkaltBom+UB4ShqgxtT7gx1+1YX/yXPMEk8/s0CpKz2lRDYvKBwh/65uJLvDXKs6KoeI/s1Yj2P8e4zbJEKpM9loKLK3bu6jipXxBB/IJnGR9M5xgH4aN0WzIqr8bjqpzQOE9URdONypvOP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZnnBuaU1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90C11C4CEED;
	Tue,  8 Jul 2025 08:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751964884;
	bh=PGiBbuWIqvkmetJ65v7E4lDT9yg3YJkDuZAcV9n5KKw=;
	h=Subject:To:Cc:From:Date:From;
	b=ZnnBuaU1v8t+CfnaCsoEjoZJxbf7J+18bD2h7R9iQJyQ8J9Uso4ELAD9XaqSlczwl
	 OHejX5mM0w8HsqiB4eWi7y9Bmyd9/7VyHHzYRxpsd+AIWRBE+TdKBngZkZ9bix7oNR
	 67e2W+PIFqDBPE8DQ0fyAU3aY+ctJN/SHuS1PIzQ=
Subject: FAILED: patch "[PATCH] usb: dwc3: Abort suspend on soft disconnect failure" failed to apply to 5.10-stable tree
To: khtsai@google.com,Thinh.Nguyen@synopsys.com,gregkh@linuxfoundation.org,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 08 Jul 2025 10:54:42 +0200
Message-ID: <2025070842-boondocks-tint-f86c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 630a1dec3b0eba2a695b9063f1c205d585cbfec9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025070842-boondocks-tint-f86c@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 630a1dec3b0eba2a695b9063f1c205d585cbfec9 Mon Sep 17 00:00:00 2001
From: Kuen-Han Tsai <khtsai@google.com>
Date: Wed, 28 May 2025 18:03:11 +0800
Subject: [PATCH] usb: dwc3: Abort suspend on soft disconnect failure

When dwc3_gadget_soft_disconnect() fails, dwc3_suspend_common() keeps
going with the suspend, resulting in a period where the power domain is
off, but the gadget driver remains connected.  Within this time frame,
invoking vbus_event_work() will cause an error as it attempts to access
DWC3 registers for endpoint disabling after the power domain has been
completely shut down.

Abort the suspend sequence when dwc3_gadget_suspend() cannot halt the
controller and proceeds with a soft connect.

Fixes: 9f8a67b65a49 ("usb: dwc3: gadget: fix gadget suspend/resume")
Cc: stable <stable@kernel.org>
Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Signed-off-by: Kuen-Han Tsai <khtsai@google.com>
Link: https://lore.kernel.org/r/20250528100315.2162699-1-khtsai@google.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 2bc775a747f2..8002c23a5a02 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -2422,6 +2422,7 @@ static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
 {
 	u32 reg;
 	int i;
+	int ret;
 
 	if (!pm_runtime_suspended(dwc->dev) && !PMSG_IS_AUTO(msg)) {
 		dwc->susphy_state = (dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0)) &
@@ -2440,7 +2441,9 @@ static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
 	case DWC3_GCTL_PRTCAP_DEVICE:
 		if (pm_runtime_suspended(dwc->dev))
 			break;
-		dwc3_gadget_suspend(dwc);
+		ret = dwc3_gadget_suspend(dwc);
+		if (ret)
+			return ret;
 		synchronize_irq(dwc->irq_gadget);
 		dwc3_core_exit(dwc);
 		break;
@@ -2475,7 +2478,9 @@ static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
 			break;
 
 		if (dwc->current_otg_role == DWC3_OTG_ROLE_DEVICE) {
-			dwc3_gadget_suspend(dwc);
+			ret = dwc3_gadget_suspend(dwc);
+			if (ret)
+				return ret;
 			synchronize_irq(dwc->irq_gadget);
 		}
 
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 321361288935..b6b63b530148 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -4821,8 +4821,15 @@ int dwc3_gadget_suspend(struct dwc3 *dwc)
 	int ret;
 
 	ret = dwc3_gadget_soft_disconnect(dwc);
-	if (ret)
-		goto err;
+	/*
+	 * Attempt to reset the controller's state. Likely no
+	 * communication can be established until the host
+	 * performs a port reset.
+	 */
+	if (ret && dwc->softconnect) {
+		dwc3_gadget_soft_connect(dwc);
+		return -EAGAIN;
+	}
 
 	spin_lock_irqsave(&dwc->lock, flags);
 	if (dwc->gadget_driver)
@@ -4830,17 +4837,6 @@ int dwc3_gadget_suspend(struct dwc3 *dwc)
 	spin_unlock_irqrestore(&dwc->lock, flags);
 
 	return 0;
-
-err:
-	/*
-	 * Attempt to reset the controller's state. Likely no
-	 * communication can be established until the host
-	 * performs a port reset.
-	 */
-	if (dwc->softconnect)
-		dwc3_gadget_soft_connect(dwc);
-
-	return ret;
 }
 
 int dwc3_gadget_resume(struct dwc3 *dwc)


