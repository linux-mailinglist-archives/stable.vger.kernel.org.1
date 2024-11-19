Return-Path: <stable+bounces-93903-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4210D9D1F57
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 05:36:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07EA82815EA
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 04:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 423FF14B080;
	Tue, 19 Nov 2024 04:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ssxu7Ci9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE12814AD2E
	for <stable@vger.kernel.org>; Tue, 19 Nov 2024 04:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731990988; cv=none; b=P9JnDdlUv3Scx3csVcXi1BD6HQWFL53FYagf91r8epe1nnheZggqpgjSGoCa3dZBO0N03AfXY7trDcgITO/5VJr5wO1q/GbC73Duu05j/it4jz9i8+17E7XLM5HhabSmLXgyngtl5/OhhC/ZPpXKFWPa8dlfEJM/W1hMG2y3IXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731990988; c=relaxed/simple;
	bh=ttjs9+YrkYgvP9BEjuF1l1j/O/dY8A/KLNyHaALpUic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U4mJrBgJdQ2tMMjrtzorUmdEfNLypsTRtICVZHMy08CGT0fHW/1zqM53/xry5WTDWz7Mhl5Dn3ZwcTFpU2LFy5cL9YerOZF1+rdIwUmL28vCXwWqvCOUCtwlGFrvU8V5mitLpcljgkwLDoW2VmqRvwb82MDrClYGnTB769GmKiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ssxu7Ci9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11A3FC4CECF;
	Tue, 19 Nov 2024 04:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731990987;
	bh=ttjs9+YrkYgvP9BEjuF1l1j/O/dY8A/KLNyHaALpUic=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ssxu7Ci9fl22ubkFATT9yOdG7giOFZri06NHJBlqkYnD0CWdl8DxouXAxParVBJYQ
	 g7P3MiKZ4yvAsP5rIuB2cRKACM/k5Yr6OTnhYzhrAhAVo/7lC7XTGFGysueP6mdR7e
	 //PLUaqhD+i51HHFQ9R00cY2+Guy/FqVzfXhgFXWcHR5YfYHDGsoJGREb+WQa6nAy7
	 h6OHFD+sn1g69ERGuYRn4on/QegeTqWKngzI2dss1qrYxZEthSQ7qZb+3tNXG/z3UU
	 yF10DVQSUUXnmcSyV5/QedM2Bfm0fNUXTd5td767nuaWPdYaYzh5wmooB1Lr5Qaxqt
	 eKwzDo22ajhvg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hugh Dickins <hughd@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: FAILED: patch "[PATCH] mm: revert "mm: shmem: fix data-race in shmem_getattr()"" failed to apply to 5.15-stable tree
Date: Mon, 18 Nov 2024 23:36:25 -0500
Message-ID: <c27966fa-007b-97dd-c39c-10412539e9d3@google.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <c27966fa-007b-97dd-c39c-10412539e9d3@google.com>
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
|-----------------|----------------------------------------------|

Note: The patch differs from the upstream commit:
---
--- -	2024-11-18 22:45:37.221809852 -0500
+++ /tmp/tmp.gWYpEchJE1	2024-11-18 22:45:37.214517918 -0500
@@ -1,3 +1,12 @@
+For 5.15 please use this replacement patch:
+
+>From 975b740a6d720fdf478e9238b65fa96e9b5d631a Mon Sep 17 00:00:00 2001
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
+index cdb169348ba9..663fb117cd87 100644
 --- a/mm/shmem.c
 +++ b/mm/shmem.c
-@@ -1166,9 +1166,7 @@ static int shmem_getattr(struct mnt_idmap *idmap,
- 	stat->attributes_mask |= (STATX_ATTR_APPEND |
- 			STATX_ATTR_IMMUTABLE |
- 			STATX_ATTR_NODUMP);
+@@ -1077,9 +1077,7 @@ static int shmem_getattr(struct user_namespace *mnt_userns,
+ 		shmem_recalc_inode(inode);
+ 		spin_unlock_irq(&info->lock);
+ 	}
 -	inode_lock_shared(inode);
- 	generic_fillattr(idmap, request_mask, inode, stat);
+ 	generic_fillattr(&init_user_ns, inode, stat);
 -	inode_unlock_shared(inode);
  
- 	if (shmem_huge_global_enabled(inode, 0, 0, false, NULL, 0))
+ 	if (shmem_is_huge(NULL, inode, 0))
  		stat->blksize = HPAGE_PMD_SIZE;
+-- 
+2.47.0.338.g60cca15819-goog
+
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Failed    |

Build Errors:
Build error for stable/linux-5.15.y:
    

