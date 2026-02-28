Return-Path: <stable+bounces-220384-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iFbTFplHo2lM/AQAu9opvQ
	(envelope-from <stable+bounces-220384-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:52:57 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 82DAB1C7775
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:52:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 054BE319C420
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B565480944;
	Sat, 28 Feb 2026 17:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QpvFIPp5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19DA3A699C;
	Sat, 28 Feb 2026 17:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300278; cv=none; b=MISx5dhRt8W2NkUc13QikSYrLjZJYiynhDk+7Pyo0XEaqiyWLyUvTMJgTQQh2YI5tdLBwMWZmp4pwYncPPgqpaM3/IN72kHvhvlO5CZeRpXCLIF9QzN/drdzpcSARh8byWJXtInhtygilUivkZTx3DQQioj4aELcIoHmTNpUuXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300278; c=relaxed/simple;
	bh=+YxQHjKhLtTGO6HRhizQj9yMP6s21GyiiQzAmsMI/iI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ARaxmXfd79rbWAKlQ0gGqcu1rxXZ5uooEwGDiKA4GZ+Hfb2cIRxumrOmeULr75uk+ET2A9QkfT7yu+N1iUtNv/X2AO6rqF7CjZcay4G9kYUS6VCMQGlzd4b/3sYPnNAWydIGrepNaS2NpO574rKkaT3HpSZu9i+5mxrLkQBwsW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QpvFIPp5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A966C2BC87;
	Sat, 28 Feb 2026 17:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300277;
	bh=+YxQHjKhLtTGO6HRhizQj9yMP6s21GyiiQzAmsMI/iI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QpvFIPp5DNitKYUHrZBmCrYvQeGc49r4+kAy+rMSoJOFdm6c9yoBwhXkgbNwbu6+/
	 zI2aoukXu8CEym029RxuvVA/lOaTABsw2KOHVXZIoW5r3OcSapx/3voXzZEtDJqaCr
	 cQc3JOmOsdP13dY4UjImPHc/oF9BvS+wrHuHnEFyjsIyWrEP54unXXTP5CxJd4tGB1
	 Hw2oA9ACI1NXSZdMtF4wq3tCg3xMJvOT6633J2x21lP1duWe7uac4o46c+0JplHKCn
	 4O3EbpjgRlAU4mwUxJDUhgKY/Lxx4UWPmirx6lwiKbTKI9E5EarvJRcED1dcqkkJo3
	 F674Xmhe+RzhA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Gerd Rausch <gerd.rausch@oracle.com>,
	Allison Henderson <allison.henderson@oracle.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 305/844] net/rds: No shortcut out of RDS_CONN_ERROR
Date: Sat, 28 Feb 2026 12:23:38 -0500
Message-ID: <20260228173244.1509663-306-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220384-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,oracle.com:email]
X-Rspamd-Queue-Id: 82DAB1C7775
X-Rspamd-Action: no action

From: Gerd Rausch <gerd.rausch@oracle.com>

[ Upstream commit ad22d24be635c6beab6a1fdd3f8b1f3c478d15da ]

RDS connections carry a state "rds_conn_path::cp_state"
and transitions from one state to another and are conditional
upon an expected state: "rds_conn_path_transition."

There is one exception to this conditionality, which is
"RDS_CONN_ERROR" that can be enforced by "rds_conn_path_drop"
regardless of what state the condition is currently in.

But as soon as a connection enters state "RDS_CONN_ERROR",
the connection handling code expects it to go through the
shutdown-path.

The RDS/TCP multipath changes added a shortcut out of
"RDS_CONN_ERROR" straight back to "RDS_CONN_CONNECTING"
via "rds_tcp_accept_one_path" (e.g. after "rds_tcp_state_change").

A subsequent "rds_tcp_reset_callbacks" can then transition
the state to "RDS_CONN_RESETTING" with a shutdown-worker queued.

That'll trip up "rds_conn_init_shutdown", which was
never adjusted to handle "RDS_CONN_RESETTING" and subsequently
drops the connection with the dreaded "DR_INV_CONN_STATE",
which leaves "RDS_SHUTDOWN_WORK_QUEUED" on forever.

So we do two things here:

a) Don't shortcut "RDS_CONN_ERROR", but take the longer
   path through the shutdown code.

b) Add "RDS_CONN_RESETTING" to the expected states in
  "rds_conn_init_shutdown" so that we won't error out
  and get stuck, if we ever hit weird state transitions
  like this again."

Signed-off-by: Gerd Rausch <gerd.rausch@oracle.com>
Signed-off-by: Allison Henderson <allison.henderson@oracle.com>
Link: https://patch.msgid.link/20260122055213.83608-2-achender@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/rds/connection.c | 2 ++
 net/rds/tcp_listen.c | 5 -----
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/net/rds/connection.c b/net/rds/connection.c
index 68bc88cce84ec..ad8027e6f54ef 100644
--- a/net/rds/connection.c
+++ b/net/rds/connection.c
@@ -382,6 +382,8 @@ void rds_conn_shutdown(struct rds_conn_path *cp)
 		if (!rds_conn_path_transition(cp, RDS_CONN_UP,
 					      RDS_CONN_DISCONNECTING) &&
 		    !rds_conn_path_transition(cp, RDS_CONN_ERROR,
+					      RDS_CONN_DISCONNECTING) &&
+		    !rds_conn_path_transition(cp, RDS_CONN_RESETTING,
 					      RDS_CONN_DISCONNECTING)) {
 			rds_conn_path_error(cp,
 					    "shutdown called in state %d\n",
diff --git a/net/rds/tcp_listen.c b/net/rds/tcp_listen.c
index 820d3e20de195..27b6107ddc28d 100644
--- a/net/rds/tcp_listen.c
+++ b/net/rds/tcp_listen.c
@@ -59,9 +59,6 @@ void rds_tcp_keepalive(struct socket *sock)
  * socket and force a reconneect from smaller -> larger ip addr. The reason
  * we special case cp_index 0 is to allow the rds probe ping itself to itself
  * get through efficiently.
- * Since reconnects are only initiated from the node with the numerically
- * smaller ip address, we recycle conns in RDS_CONN_ERROR on the passive side
- * by moving them to CONNECTING in this function.
  */
 static
 struct rds_tcp_connection *rds_tcp_accept_one_path(struct rds_connection *conn)
@@ -86,8 +83,6 @@ struct rds_tcp_connection *rds_tcp_accept_one_path(struct rds_connection *conn)
 		struct rds_conn_path *cp = &conn->c_path[i];
 
 		if (rds_conn_path_transition(cp, RDS_CONN_DOWN,
-					     RDS_CONN_CONNECTING) ||
-		    rds_conn_path_transition(cp, RDS_CONN_ERROR,
 					     RDS_CONN_CONNECTING)) {
 			return cp->cp_transport_data;
 		}
-- 
2.51.0


