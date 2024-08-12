Return-Path: <stable+bounces-66527-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E61E694ED34
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 14:40:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3887284215
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 12:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B988517B4EC;
	Mon, 12 Aug 2024 12:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GeLQhgOx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A9617B4E2
	for <stable@vger.kernel.org>; Mon, 12 Aug 2024 12:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723466398; cv=none; b=b3n/mJbqEaSghql43Zb6bvlMMrMdKPdevhgvCkc3PUCKo0Tcq5djUUPerCnxQJSMLMXE+QlpXdOp00R1qGDAeepKep3T5xaEDGt32nXuHs/Z39yd5RNkV+cSTblwS/bgfi/blBPlPLA04ZQE92UY/EZJGhucgtvW1TmHYUBD5ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723466398; c=relaxed/simple;
	bh=wr8+QOYnN9H9w7xFUxYH7a2pnMgrEZm8b2zyfMi63KE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=D/RQBaLNgjncJMYbEIErseq+SQxJ/Rdz99ew6L6GdwUzfBkbjtZba3Lvi299pPYnmmkgVzkbnzOvjc6uRKVEgapMi+Tr+bRzSo7fcF/hdwTVSqg/F9CCS91BJqZVMT46z2MRpbTRkOZbHgDGLBxrkHXurTjDA+cxQUDmdwWYlNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GeLQhgOx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01FAFC4AF0D;
	Mon, 12 Aug 2024 12:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723466398;
	bh=wr8+QOYnN9H9w7xFUxYH7a2pnMgrEZm8b2zyfMi63KE=;
	h=Subject:To:Cc:From:Date:From;
	b=GeLQhgOxpzL44Tv2F9qKawZPcPZroo7zECYI3EMrbStLYu3XTEt4NhibLMmwKtsbd
	 B+Y2repU2Run4JwXFadiJXTb1V3gR7Mwf4JGWkyMoy7BuHTenyvIYhjGGtnxqZ2dRc
	 Q8ZRefYIvoxjrxpPhftM1LDYRNBV40yQYClBRO+I=
Subject: FAILED: patch "[PATCH] mptcp: pm: don't try to create sf if alloc failed" failed to apply to 5.15-stable tree
To: matttbe@kernel.org,kuba@kernel.org,martineau@kernel.org,pabeni@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Aug 2024 14:39:47 +0200
Message-ID: <2024081246-rinse-rockslide-346f@gregkh>
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
git cherry-pick -x cd7c957f936f8cb80d03e5152f4013aae65bd986
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024081246-rinse-rockslide-346f@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

cd7c957f936f ("mptcp: pm: don't try to create sf if alloc failed")
c95eb32ced82 ("mptcp: pm: reduce indentation blocks")
528cb5f2a1e8 ("mptcp: pass addr to mptcp_pm_alloc_anno_list")
77e4b94a3de6 ("mptcp: update userspace pm infos")
24430f8bf516 ("mptcp: add address into userspace pm list")
fb00ee4f3343 ("mptcp: netlink: respect v4/v6-only sockets")
80638684e840 ("mptcp: get sk from msk directly")
5ccecaec5c1e ("mptcp: fix locking in mptcp_nl_cmd_sf_destroy()")
76a13b315709 ("mptcp: invoke MP_FAIL response when needed")
d9fb797046c5 ("mptcp: Do not traverse the subflow connection list without lock")
d42f9e4e2384 ("mptcp: Check for orphaned subflow before handling MP_FAIL timer")
d7e6f5836038 ("Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From cd7c957f936f8cb80d03e5152f4013aae65bd986 Mon Sep 17 00:00:00 2001
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 31 Jul 2024 13:05:56 +0200
Subject: [PATCH] mptcp: pm: don't try to create sf if alloc failed

It sounds better to avoid wasting cycles and / or put extreme memory
pressure on the system by trying to create new subflows if it was not
possible to add a new item in the announce list.

While at it, a warning is now printed if the entry was already in the
list as it should not happen with the in-kernel path-manager. With this
PM, mptcp_pm_alloc_anno_list() should only fail in case of memory
pressure.

Fixes: b6c08380860b ("mptcp: remove addr and subflow in PM netlink")
Cc: stable@vger.kernel.org
Suggested-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20240731-upstream-net-20240731-mptcp-endp-subflow-signal-v1-4-c8a9b036493b@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 780f4cca165c..2be7af377cda 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -348,7 +348,7 @@ bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 	add_entry = mptcp_lookup_anno_list_by_saddr(msk, addr);
 
 	if (add_entry) {
-		if (mptcp_pm_is_kernel(msk))
+		if (WARN_ON_ONCE(mptcp_pm_is_kernel(msk)))
 			return false;
 
 		sk_reset_timer(sk, &add_entry->add_timer,
@@ -555,8 +555,6 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 
 	/* check first for announce */
 	if (msk->pm.add_addr_signaled < add_addr_signal_max) {
-		local = select_signal_address(pernet, msk);
-
 		/* due to racing events on both ends we can reach here while
 		 * previous add address is still running: if we invoke now
 		 * mptcp_pm_announce_addr(), that will fail and the
@@ -567,11 +565,15 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 		if (msk->pm.addr_signal & BIT(MPTCP_ADD_ADDR_SIGNAL))
 			return;
 
+		local = select_signal_address(pernet, msk);
 		if (!local)
 			goto subflow;
 
+		/* If the alloc fails, we are on memory pressure, not worth
+		 * continuing, and trying to create subflows.
+		 */
 		if (!mptcp_pm_alloc_anno_list(msk, &local->addr))
-			goto subflow;
+			return;
 
 		__clear_bit(local->addr.id, msk->pm.id_avail_bitmap);
 		msk->pm.add_addr_signaled++;


