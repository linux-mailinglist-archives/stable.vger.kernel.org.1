Return-Path: <stable+bounces-70192-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E747095F0E8
	for <lists+stable@lfdr.de>; Mon, 26 Aug 2024 14:13:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D11B1F24C83
	for <lists+stable@lfdr.de>; Mon, 26 Aug 2024 12:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6221918661A;
	Mon, 26 Aug 2024 12:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dnSzCOSj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22BEF16F26F
	for <stable@vger.kernel.org>; Mon, 26 Aug 2024 12:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724674064; cv=none; b=bf5hrwIYrivSTi2B+PqQr8NLjgaf23sDiYinfXQImqEiluihelFqtYOgE471Uk5+9JvTumLRvIEN3kxW9jbonJRP5pn70kptdclb0PgrSOaEfEyJHwttQXC5MAqgzuF+OAsFE1sLG+X58XCnKWX3tdyRcuHXyAeF3zgmnX0foEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724674064; c=relaxed/simple;
	bh=MRl2iwA6kOh+AOPGNLY9UYwqs72dGFk+yzuySaNFmTE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=HJ2MrOl1S+tOsGWbB04+MpPSd/mPUUmGJGxerin2B6b6bTYN9cEqqzkAutMyVLgb++4GxZfyDN7Anohy823VVQWmsXdt6aC9kRhnu2/8Yoq+03HgOS6DSG+BY1MxCowNJai1ndMdhEx9jgr01BZ9viVrWveLjkS8IS0KpKOYXKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dnSzCOSj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42596C51413;
	Mon, 26 Aug 2024 12:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724674063;
	bh=MRl2iwA6kOh+AOPGNLY9UYwqs72dGFk+yzuySaNFmTE=;
	h=Subject:To:Cc:From:Date:From;
	b=dnSzCOSjrCrpZP0bEk02HQk7eGkU8eJ76r2/L200x+FyxrDm2HshO9o3Pxh8PqwPe
	 hv3HraV4AHRoJc1ULqQs2mcNG/TiChEJvK37C/ehVep/oVCTrmOpSlIJgylQZg5oPk
	 0WDUQ6TAWDYZ2yP7LCZQYMMMREmondk3FjuJCp+s=
Subject: FAILED: patch "[PATCH] mptcp: pm: fullmesh: select the right ID later" failed to apply to 6.1-stable tree
To: matttbe@kernel.org,kuba@kernel.org,martineau@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 26 Aug 2024 14:07:40 +0200
Message-ID: <2024082640-recognize-omega-3192@gregkh>
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
git cherry-pick -x 09355f7abb9fbfc1a240be029837921ea417bf4f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024082640-recognize-omega-3192@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

09355f7abb9f ("mptcp: pm: fullmesh: select the right ID later")
b9d69db87fb7 ("mptcp: let the in-kernel PM use mixed IPv4 and IPv6 addresses")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 09355f7abb9fbfc1a240be029837921ea417bf4f Mon Sep 17 00:00:00 2001
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 19 Aug 2024 21:45:30 +0200
Subject: [PATCH] mptcp: pm: fullmesh: select the right ID later

When reacting upon the reception of an ADD_ADDR, the in-kernel PM first
looks for fullmesh endpoints. If there are some, it will pick them,
using their entry ID.

It should set the ID 0 when using the endpoint corresponding to the
initial subflow, it is a special case imposed by the MPTCP specs.

Note that msk->mpc_endpoint_id might not be set when receiving the first
ADD_ADDR from the server. So better to compare the addresses.

Fixes: 1a0d6136c5f0 ("mptcp: local addresses fullmesh")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20240819-net-mptcp-pm-reusing-id-v1-12-38035d40de5b@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index d0a80f537fc3..a2e37ab1c40f 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -636,6 +636,7 @@ static unsigned int fill_local_addresses_vec(struct mptcp_sock *msk,
 {
 	struct sock *sk = (struct sock *)msk;
 	struct mptcp_pm_addr_entry *entry;
+	struct mptcp_addr_info mpc_addr;
 	struct pm_nl_pernet *pernet;
 	unsigned int subflows_max;
 	int i = 0;
@@ -643,6 +644,8 @@ static unsigned int fill_local_addresses_vec(struct mptcp_sock *msk,
 	pernet = pm_nl_get_pernet_from_msk(msk);
 	subflows_max = mptcp_pm_get_subflows_max(msk);
 
+	mptcp_local_address((struct sock_common *)msk, &mpc_addr);
+
 	rcu_read_lock();
 	list_for_each_entry_rcu(entry, &pernet->local_addr_list, list) {
 		if (!(entry->flags & MPTCP_PM_ADDR_FLAG_FULLMESH))
@@ -653,7 +656,13 @@ static unsigned int fill_local_addresses_vec(struct mptcp_sock *msk,
 
 		if (msk->pm.subflows < subflows_max) {
 			msk->pm.subflows++;
-			addrs[i++] = entry->addr;
+			addrs[i] = entry->addr;
+
+			/* Special case for ID0: set the correct ID */
+			if (mptcp_addresses_equal(&entry->addr, &mpc_addr, entry->addr.port))
+				addrs[i].id = 0;
+
+			i++;
 		}
 	}
 	rcu_read_unlock();


