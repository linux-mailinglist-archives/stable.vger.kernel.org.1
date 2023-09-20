Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E5FE7A7DCC
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234608AbjITMMZ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:12:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235399AbjITMMZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:12:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19FBBF7
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:12:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60477C433C7;
        Wed, 20 Sep 2023 12:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695211936;
        bh=Goi641lDrjlDiIoPEJWUikcJKAkTABck/2LwKHl9WsY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OTqbPvyCOBfcBj/OZNaRwoHgi0BPx9CRf4gB49hQi/2nfvQ5RbKWx8K0ZV+cO6pur
         lBqyxi2KH8DwI1rH662xklaWe+u/Rr1PLL9GMD8LqzCvpGtX7+RFoG7bMYJ3EMcnG/
         Z/Jp+B44Hu+QfNkUCdml9NzpgvrNuGAWbjMiFpx4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Polaris Pi <pinkperfect2021@gmail.com>,
        Dmitry Antipov <dmantipov@yandex.ru>,
        Brian Norris <briannorris@chromium.org>,
        Kalle Valo <kvalo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 064/273] wifi: mwifiex: Fix missed return in oob checks failed path
Date:   Wed, 20 Sep 2023 13:28:24 +0200
Message-ID: <20230920112848.440364096@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112846.440597133@linuxfoundation.org>
References: <20230920112846.440597133@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Polaris Pi <pinkperfect2021@gmail.com>

[ Upstream commit 2785851c627f2db05f9271f7f63661b5dbd95c4c ]

Add missed return in mwifiex_uap_queue_bridged_pkt() and
mwifiex_process_rx_packet().

Fixes: 119585281617 ("wifi: mwifiex: Fix OOB and integer underflow when rx packets")
Signed-off-by: Polaris Pi <pinkperfect2021@gmail.com>
Reported-by: Dmitry Antipov <dmantipov@yandex.ru>
Acked-by: Brian Norris <briannorris@chromium.org>
Signed-off-by: Kalle Valo <kvalo@kernel.org>
Link: https://lore.kernel.org/r/20230810083911.3725248-1-pinkperfect2021@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/marvell/mwifiex/sta_rx.c   | 1 +
 drivers/net/wireless/marvell/mwifiex/uap_txrx.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/net/wireless/marvell/mwifiex/sta_rx.c b/drivers/net/wireless/marvell/mwifiex/sta_rx.c
index a3d716a215ef2..f3c6daeba1b85 100644
--- a/drivers/net/wireless/marvell/mwifiex/sta_rx.c
+++ b/drivers/net/wireless/marvell/mwifiex/sta_rx.c
@@ -104,6 +104,7 @@ int mwifiex_process_rx_packet(struct mwifiex_private *priv,
 			    skb->len, rx_pkt_off);
 		priv->stats.rx_dropped++;
 		dev_kfree_skb_any(skb);
+		return -1;
 	}
 
 	if ((!memcmp(&rx_pkt_hdr->rfc1042_hdr, bridge_tunnel_header,
diff --git a/drivers/net/wireless/marvell/mwifiex/uap_txrx.c b/drivers/net/wireless/marvell/mwifiex/uap_txrx.c
index c1dec186784b9..c723eb16d0914 100644
--- a/drivers/net/wireless/marvell/mwifiex/uap_txrx.c
+++ b/drivers/net/wireless/marvell/mwifiex/uap_txrx.c
@@ -123,6 +123,7 @@ static void mwifiex_uap_queue_bridged_pkt(struct mwifiex_private *priv,
 			    skb->len, le16_to_cpu(uap_rx_pd->rx_pkt_offset));
 		priv->stats.rx_dropped++;
 		dev_kfree_skb_any(skb);
+		return;
 	}
 
 	if ((!memcmp(&rx_pkt_hdr->rfc1042_hdr, bridge_tunnel_header,
-- 
2.40.1



