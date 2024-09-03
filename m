Return-Path: <stable+bounces-72800-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B0A79699E6
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 12:17:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4038D2842DD
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 10:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69C581AD25C;
	Tue,  3 Sep 2024 10:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T+yR/a/d"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB4F1A0BC7;
	Tue,  3 Sep 2024 10:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725358624; cv=none; b=SysCTAMRDlKSjLeryIn4JXRDxoaDfsiIHIdCW7yi4twaZUezKqdUedCYIZDCZ1nQ4/MF2jR3oKylpV70wxN5ey5J3jH0r/P1s15F4s61lqG3JMugUj8v/VfdALLHOEhEjgNYbMUytCFD8CJFgOslrRn/gKn973FdRXlWiUWtiVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725358624; c=relaxed/simple;
	bh=TQiqazGLhtHKKUgi3NC65E/YTtGJeb3NUVBYQtIyOH4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wym3lUjl/j0FjtydG3Zq+jPaF/doT7cIexUpx1lH1dALpxkjahaKuOXu4F271qdzG+uh/dW1i3YpPn8/OAQkVOsDLJvAMSX8yUdbqCeMDCIx18aoTuWEsqYCcexU8rUULtG9D4aMcViiXainIIzFcTScHtusicbHbCMFgJCFPoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T+yR/a/d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EBB9C4CEC8;
	Tue,  3 Sep 2024 10:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725358623;
	bh=TQiqazGLhtHKKUgi3NC65E/YTtGJeb3NUVBYQtIyOH4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T+yR/a/dND88b44EHBN8Dt35TgEBHMZ0FXViHnCBc6EZEulUmu8yTMclsJvqUd13X
	 3eOJJv08MdVtHvP9LeZD+DglrUQCG1PTIuG26NsmOV5/t5LV7OUiAGSTzUnotscEmX
	 Sl3aPoBNwY3BDaOX7mqZJsWdf5+X2e1xijcBXZLqNCUrc0N95ZbuBdwgId/vWbzo2Y
	 kIlAk6gp/T0/aBFGxDWIUq/8rKT8AwTcscOhdXTIyF7NQru97874pjzD5F4S1XOMDr
	 RHCeXPpgG/eRUoWHbkEyOOQUpKJu7QRSO8PhZ3Dgr+9a2V17H8ut/0wb4K9vOiSI5z
	 l1CuBI3REw0uA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 6.6.y 2/2] mptcp: pm: fix RM_ADDR ID for the initial subflow
Date: Tue,  3 Sep 2024 12:16:57 +0200
Message-ID: <20240903101654.3376356-6-matttbe@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <2024083044-banked-tapered-91df@gregkh>
References: <2024083044-banked-tapered-91df@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5228; i=matttbe@kernel.org; h=from:subject; bh=TQiqazGLhtHKKUgi3NC65E/YTtGJeb3NUVBYQtIyOH4=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBm1uIW5RlkwCIBaahV90++gp1nT2pzCG1XazOPS e6QGdrHmr+JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZtbiFgAKCRD2t4JPQmmg c/VgD/0bg0IhETuJzKNSd6qZUoJyH7zdFu0xU2ChLDiYPu726RSUNEbtgk5cpZQXX6Hs7pE0QLM 4nxxMu1qg1qqXbZg3OXGKkTltE2M0EbobYIRY4ol/AygYtTcC55qAfKWkqMpgrXgokucM/wSuV8 fLXRJw6HGhlCYreNQHjV3R8ke6Twv+ZEA9CtaP7+PeuBHFlIDlD9atYixgyRvcpYl04SiafrP2r Ss6n0+y7Ey/LG10LytpEHndc2mavZ2RvcTdQb3Gwt4Q6pcr42kjUsivPFxTyBM3pAvjevURBMUP I7lDVNN5Hyt1Y+A0+owP3lz5UxCMVdxp/ICYOyCq6uqRdlNoRRC53G//znGs19Q1juwFwWzVfKt 7AlzQbN8CbbPLf8sORini33qNYg5YQRc2kEFUifq9/3sEu5Leb+drTZQlrKDXfqi528Lxj6flsV lnI0Pr/PxgOJq6y5pwXzSH0GclTdnav+9AxQK6+/caNGsRwXhSKA4yBU6rxPAQmx4g1hVT2Wyx+ M6KrHjqw/tujtyv0Zy26GvE6p53rCL+jN6zjJBVfODu42wPqO/ggYZ1JOh+kbHDfxeNSAcUrB4I Kv+a04TBT2XIHXHCgL5w/oZ+yBrJ3A2YCg3b+W3T8bXwDH1GuhkFvr+AIUWCTH0FBG3EKjghoX4 ACq/WOpCoiYQJHQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

commit 87b5896f3f7848130095656739b05881904e2697 upstream.

The initial subflow has a special local ID: 0. When an endpoint is being
deleted, it is then important to check if its address is not linked to
the initial subflow to send the right ID.

If there was an endpoint linked to the initial subflow, msk's
mpc_endpoint_id field will be set. We can then use this info when an
endpoint is being removed to see if it is linked to the initial subflow.

So now, the correct IDs are passed to mptcp_pm_nl_rm_addr_or_subflow(),
it is no longer needed to use mptcp_local_id_match().

Fixes: 3ad14f54bd74 ("mptcp: more accurate MPC endpoint tracking")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index fa4668c2d6b3..d5902e7f47a7 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -826,11 +826,6 @@ int mptcp_pm_nl_mp_prio_send_ack(struct mptcp_sock *msk,
 	return -EINVAL;
 }
 
-static bool mptcp_local_id_match(const struct mptcp_sock *msk, u8 local_id, u8 id)
-{
-	return local_id == id || (!local_id && msk->mpc_endpoint_id == id);
-}
-
 static void mptcp_pm_nl_rm_addr_or_subflow(struct mptcp_sock *msk,
 					   const struct mptcp_rm_list *rm_list,
 					   enum linux_mptcp_mib_field rm_type)
@@ -867,7 +862,7 @@ static void mptcp_pm_nl_rm_addr_or_subflow(struct mptcp_sock *msk,
 				continue;
 			if (rm_type == MPTCP_MIB_RMADDR && remote_id != rm_id)
 				continue;
-			if (rm_type == MPTCP_MIB_RMSUBFLOW && !mptcp_local_id_match(msk, id, rm_id))
+			if (rm_type == MPTCP_MIB_RMSUBFLOW && id != rm_id)
 				continue;
 
 			pr_debug(" -> %s rm_list_ids[%d]=%u local_id=%u remote_id=%u mpc_id=%u\n",
@@ -1506,6 +1501,12 @@ static bool remove_anno_list_by_saddr(struct mptcp_sock *msk,
 	return false;
 }
 
+static u8 mptcp_endp_get_local_id(struct mptcp_sock *msk,
+				  const struct mptcp_addr_info *addr)
+{
+	return msk->mpc_endpoint_id == addr->id ? 0 : addr->id;
+}
+
 static bool mptcp_pm_remove_anno_addr(struct mptcp_sock *msk,
 				      const struct mptcp_addr_info *addr,
 				      bool force)
@@ -1513,7 +1514,7 @@ static bool mptcp_pm_remove_anno_addr(struct mptcp_sock *msk,
 	struct mptcp_rm_list list = { .nr = 0 };
 	bool ret;
 
-	list.ids[list.nr++] = addr->id;
+	list.ids[list.nr++] = mptcp_endp_get_local_id(msk, addr);
 
 	ret = remove_anno_list_by_saddr(msk, addr);
 	if (ret || force) {
@@ -1540,14 +1541,12 @@ static int mptcp_nl_remove_subflow_and_signal_addr(struct net *net,
 						   const struct mptcp_pm_addr_entry *entry)
 {
 	const struct mptcp_addr_info *addr = &entry->addr;
-	struct mptcp_rm_list list = { .nr = 0 };
+	struct mptcp_rm_list list = { .nr = 1 };
 	long s_slot = 0, s_num = 0;
 	struct mptcp_sock *msk;
 
 	pr_debug("remove_id=%d\n", addr->id);
 
-	list.ids[list.nr++] = addr->id;
-
 	while ((msk = mptcp_token_iter_next(net, &s_slot, &s_num)) != NULL) {
 		struct sock *sk = (struct sock *)msk;
 		bool remove_subflow;
@@ -1565,6 +1564,7 @@ static int mptcp_nl_remove_subflow_and_signal_addr(struct net *net,
 		mptcp_pm_remove_anno_addr(msk, addr, remove_subflow &&
 					  !(entry->flags & MPTCP_PM_ADDR_FLAG_IMPLICIT));
 
+		list.ids[0] = mptcp_endp_get_local_id(msk, addr);
 		if (remove_subflow) {
 			spin_lock_bh(&msk->pm.lock);
 			mptcp_pm_nl_rm_subflow_received(msk, &list);
@@ -1673,6 +1673,7 @@ static int mptcp_nl_cmd_del_addr(struct sk_buff *skb, struct genl_info *info)
 	return ret;
 }
 
+/* Called from the userspace PM only */
 void mptcp_pm_remove_addrs(struct mptcp_sock *msk, struct list_head *rm_list)
 {
 	struct mptcp_rm_list alist = { .nr = 0 };
@@ -1701,6 +1702,7 @@ void mptcp_pm_remove_addrs(struct mptcp_sock *msk, struct list_head *rm_list)
 	}
 }
 
+/* Called from the in-kernel PM only */
 static void mptcp_pm_remove_addrs_and_subflows(struct mptcp_sock *msk,
 					       struct list_head *rm_list)
 {
@@ -1710,11 +1712,11 @@ static void mptcp_pm_remove_addrs_and_subflows(struct mptcp_sock *msk,
 	list_for_each_entry(entry, rm_list, list) {
 		if (slist.nr < MPTCP_RM_IDS_MAX &&
 		    lookup_subflow_by_saddr(&msk->conn_list, &entry->addr))
-			slist.ids[slist.nr++] = entry->addr.id;
+			slist.ids[slist.nr++] = mptcp_endp_get_local_id(msk, &entry->addr);
 
 		if (alist.nr < MPTCP_RM_IDS_MAX &&
 		    remove_anno_list_by_saddr(msk, &entry->addr))
-			alist.ids[alist.nr++] = entry->addr.id;
+			alist.ids[alist.nr++] = mptcp_endp_get_local_id(msk, &entry->addr);
 	}
 
 	spin_lock_bh(&msk->pm.lock);
@@ -2002,7 +2004,7 @@ static void mptcp_pm_nl_fullmesh(struct mptcp_sock *msk,
 {
 	struct mptcp_rm_list list = { .nr = 0 };
 
-	list.ids[list.nr++] = addr->id;
+	list.ids[list.nr++] = mptcp_endp_get_local_id(msk, addr);
 
 	spin_lock_bh(&msk->pm.lock);
 	mptcp_pm_nl_rm_subflow_received(msk, &list);
-- 
2.45.2


