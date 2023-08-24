Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E9ED7872CD
	for <lists+stable@lfdr.de>; Thu, 24 Aug 2023 16:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241576AbjHXO5R (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 24 Aug 2023 10:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241924AbjHXO4v (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 24 Aug 2023 10:56:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F73919B3
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 07:56:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E22A866FB9
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 14:56:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0066AC433C7;
        Thu, 24 Aug 2023 14:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692889006;
        bh=HfA+FoqkoIaPuYwDtWcVV3Ra6n4i8UD45yGp329fl5A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kPop4VFvKysZfF2nRLxlr4Oq29BRBvIcuAWxkAEobsCW/xE1dwVU8KRYXtHXZuVWd
         oY42k+t6as3hC8kGJoX6rGoW8LvYlPn3pohONSTjcndmnnLLmj7W4YU2Red7ffGxYX
         PvJpTB8zpywDRA026RyWt06mh452UOT0EC8c/vm8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Eric Dumazet <edumazet@google.com>,
        Jason Xing <kernelxing@tencent.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.15 121/139] net: fix the RTO timer retransmitting skb every 1ms if linear option is enabled
Date:   Thu, 24 Aug 2023 16:50:44 +0200
Message-ID: <20230824145028.759343994@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230824145023.559380953@linuxfoundation.org>
References: <20230824145023.559380953@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

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


