Return-Path: <stable+bounces-165569-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A0AB164B3
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 18:30:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04C3B18C6CD5
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 16:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 224741925BC;
	Wed, 30 Jul 2025 16:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JFFOJWRJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83C82DCF63
	for <stable@vger.kernel.org>; Wed, 30 Jul 2025 16:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753892985; cv=none; b=oOUKgKaCnSF2clObT2XTUFGY5KUE4dZM0rm88EEZogaxKY9EBBW7JLZkSh/K74fqYxrJjAEFIVeIc7mR1ZQQL7YXraaL4cTHki58P7Tl3qx/q4XCk1V8bEgpANChEWy0SazjdnY/3VrSzPgckUEfk0CvQ7qZ+S1+2mIyzOUXaJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753892985; c=relaxed/simple;
	bh=PdqudtWz2L/mOFeEN4N0dxuDPpXBUYaapB3o2+dlG5c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pTBW5ow2gGNEWm13LmOmMDB+oVVC/P4bzBs8WuBPZKrgonKJEHMA8pYTKvFIkmMEfotTN3gQJgzo7ac1uWpVPr2CdDJAxuBbETPxiR4C5dWn/lOui/+R5ivtyBS/FaOaW/o071Csr0+L/Km3kzoFdg2TULXKa9vepLtyN2v/e3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JFFOJWRJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A98CC4CEE3;
	Wed, 30 Jul 2025 16:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753892985;
	bh=PdqudtWz2L/mOFeEN4N0dxuDPpXBUYaapB3o2+dlG5c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JFFOJWRJUKlQlR/RlynRBrDwiTSt7hqbLne1dDMduiUBwQLB8gOqNbae/WBDMHxLM
	 m0Tmn65pvv6Hby59OZzBvvZThAy9aq78Zejkh3e8e9EdpvbXELOifL9s+1vI2ghr1Z
	 uMUjSdGkw+ZKcXiSiKLzVVoxbVowp3IGPoK66cEU/JarD2PlewPBMZ6KCxo8m4VVfM
	 MzX/uWQoaK1uLQWmi+BSI/2VuW9m3vEXX+dj7XWChDCI+8NS9NV8l21T+w3UKsVvUC
	 p02gsrm34xSIfdCZ9Z0q8qioGLEUA5nC4slsEIBfPE+ev7TkZFvXMwnP+mLi6Y+ffE
	 0vL2yGO+wcAuA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y 2/4] mm: update memfd seal write check to include F_SEAL_WRITE
Date: Wed, 30 Jul 2025 12:29:43 -0400
Message-Id: <1753857171-a79223c8@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250730015337.31730-3-isaacmanjarres@google.com>
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

Note: The patch differs from the upstream commit:
---
1:  28464bbb2ddc ! 1:  f90a6b98cbec mm: update memfd seal write check to include F_SEAL_WRITE
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
| 5.15                      | Success     | Success    |

