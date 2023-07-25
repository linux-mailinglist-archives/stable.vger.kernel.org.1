Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 952D1761389
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234105AbjGYLLX (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234106AbjGYLLI (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:11:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15D0519AA
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:10:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9F64E61656
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:10:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1DE2C433C7;
        Tue, 25 Jul 2023 11:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690283417;
        bh=+6aTzBbfZvzgvnTZ/zjebS3a3ELsuymSrxzF/L+okDs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1Vbbsv/7bSG/DWGoP/MUfd4qWUA5WzSYkWJG78+EUJUAJuvTOPW+Ky9ZkggQDr1Za
         i0KWExGN8SDNqtmf94P7Icqd23cjZ8zIW/FKjIuVM32Ltk1fNz8ShsSL4lzZzPqjVh
         h/KaDBR//cZOEvIMGk+zunVatwe278ZX449EKq3E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 69/78] tcp: annotate data-races around icsk->icsk_syn_retries
Date:   Tue, 25 Jul 2023 12:47:00 +0200
Message-ID: <20230725104453.951944352@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104451.275227789@linuxfoundation.org>
References: <20230725104451.275227789@linuxfoundation.org>
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

[ Upstream commit 3a037f0f3c4bfe44518f2fbb478aa2f99a9cd8bb ]

do_tcp_getsockopt() and reqsk_timer_handler() read
icsk->icsk_syn_retries while another cpu might change its value.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Link: https://lore.kernel.org/r/20230719212857.3943972-7-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/inet_connection_sock.c | 2 +-
 net/ipv4/tcp.c                  | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index 4fb0506430774..c770719797e12 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -833,7 +833,7 @@ static void reqsk_timer_handler(struct timer_list *t)
 
 	icsk = inet_csk(sk_listener);
 	net = sock_net(sk_listener);
-	max_syn_ack_retries = icsk->icsk_syn_retries ? :
+	max_syn_ack_retries = READ_ONCE(icsk->icsk_syn_retries) ? :
 		READ_ONCE(net->ipv4.sysctl_tcp_synack_retries);
 	/* Normally all the openreqs are young and become mature
 	 * (i.e. converted to established socket) for first timeout.
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 994ac3cd50e1d..4077b456e3838 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3296,7 +3296,7 @@ int tcp_sock_set_syncnt(struct sock *sk, int val)
 		return -EINVAL;
 
 	lock_sock(sk);
-	inet_csk(sk)->icsk_syn_retries = val;
+	WRITE_ONCE(inet_csk(sk)->icsk_syn_retries, val);
 	release_sock(sk);
 	return 0;
 }
@@ -3577,7 +3577,7 @@ static int do_tcp_setsockopt(struct sock *sk, int level, int optname,
 		if (val < 1 || val > MAX_TCP_SYNCNT)
 			err = -EINVAL;
 		else
-			icsk->icsk_syn_retries = val;
+			WRITE_ONCE(icsk->icsk_syn_retries, val);
 		break;
 
 	case TCP_SAVE_SYN:
@@ -3991,7 +3991,7 @@ static int do_tcp_getsockopt(struct sock *sk, int level,
 		val = keepalive_probes(tp);
 		break;
 	case TCP_SYNCNT:
-		val = icsk->icsk_syn_retries ? :
+		val = READ_ONCE(icsk->icsk_syn_retries) ? :
 			READ_ONCE(net->ipv4.sysctl_tcp_syn_retries);
 		break;
 	case TCP_LINGER2:
-- 
2.39.2



