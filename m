Return-Path: <stable+bounces-223686-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8BOpORPmrmmsJwIAu9opvQ
	(envelope-from <stable+bounces-223686-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 16:24:03 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6418523B94E
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 16:24:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7F757305F4D8
	for <lists+stable@lfdr.de>; Mon,  9 Mar 2026 15:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 237163D3013;
	Mon,  9 Mar 2026 15:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eCHgoObc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E9B3CE4B2
	for <stable@vger.kernel.org>; Mon,  9 Mar 2026 15:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773069525; cv=none; b=fxyH7fYIqye8+07yUWY8r3T4iTLYXunsOtpr905pWuij2rXU9nYdrZNfw6XfxrouFmDYJdY2kxCpgnYajBbqahqsF0Clw8dqe3tKDi9hsGBpXxs/l3vjaJp3L7tH+vrbXPx7rKK4dm8ehxcoL4yAXky4N/9WRMtRxuR3Xp/v+MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773069525; c=relaxed/simple;
	bh=ETpyohwT2IFQkX8A7LPiE8MIQ/5O1c0uDviSbvSoRLY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XTua72RlSK0L2Mrbxzb5NJvHpReoLXn0sdr9Q3pkk3VBCc8WpPR0zanxZgRzAe4Nw6Q/OktxC3EvbWMRy1XhOgcaT9HJGXM61JWuuGc0vf2aLEcS7LjSVM2K52IGRvlJ7bJZxIl93aj5BqXs+CNUL5Baq8G4S3QbF9ZQrwaXf6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eCHgoObc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03492C2BCAF;
	Mon,  9 Mar 2026 15:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773069525;
	bh=ETpyohwT2IFQkX8A7LPiE8MIQ/5O1c0uDviSbvSoRLY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eCHgoObc0jDO4yzds1vFCHPIT1+uDjVNMQSsZmcJ58cjzJHG+HDwop2iZsWQQAjxY
	 gsUoAllYhA8Sfjotpax7AdHNI+abLPN6JmTt5ZbzwadNMyKfzT68qAaIKxHKbsHB3w
	 MFXA+CY5hKDe3pcPNIbjiuHUuG6/WvoTMpMTPENfOf82Z2HdtQIHwDaUMLHr2YZdXL
	 EsPDIGEp/TsPyzkma/ZKcwN9A3pHflXDMYILNOQ+xGDwKRafIhEeHxGSn+B8OflNjT
	 tO/qJ+Qccd1Mt9C2K8n1tLQf21g03nYwUYKyXHDfuhYGKLWzFKH54XtuOOdqb4N67r
	 OneUzeTTQWxUw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Frank Lorenz <lorenz-frank@web.de>,
	Mat Martineau <martineau@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] mptcp: pm: avoid sending RM_ADDR over same subflow
Date: Mon,  9 Mar 2026 11:18:43 -0400
Message-ID: <20260309151843.1264861-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026030905-alkaline-earphone-b901@gregkh>
References: <2026030905-alkaline-earphone-b901@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6418523B94E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,web.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-223686-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,msgid.link:url]
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
index ab7bdb6531816..8778a7211e4c5 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -57,7 +57,7 @@ int mptcp_pm_remove_addr(struct mptcp_sock *msk, const struct mptcp_rm_list *rm_
 	msk->pm.rm_list_tx = *rm_list;
 	rm_addr |= BIT(MPTCP_RM_ADDR_SIGNAL);
 	WRITE_ONCE(msk->pm.addr_signal, rm_addr);
-	mptcp_pm_nl_addr_send_ack(msk);
+	mptcp_pm_nl_addr_send_ack_avoid_list(msk, rm_list);
 	return 0;
 }
 
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 4b805d7f5769f..a0d4a0cc8a825 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -849,9 +849,23 @@ bool mptcp_pm_nl_is_init_remote_addr(struct mptcp_sock *msk,
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
@@ -861,11 +875,30 @@ void mptcp_pm_nl_addr_send_ack(struct mptcp_sock *msk)
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
index 58805fbf1f961..93be4c0432d1c 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -932,6 +932,8 @@ void mptcp_pm_add_addr_send_ack(struct mptcp_sock *msk);
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


