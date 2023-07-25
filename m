Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E930476124C
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:01:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233825AbjGYLBH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:01:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233773AbjGYLAq (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:00:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6012E199F
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 03:57:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 41BC161648
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 10:57:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54E33C433C7;
        Tue, 25 Jul 2023 10:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690282678;
        bh=UZGv7RaLH4qEjuQnsE8uapcirkI+a4Ia9JxL/SQjlm4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jjLyeCBRyqZnZsPkefnnZW+eI7dZLnX+lhck+BbE/XH2uPVdsvAYB0OH+TKLEtJcR
         ll1GsbkZM7XecpuiunOH8kXYdn+OgWsHJAXhEMWySJJpsbQejBhPcY+U8fsP4qEsty
         jXQPIjbt03LBrhqrupJYLyAJPUqQvG4nudFkvaxo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 215/227] tcp: annotate data-races around tp->notsent_lowat
Date:   Tue, 25 Jul 2023 12:46:22 +0200
Message-ID: <20230725104523.643358376@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104514.821564989@linuxfoundation.org>
References: <20230725104514.821564989@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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
index f5c20afab6286..182337a8cf94a 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -2066,7 +2066,11 @@ void __tcp_v4_send_check(struct sk_buff *skb, __be32 saddr, __be32 daddr);
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
index c95d8b43390b6..4556ba6e7d74d 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3773,7 +3773,7 @@ int do_tcp_setsockopt(struct sock *sk, int level, int optname,
 		err = tcp_repair_set_window(tp, optval, optlen);
 		break;
 	case TCP_NOTSENT_LOWAT:
-		tp->notsent_lowat = val;
+		WRITE_ONCE(tp->notsent_lowat, val);
 		sk->sk_write_space(sk);
 		break;
 	case TCP_INQ:
@@ -4273,7 +4273,7 @@ int do_tcp_getsockopt(struct sock *sk, int level,
 		val = tcp_time_stamp_raw() + READ_ONCE(tp->tsoffset);
 		break;
 	case TCP_NOTSENT_LOWAT:
-		val = tp->notsent_lowat;
+		val = READ_ONCE(tp->notsent_lowat);
 		break;
 	case TCP_INQ:
 		val = tp->recvmsg_inq;
-- 
2.39.2



