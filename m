Return-Path: <stable+bounces-165558-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52305B164A5
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 18:29:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5DF55450AF
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 16:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7F3A2DD608;
	Wed, 30 Jul 2025 16:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ok5tW46D"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985EF2DCF46
	for <stable@vger.kernel.org>; Wed, 30 Jul 2025 16:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753892956; cv=none; b=sifoD+IFI3X7DE3/SIc3ziPRT9nQM2pqELIeKTh6P6jLUUrDF1FPf0IxK+Pq9U4MqosQbv/A5HYjVgfX/Xcj34tTNc/ixur4Y33lrxHF3Izma+A+S2+MkQ7XTvKhQj/RJVm36E5+bQIhZAMDD4V0ecv1IbCfL7xCPLQgic3l7vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753892956; c=relaxed/simple;
	bh=7BpNT7bLn5qu/7dirge1YTpKd+KL4oi42vFZYlAzxMU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O0Hcq51lkLif6V/XLFIrXqMCDqkg+3KWAWJBeH2xhxs6Z79zCH+Ik76ARf2w2TBM+AKfgpeeEUXbPiDgPcEfBWz2tv+O6ov141hlfGKGeGnnabJn0nUhDFUrlF7AXDE7GKEgK1+7FjEqcFGQhnct1q1a9rfXz+txklZReodWS4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ok5tW46D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0928C4CEE3;
	Wed, 30 Jul 2025 16:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753892956;
	bh=7BpNT7bLn5qu/7dirge1YTpKd+KL4oi42vFZYlAzxMU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ok5tW46DLJpf01BmEidZBJwf4yHxc+/cUCyCXPGiyTdzkWR5IWV25UelGo5tyzgKP
	 gQejuCTPDs/SBmVyVrdLQ2bIot1M8QMDzc7B+NzavDsEXd++8rcv8gUb33HgtelrFT
	 RsRZvvt5oRiRe58KTf803pSRb0AGGBat79RdPTTrObRtYXu9Oc/mykcPyVJSyVG4/g
	 3QeoLD5k7essqVuVi89aqQPsAmQ9iZqhdU3mFCIRTrJzO58/qs13J7riRWWB3dmivg
	 xLzYVv/S8IOkJ5iUhKEOmEFlEaePlFULQRbHN9yKhWS3hpTTVOVESPF/IMf0c/A7nR
	 cANUEMwu+8CjQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10.y 2/4] mm: update memfd seal write check to include F_SEAL_WRITE
Date: Wed, 30 Jul 2025 12:29:13 -0400
Message-Id: <1753871049-7060e4b2@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250730015406.32569-3-isaacmanjarres@google.com>
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

The upstream commit SHA1 provided is correct: 28464bbb2ddc199433383994bcb9600c8034afa1

WARNING: Author mismatch between patch and upstream commit:
Backport author: Isaac J. Manjarres <isaacmanjarres@google.com>
Commit author: Lorenzo Stoakes <lstoakes@gmail.com>

Status in newer kernel trees:
6.15.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Not found
6.1.y | Not found
5.15.y | Not found

Note: The patch differs from the upstream commit:
---
1:  28464bbb2ddc ! 1:  157a2af225b0 mm: update memfd seal write check to include F_SEAL_WRITE
    @@ Metadata
      ## Commit message ##
         mm: update memfd seal write check to include F_SEAL_WRITE
     
    +    [ Upstream commit 28464bbb2ddc199433383994bcb9600c8034afa1 ]
    +
         The seal_check_future_write() function is called by shmem_mmap() or
         hugetlbfs_file_mmap() to disallow any future writable mappings of an memfd
         sealed this way.
    @@ Commit message
         Cc: Mike Kravetz <mike.kravetz@oracle.com>
         Cc: Muchun Song <muchun.song@linux.dev>
         Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
    +    Cc: stable@vger.kernel.org
    +    Signed-off-by: Isaac J. Manjarres <isaacmanjarres@google.com>
     
      ## fs/hugetlbfs/inode.c ##
     @@ fs/hugetlbfs/inode.c: static int hugetlbfs_file_mmap(struct file *file, struct vm_area_struct *vma)
    - 	vm_flags_set(vma, VM_HUGETLB | VM_DONTEXPAND);
    + 	vma->vm_flags |= VM_HUGETLB | VM_DONTEXPAND;
      	vma->vm_ops = &hugetlb_vm_ops;
      
     -	ret = seal_check_future_write(info->seals, vma);
    @@ fs/hugetlbfs/inode.c: static int hugetlbfs_file_mmap(struct file *file, struct v
      
     
      ## include/linux/mm.h ##
    -@@ include/linux/mm.h: static inline void mem_dump_obj(void *object) {}
    - #endif
    +@@ include/linux/mm.h: unsigned long wp_shared_mapping_range(struct address_space *mapping,
    + extern int sysctl_nr_trim_pages;
      
      /**
     - * seal_check_future_write - Check for F_SEAL_FUTURE_WRITE flag and handle it
    @@ include/linux/mm.h: static inline void mem_dump_obj(void *object) {}
     
      ## mm/shmem.c ##
     @@ mm/shmem.c: static int shmem_mmap(struct file *file, struct vm_area_struct *vma)
    - 	struct shmem_inode_info *info = SHMEM_I(inode);
    + 	struct shmem_inode_info *info = SHMEM_I(file_inode(file));
      	int ret;
      
     -	ret = seal_check_future_write(info->seals, vma);

---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| 5.10                      | Success     | Success    |

