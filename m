Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59AC57BDEA9
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376371AbjJINVm (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376364AbjJINVl (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:21:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8F9491
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:21:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 240A2C433C8;
        Mon,  9 Oct 2023 13:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696857697;
        bh=jpgwpmeZxuwBK0VkAiGr+32yknC5SHsJ8IrH+xthYhg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ir1Ny5looLKtWAy7wmDSHnnajwzeGPZgw1ccqBPZhSm2JZFsyLz5RHandTyp23KM4
         5CsE1y+qDtnuuWU5xnjaVIvIgL+mDaIDDDCPWoc60MEZS2EKiqMvZO65guCb7u1XKj
         gBn9T6GkQyg8B0EvXIumQa+2VlAp94vhq9lS/69Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Neal Cardwell <ncardwell@google.com>,
        Yuchung Cheng <ycheng@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 127/162] tcp: fix quick-ack counting to count actual ACKs of new data
Date:   Mon,  9 Oct 2023 15:01:48 +0200
Message-ID: <20231009130126.427598936@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130122.946357448@linuxfoundation.org>
References: <20231009130122.946357448@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Neal Cardwell <ncardwell@google.com>

[ Upstream commit 059217c18be6757b95bfd77ba53fb50b48b8a816 ]

This commit fixes quick-ack counting so that it only considers that a
quick-ack has been provided if we are sending an ACK that newly
acknowledges data.

The code was erroneously using the number of data segments in outgoing
skbs when deciding how many quick-ack credits to remove. This logic
does not make sense, and could cause poor performance in
request-response workloads, like RPC traffic, where requests or
responses can be multi-segment skbs.

When a TCP connection decides to send N quick-acks, that is to
accelerate the cwnd growth of the congestion control module
controlling the remote endpoint of the TCP connection. That quick-ack
decision is purely about the incoming data and outgoing ACKs. It has
nothing to do with the outgoing data or the size of outgoing data.

And in particular, an ACK only serves the intended purpose of allowing
the remote congestion control to grow the congestion window quickly if
the ACK is ACKing or SACKing new data.

The fix is simple: only count packets as serving the goal of the
quickack mechanism if they are ACKing/SACKing new data. We can tell
whether this is the case by checking inet_csk_ack_scheduled(), since
we schedule an ACK exactly when we are ACKing/SACKing new data.

Fixes: fc6415bcb0f5 ("[TCP]: Fix quick-ack decrementing with TSO.")
Signed-off-by: Neal Cardwell <ncardwell@google.com>
Reviewed-by: Yuchung Cheng <ycheng@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Link: https://lore.kernel.org/r/20231001151239.1866845-1-ncardwell.sw@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/tcp.h     | 6 ++++--
 net/ipv4/tcp_output.c | 7 +++----
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 5fd69f2342a44..9ebb54122bb71 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -355,12 +355,14 @@ ssize_t tcp_splice_read(struct socket *sk, loff_t *ppos,
 struct sk_buff *tcp_stream_alloc_skb(struct sock *sk, int size, gfp_t gfp,
 				     bool force_schedule);
 
-static inline void tcp_dec_quickack_mode(struct sock *sk,
-					 const unsigned int pkts)
+static inline void tcp_dec_quickack_mode(struct sock *sk)
 {
 	struct inet_connection_sock *icsk = inet_csk(sk);
 
 	if (icsk->icsk_ack.quick) {
+		/* How many ACKs S/ACKing new data have we sent? */
+		const unsigned int pkts = inet_csk_ack_scheduled(sk) ? 1 : 0;
+
 		if (pkts >= icsk->icsk_ack.quick) {
 			icsk->icsk_ack.quick = 0;
 			/* Leaving quickack mode we deflate ATO. */
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index dc3166e56169f..5921b0f6f9f41 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -177,8 +177,7 @@ static void tcp_event_data_sent(struct tcp_sock *tp,
 }
 
 /* Account for an ACK we sent. */
-static inline void tcp_event_ack_sent(struct sock *sk, unsigned int pkts,
-				      u32 rcv_nxt)
+static inline void tcp_event_ack_sent(struct sock *sk, u32 rcv_nxt)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
 
@@ -192,7 +191,7 @@ static inline void tcp_event_ack_sent(struct sock *sk, unsigned int pkts,
 
 	if (unlikely(rcv_nxt != tp->rcv_nxt))
 		return;  /* Special ACK sent by DCTCP to reflect ECN */
-	tcp_dec_quickack_mode(sk, pkts);
+	tcp_dec_quickack_mode(sk);
 	inet_csk_clear_xmit_timer(sk, ICSK_TIME_DACK);
 }
 
@@ -1373,7 +1372,7 @@ static int __tcp_transmit_skb(struct sock *sk, struct sk_buff *skb,
 			   sk, skb);
 
 	if (likely(tcb->tcp_flags & TCPHDR_ACK))
-		tcp_event_ack_sent(sk, tcp_skb_pcount(skb), rcv_nxt);
+		tcp_event_ack_sent(sk, rcv_nxt);
 
 	if (skb->len != tcp_header_size) {
 		tcp_event_data_sent(tp, sk);
-- 
2.40.1



