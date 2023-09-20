Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 471127A7CAF
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235102AbjITMDQ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235092AbjITMDO (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:03:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F212ED
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:03:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A635CC433CA;
        Wed, 20 Sep 2023 12:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695211388;
        bh=vdFP5WsHGyQwl+tVzHA2WHzwrHaCrF25E2Y9Wmhrbpo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ilLg4NfIVmn/oRo1UlPGa8eHsSTdMFp9d07CXjTiuFwy6Pha6X9ueLPTjKgTdRYcy
         tKQ8CNUrx1pftyjAdjsTXa5mv7Rb3OVkLjvIBF9awVXf3qIaLkUQd8RlaPwRr14lxK
         2v9llSK3F7pj8dxBXvz9ps6QnTfW0INo67Dnu2qA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Polaris Pi <pinkperfect2021@gmail.com>,
        Dmitry Antipov <dmantipov@yandex.ru>,
        Brian Norris <briannorris@chromium.org>,
        Kalle Valo <kvalo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 048/186] wifi: mwifiex: Fix missed return in oob checks failed path
Date:   Wed, 20 Sep 2023 13:29:11 +0200
Message-ID: <20230920112838.663853477@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112836.799946261@linuxfoundation.org>
References: <20230920112836.799946261@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

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
index 09243e6d8ba9a..90c07722c25f8 100644
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



