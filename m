Return-Path: <stable+bounces-180-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 652587F7501
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 14:28:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 957C61C20D66
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 13:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 658DB28DC7;
	Fri, 24 Nov 2023 13:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="t9JiYmpn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2289B18041
	for <stable@vger.kernel.org>; Fri, 24 Nov 2023 13:28:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A053DC433CA;
	Fri, 24 Nov 2023 13:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700832510;
	bh=OcY0tj/Lo4dpeHwB7yAQOUQ/YjF4Re9Can6Ko2RPMR0=;
	h=Subject:To:Cc:From:Date:From;
	b=t9JiYmpnRLD85vDkXnVK+5ihXrmVnAzfrrlxip4b/5dlYHgF1b+digMGzvIkCXUt3
	 Iyy2wuTs0zDIk5slNtDnpKseS9k+UYtPSTfpQRaejwOIB5QCwXig6zg8c2CcKgNooN
	 YvMehT2FOGauYamFotBZX2o/Q1wJUk51Qet14MNY=
Subject: FAILED: patch "[PATCH] r8169: fix network lost after resume on DASH systems" failed to apply to 5.10-stable tree
To: hau@realtek.com,hkallweit1@gmail.com,kuba@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 24 Nov 2023 13:28:27 +0000
Message-ID: <2023112427-rubbing-storage-3833@gregkh>
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
git cherry-pick -x 868c3b95afef4883bfb66c9397482da6840b5baf
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023112427-rubbing-storage-3833@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

868c3b95afef ("r8169: fix network lost after resume on DASH systems")
f658b90977d2 ("r8169: fix DMA being used after buffer free if WoL is enabled")
7257c977c811 ("r8169: clean up rtl_pll_power_down/up functions")
128735a1530e ("r8169: improve handling D3 PLL power-down")
9224d97183d9 ("r8169: enable PLL power-down for chip versions 34, 35, 36, 42")
acb58657c869 ("r8169: improve RTL8168g PHY suspend quirk")
e80bd76fbf56 ("r8169: work around power-saving bug on some chip versions")

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


