Return-Path: <stable+bounces-241432-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +PAGOBS/72mLFQEAu9opvQ
	(envelope-from <stable+bounces-241432-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 21:55:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 82332479911
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 21:55:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0E314300D77A
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 19:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D586D4218BC;
	Mon, 27 Apr 2026 19:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QM2unevY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896F84218A1;
	Mon, 27 Apr 2026 19:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777319686; cv=none; b=JF8k7P/cIPTEYhcC8iqvTUVzqCusP1P/6cZ/mxTSOL5nRO9L0zVJEGvkq6oo1DNnAcmCY53DaEQQXVPpPbSnwZdZZx6LesFMilpOYAgWBnIsusV6z0SCXWUMT3QH01J6Whl6KLeLK+KKEjfx5syGpFaOFBjibwlZJNJwmM81Y9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777319686; c=relaxed/simple;
	bh=YgHT4YY0dv4tCJlyYABbQoZCn5kpWLZ87QgsVROZQq4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t3Dep+N1I8adfsiFn8vLyuv/coXbku3A6Ak8nwJutyEJmn8DdRbKbnPwAbUqi9bGKPvuJJSibo0mcBGEbvTHbiK/HhFvM0Nvgm6N1yJkiYsfahqw+YD10pPg7zDvWM2AYDvtmnJALmsSYWjnGPbAde4Bx5jAO4z6a2oGidbVREQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QM2unevY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21927C2BCB5;
	Mon, 27 Apr 2026 19:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777319686;
	bh=YgHT4YY0dv4tCJlyYABbQoZCn5kpWLZ87QgsVROZQq4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=QM2unevY/yY4fTxhX+K99w3rUnlRjmMuRE9SiIo9Yj+n3aFp5Z9EkTKSNLjCTAq79
	 w8iDEG9cMwTiBcbo/UFaRcZToIPjFbxhBDIShlIbA5pjc7Mf1Obkl47XixIYIzsV+6
	 vhgA3diDGgSQUZbBiI/HkR2tjca24uwBZYKa0QlUyJI1n9gc01vQgZ9gAKD+zCo89f
	 HLuCN+fRJWETtHM+bDnQC0FOqYIUM38HdioEtsWNgByQf6WXldSxbN7mz9f198oS5f
	 SCyHylx7nDKOqOYN8KpYDli0d1/OuxBLPcyC70W30bm5+L7DCSRyKTnTMCk6U8+Vf2
	 G82P4kiD4ml5A==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 27 Apr 2026 21:54:33 +0200
Subject: [PATCH net 1/4] mptcp: sockopt: set timestamp flags on subflow
 socket, not msk
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260427-net-mptcp-misc-fixes-7-1-rc2-v1-1-7432b7f279fa@kernel.org>
References: <20260427-net-mptcp-misc-fixes-7-1-rc2-v1-0-7432b7f279fa@kernel.org>
In-Reply-To: <20260427-net-mptcp-misc-fixes-7-1-rc2-v1-0-7432b7f279fa@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Gang Yan <yangang@kylinos.cn>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1645; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=7ZipACbDtiXWO0A7h+Nu6bUGlwmcWYF0IWuVi7Brx2o=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLf7/vn0XJS70TFdbF/006W88c8ert4ftDPjInmTk+ue
 PAZqtyJ7yhlYRDjYpAVU2SRbovMn/m8irfEy88CZg4rE8gQBi5OAZjIZF1GhplRVUt08o+tVbvf
 ekD0/6VZ3Cv5ngQxnS35LRxwQubllWaGfyYTmA8t1Lmq+rKq1eLsDOvVq1leP674PPPayYefH6h
 P/8MHAA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Rspamd-Queue-Id: 82332479911
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241432-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matttbe@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,kylinos.cn:email]

From: Gang Yan <yangang@kylinos.cn>

Both mptcp_setsockopt_sol_socket_tstamp() and
mptcp_setsockopt_sol_socket_timestamping() iterate over subflows,
acquire the subflow socket lock, but then erroneously pass the MPTCP
msk socket to sock_set_timestamp() / sock_set_timestamping() instead
of the subflow ssk. As a result, the timestamp flags are set on the
wrong socket and have no effect on the actual subflows.

Pass ssk instead of sk to both helpers.

Fixes: 9061f24bf82e ("mptcp: sockopt: propagate timestamp request to subflows")
Cc: stable@vger.kernel.org
Assisted-by: GLM:5.1
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/sockopt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index de90a2897d2d..79db15903e7a 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -161,7 +161,7 @@ static int mptcp_setsockopt_sol_socket_tstamp(struct mptcp_sock *msk, int optnam
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 		bool slow = lock_sock_fast(ssk);
 
-		sock_set_timestamp(sk, optname, !!val);
+		sock_set_timestamp(ssk, optname, !!val);
 		unlock_sock_fast(ssk, slow);
 	}
 
@@ -237,7 +237,7 @@ static int mptcp_setsockopt_sol_socket_timestamping(struct mptcp_sock *msk,
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 		bool slow = lock_sock_fast(ssk);
 
-		sock_set_timestamping(sk, optname, timestamping);
+		sock_set_timestamping(ssk, optname, timestamping);
 		unlock_sock_fast(ssk, slow);
 	}
 

-- 
2.53.0


