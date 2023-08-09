Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70A50775943
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 12:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232808AbjHIK7A (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 06:59:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232798AbjHIK7A (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 06:59:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5A64ED
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 03:58:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6BABC6313E
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 10:58:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B7C5C433C8;
        Wed,  9 Aug 2023 10:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691578738;
        bh=uV45xLpK5Qq4q0FfiZ+9HpKMAuYVCKcqq+Oyat4qdcU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yONno9S3DKjT0Kc1z1/buRy3YP1OEyoigzN6PJjBmTyq1W1guhyUdtXwM0HpYsOl8
         BiOdNVB6gDP2PuXuMAbCmVyVioIDazYgMEm++Lls0iiclPHheTQIJaITJ5NSnNMuZC
         cor+0YXm7K349MyAVWVxqjUZy1OoS1LRiSvXZSsE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Chengfeng Ye <dg573847474@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 22/92] mISDN: hfcpci: Fix potential deadlock on &hc->lock
Date:   Wed,  9 Aug 2023 12:40:58 +0200
Message-ID: <20230809103634.377894282@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103633.485906560@linuxfoundation.org>
References: <20230809103633.485906560@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Chengfeng Ye <dg573847474@gmail.com>

[ Upstream commit 56c6be35fcbed54279df0a2c9e60480a61841d6f ]

As &hc->lock is acquired by both timer _hfcpci_softirq() and hardirq
hfcpci_int(), the timer should disable irq before lock acquisition
otherwise deadlock could happen if the timmer is preemtped by the hadr irq.

Possible deadlock scenario:
hfcpci_softirq() (timer)
    -> _hfcpci_softirq()
    -> spin_lock(&hc->lock);
        <irq interruption>
        -> hfcpci_int()
        -> spin_lock(&hc->lock); (deadlock here)

This flaw was found by an experimental static analysis tool I am developing
for irq-related deadlock.

The tentative patch fixes the potential deadlock by spin_lock_irq()
in timer.

Fixes: b36b654a7e82 ("mISDN: Create /sys/class/mISDN")
Signed-off-by: Chengfeng Ye <dg573847474@gmail.com>
Link: https://lore.kernel.org/r/20230727085619.7419-1-dg573847474@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/isdn/hardware/mISDN/hfcpci.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/isdn/hardware/mISDN/hfcpci.c b/drivers/isdn/hardware/mISDN/hfcpci.c
index eba58b99cd29d..d6cf01c32a33d 100644
--- a/drivers/isdn/hardware/mISDN/hfcpci.c
+++ b/drivers/isdn/hardware/mISDN/hfcpci.c
@@ -839,7 +839,7 @@ hfcpci_fill_fifo(struct bchannel *bch)
 		*z1t = cpu_to_le16(new_z1);	/* now send data */
 		if (bch->tx_idx < bch->tx_skb->len)
 			return;
-		dev_kfree_skb(bch->tx_skb);
+		dev_kfree_skb_any(bch->tx_skb);
 		if (get_next_bframe(bch))
 			goto next_t_frame;
 		return;
@@ -895,7 +895,7 @@ hfcpci_fill_fifo(struct bchannel *bch)
 	}
 	bz->za[new_f1].z1 = cpu_to_le16(new_z1);	/* for next buffer */
 	bz->f1 = new_f1;	/* next frame */
-	dev_kfree_skb(bch->tx_skb);
+	dev_kfree_skb_any(bch->tx_skb);
 	get_next_bframe(bch);
 }
 
@@ -1119,7 +1119,7 @@ tx_birq(struct bchannel *bch)
 	if (bch->tx_skb && bch->tx_idx < bch->tx_skb->len)
 		hfcpci_fill_fifo(bch);
 	else {
-		dev_kfree_skb(bch->tx_skb);
+		dev_kfree_skb_any(bch->tx_skb);
 		if (get_next_bframe(bch))
 			hfcpci_fill_fifo(bch);
 	}
@@ -2277,7 +2277,7 @@ _hfcpci_softirq(struct device *dev, void *unused)
 		return 0;
 
 	if (hc->hw.int_m2 & HFCPCI_IRQ_ENABLE) {
-		spin_lock(&hc->lock);
+		spin_lock_irq(&hc->lock);
 		bch = Sel_BCS(hc, hc->hw.bswapped ? 2 : 1);
 		if (bch && bch->state == ISDN_P_B_RAW) { /* B1 rx&tx */
 			main_rec_hfcpci(bch);
@@ -2288,7 +2288,7 @@ _hfcpci_softirq(struct device *dev, void *unused)
 			main_rec_hfcpci(bch);
 			tx_birq(bch);
 		}
-		spin_unlock(&hc->lock);
+		spin_unlock_irq(&hc->lock);
 	}
 	return 0;
 }
-- 
2.40.1



