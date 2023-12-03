Return-Path: <stable+bounces-3775-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 877B3802444
	for <lists+stable@lfdr.de>; Sun,  3 Dec 2023 14:35:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DC7B1C2098C
	for <lists+stable@lfdr.de>; Sun,  3 Dec 2023 13:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69663F9C4;
	Sun,  3 Dec 2023 13:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LIHQGM2p"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293B9C2EE
	for <stable@vger.kernel.org>; Sun,  3 Dec 2023 13:35:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 420CFC433C7;
	Sun,  3 Dec 2023 13:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701610555;
	bh=+GG2eLMKC7zF4NqDQgqO8ds5A9h6knR1Wm4kFSUm57E=;
	h=Subject:To:Cc:From:Date:From;
	b=LIHQGM2pGwOtp+syR29REsNKX1yHjMPUFFWgXC0CjGRVll3WFSL8jWx49UFHmTHmC
	 utObhWB+kODI62EXMHGsILs64tBPU/lV6kfJU+xqBLtopRNvD9FTuj7sKakYxaf8Px
	 ycWy9/bfrdIag3IViTfAmcuFRgpQfHn+o/CIdJD0=
Subject: FAILED: patch "[PATCH] r8169: fix deadlock on RTL8125 in jumbo mtu mode" failed to apply to 5.4-stable tree
To: hkallweit1@gmail.com,free122448@hotmail.com,pabeni@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 03 Dec 2023 14:35:39 +0100
Message-ID: <2023120339-facing-absentee-ae63@gregkh>
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
git cherry-pick -x 59d395ed606d8df14615712b0cdcdadb2d962175
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023120339-facing-absentee-ae63@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:

59d395ed606d ("r8169: fix deadlock on RTL8125 in jumbo mtu mode")
621735f59064 ("r8169: fix rare issue with broken rx after link-down on RTL8125")
80c0576ef179 ("r8169: disable ASPM in case of tx timeout")
4b6c6065fca1 ("r8169: use tp_to_dev instead of open code")
476c4f5de368 ("r8169: mark device as not present when in PCI D3")
0c28a63a47bf ("r8169: move napi_disable call and rename rtl8169_hw_reset")
120068481405 ("r8169: fix failing WoL")
8ac8e8c64b53 ("r8169: make rtl8169_down central chip quiesce function")
bac75d8565e8 ("r8169: move some calls to rtl8169_hw_reset")
27dc36aefc73 ("r8169: change driver data type")
12b1bc75cd46 ("r8169: improve rtl_remove_one")
13f15b59ad70 ("r8169: remove remaining call to mdiobus_unregister")
ce740c5f6f7a ("r8169: improve reset handling for chips from RTL8168g")
9617886fa65d ("r8169: add helper rtl_enable_rxdvgate")
d6836ef02c17 ("r8169: use fsleep in polling functions")
93882c6f210a ("r8169: switch from netif_xxx message functions to netdev_xxx")
d56f58cec90d ("r8169: simplify counter handling")
0360c046ca18 ("r8169: move setting OCP base to generic init code")
b8447abc4c8f ("r8169: factor out rtl8169_tx_map")
e18958c6a204 ("r8169: simplify rtl_task")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 59d395ed606d8df14615712b0cdcdadb2d962175 Mon Sep 17 00:00:00 2001
From: Heiner Kallweit <hkallweit1@gmail.com>
Date: Sun, 26 Nov 2023 19:36:46 +0100
Subject: [PATCH] r8169: fix deadlock on RTL8125 in jumbo mtu mode

The original change results in a deadlock if jumbo mtu mode is used.
Reason is that the phydev lock is held when rtl_reset_work() is called
here, and rtl_jumbo_config() calls phy_start_aneg() which also tries
to acquire the phydev lock. Fix this by calling rtl_reset_work()
asynchronously.

Fixes: 621735f59064 ("r8169: fix rare issue with broken rx after link-down on RTL8125")
Reported-by: Ian Chen <free122448@hotmail.com>
Tested-by: Ian Chen <free122448@hotmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
Link: https://lore.kernel.org/r/caf6a487-ef8c-4570-88f9-f47a659faf33@gmail.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 295366a85c63..a43e33e4b25e 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -579,6 +579,7 @@ struct rtl8169_tc_offsets {
 enum rtl_flag {
 	RTL_FLAG_TASK_ENABLED = 0,
 	RTL_FLAG_TASK_RESET_PENDING,
+	RTL_FLAG_TASK_RESET_NO_QUEUE_WAKE,
 	RTL_FLAG_TASK_TX_TIMEOUT,
 	RTL_FLAG_MAX
 };
@@ -4582,6 +4583,8 @@ static void rtl_task(struct work_struct *work)
 reset:
 		rtl_reset_work(tp);
 		netif_wake_queue(tp->dev);
+	} else if (test_and_clear_bit(RTL_FLAG_TASK_RESET_NO_QUEUE_WAKE, tp->wk.flags)) {
+		rtl_reset_work(tp);
 	}
 out_unlock:
 	rtnl_unlock();
@@ -4615,7 +4618,7 @@ static void r8169_phylink_handler(struct net_device *ndev)
 	} else {
 		/* In few cases rx is broken after link-down otherwise */
 		if (rtl_is_8125(tp))
-			rtl_reset_work(tp);
+			rtl_schedule_task(tp, RTL_FLAG_TASK_RESET_NO_QUEUE_WAKE);
 		pm_runtime_idle(d);
 	}
 


