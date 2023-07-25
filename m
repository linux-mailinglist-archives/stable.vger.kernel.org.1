Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8742F76138C
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234199AbjGYLL3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234127AbjGYLLO (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:11:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEB8C10F1
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:10:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 40F6F6166F
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:10:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D082C433C8;
        Tue, 25 Jul 2023 11:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690283425;
        bh=cBpYCpLaI+9OgvbFaVO0Daks6ibu6Xk2STIlbexfbko=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qTX/cpwbNJ1UOp7iY44Pq+osc3mn6F9+9ey1nXNuYF9JEQNntoF3Aufcnj/ta+T/1
         OALwLiZ2pRszmU8TxcBfjrl5KRzl4m/Opp1SxFqqn23ZvtjX08caXPogdDPGUwTI2l
         yJIcy0+No86gLUJZIW6tWFeo+FUq51bzrrTXG9C0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 72/78] tcp: annotate data-races around tp->notsent_lowat
Date:   Tue, 25 Jul 2023 12:47:03 +0200
Message-ID: <20230725104454.065898956@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104451.275227789@linuxfoundation.org>
References: <20230725104451.275227789@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 1aeb87bc1440c5447a7fa2d6e3c2cca52cbd206b ]

tp->notsent_lowat can be read locklessly from do_tcp_getsockopt()
and tcp_poll().

Fixes: c9bee3b7fdec ("tcp: TCP_NOTSENT_LOWAT socket option")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Link: https://lore.kernel.org/r/20230719212857.3943972-10-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/tcp.h | 6 +++++-
 net/ipv4/tcp.c    | 4 ++--
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index fe58b089f0b16..d8920f84f0a8d 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -2012,7 +2012,11 @@ void __tcp_v4_send_check(struct sk_buff *skb, __be32 saddr, __be32 daddr);
 static inline u32 tcp_notsent_lowat(const struct tcp_sock *tp)
 {
 	struct net *net = sock_net((struct sock *)tp);
-	return tp->notsent_lowat ?: READ_ONCE(net->ipv4.sysctl_tcp_notsent_lowat);
+	u32 val;
+
+	val = READ_ONCE(tp->notsent_lowat);
+
+	return val ?: READ_ONCE(net->ipv4.sysctl_tcp_notsent_lowat);
 }
 
 bool tcp_stream_memory_free(const struct sock *sk, int wake);
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 29661f7e372d9..95e3e32d211a7 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3669,7 +3669,7 @@ static int do_tcp_setsockopt(struct sock *sk, int level, int optname,
 		err = tcp_repair_set_window(tp, optval, optlen);
 		break;
 	case TCP_NOTSENT_LOWAT:
-		tp->notsent_lowat = val;
+		WRITE_ONCE(tp->notsent_lowat, val);
 		sk->sk_write_space(sk);
 		break;
 	case TCP_INQ:
@@ -4161,7 +4161,7 @@ static int do_tcp_getsockopt(struct sock *sk, int level,
 		val = tcp_time_stamp_raw() + tp->tsoffset;
 		break;
 	case TCP_NOTSENT_LOWAT:
-		val = tp->notsent_lowat;
+		val = READ_ONCE(tp->notsent_lowat);
 		break;
 	case TCP_INQ:
 		val = tp->recvmsg_inq;
-- 
2.39.2



