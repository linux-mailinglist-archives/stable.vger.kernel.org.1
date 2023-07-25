Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9B37615DD
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:34:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234690AbjGYLdu (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234678AbjGYLdt (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:33:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99FCF11B
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:33:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 26AFB61683
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:33:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38227C433C9;
        Tue, 25 Jul 2023 11:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690284827;
        bh=W1T4xNzQjq+//7YpZzt1ubp5OTfzs7CTPWouUfPz5us=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nRhU1jPibKPyhL0uZFocB69EfVvGQzJsIvwYnR9Ha2DRLFr1kK11DRSPWqcfZGuAO
         6DNmTSuQdcyv/BCn0MDWhkH/b2UQSGfLdVILbVLLvZYsaQdeGT0MNrSxixfRXVVI3+
         z2Dke5wNmDeXfBJwC8W0Yhm2PN8XLvDew+2N2iC0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 495/509] tcp: annotate data-races around tp->keepalive_intvl
Date:   Tue, 25 Jul 2023 12:47:14 +0200
Message-ID: <20230725104616.421846207@linuxfoundation.org>
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

[ Upstream commit 5ecf9d4f52ff2f1d4d44c9b68bc75688e82f13b4 ]

do_tcp_getsockopt() reads tp->keepalive_intvl while another cpu
might change its value.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Link: https://lore.kernel.org/r/20230719212857.3943972-5-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/tcp.h | 9 +++++++--
 net/ipv4/tcp.c    | 4 ++--
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 92de7c049f19e..428f84f6e0d0c 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1451,9 +1451,14 @@ void tcp_leave_memory_pressure(struct sock *sk);
 static inline int keepalive_intvl_when(const struct tcp_sock *tp)
 {
 	struct net *net = sock_net((struct sock *)tp);
+	int val;
+
+	/* Paired with WRITE_ONCE() in tcp_sock_set_keepintvl()
+	 * and do_tcp_setsockopt().
+	 */
+	val = READ_ONCE(tp->keepalive_intvl);
 
-	return tp->keepalive_intvl ? :
-		READ_ONCE(net->ipv4.sysctl_tcp_keepalive_intvl);
+	return val ? : READ_ONCE(net->ipv4.sysctl_tcp_keepalive_intvl);
 }
 
 static inline int keepalive_time_when(const struct tcp_sock *tp)
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 053e4880d8f0f..b5a05b0984146 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3126,7 +3126,7 @@ int tcp_sock_set_keepintvl(struct sock *sk, int val)
 		return -EINVAL;
 
 	lock_sock(sk);
-	tcp_sk(sk)->keepalive_intvl = val * HZ;
+	WRITE_ONCE(tcp_sk(sk)->keepalive_intvl, val * HZ);
 	release_sock(sk);
 	return 0;
 }
@@ -3324,7 +3324,7 @@ static int do_tcp_setsockopt(struct sock *sk, int level, int optname,
 		if (val < 1 || val > MAX_TCP_KEEPINTVL)
 			err = -EINVAL;
 		else
-			tp->keepalive_intvl = val * HZ;
+			WRITE_ONCE(tp->keepalive_intvl, val * HZ);
 		break;
 	case TCP_KEEPCNT:
 		if (val < 1 || val > MAX_TCP_KEEPCNT)
-- 
2.39.2



