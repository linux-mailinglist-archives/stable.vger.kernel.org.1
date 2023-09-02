Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DA63790814
	for <lists+stable@lfdr.de>; Sat,  2 Sep 2023 15:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231576AbjIBNat (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 2 Sep 2023 09:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbjIBNas (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 2 Sep 2023 09:30:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B559790
        for <stable@vger.kernel.org>; Sat,  2 Sep 2023 06:30:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E31946097C
        for <stable@vger.kernel.org>; Sat,  2 Sep 2023 13:30:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1373C433C8;
        Sat,  2 Sep 2023 13:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693661444;
        bh=UHgXdL+sB5DO0NB/Q7CcZV0LJQCrr7CcXy8P1V8Kb9c=;
        h=Subject:To:Cc:From:Date:From;
        b=U49vakkqGLNJ2A9Uh2z2zrzXn87MILqRxTHBE3rTh+mG2xeVt6r4jAGAbFdPOJ94G
         N8MBsoalLOaW3k7gJdDkHi2sRwjGaYOOn7PoAncm/Zhm9OKEjhcU9qPtMXO6zeCwgq
         pKJQ7n2oO4m+4p3WUjVYtj9G46M0WPo1aWlUQUsU=
Subject: FAILED: patch "[PATCH] wifi: mt76: mt7921: fix skb leak by txs missing in AMSDU" failed to apply to 5.15-stable tree
To:     deren.wu@mediatek.com, nbd@nbd.name, shayne.chen@mediatek.com,
        simon.horman@corigine.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sat, 02 Sep 2023 15:30:41 +0200
Message-ID: <2023090241-safeguard-gigantic-d636@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
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


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x b642f4c5f3de0a8f47808d32b1ebd9c427a42a66
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023090241-safeguard-gigantic-d636@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

b642f4c5f3de ("wifi: mt76: mt7921: fix skb leak by txs missing in AMSDU")
182071cdd594 ("mt76: connac: move connac2_mac_write_txwi in mt76_connac module")
d502e30020b8 ("mt76: mt7915: rely on mt76_dev in mt7915_mac_write_txwi signature")
e00b3e407efe ("mt76: mt7921: rely on mt76_dev in mt7921_mac_write_txwi signature")
869f06468e77 ("mt76: mt7915: add support for 6G in-band discovery")
bc98e7fdd80d ("mt76: fix encap offload ethernet type check")
116c69603b01 ("mt76: mt7921: Add AP mode support")
0d2afe09fad5 ("mt76: mt7921: add mt7921u driver")
8b7a56d5c0c9 ("mt76: mt7921: move mt7921_usb_sdio_tx_status_data in mac common code.")
9da47b504c5b ("mt76: mt7921: move mt7921_usb_sdio_tx_complete_skb in common mac code.")
5b834b0d4d6b ("mt76: mt7921: move mt7921_usb_sdio_tx_prepare_skb in common mac code")
b72fd217934d ("mt76: mt7921: update mt7921_skb_add_usb_sdio_hdr to support usb")
70493b869249 ("mt76: mt7915: set band1 TGID field in tx descriptor")
f1fe8eefd2dd ("mt76: use le32/16_get_bits() whenever possible")
3f71ff0868e6 ("mt76: mt7915: allow beaconing on all chains")
cbaa0a404f8d ("mt76: mt7921: fix up the monitor mode")
b8d16f1181e2 ("mt76: mt7921: fix injected MPDU transmission to not use HW A-MSDU")
006b9d4ad5bf ("mt76: mt7915: introduce band_idx in mt7915_phy")
99ad32a4ca3a ("mt76: mt7915: add support for MT7986")
355c060d5f38 ("mt76: mt7921s: fix missing fc type/sub-type for 802.11 pkts")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b642f4c5f3de0a8f47808d32b1ebd9c427a42a66 Mon Sep 17 00:00:00 2001
From: Deren Wu <deren.wu@mediatek.com>
Date: Wed, 17 May 2023 17:18:24 +0800
Subject: [PATCH] wifi: mt76: mt7921: fix skb leak by txs missing in AMSDU

txs may be dropped if the frame is aggregated in AMSDU. When the problem
shows up, some SKBs would be hold in driver to cause network stopped
temporarily. Even if the problem can be recovered by txs timeout handling,
mt7921 still need to disable txs in AMSDU to avoid this issue.

Cc: stable@vger.kernel.org
Fixes: 163f4d22c118 ("mt76: mt7921: add MAC support")
Reviewed-by: Shayne Chen <shayne.chen@mediatek.com>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Signed-off-by: Felix Fietkau <nbd@nbd.name>

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
index 3501f0503118..f481ca3a0db8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
@@ -495,6 +495,7 @@ void mt76_connac2_mac_write_txwi(struct mt76_dev *dev, __le32 *txwi,
 				    BSS_CHANGED_BEACON_ENABLED));
 	bool inband_disc = !!(changed & (BSS_CHANGED_UNSOL_BCAST_PROBE_RESP |
 					 BSS_CHANGED_FILS_DISCOVERY));
+	bool amsdu_en = wcid->amsdu;
 
 	if (vif) {
 		struct mt76_vif *mvif = (struct mt76_vif *)vif->drv_priv;
@@ -554,12 +555,14 @@ void mt76_connac2_mac_write_txwi(struct mt76_dev *dev, __le32 *txwi,
 	txwi[4] = 0;
 
 	val = FIELD_PREP(MT_TXD5_PID, pid);
-	if (pid >= MT_PACKET_ID_FIRST)
+	if (pid >= MT_PACKET_ID_FIRST) {
 		val |= MT_TXD5_TX_STATUS_HOST;
+		amsdu_en = amsdu_en && !is_mt7921(dev);
+	}
 
 	txwi[5] = cpu_to_le32(val);
 	txwi[6] = 0;
-	txwi[7] = wcid->amsdu ? cpu_to_le32(MT_TXD7_HW_AMSDU) : 0;
+	txwi[7] = amsdu_en ? cpu_to_le32(MT_TXD7_HW_AMSDU) : 0;
 
 	if (is_8023)
 		mt76_connac2_mac_write_txwi_8023(txwi, skb, wcid);

