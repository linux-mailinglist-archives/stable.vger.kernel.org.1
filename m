Return-Path: <stable+bounces-66254-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3B4094CF04
	for <lists+stable@lfdr.de>; Fri,  9 Aug 2024 12:55:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B237528398D
	for <lists+stable@lfdr.de>; Fri,  9 Aug 2024 10:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AF7A192B61;
	Fri,  9 Aug 2024 10:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rSbw9hTT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F801922F7;
	Fri,  9 Aug 2024 10:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723200951; cv=none; b=tUCs3Q7MHkZ1kZLfTXZiwrXpPYMz/EorKzMO6vP13XO0ti86wL30z1NJ+FXy3/8KfeVnqcLAkMt71DZ647msy0K7Y2xxIxDu/7FKqMpZ4Vs6vfRqLMG9bhebKtIuosiEloc/JOwhD7C/pFMfQ5u/Emwy9Hn6i7aEVVQ2JOmDULs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723200951; c=relaxed/simple;
	bh=dTJcd+iq4efZCitXEacCWTgrwc5q61UcgjedxnRqh6s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MbWgL/CnZeMhAZZD/k0wm9MXAHFG/tF0tSyz3PZhlxtBvTJR5feM98gas7281r/DGgItGNtV4ewW1nxxkBkWhwYjIQJmiNkRUiBqQ20FBZfhrmvaYC1r4XX7L+XCiQuz80Tc4YHxSw+vjDjUEP4GukTU6vDz8oGNAYUEcMmaykc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rSbw9hTT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1675AC32782;
	Fri,  9 Aug 2024 10:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723200951;
	bh=dTJcd+iq4efZCitXEacCWTgrwc5q61UcgjedxnRqh6s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rSbw9hTTubjCdHZNQXlTfiQ5dTtHrN4hBIhW3Bj6egDXGyPP8oS6QphLFwBSq81NG
	 Bxq9j75Q0ynrtwjrxRLUSRu/cJ6kTh687LEbqo3Eg1DfjfzTzsr+IcFmZf2V84Rgej
	 3ZdyeJ4fUEg2Pf+EOF7q2BLViVyllk+a4s73n8NyvG/BhWFwbursdDJw5U/aWJqg1U
	 9ytiqFp0skwG8WYF0cl6lmFsv6BPHqTslIBPc1zjgoIG/ep8/M8ddzg1p52Bm7ZOXZ
	 2J2oaDgs9OHM7Hs5es+k9orx/vhAE3WfWKU36Ykx5SdsPoUbOoVUBJ5Z7UIzNoT3+O
	 9oy4ei9nUna7w==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>,
	Geliang Tang <geliang.tang@suse.com>,
	Matthieu Baerts <matthieu.baerts@tessares.net>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Matthieu Baerts <matttbe@kernel.org>
Subject: [PATCH 5.10.y 1/2] mptcp: export local_address
Date: Fri,  9 Aug 2024 12:55:39 +0200
Message-ID: <20240809105538.2903162-3-matttbe@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <2024080729-unclaimed-shopping-6751@gregkh>
References: <2024080729-unclaimed-shopping-6751@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3105; i=matttbe@kernel.org; h=from:subject; bh=Bo8LhQPnevBrxk4LqwDqjlNSJ4SnRUd44o/uKGrw/Zw=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmtfWqgg4G4DvbhC9aQ+EHa2PipC3Y2YENrCFXG VW6jRe2EUKJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZrX1qgAKCRD2t4JPQmmg c5beD/9be2j/VqKV34a0EPNY59fTYjozydHk7PFeVgZxVTpXDMbDbJgY8SJYGLP8eD4aD11rnik HZfxxNVRkFVwoSQTq22boF0BcyUeKAIENvmXWy8KEBaLruyjiP2bSTGjP/nVfoA0DoslSWfLYBD Wi52BcRuKMPdFPOLz1Y9IbvFW2PAB7mItpGGD15xs97jpbpqUKd8syF9hmBw76fJ7Dek9cSYSKa 9p274IkOklpiy5UpG7KFlvUaQc3wBjTp0Ywgcbs6ImTUW5y8XB8woNWO9inao1bf3Mq1xshVj/z 5fyWx0znVC9BeGoSEKw3uEgQZ4H4WToQqawlLFg+OGSjROsRp+peTZxokIpU/hI4jZVWrPy4SM1 ZI1BLlybsjLKfqbaYGQwTWL+y2cP3c6ejsw8V08d8TfXZpJqj6kfFaLGINgY5YATDymaTDAZC11 AZWRHliHsye05QpbpNrF3ET4HeUxJHDUCSuTYu79KUQ1GHpBpxj0S6fz8H0KtGN4XIBXmHgiZMu mtL0SVIjt10WEk0SR0IkFW51glEFVSM2xSmmV1iGGkEnXHxlKZ4biiKMWk3p16EVTp5JrjnOr0c TQ77y/1WjMYTAZ99vjVi3JP/pF1ttUY+AN0mBSE+lQJ85vvv2G9iebg6rVaIHNoXk0T9F43bjBU XC8kYNTULHlrsvw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

From: Geliang Tang <geliang.tang@suse.com>

commit dc886bce753cc2cf3c88ec5c7a6880a4e17d65ba upstream.

Rename local_address() with "mptcp_" prefix and export it in protocol.h.

This function will be re-used in the common PM code (pm.c) in the
following commit.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Reviewed-by: Larysa Zaremba <larysa.zaremba@intel.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 6834097fc38c ("mptcp: pm: fix backup support in signal endpoints")
[ Conflicts in pm_netlink.c and protocol.h, because the context has
  changed in commit 4638de5aefe5 ("mptcp: handle local addrs announced
  by userspace PMs") which is not in this version. This commit is
  unrelated to this modification. Also some parts using 'local_address'
  are not in this version, that's OK, we don't need to do anything with
  them. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c | 9 ++++-----
 net/mptcp/protocol.h   | 1 +
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 7f4d84f5189b..6a0079d42dc4 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -84,8 +84,7 @@ static bool address_zero(const struct mptcp_addr_info *addr)
 	return addresses_equal(addr, &zero, false);
 }
 
-static void local_address(const struct sock_common *skc,
-			  struct mptcp_addr_info *addr)
+void mptcp_local_address(const struct sock_common *skc, struct mptcp_addr_info *addr)
 {
 	addr->port = 0;
 	addr->family = skc->skc_family;
@@ -120,7 +119,7 @@ static bool lookup_subflow_by_saddr(const struct list_head *list,
 	list_for_each_entry(subflow, list, node) {
 		skc = (struct sock_common *)mptcp_subflow_tcp_sock(subflow);
 
-		local_address(skc, &cur);
+		mptcp_local_address(skc, &cur);
 		if (addresses_equal(&cur, saddr, false))
 			return true;
 	}
@@ -533,8 +532,8 @@ int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct sock_common *skc)
 	/* The 0 ID mapping is defined by the first subflow, copied into the msk
 	 * addr
 	 */
-	local_address((struct sock_common *)msk, &msk_local);
-	local_address((struct sock_common *)skc, &skc_local);
+	mptcp_local_address((struct sock_common *)msk, &msk_local);
+	mptcp_local_address((struct sock_common *)skc, &skc_local);
 	if (addresses_equal(&msk_local, &skc_local, false))
 		return 0;
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index b5978bb4022f..ddfc7bde8c90 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -372,6 +372,7 @@ void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 		       struct mptcp_subflow_context *subflow,
 		       long timeout);
 void mptcp_subflow_reset(struct sock *ssk);
+void mptcp_local_address(const struct sock_common *skc, struct mptcp_addr_info *addr);
 
 /* called with sk socket lock held */
 int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_addr_info *loc,
-- 
2.45.2


