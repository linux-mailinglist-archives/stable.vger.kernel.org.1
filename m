Return-Path: <stable+bounces-165565-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60EDAB164AC
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 18:29:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43AF24E663A
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 16:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B58562DE6E6;
	Wed, 30 Jul 2025 16:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R9t7jWH5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75AFB1925BC
	for <stable@vger.kernel.org>; Wed, 30 Jul 2025 16:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753892975; cv=none; b=qr+d2WQFkdvtIdVH9ZQQspVaRA+aQ5cmmrE8KFJLjZxrETTXiV+PVzvt/k1d4zc5W5zKuMobMHJKlCVX5OywoWe7p1RJpUObSeQtafu+ys/8GP4rI5OdaDWh/bCQTAZUJThzpHJPO6OsRnft5P+eQS7kLyvu48F/GulK2aY5tbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753892975; c=relaxed/simple;
	bh=ICuZg6KVsxYjHIK95LkCYeM3JF844T/PIyptOD954+Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ieqG2KAGWWUpl7bUBhThU43IyXeG1dcP8bh/iFB+GbV3oKJs/ag3xHWUlFAY3mJEWlCk7vbCnjjc58RpQUvXtEgdU9QO6ui1POD62KmxIpIESwCk+4IUqR6DOokw8q/lxwa6JRwlWkkShIGrUMVgg62/fUhU9EzZ31rkJbhW+XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R9t7jWH5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82C9AC4CEE7;
	Wed, 30 Jul 2025 16:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753892975;
	bh=ICuZg6KVsxYjHIK95LkCYeM3JF844T/PIyptOD954+Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R9t7jWH5qvNc9OlXx5/O5LeZHsJg0l2UhpdMLXa9SIxLOXtDyx+Hhxj0YDFUwTu3U
	 1QUMKmEMr7jQm2t8fUSD00vXdL0jT809T9KwexWT7b41rdKUwNCt9wfbiYbeZIVirK
	 m73ZJXVsyQ4RUkZAbZHNuMYG4d6yKjoWiomYnwvP3um+5U2D5OMVUH/Tp6Tr6bdMT1
	 GT2OOenREtc5cfrNs+xP5bgfkVlQ5vPQbyi17p7YvVL5vh6FfNsVXJlV/OWzpdBj40
	 Vz6aTlQA8oNTeJ+qEZD0IgmeqzUFvoqOrKRzQLNdp0oo1sfdx8rkH7qQpN8zzZeA1W
	 rQtpWTb7pdisw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6.y 1/4] mm: drop the assumption that VM_SHARED always implies writable
Date: Wed, 30 Jul 2025 12:29:32 -0400
Message-Id: <1753867166-903c855a@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250730015152.29758-2-isaacmanjarres@google.com>
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

Note: The patch differs from the upstream commit:
---
1:  e8e17ee90eaf ! 1:  05fbf991dedb mm: drop the assumption that VM_SHARED always implies writable
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
      	mm->map_count++;
      	if (vma->vm_file) {
      		i_mmap_lock_write(vma->vm_file->f_mapping);
    @@ mm/mmap.c: unsigned long mmap_region(struct file *file, unsigned long addr,
      
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
| 6.6                       | Success     | Success    |

