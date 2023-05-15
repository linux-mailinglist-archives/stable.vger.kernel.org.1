Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC00C703492
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 18:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243037AbjEOQuF (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 12:50:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243027AbjEOQtk (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 12:49:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 509FA4EE1
        for <stable@vger.kernel.org>; Mon, 15 May 2023 09:49:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D868462959
        for <stable@vger.kernel.org>; Mon, 15 May 2023 16:49:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E757EC433D2;
        Mon, 15 May 2023 16:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684169378;
        bh=xo/KuokBHLuydNpRif2y/UPXWTX7lRC6L2jK3ocdSac=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=amCNwot8f+qhxaZOkABuHpfHRrXkazscIrcuQOAn8GFSKP+fWUUVLGCiLr++OXyJB
         xD/iF+q45A4XtB3oxWLMo2SG2lR2tqagu5bQgxqegU+ZJsoOhfFxD0b48q2vjjzBWQ
         78KsLjpFPpsaTA/pMVihZshlU/JhMAHNDfP1Cf9M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Antoine Tenart <atenart@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 039/246] net: ipv6: fix skb hash for some RST packets
Date:   Mon, 15 May 2023 18:24:11 +0200
Message-Id: <20230515161723.768696125@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161722.610123835@linuxfoundation.org>
References: <20230515161722.610123835@linuxfoundation.org>
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

From: Antoine Tenart <atenart@kernel.org>

[ Upstream commit dc6456e938e938d64ffb6383a286b2ac9790a37f ]

The skb hash comes from sk->sk_txhash when using TCP, except for some
IPv6 RST packets. This is because in tcp_v6_send_reset when not in
TIME_WAIT the hash is taken from sk->sk_hash, while it should come from
sk->sk_txhash as those two hashes are not computed the same way.

Packetdrill script to test the above,

   0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
  +0 fcntl(3, F_SETFL, O_RDWR|O_NONBLOCK) = 0
  +0 connect(3, ..., ...) = -1 EINPROGRESS (Operation now in progress)

  +0 > (flowlabel 0x1) S 0:0(0) <...>

  // Wrong ack seq, trigger a rst.
  +0 < S. 0:0(0) ack 0 win 4000

  // Check the flowlabel matches prior one from SYN.
  +0 > (flowlabel 0x1) R 0:0(0) <...>

Fixes: 9258b8b1be2e ("ipv6: tcp: send consistent autoflowlabel in RST packets")
Signed-off-by: Antoine Tenart <atenart@kernel.org>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv6/tcp_ipv6.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 1e747241c7710..4d52e25deb9e3 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1064,7 +1064,7 @@ static void tcp_v6_send_reset(const struct sock *sk, struct sk_buff *skb)
 			if (np->repflow)
 				label = ip6_flowlabel(ipv6h);
 			priority = sk->sk_priority;
-			txhash = sk->sk_hash;
+			txhash = sk->sk_txhash;
 		}
 		if (sk->sk_state == TCP_TIME_WAIT) {
 			label = cpu_to_be32(inet_twsk(sk)->tw_flowlabel);
-- 
2.39.2



