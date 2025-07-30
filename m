Return-Path: <stable+bounces-165564-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78A97B164AA
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 18:29:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B98D4E3C76
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 16:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D1A02DCC1F;
	Wed, 30 Jul 2025 16:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gGpq1h1G"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE292280327
	for <stable@vger.kernel.org>; Wed, 30 Jul 2025 16:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753892972; cv=none; b=C9DxUD4IGf5AdkGW2oaHdylI1/ebeLUgq2ilGQVrDroX3T4TfJ7Uk5M/AIJV8MvNnmKvlhECRKLh6ZOakRax8KufCQYXtGVExxWVGA6S7LJKFpYTv7/ShGhJO1BPv92W/fvMg17ZxowJAM6T5a27uLfOQMVzRCmFK+CZ+SBB8aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753892972; c=relaxed/simple;
	bh=eS/GpYcPok2ucI4fRpE/qVIjBTA/pxINiZ9M6+SM+YY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C5hW8kav37bZ373xxmwm8dl+dDbJwSt/3PGvGHtexNqDjz6xB30iYuj2+hA7mjYNwNacM2IBfyq102Y+X/Uf6SdfWrToCISb5nM7AI/wt+Zg+WM8pVI8u3UO36QntXgTUxyXiYFguJwKn8/5h/2gwTTGIkP0ACs7fFdePAt9Tcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gGpq1h1G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D504CC4CEE3;
	Wed, 30 Jul 2025 16:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753892972;
	bh=eS/GpYcPok2ucI4fRpE/qVIjBTA/pxINiZ9M6+SM+YY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gGpq1h1GdHoa7kArF3KjSo4Dt9ARI8b05Gu2nmPv44PZWpSwJTX1PXBcWtJ4Fxbk7
	 GwSXHVGNJ0jIxlnfkk8nDW4PCC7oWYjMYHfW/lkZcA6E7vfI5nQEaThljEf36HSrm1
	 e33U31DUgSquIdCve0rx7+TS3nlqzNQFSEUq8Fr09vKG0iFS1iBvDxkfQQyH8dmITl
	 Fpc5umvhE1P9rJSqd2T0W3bI0Uq2fJxUuuxtEytNzXgJ0D3SHdQaUbz5n6lPIJU/4H
	 HV4l15IM0UieQ+yqBaquVUcj1XBY0eBlsy7C5HNOoaFCo/J73h/2g/Ey8DPVy7jgYs
	 Jr9Qw+k6A3ftw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y 2/4] mm: update memfd seal write check to include F_SEAL_WRITE
Date: Wed, 30 Jul 2025 12:29:30 -0400
Message-Id: <1753861932-5e72d94e@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250730015247.30827-3-isaacmanjarres@google.com>
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

Note: The patch differs from the upstream commit:
---
1:  28464bbb2ddc ! 1:  1872f21ed57a mm: update memfd seal write check to include F_SEAL_WRITE
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
| 6.1                       | Success     | Success    |

