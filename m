Return-Path: <stable+bounces-20544-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9522085A754
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 16:26:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 449FC284354
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 15:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6260338396;
	Mon, 19 Feb 2024 15:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QXJZbplE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0486438F83
	for <stable@vger.kernel.org>; Mon, 19 Feb 2024 15:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708356413; cv=none; b=cr/E+UEyuJYtPmTtG9zcs3tkmS5wkA72aApwAGfTC+mNCapyzlvjtHOjdDV3mlVAIfJnSgXo1fHI8sF7tg6HT89JSkekGJkFskoU0XBpPHIyLmTUqrvY2RGl+VSz2xiBgnjnl/lfJj+iYFfoVI5V947yJEwywIE7w76HG7Q3BMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708356413; c=relaxed/simple;
	bh=GzK4rvGIwJaFGb7zEtuOlD5CBkrXJFkm9HIvcD0Katg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=auAcD0KzPbgBldi7UCJNqubRVer5OXchTFtoC3Ajtn7hA4nS30XX5EhAkd740astTBecRczLrCu/GLd1K1YZ7+wBqXhhloWxsB95fA04DM+xHztFYwlv2VHdiVGO7OcnleFFdHU13Fa8FtJAAEUFpeZQsbu4BR2K2roBN8OGBKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QXJZbplE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C935C433F1;
	Mon, 19 Feb 2024 15:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708356412;
	bh=GzK4rvGIwJaFGb7zEtuOlD5CBkrXJFkm9HIvcD0Katg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QXJZbplEiPpSTxxd3waKRZYdaldyo/iv9q1Wr1Pr3MzRANIzbqkwwxqlbMM9uXsa8
	 HuRqHkw5DZXXltmynXBhWzErBsrRI1cmWUtMT1KIlruA8YQoT91y1qiC0KP0rBgxF9
	 PCHRBxwjM68vNOm/JlN35WBxXzfARfziftTCAm81/c66VZeG64zqdqJr5zVBhLqrfk
	 xnDSfObMLmkVAApucU/YKvJMJCG6SRDoKFviRxSN/g3d2IHDS4O9ICc+dV3MBOWUFF
	 cWKr+IOT7UmDj0Bq1hZs7Dtgq5XtY1Gj5UbiKq0TtdqNECg7RXW2JeykJMGR8OYt6H
	 xcWwQVorHELgw==
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
Subject: ["PATCH 5.10.y"] userfaultfd: fix mmap_changing checking in mfill_atomic_hugetlb
Date: Mon, 19 Feb 2024 17:26:37 +0200
Message-ID: <20240219152637.394821-1-rppt@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2024021849-backboned-clump-6dd4@gregkh>
References: <2024021849-backboned-clump-6dd4@gregkh>
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
index 078d95cd32c5..c28ff36f5b31 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -209,6 +209,7 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
 					      unsigned long dst_start,
 					      unsigned long src_start,
 					      unsigned long len,
+					      bool *mmap_changing,
 					      bool zeropage)
 {
 	int vm_alloc_shared = dst_vma->vm_flags & VM_SHARED;
@@ -329,6 +330,15 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
 				goto out;
 			}
 			mmap_read_lock(dst_mm);
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
@@ -410,6 +420,7 @@ extern ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
 				      unsigned long dst_start,
 				      unsigned long src_start,
 				      unsigned long len,
+				      bool *mmap_changing,
 				      bool zeropage);
 #endif /* CONFIG_HUGETLB_PAGE */
 
@@ -529,7 +540,8 @@ static __always_inline ssize_t __mcopy_atomic(struct mm_struct *dst_mm,
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


