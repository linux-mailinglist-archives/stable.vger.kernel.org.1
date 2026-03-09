Return-Path: <stable+bounces-223688-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2M0mLjjmrmmsJwIAu9opvQ
	(envelope-from <stable+bounces-223688-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 16:24:40 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 59F7F23B96D
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 16:24:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 64BFD3012D16
	for <lists+stable@lfdr.de>; Mon,  9 Mar 2026 15:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D3913D9048;
	Mon,  9 Mar 2026 15:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nPMdMG6u"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC153D75D2
	for <stable@vger.kernel.org>; Mon,  9 Mar 2026 15:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773069864; cv=none; b=U8V3RdNq6YEhnxb+6gB+0O/FWnyOHskLBqJS2lsxkv0Ag/cgMYXvSK3ESgeSHFFioQsILSNbjrouuhAj85Aq3hTYStv0UZytOevN92n9hVQvdQwY8pXUlX7ysK7wOXfT9Lao5Npdto9q+/ohXMuZCSF6maTWGtxD7o4NckNV+Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773069864; c=relaxed/simple;
	bh=DpC95LEZ3PbFopiij8oraOckRlN1070hXVE25r0nDno=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B3/09x08r9RgpemrjQW0H/1GKkC8grNe1QTMTQ1YO35S8c4btFYwfvo/Sj01iPVZLqZ2C4dyLhiXC9y+WPvAo/1uXgALwfV1RQeUY5QSim7h8Ozd6W9LvNEUc1H/ke6axsAwiJXIk/vW8l4gUrr2iWFbqEaE0kWTmY5POU3S9s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nPMdMG6u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F8ECC4CEF7;
	Mon,  9 Mar 2026 15:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773069863;
	bh=DpC95LEZ3PbFopiij8oraOckRlN1070hXVE25r0nDno=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nPMdMG6u8xWaCiSaW+MFOd3241WxkDYn4932WkjxrukMU2HLJ94COkNiOg1PlQfaf
	 O5Q2jFTnE1XvwPtA5dyH6S6xXw0gxPN71KiL6z/N1N9Fcroy4WjV6qOiTMecTE7lBw
	 xbkWuZ5w0xD+506llGnq3L3x8C4lkMZoPLGEs8ZhayXgNOdvbq/uXibpp9Qdx5k1oJ
	 vha/NySDmdIcBi7OmDbehMrpw6wp0BuEMEyTT3D4Zw3xkWfHNKUQycf5sJjI2JnJgY
	 2b2Qjlr6BdIJQ04b3WzxuDo/jOEWl5igOIjHswT96uqJSD5smpv213psDcLg+Gf0kI
	 j4UOozFuri3Ug==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Frank Lorenz <lorenz-frank@web.de>,
	Mat Martineau <martineau@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] mptcp: pm: avoid sending RM_ADDR over same subflow
Date: Mon,  9 Mar 2026 11:24:20 -0400
Message-ID: <20260309152420.1280295-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026030906-bullish-enjoying-edba@gregkh>
References: <2026030906-bullish-enjoying-edba@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 59F7F23B96D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,web.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-223688-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.992];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
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
index f1a8ae7a5af4f..c5131529e1587 100644
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
index 293ec3448f52c..f3b1e9f685898 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -850,9 +850,23 @@ bool mptcp_pm_nl_is_init_remote_addr(struct mptcp_sock *msk,
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
@@ -862,11 +876,30 @@ void mptcp_pm_nl_addr_send_ack(struct mptcp_sock *msk)
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
index dd5070d57d740..329071f6b9e17 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -818,6 +818,8 @@ void mptcp_pm_add_addr_send_ack(struct mptcp_sock *msk);
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


