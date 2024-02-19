Return-Path: <stable+bounces-20547-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB8485A774
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 16:34:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1FB91C2232A
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 15:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 450D2383BB;
	Mon, 19 Feb 2024 15:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n9FZu9/h"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E533B7A8
	for <stable@vger.kernel.org>; Mon, 19 Feb 2024 15:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708356863; cv=none; b=QY2OVtnWkEofDoIjyl0f+bfYwww0k9N7CixiN+ZWhAAJrlUmU7hdpSIzI2NVq/+gtrpNw2Cli9jNBBX1mqMiXJG3dYglXEU/Qv9O1/r8Ye2WnjjCjt+7G/I7qQoyZvFKws1wkYe9cdnhsDFzb2zE1oHszUaxI020vi2m+N/KDEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708356863; c=relaxed/simple;
	bh=z3EqET8v1SV8aKhSUNdapck2hOxe0BnbNbCi36QArjk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QtCaVmyRMcSyaE1XTiT1vxwGVXQmPmdApXCVtdxl2X7vAccwXH2jnPleRRXrqVxA5pNLeYA2bwhAQoU5Q9EtkYaaqcCL/HSCftVrGGzMTi72E8TaS7IP48WPWiFUDrMHbnW7vtvEGZasSX4H0sM9Qeamh+ZqQuMvHYNq27l/ujE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n9FZu9/h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E19ABC433B1;
	Mon, 19 Feb 2024 15:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708356862;
	bh=z3EqET8v1SV8aKhSUNdapck2hOxe0BnbNbCi36QArjk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n9FZu9/hu+mG7gvac8URYyfzEs8w0jMiuKsfLHIDEyfwF62xxApGj8FTHEFfTrZAu
	 E9BJcdO6Kfw+OQbeFuv2H7gY8iSxGPxSjrAuOglh8qk8fIYC1pXS/JkibyvcPS3nk7
	 aSiWIflo6bE2JNFFj7QDLOdy0LfWKCwbb1OBVF7g+k7b3ssG+bm3OcT1SpfPMr4fXr
	 pLbzG+SVOhNGzM/ucMB4q+maQ+6QGDeRoTf7vzUHyCW56mHrWHQ1/Pe7O1xsR6lxpT
	 rxSDEQeSPpEsPUY8GDOk0dJ1fAEuCb3b79HRamQDvOCwnsCqFGRSU7fR8isF8HCrBY
	 fB9g42FNNrBQg==
From: Mike Rapoport <rppt@kernel.org>
To: stable@vger.kernel.org
Cc: Lokesh Gidra <lokeshgidra@google.com>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Mike Rapoport <rppt@kernel.org>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Brian Geffon <bgeffon@google.com>,
	David Hildenbrand <david@redhat.com>,
	Jann Horn <jannh@google.com>,
	Kalesh Singh <kaleshsingh@google.com>,
	Matthew Wilcox <willy@infradead.org>,
	Nicolas Geoffray <ngeoffray@google.com>,
	Peter Xu <peterx@redhat.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 4.19.y] userfaultfd: fix mmap_changing checking in mfill_atomic_hugetlb
Date: Mon, 19 Feb 2024 17:34:01 +0200
Message-ID: <20240219153401.397328-1-rppt@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2024021851-implement-sulfide-c5fa@gregkh>
References: <2024021851-implement-sulfide-c5fa@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lokesh Gidra <lokeshgidra@google.com>

In mfill_atomic_hugetlb(), mmap_changing isn't being checked
again if we drop mmap_lock and reacquire it. When the lock is not held,
mmap_changing could have been incremented. This is also inconsistent
with the behavior in mfill_atomic().

Link: https://lkml.kernel.org/r/20240117223729.1444522-1-lokeshgidra@google.com
Fixes: df2cc96e77011 ("userfaultfd: prevent non-cooperative events vs mcopy_atomic races")
Signed-off-by: Lokesh Gidra <lokeshgidra@google.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Axel Rasmussen <axelrasmussen@google.com>
Cc: Brian Geffon <bgeffon@google.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Jann Horn <jannh@google.com>
Cc: Kalesh Singh <kaleshsingh@google.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Nicolas Geoffray <ngeoffray@google.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit 67695f18d55924b2013534ef3bdc363bc9e14605)
Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
---
 mm/userfaultfd.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index aae19c29bcfa..dcca7788222a 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -179,6 +179,7 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
 					      unsigned long dst_start,
 					      unsigned long src_start,
 					      unsigned long len,
+					      bool *mmap_changing,
 					      bool zeropage)
 {
 	int vm_alloc_shared = dst_vma->vm_flags & VM_SHARED;
@@ -310,6 +311,15 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
 				goto out;
 			}
 			down_read(&dst_mm->mmap_sem);
+			/*
+			 * If memory mappings are changing because of non-cooperative
+			 * operation (e.g. mremap) running in parallel, bail out and
+			 * request the user to retry later
+			 */
+			if (mmap_changing && READ_ONCE(*mmap_changing)) {
+				err = -EAGAIN;
+				break;
+			}
 
 			dst_vma = NULL;
 			goto retry;
@@ -391,6 +401,7 @@ extern ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
 				      unsigned long dst_start,
 				      unsigned long src_start,
 				      unsigned long len,
+				      bool *mmap_changing,
 				      bool zeropage);
 #endif /* CONFIG_HUGETLB_PAGE */
 
@@ -508,7 +519,8 @@ static __always_inline ssize_t __mcopy_atomic(struct mm_struct *dst_mm,
 	 */
 	if (is_vm_hugetlb_page(dst_vma))
 		return  __mcopy_atomic_hugetlb(dst_mm, dst_vma, dst_start,
-						src_start, len, zeropage);
+					       src_start, len, mmap_changing,
+					       zeropage);
 
 	if (!vma_is_anonymous(dst_vma) && !vma_is_shmem(dst_vma))
 		goto out_unlock;
-- 
2.43.0


