Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5413176133F
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234063AbjGYLJE (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:09:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234047AbjGYLIt (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:08:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E139212B
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:07:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2A4FE6166E
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:07:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39785C433C8;
        Tue, 25 Jul 2023 11:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690283247;
        bh=CFOA766HsT/aL7tCzLKgx7YVm1zzdnfNA+sVuARSn9o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ez7HZJ3yOMy/kwzwq3p7vIRUmxMdzLa3Uv8ljn5kmxgbaOLAF7jc4WMQ4xtvLklpM
         cpiZEhT/Cj5wEzDu8f2rMDSFKp99RjocctJbfZOoeDz1dehGXYKiT1X+6RCvSXvr11
         CmqXKTd52b3x0SHKjNmzFV/jFSYXklIv7K/St8kM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 156/183] tcp: annotate data-races around tp->keepalive_probes
Date:   Tue, 25 Jul 2023 12:46:24 +0200
Message-ID: <20230725104513.451284456@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104507.756981058@linuxfoundation.org>
References: <20230725104507.756981058@linuxfoundation.org>
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

[ Upstream commit 6e5e1de616bf5f3df1769abc9292191dfad9110a ]

do_tcp_getsockopt() reads tp->keepalive_probes while another cpu
might change its value.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Link: https://lore.kernel.org/r/20230719212857.3943972-6-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/tcp.h | 9 +++++++--
 net/ipv4/tcp.c    | 5 +++--
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index f39c44cbdfe62..9733d8e4f10af 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1535,9 +1535,14 @@ static inline int keepalive_time_when(const struct tcp_sock *tp)
 static inline int keepalive_probes(const struct tcp_sock *tp)
 {
 	struct net *net = sock_net((struct sock *)tp);
+	int val;
+
+	/* Paired with WRITE_ONCE() in tcp_sock_set_keepcnt()
+	 * and do_tcp_setsockopt().
+	 */
+	val = READ_ONCE(tp->keepalive_probes);
 
-	return tp->keepalive_probes ? :
-		READ_ONCE(net->ipv4.sysctl_tcp_keepalive_probes);
+	return val ? : READ_ONCE(net->ipv4.sysctl_tcp_keepalive_probes);
 }
 
 static inline u32 keepalive_time_elapsed(const struct tcp_sock *tp)
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index d19cfeb78392d..7d75928ea0f9c 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3463,7 +3463,8 @@ int tcp_sock_set_keepcnt(struct sock *sk, int val)
 		return -EINVAL;
 
 	lock_sock(sk);
-	tcp_sk(sk)->keepalive_probes = val;
+	/* Paired with READ_ONCE() in keepalive_probes() */
+	WRITE_ONCE(tcp_sk(sk)->keepalive_probes, val);
 	release_sock(sk);
 	return 0;
 }
@@ -3671,7 +3672,7 @@ int do_tcp_setsockopt(struct sock *sk, int level, int optname,
 		if (val < 1 || val > MAX_TCP_KEEPCNT)
 			err = -EINVAL;
 		else
-			tp->keepalive_probes = val;
+			WRITE_ONCE(tp->keepalive_probes, val);
 		break;
 	case TCP_SYNCNT:
 		if (val < 1 || val > MAX_TCP_SYNCNT)
-- 
2.39.2



