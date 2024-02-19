Return-Path: <stable+bounces-20545-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C37D485A758
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 16:28:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69BBE284319
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 15:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25A2A383A3;
	Mon, 19 Feb 2024 15:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gaa2RDA7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0FA139FF8
	for <stable@vger.kernel.org>; Mon, 19 Feb 2024 15:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708356496; cv=none; b=C8BVP01UfPX7CFRio9GLCXwT0KkLz/ul1RJLq61Vk7nbzEpN88mLBfoZVam6Hs2sv6qlJw3YUCLZYqzjXgaw58M8+SywYauNB4VR3pGblmK3UBwp1KuAhT+Tlrok8Oj3ZZoTjJwVcaybXQNrSrM078fEVSfRfHWoTBhEhjRAcGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708356496; c=relaxed/simple;
	bh=pL3E7InpGvGpfwpJ3VmC0F5xokOAzwxW74bTS3/77v0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KptqdLYvwTMkaPGRZe+8DrYf115UufYjer0UEXWyug4IYjiNDepFID8D5d5teu+MJUrj4K9dXopWyhwcwBLdH2oHuynXpgboEX5+hyyIt4zHa91VWZIcasNaGCK/0zR+9hDGJSD4LGyWpQ/l7p4+TP1bAEWrutAfDnm3YWqIwcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gaa2RDA7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF584C433C7;
	Mon, 19 Feb 2024 15:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708356496;
	bh=pL3E7InpGvGpfwpJ3VmC0F5xokOAzwxW74bTS3/77v0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Gaa2RDA7NOiizGldOwGaO0py+5J9vPs6bHdUbp4Xz18TfnPUVclSFmABgvu0GjjRq
	 1fMXBmebmMwH4Pg/PNRIqU43syQ+zq2xnlusV/8BgjJRqTUNwf3AqfBMYFafzb4NlN
	 ql8WID4ekegqg0mA1EjGEEnap+3dNOUZwI2VjetlLssI6DeB1D2IP05odMs0pFGG2X
	 0W+ZuioycZrGs8z3f9nrfP8BrWZH01iC3QE3LO49hNGna96LHxfdN7IhwYZxpxrr1x
	 cl9/ZbrDCRMXGpztzvL8Y1nrzbAPyvtFvzBwiYdpO7mVaEqmytq2HND1HZoGgBJr47
	 bpY8BYRUYbO9w==
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
Subject: ["PATCH 5.4.y"] userfaultfd: fix mmap_changing checking in mfill_atomic_hugetlb
Date: Mon, 19 Feb 2024 17:28:02 +0200
Message-ID: <20240219152802.394860-1-rppt@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2024021850-vaseline-mongrel-489e@gregkh>
References: <2024021850-vaseline-mongrel-489e@gregkh>
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
index 6fa66e2111ea..e8758304a9f3 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -177,6 +177,7 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
 					      unsigned long dst_start,
 					      unsigned long src_start,
 					      unsigned long len,
+					      bool *mmap_changing,
 					      bool zeropage)
 {
 	int vm_alloc_shared = dst_vma->vm_flags & VM_SHARED;
@@ -308,6 +309,15 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
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
@@ -389,6 +399,7 @@ extern ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
 				      unsigned long dst_start,
 				      unsigned long src_start,
 				      unsigned long len,
+				      bool *mmap_changing,
 				      bool zeropage);
 #endif /* CONFIG_HUGETLB_PAGE */
 
@@ -506,7 +517,8 @@ static __always_inline ssize_t __mcopy_atomic(struct mm_struct *dst_mm,
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


