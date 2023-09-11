Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5992679AECB
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 01:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349245AbjIKVc5 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:32:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240113AbjIKOg4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:36:56 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3332CF0
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:36:51 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 278F6C433CA;
        Mon, 11 Sep 2023 14:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694443011;
        bh=QpMOGEi8NmhqVMc14QXwJ2GvycgvKbAka5PydQ8j3qc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LA2AnbzOHYAxuqN+YR9eQFz8rTcle4ZRtB2AJakfYfYSv0mA8A3/03efMMe/dodGc
         t6cHivl6bKjvAIAjVv73ITMM2RdxvPxaLtvVSe+arPSogMKKc6CkoMq0XBvCUvDPWO
         T+k56SsW5s6iTaxfDPslhF1qKI/1tEIDRxJyjSFY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Polaris Pi <pinkperfect2021@gmail.com>,
        Dmitry Antipov <dmantipov@yandex.ru>,
        Brian Norris <briannorris@chromium.org>,
        Kalle Valo <kvalo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 226/737] wifi: mwifiex: Fix missed return in oob checks failed path
Date:   Mon, 11 Sep 2023 15:41:25 +0200
Message-ID: <20230911134656.893632327@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.286315610@linuxfoundation.org>
References: <20230911134650.286315610@linuxfoundation.org>
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

6.4-stable review patch.  If anyone has any objections, please let me know.

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
index f2899d53a43f9..65420ad674167 100644
--- a/drivers/net/wireless/marvell/mwifiex/sta_rx.c
+++ b/drivers/net/wireless/marvell/mwifiex/sta_rx.c
@@ -92,6 +92,7 @@ int mwifiex_process_rx_packet(struct mwifiex_private *priv,
 			    skb->len, rx_pkt_off);
 		priv->stats.rx_dropped++;
 		dev_kfree_skb_any(skb);
+		return -1;
 	}
 
 	if ((!memcmp(&rx_pkt_hdr->rfc1042_hdr, bridge_tunnel_header,
diff --git a/drivers/net/wireless/marvell/mwifiex/uap_txrx.c b/drivers/net/wireless/marvell/mwifiex/uap_txrx.c
index 04ff051f5d186..c1b8d41dd7536 100644
--- a/drivers/net/wireless/marvell/mwifiex/uap_txrx.c
+++ b/drivers/net/wireless/marvell/mwifiex/uap_txrx.c
@@ -110,6 +110,7 @@ static void mwifiex_uap_queue_bridged_pkt(struct mwifiex_private *priv,
 			    skb->len, le16_to_cpu(uap_rx_pd->rx_pkt_offset));
 		priv->stats.rx_dropped++;
 		dev_kfree_skb_any(skb);
+		return;
 	}
 
 	if ((!memcmp(&rx_pkt_hdr->rfc1042_hdr, bridge_tunnel_header,
-- 
2.40.1



