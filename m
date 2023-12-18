Return-Path: <stable+bounces-7176-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43755817147
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 14:56:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA4551F2361B
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 13:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3492F37860;
	Mon, 18 Dec 2023 13:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XHWq7QCa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12E81D15C;
	Mon, 18 Dec 2023 13:56:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77136C433C8;
	Mon, 18 Dec 2023 13:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702907765;
	bh=hTERgOyh47RpeR9lFuI2kltnSDD2RCUqaDKP3ZMoNlc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XHWq7QCajaHsReEikNopv2pJQq8PXKhv/oMy50jbI6oC+uln1Fosdt7C6GeiAsn+J
	 h7M1ZmDqtWKdbQELjGLKh86Li3/i+dQy0QSLrucJXvOJVVIBhmWxDBxlX28365jIrp
	 jwUlaPDbhimUFPmVSXHKu2OyWTfR8DSW4CtjBpeI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Eric Dumazet <edumazet@google.com>,
	Dong Chenchen <dongchenchen2@huawei.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 031/106] net: Remove acked SYN flag from packet in the transmit queue correctly
Date: Mon, 18 Dec 2023 14:50:45 +0100
Message-ID: <20231218135056.274430285@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231218135055.005497074@linuxfoundation.org>
References: <20231218135055.005497074@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dong Chenchen <dongchenchen2@huawei.com>

[ Upstream commit f99cd56230f56c8b6b33713c5be4da5d6766be1f ]

syzkaller report:

 kernel BUG at net/core/skbuff.c:3452!
 invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
 CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.7.0-rc4-00009-gbee0e7762ad2-dirty #135
 RIP: 0010:skb_copy_and_csum_bits (net/core/skbuff.c:3452)
 Call Trace:
 icmp_glue_bits (net/ipv4/icmp.c:357)
 __ip_append_data.isra.0 (net/ipv4/ip_output.c:1165)
 ip_append_data (net/ipv4/ip_output.c:1362 net/ipv4/ip_output.c:1341)
 icmp_push_reply (net/ipv4/icmp.c:370)
 __icmp_send (./include/net/route.h:252 net/ipv4/icmp.c:772)
 ip_fragment.constprop.0 (./include/linux/skbuff.h:1234 net/ipv4/ip_output.c:592 net/ipv4/ip_output.c:577)
 __ip_finish_output (net/ipv4/ip_output.c:311 net/ipv4/ip_output.c:295)
 ip_output (net/ipv4/ip_output.c:427)
 __ip_queue_xmit (net/ipv4/ip_output.c:535)
 __tcp_transmit_skb (net/ipv4/tcp_output.c:1462)
 __tcp_retransmit_skb (net/ipv4/tcp_output.c:3387)
 tcp_retransmit_skb (net/ipv4/tcp_output.c:3404)
 tcp_retransmit_timer (net/ipv4/tcp_timer.c:604)
 tcp_write_timer (./include/linux/spinlock.h:391 net/ipv4/tcp_timer.c:716)

The panic issue was trigered by tcp simultaneous initiation.
The initiation process is as follows:

      TCP A                                            TCP B

  1.  CLOSED                                           CLOSED

  2.  SYN-SENT     --> <SEQ=100><CTL=SYN>              ...

  3.  SYN-RECEIVED <-- <SEQ=300><CTL=SYN>              <-- SYN-SENT

  4.               ... <SEQ=100><CTL=SYN>              --> SYN-RECEIVED

  5.  SYN-RECEIVED --> <SEQ=100><ACK=301><CTL=SYN,ACK> ...

  // TCP B: not send challenge ack for ack limit or packet loss
  // TCP A: close
	tcp_close
	   tcp_send_fin
              if (!tskb && tcp_under_memory_pressure(sk))
                  tskb = skb_rb_last(&sk->tcp_rtx_queue); //pick SYN_ACK packet
           TCP_SKB_CB(tskb)->tcp_flags |= TCPHDR_FIN;  // set FIN flag

  6.  FIN_WAIT_1  --> <SEQ=100><ACK=301><END_SEQ=102><CTL=SYN,FIN,ACK> ...

  // TCP B: send challenge ack to SYN_FIN_ACK

  7.               ... <SEQ=301><ACK=101><CTL=ACK>   <-- SYN-RECEIVED //challenge ack

  // TCP A:  <SND.UNA=101>

  8.  FIN_WAIT_1 --> <SEQ=101><ACK=301><END_SEQ=102><CTL=SYN,FIN,ACK> ... // retransmit panic

	__tcp_retransmit_skb  //skb->len=0
	    tcp_trim_head
		len = tp->snd_una - TCP_SKB_CB(skb)->seq // len=101-100
		    __pskb_trim_head
			skb->data_len -= len // skb->len=-1, wrap around
	    ... ...
	    ip_fragment
		icmp_glue_bits //BUG_ON

If we use tcp_trim_head() to remove acked SYN from packet that contains data
or other flags, skb->len will be incorrectly decremented. We can remove SYN
flag that has been acked from rtx_queue earlier than tcp_trim_head(), which
can fix the problem mentioned above.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Co-developed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Dong Chenchen <dongchenchen2@huawei.com>
Link: https://lore.kernel.org/r/20231210020200.1539875-1-dongchenchen2@huawei.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/tcp_output.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 5b93d1ed1ed19..67087da45a1f7 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -3210,7 +3210,13 @@ int __tcp_retransmit_skb(struct sock *sk, struct sk_buff *skb, int segs)
 	if (skb_still_in_host_queue(sk, skb))
 		return -EBUSY;
 
+start:
 	if (before(TCP_SKB_CB(skb)->seq, tp->snd_una)) {
+		if (unlikely(TCP_SKB_CB(skb)->tcp_flags & TCPHDR_SYN)) {
+			TCP_SKB_CB(skb)->tcp_flags &= ~TCPHDR_SYN;
+			TCP_SKB_CB(skb)->seq++;
+			goto start;
+		}
 		if (unlikely(before(TCP_SKB_CB(skb)->end_seq, tp->snd_una))) {
 			WARN_ON_ONCE(1);
 			return -EINVAL;
-- 
2.43.0




