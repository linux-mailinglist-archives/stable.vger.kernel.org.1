Return-Path: <stable+bounces-86780-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 707E29A37E3
	for <lists+stable@lfdr.de>; Fri, 18 Oct 2024 09:58:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E2A51C232F2
	for <lists+stable@lfdr.de>; Fri, 18 Oct 2024 07:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E058818C916;
	Fri, 18 Oct 2024 07:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tukTmAQL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A009218C90A
	for <stable@vger.kernel.org>; Fri, 18 Oct 2024 07:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729238326; cv=none; b=f9mCD0GBa3KYZwiIeCb2q11i4og8LFg9S6tKnkza76RvdhBTXxvyvfuskzdg+pl5hfQcD7IsudBn6y8ym2lVuNp+Zl9JyDLxS3iFR81xoTcyGfUoCrC3yFS4YvZyiSQPMvXxQIu+cMZ7MUJrXUiq7spE+40XIuDeZUtFOQhcmKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729238326; c=relaxed/simple;
	bh=VepBpgmsIo7e69YPiFzO51ccFFA+13zYAmzazuG1Q+s=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Pa+DOTzQ8Ln7MniKaXskg7rrKIRbtLAskqgvbaueRoTPDqFC/sGpUsCA/UWh+v+cIoS0Qwc3xTU8hqVNLqWoRwS+uUstk8a4q3dAYX2k2MidATtwtoGbqh5d+khckjWKYp3hPK0zbMMN1pRQtQy4ZEatgBwagMRbhLxEcGln08A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tukTmAQL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4ACBC4CEC3;
	Fri, 18 Oct 2024 07:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729238326;
	bh=VepBpgmsIo7e69YPiFzO51ccFFA+13zYAmzazuG1Q+s=;
	h=Subject:To:Cc:From:Date:From;
	b=tukTmAQL4PVTj0mqtW7KEKzk8gi7mnjpI4ATKCfbhASYxcobWUpS1SCfO6OKEVOkc
	 CVn6XkdabV1hfoYxFntCLHV40Op8wWBmGWRZC8PlTStg/mTFV7JgGXTE86o06Ooqf2
	 9TzT5kcD8uWFRr0V0+ncIQbaLIv47VV0ra1dyNy8=
Subject: FAILED: patch "[PATCH] mm: huge_memory: add vma_thp_disabled() and" failed to apply to 6.6-stable tree
To: wangkefeng.wang@huawei.com,akpm@linux-foundation.org,bfu@redhat.com,borntraeger@linux.ibm.com,david@redhat.com,frankja@linux.ibm.com,hughd@google.com,imbrenda@linux.ibm.com,ryan.roberts@arm.com,stable@vger.kernel.org,thuth@redhat.com,willy@infradead.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 18 Oct 2024 09:58:42 +0200
Message-ID: <2024101842-flatness-osmosis-b08e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 963756aac1f011d904ddd9548ae82286d3a91f96
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024101842-flatness-osmosis-b08e@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 963756aac1f011d904ddd9548ae82286d3a91f96 Mon Sep 17 00:00:00 2001
From: Kefeng Wang <wangkefeng.wang@huawei.com>
Date: Fri, 11 Oct 2024 12:24:44 +0200
Subject: [PATCH] mm: huge_memory: add vma_thp_disabled() and
 thp_disabled_by_hw()

Patch series "mm: don't install PMD mappings when THPs are disabled by the
hw/process/vma".

During testing, it was found that we can get PMD mappings in processes
where THP (and more precisely, PMD mappings) are supposed to be disabled.
While it works as expected for anon+shmem, the pagecache is the
problematic bit.

For s390 KVM this currently means that a VM backed by a file located on
filesystem with large folio support can crash when KVM tries accessing the
problematic page, because the readahead logic might decide to use a
PMD-sized THP and faulting it into the page tables will install a PMD
mapping, something that s390 KVM cannot tolerate.

This might also be a problem with HW that does not support PMD mappings,
but I did not try reproducing it.

Fix it by respecting the ways to disable THPs when deciding whether we can
install a PMD mapping.  khugepaged should already be taking care of not
collapsing if THPs are effectively disabled for the hw/process/vma.


This patch (of 2):

Add vma_thp_disabled() and thp_disabled_by_hw() helpers to be shared by
shmem_allowable_huge_orders() and __thp_vma_allowable_orders().

[david@redhat.com: rename to vma_thp_disabled(), split out thp_disabled_by_hw() ]
Link: https://lkml.kernel.org/r/20241011102445.934409-2-david@redhat.com
Fixes: 793917d997df ("mm/readahead: Add large folio readahead")
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
Reported-by: Leo Fu <bfu@redhat.com>
Tested-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
Cc: Boqiao Fu <bfu@redhat.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Janosch Frank <frankja@linux.ibm.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 67d0ab3c3bba..ef5b80e48599 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -322,6 +322,24 @@ struct thpsize {
 	(transparent_hugepage_flags &					\
 	 (1<<TRANSPARENT_HUGEPAGE_USE_ZERO_PAGE_FLAG))
 
+static inline bool vma_thp_disabled(struct vm_area_struct *vma,
+		unsigned long vm_flags)
+{
+	/*
+	 * Explicitly disabled through madvise or prctl, or some
+	 * architectures may disable THP for some mappings, for
+	 * example, s390 kvm.
+	 */
+	return (vm_flags & VM_NOHUGEPAGE) ||
+	       test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags);
+}
+
+static inline bool thp_disabled_by_hw(void)
+{
+	/* If the hardware/firmware marked hugepage support disabled. */
+	return transparent_hugepage_flags & (1 << TRANSPARENT_HUGEPAGE_UNSUPPORTED);
+}
+
 unsigned long thp_get_unmapped_area(struct file *filp, unsigned long addr,
 		unsigned long len, unsigned long pgoff, unsigned long flags);
 unsigned long thp_get_unmapped_area_vmflags(struct file *filp, unsigned long addr,
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 87b49ecc7b1e..2fb328880b50 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -109,18 +109,7 @@ unsigned long __thp_vma_allowable_orders(struct vm_area_struct *vma,
 	if (!vma->vm_mm)		/* vdso */
 		return 0;
 
-	/*
-	 * Explicitly disabled through madvise or prctl, or some
-	 * architectures may disable THP for some mappings, for
-	 * example, s390 kvm.
-	 * */
-	if ((vm_flags & VM_NOHUGEPAGE) ||
-	    test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags))
-		return 0;
-	/*
-	 * If the hardware/firmware marked hugepage support disabled.
-	 */
-	if (transparent_hugepage_flags & (1 << TRANSPARENT_HUGEPAGE_UNSUPPORTED))
+	if (thp_disabled_by_hw() || vma_thp_disabled(vma, vm_flags))
 		return 0;
 
 	/* khugepaged doesn't collapse DAX vma, but page fault is fine. */
diff --git a/mm/shmem.c b/mm/shmem.c
index 4f11b5506363..c5adb987b23c 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1664,12 +1664,7 @@ unsigned long shmem_allowable_huge_orders(struct inode *inode,
 	loff_t i_size;
 	int order;
 
-	if (vma && ((vm_flags & VM_NOHUGEPAGE) ||
-	    test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags)))
-		return 0;
-
-	/* If the hardware/firmware marked hugepage support disabled. */
-	if (transparent_hugepage_flags & (1 << TRANSPARENT_HUGEPAGE_UNSUPPORTED))
+	if (thp_disabled_by_hw() || (vma && vma_thp_disabled(vma, vm_flags)))
 		return 0;
 
 	global_huge = shmem_huge_global_enabled(inode, index, write_end,


