Return-Path: <stable+bounces-143160-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BF00AB330A
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 11:22:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7B92189D2D0
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 09:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D528425D526;
	Mon, 12 May 2025 09:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="URnfFxew"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87FF725B664
	for <stable@vger.kernel.org>; Mon, 12 May 2025 09:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747041646; cv=none; b=np2E2Ru1xacLq2mUqhnKdk7hDTnkY6a225hDa/+ccXtUhqOWRnGSPcX1mLNA3LIE1PeVVtxmIcrBo/9QFU74CMTKzfQD6I+kSBCJm49DX5MBc7Ys4hLcfIDKxjCN/hx7+u1CgyzzR/WCpTbCNv2ht/NUGP+cWjr2zPE8VG62yQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747041646; c=relaxed/simple;
	bh=o8vYb7blo4q0QXfVu33Pdf5aQ5IjVY1LZdLDaEtSMZ8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=MXZg2GlS8de2DR0cHK0/RxHBCWbfCBUD0rAY9Ucd6PhBg+Ajek0aHxPooRcFsUKlr+mNeiXbaATyFWMVOLiiM3w7rXo+DpuM9mfRkj3xiKJffEE0vcmRKslKr3TtiH6IrQHvaQxQxyJ1+8qQxls7kuvz2E04Yr5Iiy8oi0lAYgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=URnfFxew; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BB4DC4CEE7;
	Mon, 12 May 2025 09:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747041646;
	bh=o8vYb7blo4q0QXfVu33Pdf5aQ5IjVY1LZdLDaEtSMZ8=;
	h=Subject:To:Cc:From:Date:From;
	b=URnfFxewYpcIYrnHmEtHsdkl98d5N3nsBiv1LnZDAePbMYXO4A2jE5pl7epTXaykn
	 ezL/4P+67nLVFnfoKGlnfBGXIsxlZcl0bqHkQpWcdMLDXl3KNeuqTTahEGwGKlwPhF
	 fmDVDZBLvKPSvpRRJK4oLGAR4Ic5R8NWZXyD1YNE=
Subject: FAILED: patch "[PATCH] mm/userfaultfd: fix uninitialized output field for -EAGAIN" failed to apply to 5.4-stable tree
To: peterx@redhat.com,aarcange@redhat.com,akpm@linux-foundation.org,axelrasmussen@google.com,david@redhat.com,rppt@kernel.org,stable@vger.kernel.org,surenb@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 May 2025 11:20:36 +0200
Message-ID: <2025051236-dense-economy-c808@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 95567729173e62e0e60a1f8ad9eb2e1320a8ccac
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025051236-dense-economy-c808@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 95567729173e62e0e60a1f8ad9eb2e1320a8ccac Mon Sep 17 00:00:00 2001
From: Peter Xu <peterx@redhat.com>
Date: Thu, 24 Apr 2025 17:57:28 -0400
Subject: [PATCH] mm/userfaultfd: fix uninitialized output field for -EAGAIN
 race

While discussing some userfaultfd relevant issues recently, Andrea noticed
a potential ABI breakage with -EAGAIN on almost all userfaultfd ioctl()s.

Quote from Andrea, explaining how -EAGAIN was processed, and how this
should fix it (taking example of UFFDIO_COPY ioctl):

  The "mmap_changing" and "stale pmd" conditions are already reported as
  -EAGAIN written in the copy field, this does not change it. This change
  removes the subnormal case that left copy.copy uninitialized and required
  apps to explicitly set the copy field to get deterministic
  behavior (which is a requirement contrary to the documentation in both
  the manpage and source code). In turn there's no alteration to backwards
  compatibility as result of this change because userland will find the
  copy field consistently set to -EAGAIN, and not anymore sometime -EAGAIN
  and sometime uninitialized.

  Even then the change only can make a difference to non cooperative users
  of userfaultfd, so when UFFD_FEATURE_EVENT_* is enabled, which is not
  true for the vast majority of apps using userfaultfd or this unintended
  uninitialized field may have been noticed sooner.

Meanwhile, since this bug existed for years, it also almost affects all
ioctl()s that was introduced later.  Besides UFFDIO_ZEROPAGE, these also
get affected in the same way:

  - UFFDIO_CONTINUE
  - UFFDIO_POISON
  - UFFDIO_MOVE

This patch should have fixed all of them.

Link: https://lkml.kernel.org/r/20250424215729.194656-2-peterx@redhat.com
Fixes: df2cc96e7701 ("userfaultfd: prevent non-cooperative events vs mcopy_atomic races")
Fixes: f619147104c8 ("userfaultfd: add UFFDIO_CONTINUE ioctl")
Fixes: fc71884a5f59 ("mm: userfaultfd: add new UFFDIO_POISON ioctl")
Fixes: adef440691ba ("userfaultfd: UFFDIO_MOVE uABI")
Signed-off-by: Peter Xu <peterx@redhat.com>
Reported-by: Andrea Arcangeli <aarcange@redhat.com>
Suggested-by: Andrea Arcangeli <aarcange@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Axel Rasmussen <axelrasmussen@google.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index d80f94346199..22f4bf956ba1 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -1585,8 +1585,11 @@ static int userfaultfd_copy(struct userfaultfd_ctx *ctx,
 	user_uffdio_copy = (struct uffdio_copy __user *) arg;
 
 	ret = -EAGAIN;
-	if (atomic_read(&ctx->mmap_changing))
+	if (unlikely(atomic_read(&ctx->mmap_changing))) {
+		if (unlikely(put_user(ret, &user_uffdio_copy->copy)))
+			return -EFAULT;
 		goto out;
+	}
 
 	ret = -EFAULT;
 	if (copy_from_user(&uffdio_copy, user_uffdio_copy,
@@ -1641,8 +1644,11 @@ static int userfaultfd_zeropage(struct userfaultfd_ctx *ctx,
 	user_uffdio_zeropage = (struct uffdio_zeropage __user *) arg;
 
 	ret = -EAGAIN;
-	if (atomic_read(&ctx->mmap_changing))
+	if (unlikely(atomic_read(&ctx->mmap_changing))) {
+		if (unlikely(put_user(ret, &user_uffdio_zeropage->zeropage)))
+			return -EFAULT;
 		goto out;
+	}
 
 	ret = -EFAULT;
 	if (copy_from_user(&uffdio_zeropage, user_uffdio_zeropage,
@@ -1744,8 +1750,11 @@ static int userfaultfd_continue(struct userfaultfd_ctx *ctx, unsigned long arg)
 	user_uffdio_continue = (struct uffdio_continue __user *)arg;
 
 	ret = -EAGAIN;
-	if (atomic_read(&ctx->mmap_changing))
+	if (unlikely(atomic_read(&ctx->mmap_changing))) {
+		if (unlikely(put_user(ret, &user_uffdio_continue->mapped)))
+			return -EFAULT;
 		goto out;
+	}
 
 	ret = -EFAULT;
 	if (copy_from_user(&uffdio_continue, user_uffdio_continue,
@@ -1801,8 +1810,11 @@ static inline int userfaultfd_poison(struct userfaultfd_ctx *ctx, unsigned long
 	user_uffdio_poison = (struct uffdio_poison __user *)arg;
 
 	ret = -EAGAIN;
-	if (atomic_read(&ctx->mmap_changing))
+	if (unlikely(atomic_read(&ctx->mmap_changing))) {
+		if (unlikely(put_user(ret, &user_uffdio_poison->updated)))
+			return -EFAULT;
 		goto out;
+	}
 
 	ret = -EFAULT;
 	if (copy_from_user(&uffdio_poison, user_uffdio_poison,
@@ -1870,8 +1882,12 @@ static int userfaultfd_move(struct userfaultfd_ctx *ctx,
 
 	user_uffdio_move = (struct uffdio_move __user *) arg;
 
-	if (atomic_read(&ctx->mmap_changing))
-		return -EAGAIN;
+	ret = -EAGAIN;
+	if (unlikely(atomic_read(&ctx->mmap_changing))) {
+		if (unlikely(put_user(ret, &user_uffdio_move->move)))
+			return -EFAULT;
+		goto out;
+	}
 
 	if (copy_from_user(&uffdio_move, user_uffdio_move,
 			   /* don't copy "move" last field */


