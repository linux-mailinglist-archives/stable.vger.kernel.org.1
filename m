Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9E877876EE
	for <lists+stable@lfdr.de>; Thu, 24 Aug 2023 19:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242792AbjHXRVN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 24 Aug 2023 13:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242882AbjHXRVC (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 24 Aug 2023 13:21:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D537412C
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 10:21:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6AF6067534
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 17:21:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EDC5C433C7;
        Thu, 24 Aug 2023 17:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692897659;
        bh=1RueG8yyQjw9gHr7H96fWI4U0N2vUIV4J0pO3mTjvzM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lTe5hKoMkq7J7nCsrKb6VGQvf4NcW5DKRP7YVB4pphidB9P3oWALQZ+Y2FCO0gU6i
         v93xRj49uzhMYilwq8QAKcoUnXllNc97wCyzmFCBIydOmy3xIPm2APgutlkF9esbbi
         srYvD1cxNjkgJaJxSUccqtjQx8JjoqlZ9SmGfUAU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Eric Dumazet <edumazet@google.com>,
        Jason Xing <kernelxing@tencent.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.10 117/135] net: fix the RTO timer retransmitting skb every 1ms if linear option is enabled
Date:   Thu, 24 Aug 2023 19:09:49 +0200
Message-ID: <20230824170622.352995704@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230824170617.074557800@linuxfoundation.org>
References: <20230824170617.074557800@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jason Xing <kernelxing@tencent.com>

commit e4dd0d3a2f64b8bd8029ec70f52bdbebd0644408 upstream.

In the real workload, I encountered an issue which could cause the RTO
timer to retransmit the skb per 1ms with linear option enabled. The amount
of lost-retransmitted skbs can go up to 1000+ instantly.

The root cause is that if the icsk_rto happens to be zero in the 6th round
(which is the TCP_THIN_LINEAR_RETRIES value), then it will always be zero
due to the changed calculation method in tcp_retransmit_timer() as follows:

icsk->icsk_rto = min(icsk->icsk_rto << 1, TCP_RTO_MAX);

Above line could be converted to
icsk->icsk_rto = min(0 << 1, TCP_RTO_MAX) = 0

Therefore, the timer expires so quickly without any doubt.

I read through the RFC 6298 and found that the RTO value can be rounded
up to a certain value, in Linux, say TCP_RTO_MIN as default, which is
regarded as the lower bound in this patch as suggested by Eric.

Fixes: 36e31b0af587 ("net: TCP thin linear timeouts")
Suggested-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Jason Xing <kernelxing@tencent.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/tcp_timer.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/net/ipv4/tcp_timer.c
+++ b/net/ipv4/tcp_timer.c
@@ -582,7 +582,9 @@ out_reset_timer:
 	    tcp_stream_is_thin(tp) &&
 	    icsk->icsk_retransmits <= TCP_THIN_LINEAR_RETRIES) {
 		icsk->icsk_backoff = 0;
-		icsk->icsk_rto = min(__tcp_set_rto(tp), TCP_RTO_MAX);
+		icsk->icsk_rto = clamp(__tcp_set_rto(tp),
+				       tcp_rto_min(sk),
+				       TCP_RTO_MAX);
 	} else {
 		/* Use normal (exponential) backoff */
 		icsk->icsk_rto = min(icsk->icsk_rto << 1, TCP_RTO_MAX);


