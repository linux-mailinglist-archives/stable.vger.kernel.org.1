Return-Path: <stable+bounces-94026-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24AFC9D2884
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 15:47:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEF4B280FB4
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 14:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72F251CCECD;
	Tue, 19 Nov 2024 14:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hOTjJjlH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31BB81CCEC6
	for <stable@vger.kernel.org>; Tue, 19 Nov 2024 14:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732027617; cv=none; b=XEab0wtffdmP3YpQrkBPP4T/+guSl/XrSIyUaKbSkpscE10GQAjBfvCo2tdxQ/xA7uGOIPyrVj7bBCKHUqo2rH+D8nrltxc1HbryMrMHUWR26pYufJKzCpDc+tz/7DE2WR+hjYDRshMpFPhj89vLAvFXQUrFtodKNfZc856I/MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732027617; c=relaxed/simple;
	bh=G+9PKgMo/YB8FzszVwjCqOIXfMCkWYzrmMncMVmSy84=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FFlQuAh6Y+OE+klgS8pMzZMJ+zk6he38fl62mxsewk6udPZgOWexscwubT0E3/ZnOQJ93WdUi+eDVMQBlKfELj8CvoIQwqxF6+yq719uhnHHvSsoGdBsdFJXTHX4wMU60smNKcTPo9ZT1HuZrMVdWo281wFIPOWeXuGlO+zFEO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hOTjJjlH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F263C4CECF;
	Tue, 19 Nov 2024 14:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732027617;
	bh=G+9PKgMo/YB8FzszVwjCqOIXfMCkWYzrmMncMVmSy84=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hOTjJjlHXLBuQe+lFt/n7QUSU/MVbqey8ZMAiXRDoeOodWfnSMwxnFTbxK9nVbhSq
	 +A6GOw/Ivfei2MKkxptuSi4QcU5SgePHGVcUsIw8vD6n/RuryneyH3F3aHZS4eJ0Dv
	 tWwQBU1RWDTGx5e/wNZjvhDfhIdbMSO5g7FOcuQZVz/UiJQisYZCm/4srUSHfMbiKN
	 h1Xt1owJHnD9ear4gEYaGU0pCTT100yUqNjslQbN0EvgHdEmURl6AjunzpWphpwnW1
	 jHXvY4vrCAJwOpBoDPuO0+1jx+QuuM9OOopGKRDg9QorcTdD8WiptVY20/UQbFLxcV
	 ZinossHIClstw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y 4/7] mptcp: update local address flags when setting it
Date: Tue, 19 Nov 2024 09:46:55 -0500
Message-ID: <20241119083547.3234013-13-matttbe@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241119083547.3234013-13-matttbe@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

The upstream commit SHA1 provided is correct: e0266319413d5d687ba7b6df7ca99e4b9724a4f2

WARNING: Author mismatch between patch and upstream commit:
Backport author: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Commit author: Geliang Tang <tanggeliang@kylinos.cn>


Status in newer kernel trees:
6.11.y | Present (different SHA1: a2062ee787b2)
6.6.y | Not found
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
--- -	2024-11-19 09:05:50.733275277 -0500
+++ /tmp/tmp.PYLoTfPdIR	2024-11-19 09:05:50.728073161 -0500
@@ -1,3 +1,5 @@
+commit e0266319413d5d687ba7b6df7ca99e4b9724a4f2 upstream.
+
 Just like in-kernel pm, when userspace pm does set_flags, it needs to send
 out MP_PRIO signal, and also modify the flags of the corresponding address
 entry in the local address list. This patch implements the missing logic.
@@ -13,29 +15,34 @@
 Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
 Link: https://patch.msgid.link/20241112-net-mptcp-misc-6-12-pm-v1-1-b835580cefa8@kernel.org
 Signed-off-by: Jakub Kicinski <kuba@kernel.org>
+[ Conflicts in pm_userspace.c, because commit 6a42477fe449 ("mptcp:
+  update set_flags interfaces"), is not in this version, and causes too
+  many conflicts when backporting it. The same code can still be added
+  at the same place, before sending the ACK. ]
+Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
 ---
  net/mptcp/pm_userspace.c | 12 ++++++++++++
  1 file changed, 12 insertions(+)
 
 diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
-index 56dfea9862b7b..3f888bfe1462e 100644
+index ca3e452d4edb..195f84f16b97 100644
 --- a/net/mptcp/pm_userspace.c
 +++ b/net/mptcp/pm_userspace.c
-@@ -560,6 +560,7 @@ int mptcp_userspace_pm_set_flags(struct sk_buff *skb, struct genl_info *info)
- 	struct nlattr *token = info->attrs[MPTCP_PM_ATTR_TOKEN];
- 	struct nlattr *attr = info->attrs[MPTCP_PM_ATTR_ADDR];
- 	struct net *net = sock_net(skb->sk);
+@@ -565,6 +565,7 @@ int mptcp_userspace_pm_set_flags(struct net *net, struct nlattr *token,
+ 				 struct mptcp_pm_addr_entry *loc,
+ 				 struct mptcp_pm_addr_entry *rem, u8 bkup)
+ {
 +	struct mptcp_pm_addr_entry *entry;
  	struct mptcp_sock *msk;
  	int ret = -EINVAL;
  	struct sock *sk;
-@@ -601,6 +602,17 @@ int mptcp_userspace_pm_set_flags(struct sk_buff *skb, struct genl_info *info)
- 	if (loc.flags & MPTCP_PM_ADDR_FLAG_BACKUP)
- 		bkup = 1;
+@@ -585,6 +586,17 @@ int mptcp_userspace_pm_set_flags(struct net *net, struct nlattr *token,
+ 	    rem->addr.family == AF_UNSPEC)
+ 		goto set_flags_err;
  
 +	spin_lock_bh(&msk->pm.lock);
 +	list_for_each_entry(entry, &msk->pm.userspace_pm_local_addr_list, list) {
-+		if (mptcp_addresses_equal(&entry->addr, &loc.addr, false)) {
++		if (mptcp_addresses_equal(&entry->addr, &loc->addr, false)) {
 +			if (bkup)
 +				entry->flags |= MPTCP_PM_ADDR_FLAG_BACKUP;
 +			else
@@ -45,5 +52,8 @@
 +	spin_unlock_bh(&msk->pm.lock);
 +
  	lock_sock(sk);
- 	ret = mptcp_pm_nl_mp_prio_send_ack(msk, &loc.addr, &rem.addr, bkup);
+ 	ret = mptcp_pm_nl_mp_prio_send_ack(msk, &loc->addr, &rem->addr, bkup);
  	release_sock(sk);
+-- 
+2.45.2
+
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

