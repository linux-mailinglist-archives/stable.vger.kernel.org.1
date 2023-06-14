Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E03A726B67
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233125AbjFGUZP (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:25:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233171AbjFGUYk (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:24:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06E4130D7
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:24:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DA0956440D
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:24:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA0EEC433D2;
        Wed,  7 Jun 2023 20:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686169447;
        bh=GIXREgkfziR8JlkUqeCsQGjKmsfgsGUdSeZ4bs8COCU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gl/p9/Jk2MwVaXeLcJsKZxstOjJTh5WkS+/84HkmEGnLh+PDtUq1LFhtu0/3aj2U1
         Mr910ggjZJs2EiAq9RuIe+gLXd8zh4aYsMI+H8259sFQWkh1pEruFabmXrAsVK2iop
         ttgdySNiQmBi00W/oFCJOURmfB1bpCy3CSGYpCsE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Eric Dumazet <edumazet@google.com>,
        fuyuanli <fuyuanli@didiglobal.com>,
        Jason Xing <kerneljasonxing@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 067/286] tcp: fix mishandling when the sack compression is deferred.
Date:   Wed,  7 Jun 2023 22:12:46 +0200
Message-ID: <20230607200925.263146294@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200922.978677727@linuxfoundation.org>
References: <20230607200922.978677727@linuxfoundation.org>
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

From: fuyuanli <fuyuanli@didiglobal.com>

[ Upstream commit 30c6f0bf9579debce27e45fac34fdc97e46acacc ]

In this patch, we mainly try to handle sending a compressed ack
correctly if it's deferred.

Here are more details in the old logic:
When sack compression is triggered in the tcp_compressed_ack_kick(),
if the sock is owned by user, it will set TCP_DELACK_TIMER_DEFERRED
and then defer to the release cb phrase. Later once user releases
the sock, tcp_delack_timer_handler() should send a ack as expected,
which, however, cannot happen due to lack of ICSK_ACK_TIMER flag.
Therefore, the receiver would not sent an ack until the sender's
retransmission timeout. It definitely increases unnecessary latency.

Fixes: 5d9f4262b7ea ("tcp: add SACK compression")
Suggested-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: fuyuanli <fuyuanli@didiglobal.com>
Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
Link: https://lore.kernel.org/netdev/20230529113804.GA20300@didi-ThinkCentre-M920t-N000/
Reviewed-by: Eric Dumazet <edumazet@google.com>
Link: https://lore.kernel.org/r/20230531080150.GA20424@didi-ThinkCentre-M920t-N000
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/tcp.h    |  1 +
 net/ipv4/tcp_input.c |  2 +-
 net/ipv4/tcp_timer.c | 16 +++++++++++++---
 3 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 76bf0a11bdc77..99c74fc300839 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -632,6 +632,7 @@ void tcp_reset(struct sock *sk, struct sk_buff *skb);
 void tcp_skb_mark_lost_uncond_verify(struct tcp_sock *tp, struct sk_buff *skb);
 void tcp_fin(struct sock *sk);
 void tcp_check_space(struct sock *sk);
+void tcp_sack_compress_send_ack(struct sock *sk);
 
 /* tcp_timer.c */
 void tcp_init_xmit_timers(struct sock *);
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 10776c54ff784..dee174c40e874 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -4530,7 +4530,7 @@ static void tcp_sack_maybe_coalesce(struct tcp_sock *tp)
 	}
 }
 
-static void tcp_sack_compress_send_ack(struct sock *sk)
+void tcp_sack_compress_send_ack(struct sock *sk)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
 
diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
index cb79127f45c34..0b5d0a2867a8c 100644
--- a/net/ipv4/tcp_timer.c
+++ b/net/ipv4/tcp_timer.c
@@ -290,9 +290,19 @@ static int tcp_write_timeout(struct sock *sk)
 void tcp_delack_timer_handler(struct sock *sk)
 {
 	struct inet_connection_sock *icsk = inet_csk(sk);
+	struct tcp_sock *tp = tcp_sk(sk);
 
-	if (((1 << sk->sk_state) & (TCPF_CLOSE | TCPF_LISTEN)) ||
-	    !(icsk->icsk_ack.pending & ICSK_ACK_TIMER))
+	if ((1 << sk->sk_state) & (TCPF_CLOSE | TCPF_LISTEN))
+		return;
+
+	/* Handling the sack compression case */
+	if (tp->compressed_ack) {
+		tcp_mstamp_refresh(tp);
+		tcp_sack_compress_send_ack(sk);
+		return;
+	}
+
+	if (!(icsk->icsk_ack.pending & ICSK_ACK_TIMER))
 		return;
 
 	if (time_after(icsk->icsk_ack.timeout, jiffies)) {
@@ -312,7 +322,7 @@ void tcp_delack_timer_handler(struct sock *sk)
 			inet_csk_exit_pingpong_mode(sk);
 			icsk->icsk_ack.ato      = TCP_ATO_MIN;
 		}
-		tcp_mstamp_refresh(tcp_sk(sk));
+		tcp_mstamp_refresh(tp);
 		tcp_send_ack(sk);
 		__NET_INC_STATS(sock_net(sk), LINUX_MIB_DELAYEDACKS);
 	}
-- 
2.39.2



