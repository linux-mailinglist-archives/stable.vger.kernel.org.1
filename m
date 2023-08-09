Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CE0277576E
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 12:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231890AbjHIKp5 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 06:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232113AbjHIKp4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 06:45:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19EC71FEA
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 03:45:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AEDCA63118
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 10:45:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD07FC433C8;
        Wed,  9 Aug 2023 10:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691577954;
        bh=iBTsONJIbCbB1rXQOZYOHcTQJJlvgXaJWHOyNoCLtRc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2d9/+iP3+azhGrDeCjLph9fEZUZ+fGcTCwd6IuzzxpGHUi9v52TtevaJcTYZ8bH4/
         Kj0jGY8N+BKilcz34dH73GroicoRzs/n9U2FZ9/3BDq8C/nW76Xy5laIL3rZu2zIlT
         gro3cSawQZZ5jgQvCD/1GqjZdNjXdxnoU07jfarA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 053/165] net: annotate data-races around sk->sk_max_pacing_rate
Date:   Wed,  9 Aug 2023 12:39:44 +0200
Message-ID: <20230809103644.552259900@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103642.720851262@linuxfoundation.org>
References: <20230809103642.720851262@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit ea7f45ef77b39e72244d282e47f6cb1ef4135cd2 ]

sk_getsockopt() runs locklessly. This means sk->sk_max_pacing_rate
can be read while other threads are changing its value.

Fixes: 62748f32d501 ("net: introduce SO_MAX_PACING_RATE")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/sock.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index b25511e7e8103..b87f498072251 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1428,7 +1428,8 @@ int sk_setsockopt(struct sock *sk, int level, int optname,
 			cmpxchg(&sk->sk_pacing_status,
 				SK_PACING_NONE,
 				SK_PACING_NEEDED);
-		sk->sk_max_pacing_rate = ulval;
+		/* Pairs with READ_ONCE() from sk_getsockopt() */
+		WRITE_ONCE(sk->sk_max_pacing_rate, ulval);
 		sk->sk_pacing_rate = min(sk->sk_pacing_rate, ulval);
 		break;
 		}
@@ -1855,12 +1856,14 @@ int sk_getsockopt(struct sock *sk, int level, int optname,
 #endif
 
 	case SO_MAX_PACING_RATE:
+		/* The READ_ONCE() pair with the WRITE_ONCE() in sk_setsockopt() */
 		if (sizeof(v.ulval) != sizeof(v.val) && len >= sizeof(v.ulval)) {
 			lv = sizeof(v.ulval);
-			v.ulval = sk->sk_max_pacing_rate;
+			v.ulval = READ_ONCE(sk->sk_max_pacing_rate);
 		} else {
 			/* 32bit version */
-			v.val = min_t(unsigned long, sk->sk_max_pacing_rate, ~0U);
+			v.val = min_t(unsigned long, ~0U,
+				      READ_ONCE(sk->sk_max_pacing_rate));
 		}
 		break;
 
-- 
2.40.1



