Return-Path: <stable+bounces-93969-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61FC09D25DF
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 13:31:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22C23285154
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 12:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E10D1C1F2A;
	Tue, 19 Nov 2024 12:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W4QXEki4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51FF192D77
	for <stable@vger.kernel.org>; Tue, 19 Nov 2024 12:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732019464; cv=none; b=a66lcmT1TT3dCip/DsVEN6a8xMsZUsG5/gIr591NwgxIIm9lXLSfdpX3bAsD937UF2WLRge2SgU/NL39+S1paxSml/b4Ow9tUYNaMvsF7HIc0ZbO1rQyxhnK8snJguNn0dIzLh9GKuK82erbo9Ffmv2MH54juf1glO7bxTUQB3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732019464; c=relaxed/simple;
	bh=efZ4H7B6LQ3sqKQUJRdHfeB63oXqoZy5ZMjgvjU9ehQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KEFK7+65eblTuGAVbaj8xBbf3fRr8lZS1FKZuYguJcB65YzqL/nDzYXHDK7elZ/IIkCrYkosWqC6QJx2u9U6BZoVNaGiSbFVXvCQ4iPQRv4ocPw8rJ98w6dgpQLat0FX5PGgZp2WxwF2JMUkfTttdfMRSziGNd+uvP4Qc1P4CJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W4QXEki4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4084EC4CECF;
	Tue, 19 Nov 2024 12:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732019464;
	bh=efZ4H7B6LQ3sqKQUJRdHfeB63oXqoZy5ZMjgvjU9ehQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W4QXEki4/gG+ratjregimmOVcNeQyAUA33s9PP6voMSSQpbSUoIoiOVQoUtTrqMkn
	 fjhG767TuSaBYWuewBjS6f22mCXrjDcdq3APukhzfsmt3uxEVJgJB4VQNutDry87hz
	 9Xo8SWO6ndQ2+ogPNxK+fP0NppAad9HY5G2GxpSUrk7HuBR2P70zhRsX5rzxw+kduJ
	 9RddFYyiy3TPIDspwUnOidQnwBzDAJ4lNur1e0ZsrGDBWceSSfNoe1lM7perSzcsEZ
	 8Ri7Zk9o1cQ30pyCQCNU8IIY5PYtqakq6OkaIBr2rfqQ3qn8iWpmkLVlLYlcs+LjL4
	 uBuEEvEgzvIHA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6.y 1/6] mptcp: define more local variables sk
Date: Tue, 19 Nov 2024 07:31:03 -0500
Message-ID: <20241118182718.3011097-9-matttbe@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241118182718.3011097-9-matttbe@kernel.org>
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

Commit in newer trees:

|-----------------|----------------------------------------------|
| 6.11.y          |  Present (exact SHA1)                        |
| 6.6.y           |  Not found                                   |
|-----------------|----------------------------------------------|

Note: The patch differs from the upstream commit:
---
--- -	2024-11-19 00:58:03.542379932 -0500
+++ /tmp/tmp.teBe5VO7C3	2024-11-19 00:58:03.540289647 -0500
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
+index e097b6a7b816..eded0f9c0b6f 100644
 --- a/net/mptcp/pm_userspace.c
 +++ b/net/mptcp/pm_userspace.c
-@@ -152,6 +152,7 @@ int mptcp_pm_nl_announce_doit(struct sk_buff *skb, struct genl_info *info)
+@@ -183,6 +183,7 @@ int mptcp_nl_cmd_announce(struct sk_buff *skb, struct genl_info *info)
  	struct mptcp_pm_addr_entry addr_val;
  	struct mptcp_sock *msk;
  	int err = -EINVAL;
@@ -23,7 +27,7 @@
  	u32 token_val;
  
  	if (!addr || !token) {
-@@ -167,6 +168,8 @@ int mptcp_pm_nl_announce_doit(struct sk_buff *skb, struct genl_info *info)
+@@ -198,6 +199,8 @@ int mptcp_nl_cmd_announce(struct sk_buff *skb, struct genl_info *info)
  		return err;
  	}
  
@@ -32,7 +36,7 @@
  	if (!mptcp_pm_is_userspace(msk)) {
  		GENL_SET_ERR_MSG(info, "invalid request; userspace PM not selected");
  		goto announce_err;
-@@ -190,7 +193,7 @@ int mptcp_pm_nl_announce_doit(struct sk_buff *skb, struct genl_info *info)
+@@ -221,7 +224,7 @@ int mptcp_nl_cmd_announce(struct sk_buff *skb, struct genl_info *info)
  		goto announce_err;
  	}
  
@@ -41,7 +45,7 @@
  	spin_lock_bh(&msk->pm.lock);
  
  	if (mptcp_pm_alloc_anno_list(msk, &addr_val.addr)) {
-@@ -200,11 +203,11 @@ int mptcp_pm_nl_announce_doit(struct sk_buff *skb, struct genl_info *info)
+@@ -231,11 +234,11 @@ int mptcp_nl_cmd_announce(struct sk_buff *skb, struct genl_info *info)
  	}
  
  	spin_unlock_bh(&msk->pm.lock);
@@ -55,7 +59,7 @@
  	return err;
  }
  
-@@ -251,6 +254,7 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
+@@ -282,6 +285,7 @@ int mptcp_nl_cmd_remove(struct sk_buff *skb, struct genl_info *info)
  	struct mptcp_sock *msk;
  	LIST_HEAD(free_list);
  	int err = -EINVAL;
@@ -63,7 +67,7 @@
  	u32 token_val;
  	u8 id_val;
  
-@@ -268,6 +272,8 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
+@@ -299,6 +303,8 @@ int mptcp_nl_cmd_remove(struct sk_buff *skb, struct genl_info *info)
  		return err;
  	}
  
@@ -72,7 +76,7 @@
  	if (!mptcp_pm_is_userspace(msk)) {
  		GENL_SET_ERR_MSG(info, "invalid request; userspace PM not selected");
  		goto remove_err;
-@@ -278,7 +284,7 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
+@@ -309,7 +315,7 @@ int mptcp_nl_cmd_remove(struct sk_buff *skb, struct genl_info *info)
  		goto remove_err;
  	}
  
@@ -81,7 +85,7 @@
  
  	list_for_each_entry(entry, &msk->pm.userspace_pm_local_addr_list, list) {
  		if (entry->addr.id == id_val) {
-@@ -289,7 +295,7 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
+@@ -320,7 +326,7 @@ int mptcp_nl_cmd_remove(struct sk_buff *skb, struct genl_info *info)
  
  	if (!match) {
  		GENL_SET_ERR_MSG(info, "address with specified id not found");
@@ -90,7 +94,7 @@
  		goto remove_err;
  	}
  
-@@ -297,15 +303,15 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
+@@ -328,15 +334,15 @@ int mptcp_nl_cmd_remove(struct sk_buff *skb, struct genl_info *info)
  
  	mptcp_pm_remove_addrs(msk, &free_list);
  
@@ -109,7 +113,7 @@
  	return err;
  }
  
-@@ -518,6 +524,7 @@ int mptcp_userspace_pm_set_flags(struct net *net, struct nlattr *token,
+@@ -558,6 +564,7 @@ int mptcp_userspace_pm_set_flags(struct net *net, struct nlattr *token,
  {
  	struct mptcp_sock *msk;
  	int ret = -EINVAL;
@@ -117,7 +121,7 @@
  	u32 token_val;
  
  	token_val = nla_get_u32(token);
-@@ -526,6 +533,8 @@ int mptcp_userspace_pm_set_flags(struct net *net, struct nlattr *token,
+@@ -566,6 +573,8 @@ int mptcp_userspace_pm_set_flags(struct net *net, struct nlattr *token,
  	if (!msk)
  		return ret;
  
@@ -126,7 +130,7 @@
  	if (!mptcp_pm_is_userspace(msk))
  		goto set_flags_err;
  
-@@ -533,11 +542,11 @@ int mptcp_userspace_pm_set_flags(struct net *net, struct nlattr *token,
+@@ -573,11 +582,11 @@ int mptcp_userspace_pm_set_flags(struct net *net, struct nlattr *token,
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
| stable/linux-6.6.y        |  Success    |  Success   |

