Return-Path: <stable+bounces-94028-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 04AEF9D2892
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 15:48:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6685DB28AF9
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 14:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A8FA1CF2A1;
	Tue, 19 Nov 2024 14:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KsU0t/8U"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF8A1CEACB
	for <stable@vger.kernel.org>; Tue, 19 Nov 2024 14:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732027621; cv=none; b=CptzARuDo+q7bkjO25DOemnrN/23KDHAGx7SUj61J1vekF7kiTZeRiv3aNmYdgMZ4JYu9jSCHIJznpv2V7IDYgremZj3WeKDXxTCXG5BU0jYNBto6K0JTsWIkAsc41pdMkVrjfExV7m2Tgr5cs2l7NiycxHjGqpUWAIejK4+cls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732027621; c=relaxed/simple;
	bh=O5xXA10kLRIAl+YsdDERQCcKy42VC+ioO35iHEnYsQI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VApF0VzWy96pCZGa72avRwLlNm4f7rAJo5pIXxvGKeQeiTSHpzNFyxhO0HIeR0DO/xAlqb/XSqeIG0pR439XpeabOdT7tXTvEU93HxX95SavygJkNUe6CkajRuZDso3qUKu1L3W1gIIgzIlCnd+r9fvdpCi+HhtY1pC+k063hcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KsU0t/8U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86226C4CECF;
	Tue, 19 Nov 2024 14:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732027621;
	bh=O5xXA10kLRIAl+YsdDERQCcKy42VC+ioO35iHEnYsQI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KsU0t/8U3Ef3GtGFUqQchPA/7tEMSA+jqzc02anKZAhw7B89ZIx7J9gTtM9u6OQFe
	 wRMyDA88E3a+mrWHqXwTAydbS8G5TQz7763TL+xQ1G3yuLZXd4ipCrFwIRjb4aDtWc
	 ndoZSFw7YEurLhFOcal/iPkGvRyDr/BlCjfjLmkhZ0pc2U9/qgYhXFwHAbEYtxjjtu
	 MyM7XlUgqc61JyV9RCkDP1STS0ig6vlGS52Ixi+baz0yKXbY+7DHI6gxxHjz99co5+
	 K9KIwWstUhywRA8DNLZbtWriSrgA493cBPu7cPKfs7pEfirF4pvM+Yk3PLmil9wYRp
	 mlJKHWtCNvDwQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y 2/7] mptcp: define more local variables sk
Date: Tue, 19 Nov 2024 09:46:59 -0500
Message-ID: <20241119083547.3234013-11-matttbe@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241119083547.3234013-11-matttbe@kernel.org>
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

The upstream commit SHA1 provided is correct: 14cb0e0bf39bd10429ba14e9e2f905f1144226fc

WARNING: Author mismatch between patch and upstream commit:
Backport author: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Commit author: Geliang Tang <geliang.tang@suse.com>


Status in newer kernel trees:
6.11.y | Present (exact SHA1)
6.6.y | Not found
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
--- -	2024-11-19 08:47:06.856885002 -0500
+++ /tmp/tmp.6gMpdrO84b	2024-11-19 08:47:06.852544679 -0500
@@ -1,3 +1,5 @@
+commit 14cb0e0bf39bd10429ba14e9e2f905f1144226fc upstream.
+
 '(struct sock *)msk' is used several times in mptcp_nl_cmd_announce(),
 mptcp_nl_cmd_remove() or mptcp_userspace_pm_set_flags() in pm_userspace.c,
 it's worth adding a local variable sk to point it.
@@ -7,15 +9,17 @@
 Signed-off-by: Mat Martineau <martineau@kernel.org>
 Link: https://lore.kernel.org/r/20231025-send-net-next-20231025-v1-8-db8f25f798eb@kernel.org
 Signed-off-by: Jakub Kicinski <kuba@kernel.org>
+Stable-dep-of: 06afe09091ee ("mptcp: add userspace_pm_lookup_addr_by_id helper")
+Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
 ---
  net/mptcp/pm_userspace.c | 31 ++++++++++++++++++++-----------
  1 file changed, 20 insertions(+), 11 deletions(-)
 
 diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
-index 7bb2b29e5b964..5c01b9bc619a8 100644
+index 748e3876ec6d..530f414e57d6 100644
 --- a/net/mptcp/pm_userspace.c
 +++ b/net/mptcp/pm_userspace.c
-@@ -152,6 +152,7 @@ int mptcp_pm_nl_announce_doit(struct sk_buff *skb, struct genl_info *info)
+@@ -185,6 +185,7 @@ int mptcp_nl_cmd_announce(struct sk_buff *skb, struct genl_info *info)
  	struct mptcp_pm_addr_entry addr_val;
  	struct mptcp_sock *msk;
  	int err = -EINVAL;
@@ -23,7 +27,7 @@
  	u32 token_val;
  
  	if (!addr || !token) {
-@@ -167,6 +168,8 @@ int mptcp_pm_nl_announce_doit(struct sk_buff *skb, struct genl_info *info)
+@@ -200,6 +201,8 @@ int mptcp_nl_cmd_announce(struct sk_buff *skb, struct genl_info *info)
  		return err;
  	}
  
@@ -32,7 +36,7 @@
  	if (!mptcp_pm_is_userspace(msk)) {
  		GENL_SET_ERR_MSG(info, "invalid request; userspace PM not selected");
  		goto announce_err;
-@@ -190,7 +193,7 @@ int mptcp_pm_nl_announce_doit(struct sk_buff *skb, struct genl_info *info)
+@@ -223,7 +226,7 @@ int mptcp_nl_cmd_announce(struct sk_buff *skb, struct genl_info *info)
  		goto announce_err;
  	}
  
@@ -41,7 +45,7 @@
  	spin_lock_bh(&msk->pm.lock);
  
  	if (mptcp_pm_alloc_anno_list(msk, &addr_val.addr)) {
-@@ -200,11 +203,11 @@ int mptcp_pm_nl_announce_doit(struct sk_buff *skb, struct genl_info *info)
+@@ -233,11 +236,11 @@ int mptcp_nl_cmd_announce(struct sk_buff *skb, struct genl_info *info)
  	}
  
  	spin_unlock_bh(&msk->pm.lock);
@@ -55,7 +59,7 @@
  	return err;
  }
  
-@@ -251,6 +254,7 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
+@@ -284,6 +287,7 @@ int mptcp_nl_cmd_remove(struct sk_buff *skb, struct genl_info *info)
  	struct mptcp_sock *msk;
  	LIST_HEAD(free_list);
  	int err = -EINVAL;
@@ -63,7 +67,7 @@
  	u32 token_val;
  	u8 id_val;
  
-@@ -268,6 +272,8 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
+@@ -301,6 +305,8 @@ int mptcp_nl_cmd_remove(struct sk_buff *skb, struct genl_info *info)
  		return err;
  	}
  
@@ -72,7 +76,7 @@
  	if (!mptcp_pm_is_userspace(msk)) {
  		GENL_SET_ERR_MSG(info, "invalid request; userspace PM not selected");
  		goto remove_err;
-@@ -278,7 +284,7 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
+@@ -311,7 +317,7 @@ int mptcp_nl_cmd_remove(struct sk_buff *skb, struct genl_info *info)
  		goto remove_err;
  	}
  
@@ -81,7 +85,7 @@
  
  	list_for_each_entry(entry, &msk->pm.userspace_pm_local_addr_list, list) {
  		if (entry->addr.id == id_val) {
-@@ -289,7 +295,7 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
+@@ -322,7 +328,7 @@ int mptcp_nl_cmd_remove(struct sk_buff *skb, struct genl_info *info)
  
  	if (!match) {
  		GENL_SET_ERR_MSG(info, "address with specified id not found");
@@ -90,7 +94,7 @@
  		goto remove_err;
  	}
  
-@@ -297,15 +303,15 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
+@@ -330,15 +336,15 @@ int mptcp_nl_cmd_remove(struct sk_buff *skb, struct genl_info *info)
  
  	mptcp_pm_remove_addrs(msk, &free_list);
  
@@ -109,7 +113,7 @@
  	return err;
  }
  
-@@ -518,6 +524,7 @@ int mptcp_userspace_pm_set_flags(struct net *net, struct nlattr *token,
+@@ -560,6 +566,7 @@ int mptcp_userspace_pm_set_flags(struct net *net, struct nlattr *token,
  {
  	struct mptcp_sock *msk;
  	int ret = -EINVAL;
@@ -117,7 +121,7 @@
  	u32 token_val;
  
  	token_val = nla_get_u32(token);
-@@ -526,6 +533,8 @@ int mptcp_userspace_pm_set_flags(struct net *net, struct nlattr *token,
+@@ -568,6 +575,8 @@ int mptcp_userspace_pm_set_flags(struct net *net, struct nlattr *token,
  	if (!msk)
  		return ret;
  
@@ -126,7 +130,7 @@
  	if (!mptcp_pm_is_userspace(msk))
  		goto set_flags_err;
  
-@@ -533,11 +542,11 @@ int mptcp_userspace_pm_set_flags(struct net *net, struct nlattr *token,
+@@ -575,11 +584,11 @@ int mptcp_userspace_pm_set_flags(struct net *net, struct nlattr *token,
  	    rem->addr.family == AF_UNSPEC)
  		goto set_flags_err;
  
@@ -141,3 +145,6 @@
 +	sock_put(sk);
  	return ret;
  }
+-- 
+2.45.2
+
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

