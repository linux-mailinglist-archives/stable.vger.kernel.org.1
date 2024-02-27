Return-Path: <stable+bounces-25274-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CFAA869E79
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 19:00:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 423291F2BA53
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 18:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89EB64EB46;
	Tue, 27 Feb 2024 18:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bDbHUEem"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44AA448CCD;
	Tue, 27 Feb 2024 18:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709056811; cv=none; b=M7eXQc2IgYvjJDQMtJSKBDlOh8N/eQrmM1RNBC3Dzbe3mXfHyCqtugIjN9943OicZsDp+IjWvijw7QVG5OvLgY4RDrY/9o3Hd5WofiSsMltX9QEzCyAApwP7ZCh/3YYg5qO81HkoIScHyTdDnJSAAAAzZE4KYoZnIELuncQst0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709056811; c=relaxed/simple;
	bh=ckJNLHq+voCT60QSx/OYa53cCDQmemAHoVi3YXyM/xw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MR+K/08k3Boz3Oe9ApJ9/9FkE0xOppXT4qT+TmllgRagxZ+AIhb+rJ8/gAtgcZS4OuJXsP6QSgimV/YBUY8Q5Fa8V0+2rrmE+3zOmv0awtZQ3/h57rpjiOdO5CZ3y+FwuvgqTI/VuuO+3xz2JzyYDfsUEf+NSkGxNVulW0OkTX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bDbHUEem; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AD8FC433C7;
	Tue, 27 Feb 2024 18:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709056810;
	bh=ckJNLHq+voCT60QSx/OYa53cCDQmemAHoVi3YXyM/xw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bDbHUEemOeE/0qejrq3LKDUu3cFecGNf8rfjIKkE8bDfIaCglj35GiDxKMqUpFfOJ
	 pKB+uVtQKAhAJnDVUOpkox/Kta7K3n5XU2ix+w/lUdPrI7jPicsbw+McD8e9OJTb/x
	 qpAfczIyvMv11Ay+Vz/5m2VTueGpEFKkNiRUrxytt1LSV+MA2wbRf3Vaky9yHG+TD+
	 C1Z9ZdqFDE69Q5airT1HTSfPV7WS/D+oUYRX+xXWPKint5O0oaabJ2SprjX5ZpaKfA
	 PhIU6RC4keoNej4mZRtNu1PJc3NWhCwApQ9zD1A/s2JeohGmY/VZbPz6ge8FyAucw7
	 ejSS528urQhmQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>,
	Paolo Abeni <pabeni@redhat.com>,
	Mat Martineau <martineau@kernel.org>,
	Matthieu Baerts <matttbe@kernel.org>,
	"David S . Miller" <davem@davemloft.net>
Subject: [PATCH 6.1.y] mptcp: fix data races on local_id
Date: Tue, 27 Feb 2024 18:58:51 +0100
Message-ID: <20240227175850.4026403-2-matttbe@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2024022609-elongated-activity-64a1@gregkh>
References: <2024022609-elongated-activity-64a1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7648; i=matttbe@kernel.org; h=from:subject; bh=GlAX/fQSs0jkpOiJU1g4g4NUgA30xUX7/4gtgUjBNYw=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBl3iLaj1PwpBdetrMyl6o69m4sbEWp+y/yD0beX 3xdQZxZOXqJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZd4i2gAKCRD2t4JPQmmg c99ED/9K0E8WR/VSZwXiP9dQg2f3pvx1KmaqOPGDn2pT5ZxLUlHN9w/w/2SNPkjz03Wpbs3FuZe porR3cVy4thdin8uQTf6rkHZhfL7iXmoXQAg7JvT5WoJTroI6HJOenrubiVO57KGiyMPyRv9uR6 rEeOHJWIS7arZJDH5XYVXeo2m6dCUjTItJI0zGQCGLxPbEC7bOXpml57A/N3MO4KEGE63JKy3vw m/cOdnSgKXFCZNMi6UCHmHtZv13hEQNLZZNVaCyuCPlxXDTXDgBDFnOdrFD2h7EHhtqqI1N5/7D l4CuTZCz3Rj5A7ByATBdjbwOmK4kvc6pl59Xsu0BjAvjxcrorjKUACDCHV9zZVb2+oeEluAleOe bCmGXLRXoiCK1ohqpslDFJI40LgftV5m8mKvU5ydST3B+PU+3dSgfzK3IYgur/b4ALDmeXg1k8g iHtN9JxuCW8tYaKGpXkZ1teElWrOylKatoGgSMLpOEmbxH24y4ASCpDIevfhuLcnI+qNEp7Lk7G FYg5gRB57uRmLgqTFe1cDbDRJF05mEvW9Dxnz0sAL39kbIRl7r36jmSTI11hmJyl/7R4exMvXkP wCPAaYSTFbkph05w+CuWQM1n9UwtWkyzJEuhwMZvsLrr4DBF3vwda04hgikq2B1zJ+vzDqf6drC 94QWVnii2Cc4tTg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

From: Paolo Abeni <pabeni@redhat.com>

The local address id is accessed lockless by the NL PM, add
all the required ONCE annotation. There is a caveat: the local
id can be initialized late in the subflow life-cycle, and its
validity is controlled by the local_id_valid flag.

Remove such flag and encode the validity in the local_id field
itself with negative value before initialization. That allows
accessing the field consistently with a single read operation.

Fixes: 0ee4261a3681 ("mptcp: implement mptcp_pm_remove_subflow")
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
(cherry picked from commit a7cfe776637004a4c938fde78be4bd608c32c3ef)
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Notes:
 - conflicts in protocol.h, because:
   - an '__unused' variable is not in v6.1, introduced later in commit
     dfc8d0603033 ("mptcp: implement delayed seq generation for passive
     fastopen"): we don't need to decrement the bit counters, that's OK.
   - the context around 'local_id' has been modified in commit
     b3ea6b272d79 ("mptcp: consolidate initial ack seq generation"), but
     that's unrelated, we just need to modify 'local_id' here.
---
 net/mptcp/diag.c         |  2 +-
 net/mptcp/pm_netlink.c   |  6 +++---
 net/mptcp/pm_userspace.c |  2 +-
 net/mptcp/protocol.c     |  2 +-
 net/mptcp/protocol.h     | 13 +++++++++++--
 net/mptcp/subflow.c      |  9 +++++----
 6 files changed, 22 insertions(+), 12 deletions(-)

diff --git a/net/mptcp/diag.c b/net/mptcp/diag.c
index e57c5f47f035..6ff6f14674aa 100644
--- a/net/mptcp/diag.c
+++ b/net/mptcp/diag.c
@@ -65,7 +65,7 @@ static int subflow_get_info(struct sock *sk, struct sk_buff *skb)
 			sf->map_data_len) ||
 	    nla_put_u32(skb, MPTCP_SUBFLOW_ATTR_FLAGS, flags) ||
 	    nla_put_u8(skb, MPTCP_SUBFLOW_ATTR_ID_REM, sf->remote_id) ||
-	    nla_put_u8(skb, MPTCP_SUBFLOW_ATTR_ID_LOC, sf->local_id)) {
+	    nla_put_u8(skb, MPTCP_SUBFLOW_ATTR_ID_LOC, subflow_get_local_id(sf))) {
 		err = -EMSGSIZE;
 		goto nla_failure;
 	}
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 70a1025f093c..3632f4830420 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -799,7 +799,7 @@ static void mptcp_pm_nl_rm_addr_or_subflow(struct mptcp_sock *msk,
 		mptcp_for_each_subflow_safe(msk, subflow, tmp) {
 			struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 			int how = RCV_SHUTDOWN | SEND_SHUTDOWN;
-			u8 id = subflow->local_id;
+			u8 id = subflow_get_local_id(subflow);
 
 			if (rm_type == MPTCP_MIB_RMADDR && subflow->remote_id != rm_id)
 				continue;
@@ -808,7 +808,7 @@ static void mptcp_pm_nl_rm_addr_or_subflow(struct mptcp_sock *msk,
 
 			pr_debug(" -> %s rm_list_ids[%d]=%u local_id=%u remote_id=%u mpc_id=%u",
 				 rm_type == MPTCP_MIB_RMADDR ? "address" : "subflow",
-				 i, rm_id, subflow->local_id, subflow->remote_id,
+				 i, rm_id, id, subflow->remote_id,
 				 msk->mpc_endpoint_id);
 			spin_unlock_bh(&msk->pm.lock);
 			mptcp_subflow_shutdown(sk, ssk, how);
@@ -2028,7 +2028,7 @@ static int mptcp_event_add_subflow(struct sk_buff *skb, const struct sock *ssk)
 	if (WARN_ON_ONCE(!sf))
 		return -EINVAL;
 
-	if (nla_put_u8(skb, MPTCP_ATTR_LOC_ID, sf->local_id))
+	if (nla_put_u8(skb, MPTCP_ATTR_LOC_ID, subflow_get_local_id(sf)))
 		return -EMSGSIZE;
 
 	if (nla_put_u8(skb, MPTCP_ATTR_REM_ID, sf->remote_id))
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 631fa104617c..67eccc141a6c 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -233,7 +233,7 @@ static int mptcp_userspace_pm_remove_id_zero_address(struct mptcp_sock *msk,
 
 	lock_sock(sk);
 	mptcp_for_each_subflow(msk, subflow) {
-		if (subflow->local_id == 0) {
+		if (READ_ONCE(subflow->local_id) == 0) {
 			has_id_0 = true;
 			break;
 		}
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 859b18cb8e4f..cdabb00648bd 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -119,7 +119,7 @@ static int __mptcp_socket_create(struct mptcp_sock *msk)
 	subflow->request_mptcp = 1;
 
 	/* This is the first subflow, always with id 0 */
-	subflow->local_id_valid = 1;
+	WRITE_ONCE(subflow->local_id, 0);
 	mptcp_sock_graft(msk->first, sk->sk_socket);
 
 	return 0;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index b09220521323..2bc37773e780 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -475,7 +475,6 @@ struct mptcp_subflow_context {
 		can_ack : 1,        /* only after processing the remote a key */
 		disposable : 1,	    /* ctx can be free at ulp release time */
 		stale : 1,	    /* unable to snd/rcv data, do not use for xmit */
-		local_id_valid : 1, /* local_id is correctly initialized */
 		valid_csum_seen : 1;        /* at least one csum validated */
 	enum mptcp_data_avail data_avail;
 	u32	remote_nonce;
@@ -483,7 +482,7 @@ struct mptcp_subflow_context {
 	u32	local_nonce;
 	u32	remote_token;
 	u8	hmac[MPTCPOPT_HMAC_LEN];
-	u8	local_id;
+	s16	local_id;	    /* if negative not initialized yet */
 	u8	remote_id;
 	u8	reset_seen:1;
 	u8	reset_transient:1;
@@ -529,6 +528,7 @@ mptcp_subflow_ctx_reset(struct mptcp_subflow_context *subflow)
 {
 	memset(&subflow->reset, 0, sizeof(subflow->reset));
 	subflow->request_mptcp = 1;
+	WRITE_ONCE(subflow->local_id, -1);
 }
 
 static inline u64
@@ -909,6 +909,15 @@ bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
 int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc);
 int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
 
+static inline u8 subflow_get_local_id(const struct mptcp_subflow_context *subflow)
+{
+	int local_id = READ_ONCE(subflow->local_id);
+
+	if (local_id < 0)
+		return 0;
+	return local_id;
+}
+
 void __init mptcp_pm_nl_init(void);
 void mptcp_pm_nl_work(struct mptcp_sock *msk);
 void mptcp_pm_nl_rm_subflow_received(struct mptcp_sock *msk,
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 45d20e20cfc0..83bc438b9825 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -489,8 +489,8 @@ static void subflow_finish_connect(struct sock *sk, const struct sk_buff *skb)
 
 static void subflow_set_local_id(struct mptcp_subflow_context *subflow, int local_id)
 {
-	subflow->local_id = local_id;
-	subflow->local_id_valid = 1;
+	WARN_ON_ONCE(local_id < 0 || local_id > 255);
+	WRITE_ONCE(subflow->local_id, local_id);
 }
 
 static int subflow_chk_local_id(struct sock *sk)
@@ -499,7 +499,7 @@ static int subflow_chk_local_id(struct sock *sk)
 	struct mptcp_sock *msk = mptcp_sk(subflow->conn);
 	int err;
 
-	if (likely(subflow->local_id_valid))
+	if (likely(subflow->local_id >= 0))
 		return 0;
 
 	err = mptcp_pm_get_local_id(msk, (struct sock_common *)sk);
@@ -1630,6 +1630,7 @@ static struct mptcp_subflow_context *subflow_create_ctx(struct sock *sk,
 	pr_debug("subflow=%p", ctx);
 
 	ctx->tcp_sock = sk;
+	WRITE_ONCE(ctx->local_id, -1);
 
 	return ctx;
 }
@@ -1867,7 +1868,7 @@ static void subflow_ulp_clone(const struct request_sock *req,
 		new_ctx->idsn = subflow_req->idsn;
 
 		/* this is the first subflow, id is always 0 */
-		new_ctx->local_id_valid = 1;
+		subflow_set_local_id(new_ctx, 0);
 	} else if (subflow_req->mp_join) {
 		new_ctx->ssn_offset = subflow_req->ssn_offset;
 		new_ctx->mp_join = 1;
-- 
2.43.0


