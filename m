Return-Path: <stable+bounces-223697-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UKqbFIzzrmnZKgIAu9opvQ
	(envelope-from <stable+bounces-223697-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 17:21:32 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FFA023C9FF
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 17:21:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 37008304CCC2
	for <lists+stable@lfdr.de>; Mon,  9 Mar 2026 16:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57330263C8C;
	Mon,  9 Mar 2026 16:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D3bCsWS8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B2D3B531D
	for <stable@vger.kernel.org>; Mon,  9 Mar 2026 16:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773072385; cv=none; b=FXU9NPJXHcIQjUx+YPDH75ZLUYqZRhCrddBEPEoecVj3ePP7eEagdCyEB7HCgfjeqbWgQ2AJTgykXMxA4/doiVQZrJ36FBL6kD3HC2rWrfaKTm4at95+YQ4Pfiah/HgsRvQj6otz7RBWGqUq38x2HznKVCS5r+HbEP3a5RpV8FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773072385; c=relaxed/simple;
	bh=3PpqzgjFKd5aCnuw6VZIcHkvGKkG+zeYLLYRE1Pg2mc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GGHOWqoItH01W7OWB0KLq98swvjv4D7sJhDuJ1eG7hlK3eW5KdyRPGJqjFDCoVMB1gCpc6EQ0LItQcOkDfv6PRLQdwI0IqLsQFSCqpKY5JF03qjH4w+mVcVrOOiSqB7t6i/fAtROwZVqheVnUOqxNFH+PeT6JHFcqvuVNOTOYto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D3bCsWS8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5923C4CEF7;
	Mon,  9 Mar 2026 16:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773072384;
	bh=3PpqzgjFKd5aCnuw6VZIcHkvGKkG+zeYLLYRE1Pg2mc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D3bCsWS84JCZmr02v8Y1wPUec7sTGez8lLKzjHpq8bJKvl/QqmP3XjXRyNB8nW6BG
	 0K3Ior4fKpziBj7OSK0i4nrVmkG2Me+WowJyrSVZ3IQ8CeGchx3LiJPnQx6TqAs78c
	 anv5Utb6xWZBXRacH7bEzlccDZDbzroQYw7WOhEtzmrgPDs3phUyUZKfnb2v1m0Xiz
	 bnQ/EaeHg7zeWRF/0Tv8Ea3O1EJo5EsoGcb5OyPVgN7/dDrR6rN/Bo2Z5YpaKzXMWr
	 WGypTlIZQsEjRiopghkHYcb/v2NgH5373SoPihZE0D/XT36Dyqgn2ZWbQWmWCJGSBd
	 2umb2uLxQFaEA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Frank Lorenz <lorenz-frank@web.de>,
	Mat Martineau <martineau@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] mptcp: pm: avoid sending RM_ADDR over same subflow
Date: Mon,  9 Mar 2026 12:06:22 -0400
Message-ID: <20260309160622.1298481-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026030907-payday-glaucoma-fe3b@gregkh>
References: <2026030907-payday-glaucoma-fe3b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6FFA023C9FF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,web.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-223697-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.993];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,msgid.link:url]
X-Rspamd-Action: no action

From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>

[ Upstream commit fb8d0bccb221080630efcd9660c9f9349e53cc9e ]

RM_ADDR are sent over an active subflow, the first one in the subflows
list. There is then a high chance the initial subflow is picked. With
the in-kernel PM, when an endpoint is removed, a RM_ADDR is sent, then
linked subflows are closed. This is done for each active MPTCP
connection.

MPTCP endpoints are likely removed because the attached network is no
longer available or usable. In this case, it is better to avoid sending
this RM_ADDR over the subflow that is going to be removed, but prefer
sending it over another active and non stale subflow, if any.

This modification avoids situations where the other end is not notified
when a subflow is no longer usable: typically when the endpoint linked
to the initial subflow is removed, especially on the server side.

Fixes: 8dd5efb1f91b ("mptcp: send ack for rm_addr")
Cc: stable@vger.kernel.org
Reported-by: Frank Lorenz <lorenz-frank@web.de>
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/612
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20260303-net-mptcp-misc-fixes-7-0-rc2-v1-2-4b5462b6f016@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ pm.c => pm_netlink.c + replaced subflow_get_local_id() with subflow->local_id ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mptcp/pm.c         |  2 +-
 net/mptcp/pm_netlink.c | 57 ++++++++++++++++++++++++++++++++++--------
 net/mptcp/protocol.h   |  2 ++
 3 files changed, 49 insertions(+), 12 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 737643e84ed15..d52e1d2950100 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -55,7 +55,7 @@ int mptcp_pm_remove_addr(struct mptcp_sock *msk, const struct mptcp_rm_list *rm_
 	msk->pm.rm_list_tx = *rm_list;
 	rm_addr |= BIT(MPTCP_RM_ADDR_SIGNAL);
 	WRITE_ONCE(msk->pm.addr_signal, rm_addr);
-	mptcp_pm_nl_addr_send_ack(msk);
+	mptcp_pm_nl_addr_send_ack_avoid_list(msk, rm_list);
 	return 0;
 }
 
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 1c8aabce33a6a..634fe0360c496 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -753,9 +753,23 @@ bool mptcp_pm_nl_is_init_remote_addr(struct mptcp_sock *msk,
 	return addresses_equal(&mpc_remote, remote, remote->port);
 }
 
-void mptcp_pm_nl_addr_send_ack(struct mptcp_sock *msk)
+static bool subflow_in_rm_list(const struct mptcp_subflow_context *subflow,
+			       const struct mptcp_rm_list *rm_list)
 {
-	struct mptcp_subflow_context *subflow;
+	u8 i, id = subflow->local_id;
+
+	for (i = 0; i < rm_list->nr; i++) {
+		if (rm_list->ids[i] == id)
+			return true;
+	}
+
+	return false;
+}
+
+void mptcp_pm_nl_addr_send_ack_avoid_list(struct mptcp_sock *msk,
+					  const struct mptcp_rm_list *rm_list)
+{
+	struct mptcp_subflow_context *subflow, *same_id = NULL;
 
 	msk_owned_by_me(msk);
 	lockdep_assert_held(&msk->pm.lock);
@@ -766,18 +780,39 @@ void mptcp_pm_nl_addr_send_ack(struct mptcp_sock *msk)
 
 	__mptcp_flush_join_list(msk);
 	mptcp_for_each_subflow(msk, subflow) {
-		if (__mptcp_subflow_active(subflow)) {
-			struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
-
-			spin_unlock_bh(&msk->pm.lock);
-			pr_debug("send ack for %s\n",
-				 mptcp_pm_should_add_signal(msk) ? "add_addr" : "rm_addr");
+		if (!__mptcp_subflow_active(subflow))
+			continue;
 
-			mptcp_subflow_send_ack(ssk);
-			spin_lock_bh(&msk->pm.lock);
-			break;
+		if (unlikely(rm_list &&
+			     subflow_in_rm_list(subflow, rm_list))) {
+			if (!same_id)
+				same_id = subflow;
+		} else {
+			goto send_ack;
 		}
 	}
+
+	if (same_id)
+		subflow = same_id;
+	else
+		return;
+
+send_ack:
+	{
+		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+
+		spin_unlock_bh(&msk->pm.lock);
+		pr_debug("send ack for %s\n",
+			 mptcp_pm_should_add_signal(msk) ? "add_addr" : "rm_addr");
+
+		mptcp_subflow_send_ack(ssk);
+		spin_lock_bh(&msk->pm.lock);
+	}
+}
+
+void mptcp_pm_nl_addr_send_ack(struct mptcp_sock *msk)
+{
+	mptcp_pm_nl_addr_send_ack_avoid_list(msk, NULL);
 }
 
 int mptcp_pm_nl_mp_prio_send_ack(struct mptcp_sock *msk,
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 3450c3cd015a0..0b740aa308f2c 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -753,6 +753,8 @@ void mptcp_pm_add_addr_send_ack(struct mptcp_sock *msk);
 bool mptcp_pm_nl_is_init_remote_addr(struct mptcp_sock *msk,
 				     const struct mptcp_addr_info *remote);
 void mptcp_pm_nl_addr_send_ack(struct mptcp_sock *msk);
+void mptcp_pm_nl_addr_send_ack_avoid_list(struct mptcp_sock *msk,
+					  const struct mptcp_rm_list *rm_list);
 void mptcp_pm_rm_addr_received(struct mptcp_sock *msk,
 			       const struct mptcp_rm_list *rm_list);
 void mptcp_pm_mp_prio_received(struct sock *sk, u8 bkup);
-- 
2.51.0


