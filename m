Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5466D7E24B8
	for <lists+stable@lfdr.de>; Mon,  6 Nov 2023 14:24:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231886AbjKFNYd (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 6 Nov 2023 08:24:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232448AbjKFNYc (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 6 Nov 2023 08:24:32 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B9F3F3
        for <stable@vger.kernel.org>; Mon,  6 Nov 2023 05:24:29 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF65EC433C7;
        Mon,  6 Nov 2023 13:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699277069;
        bh=7h6c470TrNzm/Rvpp93aPVaN760bVjhOko6uRGHROfU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AT9A7crW7hGU1XzM/JMDtd+LoMqK4EQIVs9q69FzGyt0cH7FLvv8U8H3iZkcfMki0
         41ruZJ+BvBnmwjR6VUZL5mplb7ULOkprJUP4RbKYU3L0msW+ax0uxyk7ofMyYMpw8K
         A3DqdrJJDYAEo3f8x8YCNeBhZIjlwZ+1NJuSN67g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 004/128] tcp: remove dead code from tcp_sendmsg_locked()
Date:   Mon,  6 Nov 2023 14:02:44 +0100
Message-ID: <20231106130309.319444675@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231106130309.112650042@linuxfoundation.org>
References: <20231106130309.112650042@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 3ded97bc41a1e76e1e72eeb192331c01ceacc4bc ]

TCP sendmsg() no longer puts payload in skb head, we can remove
dead code.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: 72377ab2d671 ("mptcp: more conservative check for zero probes")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/tcp.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index a91cf000bb61b..2115a0e5c98f7 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1330,14 +1330,7 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
 		if (copy > msg_data_left(msg))
 			copy = msg_data_left(msg);
 
-		/* Where to copy to? */
-		if (skb_availroom(skb) > 0 && !zc) {
-			/* We have some space in skb head. Superb! */
-			copy = min_t(int, copy, skb_availroom(skb));
-			err = skb_add_data_nocache(sk, skb, &msg->msg_iter, copy);
-			if (err)
-				goto do_fault;
-		} else if (!zc) {
+		if (!zc) {
 			bool merge = true;
 			int i = skb_shinfo(skb)->nr_frags;
 			struct page_frag *pfrag = sk_page_frag(sk);
@@ -1437,7 +1430,6 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
 
 do_error:
 	skb = tcp_write_queue_tail(sk);
-do_fault:
 	tcp_remove_empty_skb(sk, skb);
 
 	if (copied + copied_syn)
-- 
2.42.0



