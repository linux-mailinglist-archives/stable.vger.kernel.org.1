Return-Path: <stable+bounces-155097-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C8FEAE1912
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 12:36:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53B324A6A5E
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 10:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBAC424E4DD;
	Fri, 20 Jun 2025 10:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ieSZ7XBS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B52825484E
	for <stable@vger.kernel.org>; Fri, 20 Jun 2025 10:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750415794; cv=none; b=szXtbJIpoKvwfAXlBL3otWFoNdAYuiYQtQLRF/RfmDAYmKEkdXXpyT3B5WKdiID7N5flt8VyNNpS7m8x7HRjbPIXU2+PRSaTqIzSo135SEGlfYrLhtPNRqmNGVQaOcQ8B5q6D0ccZpSUJICTVQVYnrtTqD6r52u1GxmciWEWU1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750415794; c=relaxed/simple;
	bh=ynWy3Ly/DOZhWg9Sniivi8emWdKaDkej5rKY+27JKAc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=NirWbP/MepCjl1IMvHPyYE6DFu5xcqoMBkJdx67pkKpylmK89O2fbUymCRnDZHmwNDJyW/CCXPLtwy1Mc4ESiwtU26H6JczuQICy+oCOk/nXqPnB2Bz2cg4XYMRvgGW67fy8DQ8k4cCdxGbZ8bLseutDjr17mZ2h2yVAixy9i68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ieSZ7XBS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07FFEC4CEE3;
	Fri, 20 Jun 2025 10:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750415794;
	bh=ynWy3Ly/DOZhWg9Sniivi8emWdKaDkej5rKY+27JKAc=;
	h=Subject:To:Cc:From:Date:From;
	b=ieSZ7XBSQRaGXcUGCDmr0aDT2tdkAEfcCQXSZQDCmah26qpWsJAiOWoybb0N2naWm
	 a5jm04+DFZFeU+V6v/w6a4m7WmNQmWrU6h5ygInNMiY6fy5o04Unn9O1MTPVHaQB8g
	 jZ1fmJICvWDG2DLbiqy2kRzkXNExq0gaud/zWePk=
Subject: FAILED: patch "[PATCH] mm/madvise: handle madvise_lock() failure during race" failed to apply to 6.15-stable tree
To: sj@kernel.org,21cnbao@gmail.com,akpm@linux-foundation.org,baohua@kernel.org,david@redhat.com,jannh@google.com,liam.howlett@oracle.com,lorenzo.stoakes@oracle.com,shakeel.butt@linux.dev,stable@vger.kernel.org,vbabka@suse.cz
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 20 Jun 2025 12:36:20 +0200
Message-ID: <2025062020-gambling-poker-8b0c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.15.y
git checkout FETCH_HEAD
git cherry-pick -x 9c49e5d09f076001e05537734d7df002162eb2b5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025062020-gambling-poker-8b0c@gregkh' --subject-prefix 'PATCH 6.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9c49e5d09f076001e05537734d7df002162eb2b5 Mon Sep 17 00:00:00 2001
From: SeongJae Park <sj@kernel.org>
Date: Mon, 2 Jun 2025 10:49:26 -0700
Subject: [PATCH] mm/madvise: handle madvise_lock() failure during race
 unwinding

When unwinding race on -ERESTARTNOINTR handling of process_madvise(),
madvise_lock() failure is ignored.  Check the failure and abort remaining
works in the case.

Link: https://lkml.kernel.org/r/20250602174926.1074-1-sj@kernel.org
Fixes: 4000e3d0a367 ("mm/madvise: remove redundant mmap_lock operations from process_madvise()")
Signed-off-by: SeongJae Park <sj@kernel.org>
Reported-by: Barry Song <21cnbao@gmail.com>
Closes: https://lore.kernel.org/CAGsJ_4xJXXO0G+4BizhohSZ4yDteziPw43_uF8nPXPWxUVChzw@mail.gmail.com
Reviewed-by: Jann Horn <jannh@google.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>
Reviewed-by: Barry Song <baohua@kernel.org>
Cc: Liam Howlett <liam.howlett@oracle.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/madvise.c b/mm/madvise.c
index 8433ac9b27e0..5f7a66a1617e 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -1881,7 +1881,9 @@ static ssize_t vector_madvise(struct mm_struct *mm, struct iov_iter *iter,
 			/* Drop and reacquire lock to unwind race. */
 			madvise_finish_tlb(&madv_behavior);
 			madvise_unlock(mm, behavior);
-			madvise_lock(mm, behavior);
+			ret = madvise_lock(mm, behavior);
+			if (ret)
+				goto out;
 			madvise_init_tlb(&madv_behavior, mm);
 			continue;
 		}
@@ -1892,6 +1894,7 @@ static ssize_t vector_madvise(struct mm_struct *mm, struct iov_iter *iter,
 	madvise_finish_tlb(&madv_behavior);
 	madvise_unlock(mm, behavior);
 
+out:
 	ret = (total_len - iov_iter_count(iter)) ? : ret;
 
 	return ret;


