Return-Path: <stable+bounces-93911-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5786F9D1F60
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 05:36:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9FB91B24437
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 04:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E565214D2A0;
	Tue, 19 Nov 2024 04:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qpxL5qd+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F8814883C
	for <stable@vger.kernel.org>; Tue, 19 Nov 2024 04:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731991003; cv=none; b=rE5h9iyrDQ15w8EFh9sHyigslprfCs1lyFCYCzRVp2sOO6UK4g22FFVPbJmMKjdAkLnJre6PhtfgUf8wCIBvO4TOsVqLIGsNZYIzjXchuiwKjSQF71aXuy33oDQbosRTImAccF3nlqGSQfITZq4h7kjHYYJYQHV6/UgE1vTLY20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731991003; c=relaxed/simple;
	bh=ksEXlhB757MaVVmk+azjduhfOtsKwrH9EjFhfmz3+X0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VQib+rg1zSHroMpQETdiFbo5jVObzD1QKSMjsDct+9Ahiasr6HYFwJsyvRJXY8GH9mIRhj8Evu7Pa089+TVHaMFLGrNI8NlHm+6qfjwwPwEc7X2+eS3Iew1LodVqD6/q5clwoILhLQ3W2nd3h1S1xWKRQQZfoNQejVz6fTYemMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qpxL5qd+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16807C4CECF;
	Tue, 19 Nov 2024 04:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731991003;
	bh=ksEXlhB757MaVVmk+azjduhfOtsKwrH9EjFhfmz3+X0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qpxL5qd+OW+j6bQe00WbJhDfOGYizlXgCa25nnIHz3tyvztRTU3N2qLKoRXtfy//l
	 LQWehTgmVvh5kV0bDShj4SMzC5ipRddCCrE922f1sw37E56WxQJ5qXm9uxAW5h28+U
	 ZRK70Kh1qUQtWVC5xahZaAxJN25sIbYW4Y5tWtwZMO5/IKeMUo21ZPJr/PXojmPhRK
	 KKekLHrA8n2csinBC51HXz8yUPEBmjZdbFdBq59pTF5M2ct9VhAvdV859ODD7w8dHU
	 TzGmF2M/BAHAQYvj36MlnkjVk2c5MMcCSRDD5Ancy8m3LJyTJpzEkFIHAmttqQZINa
	 Cbd2P11g+l6wQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y v2 3/4] mm: refactor arch_calc_vm_flag_bits() and arm64 MTE handling
Date: Mon, 18 Nov 2024 23:36:41 -0500
Message-ID: <fb0aeea7eb024efb92c512a873f40aa6ab27898a.1731946386.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <fb0aeea7eb024efb92c512a873f40aa6ab27898a.1731946386.git.lorenzo.stoakes@oracle.com>
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

The upstream commit SHA1 provided is correct: 5baf8b037debf4ec60108ccfeccb8636d1dbad81

Commit in newer trees:

|-----------------|----------------------------------------------|
| 6.11.y          |  Present (different SHA1: 9f5efc1137ba)      |
| 6.6.y           |  Not found                                   |
| 6.1.y           |  Not found                                   |
|-----------------|----------------------------------------------|

Note: The patch differs from the upstream commit:
---
--- -	2024-11-18 17:15:02.588328592 -0500
+++ /tmp/tmp.LhvhUpwE7J	2024-11-18 17:15:02.577003940 -0500
@@ -50,29 +50,29 @@
 Cc: Will Deacon <will@kernel.org>
 Cc: <stable@vger.kernel.org>
 Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
+Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
 ---
- arch/arm64/include/asm/mman.h  | 10 +++++++---
- arch/parisc/include/asm/mman.h |  5 +++--
- include/linux/mman.h           |  7 ++++---
- mm/mmap.c                      |  2 +-
- mm/nommu.c                     |  2 +-
- mm/shmem.c                     |  3 ---
- 6 files changed, 16 insertions(+), 13 deletions(-)
+ arch/arm64/include/asm/mman.h | 10 +++++++---
+ include/linux/mman.h          |  7 ++++---
+ mm/mmap.c                     |  2 +-
+ mm/nommu.c                    |  2 +-
+ mm/shmem.c                    |  3 ---
+ 5 files changed, 13 insertions(+), 11 deletions(-)
 
 diff --git a/arch/arm64/include/asm/mman.h b/arch/arm64/include/asm/mman.h
-index 9e39217b4afbb..798d965760d43 100644
+index 5966ee4a6154..ef35c52aabd6 100644
 --- a/arch/arm64/include/asm/mman.h
 +++ b/arch/arm64/include/asm/mman.h
-@@ -6,6 +6,8 @@
+@@ -3,6 +3,8 @@
+ #define __ASM_MMAN_H__
  
- #ifndef BUILD_VDSO
  #include <linux/compiler.h>
 +#include <linux/fs.h>
 +#include <linux/shmem_fs.h>
  #include <linux/types.h>
+ #include <uapi/asm/mman.h>
  
- static inline unsigned long arch_calc_vm_prot_bits(unsigned long prot,
-@@ -31,19 +33,21 @@ static inline unsigned long arch_calc_vm_prot_bits(unsigned long prot,
+@@ -21,19 +23,21 @@ static inline unsigned long arch_calc_vm_prot_bits(unsigned long prot,
  }
  #define arch_calc_vm_prot_bits(prot, pkey) arch_calc_vm_prot_bits(prot, pkey)
  
@@ -97,37 +97,8 @@
  
  static inline bool arch_validate_prot(unsigned long prot,
  	unsigned long addr __always_unused)
-diff --git a/arch/parisc/include/asm/mman.h b/arch/parisc/include/asm/mman.h
-index 89b6beeda0b86..663f587dc7896 100644
---- a/arch/parisc/include/asm/mman.h
-+++ b/arch/parisc/include/asm/mman.h
-@@ -2,6 +2,7 @@
- #ifndef __ASM_MMAN_H__
- #define __ASM_MMAN_H__
- 
-+#include <linux/fs.h>
- #include <uapi/asm/mman.h>
- 
- /* PARISC cannot allow mdwe as it needs writable stacks */
-@@ -11,7 +12,7 @@ static inline bool arch_memory_deny_write_exec_supported(void)
- }
- #define arch_memory_deny_write_exec_supported arch_memory_deny_write_exec_supported
- 
--static inline unsigned long arch_calc_vm_flag_bits(unsigned long flags)
-+static inline unsigned long arch_calc_vm_flag_bits(struct file *file, unsigned long flags)
- {
- 	/*
- 	 * The stack on parisc grows upwards, so if userspace requests memory
-@@ -23,6 +24,6 @@ static inline unsigned long arch_calc_vm_flag_bits(unsigned long flags)
- 
- 	return 0;
- }
--#define arch_calc_vm_flag_bits(flags) arch_calc_vm_flag_bits(flags)
-+#define arch_calc_vm_flag_bits(file, flags) arch_calc_vm_flag_bits(file, flags)
- 
- #endif /* __ASM_MMAN_H__ */
 diff --git a/include/linux/mman.h b/include/linux/mman.h
-index 8ddca62d6460b..a842783ffa62b 100644
+index 58b3abd457a3..21ea08b919d9 100644
 --- a/include/linux/mman.h
 +++ b/include/linux/mman.h
 @@ -2,6 +2,7 @@
@@ -138,7 +109,7 @@
  #include <linux/mm.h>
  #include <linux/percpu_counter.h>
  
-@@ -94,7 +95,7 @@ static inline void vm_unacct_memory(long pages)
+@@ -90,7 +91,7 @@ static inline void vm_unacct_memory(long pages)
  #endif
  
  #ifndef arch_calc_vm_flag_bits
@@ -147,7 +118,7 @@
  #endif
  
  #ifndef arch_validate_prot
-@@ -151,13 +152,13 @@ calc_vm_prot_bits(unsigned long prot, unsigned long pkey)
+@@ -147,12 +148,12 @@ calc_vm_prot_bits(unsigned long prot, unsigned long pkey)
   * Combine the mmap "flags" argument into "vm_flags" used internally.
   */
  static inline unsigned long
@@ -157,49 +128,51 @@
  	return _calc_vm_trans(flags, MAP_GROWSDOWN,  VM_GROWSDOWN ) |
  	       _calc_vm_trans(flags, MAP_LOCKED,     VM_LOCKED    ) |
  	       _calc_vm_trans(flags, MAP_SYNC,	     VM_SYNC      ) |
- 	       _calc_vm_trans(flags, MAP_STACK,	     VM_NOHUGEPAGE) |
 -	       arch_calc_vm_flag_bits(flags);
 +	       arch_calc_vm_flag_bits(file, flags);
  }
  
  unsigned long vm_commit_limit(void);
 diff --git a/mm/mmap.c b/mm/mmap.c
-index ab71d4c3464cd..aee5fa08ae5d1 100644
+index 4bfec4df51c2..322677f61d30 100644
 --- a/mm/mmap.c
 +++ b/mm/mmap.c
-@@ -344,7 +344,7 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
+@@ -1316,7 +1316,7 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
  	 * to. we assume access permissions have been handled by the open
  	 * of the memory object, so we don't do any here.
  	 */
--	vm_flags |= calc_vm_prot_bits(prot, pkey) | calc_vm_flag_bits(flags) |
-+	vm_flags |= calc_vm_prot_bits(prot, pkey) | calc_vm_flag_bits(file, flags) |
+-	vm_flags = calc_vm_prot_bits(prot, pkey) | calc_vm_flag_bits(flags) |
++	vm_flags = calc_vm_prot_bits(prot, pkey) | calc_vm_flag_bits(file, flags) |
  			mm->def_flags | VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC;
  
- 	/* Obtain the address to map to. we verify (or select) it and ensure
+ 	if (flags & MAP_LOCKED)
 diff --git a/mm/nommu.c b/mm/nommu.c
-index 635d028d647b3..e9b5f527ab5b4 100644
+index e0428fa57526..859ba6bdeb9c 100644
 --- a/mm/nommu.c
 +++ b/mm/nommu.c
-@@ -842,7 +842,7 @@ static unsigned long determine_vm_flags(struct file *file,
+@@ -903,7 +903,7 @@ static unsigned long determine_vm_flags(struct file *file,
  {
  	unsigned long vm_flags;
  
 -	vm_flags = calc_vm_prot_bits(prot, 0) | calc_vm_flag_bits(flags);
 +	vm_flags = calc_vm_prot_bits(prot, 0) | calc_vm_flag_bits(file, flags);
+ 	/* vm_flags |= mm->def_flags; */
  
- 	if (!file) {
- 		/*
+ 	if (!(capabilities & NOMMU_MAP_DIRECT)) {
 diff --git a/mm/shmem.c b/mm/shmem.c
-index 4ba1d00fabdaa..e87f5d6799a7b 100644
+index 0e1fbc53717d..d1a33f66cc7f 100644
 --- a/mm/shmem.c
 +++ b/mm/shmem.c
-@@ -2733,9 +2733,6 @@ static int shmem_mmap(struct file *file, struct vm_area_struct *vma)
+@@ -2308,9 +2308,6 @@ static int shmem_mmap(struct file *file, struct vm_area_struct *vma)
  	if (ret)
  		return ret;
  
 -	/* arm64 - allow memory tagging on RAM-based files */
--	vm_flags_set(vma, VM_MTE_ALLOWED);
+-	vma->vm_flags |= VM_MTE_ALLOWED;
 -
  	file_accessed(file);
- 	/* This is anonymous shared memory if it is unlinked at the time of mmap */
- 	if (inode->i_nlink)
+ 	vma->vm_ops = &shmem_vm_ops;
+ 	return 0;
+-- 
+2.47.0
+
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

