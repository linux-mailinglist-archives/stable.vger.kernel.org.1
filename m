Return-Path: <stable+bounces-139373-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37FCFAA6388
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 21:10:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2C879C3538
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 19:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBB88224AEF;
	Thu,  1 May 2025 19:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QxOJRipx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9962224AE1
	for <stable@vger.kernel.org>; Thu,  1 May 2025 19:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746126617; cv=none; b=jzir0Mrqh6YiClKpaqkWg9CYAJdC7NKCkcqKP/RseNBjSFE9BqCrGVqwF7imR2GaGCkCc6s/hIuKiVmxFW5oW2qy5RiGo52GetpidkHmGFONj7yqZa+z7AYXVpn3HBsyYUzZEoGEWiO/AmcC86wey8IFr2tSfDxbCrYUe/OqjNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746126617; c=relaxed/simple;
	bh=QbgBBW8xs8NlGhm0HDvduD9Rah4LofU12RY6OvmLa20=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MCrq06eHfl3UUgHM2FNVraezXWMfM0X8lgTEwrWwnDzPkkPhr0nyPb42t9v1vw4UA71U1JyxfSkJHO+py2ShEdCIPX1UIHc72jjugyJYB13haDoE9edK372oh6RYp9ubdUTFphc6k99r4Nf9EhO6Kqxr0AIgmU8u2KmE4qoD6kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QxOJRipx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 767FCC4CEE3;
	Thu,  1 May 2025 19:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746126615;
	bh=QbgBBW8xs8NlGhm0HDvduD9Rah4LofU12RY6OvmLa20=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QxOJRipxRAE9vCJmbmiJjpcfcKp2tAPd/Nh2AJU7AJLS6eSTuUKDkR0qHOpmUIGbm
	 DqGLGlCyJqi/EskQe+ywR50N/wa8+H64K3m6k9ygQqJ4BP+MoMl2clDr64UCByNXWL
	 cOuHKWZFNVnauOBvnwfll3dP7Rw13n5BlGtQ3xpmI7YTBEofEYrpmmrx1zuUot/2sc
	 J8i4I+nqOzvf+2pHA4gCAPgWdNQjzd9MZjuGdTM4eyB+Q0iU6SnK1TbXA8uOtuQUXn
	 l1O/sURuK5edl8au1laza5u/dr5M0BeigV0ZyT+QIBusL4hLPLcgvmwH3+EHvmj4qf
	 P54+hbfD/yIQg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Leah Rumancik <leah.rumancik@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1 04/16] xfs: require XFS_SB_FEAT_INCOMPAT_LOG_XATTRS for attr log intent item recovery
Date: Thu,  1 May 2025 15:10:10 -0400
Message-Id: <20250501123331-9a2548c3c6e78fe6@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250430212704.2905795-5-leah.rumancik@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

✅ All tests passed successfully. No issues detected.
No action required from the submitter.

The upstream commit SHA1 provided is correct: 8ef1d96a985e4dc07ffbd71bd7fc5604a80cc644

WARNING: Author mismatch between patch and upstream commit:
Backport author: Leah Rumancik<leah.rumancik@gmail.com>
Commit author: Darrick J. Wong<djwong@kernel.org>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: c13c21f77824)

Note: The patch differs from the upstream commit:
---
1:  8ef1d96a985e4 ! 1:  e96849ae4ddac xfs: require XFS_SB_FEAT_INCOMPAT_LOG_XATTRS for attr log intent item recovery
    @@ Metadata
      ## Commit message ##
         xfs: require XFS_SB_FEAT_INCOMPAT_LOG_XATTRS for attr log intent item recovery
     
    +    [ Upstream commit 8ef1d96a985e4dc07ffbd71bd7fc5604a80cc644 ]
    +
         The XFS_SB_FEAT_INCOMPAT_LOG_XATTRS feature bit protects a filesystem
         from old kernels that do not know how to recover extended attribute log
         intent items.  Make this check mandatory instead of a debugging assert.
    @@ Commit message
         Fixes: fd920008784ea ("xfs: Set up infrastructure for log attribute replay")
         Signed-off-by: Darrick J. Wong <djwong@kernel.org>
         Reviewed-by: Christoph Hellwig <hch@lst.de>
    +    Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
    +    Acked-by: "Darrick J. Wong" <djwong@kernel.org>
     
      ## fs/xfs/xfs_attr_item.c ##
     @@ fs/xfs/xfs_attr_item.c: xfs_attri_validate(
    @@ fs/xfs/xfs_attr_item.c: xfs_attri_validate(
      	if (attrp->__pad != 0)
      		return false;
      
    -@@ fs/xfs/xfs_attr_item.c: xfs_attri_recover_work(
    +@@ fs/xfs/xfs_attr_item.c: xfs_attri_item_recover(
    + 	args->op_flags = XFS_DA_OP_RECOVERY | XFS_DA_OP_OKNOENT |
      			 XFS_DA_OP_LOGGED;
    - 	args->owner = args->dp->i_ino;
      
     -	ASSERT(xfs_sb_version_haslogxattrs(&mp->m_sb));
     -
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

