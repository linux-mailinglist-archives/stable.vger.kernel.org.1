Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED75E75541C
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231996AbjGPU06 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:26:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232011AbjGPU0y (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:26:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F96310DC
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:26:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EAA6660EBF
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:26:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01635C433C7;
        Sun, 16 Jul 2023 20:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689539201;
        bh=mgDHGDdnZAuD9jNCP8yeJNFuskfACD3EkPOl7zGC0zM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Yntt+XwSNsUB1XLAv78cS7IYT2NU13X6/Pv9hQy+tuD29E1aV83tq36itfVcWyMeX
         W9EvAf4zMrVK9cCUF2BqZqukTYYnElXn4Y3EooaP5HsbH1CWf8jwHNvNv0ATpQI4b8
         W7u6x8oflLlKAl6iMggaWTK4B+09562IE9qniw3c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 694/800] tcp: annotate data races in __tcp_oow_rate_limited()
Date:   Sun, 16 Jul 2023 21:49:07 +0200
Message-ID: <20230716195005.242344723@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 998127cdb4699b9d470a9348ffe9f1154346be5f ]

request sockets are lockless, __tcp_oow_rate_limited() could be called
on the same object from different cpus. This is harmless.

Add READ_ONCE()/WRITE_ONCE() annotations to avoid a KCSAN report.

Fixes: 4ce7e93cb3fe ("tcp: rate limit ACK sent by SYN_RECV request sockets")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/tcp_input.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index bf8b22218dd46..57f1e4883b761 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -3590,8 +3590,11 @@ static int tcp_ack_update_window(struct sock *sk, const struct sk_buff *skb, u32
 static bool __tcp_oow_rate_limited(struct net *net, int mib_idx,
 				   u32 *last_oow_ack_time)
 {
-	if (*last_oow_ack_time) {
-		s32 elapsed = (s32)(tcp_jiffies32 - *last_oow_ack_time);
+	/* Paired with the WRITE_ONCE() in this function. */
+	u32 val = READ_ONCE(*last_oow_ack_time);
+
+	if (val) {
+		s32 elapsed = (s32)(tcp_jiffies32 - val);
 
 		if (0 <= elapsed &&
 		    elapsed < READ_ONCE(net->ipv4.sysctl_tcp_invalid_ratelimit)) {
@@ -3600,7 +3603,10 @@ static bool __tcp_oow_rate_limited(struct net *net, int mib_idx,
 		}
 	}
 
-	*last_oow_ack_time = tcp_jiffies32;
+	/* Paired with the prior READ_ONCE() and with itself,
+	 * as we might be lockless.
+	 */
+	WRITE_ONCE(*last_oow_ack_time, tcp_jiffies32);
 
 	return false;	/* not rate-limited: go ahead, send dupack now! */
 }
-- 
2.39.2



