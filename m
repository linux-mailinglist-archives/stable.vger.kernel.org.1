Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0506776124A
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233583AbjGYLBD (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233527AbjGYLAk (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:00:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D7822D4E
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 03:57:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B917D61680
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 10:57:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA713C433C8;
        Tue, 25 Jul 2023 10:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690282673;
        bh=mJfq2p5ZqmyVjPNRQmQlxmn4cXTm/uV598W1kffiFYY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WGVx0CHAe4R77K+uQi7u4l/bK23xKyh4/+hG+PpNKBl89r5CAirnX0ZuEP3FMsuFH
         nL4XljEwngBzRJkyS460XRql92pbb86mdDNiWbH12WhTyYDbKLY5SycU3zZy5vtQp9
         QS1OB/GejhR/JWzCSnCArPWnY41Sx3MPseug4puU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 213/227] tcp: annotate data-races around tp->linger2
Date:   Tue, 25 Jul 2023 12:46:20 +0200
Message-ID: <20230725104523.565831972@linuxfoundation.org>
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

[ Upstream commit 9df5335ca974e688389c875546e5819778a80d59 ]

do_tcp_getsockopt() reads tp->linger2 while another cpu
might change its value.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Link: https://lore.kernel.org/r/20230719212857.3943972-8-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/tcp.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 488cf4ae75fab..0ebe775bde688 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3694,11 +3694,11 @@ int do_tcp_setsockopt(struct sock *sk, int level, int optname,
 
 	case TCP_LINGER2:
 		if (val < 0)
-			tp->linger2 = -1;
+			WRITE_ONCE(tp->linger2, -1);
 		else if (val > TCP_FIN_TIMEOUT_MAX / HZ)
-			tp->linger2 = TCP_FIN_TIMEOUT_MAX;
+			WRITE_ONCE(tp->linger2, TCP_FIN_TIMEOUT_MAX);
 		else
-			tp->linger2 = val * HZ;
+			WRITE_ONCE(tp->linger2, val * HZ);
 		break;
 
 	case TCP_DEFER_ACCEPT:
@@ -4106,7 +4106,7 @@ int do_tcp_getsockopt(struct sock *sk, int level,
 			READ_ONCE(net->ipv4.sysctl_tcp_syn_retries);
 		break;
 	case TCP_LINGER2:
-		val = tp->linger2;
+		val = READ_ONCE(tp->linger2);
 		if (val >= 0)
 			val = (val ? : READ_ONCE(net->ipv4.sysctl_tcp_fin_timeout)) / HZ;
 		break;
-- 
2.39.2



