Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 556CE7033BF
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 18:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242225AbjEOQk4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 12:40:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242857AbjEOQkz (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 12:40:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DBBD40DD
        for <stable@vger.kernel.org>; Mon, 15 May 2023 09:40:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CDAF362883
        for <stable@vger.kernel.org>; Mon, 15 May 2023 16:40:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9147C433D2;
        Mon, 15 May 2023 16:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684168853;
        bh=bY4N8iuughYAGdVD9UlDnk+nM6pcGWWyezXAyxQ4+6Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=00mUlkOJUXZhv47aK83RDXy0YB3ubXL/u4IZLOCNJ1PASBLkrvJDJfyEcv5ytNjEx
         sU+OrrwgYOESFMq5lKz9/QDlIFUPpgeFuJ6tvJ0PSsEFiHQ2NNcT8WUAyaP3zchR/z
         ln+ctGpndRywqKcmp0LDEAMQqB8vVTgijYzun8Ps=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Eric Dumazet <edumazet@google.com>,
        syzbot <syzkaller@googlegroups.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 055/191] net/packet: convert po->origdev to an atomic flag
Date:   Mon, 15 May 2023 18:24:52 +0200
Message-Id: <20230515161709.217902521@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161707.203549282@linuxfoundation.org>
References: <20230515161707.203549282@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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
index 6fa0a9a453a8b..91c35d45e43ca 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -2105,7 +2105,7 @@ static int packet_rcv(struct sk_buff *skb, struct net_device *dev,
 	sll = &PACKET_SKB_CB(skb)->sa.ll;
 	sll->sll_hatype = dev->type;
 	sll->sll_pkttype = skb->pkt_type;
-	if (unlikely(po->origdev))
+	if (unlikely(packet_sock_flag(po, PACKET_SOCK_ORIGDEV)))
 		sll->sll_ifindex = orig_dev->ifindex;
 	else
 		sll->sll_ifindex = dev->ifindex;
@@ -2371,7 +2371,7 @@ static int tpacket_rcv(struct sk_buff *skb, struct net_device *dev,
 	sll->sll_hatype = dev->type;
 	sll->sll_protocol = skb->protocol;
 	sll->sll_pkttype = skb->pkt_type;
-	if (unlikely(po->origdev))
+	if (unlikely(packet_sock_flag(po, PACKET_SOCK_ORIGDEV)))
 		sll->sll_ifindex = orig_dev->ifindex;
 	else
 		sll->sll_ifindex = dev->ifindex;
@@ -3841,9 +3841,7 @@ packet_setsockopt(struct socket *sock, int level, int optname, char __user *optv
 		if (copy_from_user(&val, optval, sizeof(val)))
 			return -EFAULT;
 
-		lock_sock(sk);
-		po->origdev = !!val;
-		release_sock(sk);
+		packet_sock_flag_set(po, PACKET_SOCK_ORIGDEV, val);
 		return 0;
 	}
 	case PACKET_VNET_HDR:
@@ -3976,7 +3974,7 @@ static int packet_getsockopt(struct socket *sock, int level, int optname,
 		val = po->auxdata;
 		break;
 	case PACKET_ORIGDEV:
-		val = po->origdev;
+		val = packet_sock_flag(po, PACKET_SOCK_ORIGDEV);
 		break;
 	case PACKET_VNET_HDR:
 		val = po->has_vnet_hdr;
diff --git a/net/packet/diag.c b/net/packet/diag.c
index 7ef1c881ae741..bf5928e5df035 100644
--- a/net/packet/diag.c
+++ b/net/packet/diag.c
@@ -24,7 +24,7 @@ static int pdiag_put_info(const struct packet_sock *po, struct sk_buff *nlskb)
 		pinfo.pdi_flags |= PDI_RUNNING;
 	if (po->auxdata)
 		pinfo.pdi_flags |= PDI_AUXDATA;
-	if (po->origdev)
+	if (packet_sock_flag(po, PACKET_SOCK_ORIGDEV))
 		pinfo.pdi_flags |= PDI_ORIGDEV;
 	if (po->has_vnet_hdr)
 		pinfo.pdi_flags |= PDI_VNETHDR;
diff --git a/net/packet/internal.h b/net/packet/internal.h
index f10294800aafb..f39dcc7608bc6 100644
--- a/net/packet/internal.h
+++ b/net/packet/internal.h
@@ -115,9 +115,9 @@ struct packet_sock {
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
@@ -142,4 +142,24 @@ static struct packet_sock *pkt_sk(struct sock *sk)
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



