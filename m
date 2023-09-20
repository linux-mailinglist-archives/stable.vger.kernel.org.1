Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EA7B7A7F90
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:28:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235743AbjITM2G (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:28:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235749AbjITM2G (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:28:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1BA28F
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:28:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBE42C433C7;
        Wed, 20 Sep 2023 12:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695212880;
        bh=qs9BMcvgc+fuH7eqylNCA/6l7sUEWxWZJMb4lMj0+XA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GVW26ZtGbRCBmSdy5B+2uMM/Ns17OZPyBXRnqtko1y/PTodSUtpaB9rPmgJXx/7Wr
         7TalLjnaiTJD7ucUYdlkoMmxEm+jr80q6P7DQBZdLLCcAzsYkGc+fXDpoX7i9nUym+
         1FvmHZPelFmqbeXf7T1WqIxHNIss/FLgzSeYv9f4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Brian Norris <briannorris@chromium.org>,
        Dmitry Antipov <dmantipov@yandex.ru>,
        Kalle Valo <kvalo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 080/367] wifi: mwifiex: avoid possible NULL skb pointer dereference
Date:   Wed, 20 Sep 2023 13:27:37 +0200
Message-ID: <20230920112900.609734714@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112858.471730572@linuxfoundation.org>
References: <20230920112858.471730572@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dmitry Antipov <dmantipov@yandex.ru>

[ Upstream commit 35a7a1ce7c7d61664ee54f5239a1f120ab95a87e ]

In 'mwifiex_handle_uap_rx_forward()', always check the value
returned by 'skb_copy()' to avoid potential NULL pointer
dereference in 'mwifiex_uap_queue_bridged_pkt()', and drop
original skb in case of copying failure.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 838e4f449297 ("mwifiex: improve uAP RX handling")
Acked-by: Brian Norris <briannorris@chromium.org>
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
Signed-off-by: Kalle Valo <kvalo@kernel.org>
Link: https://lore.kernel.org/r/20230814095041.16416-1-dmantipov@yandex.ru
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/marvell/mwifiex/uap_txrx.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/uap_txrx.c b/drivers/net/wireless/marvell/mwifiex/uap_txrx.c
index 4d2d309289426..cb3f72eee230a 100644
--- a/drivers/net/wireless/marvell/mwifiex/uap_txrx.c
+++ b/drivers/net/wireless/marvell/mwifiex/uap_txrx.c
@@ -265,7 +265,15 @@ int mwifiex_handle_uap_rx_forward(struct mwifiex_private *priv,
 
 	if (is_multicast_ether_addr(ra)) {
 		skb_uap = skb_copy(skb, GFP_ATOMIC);
-		mwifiex_uap_queue_bridged_pkt(priv, skb_uap);
+		if (likely(skb_uap)) {
+			mwifiex_uap_queue_bridged_pkt(priv, skb_uap);
+		} else {
+			mwifiex_dbg(adapter, ERROR,
+				    "failed to copy skb for uAP\n");
+			priv->stats.rx_dropped++;
+			dev_kfree_skb_any(skb);
+			return -1;
+		}
 	} else {
 		if (mwifiex_get_sta_entry(priv, ra)) {
 			/* Requeue Intra-BSS packet */
-- 
2.40.1



