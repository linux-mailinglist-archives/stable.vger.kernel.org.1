Return-Path: <stable+bounces-86902-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EDD19A4C96
	for <lists+stable@lfdr.de>; Sat, 19 Oct 2024 11:31:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7245B22F68
	for <lists+stable@lfdr.de>; Sat, 19 Oct 2024 09:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB4E51DD545;
	Sat, 19 Oct 2024 09:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ksjm/d+r"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D77D20E30B;
	Sat, 19 Oct 2024 09:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729330259; cv=none; b=A10XbyimOHv9GDJ9SOp4PEwFj7EerhPVHpT5Q65PSzq/h6vSlYJzbVDrjEpduXF3XGD42uTCPPmWXu1gMUH1a4wyVKiQ42YccFouQ0BEN0IDHtwmEBvjE6rQobapDs5XL1FQ/4Ar4OAp39VetjQJPiM8JAYquhnxVVGxXmkyE88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729330259; c=relaxed/simple;
	bh=zbWqWPno6ENAl+Sd0MjtpCFW5vRqCOyt3vEy3ggbrpg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qRymKyJlddwsVxtCs8xP2Qfv/wkZYRULuV7oWQ6uGETLRqPF3ZdedVMbxWE3j5BJlgAcQogmvJGnAap+N0vX9qqJlbYMFJBsIUI6jtK2FIxS8qDHrbBdveT9Ug1/8yscONwnaPM80V66Yeyn3lIuUnVVRMDwt/V9P6h8k4rjc54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ksjm/d+r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DADCC4CED1;
	Sat, 19 Oct 2024 09:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729330259;
	bh=zbWqWPno6ENAl+Sd0MjtpCFW5vRqCOyt3vEy3ggbrpg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ksjm/d+r5GugGcHmI8DeZbm50kwDh0ljhQFYbh4j/al6SEjm6pPU892DaeDsMRfG7
	 l7FgS0VBMZTWFTlQK1JhzT8T3z1O3RRQv/BhkBQIMgukgMV3CoYbOJf0NPO93p6Jlw
	 0H1Kjg9+lDe920cI3BiyGGzpFT6Nb/muBpvJbPCG/JV3gVme8Z0ugWWj8HvrQpcI28
	 2PQa5jPmNpEfqKmfQMKUgn1JhE6QmFTOHCXruOFRYtVKAGsd7tgkmqJvQcXRwGgwIX
	 f8RomW65dVA93aXijKk9AHEdLMiWY2BODnSMCdgsJcIZ0FMBSxIwFusu1Jhb+Tgmjz
	 F0wFuMojoxHDA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	sashal@kernel.org,
	Matthieu Baerts <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 5.15.y 2/6] mptcp: handle consistently DSS corruption
Date: Sat, 19 Oct 2024 11:30:48 +0200
Message-ID: <20241019093045.3181989-10-matttbe@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241019093045.3181989-8-matttbe@kernel.org>
References: <20241019093045.3181989-8-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4643; i=matttbe@kernel.org; h=from:subject; bh=k1diKjN7l3/qhTXI2VZWpsz7ytJGRrg2XYZIocF1oPU=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnE3xF57TtytO/cAfUznN/U9ni1uyz4V23WrixV kBPUX36meOJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZxN8RQAKCRD2t4JPQmmg cx/sD/4shQDnQuMRxeIY98no7yiQfSQYg/ZYWwdOauV6NhVLZ4KaacYTKTOreP+WJ6Jsd3ROaWz 6Wdp7e6PTUgDxVY/3cRnJod6C7Er+UOerQS/09dSHtZfpzkb8r/xUiD2nG7v8d6m4/72Wl4Vr13 NmVbwmxWIO/qsC/JSzygPulirSdWaEXP7izkMjQLuEsPZPkZc6fk5IIvmxG5fCrx3+tAaiQ9Fqe jG7BBgPnZQokM+jFVUDE6FJkav5Ddaq/Vq2mJeH7gbw69g1HsmbQwQNRk5Zdua8IsD3dMQC8cG0 +YKk49/YxEEEKUuSysOdZQPr9OnpSWemPUda+nC19ELbaUTqNA4v1tcJQXh1pR5/K0Nc3dingW8 dLtLTbCMYzKpZwTQ49sFpqaQsCcRe+xhunWxE1FZfdcWk6xDYGzUweIFw/hJewDeb79x5eVhIk3 cjziXpfh10SwDg96K8GVbfBDsKTETgHdboPWhnallpEW3hjl74vky3+nS37Avl2fR0537nQc8Dv DG5qQc5y148p7+Fke7r6KrnTfZjINJltFcuPMH05sOQDqbtbxghqH5GWqeYkLMCymSzQ8vySu2k 50Y4tjxsojxuwvvlB4KMHLZIk80sY73jChyUIT/lFW25KeOukOOHTA5s1O7lq0PJeWnYIthiMZj j2NnHxhb/hk/2eQ==
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
index c2fadfcfd6d6..08f82e1ca2f7 100644
--- a/net/mptcp/mib.c
+++ b/net/mptcp/mib.c
@@ -26,6 +26,8 @@ static const struct snmp_mib mptcp_snmp_list[] = {
 	SNMP_MIB_ITEM("MPJoinAckRx", MPTCP_MIB_JOINACKRX),
 	SNMP_MIB_ITEM("MPJoinAckHMacFailure", MPTCP_MIB_JOINACKMAC),
 	SNMP_MIB_ITEM("DSSNotMatching", MPTCP_MIB_DSSNOMATCH),
+	SNMP_MIB_ITEM("DSSCorruptionFallback", MPTCP_MIB_DSSCORRUPTIONFALLBACK),
+	SNMP_MIB_ITEM("DSSCorruptionReset", MPTCP_MIB_DSSCORRUPTIONRESET),
 	SNMP_MIB_ITEM("InfiniteMapRx", MPTCP_MIB_INFINITEMAPRX),
 	SNMP_MIB_ITEM("DSSNoMatchTCP", MPTCP_MIB_DSSTCPMISMATCH),
 	SNMP_MIB_ITEM("DataCsumErr", MPTCP_MIB_DATACSUMERR),
diff --git a/net/mptcp/mib.h b/net/mptcp/mib.h
index 90025acdcf72..1b7f6d24904b 100644
--- a/net/mptcp/mib.h
+++ b/net/mptcp/mib.h
@@ -19,6 +19,8 @@ enum linux_mptcp_mib_field {
 	MPTCP_MIB_JOINACKRX,		/* Received an ACK + MP_JOIN */
 	MPTCP_MIB_JOINACKMAC,		/* HMAC was wrong on ACK + MP_JOIN */
 	MPTCP_MIB_DSSNOMATCH,		/* Received a new mapping that did not match the previous one */
+	MPTCP_MIB_DSSCORRUPTIONFALLBACK,/* DSS corruption detected, fallback */
+	MPTCP_MIB_DSSCORRUPTIONRESET,	/* DSS corruption detected, MPJ subflow reset */
 	MPTCP_MIB_INFINITEMAPRX,	/* Received an infinite mapping */
 	MPTCP_MIB_DSSTCPMISMATCH,	/* DSS-mapping did not map with TCP's sequence numbers */
 	MPTCP_MIB_DATACSUMERR,		/* The data checksum fail */
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 73a0b0d15382..34c98596350e 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -554,6 +554,18 @@ static bool mptcp_check_data_fin(struct sock *sk)
 	return ret;
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
@@ -626,10 +638,12 @@ static bool __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
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
index 412823af2c1d..7eff961267d0 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -847,7 +847,7 @@ static bool skb_is_fully_mapped(struct sock *ssk, struct sk_buff *skb)
 	unsigned int skb_consumed;
 
 	skb_consumed = tcp_sk(ssk)->copied_seq - TCP_SKB_CB(skb)->seq;
-	if (WARN_ON_ONCE(skb_consumed >= skb->len))
+	if (unlikely(skb_consumed >= skb->len))
 		return true;
 
 	return skb->len - skb_consumed <= subflow->map_data_len -
-- 
2.45.2


