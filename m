Return-Path: <stable+bounces-66525-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B9FD94ED32
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 14:40:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 520051F2324F
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 12:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62C5617B433;
	Mon, 12 Aug 2024 12:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="i+C8zpzl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216F617A584
	for <stable@vger.kernel.org>; Mon, 12 Aug 2024 12:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723466392; cv=none; b=l8ZhIUM/Tmc8Xc2DgWMWBmZzB9QR8OgyOwlhiWxKhNgbLwA7oxkbOS/CquPx8IMg/0YL01Sh3LbwihtgMr/JtQCGqc/k5Y/nUDK2p33punaYDjLidP0hqHv6mcl9Y6tirVqKsku6A/FJUjq0LNePaVr4G8oJP3vui4yCJPDFu5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723466392; c=relaxed/simple;
	bh=xLeXuyNFLEWJPp+du/iECrAzKU957A+751AGLTiAG4k=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=mR0uHW5BneZ9sbtr5fSPGJp+pe2d3mJaNaN4X72WV5B4beOmOImCyOk/7+YMGD4GznBng0N3hOQAonHHoyTzYmAyLvjwPeWuFy1B4uuZ/Hud/PRiB029YvGtuODynaNxiBHNUYpGuYGaXYTc2Ytm+1bxkk4AHDuh59iwDuEEARg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=i+C8zpzl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D7CCC4AF0D;
	Mon, 12 Aug 2024 12:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723466392;
	bh=xLeXuyNFLEWJPp+du/iECrAzKU957A+751AGLTiAG4k=;
	h=Subject:To:Cc:From:Date:From;
	b=i+C8zpzlOHi3AqVFWYks2cToM3H693USJW3HBPqyn5BZ4Wf5diYbhzXaoaOdk3MPA
	 5zU36u6wqY/SKqNd/xE2mXe98NBf1Kzwml+63cjTxjy0OKF2FhzdxLgGRvA9fGnGeb
	 Yvuk+2REVj4g9Jrd010YFSP7IEMEPAHI8lgPLvkw=
Subject: FAILED: patch "[PATCH] mptcp: pm: don't try to create sf if alloc failed" failed to apply to 6.6-stable tree
To: matttbe@kernel.org,kuba@kernel.org,martineau@kernel.org,pabeni@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Aug 2024 14:39:45 +0200
Message-ID: <2024081244-uncertain-snarl-e4f6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x cd7c957f936f8cb80d03e5152f4013aae65bd986
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024081244-uncertain-snarl-e4f6@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

cd7c957f936f ("mptcp: pm: don't try to create sf if alloc failed")
c95eb32ced82 ("mptcp: pm: reduce indentation blocks")

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


