Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2795D6FA3E4
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 11:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233191AbjEHJwy (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 05:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233558AbjEHJwo (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 05:52:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5583724521
        for <stable@vger.kernel.org>; Mon,  8 May 2023 02:52:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CB3B0621FE
        for <stable@vger.kernel.org>; Mon,  8 May 2023 09:52:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDDF4C433A0;
        Mon,  8 May 2023 09:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683539561;
        bh=GDEKD06hoCmQmrfYT/KEdY/P49lDm8Y3saco0Dww344=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QbqDsHbgLXX4J6S5fZThVlnYKiiD5v05S72yLi0pdKlYwf+ufJe7/8FSqSbyTPhwp
         qUWQfmaoWDnWH6uZ1oGJbBkUzIGkPABJtUtUmCGJHDhbvX5aOP+KUmAeC6Ki6fIj00
         R+K95vvu1ytgaIs8Vwb5Ue1qhab6xwdJkFZ04FiI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Brian Coverstone <brian@mainsequence.net>,
        Felix Fietkau <nbd@nbd.name>
Subject: [PATCH 6.1 062/611] wifi: mt76: add missing locking to protect against concurrent rx/status calls
Date:   Mon,  8 May 2023 11:38:24 +0200
Message-Id: <20230508094423.990097534@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094421.513073170@linuxfoundation.org>
References: <20230508094421.513073170@linuxfoundation.org>
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

From: Felix Fietkau <nbd@nbd.name>

commit 5b8ccdfb943f6a03c676d2ea816dd38c149e920b upstream.

According to the documentation, ieee80211_rx_list must not run concurrently
with ieee80211_tx_status (or its variants).

Cc: stable@vger.kernel.org
Fixes: 88046b2c9f6d ("mt76: add support for reporting tx status with skb")
Reported-by: Brian Coverstone <brian@mainsequence.net>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/mediatek/mt76/dma.c         |    2 ++
 drivers/net/wireless/mediatek/mt76/mt7603/mac.c  |    5 ++++-
 drivers/net/wireless/mediatek/mt76/mt7615/mac.c  |    5 ++++-
 drivers/net/wireless/mediatek/mt76/mt76x02_mac.c |    5 ++++-
 drivers/net/wireless/mediatek/mt76/tx.c          |    4 ++++
 5 files changed, 18 insertions(+), 3 deletions(-)

--- a/drivers/net/wireless/mediatek/mt76/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/dma.c
@@ -436,7 +436,9 @@ free:
 free_skb:
 	status.skb = tx_info.skb;
 	hw = mt76_tx_status_get_hw(dev, tx_info.skb);
+	spin_lock_bh(&dev->rx_lock);
 	ieee80211_tx_status_ext(hw, &status);
+	spin_unlock_bh(&dev->rx_lock);
 
 	return ret;
 }
--- a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
@@ -1279,8 +1279,11 @@ void mt7603_mac_add_txs(struct mt7603_de
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
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -1517,8 +1517,11 @@ static void mt7615_mac_add_txs(struct mt
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
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
@@ -631,8 +631,11 @@ void mt76x02_send_tx_status(struct mt76x
 
 	mt76_tx_status_unlock(mdev, &list);
 
-	if (!status.skb)
+	if (!status.skb) {
+		spin_lock_bh(&dev->mt76.rx_lock);
 		ieee80211_tx_status_ext(mt76_hw(dev), &status);
+		spin_unlock_bh(&dev->mt76.rx_lock);
+	}
 
 	if (!len)
 		goto out;
--- a/drivers/net/wireless/mediatek/mt76/tx.c
+++ b/drivers/net/wireless/mediatek/mt76/tx.c
@@ -77,7 +77,9 @@ mt76_tx_status_unlock(struct mt76_dev *d
 		}
 
 		hw = mt76_tx_status_get_hw(dev, skb);
+		spin_lock_bh(&dev->rx_lock);
 		ieee80211_tx_status_ext(hw, &status);
+		spin_unlock_bh(&dev->rx_lock);
 	}
 	rcu_read_unlock();
 }
@@ -263,7 +265,9 @@ void __mt76_tx_complete_skb(struct mt76_
 	if (cb->pktid < MT_PACKET_ID_FIRST) {
 		hw = mt76_tx_status_get_hw(dev, skb);
 		status.sta = wcid_to_sta(wcid);
+		spin_lock_bh(&dev->rx_lock);
 		ieee80211_tx_status_ext(hw, &status);
+		spin_unlock_bh(&dev->rx_lock);
 		goto out;
 	}
 


