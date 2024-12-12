Return-Path: <stable+bounces-103129-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D0119EF6F4
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 18:30:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CA4D189A6DD
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 17:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 502A520969B;
	Thu, 12 Dec 2024 17:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="D4LNqcFX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3F92165F0;
	Thu, 12 Dec 2024 17:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734023635; cv=none; b=qdBBBJEkLO7RGZuNiUyiOA7k7wYw4rkygSuJuHHLRjGkCDl7mLvdH2zK/iHvQ1F4VREa3VtbReq82LK8w0Rsjm3C+0M/OsT5BOAY5kVeKOFRxoEMA7Tp1tee+ToNte5tAo4oOu/ToT1gVVlYbW4T7apMY9gjMJWX1K0DUZHLu4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734023635; c=relaxed/simple;
	bh=BDgM/jmqxg+T8YYJXrtM+a3cY0FCcI5ASF6Lbj5Rp4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oSaNGzX7tXMXlAwnSpkXF7U1wfGiA2GUYS2XYlcVyMCjpakwlC/JF8hzP/Tofow0RYKooUKX3p67An6OPj8jO82ImUFG6z6ReTNDaI0Alf3HLorVSCirXxbFiZ4xnpyKUJbIfCmuGgjtsWTII0tt5LnN76hBMqAqTSOZddNA5pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=D4LNqcFX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52170C4CED3;
	Thu, 12 Dec 2024 17:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734023634;
	bh=BDgM/jmqxg+T8YYJXrtM+a3cY0FCcI5ASF6Lbj5Rp4Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D4LNqcFXaEu6l2J5GMylreA4cppUXtHkecYNiyXDlNQGxYupOvtk0+dWWXw15vDKB
	 mE02LFxQKw60g29y7IuEEMZNV5fgWhRh6AFfOmmqI4ekyBYxShMXP2EdqtCSUffhum
	 LQyMgPL6iaymcWcmEXKmzL9pc9O3lVxSOjJA5mm8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Jann Horn <jannh@google.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Andreas Larsson <andreas@gaisler.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	"David S. Miller" <davem@davemloft.net>,
	Helge Deller <deller@gmx.de>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Mark Brown <broonie@kernel.org>,
	Peter Xu <peterx@redhat.com>,
	Will Deacon <will@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 5.10 032/459] mm: avoid unsafe VMA hook invocation when error arises on mmap hook
Date: Thu, 12 Dec 2024 15:56:10 +0100
Message-ID: <20241212144254.790431356@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144253.511169641@linuxfoundation.org>
References: <20241212144253.511169641@linuxfoundation.org>
User-Agent: quilt/0.67
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

[ Upstream commit 3dd6ed34ce1f2356a77fb88edafb5ec96784e3cf ]

Patch series "fix error handling in mmap_region() and refactor
(hotfixes)", v4.

mmap_region() is somewhat terrifying, with spaghetti-like control flow and
numerous means by which issues can arise and incomplete state, memory
leaks and other unpleasantness can occur.

A large amount of the complexity arises from trying to handle errors late
in the process of mapping a VMA, which forms the basis of recently
observed issues with resource leaks and observable inconsistent state.

This series goes to great lengths to simplify how mmap_region() works and
to avoid unwinding errors late on in the process of setting up the VMA for
the new mapping, and equally avoids such operations occurring while the
VMA is in an inconsistent state.

The patches in this series comprise the minimal changes required to
resolve existing issues in mmap_region() error handling, in order that
they can be hotfixed and backported.  There is additionally a follow up
series which goes further, separated out from the v1 series and sent and
updated separately.

This patch (of 5):

After an attempted mmap() fails, we are no longer in a situation where we
can safely interact with VMA hooks.  This is currently not enforced,
meaning that we need complicated handling to ensure we do not incorrectly
call these hooks.

We can avoid the whole issue by treating the VMA as suspect the moment
that the file->f_ops->mmap() function reports an error by replacing
whatever VMA operations were installed with a dummy empty set of VMA
operations.

We do so through a new helper function internal to mm - mmap_file() -
which is both more logically named than the existing call_mmap() function
and correctly isolates handling of the vm_op reassignment to mm.

All the existing invocations of call_mmap() outside of mm are ultimately
nested within the call_mmap() from mm, which we now replace.

It is therefore safe to leave call_mmap() in place as a convenience
    function (and to avoid churn).  The invokers are:

     ovl_file_operations -> mmap -> ovl_mmap() -> backing_file_mmap()
    coda_file_operations -> mmap -> coda_file_mmap()
     shm_file_operations -> shm_mmap()
shm_file_operations_huge -> shm_mmap()
            dma_buf_fops -> dma_buf_mmap_internal -> i915_dmabuf_ops
                            -> i915_gem_dmabuf_mmap()

None of these callers interact with vm_ops or mappings in a problematic
way on error, quickly exiting out.

Link: https://lkml.kernel.org/r/cover.1730224667.git.lorenzo.stoakes@oracle.com
Link: https://lkml.kernel.org/r/d41fd763496fd0048a962f3fd9407dc72dd4fd86.1730224667.git.lorenzo.stoakes@oracle.com
Fixes: deb0f6562884 ("mm/mmap: undo ->mmap() when arch_validate_flags() fails")
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reported-by: Jann Horn <jannh@google.com>
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: Jann Horn <jannh@google.com>
Cc: Andreas Larsson <andreas@gaisler.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Helge Deller <deller@gmx.de>
Cc: James E.J. Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: Peter Xu <peterx@redhat.com>
Cc: Will Deacon <will@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/internal.h |   12 ++++++++++++
 mm/mmap.c     |    4 ++--
 mm/nommu.c    |    4 ++--
 mm/util.c     |   18 ++++++++++++++++++
 4 files changed, 34 insertions(+), 4 deletions(-)

--- a/mm/internal.h
+++ b/mm/internal.h
@@ -34,6 +34,18 @@
 
 void page_writeback_init(void);
 
+/*
+ * This is a file-backed mapping, and is about to be memory mapped - invoke its
+ * mmap hook and safely handle error conditions. On error, VMA hooks will be
+ * mutated.
+ *
+ * @file: File which backs the mapping.
+ * @vma:  VMA which we are mapping.
+ *
+ * Returns: 0 if success, error otherwise.
+ */
+int mmap_file(struct file *file, struct vm_area_struct *vma);
+
 vm_fault_t do_swap_page(struct vm_fault *vmf);
 
 void free_pgtables(struct mmu_gather *tlb, struct vm_area_struct *start_vma,
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1808,7 +1808,7 @@ unsigned long mmap_region(struct file *f
 		 * new file must not have been exposed to user-space, yet.
 		 */
 		vma->vm_file = get_file(file);
-		error = call_mmap(file, vma);
+		error = mmap_file(file, vma);
 		if (error)
 			goto unmap_and_free_vma;
 
@@ -1823,7 +1823,7 @@ unsigned long mmap_region(struct file *f
 
 		addr = vma->vm_start;
 
-		/* If vm_flags changed after call_mmap(), we should try merge vma again
+		/* If vm_flags changed after mmap_file(), we should try merge vma again
 		 * as we may succeed this time.
 		 */
 		if (unlikely(vm_flags != vma->vm_flags && prev)) {
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -955,7 +955,7 @@ static int do_mmap_shared_file(struct vm
 {
 	int ret;
 
-	ret = call_mmap(vma->vm_file, vma);
+	ret = mmap_file(vma->vm_file, vma);
 	if (ret == 0) {
 		vma->vm_region->vm_top = vma->vm_region->vm_end;
 		return 0;
@@ -986,7 +986,7 @@ static int do_mmap_private(struct vm_are
 	 * - VM_MAYSHARE will be set if it may attempt to share
 	 */
 	if (capabilities & NOMMU_MAP_DIRECT) {
-		ret = call_mmap(vma->vm_file, vma);
+		ret = mmap_file(vma->vm_file, vma);
 		if (ret == 0) {
 			/* shouldn't return success if we're not sharing */
 			BUG_ON(!(vma->vm_flags & VM_MAYSHARE));
--- a/mm/util.c
+++ b/mm/util.c
@@ -1073,3 +1073,21 @@ int __weak memcmp_pages(struct page *pag
 	kunmap_atomic(addr1);
 	return ret;
 }
+
+int mmap_file(struct file *file, struct vm_area_struct *vma)
+{
+	static const struct vm_operations_struct dummy_vm_ops = {};
+	int err = call_mmap(file, vma);
+
+	if (likely(!err))
+		return 0;
+
+	/*
+	 * OK, we tried to call the file hook for mmap(), but an error
+	 * arose. The mapping is in an inconsistent state and we most not invoke
+	 * any further hooks on it.
+	 */
+	vma->vm_ops = &dummy_vm_ops;
+
+	return err;
+}



