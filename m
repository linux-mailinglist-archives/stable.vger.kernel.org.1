Return-Path: <stable+bounces-93904-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A16F09D1F58
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 05:36:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61B3F283171
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 04:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F324414D6ED;
	Tue, 19 Nov 2024 04:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZcSacLMa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD1D14AD2E
	for <stable@vger.kernel.org>; Tue, 19 Nov 2024 04:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731990989; cv=none; b=EaIUOsEWfWoYrmnU4uKcyDiOj0xapex6eKASAZ7Zs9oxLw6ZzGvDDRDvNLRY9WmTy2c4VdYsF3cjOpCaBK4vW+7nOTelx5F6KNrxLBDYPZxcQRo3neOkqREkxVon4bMAfORKOYVXmplNtiFBlg2mb8kGKXTf15M7ngw5ibh9cMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731990989; c=relaxed/simple;
	bh=YLbOAvQCyOryQxeEp91l4z6TMz9A/22L2P9H5skRI7s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rrZBMSlUAKmDhgT5Yiop3Lh6XM5c9nyoucssk/2dONhKkM1Qv0BzfJcozxSdUyWXsaVKF0gUn8RcfrPI0WIONu7HDzadQZDift3M/CM5gpoKCAElyxpzBeXhFmI/J7eBsYIkeJNBY9VPU/9kAwkmmih/CxIbxxui58eiaVQ2mys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZcSacLMa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06147C4CECF;
	Tue, 19 Nov 2024 04:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731990989;
	bh=YLbOAvQCyOryQxeEp91l4z6TMz9A/22L2P9H5skRI7s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZcSacLMaXhhTiPgdGqr0r9U0ZAfwTVnYdZ//0GAVJYAcpA6K+t/kbJkS0pFY3ejBq
	 o+2x6Fp1Anght0WQu8/SVFBNlXwxxV7M/ZtdFJTn0m4PwkyTc+Wqb5HiYywjbMb3Ht
	 BS3pA96f523QND5iXjtqWj/CUvEr8R5Si5iv0FG3ix+HZ1oEE0/a9I0iF/QMUczUax
	 DDILAwPG8ks8W/eb8Y5mAhIiSVOwUStgIVfKBafgk86b0upjmpSTH+9V9k8NXly6/8
	 ySXu3jH2OrLVtY/effSZNkYZ7GEf5UZMHF/7Mk9IgYtRy+szqpYEMS2p2qqRO6PU0Z
	 OGf4YaVWL1rHw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hugh Dickins <hughd@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: FAILED: patch "[PATCH] mm: revert "mm: shmem: fix data-race in shmem_getattr()"" failed to apply to 5.10-stable tree
Date: Mon, 18 Nov 2024 23:36:27 -0500
Message-ID: <a83ff8e9-6431-d237-94ec-5059c166a84f@google.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <a83ff8e9-6431-d237-94ec-5059c166a84f@google.com>
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

The upstream commit SHA1 provided is correct: d1aa0c04294e29883d65eac6c2f72fe95cc7c049

WARNING: Author mismatch between patch and upstream commit:
Backport author: Hugh Dickins <hughd@google.com>
Commit author: Andrew Morton <akpm@linux-foundation.org>

Commit in newer trees:

|-----------------|----------------------------------------------|
| 6.11.y          |  Present (different SHA1: 285505dc512d)      |
| 6.6.y           |  Present (different SHA1: 552c02da3b0f)      |
| 6.1.y           |  Not found                                   |
| 5.15.y          |  Not found                                   |
| 5.10.y          |  Not found                                   |
|-----------------|----------------------------------------------|

Note: The patch differs from the upstream commit:
---
--- -	2024-11-18 22:55:31.238709435 -0500
+++ /tmp/tmp.VNf4ys5kLv	2024-11-18 22:55:31.230277300 -0500
@@ -1,3 +1,12 @@
+For 5.10 and 5.4 and 4.19 please use this replacement patch:
+
+>From 98dfa72dd24347bfcbb9a60ac65ad42130ff44f5 Mon Sep 17 00:00:00 2001
+From: Andrew Morton <akpm@linux-foundation.org>
+Date: Fri, 15 Nov 2024 16:57:24 -0800
+Subject: [PATCH] mm: revert "mm: shmem: fix data-race in shmem_getattr()"
+
+commit d1aa0c04294e29883d65eac6c2f72fe95cc7c049 upstream.
+
 Revert d949d1d14fa2 ("mm: shmem: fix data-race in shmem_getattr()") as
 suggested by Chuck [1].  It is causing deadlocks when accessing tmpfs over
 NFS.
@@ -13,21 +22,25 @@
 Cc: Yu Zhao <yuzhao@google.com>
 Cc: <stable@vger.kernel.org>
 Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
+Signed-off-by: Hugh Dickins <hughd@google.com>
 ---
  mm/shmem.c | 2 --
  1 file changed, 2 deletions(-)
 
 diff --git a/mm/shmem.c b/mm/shmem.c
-index e87f5d6799a7b..568bb290bdce3 100644
+index 8239a0beb01c..e173d83b4448 100644
 --- a/mm/shmem.c
 +++ b/mm/shmem.c
-@@ -1166,9 +1166,7 @@ static int shmem_getattr(struct mnt_idmap *idmap,
- 	stat->attributes_mask |= (STATX_ATTR_APPEND |
- 			STATX_ATTR_IMMUTABLE |
- 			STATX_ATTR_NODUMP);
+@@ -1077,9 +1077,7 @@ static int shmem_getattr(const struct path *path, struct kstat *stat,
+ 		shmem_recalc_inode(inode);
+ 		spin_unlock_irq(&info->lock);
+ 	}
 -	inode_lock_shared(inode);
- 	generic_fillattr(idmap, request_mask, inode, stat);
+ 	generic_fillattr(inode, stat);
 -	inode_unlock_shared(inode);
  
- 	if (shmem_huge_global_enabled(inode, 0, 0, false, NULL, 0))
+ 	if (is_huge_enabled(sb_info))
  		stat->blksize = HPAGE_PMD_SIZE;
+-- 
+2.47.0.338.g60cca15819-goog
+
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.10.y       |  Success    |  Success   |

