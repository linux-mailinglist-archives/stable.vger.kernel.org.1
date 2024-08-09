Return-Path: <stable+bounces-66252-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 03AFC94CF02
	for <lists+stable@lfdr.de>; Fri,  9 Aug 2024 12:55:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E164B20A11
	for <lists+stable@lfdr.de>; Fri,  9 Aug 2024 10:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A4CA1922F3;
	Fri,  9 Aug 2024 10:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hcDs/0W0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B24191F9F;
	Fri,  9 Aug 2024 10:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723200925; cv=none; b=MaSPFIPQpyejZ4mqCeMd+P8eFldS6mZ41QkQCatsxX62tfK/R4AzUUCDlmVBKQNOhu8Vl4eOyCWd14wXYXSAmYVyQIIOwIrxTCtfnYJ8C9pZj1oxgPX8yCeTJKfl3b+n07dDk2nx3UzqPch4oDay6lV4QMr7jaXMJYCUYR2BLNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723200925; c=relaxed/simple;
	bh=IMJA4der1xgG+v6UHttG+q+Gg/CmoCBVSSuf/e1If+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cOpCT1fO7o+DebFVGJ7lWG9erxxJQC0hu6h4XhofQQs08J89cKEyrH6hYwuF4g5jT7vEMNmcA3EcgcYrCOunrkcXn6mCVFXlBzm09zkzFTWv9QE1RZwK03bZO3AaKnPQWJf8xygrpfBg7ENV/UQeVkqZ+GexeVK8QnC05PwwIAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hcDs/0W0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07A00C32782;
	Fri,  9 Aug 2024 10:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723200924;
	bh=IMJA4der1xgG+v6UHttG+q+Gg/CmoCBVSSuf/e1If+E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hcDs/0W0rnpzF05NhuojMXfx0acyIB5Kr77Jm+c5C6AAgC3Ic80DZkDNbClDr3Ib7
	 PSkep2uU6+OWWCbIjj6XmjTxrf/AlokhJl1nwz6LGy5nM6Rr2W7uoRVO3ztT1zi/Or
	 nHAfiUN9Th2x57ejqA41nOgZ0O2jI8bKaarq9/+y96tX0mK+7SUSv1Fi9J3k3nTkoH
	 0Grnai69c09EszUQ4cmSEER7/0YvvMde0iSkbuIcfgU8oLiN3o4Kc4yMmaByL+vlKZ
	 kH9pQSR3n36wJ/TlklLZ76YWPccxnG2NgHqFzbGG67mHkdDguuYIiwUtcCrQqH8Aib
	 P57vKcZCzM+zQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 5.10.y] mptcp: mib: count MPJ with backup flag
Date: Fri,  9 Aug 2024 12:55:15 +0200
Message-ID: <20240809105514.2902623-2-matttbe@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <2024080723-untangled-rogue-da43@gregkh>
References: <2024080723-untangled-rogue-da43@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3815; i=matttbe@kernel.org; h=from:subject; bh=IMJA4der1xgG+v6UHttG+q+Gg/CmoCBVSSuf/e1If+E=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmtfWSXyOmRO4iLs2DBxb3F2nLCbzapiHJrDnZT Fls9GcOyRWJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZrX1kgAKCRD2t4JPQmmg cyoSD/9XMYw8mQlQq0WIfmiQrkikJXpGeDN8/SetTkBreQMT5Cf5A6/EE5Qd+eCiibxRjjFuZzJ nFvzONo2LTRWxCa9yBtKe4riGgHSAFyFFfPGRiqAXDq/2oVP2VU9FxJ4fK9bCjxIio4gj/1OAR5 W1OynwVbQSitiDxWOXV0XcL9Ex+GyPqtlQ3Y5ZBmDJILEd7kbG2Ko8xCbbZodtj+jj/S7m9DLg+ mO8Q5Adj7OLKbq1Zxen4Vzz9ji1qtiZbMHt9U1MSubJeLH314r1CE0dG6gWkipekvTWTxBzdBXO 64gRAM1uQp7zwHrnU6swHudjyQJCiyYoY6osHBBG6tCntOEVIgbWEvbOx0chZq5kCP/x8V5Yqik kH0q+hHi0VK2zCwfuhrb8N7ZismB8tqiL72lfOdo25QgUUvFQhuQW/TtveUVp3MRiz4t9j2YJ4y dB9qBF12iETYYcMpzELiCbOUUd71tcs4S3zZceoFar9ArkR6nljfS1iGMNlc4dbRTddhkEpryZg 5r12lhgUzCTcdGqmT6G/YDw5qX+85DHACYYKWTeKp7xNT9GsNi5zTdjnUao0c4n0INxX/GYc5Du f1zEq0kPJeMGbzuLgkfuT9LNhdF4BmIaH4Cj4YQ8bGkJWNdR8t6d/tivmfozuSnCSrjJ9nPHwPx WIlxdfcp4UfbzuQ==
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
  and commit 5bc56388c74f ("mptcp: add port number check for MP_JOIN")
  which are not in this version. These commits are unrelated to this
  modification. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/mib.c     | 2 ++
 net/mptcp/mib.h     | 2 ++
 net/mptcp/subflow.c | 6 ++++++
 3 files changed, 10 insertions(+)

diff --git a/net/mptcp/mib.c b/net/mptcp/mib.c
index b921cbdd9aaa..f4034e000f3e 100644
--- a/net/mptcp/mib.c
+++ b/net/mptcp/mib.c
@@ -16,7 +16,9 @@ static const struct snmp_mib mptcp_snmp_list[] = {
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
index 47bcecce1106..a9f43ff00b3c 100644
--- a/net/mptcp/mib.h
+++ b/net/mptcp/mib.h
@@ -9,7 +9,9 @@ enum linux_mptcp_mib_field {
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
index a59c731d7fed..f4067484727e 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -135,6 +135,9 @@ static void subflow_init_req(struct request_sock *req,
 			return;
 	} else if (mp_opt.mp_join) {
 		SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_JOINSYNRX);
+
+		if (mp_opt.backup)
+			SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_JOINSYNBACKUPRX);
 	}
 
 	if (mp_opt.mp_capable && listener->request_mptcp) {
@@ -347,6 +350,9 @@ static void subflow_finish_connect(struct sock *sk, const struct sk_buff *skb)
 
 		subflow->mp_join = 1;
 		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_JOINSYNACKRX);
+
+		if (subflow->backup)
+			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_JOINSYNACKBACKUPRX);
 	} else if (mptcp_check_fallback(sk)) {
 fallback:
 		mptcp_rcv_space_init(mptcp_sk(parent), sk);
-- 
2.45.2


