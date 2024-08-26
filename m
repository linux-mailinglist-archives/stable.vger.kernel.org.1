Return-Path: <stable+bounces-70194-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9890295F0EA
	for <lists+stable@lfdr.de>; Mon, 26 Aug 2024 14:13:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDAF81C2373C
	for <lists+stable@lfdr.de>; Mon, 26 Aug 2024 12:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9912A16F26F;
	Mon, 26 Aug 2024 12:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OJRfddba"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584A7144306
	for <stable@vger.kernel.org>; Mon, 26 Aug 2024 12:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724674080; cv=none; b=IHkG/ejjliJzEAuGCOPKr8yTMhxgV2LfVJ/y1Sl9Rt8JEa+SDk0wJRiG8XOnrk1Abdq4s31ZScQY4XwE+bM072uXzRRFqzSriEHS1Cp/gmXSh3BfWtbgHmwy+hORG87NHVyhX648FetJaIM/BMCmAu2MnXrwkS0fvWgThtt7NbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724674080; c=relaxed/simple;
	bh=y7J0WowEEtPk938F6H1GoTBXjq0zilligNiwv34xWPk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=rnFmkgtaYnHeRI0fJ5EPM7DLd4+AwKZ1dd2QNa40l2xcJ49PK4SuP2O36BpQ+60BWoGU0OG/LF6N6yPN8nMCMvSA52NhJO3jushLePNkfOGYZ7Sx/5sLwLT/sYaeHzTNJeKOYkGuGa299mV1+2HXYZ1Kcsqb8bStxiJDH8XAhLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OJRfddba; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75F25C51413;
	Mon, 26 Aug 2024 12:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724674079;
	bh=y7J0WowEEtPk938F6H1GoTBXjq0zilligNiwv34xWPk=;
	h=Subject:To:Cc:From:Date:From;
	b=OJRfddbaNe7kvx81h6NnpP/dyXaJGixAvplyS0rBEasla8tiaC3hE3FHVTAPuyQdP
	 MorHs5Fb+BIv3dFZ7HpSTyqGk23BmqyTB/P5+kVjFKoqMEirR75SckV83DJkXSpb3N
	 UIbZ2r0/+7c8pv/iuJly0jEqmaDOnnXaNWLtcGxo=
Subject: FAILED: patch "[PATCH] mptcp: pm: avoid possible UaF when selecting endp" failed to apply to 6.1-stable tree
To: matttbe@kernel.org,kuba@kernel.org,martineau@kernel.org,pabeni@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 26 Aug 2024 14:07:56 +0200
Message-ID: <2024082656-bamboo-skinless-9366@gregkh>
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
git cherry-pick -x 48e50dcbcbaaf713d82bf2da5c16aeced94ad07d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024082656-bamboo-skinless-9366@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

48e50dcbcbaa ("mptcp: pm: avoid possible UaF when selecting endp")
85df533a787b ("mptcp: pm: do not ignore 'subflow' if 'signal' flag is also set")
cd7c957f936f ("mptcp: pm: don't try to create sf if alloc failed")
c95eb32ced82 ("mptcp: pm: reduce indentation blocks")
528cb5f2a1e8 ("mptcp: pass addr to mptcp_pm_alloc_anno_list")
77e4b94a3de6 ("mptcp: update userspace pm infos")
24430f8bf516 ("mptcp: add address into userspace pm list")
b9d69db87fb7 ("mptcp: let the in-kernel PM use mixed IPv4 and IPv6 addresses")
fb00ee4f3343 ("mptcp: netlink: respect v4/v6-only sockets")
80638684e840 ("mptcp: get sk from msk directly")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 48e50dcbcbaaf713d82bf2da5c16aeced94ad07d Mon Sep 17 00:00:00 2001
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 19 Aug 2024 21:45:32 +0200
Subject: [PATCH] mptcp: pm: avoid possible UaF when selecting endp

select_local_address() and select_signal_address() both select an
endpoint entry from the list inside an RCU protected section, but return
a reference to it, to be read later on. If the entry is dereferenced
after the RCU unlock, reading info could cause a Use-after-Free.

A simple solution is to copy the required info while inside the RCU
protected section to avoid any risk of UaF later. The address ID might
need to be modified later to handle the ID0 case later, so a copy seems
OK to deal with.

Reported-by: Paolo Abeni <pabeni@redhat.com>
Closes: https://lore.kernel.org/45cd30d3-7710-491c-ae4d-a1368c00beb1@redhat.com
Fixes: 01cacb00b35c ("mptcp: add netlink-based PM")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20240819-net-mptcp-pm-reusing-id-v1-14-38035d40de5b@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index a2e37ab1c40f..3e4ad801786f 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -143,11 +143,13 @@ static bool lookup_subflow_by_daddr(const struct list_head *list,
 	return false;
 }
 
-static struct mptcp_pm_addr_entry *
+static bool
 select_local_address(const struct pm_nl_pernet *pernet,
-		     const struct mptcp_sock *msk)
+		     const struct mptcp_sock *msk,
+		     struct mptcp_pm_addr_entry *new_entry)
 {
-	struct mptcp_pm_addr_entry *entry, *ret = NULL;
+	struct mptcp_pm_addr_entry *entry;
+	bool found = false;
 
 	msk_owned_by_me(msk);
 
@@ -159,17 +161,21 @@ select_local_address(const struct pm_nl_pernet *pernet,
 		if (!test_bit(entry->addr.id, msk->pm.id_avail_bitmap))
 			continue;
 
-		ret = entry;
+		*new_entry = *entry;
+		found = true;
 		break;
 	}
 	rcu_read_unlock();
-	return ret;
+
+	return found;
 }
 
-static struct mptcp_pm_addr_entry *
-select_signal_address(struct pm_nl_pernet *pernet, const struct mptcp_sock *msk)
+static bool
+select_signal_address(struct pm_nl_pernet *pernet, const struct mptcp_sock *msk,
+		      struct mptcp_pm_addr_entry *new_entry)
 {
-	struct mptcp_pm_addr_entry *entry, *ret = NULL;
+	struct mptcp_pm_addr_entry *entry;
+	bool found = false;
 
 	rcu_read_lock();
 	/* do not keep any additional per socket state, just signal
@@ -184,11 +190,13 @@ select_signal_address(struct pm_nl_pernet *pernet, const struct mptcp_sock *msk)
 		if (!(entry->flags & MPTCP_PM_ADDR_FLAG_SIGNAL))
 			continue;
 
-		ret = entry;
+		*new_entry = *entry;
+		found = true;
 		break;
 	}
 	rcu_read_unlock();
-	return ret;
+
+	return found;
 }
 
 unsigned int mptcp_pm_get_add_addr_signal_max(const struct mptcp_sock *msk)
@@ -512,9 +520,10 @@ __lookup_addr(struct pm_nl_pernet *pernet, const struct mptcp_addr_info *info)
 
 static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 {
-	struct mptcp_pm_addr_entry *local, *signal_and_subflow = NULL;
 	struct sock *sk = (struct sock *)msk;
+	struct mptcp_pm_addr_entry local;
 	unsigned int add_addr_signal_max;
+	bool signal_and_subflow = false;
 	unsigned int local_addr_max;
 	struct pm_nl_pernet *pernet;
 	unsigned int subflows_max;
@@ -565,23 +574,22 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 		if (msk->pm.addr_signal & BIT(MPTCP_ADD_ADDR_SIGNAL))
 			return;
 
-		local = select_signal_address(pernet, msk);
-		if (!local)
+		if (!select_signal_address(pernet, msk, &local))
 			goto subflow;
 
 		/* If the alloc fails, we are on memory pressure, not worth
 		 * continuing, and trying to create subflows.
 		 */
-		if (!mptcp_pm_alloc_anno_list(msk, &local->addr))
+		if (!mptcp_pm_alloc_anno_list(msk, &local.addr))
 			return;
 
-		__clear_bit(local->addr.id, msk->pm.id_avail_bitmap);
+		__clear_bit(local.addr.id, msk->pm.id_avail_bitmap);
 		msk->pm.add_addr_signaled++;
-		mptcp_pm_announce_addr(msk, &local->addr, false);
+		mptcp_pm_announce_addr(msk, &local.addr, false);
 		mptcp_pm_nl_addr_send_ack(msk);
 
-		if (local->flags & MPTCP_PM_ADDR_FLAG_SUBFLOW)
-			signal_and_subflow = local;
+		if (local.flags & MPTCP_PM_ADDR_FLAG_SUBFLOW)
+			signal_and_subflow = true;
 	}
 
 subflow:
@@ -592,26 +600,22 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 		bool fullmesh;
 		int i, nr;
 
-		if (signal_and_subflow) {
-			local = signal_and_subflow;
-			signal_and_subflow = NULL;
-		} else {
-			local = select_local_address(pernet, msk);
-			if (!local)
-				break;
-		}
+		if (signal_and_subflow)
+			signal_and_subflow = false;
+		else if (!select_local_address(pernet, msk, &local))
+			break;
 
-		fullmesh = !!(local->flags & MPTCP_PM_ADDR_FLAG_FULLMESH);
+		fullmesh = !!(local.flags & MPTCP_PM_ADDR_FLAG_FULLMESH);
 
 		msk->pm.local_addr_used++;
-		__clear_bit(local->addr.id, msk->pm.id_avail_bitmap);
-		nr = fill_remote_addresses_vec(msk, &local->addr, fullmesh, addrs);
+		__clear_bit(local.addr.id, msk->pm.id_avail_bitmap);
+		nr = fill_remote_addresses_vec(msk, &local.addr, fullmesh, addrs);
 		if (nr == 0)
 			continue;
 
 		spin_unlock_bh(&msk->pm.lock);
 		for (i = 0; i < nr; i++)
-			__mptcp_subflow_connect(sk, &local->addr, &addrs[i]);
+			__mptcp_subflow_connect(sk, &local.addr, &addrs[i]);
 		spin_lock_bh(&msk->pm.lock);
 	}
 	mptcp_pm_nl_check_work_pending(msk);


