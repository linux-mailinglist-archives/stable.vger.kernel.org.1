Return-Path: <stable+bounces-20467-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 083E28598A9
	for <lists+stable@lfdr.de>; Sun, 18 Feb 2024 19:48:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39B011C2092F
	for <lists+stable@lfdr.de>; Sun, 18 Feb 2024 18:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53BB66EB7F;
	Sun, 18 Feb 2024 18:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nL7Sg9pl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112286F06C
	for <stable@vger.kernel.org>; Sun, 18 Feb 2024 18:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708282090; cv=none; b=HFfxFvaZXkQa/E7ZT3JW/p/K4ssZKJHenPnJ79mfVJM8c1hSI8QcmfNghgY/e1jLwgTdAWa2J0w6sMP+lHyusqAh7GzXvEY93dqwvnwr3k6Xn3nr/qK5cOv1+TvfWy+2h0GbypQ+DIZQVUnMo/9eW6QvjJF9MW570JYq1XeT/MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708282090; c=relaxed/simple;
	bh=BbDHkmVYkkDhyJWXS0COlC26hU70t4Nl8GuFIHVKkwE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=WrcFQ+X13Brdw+pIc5yvVrHiqvMMMT6FW+/w6p8ol8JaovaArZIoebVx7B0PbsydCETEeRx18px0g24rP5bhGJxE551G0Uwo7o7+UuIDaY2Ctw4uIfmjGUSipZAWQ5d6e9+PDzz6wqYqHL3ZBh9yZFGbl1eGR/KEaJQaMwuVM6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nL7Sg9pl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2FD9C433C7;
	Sun, 18 Feb 2024 18:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708282089;
	bh=BbDHkmVYkkDhyJWXS0COlC26hU70t4Nl8GuFIHVKkwE=;
	h=Subject:To:Cc:From:Date:From;
	b=nL7Sg9plWW7SXQKJu3gm0mmA+1Cuo2VKxhFiQHzK8n+JiQgjtp9uHGtlw6hF1xZkh
	 EW308aTL6rNfsXfW0gHTQemHNVOjk5ekEvYY6fRFowwytew38sYRPvENGOBEu7rN92
	 XIOIlUbbcLdNiWfHBEgBit+FQYJKG7oe1JarBqwI=
Subject: FAILED: patch "[PATCH] userfaultfd: fix mmap_changing checking in" failed to apply to 4.19-stable tree
To: lokeshgidra@google.com,aarcange@redhat.com,akpm@linux-foundation.org,axelrasmussen@google.com,bgeffon@google.com,david@redhat.com,jannh@google.com,kaleshsingh@google.com,ngeoffray@google.com,peterx@redhat.com,rppt@kernel.org,stable@vger.kernel.org,surenb@google.com,willy@infradead.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 18 Feb 2024 19:47:52 +0100
Message-ID: <2024021851-implement-sulfide-c5fa@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x 67695f18d55924b2013534ef3bdc363bc9e14605
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024021851-implement-sulfide-c5fa@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 67695f18d55924b2013534ef3bdc363bc9e14605 Mon Sep 17 00:00:00 2001
From: Lokesh Gidra <lokeshgidra@google.com>
Date: Wed, 17 Jan 2024 14:37:29 -0800
Subject: [PATCH] userfaultfd: fix mmap_changing checking in
 mfill_atomic_hugetlb

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

diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 20e3b0d9cf7e..75fcf1f783bc 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -357,6 +357,7 @@ static __always_inline ssize_t mfill_atomic_hugetlb(
 					      unsigned long dst_start,
 					      unsigned long src_start,
 					      unsigned long len,
+					      atomic_t *mmap_changing,
 					      uffd_flags_t flags)
 {
 	struct mm_struct *dst_mm = dst_vma->vm_mm;
@@ -472,6 +473,15 @@ static __always_inline ssize_t mfill_atomic_hugetlb(
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
@@ -506,6 +516,7 @@ extern ssize_t mfill_atomic_hugetlb(struct vm_area_struct *dst_vma,
 				    unsigned long dst_start,
 				    unsigned long src_start,
 				    unsigned long len,
+				    atomic_t *mmap_changing,
 				    uffd_flags_t flags);
 #endif /* CONFIG_HUGETLB_PAGE */
 
@@ -622,8 +633,8 @@ static __always_inline ssize_t mfill_atomic(struct mm_struct *dst_mm,
 	 * If this is a HUGETLB vma, pass off to appropriate routine
 	 */
 	if (is_vm_hugetlb_page(dst_vma))
-		return  mfill_atomic_hugetlb(dst_vma, dst_start,
-					     src_start, len, flags);
+		return  mfill_atomic_hugetlb(dst_vma, dst_start, src_start,
+					     len, mmap_changing, flags);
 
 	if (!vma_is_anonymous(dst_vma) && !vma_is_shmem(dst_vma))
 		goto out_unlock;


