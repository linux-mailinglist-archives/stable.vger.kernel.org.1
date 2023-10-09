Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A4D57BDE8F
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346513AbjJINUl (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346521AbjJINUl (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:20:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA1AB8F
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:20:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15A01C433CA;
        Mon,  9 Oct 2023 13:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696857639;
        bh=pXHh0Uvx01GffeQvkxSL6qdhp1r1zNXjfuqXnaNjZQc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zrqGho+6iscXClEvoMQ0ALAFRkxQvCkwl9OcTl5lVXo8T8yoNCvoc/CN3eMSW1xH1
         TpI7FmMRrEJbu8hqqbBWKHCv3vQGPXRq3bTgnOREdrTqKPJcaBQB4dBEQBOtocdBq7
         ytYcDCkGlW9ubwpt6qEra6hMRmn3+cdBf6aYJDGE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, John Fastabend <john.fastabend@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 102/162] bpf: tcp_read_skb needs to pop skb regardless of seq
Date:   Mon,  9 Oct 2023 15:01:23 +0200
Message-ID: <20231009130125.740199791@linuxfoundation.org>
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

From: John Fastabend <john.fastabend@gmail.com>

[ Upstream commit 9b7177b1df64b8d7f85700027c324aadd6aded00 ]

Before fix e5c6de5fa0258 tcp_read_skb() would increment the tp->copied-seq
value. This (as described in the commit) would cause an error for apps
because once that is incremented the application might believe there is no
data to be read. Then some apps would stall or abort believing no data is
available.

However, the fix is incomplete because it introduces another issue in
the skb dequeue. The loop does tcp_recv_skb() in a while loop to consume
as many skbs as possible. The problem is the call is ...

  tcp_recv_skb(sk, seq, &offset)

... where 'seq' is:

  u32 seq = tp->copied_seq;

Now we can hit a case where we've yet incremented copied_seq from BPF side,
but then tcp_recv_skb() fails this test ...

 if (offset < skb->len || (TCP_SKB_CB(skb)->tcp_flags & TCPHDR_FIN))

... so that instead of returning the skb we call tcp_eat_recv_skb() which
frees the skb. This is because the routine believes the SKB has been collapsed
per comment:

 /* This looks weird, but this can happen if TCP collapsing
  * splitted a fat GRO packet, while we released socket lock
  * in skb_splice_bits()
  */

This can't happen here we've unlinked the full SKB and orphaned it. Anyways
it would confuse any BPF programs if the data were suddenly moved underneath
it.

To fix this situation do simpler operation and just skb_peek() the data
of the queue followed by the unlink. It shouldn't need to check this
condition and tcp_read_skb() reads entire skbs so there is no need to
handle the 'offset!=0' case as we would see in tcp_read_sock().

Fixes: e5c6de5fa0258 ("bpf, sockmap: Incorrectly handling copied_seq")
Fixes: 04919bed948dc ("tcp: Introduce tcp_read_skb()")
Signed-off-by: John Fastabend <john.fastabend@gmail.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
Link: https://lore.kernel.org/bpf/20230926035300.135096-2-john.fastabend@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/tcp.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index fab25d4f3a6f1..96fdde6e42b1b 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1755,16 +1755,13 @@ EXPORT_SYMBOL(tcp_read_sock);
 
 int tcp_read_skb(struct sock *sk, skb_read_actor_t recv_actor)
 {
-	struct tcp_sock *tp = tcp_sk(sk);
-	u32 seq = tp->copied_seq;
 	struct sk_buff *skb;
 	int copied = 0;
-	u32 offset;
 
 	if (sk->sk_state == TCP_LISTEN)
 		return -ENOTCONN;
 
-	while ((skb = tcp_recv_skb(sk, seq, &offset)) != NULL) {
+	while ((skb = skb_peek(&sk->sk_receive_queue)) != NULL) {
 		u8 tcp_flags;
 		int used;
 
@@ -1777,13 +1774,10 @@ int tcp_read_skb(struct sock *sk, skb_read_actor_t recv_actor)
 				copied = used;
 			break;
 		}
-		seq += used;
 		copied += used;
 
-		if (tcp_flags & TCPHDR_FIN) {
-			++seq;
+		if (tcp_flags & TCPHDR_FIN)
 			break;
-		}
 	}
 	return copied;
 }
-- 
2.40.1



