Return-Path: <stable+bounces-25402-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CAF786B606
	for <lists+stable@lfdr.de>; Wed, 28 Feb 2024 18:32:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3671C1C227D6
	for <lists+stable@lfdr.de>; Wed, 28 Feb 2024 17:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F82E1369B1;
	Wed, 28 Feb 2024 17:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ffxH3PGZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF06B3FBA2;
	Wed, 28 Feb 2024 17:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709141538; cv=none; b=Bgom47G0KluZoEyvw89sbuoSW8RPnCcz+PgC2Cj9sXqVQhnWckYwtNubeyysnTHZ7GayDvH22PWT61dDKmEbtEhJU5huP6YAwUTaVz6OoH078WRcncCmGtxoZilXTF+lu59y0riEhvEgbAv9TgMp8vZLzxZb89+NzmtTysbzehY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709141538; c=relaxed/simple;
	bh=HXQD3ppL4EL8Ki24QEE/lfTFWgkyD42Xf2IPB4zj8oE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tMz0Viy/n3O2aZz11/YITf+5slYPdx5Djg0hYDpJSivNoEP7wKm8n+N1aBGIkGR2z0v8c9jhpMck/7zorswv0ypMk0MlGHWZJrudGq/sFqBlAaXOKERGMLpifjA8D/vqxHZSlgsEHiKT7IKD+kjuaLdoctyqijeg64eTxkZAPcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ffxH3PGZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F3DAC433C7;
	Wed, 28 Feb 2024 17:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709141538;
	bh=HXQD3ppL4EL8Ki24QEE/lfTFWgkyD42Xf2IPB4zj8oE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ffxH3PGZ3jbqmXx6vkqlH6hAaggbgiMrDgXGeARlCzv3xcJeE3iS6RoaAYfrXUDzn
	 LurkyA+2FU7FlrV1zl1QK+HbiFjxON7OfsCGf62MLL5Ke07b1RPbgIaphADXXmgudL
	 p5MvgI9jT2Pa5qaLn7db5kFxA8czLF+TU0MG5do7nxuwQWgI7O+i8YvtdhzClQNfl2
	 /So3OOijfwx+kT0gTw9pPoc2LS+WGu3brj008lhcZZV8EkEAKnA/X611iguPEghFVS
	 9oLLZTQ+PPOEj2GpOaLjwAHmQxYgAIFXYFRcwA1M9DaHx5Q78FwKoGxj69cDKBGyDR
	 wv1qR1bm3fZLA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>,
	Paolo Abeni <pabeni@redhat.com>,
	Mat Martineau <martineau@kernel.org>,
	Matthieu Baerts <matthieu.baerts@tessares.net>,
	"David S . Miller" <davem@davemloft.net>,
	Matthieu Baerts <matttbe@kernel.org>
Subject: [PATCH 5.15.y] mptcp: move __mptcp_error_report in protocol.c
Date: Wed, 28 Feb 2024 18:31:58 +0100
Message-ID: <20240228173157.255719-2-matttbe@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2023100421-divisible-bacterium-18b5@gregkh>
References: <2023100421-divisible-bacterium-18b5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3978; i=matttbe@kernel.org; h=from:subject; bh=JXhbeOmplUmQsPUC0JVUwMuQr3vY4d2rPo0BZgOVKLA=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBl324Nz9GcwCNOqfxny4Kwwna0HO3EuCrwD7xQR LnttC0CimmJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZd9uDQAKCRD2t4JPQmmg c+CED/0Yl4xyn0y2io+QvFG2podXuUq+iMnfYEEnftkU85mT+jyl+IbFSJt4CvMU+INRr2c8duX DVOIgh/Nidr4uK0DpmDpoOjLkMEZ9pdTS+e1FJvM1eJAH6mZRBWgzhizwsYT7KMSyp8bhDDAF3L SK/V6+tzCTG7QXdFYC63rKxFnKDAOly16HMT7iPp1QQwmeWu1HQKnFI57yZ7y4+AOdx9mHGRygu Cf7rrGUOw+zbUmU+xldQOzNgXNO9ulItePpbxCK1/oXEILTUxvtcAZ5HUrBPzClbfXh9e/V3Wp4 pUJ93e78uEuCLrDfYZSxvbILxjhPXKcREiCb+eOrfAGA9tL2oiW5308T3fXlhXR/uJWP3fL3nWQ AbuG67X0KKnprJ5W2YoouC7JbUzfw2li8rsx1RcFnpXD6hZlK1l7mXgds39r/VG0XXNk8Qcxk0C oUtVaSNQcROKATVRWdqgFETGHMkQpkxRBplMs27i0/pX4INLTaPogot5tKKJoaz9pkaN3RuPW5M x0YZugxqPtp0/RkxRhbBwwPacl2iONJLI9sfZ3COHLR73+r6HwMoho6BLIrALyLSmMU6863viAd wf5hjK0B94A2977Qc1lRIbNTBD/lkKGsnlvWMlkxSmDg02eQ5VSfUXIgJ1wTkRSLrymlg44x+xT bjw7UYuf1LHfSaQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

From: Paolo Abeni <pabeni@redhat.com>

This will simplify the next patch ("mptcp: process pending subflow error
on close").

No functional change intended.

Cc: stable@vger.kernel.org # v5.12+
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: David S. Miller <davem@davemloft.net>
(cherry picked from commit d5fbeff1ab812b6c473b6924bee8748469462e2c)
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Notes:
 - A simple conflict because in v5.15, we don't have 9ae8e5ad99b8
   ("mptcp: annotate lockless accesses to sk->sk_err"), and one line
   from __mptcp_error_report() is different.
 - Note that the version of __mptcp_error_report() from after
   9ae8e5ad99b8 ("mptcp: annotate lockless accesses to sk->sk_err") has
   been taken -- with the WRITE_ONCE(sk->sk_err, -err); -- to ease the
   future backports.
---
 net/mptcp/protocol.c | 36 ++++++++++++++++++++++++++++++++++++
 net/mptcp/subflow.c  | 36 ------------------------------------
 2 files changed, 36 insertions(+), 36 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 8d3afa99ef653..8382345af1d86 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -688,6 +688,42 @@ static bool __mptcp_ofo_queue(struct mptcp_sock *msk)
 	return moved;
 }
 
+void __mptcp_error_report(struct sock *sk)
+{
+	struct mptcp_subflow_context *subflow;
+	struct mptcp_sock *msk = mptcp_sk(sk);
+
+	mptcp_for_each_subflow(msk, subflow) {
+		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+		int err = sock_error(ssk);
+		int ssk_state;
+
+		if (!err)
+			continue;
+
+		/* only propagate errors on fallen-back sockets or
+		 * on MPC connect
+		 */
+		if (sk->sk_state != TCP_SYN_SENT && !__mptcp_check_fallback(msk))
+			continue;
+
+		/* We need to propagate only transition to CLOSE state.
+		 * Orphaned socket will see such state change via
+		 * subflow_sched_work_if_closed() and that path will properly
+		 * destroy the msk as needed.
+		 */
+		ssk_state = inet_sk_state_load(ssk);
+		if (ssk_state == TCP_CLOSE && !sock_flag(sk, SOCK_DEAD))
+			inet_sk_state_store(sk, ssk_state);
+		WRITE_ONCE(sk->sk_err, -err);
+
+		/* This barrier is coupled with smp_rmb() in mptcp_poll() */
+		smp_wmb();
+		sk_error_report(sk);
+		break;
+	}
+}
+
 /* In most cases we will be able to lock the mptcp socket.  If its already
  * owned, we need to defer to the work queue to avoid ABBA deadlock.
  */
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 099bdfc12da96..80230787554ed 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1269,42 +1269,6 @@ void mptcp_space(const struct sock *ssk, int *space, int *full_space)
 	*full_space = tcp_full_space(sk);
 }
 
-void __mptcp_error_report(struct sock *sk)
-{
-	struct mptcp_subflow_context *subflow;
-	struct mptcp_sock *msk = mptcp_sk(sk);
-
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
-		sk->sk_err = -err;
-
-		/* This barrier is coupled with smp_rmb() in mptcp_poll() */
-		smp_wmb();
-		sk_error_report(sk);
-		break;
-	}
-}
-
 static void subflow_error_report(struct sock *ssk)
 {
 	struct sock *sk = mptcp_subflow_ctx(ssk)->conn;
-- 
2.43.0


