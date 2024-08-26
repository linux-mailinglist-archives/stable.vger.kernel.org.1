Return-Path: <stable+bounces-70230-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 554AE95F320
	for <lists+stable@lfdr.de>; Mon, 26 Aug 2024 15:38:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 882251C226A7
	for <lists+stable@lfdr.de>; Mon, 26 Aug 2024 13:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7358A18BC2D;
	Mon, 26 Aug 2024 13:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="F9zgNKVk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3306E18BC04
	for <stable@vger.kernel.org>; Mon, 26 Aug 2024 13:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724679466; cv=none; b=IjYXwMV7khomERjlBCVv64tH8OZYVC1Oy0XTL57fvSdqUpC+NRWsZ7YjuXzxsVs2kICylEUyD1yyShow5fmMchoxo0j0p24nnU4EBW4KmUBGyqdaoZXW8xog0Wl8Rs2G64UJOd4s84zdgb0mGBDAWHiynMLLj7BMfvfWB8mvhlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724679466; c=relaxed/simple;
	bh=7GwQTAnCQ/NHmkKLg+fg0ClMMiTVl3mDLR0u8Vy22RY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=YBuwDPNBWVIsPRRn9gxCitJPNaG+vMpGEbkLxxAYpJNoUZPhsDRXhr7kcPKwhH1LbI8JpdrO5MJ+AGq1KxTHaaDnEmvoJ4r2NcVepxyaZ7X8iSpSmYNGPjRFztPBelRaCDiOhhCsAoU/cIxiVaJEdP6ld8EYuBZBjQro2aoyAsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=F9zgNKVk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D9A2C52FD7;
	Mon, 26 Aug 2024 13:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724679465;
	bh=7GwQTAnCQ/NHmkKLg+fg0ClMMiTVl3mDLR0u8Vy22RY=;
	h=Subject:To:Cc:From:Date:From;
	b=F9zgNKVkz9cjlKzZM4fr9USV125et2aoGE1+AHtp/xGz0eHwTsp8h0zEZcEpfnDk0
	 D54LbondPV26BOTEqITMcyVC1MHspeMkppnwGviY/ncbr7EQiFrJ1NSjUAdTdSiOqO
	 DEj/CAtOimPV++xYulvpxqHiceZXwkmSARbuQ3uE=
Subject: FAILED: patch "[PATCH] mptcp: pm: re-using ID of unused flushed subflows" failed to apply to 5.15-stable tree
To: matttbe@kernel.org,kuba@kernel.org,martineau@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 26 Aug 2024 15:37:42 +0200
Message-ID: <2024082642-google-strongman-27a7@gregkh>
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
git cherry-pick -x ef34a6ea0cab1800f4b3c9c3c2cefd5091e03379
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024082642-google-strongman-27a7@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

ef34a6ea0cab ("mptcp: pm: re-using ID of unused flushed subflows")

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


