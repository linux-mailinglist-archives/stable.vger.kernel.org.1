Return-Path: <stable+bounces-71592-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CF3C965F04
	for <lists+stable@lfdr.de>; Fri, 30 Aug 2024 12:26:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 159DD1F21160
	for <lists+stable@lfdr.de>; Fri, 30 Aug 2024 10:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24784189908;
	Fri, 30 Aug 2024 10:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="l75obh8+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E94178378
	for <stable@vger.kernel.org>; Fri, 30 Aug 2024 10:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725013376; cv=none; b=eULnUhYGjxXGie8h4gkUIqiTUw0FGcgDTyLyUk6VvFQyYlTrjBlvR9iaMfMJF5DVWFvb9d+OvKudDoHKHeWFUl7U4DEeX4e0R32HMfYzzBdllZeJtnuzamF7XqTAkqHaW287EjX5oPnA6nCHtr0qR/Fe8/UrJ3wy67Ln2IoyegU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725013376; c=relaxed/simple;
	bh=Cw+dS4zFkLspOohy5upD/rRun0gmFgWtDL8drcnPPvg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=M6qcJqsPv1peEDdabsg9Tb7MmUa66CSTGF4LUc8zANcdaFTCbToIMifH85EQzrO35ppWWRCtMsk2x0s+AQE4N1hzPavdgew7p3eB1XC2pyPeGP0bO94fAH+BQPwIt8mX09SpugGgwS7zOM3FBxLUMdxh1koL/2q6vogjmAtCUes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=l75obh8+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13AD7C4CEC2;
	Fri, 30 Aug 2024 10:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725013376;
	bh=Cw+dS4zFkLspOohy5upD/rRun0gmFgWtDL8drcnPPvg=;
	h=Subject:To:Cc:From:Date:From;
	b=l75obh8+AVm/D/cdxvlpBV5ZA8s+mGB8GkmCmgJo6kZ7ANB+QupZLuvGKG/ZrsEsP
	 7BVjHbkASdxw5Jo9OKwiM6WbPqfOJh/WfWArHvpkMlbaBkIB+aI7FC9Ih/7UhwtSMM
	 pi0HgtS0gAjHfiOFuL+Ax8Q3qH/fYDYmb0tUrGWM=
Subject: FAILED: patch "[PATCH] mptcp: pm: fix RM_ADDR ID for the initial subflow" failed to apply to 6.1-stable tree
To: matttbe@kernel.org,martineau@kernel.org,pabeni@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 30 Aug 2024 12:22:45 +0200
Message-ID: <2024083045-mosaic-sniff-fe02@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 87b5896f3f7848130095656739b05881904e2697
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024083045-mosaic-sniff-fe02@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

87b5896f3f78 ("mptcp: pm: fix RM_ADDR ID for the initial subflow")
edd8b5d868a4 ("mptcp: pm: re-using ID of unused removed subflows")
4b317e0eb287 ("mptcp: fix NL PM announced address accounting")
e38b117d7f3b ("mptcp: make pm_remove_addrs_and_subflows static")
8b1c94da1e48 ("mptcp: only send RM_ADDR in nl_cmd_remove")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 87b5896f3f7848130095656739b05881904e2697 Mon Sep 17 00:00:00 2001
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 28 Aug 2024 08:14:25 +0200
Subject: [PATCH] mptcp: pm: fix RM_ADDR ID for the initial subflow

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

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index ec45ab4c66ab..42d4e7b5f65d 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -800,11 +800,6 @@ int mptcp_pm_nl_mp_prio_send_ack(struct mptcp_sock *msk,
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
@@ -839,7 +834,7 @@ static void mptcp_pm_nl_rm_addr_or_subflow(struct mptcp_sock *msk,
 
 			if (rm_type == MPTCP_MIB_RMADDR && remote_id != rm_id)
 				continue;
-			if (rm_type == MPTCP_MIB_RMSUBFLOW && !mptcp_local_id_match(msk, id, rm_id))
+			if (rm_type == MPTCP_MIB_RMSUBFLOW && id != rm_id)
 				continue;
 
 			pr_debug(" -> %s rm_list_ids[%d]=%u local_id=%u remote_id=%u mpc_id=%u\n",
@@ -1448,6 +1443,12 @@ static bool remove_anno_list_by_saddr(struct mptcp_sock *msk,
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
@@ -1455,7 +1456,7 @@ static bool mptcp_pm_remove_anno_addr(struct mptcp_sock *msk,
 	struct mptcp_rm_list list = { .nr = 0 };
 	bool ret;
 
-	list.ids[list.nr++] = addr->id;
+	list.ids[list.nr++] = mptcp_endp_get_local_id(msk, addr);
 
 	ret = remove_anno_list_by_saddr(msk, addr);
 	if (ret || force) {
@@ -1482,14 +1483,12 @@ static int mptcp_nl_remove_subflow_and_signal_addr(struct net *net,
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
@@ -1507,6 +1506,7 @@ static int mptcp_nl_remove_subflow_and_signal_addr(struct net *net,
 		mptcp_pm_remove_anno_addr(msk, addr, remove_subflow &&
 					  !(entry->flags & MPTCP_PM_ADDR_FLAG_IMPLICIT));
 
+		list.ids[0] = mptcp_endp_get_local_id(msk, addr);
 		if (remove_subflow) {
 			spin_lock_bh(&msk->pm.lock);
 			mptcp_pm_nl_rm_subflow_received(msk, &list);
@@ -1613,6 +1613,7 @@ int mptcp_pm_nl_del_addr_doit(struct sk_buff *skb, struct genl_info *info)
 	return ret;
 }
 
+/* Called from the userspace PM only */
 void mptcp_pm_remove_addrs(struct mptcp_sock *msk, struct list_head *rm_list)
 {
 	struct mptcp_rm_list alist = { .nr = 0 };
@@ -1641,6 +1642,7 @@ void mptcp_pm_remove_addrs(struct mptcp_sock *msk, struct list_head *rm_list)
 	}
 }
 
+/* Called from the in-kernel PM only */
 static void mptcp_pm_remove_addrs_and_subflows(struct mptcp_sock *msk,
 					       struct list_head *rm_list)
 {
@@ -1650,11 +1652,11 @@ static void mptcp_pm_remove_addrs_and_subflows(struct mptcp_sock *msk,
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
@@ -1951,7 +1953,7 @@ static void mptcp_pm_nl_fullmesh(struct mptcp_sock *msk,
 {
 	struct mptcp_rm_list list = { .nr = 0 };
 
-	list.ids[list.nr++] = addr->id;
+	list.ids[list.nr++] = mptcp_endp_get_local_id(msk, addr);
 
 	spin_lock_bh(&msk->pm.lock);
 	mptcp_pm_nl_rm_subflow_received(msk, &list);


