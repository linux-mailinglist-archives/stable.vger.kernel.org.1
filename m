Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A19807ED311
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 21:46:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233698AbjKOUqC (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 15:46:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233692AbjKOUqB (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 15:46:01 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E90AD4E
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 12:45:58 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E79E4C433CB;
        Wed, 15 Nov 2023 20:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700081158;
        bh=S5cBMtcOLxmjfadRuCPcSc3pDRpRz2WnPZLg3Vu7kYA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g3lPyxB8fp+m4aexDnddm6MuVJ6N9wGRx4IoFkTsNiZdPp/CqXpD/CvlKvqPrGrge
         Kt2jGe1zNc3cuZSVkr3VSxDFRRqeXrMoGx7rl3kIePqU5XUoHHeou2iqFie7hZJwWG
         Q72XEpVRDeGzr6znrqO5DmiYkNZZUEOrrSwjCH1k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        syzbot+a8c7be6dee0de1b669cc@syzkaller.appspotmail.com,
        Willem de Bruijn <willemb@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 72/88] llc: verify mac len before reading mac header
Date:   Wed, 15 Nov 2023 15:36:24 -0500
Message-ID: <20231115191430.435423726@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191426.221330369@linuxfoundation.org>
References: <20231115191426.221330369@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Willem de Bruijn <willemb@google.com>

[ Upstream commit 7b3ba18703a63f6fd487183b9262b08e5632da1b ]

LLC reads the mac header with eth_hdr without verifying that the skb
has an Ethernet header.

Syzbot was able to enter llc_rcv on a tun device. Tun can insert
packets without mac len and with user configurable skb->protocol
(passing a tun_pi header when not configuring IFF_NO_PI).

    BUG: KMSAN: uninit-value in llc_station_ac_send_test_r net/llc/llc_station.c:81 [inline]
    BUG: KMSAN: uninit-value in llc_station_rcv+0x6fb/0x1290 net/llc/llc_station.c:111
    llc_station_ac_send_test_r net/llc/llc_station.c:81 [inline]
    llc_station_rcv+0x6fb/0x1290 net/llc/llc_station.c:111
    llc_rcv+0xc5d/0x14a0 net/llc/llc_input.c:218
    __netif_receive_skb_one_core net/core/dev.c:5523 [inline]
    __netif_receive_skb+0x1a6/0x5a0 net/core/dev.c:5637
    netif_receive_skb_internal net/core/dev.c:5723 [inline]
    netif_receive_skb+0x58/0x660 net/core/dev.c:5782
    tun_rx_batched+0x3ee/0x980 drivers/net/tun.c:1555
    tun_get_user+0x54c5/0x69c0 drivers/net/tun.c:2002

Add a mac_len test before all three eth_hdr(skb) calls under net/llc.

There are further uses in include/net/llc_pdu.h. All these are
protected by a test skb->protocol == ETH_P_802_2. Which does not
protect against this tun scenario.

But the mac_len test added in this patch in llc_fixup_skb will
indirectly protect those too. That is called from llc_rcv before any
other LLC code.

It is tempting to just add a blanket mac_len check in llc_rcv, but
not sure whether that could break valid LLC paths that do not assume
an Ethernet header. 802.2 LLC may be used on top of non-802.3
protocols in principle. The below referenced commit shows that used
to, on top of Token Ring.

At least one of the three eth_hdr uses goes back to before the start
of git history. But the one that syzbot exercises is introduced in
this commit. That commit is old enough (2008), that effectively all
stable kernels should receive this.

Fixes: f83f1768f833 ("[LLC]: skb allocation size for responses")
Reported-by: syzbot+a8c7be6dee0de1b669cc@syzkaller.appspotmail.com
Signed-off-by: Willem de Bruijn <willemb@google.com>
Link: https://lore.kernel.org/r/20231025234251.3796495-1-willemdebruijn.kernel@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/llc/llc_input.c   | 10 ++++++++--
 net/llc/llc_s_ac.c    |  3 +++
 net/llc/llc_station.c |  3 +++
 3 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/net/llc/llc_input.c b/net/llc/llc_input.c
index f9e801cc50f5e..f4fb309185ced 100644
--- a/net/llc/llc_input.c
+++ b/net/llc/llc_input.c
@@ -127,8 +127,14 @@ static inline int llc_fixup_skb(struct sk_buff *skb)
 	skb->transport_header += llc_len;
 	skb_pull(skb, llc_len);
 	if (skb->protocol == htons(ETH_P_802_2)) {
-		__be16 pdulen = eth_hdr(skb)->h_proto;
-		s32 data_size = ntohs(pdulen) - llc_len;
+		__be16 pdulen;
+		s32 data_size;
+
+		if (skb->mac_len < ETH_HLEN)
+			return 0;
+
+		pdulen = eth_hdr(skb)->h_proto;
+		data_size = ntohs(pdulen) - llc_len;
 
 		if (data_size < 0 ||
 		    !pskb_may_pull(skb, data_size))
diff --git a/net/llc/llc_s_ac.c b/net/llc/llc_s_ac.c
index 9fa3342c7a829..df26557a02448 100644
--- a/net/llc/llc_s_ac.c
+++ b/net/llc/llc_s_ac.c
@@ -153,6 +153,9 @@ int llc_sap_action_send_test_r(struct llc_sap *sap, struct sk_buff *skb)
 	int rc = 1;
 	u32 data_size;
 
+	if (skb->mac_len < ETH_HLEN)
+		return 1;
+
 	llc_pdu_decode_sa(skb, mac_da);
 	llc_pdu_decode_da(skb, mac_sa);
 	llc_pdu_decode_ssap(skb, &dsap);
diff --git a/net/llc/llc_station.c b/net/llc/llc_station.c
index c29170e767a8c..64e2c67e16ba3 100644
--- a/net/llc/llc_station.c
+++ b/net/llc/llc_station.c
@@ -77,6 +77,9 @@ static int llc_station_ac_send_test_r(struct sk_buff *skb)
 	u32 data_size;
 	struct sk_buff *nskb;
 
+	if (skb->mac_len < ETH_HLEN)
+		goto out;
+
 	/* The test request command is type U (llc_len = 3) */
 	data_size = ntohs(eth_hdr(skb)->h_proto) - 3;
 	nskb = llc_alloc_frame(NULL, skb->dev, LLC_PDU_TYPE_U, data_size);
-- 
2.42.0



