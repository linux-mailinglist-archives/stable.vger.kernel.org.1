Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6017761247
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233796AbjGYLAt (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233809AbjGYLA3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:00:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76EE749EA
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 03:57:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F1C4D61602
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 10:57:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8ECEC433C7;
        Tue, 25 Jul 2023 10:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690282664;
        bh=nixOx57yWWFbrAJPtpK5YVgblRlGyTCnfNbwt2T3BzI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C01a1wFXjUn0wTRkfbVavmUL1mqNauajxW9R0osOcEkoN9JF3Wv+3eMa7BoZG+0KF
         UmHLtc/6mREAsIuhpqAkZQjJM3goD1+Q7uSdGSXkkdwxIz/hZTR8kFbQE9IUuAgcat
         PDgGt0EVm5sI90GNTICb7BWjGH0QIblVKwLkJAGI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 210/227] tcp: annotate data-races around tp->keepalive_intvl
Date:   Tue, 25 Jul 2023 12:46:17 +0200
Message-ID: <20230725104523.465880078@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104514.821564989@linuxfoundation.org>
References: <20230725104514.821564989@linuxfoundation.org>
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
index 9a12e8c09ea04..45d50a40795da 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1514,9 +1514,14 @@ void tcp_leave_memory_pressure(struct sock *sk);
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
index c3b743093d482..514817119bd4d 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3454,7 +3454,7 @@ int tcp_sock_set_keepintvl(struct sock *sk, int val)
 		return -EINVAL;
 
 	lock_sock(sk);
-	tcp_sk(sk)->keepalive_intvl = val * HZ;
+	WRITE_ONCE(tcp_sk(sk)->keepalive_intvl, val * HZ);
 	release_sock(sk);
 	return 0;
 }
@@ -3668,7 +3668,7 @@ int do_tcp_setsockopt(struct sock *sk, int level, int optname,
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



