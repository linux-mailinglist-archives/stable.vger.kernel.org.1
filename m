Return-Path: <stable+bounces-527-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 996887F7B76
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:05:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C412B211EE
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 18:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A04C239FE1;
	Fri, 24 Nov 2023 18:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bgkJNvIL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D973381DF;
	Fri, 24 Nov 2023 18:05:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B93BC433C7;
	Fri, 24 Nov 2023 18:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700849120;
	bh=/coHbsRxULSqVj4rc+zlsRJAYDMHycWsdhp0Nz82j6g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bgkJNvIL7/oP+GsRZDuj3ugHwRrc2pT1gFVBNgG4Yprapw6lTtEKCCwlisY/OOgqS
	 wiRVBDQavTY2iiWRnn/UWbju3fC6ue9AUC2UBNc/wbnldbi5/rzfY5PNNDORMMWPme
	 XnZ+aWfqsZVNoo1v4WMbKU2luI9bg6VDfSL6zf7E=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 031/530] net: annotate data-races around sk->sk_dst_pending_confirm
Date: Fri, 24 Nov 2023 17:43:17 +0000
Message-ID: <20231124172029.010524649@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172028.107505484@linuxfoundation.org>
References: <20231124172028.107505484@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit eb44ad4e635132754bfbcb18103f1dcb7058aedd ]

This field can be read or written without socket lock being held.

Add annotations to avoid load-store tearing.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/sock.h    | 6 +++---
 net/core/sock.c       | 2 +-
 net/ipv4/tcp_output.c | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index 97f7fbcbf61ed..7753354d59c0b 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -2181,7 +2181,7 @@ static inline void __dst_negative_advice(struct sock *sk)
 		if (ndst != dst) {
 			rcu_assign_pointer(sk->sk_dst_cache, ndst);
 			sk_tx_queue_clear(sk);
-			sk->sk_dst_pending_confirm = 0;
+			WRITE_ONCE(sk->sk_dst_pending_confirm, 0);
 		}
 	}
 }
@@ -2198,7 +2198,7 @@ __sk_dst_set(struct sock *sk, struct dst_entry *dst)
 	struct dst_entry *old_dst;
 
 	sk_tx_queue_clear(sk);
-	sk->sk_dst_pending_confirm = 0;
+	WRITE_ONCE(sk->sk_dst_pending_confirm, 0);
 	old_dst = rcu_dereference_protected(sk->sk_dst_cache,
 					    lockdep_sock_is_held(sk));
 	rcu_assign_pointer(sk->sk_dst_cache, dst);
@@ -2211,7 +2211,7 @@ sk_dst_set(struct sock *sk, struct dst_entry *dst)
 	struct dst_entry *old_dst;
 
 	sk_tx_queue_clear(sk);
-	sk->sk_dst_pending_confirm = 0;
+	WRITE_ONCE(sk->sk_dst_pending_confirm, 0);
 	old_dst = xchg((__force struct dst_entry **)&sk->sk_dst_cache, dst);
 	dst_release(old_dst);
 }
diff --git a/net/core/sock.c b/net/core/sock.c
index 16584e2dd6481..bfaf47b3f3c7c 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -600,7 +600,7 @@ struct dst_entry *__sk_dst_check(struct sock *sk, u32 cookie)
 	    INDIRECT_CALL_INET(dst->ops->check, ip6_dst_check, ipv4_dst_check,
 			       dst, cookie) == NULL) {
 		sk_tx_queue_clear(sk);
-		sk->sk_dst_pending_confirm = 0;
+		WRITE_ONCE(sk->sk_dst_pending_confirm, 0);
 		RCU_INIT_POINTER(sk->sk_dst_cache, NULL);
 		dst_release(dst);
 		return NULL;
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index f0723460753c5..9ccfdc825004d 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -1331,7 +1331,7 @@ static int __tcp_transmit_skb(struct sock *sk, struct sk_buff *skb,
 	skb->destructor = skb_is_tcp_pure_ack(skb) ? __sock_wfree : tcp_wfree;
 	refcount_add(skb->truesize, &sk->sk_wmem_alloc);
 
-	skb_set_dst_pending_confirm(skb, sk->sk_dst_pending_confirm);
+	skb_set_dst_pending_confirm(skb, READ_ONCE(sk->sk_dst_pending_confirm));
 
 	/* Build TCP header and checksum it. */
 	th = (struct tcphdr *)skb->data;
-- 
2.42.0




