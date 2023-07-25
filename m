Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A09AE7615EB
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234699AbjGYLeh (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234701AbjGYLeg (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:34:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A592F118
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:34:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 43B326169A
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:34:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CDA9C433C7;
        Tue, 25 Jul 2023 11:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690284874;
        bh=qWXsThcD0VJTXdv/kjr3ZKnio9ekAttLz2ER9RPPpLY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yR8CvFaveBYIW/3C6uZPveRpZ8VHJ3zH33m2Oei4HywWeuPchMaV5XmoDT1BRT8+9
         Z8as27m8P4SMef4nMpTEUQdVrpNHIaG2tfDfFQBmWUfYKBzSQvd1EwZTIuXyLfOfg1
         inaTPdQy3+6ApOSpPrtNocqxwCTfPGQKEv36JVv4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 503/509] tcp: annotate data-races around icsk->icsk_user_timeout
Date:   Tue, 25 Jul 2023 12:47:22 +0200
Message-ID: <20230725104616.765559403@linuxfoundation.org>
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

[ Upstream commit 26023e91e12c68669db416b97234328a03d8e499 ]

This field can be read locklessly from do_tcp_getsockopt()

Fixes: dca43c75e7e5 ("tcp: Add TCP_USER_TIMEOUT socket option.")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Link: https://lore.kernel.org/r/20230719212857.3943972-11-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/tcp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 8a441dfd258d5..0a5f61b3423bf 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3081,7 +3081,7 @@ EXPORT_SYMBOL(tcp_sock_set_syncnt);
 void tcp_sock_set_user_timeout(struct sock *sk, u32 val)
 {
 	lock_sock(sk);
-	inet_csk(sk)->icsk_user_timeout = val;
+	WRITE_ONCE(inet_csk(sk)->icsk_user_timeout, val);
 	release_sock(sk);
 }
 EXPORT_SYMBOL(tcp_sock_set_user_timeout);
@@ -3393,7 +3393,7 @@ static int do_tcp_setsockopt(struct sock *sk, int level, int optname,
 		if (val < 0)
 			err = -EINVAL;
 		else
-			icsk->icsk_user_timeout = val;
+			WRITE_ONCE(icsk->icsk_user_timeout, val);
 		break;
 
 	case TCP_FASTOPEN:
@@ -3890,7 +3890,7 @@ static int do_tcp_getsockopt(struct sock *sk, int level,
 		break;
 
 	case TCP_USER_TIMEOUT:
-		val = icsk->icsk_user_timeout;
+		val = READ_ONCE(icsk->icsk_user_timeout);
 		break;
 
 	case TCP_FASTOPEN:
-- 
2.39.2



