Return-Path: <stable+bounces-66067-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A443794C18E
	for <lists+stable@lfdr.de>; Thu,  8 Aug 2024 17:36:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36AFF1F2874F
	for <lists+stable@lfdr.de>; Thu,  8 Aug 2024 15:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAECF18E77B;
	Thu,  8 Aug 2024 15:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E6l5aCtq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74AFCB674;
	Thu,  8 Aug 2024 15:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723131375; cv=none; b=u6Ip4GAmQPaHla1Pb3Oa014j/DkOEUwxr0nUJa1iTMjl6o3S/Eh2Y60PcQd6l7oqwwpIxDjArnav1QRUA9PLvpVeVJZRAsQVKJ6aEE5JCyD6i+dUhJtTPxrHOtK9p2uYsptUEVwKTcV1i0u6ektzfnDxgq3f+2RHiPHtbXdai3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723131375; c=relaxed/simple;
	bh=XToKBaAu2Ej5/DPByPhIzNOUHAPexafI/IpWGmeBLYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JoATq2acApSwRM/bTk3Of1Zb1WxTTz2cFhS7Jg7xFyw3ZBTfYdMFzC9yfKX5jpzy7fgvmy01O7l/7GY3CmYggs+TlJnvSbnunnDs/Bavok1xMcT9VJ7VPEk2C+FGIqYDB+62bd2hrHlOhV1iSrsmgE3VjwTg/rfMI8BcC8Bt9t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E6l5aCtq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16991C32782;
	Thu,  8 Aug 2024 15:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723131375;
	bh=XToKBaAu2Ej5/DPByPhIzNOUHAPexafI/IpWGmeBLYU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E6l5aCtqkJYW/zLansdqEEQUp/Jvr9BYjGbzPL6QBgzpLCfn/5Hci2q5dketjrRa4
	 H/q2t8FdRHNNRo7MxNvDLPfucfqo8b75/xR4W64+yDQ20/eSEBf3qC4g38hsCssYjB
	 MnILZO76mJ5PsW0ajANIaE7fbOMpGCKzjNFXI2eHTyVLqSkEVV8KAmdeX9aJzDDZoO
	 eY/O4ARufNG4ZRMrkkaY4Mo1/huTEfZNyFMkVGWFjw2gWEWKm4GzKm8BWup5w3PDaf
	 onFuzxktUEJn+q1Elym6/4cxKuVJsZ3s1rFcIWrdxbwGNoVp5FNWGFEWlyREjXwiRa
	 fVLE4LR6Ucvvg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>,
	Geliang Tang <geliang.tang@suse.com>,
	Matthieu Baerts <matthieu.baerts@tessares.net>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Matthieu Baerts <matttbe@kernel.org>
Subject: [PATCH 6.1.y 1/2] mptcp: export local_address
Date: Thu,  8 Aug 2024 17:35:47 +0200
Message-ID: <20240808153546.2315845-3-matttbe@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <2024080727-stricken-overact-90c5@gregkh>
References: <2024080727-stricken-overact-90c5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4254; i=matttbe@kernel.org; h=from:subject; bh=+ZCLarjMPG3AMa0ZnsNrpVwMUFDI8HiwSYVZNp9RdkM=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmtOXSZTxdPI6xKM/zaf46RstuLOXrWr/DHfCMv 3u5NWQ3oN+JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZrTl0gAKCRD2t4JPQmmg c65vD/45vQwk6W9VY4sYvIStDVfT5Y1RGTuINYgbaK6R+rm5gQQwJLbT14MsDO4u4DK+RX/i3/5 ndwxZOZPhM4ZfsaYZ9zUHueALVg5ZmJ3mrqIEmUNK77ect8galdruI3yQI9Rj62L9YFJ9Z4Ilww KaDI7WatkMkpbPtjm6WH6R+46DpM7cPjne7XGwIZDjGFCtkrd0wxjORRMsJLYreE22BIg4/Uy+1 aGdZDy6s+C+OwdffSLNnof7NWSbRBw6pgydGz06j7dKOkZ5jvZdtJUUIxcbLL6CCemD8dXd3VjJ DBrxw6BqYyYK15hQy0Fx5rgsfH23ozQsarwn+BQ+3XLStM9K5MO7/FDcurOvmIfAoBzROV3cE6s tZWHOT8Vdc/55gLvkje7LVnkK9XhekvmLJcAuE+v6Atuf2TQzuSWaBBT9slQEjISqBZQ86iJTGl xo8qCvPtjFg23I5zeYflc9wK2b5rr7rzJN5HSYQh4oCp4vGSr76ltZ07a4r0XuxyAVNQ8QNWz19 ZFUSUYhKZ/ByoVi8jH8fNB3xKjGGr59i+Wpf/ZP4fd9rMjfiqgbXzHJOwb4OCZSBDxpZxP3/K7Q t2oZNBlVjsd90DQyXrnC8hDz+X2MOIeGb2EnXR0PQKSkR9z/tmNLmcgo2Mj2EEi/EnytZjQUumI VR9ormRhn0eA/kQ==
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
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c | 17 ++++++++---------
 net/mptcp/protocol.h   |  1 +
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index e9dff6382581..223146a341b5 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -86,8 +86,7 @@ bool mptcp_addresses_equal(const struct mptcp_addr_info *a,
 	return a->port == b->port;
 }
 
-static void local_address(const struct sock_common *skc,
-			  struct mptcp_addr_info *addr)
+void mptcp_local_address(const struct sock_common *skc, struct mptcp_addr_info *addr)
 {
 	addr->family = skc->skc_family;
 	addr->port = htons(skc->skc_num);
@@ -122,7 +121,7 @@ static bool lookup_subflow_by_saddr(const struct list_head *list,
 	list_for_each_entry(subflow, list, node) {
 		skc = (struct sock_common *)mptcp_subflow_tcp_sock(subflow);
 
-		local_address(skc, &cur);
+		mptcp_local_address(skc, &cur);
 		if (mptcp_addresses_equal(&cur, saddr, saddr->port))
 			return true;
 	}
@@ -274,7 +273,7 @@ bool mptcp_pm_sport_in_anno_list(struct mptcp_sock *msk, const struct sock *sk)
 	struct mptcp_addr_info saddr;
 	bool ret = false;
 
-	local_address((struct sock_common *)sk, &saddr);
+	mptcp_local_address((struct sock_common *)sk, &saddr);
 
 	spin_lock_bh(&msk->pm.lock);
 	list_for_each_entry(entry, &msk->pm.anno_list, list) {
@@ -545,7 +544,7 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 		struct mptcp_addr_info mpc_addr;
 		bool backup = false;
 
-		local_address((struct sock_common *)msk->first, &mpc_addr);
+		mptcp_local_address((struct sock_common *)msk->first, &mpc_addr);
 		rcu_read_lock();
 		entry = __lookup_addr(pernet, &mpc_addr, false);
 		if (entry) {
@@ -753,7 +752,7 @@ int mptcp_pm_nl_mp_prio_send_ack(struct mptcp_sock *msk,
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 		struct mptcp_addr_info local, remote;
 
-		local_address((struct sock_common *)ssk, &local);
+		mptcp_local_address((struct sock_common *)ssk, &local);
 		if (!mptcp_addresses_equal(&local, addr, addr->port))
 			continue;
 
@@ -1072,8 +1071,8 @@ int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct sock_common *skc)
 	/* The 0 ID mapping is defined by the first subflow, copied into the msk
 	 * addr
 	 */
-	local_address((struct sock_common *)msk, &msk_local);
-	local_address((struct sock_common *)skc, &skc_local);
+	mptcp_local_address((struct sock_common *)msk, &msk_local);
+	mptcp_local_address((struct sock_common *)skc, &skc_local);
 	if (mptcp_addresses_equal(&msk_local, &skc_local, false))
 		return 0;
 
@@ -1507,7 +1506,7 @@ static int mptcp_nl_remove_id_zero_address(struct net *net,
 		if (list_empty(&msk->conn_list) || mptcp_pm_is_userspace(msk))
 			goto next;
 
-		local_address((struct sock_common *)msk, &msk_local);
+		mptcp_local_address((struct sock_common *)msk, &msk_local);
 		if (!mptcp_addresses_equal(&msk_local, addr, addr->port))
 			goto next;
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index a2b85eebb620..5954e559f130 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -618,6 +618,7 @@ void __mptcp_unaccepted_force_close(struct sock *sk);
 
 bool mptcp_addresses_equal(const struct mptcp_addr_info *a,
 			   const struct mptcp_addr_info *b, bool use_port);
+void mptcp_local_address(const struct sock_common *skc, struct mptcp_addr_info *addr);
 
 /* called with sk socket lock held */
 int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_addr_info *loc,
-- 
2.45.2


