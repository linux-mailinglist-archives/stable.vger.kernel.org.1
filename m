Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73EE26F8F47
	for <lists+stable@lfdr.de>; Sat,  6 May 2023 08:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbjEFGjQ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 6 May 2023 02:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjEFGjQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 6 May 2023 02:39:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 165C5900B
        for <stable@vger.kernel.org>; Fri,  5 May 2023 23:39:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9FDE1601B6
        for <stable@vger.kernel.org>; Sat,  6 May 2023 06:39:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33E15C433D2;
        Sat,  6 May 2023 06:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683355154;
        bh=nw+9ydsccZKQWP+kgN5AZdo8UKXboxHdMSSR5ts7MGY=;
        h=Subject:To:Cc:From:Date:From;
        b=f3KnXgb7YH8m9htxspqEu3RxkXxETDhJDjESyt/8TnvIhHEMmHKKQ0npeiedNDDzm
         9cdTCDM84MnDnPKgTr2NYc80kUsxq1PVoYnx4KHUr3dzOHV9pjnEMamZYUUvA+5euV
         E2T7CER/f9Mx0c+n7OP4R+6Ma6oA9Evra5xPDErc=
Subject: FAILED: patch "[PATCH] wifi: mt76: add missing locking to protect against concurrent" failed to apply to 5.10-stable tree
To:     nbd@nbd.name, brian@mainsequence.net
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sat, 06 May 2023 11:18:59 +0900
Message-ID: <2023050659-composure-starry-4d39@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 5b8ccdfb943f6a03c676d2ea816dd38c149e920b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023050659-composure-starry-4d39@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5b8ccdfb943f6a03c676d2ea816dd38c149e920b Mon Sep 17 00:00:00 2001
From: Felix Fietkau <nbd@nbd.name>
Date: Fri, 14 Apr 2023 14:10:54 +0200
Subject: [PATCH] wifi: mt76: add missing locking to protect against concurrent
 rx/status calls

According to the documentation, ieee80211_rx_list must not run concurrently
with ieee80211_tx_status (or its variants).

Cc: stable@vger.kernel.org
Fixes: 88046b2c9f6d ("mt76: add support for reporting tx status with skb")
Reported-by: Brian Coverstone <brian@mainsequence.net>
Signed-off-by: Felix Fietkau <nbd@nbd.name>

diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wireless/mediatek/mt76/dma.c
index 738d7e1569bf..6c0174313d09 100644
--- a/drivers/net/wireless/mediatek/mt76/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/dma.c
@@ -578,7 +578,9 @@ mt76_dma_tx_queue_skb(struct mt76_dev *dev, struct mt76_queue *q,
 free_skb:
 	status.skb = tx_info.skb;
 	hw = mt76_tx_status_get_hw(dev, tx_info.skb);
+	spin_lock_bh(&dev->rx_lock);
 	ieee80211_tx_status_ext(hw, &status);
+	spin_unlock_bh(&dev->rx_lock);
 
 	return ret;
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
index 70a7f84af028..12e0af52082a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
@@ -1279,8 +1279,11 @@ void mt7603_mac_add_txs(struct mt7603_dev *dev, void *data)
 	if (wcidx >= MT7603_WTBL_STA || !sta)
 		goto out;
 
-	if (mt7603_fill_txs(dev, msta, &info, txs_data))
+	if (mt7603_fill_txs(dev, msta, &info, txs_data)) {
+		spin_lock_bh(&dev->mt76.rx_lock);
 		ieee80211_tx_status_noskb(mt76_hw(dev), sta, &info);
+		spin_unlock_bh(&dev->mt76.rx_lock);
+	}
 
 out:
 	rcu_read_unlock();
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index 6d6b46d7bd1a..ce216bad3b73 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -1558,8 +1558,11 @@ static void mt7615_mac_add_txs(struct mt7615_dev *dev, void *data)
 	if (wcid->phy_idx && dev->mt76.phys[MT_BAND1])
 		mphy = dev->mt76.phys[MT_BAND1];
 
-	if (mt7615_fill_txs(dev, msta, &info, txs_data))
+	if (mt7615_fill_txs(dev, msta, &info, txs_data)) {
+		spin_lock_bh(&dev->mt76.rx_lock);
 		ieee80211_tx_status_noskb(mphy->hw, sta, &info);
+		spin_unlock_bh(&dev->mt76.rx_lock);
+	}
 
 out:
 	rcu_read_unlock();
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c b/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
index d3f74473e6fb..3e41d809ade3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
@@ -631,8 +631,11 @@ void mt76x02_send_tx_status(struct mt76x02_dev *dev,
 
 	mt76_tx_status_unlock(mdev, &list);
 
-	if (!status.skb)
+	if (!status.skb) {
+		spin_lock_bh(&dev->mt76.rx_lock);
 		ieee80211_tx_status_ext(mt76_hw(dev), &status);
+		spin_unlock_bh(&dev->mt76.rx_lock);
+	}
 
 	if (!len)
 		goto out;
diff --git a/drivers/net/wireless/mediatek/mt76/tx.c b/drivers/net/wireless/mediatek/mt76/tx.c
index 3ad9742364ba..72b3ec715e47 100644
--- a/drivers/net/wireless/mediatek/mt76/tx.c
+++ b/drivers/net/wireless/mediatek/mt76/tx.c
@@ -77,7 +77,9 @@ mt76_tx_status_unlock(struct mt76_dev *dev, struct sk_buff_head *list)
 		}
 
 		hw = mt76_tx_status_get_hw(dev, skb);
+		spin_lock_bh(&dev->rx_lock);
 		ieee80211_tx_status_ext(hw, &status);
+		spin_unlock_bh(&dev->rx_lock);
 	}
 	rcu_read_unlock();
 }
@@ -263,7 +265,9 @@ void __mt76_tx_complete_skb(struct mt76_dev *dev, u16 wcid_idx, struct sk_buff *
 	if (cb->pktid < MT_PACKET_ID_FIRST) {
 		hw = mt76_tx_status_get_hw(dev, skb);
 		status.sta = wcid_to_sta(wcid);
+		spin_lock_bh(&dev->rx_lock);
 		ieee80211_tx_status_ext(hw, &status);
+		spin_unlock_bh(&dev->rx_lock);
 		goto out;
 	}
 

