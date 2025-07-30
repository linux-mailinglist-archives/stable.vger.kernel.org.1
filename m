Return-Path: <stable+bounces-165550-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E785B1649C
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 18:29:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0DA8542202
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 16:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF0942DC329;
	Wed, 30 Jul 2025 16:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CEHdqbRw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07311DFD96
	for <stable@vger.kernel.org>; Wed, 30 Jul 2025 16:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753892935; cv=none; b=tD9f7Q8EZVSu/p2QRkl6ekawRRGAPtcYKty84CD7mQ6v1xom0tcUKi6sqFExh8CLxUBWYo3kGp2LJEuZ2oxPguUCyb1yjgyLgkkddUNQSZajie5Z6t/scaA09YIzFGfnflRJ4rldsje5+UCAqMzeKgHA07rJ+q5E99gprsvXyEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753892935; c=relaxed/simple;
	bh=PtKwilgTD1zbf/XAZygaQ7rYc4s7N2+2nQM1d5X8Jok=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qRX55tAfxmRki3zrQgj8lsbXQJiUKboK+IHgZEGgpqMVqkY0d/UxnlDqIau1/9mPgP7SNO8UUCAo8tEpO/kbL+VEP6Ks3W5nAVO/KsMzrVGoH3VQvPGzyKgIa2pLfuYKyIbgw2eIXj4D4SpmidalBGHYk2xYQmgoMYcSCZSi+Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CEHdqbRw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 917C6C4CEE7;
	Wed, 30 Jul 2025 16:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753892934;
	bh=PtKwilgTD1zbf/XAZygaQ7rYc4s7N2+2nQM1d5X8Jok=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CEHdqbRw8gI1idMvanP9Vh2Yz+byjh6dUnyZUxgIanZhRexHibE41XZFN+FpWn+gb
	 Ku7b/mr20YSkKd9AhYsjQ1RRvJzpFAgSRECOh8H6dypQuWR+4NrvDuEt3kijLkuN8U
	 Nq/C4G9iYBCx/HW4KxQA8G8bMknDvn4dn1SKgXMc9Hv478Kyzk9StYBLXBV24IiMT6
	 A3UTscohiGFr5k9qxtOOxMsG+d+PRmkwgvt5mzpa4unrCDu8inwWesjZVHaPhQbxIX
	 7NLj38yPjIF5UVkW6YNZSw+ji/gjOIvvYBrrz1dfX51FXMmf/i6i4NdHWapX0XZgra
	 r1cR+PNdr2Zuw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y 1/4] mm: drop the assumption that VM_SHARED always implies writable
Date: Wed, 30 Jul 2025 12:28:51 -0400
Message-Id: <1753857086-c71206ad@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250730015337.31730-2-isaacmanjarres@google.com>
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

Note: The patch differs from the upstream commit:
---
1:  e8e17ee90eaf ! 1:  9f7ea48b09ac mm: drop the assumption that VM_SHARED always implies writable
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
    +@@ include/linux/fs.h: int pagecache_write_end(struct file *, struct address_space *mapping,
       *   It is also used to block modification of page cache contents through
       *   memory mappings.
       * @gfp_mask: Memory allocation flags to use for allocating pages.
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
    @@ mm/mmap.c: void vma_set_page_prot(struct vm_area_struct *vma)
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
    - 
    +@@ mm/mmap.c: static void __vma_link_file(struct vm_area_struct *vma)
      	if (file) {
    --		if (vm_flags & VM_SHARED) {
    -+		if (is_shared_maywrite(vm_flags)) {
    - 			error = mapping_map_writable(file->f_mapping);
    - 			if (error)
    - 				goto free_vma;
    -@@ mm/mmap.c: unsigned long mmap_region(struct file *file, unsigned long addr,
    - 	mm->map_count++;
    - 	if (vma->vm_file) {
    - 		i_mmap_lock_write(vma->vm_file->f_mapping);
    + 		struct address_space *mapping = file->f_mapping;
    + 
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
| 5.15                      | Success     | Success    |

