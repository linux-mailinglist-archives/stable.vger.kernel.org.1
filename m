Return-Path: <stable+bounces-94027-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B33309D2885
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 15:47:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 795B1282D04
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 14:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B90211CF28C;
	Tue, 19 Nov 2024 14:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HNDPzA3s"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8681CEE9D
	for <stable@vger.kernel.org>; Tue, 19 Nov 2024 14:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732027619; cv=none; b=C06XjbXgC0MprMeBeHW5BIJayiyrVv+U+CDP5azbMfJWJ97HKj4lEsXiJ68EUEJx9D0LG//oipCzL9+NDzE0IXcwD2CDguBcnAHXvdBXRyzIw4ePPaKhMVuy/gxBcFbzAGIEi2bM7qSzISISzZignV8uTCZDUtzddrWzw39+RM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732027619; c=relaxed/simple;
	bh=jfRFznXNVIVCiMf5TXskwpazNK2tcWBZPiCeGKWWB0g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nTkDcxkmCSO7Z8Rid8MSx3yK6NTBqzeOS9hETzSDrhslN0RIaRDDxIkqLvJoI6zj/bsSQzVKDhhpY+K2DLhoKXGiM2yawW4OPKm7UPn+bm4vQFHTqWgd8TkHwjcQA/KwdqsdZVfemYE3V1OhepZEX8M3bY8KQtjJMm7jfEYacBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HNDPzA3s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96916C4CECF;
	Tue, 19 Nov 2024 14:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732027619;
	bh=jfRFznXNVIVCiMf5TXskwpazNK2tcWBZPiCeGKWWB0g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HNDPzA3sM9vtUPWudXbba0i62Zi4B/FX9GrAFa5yDmrJp7J8plaLeOmxJosnCiwtU
	 K6Oqvd/WHSwrSnmw2C+rfVSqg5khOgSW/igg8jWmT4QYkT3bn03TdhC6TnzLfMkX7r
	 9ERZsrX+Yk/78KBreo/2Ps/nRLeSRD4THiv2TwZQQ5RStK/Ee/qHx6O7miMjtF11Tf
	 F5Qnocr1CDeOwWwbTnC4EF6Ixdf7eLY/5GqzHXaB6OLDmIHySoPi8SzXbDpyKEffey
	 ZLlB6OftSDBd7/tlSTCDxxhm/joQBngeZXoLWq6nsn43aLqYY25rlbQB4HY+c7EJ1g
	 L2dzkqQYVHPfg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y 3/7] mptcp: add userspace_pm_lookup_addr_by_id helper
Date: Tue, 19 Nov 2024 09:46:57 -0500
Message-ID: <20241119083547.3234013-12-matttbe@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241119083547.3234013-12-matttbe@kernel.org>
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

The upstream commit SHA1 provided is correct: 06afe09091ee69dc7ab058b4be9917ae59cc81e5

WARNING: Author mismatch between patch and upstream commit:
Backport author: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Commit author: Geliang Tang <tanggeliang@kylinos.cn>


Status in newer kernel trees:
6.11.y | Present (exact SHA1)
6.6.y | Not found
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
--- -	2024-11-19 08:56:32.828886482 -0500
+++ /tmp/tmp.3kjEa5Z2e2	2024-11-19 08:56:32.824223221 -0500
@@ -1,3 +1,5 @@
+commit 06afe09091ee69dc7ab058b4be9917ae59cc81e5 upstream.
+
 Corresponding __lookup_addr_by_id() helper in the in-kernel netlink PM,
 this patch adds a new helper mptcp_userspace_pm_lookup_addr_by_id() to
 lookup the address entry with the given id on the userspace pm local
@@ -8,15 +10,17 @@
 Reviewed-by: Mat Martineau <martineau@kernel.org>
 Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
 Signed-off-by: David S. Miller <davem@davemloft.net>
+Stable-dep-of: f642c5c4d528 ("mptcp: hold pm lock when deleting entry")
+Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
 ---
  net/mptcp/pm_userspace.c | 31 ++++++++++++++++---------------
  1 file changed, 16 insertions(+), 15 deletions(-)
 
 diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
-index 3bd13e94b5687..20cbcb62cd8c5 100644
+index 530f414e57d6..ca3e452d4edb 100644
 --- a/net/mptcp/pm_userspace.c
 +++ b/net/mptcp/pm_userspace.c
-@@ -106,19 +106,26 @@ static int mptcp_userspace_pm_delete_local_addr(struct mptcp_sock *msk,
+@@ -106,22 +106,29 @@ static int mptcp_userspace_pm_delete_local_addr(struct mptcp_sock *msk,
  	return -EINVAL;
  }
  
@@ -39,6 +43,9 @@
 -	struct mptcp_pm_addr_entry *entry, *match = NULL;
 +	struct mptcp_pm_addr_entry *match;
  
+ 	*flags = 0;
+ 	*ifindex = 0;
+ 
  	spin_lock_bh(&msk->pm.lock);
 -	list_for_each_entry(entry, &msk->pm.userspace_pm_local_addr_list, list) {
 -		if (id == entry->addr.id) {
@@ -50,7 +57,7 @@
  	spin_unlock_bh(&msk->pm.lock);
  	if (match) {
  		*flags = match->flags;
-@@ -261,7 +268,7 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
+@@ -282,7 +289,7 @@ int mptcp_nl_cmd_remove(struct sk_buff *skb, struct genl_info *info)
  {
  	struct nlattr *token = info->attrs[MPTCP_PM_ATTR_TOKEN];
  	struct nlattr *id = info->attrs[MPTCP_PM_ATTR_LOC_ID];
@@ -59,7 +66,7 @@
  	struct mptcp_pm_addr_entry *entry;
  	struct mptcp_sock *msk;
  	LIST_HEAD(free_list);
-@@ -298,13 +305,7 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
+@@ -319,13 +326,7 @@ int mptcp_nl_cmd_remove(struct sk_buff *skb, struct genl_info *info)
  
  	lock_sock(sk);
  
@@ -74,3 +81,6 @@
  	if (!match) {
  		GENL_SET_ERR_MSG(info, "address with specified id not found");
  		release_sock(sk);
+-- 
+2.45.2
+
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

