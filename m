Return-Path: <stable+bounces-165563-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 540FEB164B0
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 18:29:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2FE418941C0
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 16:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E5AF2DCF74;
	Wed, 30 Jul 2025 16:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hZQVW23B"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80DB2D838B
	for <stable@vger.kernel.org>; Wed, 30 Jul 2025 16:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753892969; cv=none; b=ezty9tDUxAr8ZEJOIItfmCkPEFFJitIirLDdP4uNAoknnVEXIu3+mHH7Zph9HlDobtRvtnbRhbe69ED2wF8EH+xCfV0ZNXxgJG+1Ae2pnx9lQZV9b2/AOcRDRJz2IKIKXhB9LMqkXaOuqQYS+D5DK+EIPODj9AZwiJf6JpmzegM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753892969; c=relaxed/simple;
	bh=ocR2MBZNmpN25DatUv+iTQgsl6wMtGnzdXvLkq0g3Rc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l2XsrGaHhQiW0PQqnIDiJWa5OgBQ6TNU0q5cU5QustY5W+Ob1hZaCkvF+jsZAEA8t9MZ7yqALaQvX68NsqrU8UKxzegi/aD0CsmVIUnaTgRHY2yT4VQWZHEG6NyxtdpjVB5EWLewa/8WGAyAlsV0rco1vIJuHKlg5TXp1x1xOTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hZQVW23B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28CD9C4CEE3;
	Wed, 30 Jul 2025 16:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753892969;
	bh=ocR2MBZNmpN25DatUv+iTQgsl6wMtGnzdXvLkq0g3Rc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hZQVW23BRMK1UV5jTB1PTpf4G7FJX8mzTR6DfYI8Zrno89mw9wAMPb/aS/Ujq1uUT
	 N17+RDWqVv14TLQ2SNGVgWKvgQGUZd0cTQEtasyMcLxIiwozAtJI2wbuOqdJTIZiCX
	 8YFTOZR6UpEIk6ZNO001qLTdUHELYlwiITlxVk/8fVnQiAj/4Ic4aaZpCj1iYvT+vT
	 Bfpeh8YrI9sJuMmgeeMj0U2wyNx4PFzMaqE4kJaZgh3ECYZX6z1AwQsdd5ZXuvhX3u
	 A1kNtBNaO8yLZp6VhMqXlUlZ9ubE4dFsaLH17VvwZuhAuiZ2pOKHRb4fLL7E+nYttx
	 cfswTK4Y/dv1g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10.y 1/4] mm: drop the assumption that VM_SHARED always implies writable
Date: Wed, 30 Jul 2025 12:29:27 -0400
Message-Id: <1753870943-a9cc6a66@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250730015406.32569-2-isaacmanjarres@google.com>
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

The upstream commit SHA1 provided is correct: e8e17ee90eaf650c855adb0a3e5e965fd6692ff1

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
1:  e8e17ee90eaf ! 1:  5752dc2ce6f5 mm: drop the assumption that VM_SHARED always implies writable
    @@ Metadata
      ## Commit message ##
         mm: drop the assumption that VM_SHARED always implies writable
     
    +    [ Upstream commit e8e17ee90eaf650c855adb0a3e5e965fd6692ff1 ]
    +
         Patch series "permit write-sealed memfd read-only shared mappings", v4.
     
         The man page for fcntl() describing memfd file seals states the following
    @@ Commit message
         [1]:https://lore.kernel.org/all/20230324133646.16101dfa666f253c4715d965@linux-foundation.org/
         [2]:https://bugzilla.kernel.org/show_bug.cgi?id=217238
     
    -
         This patch (of 3):
     
         There is a general assumption that VMAs with the VM_SHARED flag set are
    @@ Commit message
         Cc: Mike Kravetz <mike.kravetz@oracle.com>
         Cc: Muchun Song <muchun.song@linux.dev>
         Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
    +    Cc: stable@vger.kernel.org
    +    [isaacmanjarres: resolved merge conflicts due to
    +    due to refactoring that happened in upstream commit
    +    5de195060b2e ("mm: resolve faulty mmap_region() error path behaviour")]
    +    Signed-off-by: Isaac J. Manjarres <isaacmanjarres@google.com>
     
      ## include/linux/fs.h ##
    -@@ include/linux/fs.h: extern const struct address_space_operations empty_aops;
    -  *   It is also used to block modification of page cache contents through
    -  *   memory mappings.
    +@@ include/linux/fs.h: int pagecache_write_end(struct file *, struct address_space *mapping,
    +  * @host: Owner, either the inode or the block_device.
    +  * @i_pages: Cached pages.
       * @gfp_mask: Memory allocation flags to use for allocating pages.
     - * @i_mmap_writable: Number of VM_SHARED mappings.
     + * @i_mmap_writable: Number of VM_SHARED, VM_MAYWRITE mappings.
    @@ include/linux/mm.h: static inline bool vma_is_accessible(struct vm_area_struct *
     +	return is_shared_maywrite(vma->vm_flags);
     +}
     +
    - static inline
    - struct vm_area_struct *vma_find(struct vma_iterator *vmi, unsigned long max)
    - {
    + #ifdef CONFIG_SHMEM
    + /*
    +  * The vma_is_shmem is not inline because it is used only by slow
     
      ## kernel/fork.c ##
     @@ kernel/fork.c: static __latent_entropy int dup_mmap(struct mm_struct *mm,
    - 
    - 			get_file(file);
    + 			if (tmp->vm_flags & VM_DENYWRITE)
    + 				put_write_access(inode);
      			i_mmap_lock_write(mapping);
     -			if (tmp->vm_flags & VM_SHARED)
     +			if (vma_is_shared_maywrite(tmp))
    @@ kernel/fork.c: static __latent_entropy int dup_mmap(struct mm_struct *mm,
      			/* insert tmp into the share list, just after mpnt */
     
      ## mm/filemap.c ##
    -@@ mm/filemap.c: int generic_file_mmap(struct file *file, struct vm_area_struct *vma)
    +@@ mm/filemap.c: int generic_file_mmap(struct file * file, struct vm_area_struct * vma)
       */
      int generic_file_readonly_mmap(struct file *file, struct vm_area_struct *vma)
      {
    @@ mm/madvise.c: static long madvise_remove(struct vm_area_struct *vma,
      	offset = (loff_t)(start - vma->vm_start)
     
      ## mm/mmap.c ##
    -@@ mm/mmap.c: void vma_set_page_prot(struct vm_area_struct *vma)
    - static void __remove_shared_vm_struct(struct vm_area_struct *vma,
    - 		struct file *file, struct address_space *mapping)
    +@@ mm/mmap.c: static void __remove_shared_vm_struct(struct vm_area_struct *vma,
      {
    + 	if (vma->vm_flags & VM_DENYWRITE)
    + 		allow_write_access(file);
     -	if (vma->vm_flags & VM_SHARED)
     +	if (vma_is_shared_maywrite(vma))
      		mapping_unmap_writable(mapping);
      
      	flush_dcache_mmap_lock(mapping);
    -@@ mm/mmap.c: static unsigned long count_vma_pages_range(struct mm_struct *mm,
    - static void __vma_link_file(struct vm_area_struct *vma,
    - 			    struct address_space *mapping)
    - {
    --	if (vma->vm_flags & VM_SHARED)
    -+	if (vma_is_shared_maywrite(vma))
    - 		mapping_allow_writable(mapping);
    - 
    - 	flush_dcache_mmap_lock(mapping);
    -@@ mm/mmap.c: unsigned long mmap_region(struct file *file, unsigned long addr,
    - 	vma->vm_pgoff = pgoff;
    +@@ mm/mmap.c: static void __vma_link_file(struct vm_area_struct *vma)
      
    - 	if (file) {
    --		if (vm_flags & VM_SHARED) {
    -+		if (is_shared_maywrite(vm_flags)) {
    - 			error = mapping_map_writable(file->f_mapping);
    - 			if (error)
    - 				goto free_vma;
    -@@ mm/mmap.c: unsigned long mmap_region(struct file *file, unsigned long addr,
    - 	mm->map_count++;
    - 	if (vma->vm_file) {
    - 		i_mmap_lock_write(vma->vm_file->f_mapping);
    + 		if (vma->vm_flags & VM_DENYWRITE)
    + 			put_write_access(file_inode(file));
     -		if (vma->vm_flags & VM_SHARED)
     +		if (vma_is_shared_maywrite(vma))
    - 			mapping_allow_writable(vma->vm_file->f_mapping);
    + 			mapping_allow_writable(mapping);
      
    - 		flush_dcache_mmap_lock(vma->vm_file->f_mapping);
    + 		flush_dcache_mmap_lock(mapping);
     @@ mm/mmap.c: unsigned long mmap_region(struct file *file, unsigned long addr,
    + 		return -EINVAL;
      
    - 	/* Once vma denies write, undo our temporary denial count */
    - unmap_writable:
    --	if (file && vm_flags & VM_SHARED)
    -+	if (file && is_shared_maywrite(vm_flags))
    - 		mapping_unmap_writable(file->f_mapping);
    - 	file = vma->vm_file;
    - 	ksm_add_vma(vma);
    -@@ mm/mmap.c: unsigned long mmap_region(struct file *file, unsigned long addr,
    - 		unmap_region(mm, &vmi.mas, vma, prev, next, vma->vm_start,
    - 			     vma->vm_end, vma->vm_end, true);
    - 	}
    --	if (file && (vm_flags & VM_SHARED))
    -+	if (file && is_shared_maywrite(vm_flags))
    - 		mapping_unmap_writable(file->f_mapping);
    - free_vma:
    - 	vm_area_free(vma);
    + 	/* Map writable and ensure this isn't a sealed memfd. */
    +-	if (file && (vm_flags & VM_SHARED)) {
    ++	if (file && is_shared_maywrite(vm_flags)) {
    + 		int error = mapping_map_writable(file->f_mapping);
    + 
    + 		if (error)

---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| 5.10                      | Success     | Success    |

