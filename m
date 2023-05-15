Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6FCE70372C
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:17:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243949AbjEORRp (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243793AbjEORR0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:17:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50EEF11D8A
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:15:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 24B3D62BE0
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:15:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 329F0C433D2;
        Mon, 15 May 2023 17:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684170956;
        bh=ZPQqU2FWSMXhXfGEnLzUBhNLxnXTSR55vEuzALrF1qc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fOg+UF5COPfrUe4gpQ0iinXCVuh7NG615WM1oAAgb2CathKEmvP6wBVtKipiyYcw6
         A70xuFVMn/0n4OaHNFaXISkku5pgLZeX75oUzec9/7cQunGEYUjzQoP6g/j1Zj/zWW
         5nDiE38/8PafPdPmR5Sc+Sl4yLNoozjyKMOsI3Sk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Hayes Wang <hayeswang@realtek.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.2 055/242] r8152: fix flow control issue of RTL8156A
Date:   Mon, 15 May 2023 18:26:21 +0200
Message-Id: <20230515161723.560652655@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161721.802179972@linuxfoundation.org>
References: <20230515161721.802179972@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Hayes Wang <hayeswang@realtek.com>

[ Upstream commit 8ceda6d5a1e5402fd852e6cc59a286ce3dc545ee ]

The feature of flow control becomes abnormal, if the device sends a
pause frame and the tx/rx is disabled before sending a release frame. It
causes the lost of packets.

Set PLA_RX_FIFO_FULL and PLA_RX_FIFO_EMPTY to zeros before disabling the
tx/rx. And, toggle FC_PATCH_TASK before enabling tx/rx to reset the flow
control patch and timer. Then, the hardware could clear the state and
the flow control becomes normal after enabling tx/rx.

Besides, remove inline for fc_pause_on_auto() and fc_pause_off_auto().

Fixes: 195aae321c82 ("r8152: support new chips")
Signed-off-by: Hayes Wang <hayeswang@realtek.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/usb/r8152.c | 56 ++++++++++++++++++++++++++---------------
 1 file changed, 36 insertions(+), 20 deletions(-)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index 23da1d9dafd1f..b0ce524ef1a50 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -5986,6 +5986,25 @@ static void rtl8153_disable(struct r8152 *tp)
 	r8153_aldps_en(tp, true);
 }
 
+static u32 fc_pause_on_auto(struct r8152 *tp)
+{
+	return (ALIGN(mtu_to_size(tp->netdev->mtu), 1024) + 6 * 1024);
+}
+
+static u32 fc_pause_off_auto(struct r8152 *tp)
+{
+	return (ALIGN(mtu_to_size(tp->netdev->mtu), 1024) + 14 * 1024);
+}
+
+static void r8156_fc_parameter(struct r8152 *tp)
+{
+	u32 pause_on = tp->fc_pause_on ? tp->fc_pause_on : fc_pause_on_auto(tp);
+	u32 pause_off = tp->fc_pause_off ? tp->fc_pause_off : fc_pause_off_auto(tp);
+
+	ocp_write_word(tp, MCU_TYPE_PLA, PLA_RX_FIFO_FULL, pause_on / 16);
+	ocp_write_word(tp, MCU_TYPE_PLA, PLA_RX_FIFO_EMPTY, pause_off / 16);
+}
+
 static int rtl8156_enable(struct r8152 *tp)
 {
 	u32 ocp_data;
@@ -5994,6 +6013,7 @@ static int rtl8156_enable(struct r8152 *tp)
 	if (test_bit(RTL8152_UNPLUG, &tp->flags))
 		return -ENODEV;
 
+	r8156_fc_parameter(tp);
 	set_tx_qlen(tp);
 	rtl_set_eee_plus(tp);
 	r8153_set_rx_early_timeout(tp);
@@ -6025,9 +6045,24 @@ static int rtl8156_enable(struct r8152 *tp)
 		ocp_write_word(tp, MCU_TYPE_USB, USB_L1_CTRL, ocp_data);
 	}
 
+	ocp_data = ocp_read_word(tp, MCU_TYPE_USB, USB_FW_TASK);
+	ocp_data &= ~FC_PATCH_TASK;
+	ocp_write_word(tp, MCU_TYPE_USB, USB_FW_TASK, ocp_data);
+	usleep_range(1000, 2000);
+	ocp_data |= FC_PATCH_TASK;
+	ocp_write_word(tp, MCU_TYPE_USB, USB_FW_TASK, ocp_data);
+
 	return rtl_enable(tp);
 }
 
+static void rtl8156_disable(struct r8152 *tp)
+{
+	ocp_write_word(tp, MCU_TYPE_PLA, PLA_RX_FIFO_FULL, 0);
+	ocp_write_word(tp, MCU_TYPE_PLA, PLA_RX_FIFO_EMPTY, 0);
+
+	rtl8153_disable(tp);
+}
+
 static int rtl8156b_enable(struct r8152 *tp)
 {
 	u32 ocp_data;
@@ -6429,25 +6464,6 @@ static void rtl8153c_up(struct r8152 *tp)
 	r8153b_u1u2en(tp, true);
 }
 
-static inline u32 fc_pause_on_auto(struct r8152 *tp)
-{
-	return (ALIGN(mtu_to_size(tp->netdev->mtu), 1024) + 6 * 1024);
-}
-
-static inline u32 fc_pause_off_auto(struct r8152 *tp)
-{
-	return (ALIGN(mtu_to_size(tp->netdev->mtu), 1024) + 14 * 1024);
-}
-
-static void r8156_fc_parameter(struct r8152 *tp)
-{
-	u32 pause_on = tp->fc_pause_on ? tp->fc_pause_on : fc_pause_on_auto(tp);
-	u32 pause_off = tp->fc_pause_off ? tp->fc_pause_off : fc_pause_off_auto(tp);
-
-	ocp_write_word(tp, MCU_TYPE_PLA, PLA_RX_FIFO_FULL, pause_on / 16);
-	ocp_write_word(tp, MCU_TYPE_PLA, PLA_RX_FIFO_EMPTY, pause_off / 16);
-}
-
 static void rtl8156_change_mtu(struct r8152 *tp)
 {
 	u32 rx_max_size = mtu_to_size(tp->netdev->mtu);
@@ -9377,7 +9393,7 @@ static int rtl_ops_init(struct r8152 *tp)
 	case RTL_VER_10:
 		ops->init		= r8156_init;
 		ops->enable		= rtl8156_enable;
-		ops->disable		= rtl8153_disable;
+		ops->disable		= rtl8156_disable;
 		ops->up			= rtl8156_up;
 		ops->down		= rtl8156_down;
 		ops->unload		= rtl8153_unload;
-- 
2.39.2



