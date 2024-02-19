Return-Path: <stable+bounces-20542-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A959085A750
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 16:25:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 492761F2142F
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 15:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80ED5383A1;
	Mon, 19 Feb 2024 15:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bM8mFs/c"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4013D3839B
	for <stable@vger.kernel.org>; Mon, 19 Feb 2024 15:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708356315; cv=none; b=Sh5zhAqI7CdjQV+qvDu249kkMJIB6F5xBF1bDeGElNcOmOhev93TuZBSrSC1KKe+IzA7ogecTPUV+IbSXT2JEoDmaeUkRuSDmsIOn0wju4Tj8BQn7UzLEGRy9mJzbUyQvhifA9hTqrAEWk3WDaKpYANEpLnQ2FTrUFr+jbVQLS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708356315; c=relaxed/simple;
	bh=XMAwhd513OzrWbhqYszqwzRJS4HKcTdTYX2ZXufpADo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h5U37ziQ7vqYXQDZCY8mLs1e0pzQ2fx1VTCJVI/jhtCEamnRiScGYZa0nK8X7CeM8kh2Btg4YMp6+OAdEJFojVMr8NMJwvMCc/IJw3UTvhRaCenrA1TlG4NVrlgq/Fr7v4OZGw4AzF7zp0VJmTj8UmSCY5QgL6NcXRP9RizWatE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bM8mFs/c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70C30C433C7;
	Mon, 19 Feb 2024 15:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708356315;
	bh=XMAwhd513OzrWbhqYszqwzRJS4HKcTdTYX2ZXufpADo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bM8mFs/chvnd/DZJrVp4awMxRtTndENIQ/NB5+9l2mW5+j6jHY95dfPoQftccX+rF
	 9Qu/MkuWXBjcqvDvIb41qqEz/jKZeVfAzKkJrUPGnOpygLg0diFneq3Aejx68PBAmy
	 BylNhrc2igJwbfyuq2JLQBiFkMjgabtB47h+AF9o/pFCruaNXNBnVsYpSAqie4G6Fs
	 Y97oxEuLkQO0QO8Evm+6uiIH2th0bdl40jL6kock58yEfqF8VqIZSrUJeRDF8ibUxY
	 JL8P6ZX7fnVK6Ga9ccl87vV8GkfX5PdPJ7iedbv9TUIzQ8kiBCHVLlvf0UQADZqbCM
	 W6h2KtINucuCQ==
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
Subject: ["PATCH 6.1.y"] userfaultfd: fix mmap_changing checking in mfill_atomic_hugetlb
Date: Mon, 19 Feb 2024 17:24:52 +0200
Message-ID: <20240219152452.394767-1-rppt@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2024021847-glandular-distant-2033@gregkh>
References: <2024021847-glandular-distant-2033@gregkh>
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
 mm/userfaultfd.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 650ab6cfd5f4..992a0a16846f 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -327,6 +327,7 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
 					      unsigned long dst_start,
 					      unsigned long src_start,
 					      unsigned long len,
+					      atomic_t *mmap_changing,
 					      enum mcopy_atomic_mode mode,
 					      bool wp_copy)
 {
@@ -445,6 +446,15 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
 				goto out;
 			}
 			mmap_read_lock(dst_mm);
+			/*
+			 * If memory mappings are changing because of non-cooperative
+			 * operation (e.g. mremap) running in parallel, bail out and
+			 * request the user to retry later
+			 */
+			if (mmap_changing && atomic_read(mmap_changing)) {
+				err = -EAGAIN;
+				break;
+			}
 
 			dst_vma = NULL;
 			goto retry;
@@ -480,6 +490,7 @@ extern ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
 				      unsigned long dst_start,
 				      unsigned long src_start,
 				      unsigned long len,
+				      atomic_t *mmap_changing,
 				      enum mcopy_atomic_mode mode,
 				      bool wp_copy);
 #endif /* CONFIG_HUGETLB_PAGE */
@@ -601,8 +612,8 @@ static __always_inline ssize_t __mcopy_atomic(struct mm_struct *dst_mm,
 	 */
 	if (is_vm_hugetlb_page(dst_vma))
 		return  __mcopy_atomic_hugetlb(dst_mm, dst_vma, dst_start,
-					       src_start, len, mcopy_mode,
-					       wp_copy);
+					       src_start, len, mmap_changing,
+					       mcopy_mode, wp_copy);
 
 	if (!vma_is_anonymous(dst_vma) && !vma_is_shmem(dst_vma))
 		goto out_unlock;
-- 
2.43.0


