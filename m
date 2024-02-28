Return-Path: <stable+bounces-25403-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02E6E86B60C
	for <lists+stable@lfdr.de>; Wed, 28 Feb 2024 18:33:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2DDD28251E
	for <lists+stable@lfdr.de>; Wed, 28 Feb 2024 17:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AD911E514;
	Wed, 28 Feb 2024 17:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FH9W2eRF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385133FBA2;
	Wed, 28 Feb 2024 17:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709141604; cv=none; b=eVkwdsjfQz1t23ItedY8I5+PUAElD1S6OIWcXUCh/lA7lFTV4eOaEuLaHzBtio6RxShypJQ+dfXcg+g8Wx/BdUtabDpzcnhQTiWkTHJ5Q1gFSpc2VRN6ZMa9GODbUobSyB6ezH8HyNmtZeOWo1vCFpeYmJT0FD3Y49vnFRAHYCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709141604; c=relaxed/simple;
	bh=FfXFOgopppvVLsW5cOe0NR3KU/BWgkF143jEE5pgNKA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SPcDO7Pk4z2pg7BBcoxbAoPCOokgr+kHMw0+lXKP/mvw10oD6SDzIyJf3ogpUJEZ0KdAdt+Oi0d43QmFWgL4tzZDtXynFRjbnE6vp0t6JnB6E3SOq4LK+MPM23uFNa5tkS+CM0PuEhe8BNtbL4RxuDpn4qfUtlk9wzZEcW/HuS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FH9W2eRF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9888C433C7;
	Wed, 28 Feb 2024 17:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709141603;
	bh=FfXFOgopppvVLsW5cOe0NR3KU/BWgkF143jEE5pgNKA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FH9W2eRFtUyRn8psdkRfUlLDUdcoHzTqEnv4VwdEAWp8lRu+VrO3nhAwbKdOL8ZZd
	 HuK60/7eUp2NYmOfCF2gkEjJHzIerGPaTVuXVI8Y1iWqnbVfWfi2q2WLL6ZCMHP1cw
	 nFtObaCx69hQPtImoBfKlo9bDakwOrbGVr5Z299zhdux9EYjreW1xniGRcgrJcHeWN
	 RUDqS5MPba8XgiY4pL706uvT+mrwHsq/xd8i06vbINwXI3l7+DYb/0r+tARLmoV4X/
	 Sxi9DmorV/j+4y3AGRrGOvnE7qZ6T2gQFEeC32yFizKqhLHjmpaCWTlwRLHB5jrmZo
	 581ZPk24gpp2A==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>,
	Paolo Abeni <pabeni@redhat.com>,
	Mat Martineau <martineau@kernel.org>,
	Matthieu Baerts <matthieu.baerts@tessares.net>,
	"David S . Miller" <davem@davemloft.net>,
	Matthieu Baerts <matttbe@kernel.org>
Subject: [PATCH 5.15.y] mptcp: process pending subflow error on close
Date: Wed, 28 Feb 2024 18:33:18 +0100
Message-ID: <20240228173317.257282-2-matttbe@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2023100447-durable-snowiness-8b36@gregkh>
References: <2023100447-durable-snowiness-8b36@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3847; i=matttbe@kernel.org; h=from:subject; bh=AxhVWTnQXa9rlO+K6340OWBbJnkCouY5MXuW8bT9f1c=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBl325dsKoLj8rJGkAkclpCdaVMcSTOEQaii9TVp npzRl0qfUCJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZd9uXQAKCRD2t4JPQmmg c1eYD/9WyqkuYqCacy4+tBcMT6hDDaNpiSGFg0Tty45Srii6TjW9mse41LS9yKItV9bLZWAP7FM z45iNgW84+ElaJf9FR3g3im6iCL5Gn/eqQ1AP4WCku9q+EiN5/U67Ul5EZTnKlN5Ob0IOonqjXz FGaBQAbA2XckcfN8j91kN7/Kssa/CVJdmmte6L+adcOFDMibEpKWOVEIChvDabeHv0P2IhbNUg5 AhGOfNbROpWUlXaxH9H/yb1q1xbbkQmdCHZAVQYzQ1RXoNgjJHrbJvz3XRQpEAlbNq4+QsIMv+0 PSk+1slxqjMDgh+KsrdAY35VwSVMkyDAjX5BQzcopFKzrW7yj25OLrMNKkLQ9JUfzEtJyYvYQIR lwxNu2bdqSlpHtyBUAwxFYqRO84ZIYLbpaOVw2yvBSP50Us/0KGX1iD7juQ/v8KHUVWmrcIBoEY c4Cf/qg1rwIfLv1D0kDVoxtHLAP7Asu0e+zIkTYXg0Sk90reHNJjv7DuJ7s1Od+qhag42/OdNla BX1NZzx+jF3SPQiI7f0hns/BsPXJTx8w2o90bE6bhBvDX5usv3hwuj3kh6sluVNZ0oWy74vWA3u javvwAsMkOip8Kn7iynjvetDgYiCuGSaTAAuetYuJBQszvt/pUrna7oV3FkZVKGi+Diz6mOA+Om N87MB5ucdiJwBtQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

From: Paolo Abeni <pabeni@redhat.com>

On incoming TCP reset, subflow closing could happen before error
propagation. That in turn could cause the socket error being ignored,
and a missing socket state transition, as reported by Daire-Byrne.

Address the issues explicitly checking for subflow socket error at
close time. To avoid code duplication, factor-out of __mptcp_error_report()
a new helper implementing the relevant bits.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/429
Fixes: 15cc10453398 ("mptcp: deliver ssk errors to msk")
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: David S. Miller <davem@davemloft.net>
(cherry picked from commit 9f1a98813b4b686482e5ef3c9d998581cace0ba6)
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Notes:
 - a conflict in protocol.c, because commit 34cec5cd7abc ("mptcp: fix
   accept vs worker race") has not been backported to v5.15. It
   introduces a new label (out_release) in the modified context.
---
 net/mptcp/protocol.c | 63 ++++++++++++++++++++++++--------------------
 1 file changed, 34 insertions(+), 29 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 8382345af1d86..47844df9c0b4c 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -688,40 +688,44 @@ static bool __mptcp_ofo_queue(struct mptcp_sock *msk)
 	return moved;
 }
 
+static bool __mptcp_subflow_error_report(struct sock *sk, struct sock *ssk)
+{
+	int err = sock_error(ssk);
+	int ssk_state;
+
+	if (!err)
+		return false;
+
+	/* only propagate errors on fallen-back sockets or
+	 * on MPC connect
+	 */
+	if (sk->sk_state != TCP_SYN_SENT && !__mptcp_check_fallback(mptcp_sk(sk)))
+		return false;
+
+	/* We need to propagate only transition to CLOSE state.
+	 * Orphaned socket will see such state change via
+	 * subflow_sched_work_if_closed() and that path will properly
+	 * destroy the msk as needed.
+	 */
+	ssk_state = inet_sk_state_load(ssk);
+	if (ssk_state == TCP_CLOSE && !sock_flag(sk, SOCK_DEAD))
+		inet_sk_state_store(sk, ssk_state);
+	WRITE_ONCE(sk->sk_err, -err);
+
+	/* This barrier is coupled with smp_rmb() in mptcp_poll() */
+	smp_wmb();
+	sk_error_report(sk);
+	return true;
+}
+
 void __mptcp_error_report(struct sock *sk)
 {
 	struct mptcp_subflow_context *subflow;
 	struct mptcp_sock *msk = mptcp_sk(sk);
 
-	mptcp_for_each_subflow(msk, subflow) {
-		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
-		int err = sock_error(ssk);
-		int ssk_state;
-
-		if (!err)
-			continue;
-
-		/* only propagate errors on fallen-back sockets or
-		 * on MPC connect
-		 */
-		if (sk->sk_state != TCP_SYN_SENT && !__mptcp_check_fallback(msk))
-			continue;
-
-		/* We need to propagate only transition to CLOSE state.
-		 * Orphaned socket will see such state change via
-		 * subflow_sched_work_if_closed() and that path will properly
-		 * destroy the msk as needed.
-		 */
-		ssk_state = inet_sk_state_load(ssk);
-		if (ssk_state == TCP_CLOSE && !sock_flag(sk, SOCK_DEAD))
-			inet_sk_state_store(sk, ssk_state);
-		WRITE_ONCE(sk->sk_err, -err);
-
-		/* This barrier is coupled with smp_rmb() in mptcp_poll() */
-		smp_wmb();
-		sk_error_report(sk);
-		break;
-	}
+	mptcp_for_each_subflow(msk, subflow)
+		if (__mptcp_subflow_error_report(sk, mptcp_subflow_tcp_sock(subflow)))
+			break;
 }
 
 /* In most cases we will be able to lock the mptcp socket.  If its already
@@ -2309,6 +2313,7 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 		/* close acquired an extra ref */
 		__sock_put(ssk);
 	}
+	__mptcp_subflow_error_report(sk, ssk);
 	release_sock(ssk);
 
 	sock_put(ssk);
-- 
2.43.0


