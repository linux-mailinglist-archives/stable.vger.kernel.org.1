Return-Path: <stable+bounces-70186-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52D4E95F0D7
	for <lists+stable@lfdr.de>; Mon, 26 Aug 2024 14:12:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0639F288037
	for <lists+stable@lfdr.de>; Mon, 26 Aug 2024 12:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD0CD198A2A;
	Mon, 26 Aug 2024 12:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BQNKe6i6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DEE817BEA5
	for <stable@vger.kernel.org>; Mon, 26 Aug 2024 12:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724673999; cv=none; b=lsSzATK45qimBglBhSd5Y7F8YUqRqOFfAHfhhgbwtlSWGWEcSl69mopHH9kE/W5R6qPPbpVX30e1vS0KBTcEEe99yHqIWK1NecVuf2Ue0d/JKYT8QdvpQm4HEHoRnZ5yif33abxbSpahtBpRmgrbM+/aVYqT3tR0uaCbcCSZxFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724673999; c=relaxed/simple;
	bh=0+bQSWZOFrBHhgKGAxI2iHSZzcmQlvGJWOQWJiwDyvI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=NSZAGzW5jOKOK5ikiDX3iSr8uRQkNA68KWWcuFTwZeVDuuoSexXS9O23DZtbEKBD66Z3ZPpSddlZucInSI+J20pXDVmBf0Sv3YfYBWIga7erY4fJJpAZH8wlHcdBCjVTwK+mtd0jTLSorluNEDQ5AbOApENWtKC8qowRzd5PL/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BQNKe6i6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92405C51435;
	Mon, 26 Aug 2024 12:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724673999;
	bh=0+bQSWZOFrBHhgKGAxI2iHSZzcmQlvGJWOQWJiwDyvI=;
	h=Subject:To:Cc:From:Date:From;
	b=BQNKe6i6g6An7vQ4+plaLtgHkOXC8F95w2itE1FsrM8p4rmOAoPNgBT3fpm8fiA9t
	 09wtQogB9IlfDvmFvgEKBsPfcGo3dD7xVb/hkvCf8UKk1Vd+W0qFyQvR1v9QY/8tC4
	 rT3b1K3MEf55tswV69YU1Jt/AmDYW8Xd8gKMfDoE=
Subject: FAILED: patch "[PATCH] mptcp: pm: only mark 'subflow' endp as available" failed to apply to 5.15-stable tree
To: matttbe@kernel.org,kuba@kernel.org,martineau@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 26 Aug 2024 14:06:27 +0200
Message-ID: <2024082627-devotion-chewer-87af@gregkh>
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
git cherry-pick -x 322ea3778965da72862cca2a0c50253aacf65fe6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024082627-devotion-chewer-87af@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

322ea3778965 ("mptcp: pm: only mark 'subflow' endp as available")
f448451aa62d ("mptcp: pm: remove mptcp_pm_remove_subflow()")
ef34a6ea0cab ("mptcp: pm: re-using ID of unused flushed subflows")
edd8b5d868a4 ("mptcp: pm: re-using ID of unused removed subflows")
4b317e0eb287 ("mptcp: fix NL PM announced address accounting")
6a09788c1a66 ("mptcp: pm: inc RmAddr MIB counter once per RM_ADDR ID")
9bbec87ecfe8 ("mptcp: unify pm get_local_id interfaces")
dc886bce753c ("mptcp: export local_address")
8b1c94da1e48 ("mptcp: only send RM_ADDR in nl_cmd_remove")
3ad14f54bd74 ("mptcp: more accurate MPC endpoint tracking")
c157bbe776b7 ("mptcp: allow the in kernel PM to set MPC subflow priority")
843b5e75efff ("mptcp: fix local endpoint accounting")
d9a4594edabf ("mptcp: netlink: Add MPTCP_PM_CMD_REMOVE")
9ab4807c84a4 ("mptcp: netlink: Add MPTCP_PM_CMD_ANNOUNCE")
982f17ba1a25 ("mptcp: netlink: split mptcp_pm_parse_addr into two functions")
8b20137012d9 ("mptcp: read attributes of addr entries managed by userspace PMs")
4638de5aefe5 ("mptcp: handle local addrs announced by userspace PMs")
0530020a7c8f ("mptcp: track and update contiguous data status")
0348c690ed37 ("mptcp: add the fallback check")
1761fed25678 ("mptcp: don't send RST for single subflow")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 322ea3778965da72862cca2a0c50253aacf65fe6 Mon Sep 17 00:00:00 2001
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 19 Aug 2024 21:45:26 +0200
Subject: [PATCH] mptcp: pm: only mark 'subflow' endp as available

Adding the following warning ...

  WARN_ON_ONCE(msk->pm.local_addr_used == 0)

... before decrementing the local_addr_used counter helped to find a bug
when running the "remove single address" subtest from the mptcp_join.sh
selftests.

Removing a 'signal' endpoint will trigger the removal of all subflows
linked to this endpoint via mptcp_pm_nl_rm_addr_or_subflow() with
rm_type == MPTCP_MIB_RMSUBFLOW. This will decrement the local_addr_used
counter, which is wrong in this case because this counter is linked to
'subflow' endpoints, and here it is a 'signal' endpoint that is being
removed.

Now, the counter is decremented, only if the ID is being used outside
of mptcp_pm_nl_rm_addr_or_subflow(), only for 'subflow' endpoints, and
if the ID is not 0 -- local_addr_used is not taking into account these
ones. This marking of the ID as being available, and the decrement is
done no matter if a subflow using this ID is currently available,
because the subflow could have been closed before.

Fixes: 06faa2271034 ("mptcp: remove multi addresses and subflows in PM")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20240819-net-mptcp-pm-reusing-id-v1-8-38035d40de5b@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 44fc1c5959ac..4cf7cc851f80 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -833,10 +833,10 @@ static void mptcp_pm_nl_rm_addr_or_subflow(struct mptcp_sock *msk,
 			if (rm_type == MPTCP_MIB_RMSUBFLOW)
 				__MPTCP_INC_STATS(sock_net(sk), rm_type);
 		}
-		if (rm_type == MPTCP_MIB_RMSUBFLOW)
-			__set_bit(rm_id ? rm_id : msk->mpc_endpoint_id, msk->pm.id_avail_bitmap);
-		else if (rm_type == MPTCP_MIB_RMADDR)
+
+		if (rm_type == MPTCP_MIB_RMADDR)
 			__MPTCP_INC_STATS(sock_net(sk), rm_type);
+
 		if (!removed)
 			continue;
 
@@ -846,8 +846,6 @@ static void mptcp_pm_nl_rm_addr_or_subflow(struct mptcp_sock *msk,
 		if (rm_type == MPTCP_MIB_RMADDR) {
 			msk->pm.add_addr_accepted--;
 			WRITE_ONCE(msk->pm.accept_addr, true);
-		} else if (rm_type == MPTCP_MIB_RMSUBFLOW) {
-			msk->pm.local_addr_used--;
 		}
 	}
 }
@@ -1441,6 +1439,14 @@ static bool mptcp_pm_remove_anno_addr(struct mptcp_sock *msk,
 	return ret;
 }
 
+static void __mark_subflow_endp_available(struct mptcp_sock *msk, u8 id)
+{
+	/* If it was marked as used, and not ID 0, decrement local_addr_used */
+	if (!__test_and_set_bit(id ? : msk->mpc_endpoint_id, msk->pm.id_avail_bitmap) &&
+	    id && !WARN_ON_ONCE(msk->pm.local_addr_used == 0))
+		msk->pm.local_addr_used--;
+}
+
 static int mptcp_nl_remove_subflow_and_signal_addr(struct net *net,
 						   const struct mptcp_pm_addr_entry *entry)
 {
@@ -1474,11 +1480,11 @@ static int mptcp_nl_remove_subflow_and_signal_addr(struct net *net,
 			spin_lock_bh(&msk->pm.lock);
 			mptcp_pm_nl_rm_subflow_received(msk, &list);
 			spin_unlock_bh(&msk->pm.lock);
-		} else if (entry->flags & MPTCP_PM_ADDR_FLAG_SUBFLOW) {
-			/* If the subflow has been used, but now closed */
+		}
+
+		if (entry->flags & MPTCP_PM_ADDR_FLAG_SUBFLOW) {
 			spin_lock_bh(&msk->pm.lock);
-			if (!__test_and_set_bit(entry->addr.id, msk->pm.id_avail_bitmap))
-				msk->pm.local_addr_used--;
+			__mark_subflow_endp_available(msk, list.ids[0]);
 			spin_unlock_bh(&msk->pm.lock);
 		}
 
@@ -1516,6 +1522,7 @@ static int mptcp_nl_remove_id_zero_address(struct net *net,
 		spin_lock_bh(&msk->pm.lock);
 		mptcp_pm_remove_addr(msk, &list);
 		mptcp_pm_nl_rm_subflow_received(msk, &list);
+		__mark_subflow_endp_available(msk, 0);
 		spin_unlock_bh(&msk->pm.lock);
 		release_sock(sk);
 
@@ -1917,6 +1924,7 @@ static void mptcp_pm_nl_fullmesh(struct mptcp_sock *msk,
 
 	spin_lock_bh(&msk->pm.lock);
 	mptcp_pm_nl_rm_subflow_received(msk, &list);
+	__mark_subflow_endp_available(msk, list.ids[0]);
 	mptcp_pm_create_subflow_or_signal_addr(msk);
 	spin_unlock_bh(&msk->pm.lock);
 }


