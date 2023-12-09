Return-Path: <stable+bounces-5133-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B1880B436
	for <lists+stable@lfdr.de>; Sat,  9 Dec 2023 13:33:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8245B20B10
	for <lists+stable@lfdr.de>; Sat,  9 Dec 2023 12:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04DD011184;
	Sat,  9 Dec 2023 12:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TxDOTMC4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BADAD187C
	for <stable@vger.kernel.org>; Sat,  9 Dec 2023 12:33:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21446C433C7;
	Sat,  9 Dec 2023 12:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702125209;
	bh=FONxdUC4Zo0FGJIuqsBfZFHT8jAwrXV5C2mE5fBG0dA=;
	h=Subject:To:Cc:From:Date:From;
	b=TxDOTMC44OqEu+NXiQl01acmooSuYqfpU+d7orhT7sJUvWt4d4NJ9eupek8qmUdIa
	 l/7VcS8/ffBRPNNSftZBqHFbBDGdvJ3dhoUjIis40ooc2uxmVP8VcbqG7Ziv10+9Ef
	 YyhcORcgmiK9aPX9VBbS4yL4s8hDUNS3AcHWkRcE=
Subject: FAILED: patch "[PATCH] r8169: fix rtl8125b PAUSE frames blasting when suspended" failed to apply to 5.10-stable tree
To: hau@realtek.com,grundler@chromium.org,hkallweit1@gmail.com,jacob.e.keller@intel.com,kuba@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 09 Dec 2023 13:33:18 +0100
Message-ID: <2023120918-coma-plentiful-2159@gregkh>
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
git cherry-pick -x 4b0768b6556af56ee9b7cf4e68452a2b6289ae45
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023120918-coma-plentiful-2159@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

4b0768b6556a ("r8169: fix rtl8125b PAUSE frames blasting when suspended")
efc37109c780 ("r8169: remove support for chip version 60")
ebe598985711 ("r8169: remove support for chip versions 45 and 47")
68650b4e6c13 ("r8169: support L1.2 control on RTL8168h")
c217ab7a3961 ("r8169: enable ASPM L1.2 if system vendor flags it as safe")
4b5f82f6aaef ("r8169: enable ASPM L1/L1.1 from RTL8168h")
18a9eae240cb ("r8169: enable ASPM L0s state")
e6d6ca6e1204 ("r8169: Add support for another RTL8168FP")
e0d38b588075 ("r8169: improve DASH support")
c6cff9dfebb3 ("r8169: move ERI access functions to avoid forward declaration")
ae0d0bb29b31 ("Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 4b0768b6556af56ee9b7cf4e68452a2b6289ae45 Mon Sep 17 00:00:00 2001
From: ChunHao Lin <hau@realtek.com>
Date: Wed, 29 Nov 2023 23:53:50 +0800
Subject: [PATCH] r8169: fix rtl8125b PAUSE frames blasting when suspended

When FIFO reaches near full state, device will issue pause frame.
If pause slot is enabled(set to 1), in this time, device will issue
pause frame only once. But if pause slot is disabled(set to 0), device
will keep sending pause frames until FIFO reaches near empty state.

When pause slot is disabled, if there is no one to handle receive
packets, device FIFO will reach near full state and keep sending
pause frames. That will impact entire local area network.

This issue can be reproduced in Chromebox (not Chromebook) in
developer mode running a test image (and v5.10 kernel):
1) ping -f $CHROMEBOX (from workstation on same local network)
2) run "powerd_dbus_suspend" from command line on the $CHROMEBOX
3) ping $ROUTER (wait until ping fails from workstation)

Takes about ~20-30 seconds after step 2 for the local network to
stop working.

Fix this issue by enabling pause slot to only send pause frame once
when FIFO reaches near full state.

Fixes: f1bce4ad2f1c ("r8169: add support for RTL8125")
Reported-by: Grant Grundler <grundler@chromium.org>
Tested-by: Grant Grundler <grundler@chromium.org>
Cc: stable@vger.kernel.org
Signed-off-by: ChunHao Lin <hau@realtek.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Heiner Kallweit <hkallweit1@gmail.com>
Link: https://lore.kernel.org/r/20231129155350.5843-1-hau@realtek.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 62cabeeb842a..bb787a52bc75 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -196,6 +196,7 @@ enum rtl_registers {
 					/* No threshold before first PCI xfer */
 #define	RX_FIFO_THRESH			(7 << RXCFG_FIFO_SHIFT)
 #define	RX_EARLY_OFF			(1 << 11)
+#define	RX_PAUSE_SLOT_ON		(1 << 11)	/* 8125b and later */
 #define	RXCFG_DMA_SHIFT			8
 					/* Unlimited maximum PCI burst. */
 #define	RX_DMA_BURST			(7 << RXCFG_DMA_SHIFT)
@@ -2306,9 +2307,13 @@ static void rtl_init_rxcfg(struct rtl8169_private *tp)
 	case RTL_GIGA_MAC_VER_40 ... RTL_GIGA_MAC_VER_53:
 		RTL_W32(tp, RxConfig, RX128_INT_EN | RX_MULTI_EN | RX_DMA_BURST | RX_EARLY_OFF);
 		break;
-	case RTL_GIGA_MAC_VER_61 ... RTL_GIGA_MAC_VER_63:
+	case RTL_GIGA_MAC_VER_61:
 		RTL_W32(tp, RxConfig, RX_FETCH_DFLT_8125 | RX_DMA_BURST);
 		break;
+	case RTL_GIGA_MAC_VER_63:
+		RTL_W32(tp, RxConfig, RX_FETCH_DFLT_8125 | RX_DMA_BURST |
+			RX_PAUSE_SLOT_ON);
+		break;
 	default:
 		RTL_W32(tp, RxConfig, RX128_INT_EN | RX_DMA_BURST);
 		break;


