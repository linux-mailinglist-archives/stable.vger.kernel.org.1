Return-Path: <stable+bounces-86910-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0739A9A4CDE
	for <lists+stable@lfdr.de>; Sat, 19 Oct 2024 12:29:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87A241F22BC2
	for <lists+stable@lfdr.de>; Sat, 19 Oct 2024 10:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BCB81DED55;
	Sat, 19 Oct 2024 10:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qpHZqyc6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B6956B81;
	Sat, 19 Oct 2024 10:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729333756; cv=none; b=FpCdi+BeHbszNrqkylUv5Mvf3nyHBGIRr4wFRFlYk0FZaIn1fcnBCyyApgknvb0O/5v9EtJNKxipmThEvHs6mqdencp3ZQ3aPKcPR2eByy2rULozVhVTgmc7YhmLwQ/QiYYDCkV/t6/EYOacSUBhjybzJe68O7AYIaqrlkkTbjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729333756; c=relaxed/simple;
	bh=BFI0jyosPmOnHqY0LnMSWCjphPbM+TMeHEB94JgUkuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F8pC3Ht8Xo1hwqEAXgw5BHjVZB0EStIyaoD3oSvOHSIdngbJ/pUs6R1x3aBZAXlayy1pSNff8FXWdPgpyzCWDR96fZefH5Jj2QEd50N9amJqC6p30m9xZnRROZ4C1/FElPc5HMXtYOMOuTBkbioIwMPi8AzUFTrtLBh6dIK1fVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qpHZqyc6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5DB2C4CECF;
	Sat, 19 Oct 2024 10:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729333755;
	bh=BFI0jyosPmOnHqY0LnMSWCjphPbM+TMeHEB94JgUkuQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qpHZqyc6b8rIlmMq6l60oALf/2YYcovxDxyVLB4GaA5ZL5D+Zjv6HuydKovuozlGQ
	 ia7qnLKKpoTIVv+vVovVo4FIj6NXynHX3z8I32XLBM/J0hlWEJxmSyvO+ggP/bphs5
	 FSddmQ5OwgGTom1Sj/PB3RhgyKdHvSoIhiI0L8qC6Ht6zDHcZuEFnb4a3RvFJtsArN
	 o3YxA2TAsy06nMeUR8AST/5gAmRDQsRjNeKIgKO3phisvXWl0ofC7+YF+t3y1cHpJn
	 Zj70gFlw4FJAP8cjvp6VJ0FmqCcmDnCf6JOwNmmpx0gkrXjqDxLTeT661YUoMTVHZo
	 Z6HQuBOV49toQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	sashal@kernel.org,
	Matthieu Baerts <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 5.10.y 2/3] mptcp: handle consistently DSS corruption
Date: Sat, 19 Oct 2024 12:29:08 +0200
Message-ID: <20241019102905.3383483-7-matttbe@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241019102905.3383483-5-matttbe@kernel.org>
References: <20241019102905.3383483-5-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4615; i=matttbe@kernel.org; h=from:subject; bh=mgszj9fxlSPmfVrM9CCcEDleRtBoxxHe8lu9QEVHeps=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnE4nxGiuWpdXslByoOacFsm24MBBj0PPi3G2rZ U9dwT9qKriJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZxOJ8QAKCRD2t4JPQmmg c4XpEAC0wSodm833As+NY6pNPR6NE/9mTOP+sE9YIrdSQ07eiiZ1c4NJT/6ezifQr/UX1d+J28y ONQU0iL74tPl9N7+qWMzdj0NuvCUMUCOa0gN/hd/nVNB7zLGWZWgOUm/Hzr4Lc8Q+JYwjIe+dnn ZB+PdApK20GAvgHvlGqPm7vA1MEviWUzxUpy+6elgmRO4Dz3LOTED4hUHW+7akTcMxzE0Z2zXSt h/BsOUsUxhehRwmmggo5nnenGGa2slaEgKU9cFkXzdjGbc1LQ0Zlk0qbJlEfVLXw3sn/vwV8Cil /CV+gZiN4imeFwlJDMVsNHqSd+aACxtBxyHyeyCcTQfTujfLfd+6rWkBiKruZ3p1OZ3Jm+wF+La CekiKgs0tfUGhDXv1HhJWixoiURidwQyWSlT/KLeF3CU7otJsLXOk63716hvK8u7FdDWUUPImnH DRu2Eq3lVHcaBEnbraiuJSJtH/q/hUbNYPng58qUXexXi24Pd0pco9Fmh9nkWDybg1r7yKrz2r+ 0ZI14eIRaJBjvUppwNmHf4OLway2Lf87txAv3XsNrDIXAupjwf+c35iUf3dnCKaAFC2H0n0Zkz1 m6zXrt4bsPlPQ9WE6WIfSPnbsA96RpVcbQxHtKiEv4MWn1dcHRWu8fxlJXATH9w8Buxq4c4Wvzz MM+RNZSAK3oN2gA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

From: Paolo Abeni <pabeni@redhat.com>

commit e32d262c89e2b22cb0640223f953b548617ed8a6 upstream.

Bugged peer implementation can send corrupted DSS options, consistently
hitting a few warning in the data path. Use DEBUG_NET assertions, to
avoid the splat on some builds and handle consistently the error, dumping
related MIBs and performing fallback and/or reset according to the
subflow type.

Fixes: 6771bfd9ee24 ("mptcp: update mptcp ack sequence from work queue")
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20241008-net-mptcp-fallback-fixes-v1-1-c6fb8e93e551@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Conflicts in mib.[ch], because commit 104125b82e5c ("mptcp: add mib
  for infinite map sending") is linked to a new feature, not available
  in this version. Resolving the conflicts is easy, simply adding the
  new lines declaring the new "DSS corruptions" MIB entries.
  Also removed in protocol.c and subflow.c all DEBUG_NET_WARN_ON_ONCE
  because they are not defined in this version: enough with the MIB
  counters that have been added in this commit. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/mib.c      |  2 ++
 net/mptcp/mib.h      |  2 ++
 net/mptcp/protocol.c | 20 +++++++++++++++++---
 net/mptcp/subflow.c  |  2 +-
 4 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/mib.c b/net/mptcp/mib.c
index f4034e000f3e..44d083958d8e 100644
--- a/net/mptcp/mib.c
+++ b/net/mptcp/mib.c
@@ -23,6 +23,8 @@ static const struct snmp_mib mptcp_snmp_list[] = {
 	SNMP_MIB_ITEM("MPJoinAckRx", MPTCP_MIB_JOINACKRX),
 	SNMP_MIB_ITEM("MPJoinAckHMacFailure", MPTCP_MIB_JOINACKMAC),
 	SNMP_MIB_ITEM("DSSNotMatching", MPTCP_MIB_DSSNOMATCH),
+	SNMP_MIB_ITEM("DSSCorruptionFallback", MPTCP_MIB_DSSCORRUPTIONFALLBACK),
+	SNMP_MIB_ITEM("DSSCorruptionReset", MPTCP_MIB_DSSCORRUPTIONRESET),
 	SNMP_MIB_ITEM("InfiniteMapRx", MPTCP_MIB_INFINITEMAPRX),
 	SNMP_MIB_ITEM("OFOQueueTail", MPTCP_MIB_OFOQUEUETAIL),
 	SNMP_MIB_ITEM("OFOQueue", MPTCP_MIB_OFOQUEUE),
diff --git a/net/mptcp/mib.h b/net/mptcp/mib.h
index a9f43ff00b3c..0e17e1cebdbc 100644
--- a/net/mptcp/mib.h
+++ b/net/mptcp/mib.h
@@ -16,6 +16,8 @@ enum linux_mptcp_mib_field {
 	MPTCP_MIB_JOINACKRX,		/* Received an ACK + MP_JOIN */
 	MPTCP_MIB_JOINACKMAC,		/* HMAC was wrong on ACK + MP_JOIN */
 	MPTCP_MIB_DSSNOMATCH,		/* Received a new mapping that did not match the previous one */
+	MPTCP_MIB_DSSCORRUPTIONFALLBACK,/* DSS corruption detected, fallback */
+	MPTCP_MIB_DSSCORRUPTIONRESET,	/* DSS corruption detected, MPJ subflow reset */
 	MPTCP_MIB_INFINITEMAPRX,	/* Received an infinite mapping */
 	MPTCP_MIB_OFOQUEUETAIL,	/* Segments inserted into OoO queue tail */
 	MPTCP_MIB_OFOQUEUE,		/* Segments inserted into OoO queue */
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 24a21ff0cb8a..8558309a2d3f 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -457,6 +457,18 @@ static void mptcp_check_data_fin(struct sock *sk)
 	}
 }
 
+static void mptcp_dss_corruption(struct mptcp_sock *msk, struct sock *ssk)
+{
+	if (READ_ONCE(msk->allow_infinite_fallback)) {
+		MPTCP_INC_STATS(sock_net(ssk),
+				MPTCP_MIB_DSSCORRUPTIONFALLBACK);
+		mptcp_do_fallback(ssk);
+	} else {
+		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_DSSCORRUPTIONRESET);
+		mptcp_subflow_reset(ssk);
+	}
+}
+
 static bool __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
 					   struct sock *ssk,
 					   unsigned int *bytes)
@@ -519,10 +531,12 @@ static bool __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
 				moved += len;
 			seq += len;
 
-			if (WARN_ON_ONCE(map_remaining < len))
-				break;
+			if (unlikely(map_remaining < len))
+				mptcp_dss_corruption(msk, ssk);
 		} else {
-			WARN_ON_ONCE(!fin);
+			if (unlikely(!fin))
+				mptcp_dss_corruption(msk, ssk);
+
 			sk_eat_skb(ssk, skb);
 			done = true;
 		}
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 0c020ca463f4..c3434069fb0a 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -702,7 +702,7 @@ static bool skb_is_fully_mapped(struct sock *ssk, struct sk_buff *skb)
 	unsigned int skb_consumed;
 
 	skb_consumed = tcp_sk(ssk)->copied_seq - TCP_SKB_CB(skb)->seq;
-	if (WARN_ON_ONCE(skb_consumed >= skb->len))
+	if (unlikely(skb_consumed >= skb->len))
 		return true;
 
 	return skb->len - skb_consumed <= subflow->map_data_len -
-- 
2.45.2


