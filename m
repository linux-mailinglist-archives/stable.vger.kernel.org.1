Return-Path: <stable+bounces-165180-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00E39B1579E
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 04:43:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61DEF18A3E1B
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 02:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53D4A1BD9D0;
	Wed, 30 Jul 2025 02:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kLN88Z3j"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137F415A8
	for <stable@vger.kernel.org>; Wed, 30 Jul 2025 02:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753843402; cv=none; b=Z4l30Vy6YFJf0SgdVGYtaYDdXADtbV6ciXyjx6d6dwNoHbyr3LuhO1My9817k3fHD0kMjQlKpRkVYwGLcQWcT8sPPG8fyQnqcb6RUAZPLB6lIDFqTXm6zdrvoaQNIrczORI/Qu2IvAsobxdivdbHpZUdVHFtHYs7wBSZ1UfYr58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753843402; c=relaxed/simple;
	bh=LLJzeb2JmZxg6UgxkbXT2idBrDeShyCirppJjZPexHc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gDz2OymXjvTPb736Upja6gojoK6NWE6xP7GdnGhwtQDODKoM+RunDalhOyF36iYZjsP72WH81Z559ejjzKgJKumNhoGmOHAcuFo8E5/Ip3ejdnQKwNh92mVBpNgJ3EzbgtI2SR3A/IkVLUSxOohw3BXingyI8hj4F3zvU5VepDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kLN88Z3j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AEC3C4CEEF;
	Wed, 30 Jul 2025 02:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753843401;
	bh=LLJzeb2JmZxg6UgxkbXT2idBrDeShyCirppJjZPexHc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kLN88Z3jteVh5mVAVtxNs1lphYQCSZIKZZ5DxS14TGYWlz9TDKV/gIKqy5gD5X7Dj
	 QlxMIphppJIoD3w4afxsw8/GTKMRwyoiPt0IEwttQUTCDPYx0w9beL2YqRrBIfeEFf
	 +Te2cAapor5frNgf2zpKlDL6pbmxM16IcOmpNLpz1SA1kNlntFxdaZjm/2VHF+Yt8g
	 DpRsQeFw1iXRlDlqOUbEFCbZ+aGTaiD/ToUJ2neVCepO5SXAAXDauQ40iZDax1oho9
	 5TzxbwSNrTEqlOipiXSjenP1h3vvvcUrnBQegaB/I6mLyRDmoQwIShJA39lJqECPoY
	 Um0TTc1VE+4cw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.4.y 2/3] mm: update memfd seal write check to include F_SEAL_WRITE
Date: Tue, 29 Jul 2025 22:43:19 -0400
Message-Id: <1753842163-a00b7eb8@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250730005818.2793577-3-isaacmanjarres@google.com>
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
5.10.y | Not found

Note: The patch differs from the upstream commit:
---
1:  28464bbb2ddc ! 1:  3f153c98f29a mm: update memfd seal write check to include F_SEAL_WRITE
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
    +@@ include/linux/mm.h: static inline int pages_identical(struct page *page1, struct page *page2)
    + }
      
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
| 5.4                       | Success     | Success    |

