Return-Path: <stable+bounces-25404-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 313D186B61B
	for <lists+stable@lfdr.de>; Wed, 28 Feb 2024 18:34:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2BBC1F28438
	for <lists+stable@lfdr.de>; Wed, 28 Feb 2024 17:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78463159585;
	Wed, 28 Feb 2024 17:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dG7BSjPT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3643D12DD9B;
	Wed, 28 Feb 2024 17:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709141654; cv=none; b=qgwoeTS5eWD60Ggj7RRETk/odCvCbwXFFkRcf4yNRxU/h4H5BdlbUUXhL8w+mrOVDg3ZDnVuHeG08PJ3ndhQwT6wb4NZA+DNRwbG1hmHr5YVIiAQG0GSvlqcGbJxQw9phcg8vHq9H7vAzoJHHSrs+5Tk+omhzLtUr1wlBGes8Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709141654; c=relaxed/simple;
	bh=FQuUwAya9x2g0WSazw9hHaImNaTu+qG7C4yv14KHnj0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rQ7nlBdBQ+b4OFUwbTQ8PvrRrIceBWpemXc7NqFaa4gEjpJRyk077FksEWrfXH7Ez8dCCPrnab4AWhfSpXSQ91+ec1w3ofXZuHpldahLxQZkRQGEmsPr14tzxwRH6GvThI4D+yrXxAyVJjgvysIfpLFBUYkT8b2SBt4mvVEF45Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dG7BSjPT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1472C433C7;
	Wed, 28 Feb 2024 17:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709141653;
	bh=FQuUwAya9x2g0WSazw9hHaImNaTu+qG7C4yv14KHnj0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dG7BSjPTZ4CzDmcJ+PeUrWpcy7wozcyRUHqIBdtIwUvIIOMesLyJfXGPI/tr7e1od
	 A594PRnSdeSUfmFCdMqoXYfIqBr67J1xLL61wAchUXBfhSFdyoW0Bver3Am6ENj9QR
	 kQaRfM/lMsytvjzE3UWjx4Ct9tCISeMld87caUw4NiF1i/kUaVI7MC5NRP1LMB3VWb
	 yCT7mke1rI6wLKFu+FMBsMeve/6JOGaotVff3gYtAQmoryp9BUXUCd3vBSuZz08HLA
	 8xkCLLQYFPz+syA9uhG9owZOupADfjUE+rgNiTRzIyFYX+g/zn9bBnUssW/NCSX6Lf
	 03WPUpXi9SF2w==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>,
	Paolo Abeni <pabeni@redhat.com>,
	Matthieu Baerts <matthieu.baerts@tessares.net>,
	Mat Martineau <martineau@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Matthieu Baerts <matttbe@kernel.org>
Subject: [PATCH 5.15.y] mptcp: rename timer related helper to less confusing names
Date: Wed, 28 Feb 2024 18:33:56 +0100
Message-ID: <20240228173355.258080-2-matttbe@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2023100402-launder-percent-3d59@gregkh>
References: <2023100402-launder-percent-3d59@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4543; i=matttbe@kernel.org; h=from:subject; bh=kx8TTUbqQVhAqxeqL567hYzyhzNfzrLKvuNSs1QDmME=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBl326Efe7lyu/FOC/I24S7WrYOfPhCjNDjLdzdk DTiR2PPr8+JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZd9uhAAKCRD2t4JPQmmg czcSD/0fwFSqhShXqXNSLKunlawQtQKJk1vLOTpNBNPwxEKk5Iyoom5RDpAgftuM/BaqybZ+DS9 QWFZppBvohwik3V++n/cGA/aClKZsnbFcXhlIit/5eG/LKWPzJCUbo8rdD58h/MBPY2yDI+KB8+ dxqZVW+Lgui5yuWjIx5LjkB237MsJyqcQxjA9e/B3AyUoP9hFRHPLQ3HTqkmMvszqSrwxhnEa8S uDKlLPJYpLar/9FY4CTv2Nv6QbLDk9r3jiIE8xGB1EHSE2z11EntuEaAb4opkXpVvFdHwEOPufS jYoV0sac9BlH4QoNtzaIz+OtgqoJdDQpKsG8R6RYKvqfwwuh0RaNM1KSD/bICntLqRXuQrF+VBp nvLIJdwU0xRdDKD2xCDgbEJoksrXca7SXbt0OgOTaLCoDnKKPCDuv6OFM1I6ymGHvV7vEbFy1mW 3J8I3tx8mkWIJygCroDAnHuIddb736yb5Wg+GovJhSjfYbi187nF9YiocFTStBKpchHHDnW9VB+ BUKUje+bxiUfs+58gJy/spcjKrqejGBdvXCPcL/GYSKtStEkHan2Sexue6yyffUE/YQnvPGeS8k eJyL3IgfOUaYVIwXXxyuatfUfIC7citd8kwAKAWLhMiAO1j/jggtTO++Us3qB/7M7c9Snkr/ZG2 jzkORkHKZaxzGAw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

From: Paolo Abeni <pabeni@redhat.com>

The msk socket uses to different timeout to track close related
events and retransmissions. The existing helpers do not indicate
clearly which timer they actually touch, making the related code
quite confusing.

Change the existing helpers name to avoid such confusion. No
functional change intended.

This patch is linked to the next one ("mptcp: fix dangling connection
hang-up"). The two patches are supposed to be backported together.

Cc: stable@vger.kernel.org # v5.11+
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: David S. Miller <davem@davemloft.net>
(cherry picked from commit f6909dc1c1f4452879278128012da6c76bc186a5)
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Notes:
 - A few conflicts, e.g. because 76a13b315709 ("mptcp: invoke MP_FAIL
   response when needed") is not in v5.15. The renames have been redone
   from scratch.
---
 net/mptcp/protocol.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 47844df9c0b4c..4b4720872f557 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -330,7 +330,7 @@ static bool __mptcp_move_skb(struct mptcp_sock *msk, struct sock *ssk,
 	return false;
 }
 
-static void mptcp_stop_timer(struct sock *sk)
+static void mptcp_stop_rtx_timer(struct sock *sk)
 {
 	struct inet_connection_sock *icsk = inet_csk(sk);
 
@@ -830,12 +830,12 @@ static void mptcp_flush_join_list(struct mptcp_sock *msk)
 	mptcp_sockopt_sync_all(msk);
 }
 
-static bool mptcp_timer_pending(struct sock *sk)
+static bool mptcp_rtx_timer_pending(struct sock *sk)
 {
 	return timer_pending(&inet_csk(sk)->icsk_retransmit_timer);
 }
 
-static void mptcp_reset_timer(struct sock *sk)
+static void mptcp_reset_rtx_timer(struct sock *sk)
 {
 	struct inet_connection_sock *icsk = inet_csk(sk);
 	unsigned long tout;
@@ -1145,10 +1145,10 @@ static void __mptcp_clean_una(struct sock *sk)
 		__mptcp_mem_reclaim_partial(sk);
 
 	if (snd_una == READ_ONCE(msk->snd_nxt) && !msk->recovery) {
-		if (mptcp_timer_pending(sk) && !mptcp_data_fin_enabled(msk))
-			mptcp_stop_timer(sk);
+		if (mptcp_rtx_timer_pending(sk) && !mptcp_data_fin_enabled(msk))
+			mptcp_stop_rtx_timer(sk);
 	} else {
-		mptcp_reset_timer(sk);
+		mptcp_reset_rtx_timer(sk);
 	}
 }
 
@@ -1640,8 +1640,8 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 
 out:
 	/* ensure the rtx timer is running */
-	if (!mptcp_timer_pending(sk))
-		mptcp_reset_timer(sk);
+	if (!mptcp_rtx_timer_pending(sk))
+		mptcp_reset_rtx_timer(sk);
 	if (copied)
 		mptcp_check_send_data_fin(sk);
 }
@@ -1700,8 +1700,8 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk)
 	if (copied) {
 		tcp_push(ssk, 0, info.mss_now, tcp_sk(ssk)->nonagle,
 			 info.size_goal);
-		if (!mptcp_timer_pending(sk))
-			mptcp_reset_timer(sk);
+		if (!mptcp_rtx_timer_pending(sk))
+			mptcp_reset_rtx_timer(sk);
 
 		if (msk->snd_data_fin_enable &&
 		    msk->snd_nxt + 1 == msk->write_seq)
@@ -2173,7 +2173,7 @@ static void mptcp_retransmit_timer(struct timer_list *t)
 	sock_put(sk);
 }
 
-static void mptcp_timeout_timer(struct timer_list *t)
+static void mptcp_tout_timer(struct timer_list *t)
 {
 	struct sock *sk = from_timer(sk, t, sk_timer);
 
@@ -2465,8 +2465,8 @@ static void __mptcp_retrans(struct sock *sk)
 	release_sock(ssk);
 
 reset_timer:
-	if (!mptcp_timer_pending(sk))
-		mptcp_reset_timer(sk);
+	if (!mptcp_rtx_timer_pending(sk))
+		mptcp_reset_rtx_timer(sk);
 }
 
 static void mptcp_worker(struct work_struct *work)
@@ -2543,7 +2543,7 @@ static int __mptcp_init_sock(struct sock *sk)
 
 	/* re-use the csk retrans timer for MPTCP-level retrans */
 	timer_setup(&msk->sk.icsk_retransmit_timer, mptcp_retransmit_timer, 0);
-	timer_setup(&sk->sk_timer, mptcp_timeout_timer, 0);
+	timer_setup(&sk->sk_timer, mptcp_tout_timer, 0);
 
 	return 0;
 }
@@ -2629,8 +2629,8 @@ void mptcp_subflow_shutdown(struct sock *sk, struct sock *ssk, int how)
 		} else {
 			pr_debug("Sending DATA_FIN on subflow %p", ssk);
 			tcp_send_ack(ssk);
-			if (!mptcp_timer_pending(sk))
-				mptcp_reset_timer(sk);
+			if (!mptcp_rtx_timer_pending(sk))
+				mptcp_reset_rtx_timer(sk);
 		}
 		break;
 	}
-- 
2.43.0


