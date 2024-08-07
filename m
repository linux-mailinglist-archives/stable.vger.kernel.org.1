Return-Path: <stable+bounces-65560-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 296EE94A9A7
	for <lists+stable@lfdr.de>; Wed,  7 Aug 2024 16:14:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8D131F29D7D
	for <lists+stable@lfdr.de>; Wed,  7 Aug 2024 14:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78A6D3A1C4;
	Wed,  7 Aug 2024 14:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WTB1g/5V"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310286FE16
	for <stable@vger.kernel.org>; Wed,  7 Aug 2024 14:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723040049; cv=none; b=SpkBgf+A4XqXbT6OrH/Ct2/tZly5j5NrYLlJnNcssBX74fKuGN8avsjkPH1KIN2W/cTfHVIdBiw571KJWXECUv0o3G2rDG3hxdWwVARXlqbvfClKiLxTbGtObfE9meDVhKEf9KBwvOeoufNbjMGAfheC/MZkNFqV5vxlAw9LuIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723040049; c=relaxed/simple;
	bh=rapTZsjY+pm0LBY4eLh7sqSi7Ne2LUBoT9qs9+JI/+E=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=kNbDbDyyOwuPr2wB1rOkdVyxXYw5xR51EW1yloRyFaZolv7fKwpb1IfHY1Y/ZU6HAFFldw1KnRcSMgao7FZ3nWC4G7A+dKjIB+TBRqwDvUb2IWYHjx9evE80N1ciZeOxLnmh2NH21rgRDG/rpn2zAhU1k9+LRrNUrXUtfgngwdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WTB1g/5V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD9E9C32782;
	Wed,  7 Aug 2024 14:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723040049;
	bh=rapTZsjY+pm0LBY4eLh7sqSi7Ne2LUBoT9qs9+JI/+E=;
	h=Subject:To:Cc:From:Date:From;
	b=WTB1g/5V5Nyp0Yknq2CPnZ7beJvmw2O5cHlBLaCik6JWGUxg9vpm+PlkTS7i1IupV
	 J4F6FrCQplCq1Hp1RP6Lz2chSh3eAE3E8V3wsdEPf48hWJ1DNg4dVHjGDMV0N73kdW
	 ww7f8Oy9ISoDbsjjVvWmfvKkA11+A9aVHYQerkWk=
Subject: FAILED: patch "[PATCH] mptcp: fix NL PM announced address accounting" failed to apply to 5.15-stable tree
To: pabeni@redhat.com,davem@davemloft.net,matttbe@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 07 Aug 2024 16:14:05 +0200
Message-ID: <2024080705-poise-profile-662a@gregkh>
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
git cherry-pick -x 4b317e0eb287bd30a1b329513531157c25e8b692
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024080705-poise-profile-662a@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

4b317e0eb287 ("mptcp: fix NL PM announced address accounting")
6fa0174a7c86 ("mptcp: more careful RM_ADDR generation")
7d9bf018f907 ("selftests: mptcp: update output info of chk_rm_nr")
327b9a94e2a8 ("selftests: mptcp: more stable join tests-cases")

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


