Return-Path: <stable+bounces-67439-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37CA6950134
	for <lists+stable@lfdr.de>; Tue, 13 Aug 2024 11:28:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB1AA1F21F38
	for <lists+stable@lfdr.de>; Tue, 13 Aug 2024 09:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EC3414D42C;
	Tue, 13 Aug 2024 09:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n4WtSpNf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD7716BE2A;
	Tue, 13 Aug 2024 09:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723541314; cv=none; b=KvctJRaFpvqHUC5hV+AlWUwf23IYZL2dSwRXckEtWXe5lOak7dj/RmMoWrVTW6f7655nzKAzXW0y9JCUa9cStpMSxK31zk+TcndmtsAQf1W8NHrUz29tGWCGW3YPNh0wPN7sXwx+Bp2M8EUFVA3Em5nZKd7MhWVaWoGlV4B34mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723541314; c=relaxed/simple;
	bh=D5z96ClQinw9egDyi5bNurvKXxqXQVFjgQ1/Ec0Bpdw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G7N/IPCcK0DOuuj1TbK9Tnv20EnBrlWsaVcyiP3MmB3b0bXJzR7deU5azNQ69Ke455UypSLgI4YV+t08QS3Gb3Hcm5LEDHinWkX+0w/ZcUYqK7FeRQwRs/HzPm3Q8pk7mlbAmkxXjOBp7I6Vm44du5L80Wr1yw89T8q/Ha10kyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n4WtSpNf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FAEFC4AF12;
	Tue, 13 Aug 2024 09:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723541313;
	bh=D5z96ClQinw9egDyi5bNurvKXxqXQVFjgQ1/Ec0Bpdw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n4WtSpNfEmil6aeAOnXDs/NrA1Z2hpfhVb/aa9zP7br5ZLwLl9VVv3EY840DiOyuR
	 Ubdl1iLaxlkGzNKIt+/HmKM/pyTPfPlEkxPPxDjgd+gCYfdsx+93g55v6idJ9JmDTP
	 lsdB6J3QNgKgko57UuRlxwpDF9ysS6QYOfjUtn/xmesYN1b1c7xXIx6KMcuJtIpotB
	 viphtpDgIxo8PZX/2EdHpew4WlDv91eknQxqOZBgTXLZRnToLUs8ckykz+hRxzs1UB
	 WE9uhPMx79yrKRrlA3aDRe1ZwTqKV6+DahOKFPSHNzLrQz1OXlh5UD7FTR5dy24AQz
	 9jTZyg7zG5WNw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Mat Martineau <martineau@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.1.y 3/5] mptcp: pm: don't try to create sf if alloc failed
Date: Tue, 13 Aug 2024 11:28:19 +0200
Message-ID: <20240813092815.966749-10-matttbe@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <2024081245-deem-refinance-8605@gregkh>
References: <2024081245-deem-refinance-8605@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2526; i=matttbe@kernel.org; h=from:subject; bh=D5z96ClQinw9egDyi5bNurvKXxqXQVFjgQ1/Ec0Bpdw=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmuycv3nHejNxOh47SSELe7WmshWm07v4cmn74L nwyZUwEhhGJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZrsnLwAKCRD2t4JPQmmg cyK3EACv1EXlNuiNeDl4EpFc0fRf78sQC6gke4yacwzVuXP5fz7ZIYQVuU+8Fm88E2BgmRttJZy B6HdiVo8oyk4QE43hB/rE1JcRSLJ/NUgjn7mFupkzWIArzYNIyYuFOJfOlt9AjrN++5MBMLacBn 8u0IeKDnwrNM4KRcndFlN23hnbC6Z/tji65gSEgD6EN75koiJc6EzNhuVxkE5aNnIFyiRPcfpyS vmEDf0IczbVq1ZEmHyfUcz1zEI8NtNvnQcviCp9BvmD/pLbY5qXKg47WkLsiLSPImbWhTnlMoRk fk/+BRgnDv/+edZ/V2ZH8NlpFUlXT1ElQOnaHtNStdwAX9RLg0KU9i2I5GhNiZjR4fvdIoQZs2C ulPbI4BfpQEjmWdhY+2v9fgokje0v0fo83ugM6TzRtEOxibS+QmnaPHHjFqN3KBB6WFMRYslIkF 9tXIAAWLth7GPES768cLcoHnf4tRGykXgFs3AmQKERAMdy+hsTgfyf1umUPL/tVt2P1i8YizjJR ysa4hYmGd+2lUjbmSWeJXg+iH0aOY5RoMzv/dVorrD678hfFSbTylb8k+3QUqoZ0w5Sfofhxm+C N9/+yKzF5m/ogyGoW1V9tvBDJv1BTPO1YMWaNPbbjSWFKq3yNSAo2wseWpyd1bYg2yYQbyaSDFr MAqR3VpZdJ5bonA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

commit cd7c957f936f8cb80d03e5152f4013aae65bd986 upstream.

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
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index bf1059a9f125..8c04e8fb4488 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -363,7 +363,7 @@ bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 	add_entry = mptcp_lookup_anno_list_by_saddr(msk, addr);
 
 	if (add_entry) {
-		if (mptcp_pm_is_kernel(msk))
+		if (WARN_ON_ONCE(mptcp_pm_is_kernel(msk)))
 			return false;
 
 		sk_reset_timer(sk, &add_entry->add_timer,
@@ -567,8 +567,6 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 
 	/* check first for announce */
 	if (msk->pm.add_addr_signaled < add_addr_signal_max) {
-		local = select_signal_address(pernet, msk);
-
 		/* due to racing events on both ends we can reach here while
 		 * previous add address is still running: if we invoke now
 		 * mptcp_pm_announce_addr(), that will fail and the
@@ -579,11 +577,15 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
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
-- 
2.45.2


