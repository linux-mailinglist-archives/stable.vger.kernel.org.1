Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 383FE7D78D0
	for <lists+stable@lfdr.de>; Thu, 26 Oct 2023 01:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbjJYXm7 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 25 Oct 2023 19:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjJYXm7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 25 Oct 2023 19:42:59 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B11F8182;
        Wed, 25 Oct 2023 16:42:55 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id af79cd13be357-778711ee748so24795785a.2;
        Wed, 25 Oct 2023 16:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698277375; x=1698882175; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wel2VyKYXmVVIAE5xa88uFLKfxBW5uAu1BSCn+hApRQ=;
        b=kj0A9/1wgff6eQlzCwU4dO5dxdqFz2PR6nCrMDMacK5d89ZHSvzifCYMqZc6b3NR53
         hbGI+pqQqxpoKBasSp4W2ilCoTZkfTtVlWyGPDlUOpPoBKW8RUfZfN2WEz1QL595idg8
         ARKDGs8LLEb1xa2VkEukE78LGjPqXOvEibQ7NjgFqgqT0p3x1CghsmrIttuPZZrgd/U1
         qre7MN4ttpdOSPqV+Njx3rqVQdPk5BVDpOMEDaj+XR2XSlTqZYhjg0NX2n/4O0Alns4G
         7g9PxuhmMBFiRjzJcW/oXVPsWFmnFt6uRc2AE5gYn2uOUIYI0FJt32+uyLbqrX1qMi2X
         6OKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698277375; x=1698882175;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wel2VyKYXmVVIAE5xa88uFLKfxBW5uAu1BSCn+hApRQ=;
        b=dhnSOVDwRqUc/g+aH2zM49BxhanXzWCKHAc/gY4QyOMEbfqyjpbJ+gkJPjFqwPzCOX
         cJFAUuPkndvxA5VWMCFWy3dJp4HkyDWIe9Ed2ghsS7ZzNGGdE6pbvOW6AkplAQ0b4CLP
         pOPYhre+JEc/qXWNYxrh7cremlfTHxnThQiirVfoovdcf9c81hsr2hayZW2WErvXzO+u
         XOmefFSRuUHSOAcvuv7F4dRJylNiimi5nI1Ekjt/lkVZrp9U5FHDsPO8G74/PFSHfvAF
         ePTUYKDO/Q2n0xvpit/cr9zfahXRdrsU+lmY3rLk1EofYlVZiNGaxiNLjNDBZbyoLK8L
         g8Wg==
X-Gm-Message-State: AOJu0YwV9kRFeus0PH9JyAwqh73qtogscfGeYDt+oU/plYl4cT7YD+Us
        WV2wyqdwgx0jLY4dO+4gP6Or0V4Oi5k=
X-Google-Smtp-Source: AGHT+IE5Zjz7N6ZLSy2I644opaRJHJ/VHFW2Fx//iRFGbuBV7kiQ2oxc3skBJR8aiAy97cm5n2wLxg==
X-Received: by 2002:a05:620a:1a92:b0:760:6b8e:eba with SMTP id bl18-20020a05620a1a9200b007606b8e0ebamr17027676qkb.12.1698277374818;
        Wed, 25 Oct 2023 16:42:54 -0700 (PDT)
Received: from willemb.c.googlers.com.com (193.132.150.34.bc.googleusercontent.com. [34.150.132.193])
        by smtp.gmail.com with ESMTPSA id h12-20020a05620a10ac00b00765ab6d3e81sm4572994qkk.122.2023.10.25.16.42.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 16:42:54 -0700 (PDT)
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
        pabeni@redhat.com, stable@vger.kernel.org,
        Willem de Bruijn <willemb@google.com>,
        syzbot+a8c7be6dee0de1b669cc@syzkaller.appspotmail.com
Subject: [PATCH net v2] llc: verify mac len before reading mac header
Date:   Wed, 25 Oct 2023 19:42:38 -0400
Message-ID: <20231025234251.3796495-1-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Willem de Bruijn <willemb@google.com>

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

---

Changes
  v1->v2
    - fix return value in llc_sap_action_send_test_r
    - add Fixes tag
    - cc: stable@vger.kernel.org
---
 net/llc/llc_input.c   | 10 ++++++++--
 net/llc/llc_s_ac.c    |  3 +++
 net/llc/llc_station.c |  3 +++
 3 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/net/llc/llc_input.c b/net/llc/llc_input.c
index 7cac441862e21..51bccfb00a9cd 100644
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
index 79d1cef8f15a9..06fb8e6944b06 100644
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
index 05c6ae0920534..f506542925109 100644
--- a/net/llc/llc_station.c
+++ b/net/llc/llc_station.c
@@ -76,6 +76,9 @@ static int llc_station_ac_send_test_r(struct sk_buff *skb)
 	u32 data_size;
 	struct sk_buff *nskb;
 
+	if (skb->mac_len < ETH_HLEN)
+		goto out;
+
 	/* The test request command is type U (llc_len = 3) */
 	data_size = ntohs(eth_hdr(skb)->h_proto) - 3;
 	nskb = llc_alloc_frame(NULL, skb->dev, LLC_PDU_TYPE_U, data_size);
-- 
2.42.0.758.gaed0368e0e-goog

