Return-Path: <stable+bounces-63391-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02DC89418C2
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 18:25:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EE8F1C20D67
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 16:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BB951898E1;
	Tue, 30 Jul 2024 16:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="l/71BWgX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2EB183CBF;
	Tue, 30 Jul 2024 16:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722356683; cv=none; b=mu+phzUSezRGBuKV0OBaomQ7bO96IKJifSD/n8GN19HB7mT6WtV/AUdT4C9b2ffb9lYJx+fEvq6X7N+piIA9ZRb0EZ5G8RpUdqQmmbdq9lCBFHIub9szTEgRAh6Mzmu0Jx9z1AwWSlV5MwW9XLCDkWlrYPTCVYD0bjAS8Wx/MhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722356683; c=relaxed/simple;
	bh=ezIarHBKyazCGDRJbdPoMDluoWBAy3cr4p8oII+nMyo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XymGGKuC3y8cp70LAfHclKkFsLSTy5TCeGfm4tKhG6zv0/jG2L9Johliztgz8TVauj4qGxGHVi2+T3nxVBOCk46kCvX8lID+yAweyqZktOxxZkOQDZBKrD+sKoU5RlPOWCyJqBgZ5UzKKyrUPvj7xoJY58ryu5zkRzGMUMN8HHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=l/71BWgX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 101D1C32782;
	Tue, 30 Jul 2024 16:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722356682;
	bh=ezIarHBKyazCGDRJbdPoMDluoWBAy3cr4p8oII+nMyo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l/71BWgXeFD7WmUVy7en5XnIce+RxQv0/T74L5afqyhuC66wx5S9djjEr1AjaKGKX
	 MATI/dSVSjGPQaku90MzATMzmjtOShaDHDNgzpUnZbA3tm9knkTH3KJBaBPSO7o1Co
	 cV64cJg5WVOeoge36H5ZzVe2rzQ4hvlsazFX5w6k=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Neal Cardwell <ncardwell@google.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.10 173/809] tcp: add tcp_done_with_error() helper
Date: Tue, 30 Jul 2024 17:40:49 +0200
Message-ID: <20240730151731.437691895@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730151724.637682316@linuxfoundation.org>
References: <20240730151724.637682316@linuxfoundation.org>
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

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 5e514f1cba090e1c8fff03e92a175eccfe46305f ]

tcp_reset() ends with a sequence that is carefuly ordered.

We need to fix [e]poll bugs in the following patches,
it makes sense to use a common helper.

Suggested-by: Neal Cardwell <ncardwell@google.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Acked-by: Neal Cardwell <ncardwell@google.com>
Link: https://lore.kernel.org/r/20240528125253.1966136-2-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 853c3bd7b791 ("tcp: fix race in tcp_write_err()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/tcp.h    |  1 +
 net/ipv4/tcp.c       |  2 +-
 net/ipv4/tcp_input.c | 32 +++++++++++++++++++++-----------
 3 files changed, 23 insertions(+), 12 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 060e95b331a28..32815a40dea16 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -677,6 +677,7 @@ void tcp_skb_collapse_tstamp(struct sk_buff *skb,
 /* tcp_input.c */
 void tcp_rearm_rto(struct sock *sk);
 void tcp_synack_rtt_meas(struct sock *sk, struct request_sock *req);
+void tcp_done_with_error(struct sock *sk, int err);
 void tcp_reset(struct sock *sk, struct sk_buff *skb);
 void tcp_fin(struct sock *sk);
 void tcp_check_space(struct sock *sk);
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index e6790ea748773..cc36ff797484b 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -598,7 +598,7 @@ __poll_t tcp_poll(struct file *file, struct socket *sock, poll_table *wait)
 		 */
 		mask |= EPOLLOUT | EPOLLWRNORM;
 	}
-	/* This barrier is coupled with smp_wmb() in tcp_reset() */
+	/* This barrier is coupled with smp_wmb() in tcp_done_with_error() */
 	smp_rmb();
 	if (READ_ONCE(sk->sk_err) ||
 	    !skb_queue_empty_lockless(&sk->sk_error_queue))
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 38da23f991d60..570e87ad9a56e 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -4469,9 +4469,26 @@ static enum skb_drop_reason tcp_sequence(const struct tcp_sock *tp,
 	return SKB_NOT_DROPPED_YET;
 }
 
+
+void tcp_done_with_error(struct sock *sk, int err)
+{
+	/* This barrier is coupled with smp_rmb() in tcp_poll() */
+	WRITE_ONCE(sk->sk_err, err);
+	smp_wmb();
+
+	tcp_write_queue_purge(sk);
+	tcp_done(sk);
+
+	if (!sock_flag(sk, SOCK_DEAD))
+		sk_error_report(sk);
+}
+EXPORT_SYMBOL(tcp_done_with_error);
+
 /* When we get a reset we do this. */
 void tcp_reset(struct sock *sk, struct sk_buff *skb)
 {
+	int err;
+
 	trace_tcp_receive_reset(sk);
 
 	/* mptcp can't tell us to ignore reset pkts,
@@ -4483,24 +4500,17 @@ void tcp_reset(struct sock *sk, struct sk_buff *skb)
 	/* We want the right error as BSD sees it (and indeed as we do). */
 	switch (sk->sk_state) {
 	case TCP_SYN_SENT:
-		WRITE_ONCE(sk->sk_err, ECONNREFUSED);
+		err = ECONNREFUSED;
 		break;
 	case TCP_CLOSE_WAIT:
-		WRITE_ONCE(sk->sk_err, EPIPE);
+		err = EPIPE;
 		break;
 	case TCP_CLOSE:
 		return;
 	default:
-		WRITE_ONCE(sk->sk_err, ECONNRESET);
+		err = ECONNRESET;
 	}
-	/* This barrier is coupled with smp_rmb() in tcp_poll() */
-	smp_wmb();
-
-	tcp_write_queue_purge(sk);
-	tcp_done(sk);
-
-	if (!sock_flag(sk, SOCK_DEAD))
-		sk_error_report(sk);
+	tcp_done_with_error(sk, err);
 }
 
 /*
-- 
2.43.0




