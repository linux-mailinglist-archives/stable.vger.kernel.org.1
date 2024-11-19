Return-Path: <stable+bounces-93975-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 33FF49D25E6
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 13:31:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1FD81F24540
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 12:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA2151CBE89;
	Tue, 19 Nov 2024 12:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LJUqCn+T"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB9313B780
	for <stable@vger.kernel.org>; Tue, 19 Nov 2024 12:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732019476; cv=none; b=E7TF3oOJUaEww5WAxFIKWNGkNYhoGR5Znmn0D7fziFrCIYfQY1FeWE57CCCo4uVdaHBJWjVRTtRVwMQpS8mIE46p7O83hqvH4PnEZcdKIwVzdDMLmrTHOKf72oRUeGCdYcvML/sJ+zfnmtQty9+hmjIFFXLNrKDkyCzn3KNZxVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732019476; c=relaxed/simple;
	bh=pGhRiKczDgLD1J3OyOqV/p3g/zA9dBb9fAPnkizr7yU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ohe8acdOl8XVbcn7Bl3JG1LHV6LSl6FBHureBOYOB+BOt3N0N5vHH8Z9fjCEl4OFnnPtt5H0l17sh7Up2uY8XTOs1u3ZzUxNF5Y5QvqzPUsItAah6z0DKikNOSFIYtEstvqzNbK0ppmqoTC6lDTgQnTcbBaEkcRW8lJBwjmmibw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LJUqCn+T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12A02C4CECF;
	Tue, 19 Nov 2024 12:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732019476;
	bh=pGhRiKczDgLD1J3OyOqV/p3g/zA9dBb9fAPnkizr7yU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LJUqCn+T6xwpl/n2R85EdKoRhKh7GoL/6N/XxwERA9TWjnW85BBODONxbdSgVO9ow
	 CD4PPZhIFEUajMJfLv8L8AFrJ5+1kjKVRg161dJJ5maWSYSvcAuaNyiIvLAcV8uk6e
	 jJFfvBqmRiH1+dhA1wpv7MGPIbNtawoIo3D/xn/0IayLMce4Dh+XuOUYfF3f2xHXJw
	 03Vo4yYWo0f5nUcFv8RjO+CITtzqlZY7k6rqyXQG+uW7/SGRRsLzJB9QF4ZdJvS8pd
	 BcmjYdQU83jDMZB4HRXqYCtImxFfyyqjPz6DdDPlkQD5ofFUz70jhCdo68i64mF9uq
	 O3vEUDE6oGqZw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6.y 3/6] mptcp: update local address flags when setting it
Date: Tue, 19 Nov 2024 07:31:14 -0500
Message-ID: <20241118182718.3011097-11-matttbe@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241118182718.3011097-11-matttbe@kernel.org>
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

Commit in newer trees:

|-----------------|----------------------------------------------|
| 6.11.y          |  Present (different SHA1: a2062ee787b2)      |
| 6.6.y           |  Not found                                   |
|-----------------|----------------------------------------------|

Note: The patch differs from the upstream commit:
---
--- -	2024-11-19 01:08:21.112126559 -0500
+++ /tmp/tmp.JshXcaxs5Q	2024-11-19 01:08:21.107482370 -0500
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
+index 23e362c11801..e268f61d8eb0 100644
 --- a/net/mptcp/pm_userspace.c
 +++ b/net/mptcp/pm_userspace.c
-@@ -560,6 +560,7 @@ int mptcp_userspace_pm_set_flags(struct sk_buff *skb, struct genl_info *info)
- 	struct nlattr *token = info->attrs[MPTCP_PM_ATTR_TOKEN];
- 	struct nlattr *attr = info->attrs[MPTCP_PM_ATTR_ADDR];
- 	struct net *net = sock_net(skb->sk);
+@@ -563,6 +563,7 @@ int mptcp_userspace_pm_set_flags(struct net *net, struct nlattr *token,
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
+@@ -583,6 +584,17 @@ int mptcp_userspace_pm_set_flags(struct net *net, struct nlattr *token,
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
| stable/linux-6.6.y        |  Success    |  Success   |

