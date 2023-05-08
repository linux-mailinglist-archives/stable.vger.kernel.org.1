Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84EE56FA4DA
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233975AbjEHKD5 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233980AbjEHKD4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:03:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94F2C2EB1A
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:03:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 108C1622E1
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:03:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29BBCC433D2;
        Mon,  8 May 2023 10:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683540232;
        bh=yS2yLEY4YsE/mfRzJ7zd61p0XZAVoV4brVk1722L+yA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Fl3npxgVQzPNXFq/Cz2oZ6UZ1Uz9Tg/fKFhyc1IwjHykYjPtJqBrXT3pst7k1t9wF
         z7qaDQcF1m4MAy2pj0Noks16B63AoJEUcuXJsFGk4+bBZBTxKy/UL4Wieemrisd4gX
         Hx2Oo01jnf49mALYhu8ygOb9nqnnKqRd8LD0uNT0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Eric Dumazet <edumazet@google.com>,
        syzbot <syzkaller@googlegroups.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 287/611] net/packet: convert po->origdev to an atomic flag
Date:   Mon,  8 May 2023 11:42:09 +0200
Message-Id: <20230508094431.710098307@linuxfoundation.org>
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

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit ee5675ecdf7a4e713ed21d98a70c2871d6ebed01 ]

syzbot/KCAN reported that po->origdev can be read
while another thread is changing its value.

We can avoid this splat by converting this field
to an actual bit.

Following patches will convert remaining 1bit fields.

Fixes: 80feaacb8a64 ("[AF_PACKET]: Add option to return orig_dev to userspace.")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/packet/af_packet.c | 10 ++++------
 net/packet/diag.c      |  2 +-
 net/packet/internal.h  | 22 +++++++++++++++++++++-
 3 files changed, 26 insertions(+), 8 deletions(-)

diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index b5487bd8ffc9d..6c572fcbb4bc5 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -2185,7 +2185,7 @@ static int packet_rcv(struct sk_buff *skb, struct net_device *dev,
 	sll = &PACKET_SKB_CB(skb)->sa.ll;
 	sll->sll_hatype = dev->type;
 	sll->sll_pkttype = skb->pkt_type;
-	if (unlikely(po->origdev))
+	if (unlikely(packet_sock_flag(po, PACKET_SOCK_ORIGDEV)))
 		sll->sll_ifindex = orig_dev->ifindex;
 	else
 		sll->sll_ifindex = dev->ifindex;
@@ -2460,7 +2460,7 @@ static int tpacket_rcv(struct sk_buff *skb, struct net_device *dev,
 	sll->sll_hatype = dev->type;
 	sll->sll_protocol = skb->protocol;
 	sll->sll_pkttype = skb->pkt_type;
-	if (unlikely(po->origdev))
+	if (unlikely(packet_sock_flag(po, PACKET_SOCK_ORIGDEV)))
 		sll->sll_ifindex = orig_dev->ifindex;
 	else
 		sll->sll_ifindex = dev->ifindex;
@@ -3913,9 +3913,7 @@ packet_setsockopt(struct socket *sock, int level, int optname, sockptr_t optval,
 		if (copy_from_sockptr(&val, optval, sizeof(val)))
 			return -EFAULT;
 
-		lock_sock(sk);
-		po->origdev = !!val;
-		release_sock(sk);
+		packet_sock_flag_set(po, PACKET_SOCK_ORIGDEV, val);
 		return 0;
 	}
 	case PACKET_VNET_HDR:
@@ -4064,7 +4062,7 @@ static int packet_getsockopt(struct socket *sock, int level, int optname,
 		val = po->auxdata;
 		break;
 	case PACKET_ORIGDEV:
-		val = po->origdev;
+		val = packet_sock_flag(po, PACKET_SOCK_ORIGDEV);
 		break;
 	case PACKET_VNET_HDR:
 		val = po->has_vnet_hdr;
diff --git a/net/packet/diag.c b/net/packet/diag.c
index 07812ae5ca073..e1ac9bb375b31 100644
--- a/net/packet/diag.c
+++ b/net/packet/diag.c
@@ -25,7 +25,7 @@ static int pdiag_put_info(const struct packet_sock *po, struct sk_buff *nlskb)
 		pinfo.pdi_flags |= PDI_RUNNING;
 	if (po->auxdata)
 		pinfo.pdi_flags |= PDI_AUXDATA;
-	if (po->origdev)
+	if (packet_sock_flag(po, PACKET_SOCK_ORIGDEV))
 		pinfo.pdi_flags |= PDI_ORIGDEV;
 	if (po->has_vnet_hdr)
 		pinfo.pdi_flags |= PDI_VNETHDR;
diff --git a/net/packet/internal.h b/net/packet/internal.h
index 48af35b1aed25..178cd1852238d 100644
--- a/net/packet/internal.h
+++ b/net/packet/internal.h
@@ -116,9 +116,9 @@ struct packet_sock {
 	int			copy_thresh;
 	spinlock_t		bind_lock;
 	struct mutex		pg_vec_lock;
+	unsigned long		flags;
 	unsigned int		running;	/* bind_lock must be held */
 	unsigned int		auxdata:1,	/* writer must hold sock lock */
-				origdev:1,
 				has_vnet_hdr:1,
 				tp_loss:1,
 				tp_tx_has_off:1;
@@ -144,4 +144,24 @@ static inline struct packet_sock *pkt_sk(struct sock *sk)
 	return (struct packet_sock *)sk;
 }
 
+enum packet_sock_flags {
+	PACKET_SOCK_ORIGDEV,
+};
+
+static inline void packet_sock_flag_set(struct packet_sock *po,
+					enum packet_sock_flags flag,
+					bool val)
+{
+	if (val)
+		set_bit(flag, &po->flags);
+	else
+		clear_bit(flag, &po->flags);
+}
+
+static inline bool packet_sock_flag(const struct packet_sock *po,
+				    enum packet_sock_flags flag)
+{
+	return test_bit(flag, &po->flags);
+}
+
 #endif
-- 
2.39.2



