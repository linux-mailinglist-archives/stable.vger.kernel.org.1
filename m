Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6897615D9
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234687AbjGYLdr (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234673AbjGYLdq (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:33:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD18B19F
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:33:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6B414615BA
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:33:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B49CC433C8;
        Tue, 25 Jul 2023 11:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690284824;
        bh=5VFXx3C39PMQMlHae/LjuHkr4497WP2EMMz6y0oEslg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZlS9yVG9sUbfpwLnwCzJtXv2LrtsN65DUsYKpsoD1KM4VuGRrqOgcZiuaJSDNhLUw
         oXG2FGGOj4HxcyoCRu23gzXo+jAu+Q6DP6FtyBevTSEtHm3ZYfl9YSpEckHwtFAd/J
         cvdXEGzJWbHjs2oqmba1EZZNjk+SPNljQ6HZbWAs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 494/509] tcp: annotate data-races around tp->keepalive_time
Date:   Tue, 25 Jul 2023 12:47:13 +0200
Message-ID: <20230725104616.375044127@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104553.588743331@linuxfoundation.org>
References: <20230725104553.588743331@linuxfoundation.org>
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

[ Upstream commit 4164245c76ff906c9086758e1c3f87082a7f5ef5 ]

do_tcp_getsockopt() reads tp->keepalive_time while another cpu
might change its value.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Link: https://lore.kernel.org/r/20230719212857.3943972-4-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/tcp.h | 7 +++++--
 net/ipv4/tcp.c    | 3 ++-
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index e231101e5001b..92de7c049f19e 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1459,9 +1459,12 @@ static inline int keepalive_intvl_when(const struct tcp_sock *tp)
 static inline int keepalive_time_when(const struct tcp_sock *tp)
 {
 	struct net *net = sock_net((struct sock *)tp);
+	int val;
 
-	return tp->keepalive_time ? :
-		READ_ONCE(net->ipv4.sysctl_tcp_keepalive_time);
+	/* Paired with WRITE_ONCE() in tcp_sock_set_keepidle_locked() */
+	val = READ_ONCE(tp->keepalive_time);
+
+	return val ? : READ_ONCE(net->ipv4.sysctl_tcp_keepalive_time);
 }
 
 static inline int keepalive_probes(const struct tcp_sock *tp)
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 39919d1436cea..053e4880d8f0f 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3093,7 +3093,8 @@ int tcp_sock_set_keepidle_locked(struct sock *sk, int val)
 	if (val < 1 || val > MAX_TCP_KEEPIDLE)
 		return -EINVAL;
 
-	tp->keepalive_time = val * HZ;
+	/* Paired with WRITE_ONCE() in keepalive_time_when() */
+	WRITE_ONCE(tp->keepalive_time, val * HZ);
 	if (sock_flag(sk, SOCK_KEEPOPEN) &&
 	    !((1 << sk->sk_state) & (TCPF_CLOSE | TCPF_LISTEN))) {
 		u32 elapsed = keepalive_time_elapsed(tp);
-- 
2.39.2



