Return-Path: <stable+bounces-2790-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE307FA876
	for <lists+stable@lfdr.de>; Mon, 27 Nov 2023 18:58:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26195281573
	for <lists+stable@lfdr.de>; Mon, 27 Nov 2023 17:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B20F63C46E;
	Mon, 27 Nov 2023 17:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: stable@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFFA412C;
	Mon, 27 Nov 2023 09:58:09 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3ARHvofU71479205, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3ARHvofU71479205
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Nov 2023 01:57:50 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Tue, 28 Nov 2023 01:57:50 +0800
Received: from Test06-PC.realtek.com.tw (172.22.228.55) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 28 Nov 2023 01:57:49 +0800
From: ChunHao Lin <hau@realtek.com>
To: <hkallweit1@gmail.com>
CC: <nic_swsd@realtek.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <grundler@chromium.org>,
        ChunHao Lin
	<hau@realtek.com>, <stable@vger.kernel.org>
Subject: [PATCH net 2/2] r8169: fix deadlock in "r8169_phylink_handler"
Date: Tue, 28 Nov 2023 01:57:36 +0800
Message-ID: <20231127175736.5738-3-hau@realtek.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231127175736.5738-1-hau@realtek.com>
References: <20231127175736.5738-1-hau@realtek.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXH36505.realtek.com.tw (172.21.6.25) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

In "r8169_phylink_handler", for rtl8125, it will call "rtl_reset_work"->
"rtl_hw_start"->"rtl_jumbo_config"->"phy_start_aneg". When call
"r8169_phylink_handler", PHY lock is acquired. But "phy_start_aneg"
will also try to acquire PHY lock. That will cause deadlock.

In this path, use "_phy_start_aneg", unlocked version "phy_start_aneg",
to prevent deadlock in "r8169_phylink_handler".

Fixes: 453a77894efa ("r8169: don't advertise pause in jumbo mode")
Cc: stable@vger.kernel.org
Signed-off-by: ChunHao Lin <hau@realtek.com>
---
 drivers/net/ethernet/realtek/r8169_main.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 473b3245754f..2e3e42a98edd 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -2415,11 +2415,22 @@ static void rtl_jumbo_config(struct rtl8169_private *tp)
 
 	/* Chip doesn't support pause in jumbo mode */
 	if (jumbo) {
+		int lock;
+
 		linkmode_clear_bit(ETHTOOL_LINK_MODE_Pause_BIT,
 				   tp->phydev->advertising);
 		linkmode_clear_bit(ETHTOOL_LINK_MODE_Asym_Pause_BIT,
 				   tp->phydev->advertising);
-		phy_start_aneg(tp->phydev);
+
+		if (!mutex_trylock(&tp->phydev->lock))
+			lock = 0;
+		else
+			lock = 1;
+
+		_phy_start_aneg(tp->phydev);
+
+		if (lock)
+			mutex_unlock(&tp->phydev->lock);
 	}
 }
 
-- 
2.39.2


