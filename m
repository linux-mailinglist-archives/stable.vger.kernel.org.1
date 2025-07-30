Return-Path: <stable+bounces-165553-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12476B1649F
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 18:29:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71AD118C44BC
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 16:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D73E32DC357;
	Wed, 30 Jul 2025 16:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XjvESeut"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F921DFD96
	for <stable@vger.kernel.org>; Wed, 30 Jul 2025 16:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753892942; cv=none; b=UklkQnxPPC67dsJQXcR/cgNEow9Mneib7/Il8WOIjXhzBSerTOCjJ3tWbYuCtaOuPT919xakb/k+vr3yck0dIyHnHmawJoc9X8G/brkB7wjH62ZEsr3kfBl5F7kw8+RfkQSE/fCmb7NCHxwPBW2ZFn2iXv//EIXoA/vc8DQP7is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753892942; c=relaxed/simple;
	bh=22kwapCngC5lJ60ngjA9N3y/PFg76oZ8AxNXgPsRJ2M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j8nqo0HU+cCF0W4LM4xrHfV6CfE4iOB81jXwb218FNYNyuMTEGzb6CUC3N0FLvY2j1WXrh9DY9duQNJR5yqgqFLCc7uv4sTzRjMurpZh23lYP1McUKPlRrmcIj9Kj0Al0B3dixrCf4JDob8zRqxWhGALNO0nTZj/0woqZFSzIK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XjvESeut; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC43FC4CEE3;
	Wed, 30 Jul 2025 16:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753892942;
	bh=22kwapCngC5lJ60ngjA9N3y/PFg76oZ8AxNXgPsRJ2M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XjvESeutAvY4lhPJX5JIiL0Ch2kQmQNOL3MGAMAzdsTifUc4OM/y9EtxThTzFMa5P
	 Xhpc1MptXCsXfkIYzh/YkwKpRjeevQ00FmK7/isi4hd6rt0AHkiE2BR9aEzamg709t
	 L6qyjWke0WQwTaR0GZk0I/G7vDymt4GIbO+PJyx6OOR6ZR+ku8CTUlYMj9qlqi8zlh
	 MeyFiHSTTMfCS14LbkCrCqfXwdzhIX/3H4+rF2W4MSXBTZbvs15lJuwA+UrhEGJkdU
	 iTM6kKqWpl+lfYXQOyqSooiBzZAaMs/8WTClFY9lTnNwygLffXWvQxel2NRKoN0YJT
	 kIVabmO7s6+6A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y 1/4] mm: drop the assumption that VM_SHARED always implies writable
Date: Wed, 30 Jul 2025 12:29:00 -0400
Message-Id: <1753861864-f75dfd42@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250730015247.30827-2-isaacmanjarres@google.com>
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

Note: The patch differs from the upstream commit:
---
1:  e8e17ee90eaf ! 1:  3654bc416e94 mm: drop the assumption that VM_SHARED always implies writable
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
     @@ include/linux/fs.h: extern const struct address_space_operations empty_aops;
    @@ mm/mmap.c: static unsigned long count_vma_pages_range(struct mm_struct *mm,
      		mapping_allow_writable(mapping);
      
      	flush_dcache_mmap_lock(mapping);
    -@@ mm/mmap.c: unsigned long mmap_region(struct file *file, unsigned long addr,
    - 	vma->vm_pgoff = pgoff;
    - 
    - 	if (file) {
    --		if (vm_flags & VM_SHARED) {
    -+		if (is_shared_maywrite(vm_flags)) {
    - 			error = mapping_map_writable(file->f_mapping);
    - 			if (error)
    - 				goto free_vma;
    -@@ mm/mmap.c: unsigned long mmap_region(struct file *file, unsigned long addr,
    +@@ mm/mmap.c: static unsigned long __mmap_region(struct file *file, unsigned long addr,
    + 	vma_mas_store(vma, &mas);
      	mm->map_count++;
      	if (vma->vm_file) {
    - 		i_mmap_lock_write(vma->vm_file->f_mapping);
     -		if (vma->vm_flags & VM_SHARED)
     +		if (vma_is_shared_maywrite(vma))
      			mapping_allow_writable(vma->vm_file->f_mapping);
      
      		flush_dcache_mmap_lock(vma->vm_file->f_mapping);
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
| 6.1                       | Success     | Success    |

