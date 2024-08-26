Return-Path: <stable+bounces-70183-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 502F195F0C1
	for <lists+stable@lfdr.de>; Mon, 26 Aug 2024 14:11:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A2581C23095
	for <lists+stable@lfdr.de>; Mon, 26 Aug 2024 12:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58F4A1741C0;
	Mon, 26 Aug 2024 12:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eLA5PJQD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195ED172BA6
	for <stable@vger.kernel.org>; Mon, 26 Aug 2024 12:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724673968; cv=none; b=k7Bn8x+kTf970BGrTh7VQVEBpUWXHyyFpo2gbJImoCzRfAZYp3/6QehIDOsnauLUkbkqqJtb19dKN4/1w/Xjr6q3N6GEV/t2YPvc8BFLY7tAY3fu/RKJwj7brdesYJEaw7HtKaiqD0NJfkhFv+skkSr6NKPo6/dxjebo2iBNC8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724673968; c=relaxed/simple;
	bh=SecEHB+8swUzQbaRkDIUBgGpdvzTHrhFEuyaFU6LCN4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Z9kfVrFR9MNB48ZtABm+qw92ZxDoELzWJYj83/btiQxnYY2AVgXBpyI3o8y99G5w0Qhz98+gWirNteCHKtOMOtVZj0+R9b2GaXSxNZZV6EcjbVABmDtq8yhf+JDjJsPKmAIi5jWo+1+a6AB9qQL1uzRk5wG1nGxpra3LI0SEgyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eLA5PJQD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23C1CC51418;
	Mon, 26 Aug 2024 12:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724673967;
	bh=SecEHB+8swUzQbaRkDIUBgGpdvzTHrhFEuyaFU6LCN4=;
	h=Subject:To:Cc:From:Date:From;
	b=eLA5PJQDLWG6yYEOgd4f1tzsGzNVP8dEuZlKFnT1BLYziGcPJ26xfPkvqtM+omFeN
	 rAyrbZBnSfKSQ4mTccDrLWTGZMSWACzWkfiPYdf4fY409FoWJYJCtv80T7m6Feg8ve
	 AQrSmUtBubmus1a+qoInHOCSydZRuFzZNsrDDz/A=
Subject: FAILED: patch "[PATCH] mptcp: pm: remove mptcp_pm_remove_subflow()" failed to apply to 5.15-stable tree
To: matttbe@kernel.org,kuba@kernel.org,martineau@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 26 Aug 2024 14:05:56 +0200
Message-ID: <2024082656-shield-daily-d746@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x f448451aa62d54be16acb0034223c17e0d12bc69
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024082656-shield-daily-d746@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

f448451aa62d ("mptcp: pm: remove mptcp_pm_remove_subflow()")
ef34a6ea0cab ("mptcp: pm: re-using ID of unused flushed subflows")
edd8b5d868a4 ("mptcp: pm: re-using ID of unused removed subflows")
4b317e0eb287 ("mptcp: fix NL PM announced address accounting")
9bbec87ecfe8 ("mptcp: unify pm get_local_id interfaces")
dc886bce753c ("mptcp: export local_address")
8b1c94da1e48 ("mptcp: only send RM_ADDR in nl_cmd_remove")
c157bbe776b7 ("mptcp: allow the in kernel PM to set MPC subflow priority")
d9a4594edabf ("mptcp: netlink: Add MPTCP_PM_CMD_REMOVE")
9ab4807c84a4 ("mptcp: netlink: Add MPTCP_PM_CMD_ANNOUNCE")
982f17ba1a25 ("mptcp: netlink: split mptcp_pm_parse_addr into two functions")
8b20137012d9 ("mptcp: read attributes of addr entries managed by userspace PMs")
4638de5aefe5 ("mptcp: handle local addrs announced by userspace PMs")
c682bf536cf4 ("mptcp: add pm_nl_pernet helpers")
4cf86ae84c71 ("mptcp: strict local address ID selection")
d045b9eb95a9 ("mptcp: introduce implicit endpoints")
6fa0174a7c86 ("mptcp: more careful RM_ADDR generation")
7d9bf018f907 ("selftests: mptcp: update output info of chk_rm_nr")
90d930882139 ("mptcp: constify a bunch of of helpers")
33397b83eee6 ("selftests: mptcp: add backup with port testcase")

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


