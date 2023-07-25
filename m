Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0487C761336
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234113AbjGYLI4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:08:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234114AbjGYLIm (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:08:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6A9E1FCF
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:07:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A7D9A61682
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:07:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4B66C433C9;
        Tue, 25 Jul 2023 11:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690283228;
        bh=9H8tz5In6TRmMACrNPIwdy35IEoT0yRWpVg9PDcDAh4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UFGeGZNQLFeSCo5uT0RtComRqGgpB4qwdQw6mEDsna09ZkApEKXRw1CcP6U/Rb5rA
         KN8tOjjJKFY8U2zmRiIaNWabO9DRuWcDfPo+MIBjqR1abiiEu6o04v1+WzCuv5bImx
         pOnK0vtJB3VDiZt4puFOMtoPNNNuDUUrtn/I1jIM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 159/183] tcp: annotate data-races around rskq_defer_accept
Date:   Tue, 25 Jul 2023 12:46:27 +0200
Message-ID: <20230725104513.540617439@linuxfoundation.org>
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

[ Upstream commit ae488c74422fb1dcd807c0201804b3b5e8a322a3 ]

do_tcp_getsockopt() reads rskq_defer_accept while another cpu
might change its value.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Link: https://lore.kernel.org/r/20230719212857.3943972-9-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/tcp.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 363535b6ece83..bc3ad48f92389 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3700,9 +3700,9 @@ int do_tcp_setsockopt(struct sock *sk, int level, int optname,
 
 	case TCP_DEFER_ACCEPT:
 		/* Translate value in seconds to number of retransmits */
-		icsk->icsk_accept_queue.rskq_defer_accept =
-			secs_to_retrans(val, TCP_TIMEOUT_INIT / HZ,
-					TCP_RTO_MAX / HZ);
+		WRITE_ONCE(icsk->icsk_accept_queue.rskq_defer_accept,
+			   secs_to_retrans(val, TCP_TIMEOUT_INIT / HZ,
+					   TCP_RTO_MAX / HZ));
 		break;
 
 	case TCP_WINDOW_CLAMP:
@@ -4104,8 +4104,9 @@ int do_tcp_getsockopt(struct sock *sk, int level,
 			val = (val ? : READ_ONCE(net->ipv4.sysctl_tcp_fin_timeout)) / HZ;
 		break;
 	case TCP_DEFER_ACCEPT:
-		val = retrans_to_secs(icsk->icsk_accept_queue.rskq_defer_accept,
-				      TCP_TIMEOUT_INIT / HZ, TCP_RTO_MAX / HZ);
+		val = READ_ONCE(icsk->icsk_accept_queue.rskq_defer_accept);
+		val = retrans_to_secs(val, TCP_TIMEOUT_INIT / HZ,
+				      TCP_RTO_MAX / HZ);
 		break;
 	case TCP_WINDOW_CLAMP:
 		val = tp->window_clamp;
-- 
2.39.2



