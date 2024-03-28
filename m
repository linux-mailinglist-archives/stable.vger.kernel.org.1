Return-Path: <stable+bounces-26489-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B77B870ED6
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 22:47:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 093B31F21F3E
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 21:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67C2C200CD;
	Mon,  4 Mar 2024 21:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UTRNR60c"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240381F92C;
	Mon,  4 Mar 2024 21:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709588850; cv=none; b=MAUIGIxx3kw4tW/lbfQe+JBs4D03SDVd+Rswu8iT18sPqZLyqLub4aeodYneI6jamscdXS7H+JAFLrnAqBBplPcFhdBzEHaFjR6w4dH2peFLHshJcYjmckzEnB7TOOJN9h4JBYxK5XCz6vTnxvcj0E3EKJOKIyIflXTFSeWAccY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709588850; c=relaxed/simple;
	bh=NPyYtvvqTbc7x3cU7RHJ14tdLI1oew6Ee/w1tRtQNms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tBcndy3CiUsRmg0+4m6FMVuY6R/8WirFecKqffwV4Up0lghGi9eCd1uu0CpO4Zvc2KtMBek5ovCYW+eggiXBBtXKbzZN1NhyAwQoeb+Y4CyPryBkElBDbxiEA5WS+X+XmWI69DZLHTbOic8lMJdW46VeCZC+vZHb9Aa0iHRJUfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UTRNR60c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0F97C433F1;
	Mon,  4 Mar 2024 21:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709588850;
	bh=NPyYtvvqTbc7x3cU7RHJ14tdLI1oew6Ee/w1tRtQNms=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UTRNR60csoTqILKf79/vgIZfh6n53OmalIf5Ttn0MixPGZrkohp3eGOexw+18MAl/
	 8UVW5hSEkZZvaGQ0dbQEaekYJSeyHp8BnRxUOjoVJlifDxMq7Rwse16TTQo+iVJ4hI
	 ojtwdltIvM1xy5SjSaAQpkOrE3ke0V0SxIwqY5/A=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Paolo Abeni <pabeni@redhat.com>,
	Mat Martineau <martineau@kernel.org>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 6.1 097/215] mptcp: fix data races on local_id
Date: Mon,  4 Mar 2024 21:22:40 +0000
Message-ID: <20240304211600.110155297@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240304211556.993132804@linuxfoundation.org>
References: <20240304211556.993132804@linuxfoundation.org>
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

From: Paolo Abeni <pabeni@redhat.com>

commit a7cfe776637004a4c938fde78be4bd608c32c3ef upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---

---
 net/mptcp/diag.c         |    2 +-
 net/mptcp/pm_netlink.c   |    6 +++---
 net/mptcp/pm_userspace.c |    2 +-
 net/mptcp/protocol.c     |    2 +-
 net/mptcp/protocol.h     |   13 +++++++++++--
 net/mptcp/subflow.c      |    9 +++++----
 6 files changed, 22 insertions(+), 12 deletions(-)

--- a/net/mptcp/diag.c
+++ b/net/mptcp/diag.c
@@ -65,7 +65,7 @@ static int subflow_get_info(struct sock
 			sf->map_data_len) ||
 	    nla_put_u32(skb, MPTCP_SUBFLOW_ATTR_FLAGS, flags) ||
 	    nla_put_u8(skb, MPTCP_SUBFLOW_ATTR_ID_REM, sf->remote_id) ||
-	    nla_put_u8(skb, MPTCP_SUBFLOW_ATTR_ID_LOC, sf->local_id)) {
+	    nla_put_u8(skb, MPTCP_SUBFLOW_ATTR_ID_LOC, subflow_get_local_id(sf))) {
 		err = -EMSGSIZE;
 		goto nla_failure;
 	}
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -799,7 +799,7 @@ static void mptcp_pm_nl_rm_addr_or_subfl
 		mptcp_for_each_subflow_safe(msk, subflow, tmp) {
 			struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 			int how = RCV_SHUTDOWN | SEND_SHUTDOWN;
-			u8 id = subflow->local_id;
+			u8 id = subflow_get_local_id(subflow);
 
 			if (rm_type == MPTCP_MIB_RMADDR && subflow->remote_id != rm_id)
 				continue;
@@ -808,7 +808,7 @@ static void mptcp_pm_nl_rm_addr_or_subfl
 
 			pr_debug(" -> %s rm_list_ids[%d]=%u local_id=%u remote_id=%u mpc_id=%u",
 				 rm_type == MPTCP_MIB_RMADDR ? "address" : "subflow",
-				 i, rm_id, subflow->local_id, subflow->remote_id,
+				 i, rm_id, id, subflow->remote_id,
 				 msk->mpc_endpoint_id);
 			spin_unlock_bh(&msk->pm.lock);
 			mptcp_subflow_shutdown(sk, ssk, how);
@@ -2028,7 +2028,7 @@ static int mptcp_event_add_subflow(struc
 	if (WARN_ON_ONCE(!sf))
 		return -EINVAL;
 
-	if (nla_put_u8(skb, MPTCP_ATTR_LOC_ID, sf->local_id))
+	if (nla_put_u8(skb, MPTCP_ATTR_LOC_ID, subflow_get_local_id(sf)))
 		return -EMSGSIZE;
 
 	if (nla_put_u8(skb, MPTCP_ATTR_REM_ID, sf->remote_id))
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -233,7 +233,7 @@ static int mptcp_userspace_pm_remove_id_
 
 	lock_sock(sk);
 	mptcp_for_each_subflow(msk, subflow) {
-		if (subflow->local_id == 0) {
+		if (READ_ONCE(subflow->local_id) == 0) {
 			has_id_0 = true;
 			break;
 		}
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -119,7 +119,7 @@ static int __mptcp_socket_create(struct
 	subflow->request_mptcp = 1;
 
 	/* This is the first subflow, always with id 0 */
-	subflow->local_id_valid = 1;
+	WRITE_ONCE(subflow->local_id, 0);
 	mptcp_sock_graft(msk->first, sk->sk_socket);
 
 	return 0;
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
@@ -529,6 +528,7 @@ mptcp_subflow_ctx_reset(struct mptcp_sub
 {
 	memset(&subflow->reset, 0, sizeof(subflow->reset));
 	subflow->request_mptcp = 1;
+	WRITE_ONCE(subflow->local_id, -1);
 }
 
 static inline u64
@@ -909,6 +909,15 @@ bool mptcp_pm_rm_addr_signal(struct mptc
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
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -489,8 +489,8 @@ do_reset:
 
 static void subflow_set_local_id(struct mptcp_subflow_context *subflow, int local_id)
 {
-	subflow->local_id = local_id;
-	subflow->local_id_valid = 1;
+	WARN_ON_ONCE(local_id < 0 || local_id > 255);
+	WRITE_ONCE(subflow->local_id, local_id);
 }
 
 static int subflow_chk_local_id(struct sock *sk)
@@ -499,7 +499,7 @@ static int subflow_chk_local_id(struct s
 	struct mptcp_sock *msk = mptcp_sk(subflow->conn);
 	int err;
 
-	if (likely(subflow->local_id_valid))
+	if (likely(subflow->local_id >= 0))
 		return 0;
 
 	err = mptcp_pm_get_local_id(msk, (struct sock_common *)sk);
@@ -1630,6 +1630,7 @@ static struct mptcp_subflow_context *sub
 	pr_debug("subflow=%p", ctx);
 
 	ctx->tcp_sock = sk;
+	WRITE_ONCE(ctx->local_id, -1);
 
 	return ctx;
 }
@@ -1867,7 +1868,7 @@ static void subflow_ulp_clone(const stru
 		new_ctx->idsn = subflow_req->idsn;
 
 		/* this is the first subflow, id is always 0 */
-		new_ctx->local_id_valid = 1;
+		subflow_set_local_id(new_ctx, 0);
 	} else if (subflow_req->mp_join) {
 		new_ctx->ssn_offset = subflow_req->ssn_offset;
 		new_ctx->mp_join = 1;



