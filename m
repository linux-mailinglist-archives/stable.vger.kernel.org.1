Return-Path: <stable+bounces-93974-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF589D25E5
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 13:31:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9715F1F24B80
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 12:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C7E1CACD9;
	Tue, 19 Nov 2024 12:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OtLI4FK0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801D91C2454
	for <stable@vger.kernel.org>; Tue, 19 Nov 2024 12:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732019474; cv=none; b=XGfYBu7x+ghiuwukKFMEoQJ8hEgmClBzRBRINYnoEoCu+Rr0txAkMrU33kmNFa8xCR1FcIIpmPz7sy0t2+EuMifaZFXGFe5CB0gkxi9WHICXQGeeIMRqIL6nXrgd/2G0aJt7Y/yc4jjOE5SWyt4LIDHc8J184gVoffJcQ3TAGfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732019474; c=relaxed/simple;
	bh=dlWVOl3NpWI1d93BeRiKKNO6yrQ+8mAk0Nx8idjC/6E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EMaz3IFlcgN/WlDK9lPrb/b3MEDTY7fRHmitpe6Bf83aKDEHEs1t4QoU11Z7F2b4EPDtZKkUhiXenscJye2kM+2Z7yFyKBIC3gvCxdE11LPW2XVBkdNcmTDupDWaXORwUxLTc8UjoXJUDwOqStml01I4Dx2dtKNAGax/0/cZMXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OtLI4FK0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E02D6C4CECF;
	Tue, 19 Nov 2024 12:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732019474;
	bh=dlWVOl3NpWI1d93BeRiKKNO6yrQ+8mAk0Nx8idjC/6E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OtLI4FK0Q6EaciO89v522atRG4LYR1bn37tVNggTLLCrPHM+LqTJjHk8l8dneyC07
	 KFIog3F1fpQMdpkaSLmBLBMp8MtrnJwAid5wc9L5nzxBiOtX8LbHFKUFTwOtl8WnRv
	 5/4kI8WmQCQ5VK+kCGSU/WXy9hWMGWbQlonldRJlzj26225+eXOplfpqz17pbM8SKt
	 QHP/MKz+1uD3wxnFjWh0D0gMXByHZg4DJrYH70sxlP+GLOKwIWWo2YbJNCrQRc+Ukc
	 kREvZlGdIq6iy7xhIZnvbrd9pMZzKXKHTNzqrBObXjWGyGRPfM3B+RNjGqSg/vQFVF
	 l4m5I94Mlb1PQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6.y 2/6] mptcp: add userspace_pm_lookup_addr_by_id helper
Date: Tue, 19 Nov 2024 07:31:12 -0500
Message-ID: <20241118182718.3011097-10-matttbe@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241118182718.3011097-10-matttbe@kernel.org>
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

Commit in newer trees:

|-----------------|----------------------------------------------|
| 6.11.y          |  Present (exact SHA1)                        |
| 6.6.y           |  Not found                                   |
|-----------------|----------------------------------------------|

Note: The patch differs from the upstream commit:
---
--- -	2024-11-19 01:03:18.229030137 -0500
+++ /tmp/tmp.cXmNHAm0RR	2024-11-19 01:03:18.223800931 -0500
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
+index eded0f9c0b6f..23e362c11801 100644
 --- a/net/mptcp/pm_userspace.c
 +++ b/net/mptcp/pm_userspace.c
-@@ -106,19 +106,26 @@ static int mptcp_userspace_pm_delete_local_addr(struct mptcp_sock *msk,
+@@ -107,19 +107,26 @@ static int mptcp_userspace_pm_delete_local_addr(struct mptcp_sock *msk,
  	return -EINVAL;
  }
  
@@ -50,7 +54,7 @@
  	spin_unlock_bh(&msk->pm.lock);
  	if (match) {
  		*flags = match->flags;
-@@ -261,7 +268,7 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
+@@ -280,7 +287,7 @@ int mptcp_nl_cmd_remove(struct sk_buff *skb, struct genl_info *info)
  {
  	struct nlattr *token = info->attrs[MPTCP_PM_ATTR_TOKEN];
  	struct nlattr *id = info->attrs[MPTCP_PM_ATTR_LOC_ID];
@@ -59,7 +63,7 @@
  	struct mptcp_pm_addr_entry *entry;
  	struct mptcp_sock *msk;
  	LIST_HEAD(free_list);
-@@ -298,13 +305,7 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
+@@ -317,13 +324,7 @@ int mptcp_nl_cmd_remove(struct sk_buff *skb, struct genl_info *info)
  
  	lock_sock(sk);
  
@@ -74,3 +78,6 @@
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
| stable/linux-6.6.y        |  Success    |  Success   |

