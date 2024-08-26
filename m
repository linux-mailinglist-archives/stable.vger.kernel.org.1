Return-Path: <stable+bounces-70180-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EBB295F05D
	for <lists+stable@lfdr.de>; Mon, 26 Aug 2024 14:04:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43EC81F20B65
	for <lists+stable@lfdr.de>; Mon, 26 Aug 2024 12:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 805FC16BE09;
	Mon, 26 Aug 2024 12:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QzbMidw1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE3715B13A
	for <stable@vger.kernel.org>; Mon, 26 Aug 2024 12:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724673865; cv=none; b=NvZUg/gTBzCsUuaU4V99pow5MtNd4y4SAxnEYMJCOavc036xc6OZ11TpGNTTLXk6w/1npmOG9rWuMLBr+7/RjybaRyOQpSqV38BdCpGVNDfuRMPDafXw3K3XAT21CC07UFIfE8U1sTTvZUWRf11FWUymY7BML1Dvs/RzVxGNBko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724673865; c=relaxed/simple;
	bh=FCSetx4DGFUbIsP/VuGYtd3+uqU7lCbdrS3SWBRvmkc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=XAjnpQdej/bYge8ZcfZzwkHgMJg66Xl03Hg/j7LIp6sM622+B5dhkLsMGAkvc3XTqUcjZg5YMd495bYVXb2AzfQzyropNS2jCgZ30lZo9enUlDqDevJxGgwtnS/dNCcIq86ceyf02r12kFdrsJ/SV5Ngat14Jt61KX0H68yqDeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QzbMidw1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FF1EC51405;
	Mon, 26 Aug 2024 12:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724673864;
	bh=FCSetx4DGFUbIsP/VuGYtd3+uqU7lCbdrS3SWBRvmkc=;
	h=Subject:To:Cc:From:Date:From;
	b=QzbMidw1MTwqdB9N1oVdC+VWJKqDmH7/onTUAFhYeVTFB395RA0xT8rolNmB+ExH3
	 xL8m6bFTSDPG9BqfiGlTXT3O5nLDA8Rf9EnwiF/fLCkahP6xdJAyvh1bV7NFMVArZe
	 SDW7tFZu1rDXTF6e1mpTsSUh0Fx7HXvQMQXCRncI=
Subject: FAILED: patch "[PATCH] mptcp: pm: re-using ID of unused removed subflows" failed to apply to 5.10-stable tree
To: matttbe@kernel.org,kuba@kernel.org,martineau@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 26 Aug 2024 14:04:13 +0200
Message-ID: <2024082613-gerbil-channel-c3e1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x edd8b5d868a4d459f3065493001e293901af758d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024082613-gerbil-channel-c3e1@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

edd8b5d868a4 ("mptcp: pm: re-using ID of unused removed subflows")
d045b9eb95a9 ("mptcp: introduce implicit endpoints")
33397b83eee6 ("selftests: mptcp: add backup with port testcase")
09f12c3ab7a5 ("mptcp: allow to use port and non-signal in set_flags")
6a0653b96f5d ("selftests: mptcp: add fullmesh setting tests")
327b9a94e2a8 ("selftests: mptcp: more stable join tests-cases")
6bb3ab4913e9 ("selftests: mptcp: add MP_FAIL mibs check")
f444fea7896d ("Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From edd8b5d868a4d459f3065493001e293901af758d Mon Sep 17 00:00:00 2001
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 19 Aug 2024 21:45:21 +0200
Subject: [PATCH] mptcp: pm: re-using ID of unused removed subflows

If no subflow is attached to the 'subflow' endpoint that is being
removed, the addr ID will not be marked as available again.

Mark the linked ID as available when removing the 'subflow' endpoint if
no subflow is attached to it.

While at it, the local_addr_used counter is decremented if the ID was
marked as being used to reflect the reality, but also to allow adding
new endpoints after that.

Fixes: b6c08380860b ("mptcp: remove addr and subflow in PM netlink")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20240819-net-mptcp-pm-reusing-id-v1-3-38035d40de5b@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 26f0329e16bb..8b232a210a06 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1469,8 +1469,17 @@ static int mptcp_nl_remove_subflow_and_signal_addr(struct net *net,
 		remove_subflow = lookup_subflow_by_saddr(&msk->conn_list, addr);
 		mptcp_pm_remove_anno_addr(msk, addr, remove_subflow &&
 					  !(entry->flags & MPTCP_PM_ADDR_FLAG_IMPLICIT));
-		if (remove_subflow)
+
+		if (remove_subflow) {
 			mptcp_pm_remove_subflow(msk, &list);
+		} else if (entry->flags & MPTCP_PM_ADDR_FLAG_SUBFLOW) {
+			/* If the subflow has been used, but now closed */
+			spin_lock_bh(&msk->pm.lock);
+			if (!__test_and_set_bit(entry->addr.id, msk->pm.id_avail_bitmap))
+				msk->pm.local_addr_used--;
+			spin_unlock_bh(&msk->pm.lock);
+		}
+
 		release_sock(sk);
 
 next:


