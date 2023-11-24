Return-Path: <stable+bounces-183-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EA6F7F7504
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 14:28:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC9BD28165E
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 13:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98D4B28DC1;
	Fri, 24 Nov 2023 13:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vZ50pWyo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA3C18041
	for <stable@vger.kernel.org>; Fri, 24 Nov 2023 13:28:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76BC1C43391;
	Fri, 24 Nov 2023 13:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700832517;
	bh=sSI1HLT3ElFJHElaj17WatBqXCjYq/JapqcFBokbvC8=;
	h=Subject:To:Cc:From:Date:From;
	b=vZ50pWyoKDSk161xcwVrVIXlq8KXnRiSE2Y3vIV3cVlHaIPzl1pGpc886B+mY0QcE
	 o2z1xvmRPjrl50xrdAxbLaezaH0zOCKeMuHpWOjYit+Hx3Slx0y+YWBUaRdvsiqNRh
	 lHl682cV5ju9ICD64rNVCJh7hTHLtXR8A6KhOJUU=
Subject: FAILED: patch "[PATCH] r8169: fix network lost after resume on DASH systems" failed to apply to 4.14-stable tree
To: hau@realtek.com,hkallweit1@gmail.com,kuba@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 24 Nov 2023 13:28:30 +0000
Message-ID: <2023112430-trowel-thee-5ced@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 4.14-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.14.y
git checkout FETCH_HEAD
git cherry-pick -x 868c3b95afef4883bfb66c9397482da6840b5baf
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023112430-trowel-thee-5ced@gregkh' --subject-prefix 'PATCH 4.14.y' HEAD^..

Possible dependencies:

868c3b95afef ("r8169: fix network lost after resume on DASH systems")
f658b90977d2 ("r8169: fix DMA being used after buffer free if WoL is enabled")
7257c977c811 ("r8169: clean up rtl_pll_power_down/up functions")
128735a1530e ("r8169: improve handling D3 PLL power-down")
9224d97183d9 ("r8169: enable PLL power-down for chip versions 34, 35, 36, 42")
acb58657c869 ("r8169: improve RTL8168g PHY suspend quirk")
e80bd76fbf56 ("r8169: work around power-saving bug on some chip versions")
bb13a800620c ("r8169: fix handling ether_clk")
0439297be951 ("r8169: add support for RTL8125B")
4640338c36af ("r8169: rename RTL8125 to RTL8125A")
288302dab34e ("r8169: improve rtl8169_runtime_resume")
06a14ab852fb ("r8169: remove driver-specific mutex")
abe5fc42f9ce ("r8169: use RTNL to protect critical sections")
567ca57faa62 ("r8169: add rtl8169_up")
ec2f204bddb5 ("r8169: remove no longer needed checks for device being runtime-active")
476c4f5de368 ("r8169: mark device as not present when in PCI D3")
9f0b54cd1672 ("r8169: move switching optional clock on/off to pll power functions")
a2ee847242b3 ("r8169: move updating counters to rtl8169_down")
0c28a63a47bf ("r8169: move napi_disable call and rename rtl8169_hw_reset")
e9882208ae98 ("r8169: improve setting WoL on runtime-resume")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 868c3b95afef4883bfb66c9397482da6840b5baf Mon Sep 17 00:00:00 2001
From: ChunHao Lin <hau@realtek.com>
Date: Fri, 10 Nov 2023 01:34:00 +0800
Subject: [PATCH] r8169: fix network lost after resume on DASH systems

Device that support DASH may be reseted or powered off during suspend.
So driver needs to handle DASH during system suspend and resume. Or
DASH firmware will influence device behavior and causes network lost.

Fixes: b646d90053f8 ("r8169: magic.")
Cc: stable@vger.kernel.org
Reviewed-by: Heiner Kallweit <hkallweit1@gmail.com>
Signed-off-by: ChunHao Lin <hau@realtek.com>
Link: https://lore.kernel.org/r/20231109173400.4573-3-hau@realtek.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index cfcb40d90920..b9bb1d2f0237 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -4661,10 +4661,16 @@ static void rtl8169_down(struct rtl8169_private *tp)
 	rtl8169_cleanup(tp);
 	rtl_disable_exit_l1(tp);
 	rtl_prepare_power_down(tp);
+
+	if (tp->dash_type != RTL_DASH_NONE)
+		rtl8168_driver_stop(tp);
 }
 
 static void rtl8169_up(struct rtl8169_private *tp)
 {
+	if (tp->dash_type != RTL_DASH_NONE)
+		rtl8168_driver_start(tp);
+
 	pci_set_master(tp->pci_dev);
 	phy_init_hw(tp->phydev);
 	phy_resume(tp->phydev);


