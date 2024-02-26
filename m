Return-Path: <stable+bounces-23694-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B22A0867644
	for <lists+stable@lfdr.de>; Mon, 26 Feb 2024 14:17:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F1FF1F2961E
	for <lists+stable@lfdr.de>; Mon, 26 Feb 2024 13:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 917681272AE;
	Mon, 26 Feb 2024 13:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Wfo71Spp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52211126F1A
	for <stable@vger.kernel.org>; Mon, 26 Feb 2024 13:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708953444; cv=none; b=iC6Hz4TyJR/D/JZ3A6uoc4ifaoIluviFVbJP/gBb9h4DDx770JEu/hxeiP+JINdXktROyHiqoTsK2s7qTrd9TS5mNkktkOZAIvgAkBcEciTooPyQ/58jNogWNMfYBCU1GMGqyE8BqU1J+A9HYqUfcqfpai5ELHa9WEpEH00se4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708953444; c=relaxed/simple;
	bh=112sRDahYrmJuCUnKQfejUKTX9jmavhvFV2rvk1Tt2s=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=VR+Ywwbc7ABRnpcQvlOUVdj1gMNgEbQDAN8BRlS62FZd0Vyt5WxAauglWq8/Mb4Ed1jjYS+zqF394JQygBvYK6memb0o/dj2PH6Zohwm7AafbuS3rypQBlNLHcAeNt0WtVDlmwdoIAuOsDUEz0JCTtZJaRDBrKVcexmdRtMwwVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Wfo71Spp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D10C0C433F1;
	Mon, 26 Feb 2024 13:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708953444;
	bh=112sRDahYrmJuCUnKQfejUKTX9jmavhvFV2rvk1Tt2s=;
	h=Subject:To:Cc:From:Date:From;
	b=Wfo71SppPRJ1n4/izuL/o9OvBX/fiwr42qT3O6zoOPmcrqMLKQAVXlZHXXktGSB5J
	 FJnmleqgk1ihxXsdohHK3HdKX2g/cmDeV56kT2TDreJxnZNzF9P5t2WA+S7Z0t9cHX
	 CylS0ASdGWIv3iIFQwCP7tu05gmaNvCrn/A6cRZQ=
Subject: FAILED: patch "[PATCH] mptcp: fix data races on local_id" failed to apply to 5.10-stable tree
To: pabeni@redhat.com,davem@davemloft.net,martineau@kernel.org,matttbe@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 26 Feb 2024 14:17:11 +0100
Message-ID: <2024022611-duh-rising-d12e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x a7cfe776637004a4c938fde78be4bd608c32c3ef
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024022611-duh-rising-d12e@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

a7cfe7766370 ("mptcp: fix data races on local_id")
84c531f54ad9 ("mptcp: userspace pm send RM_ADDR for ID 0")
f1f26512a9bf ("mptcp: use plain bool instead of custom binary enum")
1e07938e29c5 ("net: mptcp: rename netlink handlers to mptcp_pm_nl_<blah>_{doit,dumpit}")
1d0507f46843 ("net: mptcp: convert netlink from small_ops to ops")
fce68b03086f ("mptcp: add scheduled in mptcp_subflow_context")
1730b2b2c5a5 ("mptcp: add sched in mptcp_sock")
740ebe35bd3f ("mptcp: add struct mptcp_sched_ops")
a7384f391875 ("Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a7cfe776637004a4c938fde78be4bd608c32c3ef Mon Sep 17 00:00:00 2001
From: Paolo Abeni <pabeni@redhat.com>
Date: Thu, 15 Feb 2024 19:25:31 +0100
Subject: [PATCH] mptcp: fix data races on local_id

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
index a24c9128dee9..912e25077437 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -800,7 +800,7 @@ static void mptcp_pm_nl_rm_addr_or_subflow(struct mptcp_sock *msk,
 		mptcp_for_each_subflow_safe(msk, subflow, tmp) {
 			struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 			int how = RCV_SHUTDOWN | SEND_SHUTDOWN;
-			u8 id = subflow->local_id;
+			u8 id = subflow_get_local_id(subflow);
 
 			if (rm_type == MPTCP_MIB_RMADDR && subflow->remote_id != rm_id)
 				continue;
@@ -809,7 +809,7 @@ static void mptcp_pm_nl_rm_addr_or_subflow(struct mptcp_sock *msk,
 
 			pr_debug(" -> %s rm_list_ids[%d]=%u local_id=%u remote_id=%u mpc_id=%u",
 				 rm_type == MPTCP_MIB_RMADDR ? "address" : "subflow",
-				 i, rm_id, subflow->local_id, subflow->remote_id,
+				 i, rm_id, id, subflow->remote_id,
 				 msk->mpc_endpoint_id);
 			spin_unlock_bh(&msk->pm.lock);
 			mptcp_subflow_shutdown(sk, ssk, how);
@@ -1994,7 +1994,7 @@ static int mptcp_event_add_subflow(struct sk_buff *skb, const struct sock *ssk)
 	if (WARN_ON_ONCE(!sf))
 		return -EINVAL;
 
-	if (nla_put_u8(skb, MPTCP_ATTR_LOC_ID, sf->local_id))
+	if (nla_put_u8(skb, MPTCP_ATTR_LOC_ID, subflow_get_local_id(sf)))
 		return -EMSGSIZE;
 
 	if (nla_put_u8(skb, MPTCP_ATTR_REM_ID, sf->remote_id))
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index e582b3b2d174..d396a5973429 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -234,7 +234,7 @@ static int mptcp_userspace_pm_remove_id_zero_address(struct mptcp_sock *msk,
 
 	lock_sock(sk);
 	mptcp_for_each_subflow(msk, subflow) {
-		if (subflow->local_id == 0) {
+		if (READ_ONCE(subflow->local_id) == 0) {
 			has_id_0 = true;
 			break;
 		}
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 8ef2927ebca2..948606a537da 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -85,7 +85,7 @@ static int __mptcp_socket_create(struct mptcp_sock *msk)
 	subflow->subflow_id = msk->subflow_id++;
 
 	/* This is the first subflow, always with id 0 */
-	subflow->local_id_valid = 1;
+	WRITE_ONCE(subflow->local_id, 0);
 	mptcp_sock_graft(msk->first, sk->sk_socket);
 	iput(SOCK_INODE(ssock));
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index ed50f2015dc3..631a7f445f34 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -491,10 +491,9 @@ struct mptcp_subflow_context {
 		remote_key_valid : 1,        /* received the peer key from */
 		disposable : 1,	    /* ctx can be free at ulp release time */
 		stale : 1,	    /* unable to snd/rcv data, do not use for xmit */
-		local_id_valid : 1, /* local_id is correctly initialized */
 		valid_csum_seen : 1,        /* at least one csum validated */
 		is_mptfo : 1,	    /* subflow is doing TFO */
-		__unused : 9;
+		__unused : 10;
 	bool	data_avail;
 	bool	scheduled;
 	u32	remote_nonce;
@@ -505,7 +504,7 @@ struct mptcp_subflow_context {
 		u8	hmac[MPTCPOPT_HMAC_LEN]; /* MPJ subflow only */
 		u64	iasn;	    /* initial ack sequence number, MPC subflows only */
 	};
-	u8	local_id;
+	s16	local_id;	    /* if negative not initialized yet */
 	u8	remote_id;
 	u8	reset_seen:1;
 	u8	reset_transient:1;
@@ -556,6 +555,7 @@ mptcp_subflow_ctx_reset(struct mptcp_subflow_context *subflow)
 {
 	memset(&subflow->reset, 0, sizeof(subflow->reset));
 	subflow->request_mptcp = 1;
+	WRITE_ONCE(subflow->local_id, -1);
 }
 
 static inline u64
@@ -1022,6 +1022,15 @@ int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc);
 int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
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
index c34ecadee120..015184bbf06c 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -577,8 +577,8 @@ static void subflow_finish_connect(struct sock *sk, const struct sk_buff *skb)
 
 static void subflow_set_local_id(struct mptcp_subflow_context *subflow, int local_id)
 {
-	subflow->local_id = local_id;
-	subflow->local_id_valid = 1;
+	WARN_ON_ONCE(local_id < 0 || local_id > 255);
+	WRITE_ONCE(subflow->local_id, local_id);
 }
 
 static int subflow_chk_local_id(struct sock *sk)
@@ -587,7 +587,7 @@ static int subflow_chk_local_id(struct sock *sk)
 	struct mptcp_sock *msk = mptcp_sk(subflow->conn);
 	int err;
 
-	if (likely(subflow->local_id_valid))
+	if (likely(subflow->local_id >= 0))
 		return 0;
 
 	err = mptcp_pm_get_local_id(msk, (struct sock_common *)sk);
@@ -1731,6 +1731,7 @@ static struct mptcp_subflow_context *subflow_create_ctx(struct sock *sk,
 	pr_debug("subflow=%p", ctx);
 
 	ctx->tcp_sock = sk;
+	WRITE_ONCE(ctx->local_id, -1);
 
 	return ctx;
 }
@@ -1966,7 +1967,7 @@ static void subflow_ulp_clone(const struct request_sock *req,
 		new_ctx->idsn = subflow_req->idsn;
 
 		/* this is the first subflow, id is always 0 */
-		new_ctx->local_id_valid = 1;
+		subflow_set_local_id(new_ctx, 0);
 	} else if (subflow_req->mp_join) {
 		new_ctx->ssn_offset = subflow_req->ssn_offset;
 		new_ctx->mp_join = 1;


