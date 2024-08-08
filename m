Return-Path: <stable+bounces-66064-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30C4D94C172
	for <lists+stable@lfdr.de>; Thu,  8 Aug 2024 17:32:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D40D0280EF1
	for <lists+stable@lfdr.de>; Thu,  8 Aug 2024 15:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A37218B489;
	Thu,  8 Aug 2024 15:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pk1TN/Qg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1923118D646;
	Thu,  8 Aug 2024 15:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723131032; cv=none; b=VvuirXptasOQdo6Ab8asicBeiLgptrD4blIoSpOJByVEv7+rKJgW2+yOm5N7L4AFlHdI8Rbkv5tXQQq1qhC8xcRsmcG4ppIdIZBU0gzfUFv0+l8nY1+v5WN/GMioDeaTO3gzmeJE9xESzSOJu+7ys1wowiqjUb1l+xe/3r9FeZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723131032; c=relaxed/simple;
	bh=kmXJDsR5uzRQKmmr3H+BHdZCShdjvKClhktPf7MnBy4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KhPrOWGzkFgShXFoF/pl5PQnOO2kkkI4GyUKT5f83W21p/QStp8inifVtVoEpN5DabFeAnAYriEAgBLpXYN0UCjuNOxz8K/S8slZIfezoCAmrKvQ8VKO6vqG14UP2s6scWEpIEWWBZW1IjT/D7Ks8e7AH9yrQvOM7TaMLKnAJl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pk1TN/Qg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A898C32782;
	Thu,  8 Aug 2024 15:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723131031;
	bh=kmXJDsR5uzRQKmmr3H+BHdZCShdjvKClhktPf7MnBy4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pk1TN/QgH5On6IKyH5FE04ISowZc82XrpaDpGK/v81wTPLGZ1JujchR/V1VdbdZBC
	 i9cXv06mX5nbzJgqjFyGX9sYJaAuL/A5TetraRpZQMRhT9Vb6uA4j7XGGlRcSNmmNv
	 6G6CCx2RChK87RGPciRvpGBzCQgqoRZPNoRrvrXDJchCYLTeN3ipSAMs6U1h5fElHR
	 N40akhRIirICzkP1rgP0BGlAeYpj2kTxnGxBCkbjotMgAlAnFUnQgq3NbYWOFJ5HMv
	 5S3kZdG2L/ybP2QrLKGu2RUCpRYrR95N2sdJQHtHVO4RvwVBa1/ZwxOv7ZaMb3Di4x
	 I1gVauiN/3HdA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 6.1.y] mptcp: mib: count MPJ with backup flag
Date: Thu,  8 Aug 2024 17:30:05 +0200
Message-ID: <20240808153004.2308809-2-matttbe@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <2024080722-survive-jacket-b862@gregkh>
References: <2024080722-survive-jacket-b862@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3776; i=matttbe@kernel.org; h=from:subject; bh=kmXJDsR5uzRQKmmr3H+BHdZCShdjvKClhktPf7MnBy4=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmtOR8AdYjaLfka2qkZizaJJ85XSPtYTfCrT5fj UUIX+rQOPmJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZrTkfAAKCRD2t4JPQmmg cyXUEACwGbkKEmD/lDMDOxmlq8Ku0geNSz1jbXCjsL0yRS5l8HKkGQHl8/WsnS45S/YQ3971MKv jtNBiL0gbNtV5LY97YI9OFi8jqJqXwnljvAWcVMp2R//fqTqrdR4SNT67AHpPUK/0BYD1FHMRuQ dbI2d8Jx1+eAuFbEfr0GYM1KHyJZa7G0/toQW+STE7ZPpGRedYVnUNMUuiFDNXvhlk3OWwhZhZ/ 4SnzcXXJtyd6Ist86HVbYjOQ7AJrlJVzRc8CATRs5ZtOtjlLBckTVIr63h/kj5wpb2MgLs8/PxT CY7cwICZQ9iNWz/Rz79z437oBRXeRWzfl0ih7BYTj2rhJoloiIXyrwiXaSMr0HLrGTsOomLpkP6 eT114V6BNBUT4KuFD+t0H7InBvweY6AaOqzHZHe85qHOpJXKQuoY3nk/WyM4VLuXtFeR6cFCfoz BlGuJ33Pb4s1ovuqZGhm5I+p4ut//2q1F1Hk1sxR+YRgjx9wsBpYrLHpIxuc2T5BJn84Cte8JBx i4abOiJtLA45dtd7V3XpkuArLfHCgfVlBOTliq+wre9aySp2kRhawvVrG8VS35JaPr8i+kb+/s6 rsh8itVveF5w+eebjcivRVogWLv4h/4GlAvaZnCXdqkwqTW+FlJd2ZlX1FfTKFH0ymtTYOgqGOR QuEbyJlKBqxeE8A==
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
index 0dac2863c6e1..1f3161a38b9d 100644
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
index 2be3596374f4..a7b94f5c5d27 100644
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
index 96bdd4119578..b8cb65bd9be8 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -165,6 +165,9 @@ static int subflow_check_req(struct request_sock *req,
 			return 0;
 	} else if (opt_mp_join) {
 		SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_JOINSYNRX);
+
+		if (mp_opt.backup)
+			SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_JOINSYNBACKUPRX);
 	}
 
 	if (opt_mp_capable && listener->request_mptcp) {
@@ -469,6 +472,9 @@ static void subflow_finish_connect(struct sock *sk, const struct sk_buff *skb)
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


