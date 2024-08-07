Return-Path: <stable+bounces-65561-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5524894A9AC
	for <lists+stable@lfdr.de>; Wed,  7 Aug 2024 16:15:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A381281E1A
	for <lists+stable@lfdr.de>; Wed,  7 Aug 2024 14:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79E7877F08;
	Wed,  7 Aug 2024 14:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uOFijnVa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395435811A
	for <stable@vger.kernel.org>; Wed,  7 Aug 2024 14:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723040058; cv=none; b=qnePj5dxoz6JfpxCSRpnA59arsobQdWu8rOYxkXEtoJZtmfJYU9fDj+/SbKMTSgvqjG+9L3EGuNm/eTtDqKVEZ1e29V/5YsO/IAlmiToxer0doi07L+9HmOr11LeOb201O3rCYnfji4H5UA5FnvX6ALZAwJ7YQpFgh+r1mnyJ90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723040058; c=relaxed/simple;
	bh=5j7+cbqPJ6yMjFzwf4f/nx4p3l0fUfm4C+oHpTDVQTI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=HfLHFvO24BTFX64xeqE2uJhJIpHC+dSIbyf+c3BELxPp6Vfqtz24VeDnm/vFx6m6D8fOUtlFbNnqyEex9A1HWOmRbH4I3/332J+r6dp3+EHVVuEeLzpXJLNhImXv/lYiNdXP/kONcVTXGEpFro2/veQxR+W5O6zmF8iEyxofQso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uOFijnVa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A75AC4AF0B;
	Wed,  7 Aug 2024 14:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723040057;
	bh=5j7+cbqPJ6yMjFzwf4f/nx4p3l0fUfm4C+oHpTDVQTI=;
	h=Subject:To:Cc:From:Date:From;
	b=uOFijnVaLX64aPXdgueBWxoDF5kTCyTqw2kbBmI5D6D6VRedtarpUWjmfZCPMhzzs
	 UqFQBaxiINS8UCNGXiWt/awOPBoDkOkq+Jr3LQmv9ag9CN6qbWbzASMEdgCc6Na+kx
	 sVTHcRgiF/VXDl+bj+QWAb5pu6G0TnuAcse3T60M=
Subject: FAILED: patch "[PATCH] mptcp: fix NL PM announced address accounting" failed to apply to 5.10-stable tree
To: pabeni@redhat.com,davem@davemloft.net,matttbe@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 07 Aug 2024 16:14:06 +0200
Message-ID: <2024080706-omnivore-undermost-43f1@gregkh>
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
git cherry-pick -x 4b317e0eb287bd30a1b329513531157c25e8b692
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024080706-omnivore-undermost-43f1@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

4b317e0eb287 ("mptcp: fix NL PM announced address accounting")
6fa0174a7c86 ("mptcp: more careful RM_ADDR generation")
7d9bf018f907 ("selftests: mptcp: update output info of chk_rm_nr")
327b9a94e2a8 ("selftests: mptcp: more stable join tests-cases")
6bb3ab4913e9 ("selftests: mptcp: add MP_FAIL mibs check")
f7713dd5d23a ("selftests: mptcp: delete uncontinuous removing ids")
4f49d63352da ("selftests: mptcp: add fullmesh testcases")
0cddb4a6f4e3 ("selftests: mptcp: add deny_join_id0 testcases")
af66d3e1c3fa ("selftests: mptcp: enable checksum in mptcp_join.sh")
5e287fe76149 ("selftests: mptcp: remove id 0 address testcases")
ef360019db40 ("selftests: mptcp: signal addresses testcases")
efd13b71a3fa ("Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 4b317e0eb287bd30a1b329513531157c25e8b692 Mon Sep 17 00:00:00 2001
From: Paolo Abeni <pabeni@redhat.com>
Date: Sat, 27 Jul 2024 11:04:00 +0200
Subject: [PATCH] mptcp: fix NL PM announced address accounting

Currently the per connection announced address counter is never
decreased. As a consequence, after connection establishment, if
the NL PM deletes an endpoint and adds a new/different one, no
additional subflow is created for the new endpoint even if the
current limits allow that.

Address the issue properly updating the signaled address counter
every time the NL PM removes such addresses.

Fixes: 01cacb00b35c ("mptcp: add netlink-based PM")
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index b399f2b7a369..f65831de5c1a 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1401,6 +1401,7 @@ static bool mptcp_pm_remove_anno_addr(struct mptcp_sock *msk,
 	ret = remove_anno_list_by_saddr(msk, addr);
 	if (ret || force) {
 		spin_lock_bh(&msk->pm.lock);
+		msk->pm.add_addr_signaled -= ret;
 		mptcp_pm_remove_addr(msk, &list);
 		spin_unlock_bh(&msk->pm.lock);
 	}
@@ -1565,17 +1566,18 @@ static void mptcp_pm_remove_addrs_and_subflows(struct mptcp_sock *msk,
 	struct mptcp_pm_addr_entry *entry;
 
 	list_for_each_entry(entry, rm_list, list) {
-		if (lookup_subflow_by_saddr(&msk->conn_list, &entry->addr) &&
-		    slist.nr < MPTCP_RM_IDS_MAX)
+		if (slist.nr < MPTCP_RM_IDS_MAX &&
+		    lookup_subflow_by_saddr(&msk->conn_list, &entry->addr))
 			slist.ids[slist.nr++] = entry->addr.id;
 
-		if (remove_anno_list_by_saddr(msk, &entry->addr) &&
-		    alist.nr < MPTCP_RM_IDS_MAX)
+		if (alist.nr < MPTCP_RM_IDS_MAX &&
+		    remove_anno_list_by_saddr(msk, &entry->addr))
 			alist.ids[alist.nr++] = entry->addr.id;
 	}
 
 	if (alist.nr) {
 		spin_lock_bh(&msk->pm.lock);
+		msk->pm.add_addr_signaled -= alist.nr;
 		mptcp_pm_remove_addr(msk, &alist);
 		spin_unlock_bh(&msk->pm.lock);
 	}


