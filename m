Return-Path: <stable+bounces-94024-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D39D19D2882
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 15:47:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9911A281840
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 14:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D30C41CF5E3;
	Tue, 19 Nov 2024 14:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rPSEn9hh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937B81CDFC8
	for <stable@vger.kernel.org>; Tue, 19 Nov 2024 14:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732027613; cv=none; b=CowjEc96m4+OkL2GAwldne6yFb6BW7q8VnKNVo5RekY9vkJTwCJoyfoybTtJ65Hjzbfz3idH7hOk3kwizNIO72G0BuAj8y1uhccbAwz4ITX+QVu0/eKxT9rsOTWI079BurWWZUct6Lf6Jpq6SlLH81YufPq6V98nb4eKgGmhZeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732027613; c=relaxed/simple;
	bh=XB2LCVXy1D3eTz+pMKRuMSMbzSrdv2fIMjLfvoz4oKI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e/cmTOrMElWpBEvXsMcYMhBAdjwfa1V1YpoQ+G9urU/XxOFomHkLDmgq5F/MVVlTPGQ8Z+FnkSMw/Vy1Oqsz6dF2/DMnLHKOnU08GP1CW+fRveLOcgy0PRj0zayjSu5HmFwpCBFq1TgdmUX9HbaJq9Fp9B6uQeACE3pRCRxXceY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rPSEn9hh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 886F2C4CECF;
	Tue, 19 Nov 2024 14:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732027613;
	bh=XB2LCVXy1D3eTz+pMKRuMSMbzSrdv2fIMjLfvoz4oKI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rPSEn9hhXaLzuVcR+RmDCdJlvThhLYZZGZFeX2xayYhN2JH0o0pgCfiuS8OLFr5cH
	 UTIfXL9G04IyXfJI8SU7ap2O7mKQj8viSxNUecZ5t58W+4HE9hdemLINA8zMHyWBl3
	 HXCFC3wlqCK2nrOzEfiSateNYebQHP+Ovu0Y5nDHqe/avXW9CFqJhuiEEzNI0palO6
	 7r38bX7oITtObfeemrtbrqU4jH9SfkS3tRPOilawHDW8LVuyc5YHDOzpB2uVkkUVF2
	 VszeEb98LaWcaFbi+GIFiACspOijyFSRsrEzAkG5eGyXlQLGfWZYL50zbAvNx4exBO
	 q3SB+BqB7h2MQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y 5/7] mptcp: hold pm lock when deleting entry
Date: Tue, 19 Nov 2024 09:46:51 -0500
Message-ID: <20241119083547.3234013-14-matttbe@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241119083547.3234013-14-matttbe@kernel.org>
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

The upstream commit SHA1 provided is correct: f642c5c4d528d11bd78b6c6f84f541cd3c0bea86

WARNING: Author mismatch between patch and upstream commit:
Backport author: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Commit author: Geliang Tang <tanggeliang@kylinos.cn>


Status in newer kernel trees:
6.11.y | Present (different SHA1: ff6abb7bc44a)
6.6.y | Not found
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
--- -	2024-11-19 09:14:36.773993774 -0500
+++ /tmp/tmp.Cjfj42tExY	2024-11-19 09:14:36.772429060 -0500
@@ -1,3 +1,5 @@
+commit f642c5c4d528d11bd78b6c6f84f541cd3c0bea86 upstream.
+
 When traversing userspace_pm_local_addr_list and deleting an entry from
 it in mptcp_pm_nl_remove_doit(), msk->pm.lock should be held.
 
@@ -11,15 +13,16 @@
 Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
 Link: https://patch.msgid.link/20241112-net-mptcp-misc-6-12-pm-v1-2-b835580cefa8@kernel.org
 Signed-off-by: Jakub Kicinski <kuba@kernel.org>
+Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
 ---
  net/mptcp/pm_userspace.c | 3 +++
  1 file changed, 3 insertions(+)
 
 diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
-index 3f888bfe1462e..e35178f5205fa 100644
+index 195f84f16b97..9016f8900c19 100644
 --- a/net/mptcp/pm_userspace.c
 +++ b/net/mptcp/pm_userspace.c
-@@ -308,14 +308,17 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
+@@ -326,14 +326,17 @@ int mptcp_nl_cmd_remove(struct sk_buff *skb, struct genl_info *info)
  
  	lock_sock(sk);
  
@@ -29,7 +32,7 @@
  		GENL_SET_ERR_MSG(info, "address with specified id not found");
 +		spin_unlock_bh(&msk->pm.lock);
  		release_sock(sk);
- 		goto out;
+ 		goto remove_err;
  	}
  
  	list_move(&match->list, &free_list);
@@ -37,3 +40,6 @@
  
  	mptcp_pm_remove_addrs(msk, &free_list);
  
+-- 
+2.45.2
+
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

