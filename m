Return-Path: <stable+bounces-160478-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5366EAFC8D1
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 12:48:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F0E4422986
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 10:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8B99284B4F;
	Tue,  8 Jul 2025 10:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JdtvmI/C"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532362D8DC5
	for <stable@vger.kernel.org>; Tue,  8 Jul 2025 10:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751971669; cv=none; b=PPgBsvhpOwg4gtnv4I+/MeXsmBO8iDtz2e7xqyobQp705DYEVsBQP04WotIYW1I5Tyz6VtRIvUAMz4TfraA6GOSFQ80QHpEgHTPCfaHRblG40ZTYlIhxogP8U1gMPIiJ0oz6yLwNImcglPG1j44nG1UOgtxqGyA/V+/xrj9Wvl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751971669; c=relaxed/simple;
	bh=+R22+CvKuQMG4Dha4/BVb8wE9TRrFhcP06ISD5dvU6c=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=iptj+kMG3dm5iaZEuH+2GuOn8yxMm4dwu76OdKcOkrvE5lRfo+BDBOianKEyaOdZ2o20S+8sbibe39zNP1jLnCtkTTqt4M0wbM7mND3eVoDjPJR87mS6R5TRImZl1Ef37UVbG1LqqD5ZduiHheeWp9K5u7YyowiOuaBsouRd80k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JdtvmI/C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 739DCC4CEED;
	Tue,  8 Jul 2025 10:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751971668;
	bh=+R22+CvKuQMG4Dha4/BVb8wE9TRrFhcP06ISD5dvU6c=;
	h=Subject:To:Cc:From:Date:From;
	b=JdtvmI/Cw152mRB8OwkXhTNha/1JHBn0W9RRTgk9lTQqNAv0I4RNHPmCDVuJlZIsh
	 AecENV7aCEDF1Vjm6BQTuibaUJASQuMcpy36AXue2j+BPgAt5zX7Mdip8guwCD+RAd
	 pj68jn3wTH4zml/QPixfHhvMI6aLD44X/62F9Tck=
Subject: FAILED: patch "[PATCH] usb: dwc3: Abort suspend on soft disconnect failure" failed to apply to 6.6-stable tree
To: khtsai@google.com,Thinh.Nguyen@synopsys.com,gregkh@linuxfoundation.org,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 08 Jul 2025 12:47:43 +0200
Message-ID: <2025070843-mammal-recapture-b529@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 630a1dec3b0eba2a695b9063f1c205d585cbfec9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025070843-mammal-recapture-b529@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

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


