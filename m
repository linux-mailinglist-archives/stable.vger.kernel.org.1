Return-Path: <stable+bounces-74065-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D048797200A
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 19:09:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E7742886E4
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 17:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A732142AA1;
	Mon,  9 Sep 2024 17:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EgjqrxIy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7A816C852
	for <stable@vger.kernel.org>; Mon,  9 Sep 2024 17:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725901786; cv=none; b=e8Fi1i4DUlBHbQdgQQWA8YoaTujbpqZnoP0NTxjoxD7kkGefc1ETUvc5V9vbYkiLrXieMwB6NvMpXHMBvAGHVW+9PuFOP4WUptGTa6iMocAN4x7fcIKiA9x5oB2gfJHOW4rd+1hv/yb0TE4nL6IAETLxR+irIpo9zEaPBPmfzJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725901786; c=relaxed/simple;
	bh=nwozwE1Wp3UI+E/PMTRl4ZeTVvkBpWso8u4SRYOwVxg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=jjGBYnJJ/+kyyuQdd40r02LmBsEKdZ+wtXPQImm9VnA58v6q0yLUEDRr2IF4ajjueIBisZKnD/EIdjrgIB1ryG6ReQ+dvYmv2TJsyU8Z8Sms1j9KPJWIW/9EQemolOQwkDxvEFZI+6g8EriMebYt6RdC88c2ElOeLdYybbr93xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EgjqrxIy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81789C4CEC7;
	Mon,  9 Sep 2024 17:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725901785;
	bh=nwozwE1Wp3UI+E/PMTRl4ZeTVvkBpWso8u4SRYOwVxg=;
	h=Subject:To:Cc:From:Date:From;
	b=EgjqrxIy47OT6H+usmasAY7J9pujK5FapfVfFMt8lMJHy+Lmkr7BuXpiyoay4EgyV
	 V/DIY6GhPXTlGmD/uOyLKHDNSUiJskUoT8WybG7QGqRo9RFikCE1qUMD4OykgGNrvZ
	 DQVbgl6aK3gQfU53j6tqBBMoycPvWiIAM/X1QyVo=
Subject: FAILED: patch "[PATCH] usb: dwc3: core: update LC timer as per USB Spec V3.2" failed to apply to 5.4-stable tree
To: quic_faisalh@quicinc.com,Thinh.Nguyen@synopsys.com,gregkh@linuxfoundation.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 09 Sep 2024 19:09:43 +0200
Message-ID: <2024090942-clunky-disobey-80a9@gregkh>
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
git cherry-pick -x 9149c9b0c7e046273141e41eebd8a517416144ac
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024090942-clunky-disobey-80a9@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:

9149c9b0c7e0 ("usb: dwc3: core: update LC timer as per USB Spec V3.2")
63d7f9810a38 ("usb: dwc3: core: Enable GUCTL1 bit 10 for fixing termination error after resume bug")
843714bb37d9 ("usb: dwc3: Decouple USB 2.0 L1 & L2 events")
9af21dd6faeb ("usb: dwc3: Add support for DWC_usb32 IP")
8bb14308a869 ("usb: dwc3: core: Use role-switch default dr_mode")
d94ea5319813 ("usb: dwc3: gadget: Properly set maxpacket limit")
586f4335700f ("usb: dwc3: Fix GTXFIFOSIZ.TXFDEP macro name")
7ba6b09fda5e ("usb: dwc3: core: add support for disabling SS instances in park mode")
5eb5afb07853 ("usb: dwc3: use proper initializers for property entries")
9ba3aca8fe82 ("usb: dwc3: Disable phy suspend after power-on reset")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9149c9b0c7e046273141e41eebd8a517416144ac Mon Sep 17 00:00:00 2001
From: Faisal Hassan <quic_faisalh@quicinc.com>
Date: Thu, 29 Aug 2024 15:15:02 +0530
Subject: [PATCH] usb: dwc3: core: update LC timer as per USB Spec V3.2

This fix addresses STAR 9001285599, which only affects DWC_usb3 version
3.20a. The timer value for PM_LC_TIMER in DWC_usb3 3.20a for the Link
ECN changes is incorrect. If the PM TIMER ECN is enabled via GUCTL2[19],
the link compliance test (TD7.21) may fail. If the ECN is not enabled
(GUCTL2[19] = 0), the controller will use the old timer value (5us),
which is still acceptable for the link compliance test. Therefore, clear
GUCTL2[19] to pass the USB link compliance test: TD 7.21.

Cc: stable@vger.kernel.org
Signed-off-by: Faisal Hassan <quic_faisalh@quicinc.com>
Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Link: https://lore.kernel.org/r/20240829094502.26502-1-quic_faisalh@quicinc.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index ccc3895dbd7f..9eb085f359ce 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -1386,6 +1386,21 @@ static int dwc3_core_init(struct dwc3 *dwc)
 		dwc3_writel(dwc->regs, DWC3_GUCTL2, reg);
 	}
 
+	/*
+	 * STAR 9001285599: This issue affects DWC_usb3 version 3.20a
+	 * only. If the PM TIMER ECM is enabled through GUCTL2[19], the
+	 * link compliance test (TD7.21) may fail. If the ECN is not
+	 * enabled (GUCTL2[19] = 0), the controller will use the old timer
+	 * value (5us), which is still acceptable for the link compliance
+	 * test. Therefore, do not enable PM TIMER ECM in 3.20a by
+	 * setting GUCTL2[19] by default; instead, use GUCTL2[19] = 0.
+	 */
+	if (DWC3_VER_IS(DWC3, 320A)) {
+		reg = dwc3_readl(dwc->regs, DWC3_GUCTL2);
+		reg &= ~DWC3_GUCTL2_LC_TIMER;
+		dwc3_writel(dwc->regs, DWC3_GUCTL2, reg);
+	}
+
 	/*
 	 * When configured in HOST mode, after issuing U3/L2 exit controller
 	 * fails to send proper CRC checksum in CRC5 feild. Because of this
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 1e561fd8b86e..c71240e8f7c7 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -421,6 +421,7 @@
 
 /* Global User Control Register 2 */
 #define DWC3_GUCTL2_RST_ACTBITLATER		BIT(14)
+#define DWC3_GUCTL2_LC_TIMER			BIT(19)
 
 /* Global User Control Register 3 */
 #define DWC3_GUCTL3_SPLITDISABLE		BIT(14)
@@ -1269,6 +1270,7 @@ struct dwc3 {
 #define DWC3_REVISION_290A	0x5533290a
 #define DWC3_REVISION_300A	0x5533300a
 #define DWC3_REVISION_310A	0x5533310a
+#define DWC3_REVISION_320A	0x5533320a
 #define DWC3_REVISION_330A	0x5533330a
 
 #define DWC31_REVISION_ANY	0x0


