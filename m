Return-Path: <stable+bounces-20543-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C2BC85A751
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 16:26:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 423DE1F2159B
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 15:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BFE138396;
	Mon, 19 Feb 2024 15:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NhmJL0Zp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9BD1EA80
	for <stable@vger.kernel.org>; Mon, 19 Feb 2024 15:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708356366; cv=none; b=NEF17fmRXDl11lXbTDBEgMFZvZu9xz+SxLid/EMFPXHO4NOfQMEE5YBcN7H36kJrRgZq5HXYT66N6RSF9Nzlqh4wlDI2FeVXJy74aImO5M0mJmzl+T3XnvPt2GtblcveFgh9wLJ4Pv4f4NFMy5pus2rwDzihTJD7RwRFMeFuIOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708356366; c=relaxed/simple;
	bh=zL3299zTVnK2hz7DI4UAzlgM3bvr4vtxM8b4CuPIUkg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f1WBgpuzsp2RvY7t324FRXGvgtAi6dw06/2+YrSgw2MYKKv0RefdcE3iutgbmy+jOHT39AV+19to0vaHGx8npMH++a7k7De8MfR4AMkRi3zXG23X4cZK7Xp7g9+GoaXpOjC0ZfEzdYzq74YZ7YVRdr9S+ldLBaw1IZG93YOO4tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NhmJL0Zp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E04D2C433F1;
	Mon, 19 Feb 2024 15:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708356365;
	bh=zL3299zTVnK2hz7DI4UAzlgM3bvr4vtxM8b4CuPIUkg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NhmJL0ZpnEXRq4Y+5Xt03bum30eQxASc+T+VIzy8ynZm/119grXYyf4JYJtsRh58W
	 xGkTZOSi1BJaIE96UWMcf+H0pubgWsIkXFPefn9X6eV9JUtgTsKCmvDfnsivCqyXWj
	 HPtzYsUBdU9B0On88OAkH0Uc7/4GNIWbjSqbMIfn9WcjVLsHp/HdiabnxMJbZD6sEe
	 2dFOZpKsIqb0QW65WCLELtUXo+dvrbkxzW9+ZxzZKAf8/kM/l0K4WRvosQRhkb75h+
	 0KTdp6IQCJzou50bscBGfisjeiFqRXkp0JHC9fhWBUGTNyXoil3um0A5XUtaI3Kxed
	 LYmqWwxKqOXEg==
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
Subject: ["PATCH 5.15.y"] userfaultfd: fix mmap_changing checking in mfill_atomic_hugetlb
Date: Mon, 19 Feb 2024 17:25:51 +0200
Message-ID: <20240219152551.394793-1-rppt@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2024021848-spiny-glitzy-711f@gregkh>
References: <2024021848-spiny-glitzy-711f@gregkh>
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
index caa13abe0c56..98a9d0ef2d91 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -289,6 +289,7 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
 					      unsigned long dst_start,
 					      unsigned long src_start,
 					      unsigned long len,
+					      atomic_t *mmap_changing,
 					      enum mcopy_atomic_mode mode)
 {
 	int vm_shared = dst_vma->vm_flags & VM_SHARED;
@@ -405,6 +406,15 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
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
@@ -440,6 +450,7 @@ extern ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
 				      unsigned long dst_start,
 				      unsigned long src_start,
 				      unsigned long len,
+				      atomic_t *mmap_changing,
 				      enum mcopy_atomic_mode mode);
 #endif /* CONFIG_HUGETLB_PAGE */
 
@@ -561,7 +572,8 @@ static __always_inline ssize_t __mcopy_atomic(struct mm_struct *dst_mm,
 	 */
 	if (is_vm_hugetlb_page(dst_vma))
 		return  __mcopy_atomic_hugetlb(dst_mm, dst_vma, dst_start,
-						src_start, len, mcopy_mode);
+					       src_start, len, mmap_changing,
+					       mcopy_mode);
 
 	if (!vma_is_anonymous(dst_vma) && !vma_is_shmem(dst_vma))
 		goto out_unlock;
-- 
2.43.0


