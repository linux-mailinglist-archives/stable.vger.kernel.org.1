Return-Path: <stable+bounces-5942-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DAE980D7F4
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 19:42:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 184411F211E3
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 18:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA1B1524C3;
	Mon, 11 Dec 2023 18:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lZBVxACw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70D0FBE1;
	Mon, 11 Dec 2023 18:41:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CD4AC433C8;
	Mon, 11 Dec 2023 18:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702320082;
	bh=aud+WJKpTjbbSlBWFrnVvTrrt6zZxAnUOoxfEX5K2pc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lZBVxACwi1jhbgo3DnAMKHy8DevHLS8drHn2NedVE8SjWGJQqIkOIYgxvmJ8p+5rV
	 gCkkLP62PHtCxk7r3agLXYtshk0vizMt7qmpASf3NzxPU4qEt1ukEpsSBxWaZDS5Fn
	 4joQ85r5ZhEwHMkQ9N7KICGrD7RxwJxYbQkGsOa8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Grant Grundler <grundler@chromium.org>,
	ChunHao Lin <hau@realtek.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 97/97] r8169: fix rtl8125b PAUSE frames blasting when suspended
Date: Mon, 11 Dec 2023 19:22:40 +0100
Message-ID: <20231211182023.974546975@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231211182019.802717483@linuxfoundation.org>
References: <20231211182019.802717483@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: ChunHao Lin <hau@realtek.com>

[ Upstream commit 4b0768b6556af56ee9b7cf4e68452a2b6289ae45 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/realtek/r8169_main.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 88253cedd9d96..c72ff0fd38c42 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -205,6 +205,7 @@ enum rtl_registers {
 					/* No threshold before first PCI xfer */
 #define	RX_FIFO_THRESH			(7 << RXCFG_FIFO_SHIFT)
 #define	RX_EARLY_OFF			(1 << 11)
+#define	RX_PAUSE_SLOT_ON		(1 << 11)	/* 8125b and later */
 #define	RXCFG_DMA_SHIFT			8
 					/* Unlimited maximum PCI burst. */
 #define	RX_DMA_BURST			(7 << RXCFG_DMA_SHIFT)
@@ -2318,9 +2319,13 @@ static void rtl_init_rxcfg(struct rtl8169_private *tp)
 	case RTL_GIGA_MAC_VER_40 ... RTL_GIGA_MAC_VER_52:
 		RTL_W32(tp, RxConfig, RX128_INT_EN | RX_MULTI_EN | RX_DMA_BURST | RX_EARLY_OFF);
 		break;
-	case RTL_GIGA_MAC_VER_60 ... RTL_GIGA_MAC_VER_63:
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
-- 
2.42.0




