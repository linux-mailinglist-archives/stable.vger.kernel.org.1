Return-Path: <stable+bounces-175892-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06962B36A63
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 16:37:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DED01BC715C
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 14:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09528353364;
	Tue, 26 Aug 2025 14:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CSpMrC8i"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31EB2FE580;
	Tue, 26 Aug 2025 14:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756218242; cv=none; b=KPblXPKxNHO7H5dliKilrQ//aMTFVnX1DOMFAeSdCyNSNKEh7MVzPqgClAT/jwQf4GCsrzDLNV87CBjyWFYT/vsmm5ncmTVHR8f5/D1+JET6hWrcX1TKse61fFc/Mqd5KlhZ09CbirwKj70F66fW7IyVBMyViR68KXcMvIRQ/Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756218242; c=relaxed/simple;
	bh=ZtKQqje3JT5GEd+lHDtf1pQRG1UvnvACg0x7nAf5i5U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OCgzPq1bAlKcbnrVjL7ABadodjCm5mW5JUMP7ym53gtdvR3Tox+C4uMlY/XxoBo7+SRiTuAW2fNp4pbXoFQAO7nbB2BXbj+5EiNFtnh1ao/jz+q9JATPvR7pHm5Llo/Jbj9Znzmej24ZnvATN/tmCbGKZzw9ENzQ9/TBB+RIgUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CSpMrC8i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18944C4CEF1;
	Tue, 26 Aug 2025 14:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756218242;
	bh=ZtKQqje3JT5GEd+lHDtf1pQRG1UvnvACg0x7nAf5i5U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CSpMrC8iFefEjlm3Qr+yJyGW7SQ/aKg5fP2gwAw6e3k5pdlVPfkG1M9WIJxtSQ3+8
	 MZ7kb6OCyuhA2V6kSzkTxezrUzDJ1wGsewjO10c2LHdFTFOAn1gEUDg0FEMx1FRmmc
	 qsq9urY7XL23EvJLu7+nKP+4nv2TX7ZSNBYOtdoI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Julian Orth <ju.orth@gmail.com>,
	Jann Horn <jannh@google.com>,
	"Liam R. Howlett" <Liam.Howlett@Oracle.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Isaac J. Manjarres" <isaacmanjarres@google.com>
Subject: [PATCH 5.10 448/523] mm: reinstate ability to map write-sealed memfd mappings read-only
Date: Tue, 26 Aug 2025 13:10:58 +0200
Message-ID: <20250826110935.505072082@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110924.562212281@linuxfoundation.org>
References: <20250826110924.562212281@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

[ Upstream commit 8ec396d05d1b737c87311fb7311f753b02c2a6b1 ]

Patch series "mm: reinstate ability to map write-sealed memfd mappings
read-only".

In commit 158978945f31 ("mm: perform the mapping_map_writable() check
after call_mmap()") (and preceding changes in the same series) it became
possible to mmap() F_SEAL_WRITE sealed memfd mappings read-only.

Commit 5de195060b2e ("mm: resolve faulty mmap_region() error path
behaviour") unintentionally undid this logic by moving the
mapping_map_writable() check before the shmem_mmap() hook is invoked,
thereby regressing this change.

This series reworks how we both permit write-sealed mappings being mapped
read-only and disallow mprotect() from undoing the write-seal, fixing this
regression.

We also add a regression test to ensure that we do not accidentally
regress this in future.

Thanks to Julian Orth for reporting this regression.

This patch (of 2):

In commit 158978945f31 ("mm: perform the mapping_map_writable() check
after call_mmap()") (and preceding changes in the same series) it became
possible to mmap() F_SEAL_WRITE sealed memfd mappings read-only.

This was previously unnecessarily disallowed, despite the man page
documentation indicating that it would be, thereby limiting the usefulness
of F_SEAL_WRITE logic.

We fixed this by adapting logic that existed for the F_SEAL_FUTURE_WRITE
seal (one which disallows future writes to the memfd) to also be used for
F_SEAL_WRITE.

For background - the F_SEAL_FUTURE_WRITE seal clears VM_MAYWRITE for a
read-only mapping to disallow mprotect() from overriding the seal - an
operation performed by seal_check_write(), invoked from shmem_mmap(), the
f_op->mmap() hook used by shmem mappings.

By extending this to F_SEAL_WRITE and critically - checking
mapping_map_writable() to determine if we may map the memfd AFTER we
invoke shmem_mmap() - the desired logic becomes possible.  This is because
mapping_map_writable() explicitly checks for VM_MAYWRITE, which we will
have cleared.

Commit 5de195060b2e ("mm: resolve faulty mmap_region() error path
behaviour") unintentionally undid this logic by moving the
mapping_map_writable() check before the shmem_mmap() hook is invoked,
thereby regressing this change.

We reinstate this functionality by moving the check out of shmem_mmap()
and instead performing it in do_mmap() at the point at which VMA flags are
being determined, which seems in any case to be a more appropriate place
in which to make this determination.

In order to achieve this we rework memfd seal logic to allow us access to
this information using existing logic and eliminate the clearing of
VM_MAYWRITE from seal_check_write() which we are performing in do_mmap()
instead.

Link: https://lkml.kernel.org/r/99fc35d2c62bd2e05571cf60d9f8b843c56069e0.1732804776.git.lorenzo.stoakes@oracle.com
Fixes: 5de195060b2e ("mm: resolve faulty mmap_region() error path behaviour")
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reported-by: Julian Orth <ju.orth@gmail.com>
Closes: https://lore.kernel.org/all/CAHijbEUMhvJTN9Xw1GmbM266FXXv=U7s4L_Jem5x3AaPZxrYpQ@mail.gmail.com/
Cc: Jann Horn <jannh@google.com>
Cc: Liam R. Howlett <Liam.Howlett@Oracle.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Isaac J. Manjarres <isaacmanjarres@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/memfd.h |   14 ++++++++++++
 include/linux/mm.h    |   58 ++++++++++++++++++++++++++++++++++----------------
 mm/memfd.c            |    2 -
 mm/mmap.c             |    4 +++
 4 files changed, 59 insertions(+), 19 deletions(-)

--- a/include/linux/memfd.h
+++ b/include/linux/memfd.h
@@ -6,11 +6,25 @@
 
 #ifdef CONFIG_MEMFD_CREATE
 extern long memfd_fcntl(struct file *file, unsigned int cmd, unsigned long arg);
+unsigned int *memfd_file_seals_ptr(struct file *file);
 #else
 static inline long memfd_fcntl(struct file *f, unsigned int c, unsigned long a)
 {
 	return -EINVAL;
 }
+
+static inline unsigned int *memfd_file_seals_ptr(struct file *file)
+{
+	return NULL;
+}
 #endif
 
+/* Retrieve memfd seals associated with the file, if any. */
+static inline unsigned int memfd_file_seals(struct file *file)
+{
+	unsigned int *sealsp = memfd_file_seals_ptr(file);
+
+	return sealsp ? *sealsp : 0;
+}
+
 #endif /* __LINUX_MEMFD_H */
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3200,6 +3200,37 @@ unsigned long wp_shared_mapping_range(st
 
 extern int sysctl_nr_trim_pages;
 
+static inline bool is_write_sealed(int seals)
+{
+	return seals & (F_SEAL_WRITE | F_SEAL_FUTURE_WRITE);
+}
+
+/**
+ * is_readonly_sealed - Checks whether write-sealed but mapped read-only,
+ *                      in which case writes should be disallowing moving
+ *                      forwards.
+ * @seals: the seals to check
+ * @vm_flags: the VMA flags to check
+ *
+ * Returns whether readonly sealed, in which case writess should be disallowed
+ * going forward.
+ */
+static inline bool is_readonly_sealed(int seals, vm_flags_t vm_flags)
+{
+	/*
+	 * Since an F_SEAL_[FUTURE_]WRITE sealed memfd can be mapped as
+	 * MAP_SHARED and read-only, take care to not allow mprotect to
+	 * revert protections on such mappings. Do this only for shared
+	 * mappings. For private mappings, don't need to mask
+	 * VM_MAYWRITE as we still want them to be COW-writable.
+	 */
+	if (is_write_sealed(seals) &&
+	    ((vm_flags & (VM_SHARED | VM_WRITE)) == VM_SHARED))
+		return true;
+
+	return false;
+}
+
 /**
  * seal_check_write - Check for F_SEAL_WRITE or F_SEAL_FUTURE_WRITE flags and
  *                    handle them.
@@ -3211,24 +3242,15 @@ extern int sysctl_nr_trim_pages;
  */
 static inline int seal_check_write(int seals, struct vm_area_struct *vma)
 {
-	if (seals & (F_SEAL_WRITE | F_SEAL_FUTURE_WRITE)) {
-		/*
-		 * New PROT_WRITE and MAP_SHARED mmaps are not allowed when
-		 * write seals are active.
-		 */
-		if ((vma->vm_flags & VM_SHARED) && (vma->vm_flags & VM_WRITE))
-			return -EPERM;
-
-		/*
-		 * Since an F_SEAL_[FUTURE_]WRITE sealed memfd can be mapped as
-		 * MAP_SHARED and read-only, take care to not allow mprotect to
-		 * revert protections on such mappings. Do this only for shared
-		 * mappings. For private mappings, don't need to mask
-		 * VM_MAYWRITE as we still want them to be COW-writable.
-		 */
-		if (vma->vm_flags & VM_SHARED)
-			vma->vm_flags &= ~(VM_MAYWRITE);
-	}
+	if (!is_write_sealed(seals))
+		return 0;
+
+	/*
+	 * New PROT_WRITE and MAP_SHARED mmaps are not allowed when
+	 * write seals are active.
+	 */
+	if ((vma->vm_flags & VM_SHARED) && (vma->vm_flags & VM_WRITE))
+		return -EPERM;
 
 	return 0;
 }
--- a/mm/memfd.c
+++ b/mm/memfd.c
@@ -133,7 +133,7 @@ static int memfd_wait_for_pins(struct ad
 	return error;
 }
 
-static unsigned int *memfd_file_seals_ptr(struct file *file)
+unsigned int *memfd_file_seals_ptr(struct file *file)
 {
 	if (shmem_file(file))
 		return &SHMEM_I(file_inode(file))->seals;
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -47,6 +47,7 @@
 #include <linux/pkeys.h>
 #include <linux/oom.h>
 #include <linux/sched/mm.h>
+#include <linux/memfd.h>
 
 #include <linux/uaccess.h>
 #include <asm/cacheflush.h>
@@ -1488,6 +1489,7 @@ unsigned long do_mmap(struct file *file,
 
 	if (file) {
 		struct inode *inode = file_inode(file);
+		unsigned int seals = memfd_file_seals(file);
 		unsigned long flags_mask;
 
 		if (!file_mmap_ok(file, inode, pgoff, len))
@@ -1532,6 +1534,8 @@ unsigned long do_mmap(struct file *file,
 			vm_flags |= VM_SHARED | VM_MAYSHARE;
 			if (!(file->f_mode & FMODE_WRITE))
 				vm_flags &= ~(VM_MAYWRITE | VM_SHARED);
+			else if (is_readonly_sealed(seals, vm_flags))
+				vm_flags &= ~VM_MAYWRITE;
 			fallthrough;
 		case MAP_PRIVATE:
 			if (!(file->f_mode & FMODE_READ))



