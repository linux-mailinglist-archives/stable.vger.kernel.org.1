Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA716FAB63
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233882AbjEHLMn (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233868AbjEHLMj (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:12:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEC7135552
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:12:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 62B6C62B99
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:12:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22B6BC4339B;
        Mon,  8 May 2023 11:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683544356;
        bh=0bs6IWQFhVJl9iW2Me3MZ7RXq8j2blXnYOQzkfSq9Ug=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cxGxP9hXX+hZi2ouLKJBT884Og3qiDg3BPE+sCkXVLrV/ukEgmi+E+b2PNP78z0zf
         s2tS5N1LFSz0RVXFAVWiptOqB98QamYosQoJKAT1o0I8Ir1WV/r4Shu9EPZ0M0xCO4
         DmCKyltXKpNTUSIgU5TvU2tRYcnqIALt0JaXPtX0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 353/694] net/packet: annotate accesses to po->xmit
Date:   Mon,  8 May 2023 11:43:08 +0200
Message-Id: <20230508094444.061593960@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094432.603705160@linuxfoundation.org>
References: <20230508094432.603705160@linuxfoundation.org>
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

[ Upstream commit b9d83ab8a708f23a4001d60e9d8d0b3be3d9f607 ]

po->xmit can be set from setsockopt(PACKET_QDISC_BYPASS),
while read locklessly.

Use READ_ONCE()/WRITE_ONCE() to avoid potential load/store
tearing issues.

Fixes: d346a3fae3ff ("packet: introduce PACKET_QDISC_BYPASS socket option")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/packet/af_packet.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index d4e76e2ae153e..d25dd9f63cc4f 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -307,7 +307,8 @@ static void packet_cached_dev_reset(struct packet_sock *po)
 
 static bool packet_use_direct_xmit(const struct packet_sock *po)
 {
-	return po->xmit == packet_direct_xmit;
+	/* Paired with WRITE_ONCE() in packet_setsockopt() */
+	return READ_ONCE(po->xmit) == packet_direct_xmit;
 }
 
 static u16 packet_pick_tx_queue(struct sk_buff *skb)
@@ -2867,7 +2868,8 @@ static int tpacket_snd(struct packet_sock *po, struct msghdr *msg)
 		packet_inc_pending(&po->tx_ring);
 
 		status = TP_STATUS_SEND_REQUEST;
-		err = po->xmit(skb);
+		/* Paired with WRITE_ONCE() in packet_setsockopt() */
+		err = READ_ONCE(po->xmit)(skb);
 		if (unlikely(err != 0)) {
 			if (err > 0)
 				err = net_xmit_errno(err);
@@ -3070,7 +3072,8 @@ static int packet_snd(struct socket *sock, struct msghdr *msg, size_t len)
 		virtio_net_hdr_set_proto(skb, &vnet_hdr);
 	}
 
-	err = po->xmit(skb);
+	/* Paired with WRITE_ONCE() in packet_setsockopt() */
+	err = READ_ONCE(po->xmit)(skb);
 	if (unlikely(err != 0)) {
 		if (err > 0)
 			err = net_xmit_errno(err);
@@ -4007,7 +4010,8 @@ packet_setsockopt(struct socket *sock, int level, int optname, sockptr_t optval,
 		if (copy_from_sockptr(&val, optval, sizeof(val)))
 			return -EFAULT;
 
-		po->xmit = val ? packet_direct_xmit : dev_queue_xmit;
+		/* Paired with all lockless reads of po->xmit */
+		WRITE_ONCE(po->xmit, val ? packet_direct_xmit : dev_queue_xmit);
 		return 0;
 	}
 	default:
-- 
2.39.2



