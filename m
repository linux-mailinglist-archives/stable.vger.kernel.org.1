Return-Path: <stable+bounces-244186-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iFz6OSQI+mkEIgMAu9opvQ
	(envelope-from <stable+bounces-244186-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 17:09:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 526FF4CFFA0
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 17:09:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3203930F2FE4
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 15:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C7C4481FAB;
	Tue,  5 May 2026 15:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jnRDf0pa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC6A481250;
	Tue,  5 May 2026 15:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777993304; cv=none; b=SoYhsOdZyhpEISDFz27scMLdP/eqX6GaQta9QSzILJlMBLzkPrHazuZNjMaehVSPM7RgDz/Mv4WkjQk3mQBtlfMa+tlOI3AtIlQn5epA6PyqaET4EWvisc7dL9E15MHK3s7LiHSRn76jowz6R2kkmBef06a5IJJ368PQwKWQ5PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777993304; c=relaxed/simple;
	bh=5qL8/W6mBGqHCVD2v3ZvGTGMj7PV2tQ5ZdxB1eDeg58=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fu+5suFgEspSKYSIl4SKFeiAeuTR3rf+tgF9tfqX1xphtbbugItL/YZT/ooWjAaj85jdSl9K5Q2gucOxHFVRv4uisWmzxEUfr9Ck169WmkYJcmqhtn/yFmVtbsmndaSND2UzgOd24YlLZ+TpnJPXjMc5RKzxepVLrIzYWo/7bEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jnRDf0pa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 918DCC2BCF5;
	Tue,  5 May 2026 15:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777993303;
	bh=5qL8/W6mBGqHCVD2v3ZvGTGMj7PV2tQ5ZdxB1eDeg58=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=jnRDf0pagUsHheJI2iONW2m+z6PIhsUHlrOyQvxPsY+y5yRSd91d2mkRZ509NxyyO
	 UIR3PDjrUj/DKPnOvdHb+SRc/AMhQ11JZLsaTTEjIw5gxAdxpMN62EDhj9Jqd8vfWd
	 auKW3rc77u9VOjb3OHZGQpAwcUh+kAjRWXv496J3p5fIEe+RizIH0PfELlc48cn4kA
	 As+SufZ7IKzCqP4sWiz40JIIg9u/wT5lJmcSCFa+CrPgBk4fi6C3kIk1YEy+0FLhQT
	 eBl2EanRdzS1okbsHRCk1uG4D5wPOO6q8g07WMXlvTw2JBlqg+yFX0ei5RphprojcS
	 BpA5VHthqmtRw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 05 May 2026 17:00:55 +0200
Subject: [PATCH net 07/11] mptcp: pm: ADD_ADDR rtx: skip inactive subflows
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260505-net-mptcp-pm-fixes-7-1-rc3-v1-7-fca8091060a4@kernel.org>
References: <20260505-net-mptcp-pm-fixes-7-1-rc3-v1-0-fca8091060a4@kernel.org>
In-Reply-To: <20260505-net-mptcp-pm-fixes-7-1-rc3-v1-0-fca8091060a4@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Christoph Paasch <cpaasch@openai.com>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1796; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=5qL8/W6mBGqHCVD2v3ZvGTGMj7PV2tQ5ZdxB1eDeg58=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJ/sTloL8/6wjv5uVRSsc2Gq9NWBARurOR24J+dY1K6O
 fbI9klOHaUsDGJcDLJiiizSbZH5M59X8ZZ4+VnAzGFlAhnCwMUpABNxTWBkWF/25+DV/OJgix+B
 3Yfk5IzthPNnHnI70GRzpi47zuKVOiPDZ49wi4tR/57Ma7ubM781Z7l8UuTdjTP6A+vlzq3Xdc3
 kBgA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Rspamd-Queue-Id: 526FF4CFFA0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244186-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matttbe@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

When looking at the maximum RTO amongst the subflows, inactive subflows
were taken into account: that includes stale ones, and the initial one
if it has been already been closed.

Unusable subflows are now simply skipped. Stale ones are used as an
alternative: if there are only stale ones, to take their maximum RTO and
avoid to eventually fallback to net.mptcp.add_addr_timeout, which is set
to 2 minutes by default.

Fixes: 30549eebc4d8 ("mptcp: make ADD_ADDR retransmission timeout adaptive")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 29d1bb6a69cf..8a5dba7fe66e 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -306,18 +306,28 @@ static unsigned int mptcp_adjust_add_addr_timeout(struct mptcp_sock *msk)
 	const struct net *net = sock_net((struct sock *)msk);
 	unsigned int rto = mptcp_get_add_addr_timeout(net);
 	struct mptcp_subflow_context *subflow;
-	unsigned int max = 0;
+	unsigned int max = 0, max_stale = 0;
 
 	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 		struct inet_connection_sock *icsk = inet_csk(ssk);
 
-		if (icsk->icsk_rto > max)
+		if (!__mptcp_subflow_active(subflow))
+			continue;
+
+		if (unlikely(subflow->stale)) {
+			if (icsk->icsk_rto > max_stale)
+				max_stale = icsk->icsk_rto;
+		} else if (icsk->icsk_rto > max) {
 			max = icsk->icsk_rto;
+		}
 	}
 
-	if (max && max < rto)
-		rto = max;
+	if (max)
+		return min(max, rto);
+
+	if (max_stale)
+		return min(max_stale, rto);
 
 	return rto;
 }

-- 
2.53.0


