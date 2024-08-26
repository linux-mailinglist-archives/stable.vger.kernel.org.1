Return-Path: <stable+bounces-70181-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1293595F05E
	for <lists+stable@lfdr.de>; Mon, 26 Aug 2024 14:04:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 909BDB20CAF
	for <lists+stable@lfdr.de>; Mon, 26 Aug 2024 12:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42F4515539F;
	Mon, 26 Aug 2024 12:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YgKgV2Ye"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C8578C73
	for <stable@vger.kernel.org>; Mon, 26 Aug 2024 12:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724673875; cv=none; b=JP4/zAVeiO8k7brXw4MdV+UkAbmJASPpKqml+4oTL/H3OD7APGJ/s+z6u5TwTd17ADNWGQLegDSuy9dqvR6fxczmp2P6h2QADtjzcnAA3LiPB3WxnRKJ2wFI/LqhiWdeQIwZk88DOG2MvnEHvvRtFZ7divag3tuQ5rr7UiheCYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724673875; c=relaxed/simple;
	bh=a4ECItVqpdB23RP4nZRCKE+VSudBu4CralNMi+GGTsA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=cCMpoO5j7ZldR8Oto7uPJJe7p5bIEXRhhpupfT3Ob3hxCpp2oTxr/VMurvYj2WGCRKOMwrwwYb5CQVKXmWY5fUUN9lqosSUOEpXXw3skmltIZNEbln/mKh2GivUKZG+EqQormU6VOmAdsZyvfeIapWwLb9OdTfSp62kod/LuVuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YgKgV2Ye; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15AB9C51405;
	Mon, 26 Aug 2024 12:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724673874;
	bh=a4ECItVqpdB23RP4nZRCKE+VSudBu4CralNMi+GGTsA=;
	h=Subject:To:Cc:From:Date:From;
	b=YgKgV2YeOsKFgWw+SC0ngDr6DFolKfqtOghzgwohpqYnJxXFMQoUxA/nNb9MSLuJn
	 mdHSH5q89tCPSgGGF6MMFvMoBNbcrCgV7o0y7SECcunvhQbswKTYDYALTwx+OWr7W+
	 E3Blx877hH6DxwTUqMaaYVvx7o7qslIIedp6qQRg=
Subject: FAILED: patch "[PATCH] mptcp: pm: re-using ID of unused flushed subflows" failed to apply to 5.10-stable tree
To: matttbe@kernel.org,kuba@kernel.org,martineau@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 26 Aug 2024 14:04:31 +0200
Message-ID: <2024082631-emerald-impotence-a278@gregkh>
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
git cherry-pick -x ef34a6ea0cab1800f4b3c9c3c2cefd5091e03379
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024082631-emerald-impotence-a278@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

ef34a6ea0cab ("mptcp: pm: re-using ID of unused flushed subflows")
06faa2271034 ("mptcp: remove multi addresses and subflows in PM")
141694df6573 ("mptcp: remove address when netlink flushes addrs")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ef34a6ea0cab1800f4b3c9c3c2cefd5091e03379 Mon Sep 17 00:00:00 2001
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 19 Aug 2024 21:45:23 +0200
Subject: [PATCH] mptcp: pm: re-using ID of unused flushed subflows

If no subflows are attached to the 'subflow' endpoints that are being
flushed, the corresponding addr IDs will not be marked as available
again.

Mark all ID as being available when flushing all the 'subflow'
endpoints, and reset local_addr_used counter to cover these cases.

Note that mptcp_pm_remove_addrs_and_subflows() helper is only called for
flushing operations, not to remove a specific set of addresses and
subflows.

Fixes: 06faa2271034 ("mptcp: remove multi addresses and subflows in PM")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20240819-net-mptcp-pm-reusing-id-v1-5-38035d40de5b@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 8b232a210a06..2c26696b820e 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1623,8 +1623,15 @@ static void mptcp_pm_remove_addrs_and_subflows(struct mptcp_sock *msk,
 		mptcp_pm_remove_addr(msk, &alist);
 		spin_unlock_bh(&msk->pm.lock);
 	}
+
 	if (slist.nr)
 		mptcp_pm_remove_subflow(msk, &slist);
+
+	/* Reset counters: maybe some subflows have been removed before */
+	spin_lock_bh(&msk->pm.lock);
+	bitmap_fill(msk->pm.id_avail_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
+	msk->pm.local_addr_used = 0;
+	spin_unlock_bh(&msk->pm.lock);
 }
 
 static void mptcp_nl_remove_addrs_list(struct net *net,


