Return-Path: <stable+bounces-93959-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93B249D25D7
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 13:31:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB741B2946C
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 12:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE38B1CBEA7;
	Tue, 19 Nov 2024 12:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NeSYMYb1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0DA1CBE89
	for <stable@vger.kernel.org>; Tue, 19 Nov 2024 12:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732019445; cv=none; b=GBPeN16Yp61kklHiwzR1l5wYc1XbWzKbQQWV6DdnTNsXmrZ5WSoDUx5mvkEyUzahwj9RamueCDiXNWvstA6EAKFD4Zuu6CfP7DvI1p2NwbzEu22WvwfI87OpkrRevOjAdOn8BibTrbXTcSTIrpi0ZlfQ5K2OjBzg4QW7ngH4uM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732019445; c=relaxed/simple;
	bh=PFnn6H6zO7jl9H6DjpdruhD29p8/1H2WySIEW3WZakc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KmytAQG2Ui6pYrC14urnQk3vwzzX7sMznijrn1vdulRYnGScmK44rwE+NvfISD2wrsntSMVuRKy+oUqmhVAWE6Csgs02dOfVrXddk52zIx8j63YcJO+yqUV559vKlVRESX7Wfn3IX3/DbxSO0flAi0pHxk0Hv//w4dG8o8SSAQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NeSYMYb1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC141C4CECF;
	Tue, 19 Nov 2024 12:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732019445;
	bh=PFnn6H6zO7jl9H6DjpdruhD29p8/1H2WySIEW3WZakc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NeSYMYb1P0YYT7hSPQJhSK+lsnyiEjg3qnsaCICcH1iZqQcaRkLssSXBmXokUnZcU
	 Cl93ZApDgogqMAnE7ZIgoWlOUXRWOkIw2HT0s5Lw8RvIJAYKEsU4A5hII6CqYv83Gi
	 OgYE8vqI9kOPdoZwPS7fh3dWCaCXxF/OMPmdpwgs1EE6h9jmq6+WkrRfMImZDVfsOd
	 NBHIWO+9iilKSgEBlZ5wQvTy+KtnNpOtVa8B/4gXjOE7wPKV+mpQUkybDfr6a5lMj/
	 wK1yq79onBHPpmauLJzY89Of/g950qB5TCi6LoCNNiW04SptTA1nf/FqFbrQa/2n/8
	 m4ZfRuv5bk/hQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hugh Dickins <hughd@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: FAILED: patch "[PATCH] mm: revert "mm: shmem: fix data-race in shmem_getattr()"" failed to apply to 6.1-stable tree
Date: Tue, 19 Nov 2024 07:30:43 -0500
Message-ID: <b3c9649c-59c7-a116-9477-3787159ddd48@google.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <b3c9649c-59c7-a116-9477-3787159ddd48@google.com>
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
|-----------------|----------------------------------------------|

Note: The patch differs from the upstream commit:
---
--- -	2024-11-19 00:05:12.416053794 -0500
+++ /tmp/tmp.vwrrH0rcVj	2024-11-19 00:05:12.409155886 -0500
@@ -1,3 +1,12 @@
+For 6.1 please use this replacement patch:
+
+>From f6a8e058ad34f16109d54218c64e0c215bcc04fc Mon Sep 17 00:00:00 2001
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
+index 0e1fbc53717d..f7c08e169e42 100644
 --- a/mm/shmem.c
 +++ b/mm/shmem.c
-@@ -1166,9 +1166,7 @@ static int shmem_getattr(struct mnt_idmap *idmap,
+@@ -1086,9 +1086,7 @@ static int shmem_getattr(struct user_namespace *mnt_userns,
  	stat->attributes_mask |= (STATX_ATTR_APPEND |
  			STATX_ATTR_IMMUTABLE |
  			STATX_ATTR_NODUMP);
 -	inode_lock_shared(inode);
- 	generic_fillattr(idmap, request_mask, inode, stat);
+ 	generic_fillattr(&init_user_ns, inode, stat);
 -	inode_unlock_shared(inode);
  
- 	if (shmem_huge_global_enabled(inode, 0, 0, false, NULL, 0))
+ 	if (shmem_is_huge(NULL, inode, 0, false))
  		stat->blksize = HPAGE_PMD_SIZE;
+-- 
+2.47.0.338.g60cca15819-goog
+
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

