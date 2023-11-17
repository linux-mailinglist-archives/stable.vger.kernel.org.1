Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB257EEFA2
	for <lists+stable@lfdr.de>; Fri, 17 Nov 2023 11:02:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbjKQKCe (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 17 Nov 2023 05:02:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbjKQKCe (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 17 Nov 2023 05:02:34 -0500
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AAB885;
        Fri, 17 Nov 2023 02:02:27 -0800 (PST)
X-QQ-mid: bizesmtp74t1700215208t84gf9pf
Received: from wxdbg.localdomain.com ( [183.128.129.197])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 17 Nov 2023 17:59:55 +0800 (CST)
X-QQ-SSF: 01400000000000K0Z000000A0000000
X-QQ-FEAT: RrZlkntZBfnLu0O2zBM0wuvxGlmC4CpbclQi4DdcfoRIXX/3azRKVAtAwoJ2K
        CzyjIWfFOuTO+h2VfTYXgcQv0z2Twj9nX9JbKAhCGALJdwNKbnQdr0AndLa0aI0jbixVZYp
        E7Im19LmuOP1D/wtobJ18A7/OOXhnUEYBN3onkBUFYic7tI1TpXlM3aV2FVyNjaHQDho58E
        jyTqv4Km3J7Mlpz0Rq1LflpxFP9HGe/NZbzaxZqrgMYeFN3FyR/lGfqVM07Iag0j5Slzsk1
        nFd6pN3xpT0kIRHQxFgaOMzZuKFO8YWdyPNawCX688qz/YT8f+WY9KEeUxzgbNSla/dMqNj
        3tb8HOpJN4w9skO85dhwiMDKSk5eZ1gX6SOkAKfCIrbL7vj87JJU11VBsTZa6Nze/ToqUiC
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 8508710331023806557
From:   Jiawen Wu <jiawenwu@trustnetic.com>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org
Cc:     mengyuanlou@net-swift.com, stable@vger.kernel.org,
        Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net] net: wangxun: fix kernel panic due to null pointer
Date:   Fri, 17 Nov 2023 18:11:08 +0800
Message-Id: <20231117101108.893335-1-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

When the device uses a custom subsystem vendor ID, the function
wx_sw_init() returns before the memory of 'wx->mac_table' is allocated.
The null pointer will causes the kernel panic.

Fixes: 79625f45ca73 ("net: wangxun: Move MAC address handling to libwx")
Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ethernet/wangxun/libwx/wx_hw.c      | 8 +++++---
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c   | 4 +---
 drivers/net/ethernet/wangxun/txgbe/txgbe_main.c | 4 +---
 3 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_hw.c b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
index a3c5de9d547a..533e912af089 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_hw.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
@@ -1769,10 +1769,12 @@ int wx_sw_init(struct wx *wx)
 		wx->subsystem_device_id = pdev->subsystem_device;
 	} else {
 		err = wx_flash_read_dword(wx, 0xfffdc, &ssid);
-		if (!err)
-			wx->subsystem_device_id = swab16((u16)ssid);
+		if (err < 0) {
+			wx_err(wx, "read of internal subsystem device id failed\n");
+			return err;
+		}
 
-		return err;
+		wx->subsystem_device_id = swab16((u16)ssid);
 	}
 
 	wx->mac_table = kcalloc(wx->mac.num_rar_entries,
diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
index 3d43f808c86b..8db804543e66 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
@@ -121,10 +121,8 @@ static int ngbe_sw_init(struct wx *wx)
 
 	/* PCI config space info */
 	err = wx_sw_init(wx);
-	if (err < 0) {
-		wx_err(wx, "read of internal subsystem device id failed\n");
+	if (err < 0)
 		return err;
-	}
 
 	/* mac type, phy type , oem type */
 	ngbe_init_type_code(wx);
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
index 70f0b5c01dac..526250102db2 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
@@ -364,10 +364,8 @@ static int txgbe_sw_init(struct wx *wx)
 
 	/* PCI config space info */
 	err = wx_sw_init(wx);
-	if (err < 0) {
-		wx_err(wx, "read of internal subsystem device id failed\n");
+	if (err < 0)
 		return err;
-	}
 
 	txgbe_init_type_code(wx);
 
-- 
2.27.0

