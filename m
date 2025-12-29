Return-Path: <stable+bounces-203569-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE74CE6EA7
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 14:54:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3EC693006AA8
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 13:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F87C22A4EB;
	Mon, 29 Dec 2025 13:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SwznyXLn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1CA5224AF0
	for <stable@vger.kernel.org>; Mon, 29 Dec 2025 13:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767016463; cv=none; b=WCgJZ7PYnZaVRrHC23S4orKNkvDFfZ2hrhIWhKgXzkx3Qc7Yauk0XGfkg9AgMt+NMkUHk34HKtSBSGkGC+Z5mX6lDT1zsvI+mxXerBEJOLuXx3bBW2jq/jQfgKJY4WIuTDYcOh+Qx794ZcjLwwhOBw8EsduFswRUBCdgaoJg7D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767016463; c=relaxed/simple;
	bh=4GPqTH9Q7hnJqMusm3zeC0nIJ2hvzhG4AvICtZNS5mA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=WR7P5xTbQNBSQKVu3/pLNnLkPr3DGu8IskFF1qKYxMQmUsU4joi6/rVKyDenDpoM6K6Bb7HoGUTMQSsIp2JTKJ1J+JmhnW8SHja5SOLSVI0mwW0Nns5XsChhAWee6cKOeGjSNBOUEwlyJ/SDwisHUnW9CSXRa50u2TxlKbVt5tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SwznyXLn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23C4FC4CEF7;
	Mon, 29 Dec 2025 13:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767016462;
	bh=4GPqTH9Q7hnJqMusm3zeC0nIJ2hvzhG4AvICtZNS5mA=;
	h=Subject:To:Cc:From:Date:From;
	b=SwznyXLn8hRJptRyZSP0DzRUImuWyAEQSvRLrRL+v3mJQxciTtvD2E0IpZ+AYrytl
	 rlepgh7AGQPgfS0T3ficbz2r82TxVacpxUUaFtn5vhhJnQ74w7bswHrpBuV9+a+U9P
	 EaZe+eJHYwYELdC0t1AYnMJaf0Q+wgesIi8CCz3U=
Subject: FAILED: patch "[PATCH] usb: dwc3: keep susphy enabled during exit to avoid" failed to apply to 5.15-stable tree
To: udipto.goswami@oss.qualcomm.com,Thinh.Nguyen@synopsys.com,gregkh@linuxfoundation.org,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Dec 2025 14:54:11 +0100
Message-ID: <2025122911-punctual-slapping-497e@gregkh>
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
git cherry-pick -x e1003aa7ec9eccdde4c926bd64ef42816ad55f25
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025122911-punctual-slapping-497e@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e1003aa7ec9eccdde4c926bd64ef42816ad55f25 Mon Sep 17 00:00:00 2001
From: Udipto Goswami <udipto.goswami@oss.qualcomm.com>
Date: Wed, 26 Nov 2025 11:12:21 +0530
Subject: [PATCH] usb: dwc3: keep susphy enabled during exit to avoid
 controller faults

On some platforms, switching USB roles from host to device can trigger
controller faults due to premature PHY power-down. This occurs when the
PHY is disabled too early during teardown, causing synchronization
issues between the PHY and controller.

Keep susphy enabled during dwc3_host_exit() and dwc3_gadget_exit()
ensures the PHY remains in a low-power state capable of handling
required commands during role switch.

Cc: stable <stable@kernel.org>
Fixes: 6d735722063a ("usb: dwc3: core: Prevent phy suspend during init")
Suggested-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Signed-off-by: Udipto Goswami <udipto.goswami@oss.qualcomm.com>
Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Link: https://patch.msgid.link/20251126054221.120638-1-udipto.goswami@oss.qualcomm.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index bc3fe31638b9..8a35a6901db7 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -4826,7 +4826,7 @@ void dwc3_gadget_exit(struct dwc3 *dwc)
 	if (!dwc->gadget)
 		return;
 
-	dwc3_enable_susphy(dwc, false);
+	dwc3_enable_susphy(dwc, true);
 	usb_del_gadget(dwc->gadget);
 	dwc3_gadget_free_endpoints(dwc);
 	usb_put_gadget(dwc->gadget);
diff --git a/drivers/usb/dwc3/host.c b/drivers/usb/dwc3/host.c
index cf6512ed17a6..96b588bd08cd 100644
--- a/drivers/usb/dwc3/host.c
+++ b/drivers/usb/dwc3/host.c
@@ -227,7 +227,7 @@ void dwc3_host_exit(struct dwc3 *dwc)
 	if (dwc->sys_wakeup)
 		device_init_wakeup(&dwc->xhci->dev, false);
 
-	dwc3_enable_susphy(dwc, false);
+	dwc3_enable_susphy(dwc, true);
 	platform_device_unregister(dwc->xhci);
 	dwc->xhci = NULL;
 }


