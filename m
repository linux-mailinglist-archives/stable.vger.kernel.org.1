Return-Path: <stable+bounces-70182-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 159A895F091
	for <lists+stable@lfdr.de>; Mon, 26 Aug 2024 14:08:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AF9B1C22725
	for <lists+stable@lfdr.de>; Mon, 26 Aug 2024 12:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDCF718BC01;
	Mon, 26 Aug 2024 12:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jc5bWRup"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0E21714B3
	for <stable@vger.kernel.org>; Mon, 26 Aug 2024 12:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724673958; cv=none; b=oPxiWVRTiFbkbvO+aS0Wdi/5QUErCjfarTbqLS/v/r4bdiF+7fAg5qtq6WppiFEKkaQUs7+p5wyLmN5rMKyv4249GdFdnO+YGWhwnuV1sC5NYMTKo0uOPRL1ghzIJhKe+JSu65eKmCbpJRDoBhIX2tFirHBSCIn/Gg+x2o8vv8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724673958; c=relaxed/simple;
	bh=ukw/89SFA7idQ6Oq+a7SS/xJXpVOPnS/jiP34sVizig=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ghsAVNCz6TYbTqVOP9j8/gj5t94nkE+wuPSJv+DE/MO/kOYRYV2VmQB+TXPttVyM7F0LnRGe92bQ60gND1uDCpsB95NA8CQ6MpzovaHOA6NW5tisU9BM37uphDhvS02ck8BNk5GtrFp7DQii+MVPz1IMynKrMySFURC9C8J9Bjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jc5bWRup; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9766C5140C;
	Mon, 26 Aug 2024 12:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724673958;
	bh=ukw/89SFA7idQ6Oq+a7SS/xJXpVOPnS/jiP34sVizig=;
	h=Subject:To:Cc:From:Date:From;
	b=jc5bWRupUNtq6+r4Bsh0kqvGnvCbGFlxaN4LPI9CYrJHWq92aEo6oTniclR72Z8EK
	 bzCTuQ1UKpiGhArDigALU0F4hReRJd3v4DpozU2/qxhXXlHXSd9/UBNk1FnurpF6Ns
	 v6mZ53ybx/PTebCpbuHcTcps/CJPFzNDo9w6Trlg=
Subject: FAILED: patch "[PATCH] mptcp: pm: remove mptcp_pm_remove_subflow()" failed to apply to 6.1-stable tree
To: matttbe@kernel.org,kuba@kernel.org,martineau@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 26 Aug 2024 14:05:55 +0200
Message-ID: <2024082655-frostily-embellish-9960@gregkh>
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
git cherry-pick -x f448451aa62d54be16acb0034223c17e0d12bc69
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024082655-frostily-embellish-9960@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

f448451aa62d ("mptcp: pm: remove mptcp_pm_remove_subflow()")
ef34a6ea0cab ("mptcp: pm: re-using ID of unused flushed subflows")
edd8b5d868a4 ("mptcp: pm: re-using ID of unused removed subflows")
4b317e0eb287 ("mptcp: fix NL PM announced address accounting")
9bbec87ecfe8 ("mptcp: unify pm get_local_id interfaces")
dc886bce753c ("mptcp: export local_address")
8b1c94da1e48 ("mptcp: only send RM_ADDR in nl_cmd_remove")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f448451aa62d54be16acb0034223c17e0d12bc69 Mon Sep 17 00:00:00 2001
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 19 Aug 2024 21:45:25 +0200
Subject: [PATCH] mptcp: pm: remove mptcp_pm_remove_subflow()

This helper is confusing. It is in pm.c, but it is specific to the
in-kernel PM and it cannot be used by the userspace one. Also, it simply
calls one in-kernel specific function with the PM lock, while the
similar mptcp_pm_remove_addr() helper requires the PM lock.

What's left is the pr_debug(), which is not that useful, because a
similar one is present in the only function called by this helper:

  mptcp_pm_nl_rm_subflow_received()

After these modifications, this helper can be marked as 'static', and
the lock can be taken only once in mptcp_pm_flush_addrs_and_subflows().

Note that it is not a bug fix, but it will help backporting the
following commits.

Fixes: 0ee4261a3681 ("mptcp: implement mptcp_pm_remove_subflow")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20240819-net-mptcp-pm-reusing-id-v1-7-38035d40de5b@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 23bb89c94e90..925123e99889 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -60,16 +60,6 @@ int mptcp_pm_remove_addr(struct mptcp_sock *msk, const struct mptcp_rm_list *rm_
 	return 0;
 }
 
-int mptcp_pm_remove_subflow(struct mptcp_sock *msk, const struct mptcp_rm_list *rm_list)
-{
-	pr_debug("msk=%p, rm_list_nr=%d", msk, rm_list->nr);
-
-	spin_lock_bh(&msk->pm.lock);
-	mptcp_pm_nl_rm_subflow_received(msk, rm_list);
-	spin_unlock_bh(&msk->pm.lock);
-	return 0;
-}
-
 /* path manager event handlers */
 
 void mptcp_pm_new_connection(struct mptcp_sock *msk, const struct sock *ssk, int server_side)
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 2c26696b820e..44fc1c5959ac 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -857,8 +857,8 @@ static void mptcp_pm_nl_rm_addr_received(struct mptcp_sock *msk)
 	mptcp_pm_nl_rm_addr_or_subflow(msk, &msk->pm.rm_list_rx, MPTCP_MIB_RMADDR);
 }
 
-void mptcp_pm_nl_rm_subflow_received(struct mptcp_sock *msk,
-				     const struct mptcp_rm_list *rm_list)
+static void mptcp_pm_nl_rm_subflow_received(struct mptcp_sock *msk,
+					    const struct mptcp_rm_list *rm_list)
 {
 	mptcp_pm_nl_rm_addr_or_subflow(msk, rm_list, MPTCP_MIB_RMSUBFLOW);
 }
@@ -1471,7 +1471,9 @@ static int mptcp_nl_remove_subflow_and_signal_addr(struct net *net,
 					  !(entry->flags & MPTCP_PM_ADDR_FLAG_IMPLICIT));
 
 		if (remove_subflow) {
-			mptcp_pm_remove_subflow(msk, &list);
+			spin_lock_bh(&msk->pm.lock);
+			mptcp_pm_nl_rm_subflow_received(msk, &list);
+			spin_unlock_bh(&msk->pm.lock);
 		} else if (entry->flags & MPTCP_PM_ADDR_FLAG_SUBFLOW) {
 			/* If the subflow has been used, but now closed */
 			spin_lock_bh(&msk->pm.lock);
@@ -1617,18 +1619,14 @@ static void mptcp_pm_remove_addrs_and_subflows(struct mptcp_sock *msk,
 			alist.ids[alist.nr++] = entry->addr.id;
 	}
 
+	spin_lock_bh(&msk->pm.lock);
 	if (alist.nr) {
-		spin_lock_bh(&msk->pm.lock);
 		msk->pm.add_addr_signaled -= alist.nr;
 		mptcp_pm_remove_addr(msk, &alist);
-		spin_unlock_bh(&msk->pm.lock);
 	}
-
 	if (slist.nr)
-		mptcp_pm_remove_subflow(msk, &slist);
-
+		mptcp_pm_nl_rm_subflow_received(msk, &slist);
 	/* Reset counters: maybe some subflows have been removed before */
-	spin_lock_bh(&msk->pm.lock);
 	bitmap_fill(msk->pm.id_avail_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
 	msk->pm.local_addr_used = 0;
 	spin_unlock_bh(&msk->pm.lock);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 60c6b073d65f..a1c1b0ff1ce1 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1026,7 +1026,6 @@ int mptcp_pm_announce_addr(struct mptcp_sock *msk,
 			   const struct mptcp_addr_info *addr,
 			   bool echo);
 int mptcp_pm_remove_addr(struct mptcp_sock *msk, const struct mptcp_rm_list *rm_list);
-int mptcp_pm_remove_subflow(struct mptcp_sock *msk, const struct mptcp_rm_list *rm_list);
 void mptcp_pm_remove_addrs(struct mptcp_sock *msk, struct list_head *rm_list);
 
 void mptcp_free_local_addr_list(struct mptcp_sock *msk);
@@ -1133,8 +1132,6 @@ static inline u8 subflow_get_local_id(const struct mptcp_subflow_context *subflo
 
 void __init mptcp_pm_nl_init(void);
 void mptcp_pm_nl_work(struct mptcp_sock *msk);
-void mptcp_pm_nl_rm_subflow_received(struct mptcp_sock *msk,
-				     const struct mptcp_rm_list *rm_list);
 unsigned int mptcp_pm_get_add_addr_signal_max(const struct mptcp_sock *msk);
 unsigned int mptcp_pm_get_add_addr_accept_max(const struct mptcp_sock *msk);
 unsigned int mptcp_pm_get_subflows_max(const struct mptcp_sock *msk);


