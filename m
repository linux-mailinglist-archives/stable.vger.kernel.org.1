Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1252370C96C
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235329AbjEVTsB (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235325AbjEVTsA (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:48:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F4CDA9
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:47:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E618262A96
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:47:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08B9CC433D2;
        Mon, 22 May 2023 19:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684784878;
        bh=MUZ+vTtqbwHDiI659bCJs3cVxAFoCDZgavRLSnqdh2g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IFWX0R4ShCMktQWS3smWo9hvBS5LVF30MThYEwq6HEKh3dJqB2mfzyXEPjmv3rAel
         6q0IhxPMc+2Pws7Qu/9XqeXI2/jvi7sjZc1UyLp27D+SvBx43SuxNLLTIcj0cO8jkR
         tJl7uLeTtaxnCzssipo1VYaUNqo1FuC3ZbUo2UbI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Eric Dumazet <edumazet@google.com>,
        Antoine Tenart <atenart@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 232/364] tcp: fix possible sk_priority leak in tcp_v4_send_reset()
Date:   Mon, 22 May 2023 20:08:57 +0100
Message-Id: <20230522190418.500921976@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522190412.801391872@linuxfoundation.org>
References: <20230522190412.801391872@linuxfoundation.org>
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

[ Upstream commit 1e306ec49a1f206fd2cc89a42fac6e6f592a8cc1 ]

When tcp_v4_send_reset() is called with @sk == NULL,
we do not change ctl_sk->sk_priority, which could have been
set from a prior invocation.

Change tcp_v4_send_reset() to set sk_priority and sk_mark
fields before calling ip_send_unicast_reply().

This means tcp_v4_send_reset() and tcp_v4_send_ack()
no longer have to clear ctl_sk->sk_mark after
their call to ip_send_unicast_reply().

Fixes: f6c0f5d209fa ("tcp: honor SO_PRIORITY in TIME_WAIT state")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Antoine Tenart <atenart@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/tcp_ipv4.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index b9d55277cb858..c87958f979f0a 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -829,6 +829,9 @@ static void tcp_v4_send_reset(const struct sock *sk, struct sk_buff *skb)
 				   inet_twsk(sk)->tw_priority : sk->sk_priority;
 		transmit_time = tcp_transmit_time(sk);
 		xfrm_sk_clone_policy(ctl_sk, sk);
+	} else {
+		ctl_sk->sk_mark = 0;
+		ctl_sk->sk_priority = 0;
 	}
 	ip_send_unicast_reply(ctl_sk,
 			      skb, &TCP_SKB_CB(skb)->header.h4.opt,
@@ -836,7 +839,6 @@ static void tcp_v4_send_reset(const struct sock *sk, struct sk_buff *skb)
 			      &arg, arg.iov[0].iov_len,
 			      transmit_time);
 
-	ctl_sk->sk_mark = 0;
 	xfrm_sk_free_policy(ctl_sk);
 	sock_net_set(ctl_sk, &init_net);
 	__TCP_INC_STATS(net, TCP_MIB_OUTSEGS);
@@ -935,7 +937,6 @@ static void tcp_v4_send_ack(const struct sock *sk,
 			      &arg, arg.iov[0].iov_len,
 			      transmit_time);
 
-	ctl_sk->sk_mark = 0;
 	sock_net_set(ctl_sk, &init_net);
 	__TCP_INC_STATS(net, TCP_MIB_OUTSEGS);
 	local_bh_enable();
-- 
2.39.2



