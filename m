Return-Path: <stable+bounces-90804-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9EB09BEB22
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 13:56:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEF6D1C21B85
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 12:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 204971F6664;
	Wed,  6 Nov 2024 12:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rOfegCuS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12C31E230E;
	Wed,  6 Nov 2024 12:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730896862; cv=none; b=jdqzx3doGxjyBZf8vgeJRHb7cZQVHG4pTV0Uvt5ZTXLnTj0x6OcwjGOGuRR26kuLISCA11ZfkgO+dZ4WsBF/k/uDJpF10cGh6/gNtwEITBmVy+aLElLEMr4hLqrNpmHRg6PH3TDULy7YNbzU0LGxa5BrnpTt9Jowq1Of+tc1d/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730896862; c=relaxed/simple;
	bh=RDCKZv/pVr5oqH1xDwv6aB4rlQUcSTzcxS9uINkx9as=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z2BTs7cFBINfNP5klaaqzOQ4AlmmWC/N00Bqh/fBN3prO3dCVJyIN3n1vph9LQUHK54hzg41XA+wr1YGFKRxiwZUUKf4cQHNesVnV/Am7wGNyAFRINeYlyCQ/zOMFq7SHt7LIFqY7cCNhIj8T5ANSp59DVE4DNV0b7RcJpaRaGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rOfegCuS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24C75C4CECD;
	Wed,  6 Nov 2024 12:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730896862;
	bh=RDCKZv/pVr5oqH1xDwv6aB4rlQUcSTzcxS9uINkx9as=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rOfegCuSpNDSezzwTzaSjRp3Rq++dbaNeG/OnTGG49nCvvCn8LJIHAl0zu7yY3C92
	 byaK42mHTeTtcha6Pn9mLtnKX7ES7LECdu3DvC/wKTxdHVZFjFuRuZTdvXECbMM3rQ
	 tgiXGvq9kMVAIz+9Hn0lNGf59gXj+yBqflptTH/A=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Christoph Hellwig <hch@lst.de>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Chris Wilson <chris@chris-wilson.co.uk>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Harshvardhan Jha <harshvardhan.j.jha@oracle.com>
Subject: [PATCH 5.10 096/110] mm: add remap_pfn_range_notrack
Date: Wed,  6 Nov 2024 13:05:02 +0100
Message-ID: <20241106120305.832960601@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241106120303.135636370@linuxfoundation.org>
References: <20241106120303.135636370@linuxfoundation.org>
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

From: Christoph Hellwig <hch@lst.de>

commit 74ffa5a3e68504dd289135b1cf0422c19ffb3f2e upstream.

Patch series "add remap_pfn_range_notrack instead of reinventing it in i915", v2.

i915 has some reason to want to avoid the track_pfn_remap overhead in
remap_pfn_range.  Add a function to the core VM to do just that rather
than reinventing the functionality poorly in the driver.

Note that the remap_io_sg path does get exercises when using Xorg on my
Thinkpad X1, so this should be considered lightly tested, I've not managed
to hit the remap_io_mapping path at all.

This patch (of 4):

Add a version of remap_pfn_range that does not call track_pfn_range.  This
will be used to fix horrible abuses of VM internals in the i915 driver.

Link: https://lkml.kernel.org/r/20210326055505.1424432-1-hch@lst.de
Link: https://lkml.kernel.org/r/20210326055505.1424432-2-hch@lst.de
Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Chris Wilson <chris@chris-wilson.co.uk>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Harshvardhan Jha <harshvardhan.j.jha@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/mm.h |    2 ++
 mm/memory.c        |   51 +++++++++++++++++++++++++++++++--------------------
 2 files changed, 33 insertions(+), 20 deletions(-)

--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2749,6 +2749,8 @@ unsigned long change_prot_numa(struct vm
 struct vm_area_struct *find_extend_vma(struct mm_struct *, unsigned long addr);
 int remap_pfn_range(struct vm_area_struct *, unsigned long addr,
 			unsigned long pfn, unsigned long size, pgprot_t);
+int remap_pfn_range_notrack(struct vm_area_struct *vma, unsigned long addr,
+		unsigned long pfn, unsigned long size, pgprot_t prot);
 int vm_insert_page(struct vm_area_struct *, unsigned long addr, struct page *);
 int vm_insert_pages(struct vm_area_struct *vma, unsigned long addr,
 			struct page **pages, unsigned long *num);
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2290,26 +2290,17 @@ static inline int remap_p4d_range(struct
 	return 0;
 }
 
-/**
- * remap_pfn_range - remap kernel memory to userspace
- * @vma: user vma to map to
- * @addr: target page aligned user address to start at
- * @pfn: page frame number of kernel physical memory address
- * @size: size of mapping area
- * @prot: page protection flags for this mapping
- *
- * Note: this is only safe if the mm semaphore is held when called.
- *
- * Return: %0 on success, negative error code otherwise.
+/*
+ * Variant of remap_pfn_range that does not call track_pfn_remap.  The caller
+ * must have pre-validated the caching bits of the pgprot_t.
  */
-int remap_pfn_range(struct vm_area_struct *vma, unsigned long addr,
-		    unsigned long pfn, unsigned long size, pgprot_t prot)
+int remap_pfn_range_notrack(struct vm_area_struct *vma, unsigned long addr,
+		unsigned long pfn, unsigned long size, pgprot_t prot)
 {
 	pgd_t *pgd;
 	unsigned long next;
 	unsigned long end = addr + PAGE_ALIGN(size);
 	struct mm_struct *mm = vma->vm_mm;
-	unsigned long remap_pfn = pfn;
 	int err;
 
 	if (WARN_ON_ONCE(!PAGE_ALIGNED(addr)))
@@ -2339,10 +2330,6 @@ int remap_pfn_range(struct vm_area_struc
 		vma->vm_pgoff = pfn;
 	}
 
-	err = track_pfn_remap(vma, &prot, remap_pfn, addr, PAGE_ALIGN(size));
-	if (err)
-		return -EINVAL;
-
 	vma->vm_flags |= VM_IO | VM_PFNMAP | VM_DONTEXPAND | VM_DONTDUMP;
 
 	BUG_ON(addr >= end);
@@ -2354,12 +2341,36 @@ int remap_pfn_range(struct vm_area_struc
 		err = remap_p4d_range(mm, pgd, addr, next,
 				pfn + (addr >> PAGE_SHIFT), prot);
 		if (err)
-			break;
+			return err;
 	} while (pgd++, addr = next, addr != end);
 
+	return 0;
+}
+
+/**
+ * remap_pfn_range - remap kernel memory to userspace
+ * @vma: user vma to map to
+ * @addr: target page aligned user address to start at
+ * @pfn: page frame number of kernel physical memory address
+ * @size: size of mapping area
+ * @prot: page protection flags for this mapping
+ *
+ * Note: this is only safe if the mm semaphore is held when called.
+ *
+ * Return: %0 on success, negative error code otherwise.
+ */
+int remap_pfn_range(struct vm_area_struct *vma, unsigned long addr,
+		    unsigned long pfn, unsigned long size, pgprot_t prot)
+{
+	int err;
+
+	err = track_pfn_remap(vma, &prot, pfn, addr, PAGE_ALIGN(size));
 	if (err)
-		untrack_pfn(vma, remap_pfn, PAGE_ALIGN(size));
+		return -EINVAL;
 
+	err = remap_pfn_range_notrack(vma, addr, pfn, size, prot);
+	if (err)
+		untrack_pfn(vma, pfn, PAGE_ALIGN(size));
 	return err;
 }
 EXPORT_SYMBOL(remap_pfn_range);



