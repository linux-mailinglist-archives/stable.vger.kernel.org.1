Return-Path: <stable+bounces-223681-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eGkpDuLgrmmoJgIAu9opvQ
	(envelope-from <stable+bounces-223681-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 16:01:54 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E215C23B2DB
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 16:01:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 66F48305D495
	for <lists+stable@lfdr.de>; Mon,  9 Mar 2026 14:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D7831465B4;
	Mon,  9 Mar 2026 14:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IqillTTX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317983D332F
	for <stable@vger.kernel.org>; Mon,  9 Mar 2026 14:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773068263; cv=none; b=amUwNgaW92HEOz5rewvR2Qxz4r5k7X9x+I8vu4DTwIjZqmXSdvLzUDkh9Hq1hQA3NPt+ilqNLhjbZN2K2VRbE5FYfw3rf2VL1y6dBHxyf9qEa5msS/zgyMEY2fCiqygu9RNrjMof2COYU9Yyl5a2UCQODw7tAGDXp6w49r1SRMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773068263; c=relaxed/simple;
	bh=k9KBjiqE8VqGdHYgSEeDRaGDv/UeHi6JSSuooHvuvGo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uAjZylPVQe4Zqru0NuoIg77EYSpMBAczhVy8LpI2r0fmw//Fz0DHmmVAo50BMJgd/M3bvwMvkBIqnFobV4HCfMOMpF6A9a4WuAuBLA9+Ri/aYWpRifbc3ahiBUaAXqJQOSRT1AujwelcsRJ4/p2c0A66j4CutyNtYLUZg9x8IQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IqillTTX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13105C4CEF7;
	Mon,  9 Mar 2026 14:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773068262;
	bh=k9KBjiqE8VqGdHYgSEeDRaGDv/UeHi6JSSuooHvuvGo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IqillTTX3M+lhbGCtNUAXzXQmFO6NIYMXlid+O/8tuGyMgT5GKDmBEF7J4Q54yPHh
	 FKeBaMWcu72y/cqrx0yxYkNp8xyp1dHYHJtBSrMRT1suy/LX9tOPcybUYTLPmYVKQU
	 KBMDhLf7LVDWRTpxsbVvJLkvVlz8LEHxPSWAVF7v+FNx13nQY8pbXeD/JB+4wuHzNX
	 oOQ8q+eMXloy7vaKE3wzj1SQ1vYAj+leug5n6VMvvZ+upR5cXrPnLbvnlXtKoCEfMG
	 XEMJ8uojkF95bhxj/Q8CNMknMu7ZOOd0oZVA0ygxHUlAY8GWaJBjy4GJfOJQr0MUJb
	 QFAy1jlpvp63w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Frank Lorenz <lorenz-frank@web.de>,
	Mat Martineau <martineau@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] mptcp: pm: avoid sending RM_ADDR over same subflow
Date: Mon,  9 Mar 2026 10:57:40 -0400
Message-ID: <20260309145740.1231220-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026030905-henchman-oxidant-c129@gregkh>
References: <2026030905-henchman-oxidant-c129@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E215C23B2DB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RSPAMD_URIBL_FAIL(0.00)[msgid.link:query timed out];
	TAGGED_FROM(0.00)[bounces-223681-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,web.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
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
	RSPAMD_EMAILBL_FAIL(0.00)[kuba.kernel.org:query timed out];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,msgid.link:url]
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
[ adapted to _nl-prefixed function names in pm_netlink.c and omitted stale subflow fallback ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mptcp/pm.c         |  2 +-
 net/mptcp/pm_netlink.c | 43 +++++++++++++++++++++++++++++++++++++-----
 net/mptcp/protocol.h   |  2 ++
 3 files changed, 41 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 1b7541206a70b..8d2c27c43ee0b 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -56,7 +56,7 @@ int mptcp_pm_remove_addr(struct mptcp_sock *msk, const struct mptcp_rm_list *rm_
 	msk->pm.rm_list_tx = *rm_list;
 	rm_addr |= BIT(MPTCP_RM_ADDR_SIGNAL);
 	WRITE_ONCE(msk->pm.addr_signal, rm_addr);
-	mptcp_pm_nl_addr_send_ack(msk);
+	mptcp_pm_nl_addr_send_ack_avoid_list(msk, rm_list);
 	return 0;
 }
 
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 864c26e22b24f..abd4db6ba34fe 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -846,9 +846,23 @@ bool mptcp_pm_nl_is_init_remote_addr(struct mptcp_sock *msk,
 	return mptcp_addresses_equal(&mpc_remote, remote, remote->port);
 }
 
-void mptcp_pm_nl_addr_send_ack(struct mptcp_sock *msk)
+static bool subflow_in_rm_list(const struct mptcp_subflow_context *subflow,
+			       const struct mptcp_rm_list *rm_list)
 {
-	struct mptcp_subflow_context *subflow;
+	u8 i, id = subflow_get_local_id(subflow);
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
@@ -858,11 +872,30 @@ void mptcp_pm_nl_addr_send_ack(struct mptcp_sock *msk)
 		return;
 
 	mptcp_for_each_subflow(msk, subflow) {
-		if (__mptcp_subflow_active(subflow)) {
-			mptcp_pm_send_ack(msk, subflow, false, false);
-			break;
+		if (!__mptcp_subflow_active(subflow))
+			continue;
+
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
+	mptcp_pm_send_ack(msk, subflow, false, false);
+}
+
+void mptcp_pm_nl_addr_send_ack(struct mptcp_sock *msk)
+{
+	mptcp_pm_nl_addr_send_ack_avoid_list(msk, NULL);
 }
 
 int mptcp_pm_nl_mp_prio_send_ack(struct mptcp_sock *msk,
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index b266002660d70..669991bbae75f 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1029,6 +1029,8 @@ void mptcp_pm_add_addr_send_ack(struct mptcp_sock *msk);
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


