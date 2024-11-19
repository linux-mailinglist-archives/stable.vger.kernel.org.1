Return-Path: <stable+bounces-93912-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D1799D1F5F
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 05:36:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1E5628029E
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 04:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AFD114B96E;
	Tue, 19 Nov 2024 04:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dQNQjSqf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF352149C57
	for <stable@vger.kernel.org>; Tue, 19 Nov 2024 04:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731991005; cv=none; b=WkkQ4boYNG0tP/rd0RyZr68l2dmpRdMp97h2oGOFgSEidHFFcofN4VRi23U0pthKwXrG2kh/9WYlxBkzaVie3JvUS7rPBDOFHbUHBaJeiPmychhFi5bQmUWp0hdCXCNbgfR2B59ESqVP1SybSDALSQd3V+yAjVU7HSSGJ7+GI64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731991005; c=relaxed/simple;
	bh=EMI2oGqW24Sqx/ZMGr3Zwr4x9pRxJiLrNhleDE1t4uo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IZV//tBWPL0KTEAAFS6n4afhhKn4KC+B3KiNnzfQbLD+CnVCzDaAmeEcrrSZ1fB/NydRXBjA2xtbbG6X5GHacTkaTho6dxSf4/cUUlj8D+GlzVnsnZS8eoCYMl45xtEZHf+GQSB1TcBSemm3h4SBeR3dm37y90K53a3sBh6/YkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dQNQjSqf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11D8BC4CED1;
	Tue, 19 Nov 2024 04:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731991005;
	bh=EMI2oGqW24Sqx/ZMGr3Zwr4x9pRxJiLrNhleDE1t4uo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dQNQjSqfYNaZ7fhlDPzw0lIhb/4h2Mnlgbe7PgEE4/iTOolkFHUBIIfyr9KfNhYia
	 9eDV8tvDtzERJRSmZPCy8KibGIZ1V1wVixcORnkFzderJjokL5oJdIhB5Cp+dcuorX
	 M6OXJwHW/X/v4PTCayQUEX9qAqb+UGlhMvnKWNdzdU6CBEmDdBk9aocvftbMlS84QH
	 pp2A9Vgr6MoFPKeu8ElQbGU7dvmqlqXQGoRqRo9kHlhIC+lNv0GZDW0a+E8ftpqpTP
	 tziS1iVFj3bJu2EIj0GMd8Qu+OBvJRCT9BsKg9+7Cvz8qld5C2b7G2YcU04lSeNQXc
	 K/xhWS3USfr/w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y v2 4/4] mm: resolve faulty mmap_region() error path behaviour
Date: Mon, 18 Nov 2024 23:36:43 -0500
Message-ID: <c1010a906529ca76149fe169291f0bb94b506dac.1731946386.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <c1010a906529ca76149fe169291f0bb94b506dac.1731946386.git.lorenzo.stoakes@oracle.com>
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

The upstream commit SHA1 provided is correct: 5de195060b2e251a835f622759550e6202167641

Commit in newer trees:

|-----------------|----------------------------------------------|
| 6.11.y          |  Not found                                   |
| 6.6.y           |  Not found                                   |
| 6.1.y           |  Not found                                   |
|-----------------|----------------------------------------------|

Note: The patch differs from the upstream commit:
---
--- -	2024-11-18 17:18:53.116972504 -0500
+++ /tmp/tmp.LfCsQR09RO	2024-11-18 17:18:53.109756830 -0500
@@ -65,16 +65,17 @@
 Cc: Will Deacon <will@kernel.org>
 Cc: <stable@vger.kernel.org>
 Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
+Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
 ---
- mm/mmap.c | 119 +++++++++++++++++++++++++++++-------------------------
- 1 file changed, 65 insertions(+), 54 deletions(-)
+ mm/mmap.c | 104 ++++++++++++++++++++++++++++++------------------------
+ 1 file changed, 57 insertions(+), 47 deletions(-)
 
 diff --git a/mm/mmap.c b/mm/mmap.c
-index aee5fa08ae5d1..79d541f1502b2 100644
+index 322677f61d30..9a9933ede542 100644
 --- a/mm/mmap.c
 +++ b/mm/mmap.c
-@@ -1358,20 +1358,18 @@ int do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
- 	return do_vmi_munmap(&vmi, mm, start, len, uf, false);
+@@ -2652,7 +2652,7 @@ int do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
+ 	return do_mas_munmap(&mas, mm, start, len, uf, false);
  }
  
 -unsigned long mmap_region(struct file *file, unsigned long addr,
@@ -82,45 +83,31 @@
  		unsigned long len, vm_flags_t vm_flags, unsigned long pgoff,
  		struct list_head *uf)
  {
- 	struct mm_struct *mm = current->mm;
- 	struct vm_area_struct *vma = NULL;
- 	pgoff_t pglen = PHYS_PFN(len);
--	struct vm_area_struct *merge;
- 	unsigned long charged = 0;
- 	struct vma_munmap_struct vms;
- 	struct ma_state mas_detach;
- 	struct maple_tree mt_detach;
- 	unsigned long end = addr + len;
--	bool writable_file_mapping = false;
- 	int error;
- 	VMA_ITERATOR(vmi, mm, addr);
- 	VMG_STATE(vmg, mm, &vmi, addr, end, vm_flags, pgoff);
-@@ -1445,28 +1443,26 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
- 	vm_flags_init(vma, vm_flags);
+@@ -2750,26 +2750,28 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
  	vma->vm_page_prot = vm_get_page_prot(vm_flags);
+ 	vma->vm_pgoff = pgoff;
  
-+	if (vma_iter_prealloc(&vmi, vma)) {
+-	if (file) {
+-		if (vm_flags & VM_SHARED) {
+-			error = mapping_map_writable(file->f_mapping);
+-			if (error)
+-				goto free_vma;
+-		}
++	if (mas_preallocate(&mas, vma, GFP_KERNEL)) {
 +		error = -ENOMEM;
 +		goto free_vma;
 +	}
-+
- 	if (file) {
+ 
++	if (file) {
  		vma->vm_file = get_file(file);
  		error = mmap_file(file, vma);
  		if (error)
 -			goto unmap_and_free_vma;
--
--		if (vma_is_shared_maywrite(vma)) {
--			error = mapping_map_writable(file->f_mapping);
--			if (error)
--				goto close_and_free_vma;
--
--			writable_file_mapping = true;
--		}
 +			goto unmap_and_free_file_vma;
- 
++
 +		/* Drivers cannot alter the address of the VMA. */
 +		WARN_ON_ONCE(addr != vma->vm_start);
+ 
  		/*
 -		 * Expansion is handled above, merging is handled below.
 -		 * Drivers should not alter the address of the VMA.
@@ -134,28 +121,21 @@
 +		VM_WARN_ON_ONCE(vm_flags != vma->vm_flags &&
 +				!(vm_flags & VM_MAYWRITE) &&
 +				(vma->vm_flags & VM_MAYWRITE));
++
+ 		mas_reset(&mas);
  
- 		vma_iter_config(&vmi, addr, end);
  		/*
-@@ -1474,6 +1470,8 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
- 		 * vma again as we may succeed this time.
- 		 */
- 		if (unlikely(vm_flags != vma->vm_flags && vmg.prev)) {
-+			struct vm_area_struct *merge;
-+
- 			vmg.flags = vma->vm_flags;
- 			/* If this fails, state is reset ready for a reattempt. */
- 			merge = vma_merge_new_range(&vmg);
-@@ -1491,7 +1489,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
+@@ -2792,7 +2794,8 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
  				vma = merge;
  				/* Update vm_flags to pick up the change. */
  				vm_flags = vma->vm_flags;
 -				goto unmap_writable;
++				mas_destroy(&mas);
 +				goto file_expanded;
  			}
- 			vma_iter_config(&vmi, addr, end);
  		}
-@@ -1500,26 +1498,15 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
+ 
+@@ -2800,31 +2803,15 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
  	} else if (vm_flags & VM_SHARED) {
  		error = shmem_zero_setup(vma);
  		if (error)
@@ -165,41 +145,46 @@
  		vma_set_anonymous(vma);
  	}
  
--	if (map_deny_write_exec(vma->vm_flags, vma->vm_flags)) {
--		error = -EACCES;
--		goto close_and_free_vma;
--	}
--
 -	/* Allow architectures to sanity-check the vm_flags */
 -	if (!arch_validate_flags(vma->vm_flags)) {
 -		error = -EINVAL;
--		goto close_and_free_vma;
+-		if (file)
+-			goto close_and_free_vma;
+-		else if (vma->vm_file)
+-			goto unmap_and_free_vma;
+-		else
+-			goto free_vma;
 -	}
 -
--	if (vma_iter_prealloc(&vmi, vma)) {
+-	if (mas_preallocate(&mas, vma, GFP_KERNEL)) {
 -		error = -ENOMEM;
--		goto close_and_free_vma;
+-		if (file)
+-			goto close_and_free_vma;
+-		else if (vma->vm_file)
+-			goto unmap_and_free_vma;
+-		else
+-			goto free_vma;
 -	}
 +#ifdef CONFIG_SPARC64
 +	/* TODO: Fix SPARC ADI! */
 +	WARN_ON_ONCE(!arch_validate_flags(vm_flags));
 +#endif
  
- 	/* Lock the VMA since it is modified after insertion into VMA tree */
- 	vma_start_write(vma);
-@@ -1533,10 +1520,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
+ 	if (vma->vm_file)
+ 		i_mmap_lock_write(vma->vm_file->f_mapping);
+@@ -2847,10 +2834,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
  	 */
  	khugepaged_enter_vma(vma, vma->vm_flags);
  
 -	/* Once vma denies write, undo our temporary denial count */
 -unmap_writable:
--	if (writable_file_mapping)
+-	if (file && vm_flags & VM_SHARED)
 -		mapping_unmap_writable(file->f_mapping);
 +file_expanded:
  	file = vma->vm_file;
- 	ksm_add_vma(vma);
  expanded:
-@@ -1569,23 +1553,17 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
+ 	perf_event_mmap(vma);
+@@ -2879,28 +2863,54 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
  
  	vma_set_page_prot(vma);
  
@@ -208,33 +193,22 @@
  
 -close_and_free_vma:
 -	vma_close(vma);
--
--	if (file || vma->vm_file) {
 -unmap_and_free_vma:
--		fput(vma->vm_file);
--		vma->vm_file = NULL;
 +unmap_and_free_file_vma:
-+	fput(vma->vm_file);
-+	vma->vm_file = NULL;
+ 	fput(vma->vm_file);
+ 	vma->vm_file = NULL;
  
--		vma_iter_set(&vmi, vma->vm_end);
--		/* Undo any partial mapping done by a device driver. */
--		unmap_region(&vmi.mas, vma, vmg.prev, vmg.next);
--	}
--	if (writable_file_mapping)
+ 	/* Undo any partial mapping done by a device driver. */
+ 	unmap_region(mm, mas.tree, vma, prev, next, vma->vm_start, vma->vm_end);
+-	if (file && (vm_flags & VM_SHARED))
 -		mapping_unmap_writable(file->f_mapping);
-+	vma_iter_set(&vmi, vma->vm_end);
-+	/* Undo any partial mapping done by a device driver. */
-+	unmap_region(&vmi.mas, vma, vmg.prev, vmg.next);
 +free_iter_vma:
-+	vma_iter_free(&vmi);
++	mas_destroy(&mas);
  free_vma:
  	vm_area_free(vma);
  unacct_error:
-@@ -1595,10 +1573,43 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
- abort_munmap:
- 	vms_abort_munmap_vmas(&vms, &mas_detach);
- gather_failed:
+ 	if (charged)
+ 		vm_unacct_memory(charged);
 -	validate_mm(mm);
  	return error;
  }
@@ -246,16 +220,12 @@
 +	unsigned long ret;
 +	bool writable_file_mapping = false;
 +
-+	/* Check to see if MDWE is applicable. */
-+	if (map_deny_write_exec(vm_flags, vm_flags))
-+		return -EACCES;
-+
 +	/* Allow architectures to sanity-check the vm_flags. */
 +	if (!arch_validate_flags(vm_flags))
 +		return -EINVAL;
 +
 +	/* Map writable and ensure this isn't a sealed memfd. */
-+	if (file && is_shared_maywrite(vm_flags)) {
++	if (file && (vm_flags & VM_SHARED)) {
 +		int error = mapping_map_writable(file->f_mapping);
 +
 +		if (error)
@@ -273,6 +243,9 @@
 +	return ret;
 +}
 +
- static int __vm_munmap(unsigned long start, size_t len, bool unlock)
+ static int __vm_munmap(unsigned long start, size_t len, bool downgrade)
  {
  	int ret;
+-- 
+2.47.0
+
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

