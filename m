Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1FFE74C2AF
	for <lists+stable@lfdr.de>; Sun,  9 Jul 2023 13:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231586AbjGILXa (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 9 Jul 2023 07:23:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231536AbjGILXa (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 9 Jul 2023 07:23:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D467130
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 04:23:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0A3BB60B86
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 11:23:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AD9CC433C8;
        Sun,  9 Jul 2023 11:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688901808;
        bh=0YrTWkP791Q6pbwnTipRK9YXyjAr5xDWSDx9eXN6DNw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UU0PCP1qTWkQiN2RKIGJuqSWa3JoynuLNSllEYKC/a2ychVAkOtWKzMkKa34BiHLO
         SyzwUDAxXr3xNf2g+pHa4OIni0ZkGGXD0UZuxD6aOlFgsko1x5xNk3mMHY7WC51hEN
         JzL+dzzyS3UrQU8Qb0mAI14GICeZfCvchUO9y5Yc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ziyang Huang <hzyitc@outlook.com>,
        Kalle Valo <quic_kvalo@quicinc.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 124/431] wifi: ath11k: Add missing hw_ops->get_ring_selector() for IPQ5018
Date:   Sun,  9 Jul 2023 13:11:12 +0200
Message-ID: <20230709111454.063573588@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230709111451.101012554@linuxfoundation.org>
References: <20230709111451.101012554@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Ziyang Huang <hzyitc@outlook.com>

[ Upstream commit ce282d8de71f07f0056ea319541141152c65f552 ]

During sending data after clients connected, hw_ops->get_ring_selector()
will be called. But for IPQ5018, this member isn't set, and the
following NULL pointer exception will be occurred:

	[   38.840478] 8<--- cut here ---
	[   38.840517] Unable to handle kernel NULL pointer dereference at virtual address 00000000
	...
	[   38.923161] PC is at 0x0
	[   38.927930] LR is at ath11k_dp_tx+0x70/0x730 [ath11k]
	...
	[   39.063264] Process hostapd (pid: 1034, stack limit = 0x801ceb3d)
	[   39.068994] Stack: (0x856a9a68 to 0x856aa000)
	...
	[   39.438467] [<7f323804>] (ath11k_dp_tx [ath11k]) from [<7f314e6c>] (ath11k_mac_op_tx+0x80/0x190 [ath11k])
	[   39.446607] [<7f314e6c>] (ath11k_mac_op_tx [ath11k]) from [<7f17dbe0>] (ieee80211_handle_wake_tx_queue+0x7c/0xc0 [mac80211])
	[   39.456162] [<7f17dbe0>] (ieee80211_handle_wake_tx_queue [mac80211]) from [<7f174450>] (ieee80211_probereq_get+0x584/0x704 [mac80211])
	[   39.467443] [<7f174450>] (ieee80211_probereq_get [mac80211]) from [<7f178c40>] (ieee80211_tx_prepare_skb+0x1f8/0x248 [mac80211])
	[   39.479334] [<7f178c40>] (ieee80211_tx_prepare_skb [mac80211]) from [<7f179e28>] (__ieee80211_subif_start_xmit+0x32c/0x3d4 [mac80211])
	[   39.491053] [<7f179e28>] (__ieee80211_subif_start_xmit [mac80211]) from [<7f17af08>] (ieee80211_tx_control_port+0x19c/0x288 [mac80211])
	[   39.502946] [<7f17af08>] (ieee80211_tx_control_port [mac80211]) from [<7f0fc704>] (nl80211_tx_control_port+0x174/0x1d4 [cfg80211])
	[   39.515017] [<7f0fc704>] (nl80211_tx_control_port [cfg80211]) from [<808ceac4>] (genl_rcv_msg+0x154/0x340)
	[   39.526814] [<808ceac4>] (genl_rcv_msg) from [<808cdb74>] (netlink_rcv_skb+0xb8/0x11c)
	[   39.536446] [<808cdb74>] (netlink_rcv_skb) from [<808ce1d0>] (genl_rcv+0x28/0x34)
	[   39.544344] [<808ce1d0>] (genl_rcv) from [<808cd234>] (netlink_unicast+0x174/0x274)
	[   39.551895] [<808cd234>] (netlink_unicast) from [<808cd510>] (netlink_sendmsg+0x1dc/0x440)
	[   39.559362] [<808cd510>] (netlink_sendmsg) from [<808596e0>] (____sys_sendmsg+0x1a8/0x1fc)
	[   39.567697] [<808596e0>] (____sys_sendmsg) from [<8085b1a8>] (___sys_sendmsg+0xa4/0xdc)
	[   39.575941] [<8085b1a8>] (___sys_sendmsg) from [<8085b310>] (sys_sendmsg+0x44/0x74)
	[   39.583841] [<8085b310>] (sys_sendmsg) from [<80300060>] (ret_fast_syscall+0x0/0x40)
	...
	[   39.620734] Code: bad PC value
	[   39.625869] ---[ end trace 8aef983ad3cbc032 ]---

Fixes: ba60f2793d3a ("wifi: ath11k: initialize hw_ops for IPQ5018")
Signed-off-by: Ziyang Huang <hzyitc@outlook.com>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
Link: https://lore.kernel.org/r/TYZPR01MB5556D6E3F63EAB5129D11420C953A@TYZPR01MB5556.apcprd01.prod.exchangelabs.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath11k/hw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/hw.c b/drivers/net/wireless/ath/ath11k/hw.c
index ab8f0ccacc6be..727e6a785bb98 100644
--- a/drivers/net/wireless/ath/ath11k/hw.c
+++ b/drivers/net/wireless/ath/ath11k/hw.c
@@ -1165,7 +1165,7 @@ const struct ath11k_hw_ops ipq5018_ops = {
 	.mpdu_info_get_peerid = ath11k_hw_ipq8074_mpdu_info_get_peerid,
 	.rx_desc_mac_addr2_valid = ath11k_hw_ipq9074_rx_desc_mac_addr2_valid,
 	.rx_desc_mpdu_start_addr2 = ath11k_hw_ipq9074_rx_desc_mpdu_start_addr2,
-
+	.get_ring_selector = ath11k_hw_ipq8074_get_tcl_ring_selector,
 };
 
 #define ATH11K_TX_RING_MASK_0 BIT(0)
-- 
2.39.2



