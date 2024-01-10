Return-Path: <stable+bounces-10098-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A00D827269
	for <lists+stable@lfdr.de>; Mon,  8 Jan 2024 16:12:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1588128447D
	for <lists+stable@lfdr.de>; Mon,  8 Jan 2024 15:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4F904BAA8;
	Mon,  8 Jan 2024 15:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="e7RbHjeW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BCCE4B5AB;
	Mon,  8 Jan 2024 15:12:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EECF5C433BC;
	Mon,  8 Jan 2024 15:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704726754;
	bh=w9oIBjIXuYRK4UuvQVCMq18P8DFnw4TDb0EqDL1kdBQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e7RbHjeW7WdECYPzWsltQuLmDk4/XRnYB1Z/VZOPYdooi2O8ZGmRIlmPnQvGqWBK9
	 gFTuVYGjSAOELewrDbMRgweZsbgjrw4NKSrJNYJqTXBGF9e1fxPsMksAxwaK0b2lTx
	 Zxydziq9CPZibOAjdbLKb60iaooNH8t7COXWM17I=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Eric Dumazet <edumazet@google.com>,
	Soheil Hassas Yeganeh <soheil@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 068/124] tcp: derive delack_max from rto_min
Date: Mon,  8 Jan 2024 16:08:14 +0100
Message-ID: <20240108150606.096683247@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240108150602.976232871@linuxfoundation.org>
References: <20240108150602.976232871@linuxfoundation.org>
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

[ Upstream commit bbf80d713fe75cfbecda26e7c03a9a8d22af2f4f ]

While BPF allows to set icsk->->icsk_delack_max
and/or icsk->icsk_rto_min, we have an ip route
attribute (RTAX_RTO_MIN) to be able to tune rto_min,
but nothing to consequently adjust max delayed ack,
which vary from 40ms to 200 ms (TCP_DELACK_{MIN|MAX}).

This makes RTAX_RTO_MIN of almost no practical use,
unless customers are in big trouble.

Modern days datacenter communications want to set
rto_min to ~5 ms, and the max delayed ack one jiffie
smaller to avoid spurious retransmits.

After this patch, an "rto_min 5" route attribute will
effectively lower max delayed ack timers to 4 ms.

Note in the following ss output, "rto:6 ... ato:4"

$ ss -temoi dst XXXXXX
State Recv-Q Send-Q           Local Address:Port       Peer Address:Port  Process
ESTAB 0      0        [2002:a05:6608:295::]:52950   [2002:a05:6608:297::]:41597
     ino:255134 sk:1001 <->
         skmem:(r0,rb1707063,t872,tb262144,f0,w0,o0,bl0,d0) ts sack
 cubic wscale:8,8 rto:6 rtt:0.02/0.002 ato:4 mss:4096 pmtu:4500
 rcvmss:536 advmss:4096 cwnd:10 bytes_sent:54823160 bytes_acked:54823121
 bytes_received:54823120 segs_out:1370582 segs_in:1370580
 data_segs_out:1370579 data_segs_in:1370578 send 16.4Gbps
 pacing_rate 32.6Gbps delivery_rate 1.72Gbps delivered:1370579
 busy:26920ms unacked:1 rcv_rtt:34.615 rcv_space:65920
 rcv_ssthresh:65535 minrtt:0.015 snd_wnd:65536

While we could argue this patch fixes a bug with RTAX_RTO_MIN,
I do not add a Fixes: tag, so that we can soak it a bit before
asking backports to stable branches.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Acked-by: Soheil Hassas Yeganeh <soheil@google.com>
Acked-by: Neal Cardwell <ncardwell@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/tcp.h     |  2 ++
 net/ipv4/tcp.c        |  3 ++-
 net/ipv4/tcp_output.c | 16 +++++++++++++++-
 3 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index a88bf8f6db235..9cbcfb3c95dac 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -723,6 +723,8 @@ static inline void tcp_fast_path_check(struct sock *sk)
 		tcp_fast_path_on(tp);
 }
 
+u32 tcp_delack_max(const struct sock *sk);
+
 /* Compute the actual rto_min value */
 static inline u32 tcp_rto_min(struct sock *sk)
 {
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index ec46d74c20938..f124f6c639157 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3774,7 +3774,8 @@ void tcp_get_info(struct sock *sk, struct tcp_info *info)
 		info->tcpi_options |= TCPI_OPT_SYN_DATA;
 
 	info->tcpi_rto = jiffies_to_usecs(icsk->icsk_rto);
-	info->tcpi_ato = jiffies_to_usecs(icsk->icsk_ack.ato);
+	info->tcpi_ato = jiffies_to_usecs(min(icsk->icsk_ack.ato,
+					      tcp_delack_max(sk)));
 	info->tcpi_snd_mss = tp->mss_cache;
 	info->tcpi_rcv_mss = icsk->icsk_ack.rcv_mss;
 
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index cab3c1162c3a6..ab3b7b4b4429b 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -4003,6 +4003,20 @@ int tcp_connect(struct sock *sk)
 }
 EXPORT_SYMBOL(tcp_connect);
 
+u32 tcp_delack_max(const struct sock *sk)
+{
+	const struct dst_entry *dst = __sk_dst_get(sk);
+	u32 delack_max = inet_csk(sk)->icsk_delack_max;
+
+	if (dst && dst_metric_locked(dst, RTAX_RTO_MIN)) {
+		u32 rto_min = dst_metric_rtt(dst, RTAX_RTO_MIN);
+		u32 delack_from_rto_min = max_t(int, 1, rto_min - 1);
+
+		delack_max = min_t(u32, delack_max, delack_from_rto_min);
+	}
+	return delack_max;
+}
+
 /* Send out a delayed ack, the caller does the policy checking
  * to see if we should even be here.  See tcp_input.c:tcp_ack_snd_check()
  * for details.
@@ -4038,7 +4052,7 @@ void tcp_send_delayed_ack(struct sock *sk)
 		ato = min(ato, max_ato);
 	}
 
-	ato = min_t(u32, ato, inet_csk(sk)->icsk_delack_max);
+	ato = min_t(u32, ato, tcp_delack_max(sk));
 
 	/* Stay within the limit we were given */
 	timeout = jiffies + ato;
-- 
2.43.0




