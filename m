Return-Path: <stable+bounces-94020-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AB0D9D287F
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 15:47:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3F69284DCC
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 14:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5645D1CF2BE;
	Tue, 19 Nov 2024 14:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jeNu2NS+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F731CC174
	for <stable@vger.kernel.org>; Tue, 19 Nov 2024 14:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732027605; cv=none; b=GXRBH28VrYPT9SE/wxtWVnwIhbdw6BGy6evMJSM5fc959JrHjmq2yyC4dL1uGkJqj5espWPuQH7p6/MRwhNOOOWoFk8Cp3gMyLgfk53g4KuMUWGh10j6Q0pemgVSOdSmv+ovxq2dOyvETCcO5cpQUqvOAMvQpPXIozMBByZ0YYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732027605; c=relaxed/simple;
	bh=Vo2xilMbzvaKPObujd+z1M8eYyyDOIVMOTT6EL/gwi4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d9mbkvhN3Az2i1Gc0n3SohMszzXLyt/kmNOFctVRaM0Tqr7Ec9PXtJoSzCokIhG+DQwdVFfMrOEUPfbbGPGnYz6N+DIaY/acY263FnuCxq672YYE1RUPBuTMk7KpCSCSn6d9bJRmxPTUyfu8bFnYVUPYIhsu1PsFQKRq/AuosJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jeNu2NS+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F3DFC4CECF;
	Tue, 19 Nov 2024 14:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732027604;
	bh=Vo2xilMbzvaKPObujd+z1M8eYyyDOIVMOTT6EL/gwi4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jeNu2NS+iR1OXGpNvCWfzZShnb+ToyZWQbyTiXRSLiXSDnhOEDEAvzVA3nP/CmK6Z
	 6ajirGNvSFd7D00gxi3ybQLY4X77I9M1AXAUNwxq2oVnUYgvbNPh2l33pO/QGlZq/8
	 XvGUSdr6coTie+FF/qvpIX+Vhx2Z2t86hwFpF9kwu+3JYf8Zkk/rHY+pfMWqYkReax
	 BVA7wVIJF3XNhBnqgOTLrLTYDjSPtp6NiTzChCQhqPjfde9fAFvNzEj9gDU/5UnIQv
	 bX+aXLWeqWuTo1nzYmsJQJTt3sqznJ0VpzYlw+E4yVOfgVRr3PzXDpVIlijhC+X7Yr
	 RTCPguVvFIX1A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y 6/7] mptcp: drop lookup_by_id in lookup_addr
Date: Tue, 19 Nov 2024 09:46:42 -0500
Message-ID: <20241119083547.3234013-15-matttbe@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241119083547.3234013-15-matttbe@kernel.org>
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

The upstream commit SHA1 provided is correct: af250c27ea1c404e210fc3a308b20f772df584d6

WARNING: Author mismatch between patch and upstream commit:
Backport author: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Commit author: Geliang Tang <tanggeliang@kylinos.cn>


Status in newer kernel trees:
6.11.y | Present (exact SHA1)
6.6.y | Not found
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
--- -	2024-11-19 09:24:03.249399574 -0500
+++ /tmp/tmp.2tsnXkauzv	2024-11-19 09:24:03.244329130 -0500
@@ -1,3 +1,5 @@
+commit af250c27ea1c404e210fc3a308b20f772df584d6 upstream.
+
 When the lookup_by_id parameter of __lookup_addr() is true, it's the same
 as __lookup_addr_by_id(), it can be replaced by __lookup_addr_by_id()
 directly. So drop this parameter, let __lookup_addr() only looks up address
@@ -8,15 +10,22 @@
 Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
 Link: https://lore.kernel.org/r/20240305-upstream-net-next-20240304-mptcp-misc-cleanup-v1-4-c436ba5e569b@kernel.org
 Signed-off-by: Jakub Kicinski <kuba@kernel.org>
+Stable-dep-of: db3eab8110bc ("mptcp: pm: use _rcu variant under rcu_read_lock")
+[ Conflicts in pm_netlink.c, because commit 6a42477fe449 ("mptcp: update
+  set_flags interfaces") is not in this version, and causes too many
+  conflicts when backporting it. The conflict is easy to resolve: addr
+  is a pointer here here in mptcp_pm_nl_set_flags(), the rest of the
+  code is the same. ]
+Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
 ---
  net/mptcp/pm_netlink.c | 12 +++++-------
  1 file changed, 5 insertions(+), 7 deletions(-)
 
 diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
-index 354083b8386f0..5c17d39146ea2 100644
+index 49e8156f5388..9b65d9360976 100644
 --- a/net/mptcp/pm_netlink.c
 +++ b/net/mptcp/pm_netlink.c
-@@ -499,15 +499,12 @@ __lookup_addr_by_id(struct pm_nl_pernet *pernet, unsigned int id)
+@@ -525,15 +525,12 @@ __lookup_addr_by_id(struct pm_nl_pernet *pernet, unsigned int id)
  }
  
  static struct mptcp_pm_addr_entry *
@@ -34,7 +43,7 @@
  			return entry;
  	}
  	return NULL;
-@@ -537,7 +534,7 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
+@@ -564,7 +561,7 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
  
  		mptcp_local_address((struct sock_common *)msk->first, &mpc_addr);
  		rcu_read_lock();
@@ -43,8 +52,8 @@
  		if (entry) {
  			__clear_bit(entry->addr.id, msk->pm.id_avail_bitmap);
  			msk->mpc_endpoint_id = entry->addr.id;
-@@ -1918,7 +1915,8 @@ int mptcp_pm_nl_set_flags(struct sk_buff *skb, struct genl_info *info)
- 		bkup = 1;
+@@ -2081,7 +2078,8 @@ static int mptcp_nl_cmd_set_flags(struct sk_buff *skb, struct genl_info *info)
+ 						    token, &addr, &remote, bkup);
  
  	spin_lock_bh(&pernet->lock);
 -	entry = __lookup_addr(pernet, &addr.addr, lookup_by_id);
@@ -52,4 +61,7 @@
 +			       __lookup_addr(pernet, &addr.addr);
  	if (!entry) {
  		spin_unlock_bh(&pernet->lock);
- 		GENL_SET_ERR_MSG(info, "address not found");
+ 		return -EINVAL;
+-- 
+2.45.2
+
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

