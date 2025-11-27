Return-Path: <stable+bounces-197529-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12D99C8FEBF
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 19:28:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C61553A5C60
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 18:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBEF22ED161;
	Thu, 27 Nov 2025 18:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J6SqoOSr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A1E24886A;
	Thu, 27 Nov 2025 18:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764268079; cv=none; b=s6MWYx3sIv31a46t5bx17PtNeOxjNd7v7CZNjFVADCQdWuGnPPFR0FlnMqVXXfSLa2BW3mQsE9MTAderff1j+sTAGlrBOb+eDMI2HAzGIS1LHwYTANhxp1dCikd5fCDsVEMYISqXsH7dYHHRDZq3KsuGF1tY7/V9/J/6fjKQVjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764268079; c=relaxed/simple;
	bh=RsEOmHIljg6LRYEm+rUUrJzvjeQBdkoRGZmUWhFzkMg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AfG7TDx7TSGAId7xIUe0X/WZxUYfKmR/+cjW8Qlkcc2GF6uW/dWNT/FemvmQPsbCbuM9FaLzyEm9EAbKxgJlti13yvPVzLK0iuhIO4cPZJ8WKZVhDS4NbvzLMrThc4uO6pwSMr0NG9hSRN4ELb9/lhoDc18KBwQKqRRbx/oBRNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J6SqoOSr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBB67C4CEF8;
	Thu, 27 Nov 2025 18:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764268078;
	bh=RsEOmHIljg6LRYEm+rUUrJzvjeQBdkoRGZmUWhFzkMg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J6SqoOSr2Ic98JjVQO4yW76SKDBxBVfDCI0vPdM4zrmjdbpXLProg2U6II2yqz+r0
	 eWXr3kaaQriNJq6zEoQ3zHyyVw8PFiTOnI142/RQg64pZi17TPeYyhLwYui3T477cm
	 ay5a4hNlqzuM1x5kmmf2rX1vvKU7RaFs0D5Pz95ey74+Vk4KMJC/BNNFCB5fsv7sRf
	 nTKJjynF/JQLIjDR3k7g2JdoFZvtD6l8cQh7LGJ1d7MnAcUJhvAMYlcSv60b33EjGh
	 Nzu9Ev2m7pInJogC2bz+DJI4HRM5Pg7hm3ilC8hzlCm2ZSvDz1SpbqWzlYWELGQQ5I
	 gxmIrg9C9UjBw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>,
	Paolo Abeni <pabeni@redhat.com>,
	Geliang Tang <geliang@kernel.org>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.6.y] mptcp: fix duplicate reset on fastclose
Date: Thu, 27 Nov 2025 19:27:42 +0100
Message-ID: <20251127182741.3577840-2-matttbe@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025112433-making-debatable-abfe@gregkh>
References: <2025112433-making-debatable-abfe@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4075; i=matttbe@kernel.org; h=from:subject; bh=/Nc+LweViRBA6LzE5UnRSpuxOFE2So+7UbIPZcVmE04=; b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDI1Zsj9mh8gxO3xS3ylKK9c/mHfjpQfM9Z/Y/CfdiyIQ 7VN4U9mRykLgxgXg6yYIot0W2T+zOdVvCVefhYwc1iZQIYwcHEKwERWdjMyLI2XaVQruKi7ITjE abaHrcZR0TBWDpbeQwGLbOZKaarFMDJMzlT28342USz48iKRtekvg31XaJe/DzhV5Bu44uujrlm cAA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

From: Paolo Abeni <pabeni@redhat.com>

commit ae155060247be8dcae3802a95bd1bdf93ab3215d upstream.

The CI reports sporadic failures of the fastclose self-tests. The root
cause is a duplicate reset, not carrying the relevant MPTCP option.
In the failing scenario the bad reset is received by the peer before
the fastclose one, preventing the reception of the latter.

Indeed there is window of opportunity at fastclose time for the
following race:

  mptcp_do_fastclose
    __mptcp_close_ssk
      __tcp_close()
        tcp_set_state() [1]
        tcp_send_active_reset() [2]

After [1] the stack will send reset to in-flight data reaching the now
closed port. Such reset may race with [2].

Address the issue explicitly sending a single reset on fastclose before
explicitly moving the subflow to close status.

Fixes: d21f83485518 ("mptcp: use fastclose on more edge scenarios")
Cc: stable@vger.kernel.org
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/596
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Geliang Tang <geliang@kernel.org>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20251118-net-mptcp-misc-fixes-6-18-rc6-v1-6-806d3781c95f@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ No conflicts, but tcp_send_active_reset() doesn't take a 3rd argument
  (sk_rst_reason) in this version, see commit 5691276b39da ("rstreason:
  prepare for active reset"). This argument is only helpful for tracing,
  it is fine to drop it. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c | 35 ++++++++++++++++++++++-------------
 1 file changed, 22 insertions(+), 13 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 73b3a44b183f..167650ce2253 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2431,7 +2431,6 @@ bool __mptcp_retransmit_pending_data(struct sock *sk)
 
 /* flags for __mptcp_close_ssk() */
 #define MPTCP_CF_PUSH		BIT(1)
-#define MPTCP_CF_FASTCLOSE	BIT(2)
 
 /* be sure to send a reset only if the caller asked for it, also
  * clean completely the subflow status when the subflow reaches
@@ -2442,7 +2441,7 @@ static void __mptcp_subflow_disconnect(struct sock *ssk,
 				       unsigned int flags)
 {
 	if (((1 << ssk->sk_state) & (TCPF_CLOSE | TCPF_LISTEN)) ||
-	    (flags & MPTCP_CF_FASTCLOSE)) {
+	    subflow->send_fastclose) {
 		/* The MPTCP code never wait on the subflow sockets, TCP-level
 		 * disconnect should never fail
 		 */
@@ -2489,14 +2488,8 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 
 	lock_sock_nested(ssk, SINGLE_DEPTH_NESTING);
 
-	if ((flags & MPTCP_CF_FASTCLOSE) && !__mptcp_check_fallback(msk)) {
-		/* be sure to force the tcp_close path
-		 * to generate the egress reset
-		 */
-		ssk->sk_lingertime = 0;
-		sock_set_flag(ssk, SOCK_LINGER);
-		subflow->send_fastclose = 1;
-	}
+	if (subflow->send_fastclose && ssk->sk_state != TCP_CLOSE)
+		tcp_set_state(ssk, TCP_CLOSE);
 
 	need_push = (flags & MPTCP_CF_PUSH) && __mptcp_retransmit_pending_data(sk);
 	if (!dispose_it) {
@@ -2800,9 +2793,25 @@ static void mptcp_do_fastclose(struct sock *sk)
 	struct mptcp_sock *msk = mptcp_sk(sk);
 
 	mptcp_set_state(sk, TCP_CLOSE);
-	mptcp_for_each_subflow_safe(msk, subflow, tmp)
-		__mptcp_close_ssk(sk, mptcp_subflow_tcp_sock(subflow),
-				  subflow, MPTCP_CF_FASTCLOSE);
+
+	/* Explicitly send the fastclose reset as need */
+	if (__mptcp_check_fallback(msk))
+		return;
+
+	mptcp_for_each_subflow_safe(msk, subflow, tmp) {
+		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+
+		lock_sock(ssk);
+
+		/* Some subflow socket states don't allow/need a reset.*/
+		if ((1 << ssk->sk_state) & (TCPF_LISTEN | TCPF_CLOSE))
+			goto unlock;
+
+		subflow->send_fastclose = 1;
+		tcp_send_active_reset(ssk, ssk->sk_allocation);
+unlock:
+		release_sock(ssk);
+	}
 }
 
 static void mptcp_worker(struct work_struct *work)
-- 
2.51.0


