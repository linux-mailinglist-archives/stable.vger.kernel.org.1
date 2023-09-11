Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 781EC79B4EA
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240587AbjIKV2p (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:28:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238427AbjIKN4X (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 09:56:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4602310E
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 06:56:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90C38C433C8;
        Mon, 11 Sep 2023 13:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694440578;
        bh=Oj/KkJHDj6CeEtsID+5FOpk7zZechjY4TrdXYU0wjUo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qdVoYpxjmU9FtJ0MfmAr5Zcx5/UIR+fWqZrTEiBT9TrnBcvQTld3XMVI/9HOT/3h6
         yffR7TJQPG+Kxm0zHf1CMxL7DMWAY5YqVpCe8snnzDchf10sI4G7/yZid2hfPsFi5V
         Nc/kxWOyz0h3vLSAwfOvUWUOpTi953kjYv8p5354=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Shayne Chen <shayne.chen@mediatek.com>,
        Peter Chiu <chui-hao.chiu@mediatek.com>,
        Felix Fietkau <nbd@nbd.name>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 085/739] wifi: mt76: mt7996: fix bss wlan_idx when sending bss_info command
Date:   Mon, 11 Sep 2023 15:38:04 +0200
Message-ID: <20230911134653.483610538@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.921299741@linuxfoundation.org>
References: <20230911134650.921299741@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Chiu <chui-hao.chiu@mediatek.com>

[ Upstream commit cc945b546227423488fe4be0ab92fd126b703246 ]

The bmc_tx_wlan_idx should be the wlan_idx of the current bss rather
than peer AP's wlan_idx, otherwise there will appear some frame
decryption problems on station mode.

Fixes: 98686cd21624 ("wifi: mt76: mt7996: add driver for MediaTek Wi-Fi 7 (802.11be) devices")
Reviewed-by: Shayne Chen <shayne.chen@mediatek.com>
Signed-off-by: Peter Chiu <chui-hao.chiu@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index 88e2f9d0e5130..cd54e81d73044 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -712,6 +712,7 @@ mt7996_mcu_bss_basic_tlv(struct sk_buff *skb,
 	struct cfg80211_chan_def *chandef = &phy->chandef;
 	struct mt76_connac_bss_basic_tlv *bss;
 	u32 type = CONNECTION_INFRA_AP;
+	u16 sta_wlan_idx = wlan_idx;
 	struct tlv *tlv;
 	int idx;
 
@@ -731,7 +732,7 @@ mt7996_mcu_bss_basic_tlv(struct sk_buff *skb,
 				struct mt76_wcid *wcid;
 
 				wcid = (struct mt76_wcid *)sta->drv_priv;
-				wlan_idx = wcid->idx;
+				sta_wlan_idx = wcid->idx;
 			}
 			rcu_read_unlock();
 		}
@@ -751,7 +752,7 @@ mt7996_mcu_bss_basic_tlv(struct sk_buff *skb,
 	bss->bcn_interval = cpu_to_le16(vif->bss_conf.beacon_int);
 	bss->dtim_period = vif->bss_conf.dtim_period;
 	bss->bmc_tx_wlan_idx = cpu_to_le16(wlan_idx);
-	bss->sta_idx = cpu_to_le16(wlan_idx);
+	bss->sta_idx = cpu_to_le16(sta_wlan_idx);
 	bss->conn_type = cpu_to_le32(type);
 	bss->omac_idx = mvif->omac_idx;
 	bss->band_idx = mvif->band_idx;
-- 
2.40.1



