Return-Path: <stable+bounces-66130-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 78B2194CCEF
	for <lists+stable@lfdr.de>; Fri,  9 Aug 2024 11:08:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EFC3CB219C9
	for <lists+stable@lfdr.de>; Fri,  9 Aug 2024 09:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE168190492;
	Fri,  9 Aug 2024 09:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A00bwu1e"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF39190067;
	Fri,  9 Aug 2024 09:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723194483; cv=none; b=MuX5ohP1wg8dlv0iUKPzc6Gljn6N/iZugqUP+tZqMligZRcIZFQSTwilfv/gAlgvn8eFmC3Vz0ILJA5JMSIb/CyETzFK6+XI9qAlvkAEFh61AQrVl7oWWbeEkuO4kvEHdWIzQAjg1MJKT+3LYPRpHEWlEXKH2zN1qjbbU+qJRxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723194483; c=relaxed/simple;
	bh=Z6lm/qrzyFzltmug7pVSYKf0j0H9JFXolOsQh3eMpxs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OLWM+Ov385Mrfr+kNsE2s6bDKCv75of1q2A8c8WRSLVtboGhpTcC5yQNaY63DlTogT/PJM990ePk3eH/8gNgwGSlvCejHJARuziWjH5fPDl0CM7/nyE5gXI2w5O6crYoqHVahR7ZAVRTq1sra4D45gzaLzqkqk+oV9OzsPwXI+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A00bwu1e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5213EC4AF0E;
	Fri,  9 Aug 2024 09:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723194483;
	bh=Z6lm/qrzyFzltmug7pVSYKf0j0H9JFXolOsQh3eMpxs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A00bwu1etzALVghdvXAfmqKK4FMdmQubA+7X0X/eDIidGyH+yh3B3Px8AJtMoQQRw
	 4HAgHQlNMTCQojIhUL97IDLkNBke4lvBbb8DeMwsYuhlyH9vznF5Y3DuyeAWVgdsjR
	 4H9h0slzxSZcUOXZQE3ZwlBzTbRsdkvggeSwqPDJvkCwDqJJFkd3sGN4apWiP3pslM
	 JD7PXfmpLsJx70WYHSbEy0dN340kHsUoslO3qNhY28FOVYPp6+0u2h98x39WsEZ4VH
	 cTSnNAI9eZx1HuNB+B8w39+egI802XhbGJ0tcJy9/0M8yCKjsbp7We6ak0Xpprvynd
	 iZTzwrug7kjGw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 5.15.y] mptcp: mib: count MPJ with backup flag
Date: Fri,  9 Aug 2024 11:07:54 +0200
Message-ID: <20240809090753.2699805-2-matttbe@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <2024080722-glorify-rarity-f9bb@gregkh>
References: <2024080722-glorify-rarity-f9bb@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3776; i=matttbe@kernel.org; h=from:subject; bh=Z6lm/qrzyFzltmug7pVSYKf0j0H9JFXolOsQh3eMpxs=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmtdxppO08ryP/L+r9FoFm4KlaC+UAp94sf1Gpb FBnTgZj8aKJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZrXcaQAKCRD2t4JPQmmg cwQED/97uBZvGB0H565L2ukWZIf/6tHJtoHKnF5e3ym+mKD2J0yPRBybiDaeyX8eVQjKGWc7gdw SbxjDLq0/XGko4XMacRH7J7NnXTRg/BZEfGESFO/GhEETXftvevvtoeb9OwCKVUVdLjai68reLJ g7vfo7IlzyXPnSC2YrUDA8sGnKKn847tniRNIemagM68H8FAxyglYeKRabZjSY2jJ1dyI3D+8+U FcFUP93ZbQE8jp8SMjAfmmi5+TkpvQxqGZSVIJIy21/E3OjO4x0cG9gUc4xW4qO1z/xc/mIbSpL TpJeffXDSOyzRYpf5crpGu9kgV/G4FaGzYLPOS2841RlbljBq5n6M6LyJH2Wvohu56M5CUKwVqR X1dwC2n3IH7v2PHG+0gPIBAuLgxBp4FTaXc5JGT+DovfepFBZtVAtAzIDmd1ZJFQ9Oul32lcojl OkdroWtPLmkcMZauRnV+dufxuEmow7u95QPnrhwed+9Logh98Z3m3+pKfFUnCwVy5Yy0HYTUYNP MU4Q2bPbyg7mazO7C28oLrpOV3/jldS9Hu7gUWmTOVBcoI2y4TjA3wexEWL0fat1lpFuCdTubuu 2ot4ZP73i1B0ba1LOaq+KLIppcJvKPNqP65uANFicIn4mk/pDtCKN78AI5Ujby1TJ/cW6DBwxPV STFHm0w8Ol1jLYQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

commit 4dde0d72ccec500c60c798e036b852e013d6e124 upstream.

Without such counters, it is difficult to easily debug issues with MPJ
not having the backup flags on production servers.

This is not strictly a fix, but it eases to validate the following
patches without requiring to take packet traces, to query ongoing
connections with Netlink with admin permissions, or to guess by looking
at the behaviour of the packet scheduler. Also, the modification is self
contained, isolated, well controlled, and the increments are done just
after others, there from the beginning. It looks then safe, and helpful
to backport this.

Fixes: 4596a2c1b7f5 ("mptcp: allow creating non-backup subflows")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
[ Conflicts in subflow.c because the context has changed in
  commit b3ea6b272d79 ("mptcp: consolidate initial ack seq generation")
  which is not in this version. This commit is unrelated to this
  modification. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/mib.c     | 2 ++
 net/mptcp/mib.h     | 2 ++
 net/mptcp/subflow.c | 6 ++++++
 3 files changed, 10 insertions(+)

diff --git a/net/mptcp/mib.c b/net/mptcp/mib.c
index 8d1c67b93591..c2fadfcfd6d6 100644
--- a/net/mptcp/mib.c
+++ b/net/mptcp/mib.c
@@ -19,7 +19,9 @@ static const struct snmp_mib mptcp_snmp_list[] = {
 	SNMP_MIB_ITEM("MPTCPRetrans", MPTCP_MIB_RETRANSSEGS),
 	SNMP_MIB_ITEM("MPJoinNoTokenFound", MPTCP_MIB_JOINNOTOKEN),
 	SNMP_MIB_ITEM("MPJoinSynRx", MPTCP_MIB_JOINSYNRX),
+	SNMP_MIB_ITEM("MPJoinSynBackupRx", MPTCP_MIB_JOINSYNBACKUPRX),
 	SNMP_MIB_ITEM("MPJoinSynAckRx", MPTCP_MIB_JOINSYNACKRX),
+	SNMP_MIB_ITEM("MPJoinSynAckBackupRx", MPTCP_MIB_JOINSYNACKBACKUPRX),
 	SNMP_MIB_ITEM("MPJoinSynAckHMacFailure", MPTCP_MIB_JOINSYNACKMAC),
 	SNMP_MIB_ITEM("MPJoinAckRx", MPTCP_MIB_JOINACKRX),
 	SNMP_MIB_ITEM("MPJoinAckHMacFailure", MPTCP_MIB_JOINACKMAC),
diff --git a/net/mptcp/mib.h b/net/mptcp/mib.h
index 2966fcb6548b..90025acdcf72 100644
--- a/net/mptcp/mib.h
+++ b/net/mptcp/mib.h
@@ -12,7 +12,9 @@ enum linux_mptcp_mib_field {
 	MPTCP_MIB_RETRANSSEGS,		/* Segments retransmitted at the MPTCP-level */
 	MPTCP_MIB_JOINNOTOKEN,		/* Received MP_JOIN but the token was not found */
 	MPTCP_MIB_JOINSYNRX,		/* Received a SYN + MP_JOIN */
+	MPTCP_MIB_JOINSYNBACKUPRX,	/* Received a SYN + MP_JOIN + backup flag */
 	MPTCP_MIB_JOINSYNACKRX,		/* Received a SYN/ACK + MP_JOIN */
+	MPTCP_MIB_JOINSYNACKBACKUPRX,	/* Received a SYN/ACK + MP_JOIN + backup flag */
 	MPTCP_MIB_JOINSYNACKMAC,	/* HMAC was wrong on SYN/ACK + MP_JOIN */
 	MPTCP_MIB_JOINACKRX,		/* Received an ACK + MP_JOIN */
 	MPTCP_MIB_JOINACKMAC,		/* HMAC was wrong on ACK + MP_JOIN */
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 2fdc7b1d2f32..90e7a46a6d2f 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -163,6 +163,9 @@ static int subflow_check_req(struct request_sock *req,
 			return 0;
 	} else if (opt_mp_join) {
 		SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_JOINSYNRX);
+
+		if (mp_opt.backup)
+			SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_JOINSYNBACKUPRX);
 	}
 
 	if (opt_mp_capable && listener->request_mptcp) {
@@ -462,6 +465,9 @@ static void subflow_finish_connect(struct sock *sk, const struct sk_buff *skb)
 		subflow->mp_join = 1;
 		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_JOINSYNACKRX);
 
+		if (subflow->backup)
+			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_JOINSYNACKBACKUPRX);
+
 		if (subflow_use_different_dport(mptcp_sk(parent), sk)) {
 			pr_debug("synack inet_dport=%d %d",
 				 ntohs(inet_sk(sk)->inet_dport),
-- 
2.45.2


