Return-Path: <stable+bounces-50429-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 021369065C4
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 09:55:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A64A1281FD6
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 07:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 381EE13C908;
	Thu, 13 Jun 2024 07:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="E99qKpF3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB50813C8E8
	for <stable@vger.kernel.org>; Thu, 13 Jun 2024 07:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718265339; cv=none; b=uH+3cBloQYqL5l+bgNjU8SwAnflnmTf1X9/NuKgrb3/00xmNIdiVFY3quAoXFWkGjWqz6yg/rzpkHgZFLeEUIBWQgidLk/T7Mex60kK3nqrH+eFUvXRP8HfDCKNVMz7YQ7cHksUOLPvzTQmcwTEuIVdNRPruqi/rOYzLMzENq8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718265339; c=relaxed/simple;
	bh=aqDzmQpltBfyA/8MfbCYl0lgFqz/mHiC5c8c5fLtYVQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=iF37DqNeyBEgRiEhmkA03a684NBk2CXJatF9KjiDaUXFY7nXngpAOSYrv9HJuzO96q53Xj9TsJwauBTJN0U3E0apu88LeqdrHfrnfjNqnSWWs9PyRKOM04JDvkempSBfU1aWcW/Wy1ioOm5BHU65CT1G+fLMpZszU3hvrpe5zkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=E99qKpF3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15D84C2BBFC;
	Thu, 13 Jun 2024 07:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718265338;
	bh=aqDzmQpltBfyA/8MfbCYl0lgFqz/mHiC5c8c5fLtYVQ=;
	h=Subject:To:Cc:From:Date:From;
	b=E99qKpF3Db8a8gki/cxV5RsJuvZUiSYo7Wl63MP0YHDhBLw5AdKUOxfLgRZPJjWiy
	 S2/dwCMavYVocN1TxjbFTZWK5URWyEfbEedbZYXpTlmCZcsh4+X19F8kLMO5zCG4v+
	 Q173SwmUckRHOx2Damv6wCqz4nQkOBw2oVbyagCY=
Subject: FAILED: patch "[PATCH] mm: /proc/pid/smaps_rollup: avoid skipping vma after getting" failed to apply to 6.1-stable tree
To: yzhong@purestorage.com,akpm@linux-foundation.org,david@redhat.com,mkhalfella@purestorage.com,stable@vger.kernel.org,willy@infradead.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 13 Jun 2024 09:55:35 +0200
Message-ID: <2024061335-lunchbox-playroom-cf81@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 6d065f507d82307d6161ac75c025111fb8b08a46
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024061335-lunchbox-playroom-cf81@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

6d065f507d82 ("mm: /proc/pid/smaps_rollup: avoid skipping vma after getting mmap_lock again")
250cb40f0afe ("task_mmu: convert to vma iterator")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 6d065f507d82307d6161ac75c025111fb8b08a46 Mon Sep 17 00:00:00 2001
From: Yuanyuan Zhong <yzhong@purestorage.com>
Date: Thu, 23 May 2024 12:35:31 -0600
Subject: [PATCH] mm: /proc/pid/smaps_rollup: avoid skipping vma after getting
 mmap_lock again

After switching smaps_rollup to use VMA iterator, searching for next entry
is part of the condition expression of the do-while loop.  So the current
VMA needs to be addressed before the continue statement.

Otherwise, with some VMAs skipped, userspace observed memory
consumption from /proc/pid/smaps_rollup will be smaller than the sum of
the corresponding fields from /proc/pid/smaps.

Link: https://lkml.kernel.org/r/20240523183531.2535436-1-yzhong@purestorage.com
Fixes: c4c84f06285e ("fs/proc/task_mmu: stop using linked list and highest_vm_end")
Signed-off-by: Yuanyuan Zhong <yzhong@purestorage.com>
Reviewed-by: Mohamed Khalfella <mkhalfella@purestorage.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index e5a5f015ff03..f8d35f993fe5 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -970,12 +970,17 @@ static int show_smaps_rollup(struct seq_file *m, void *v)
 				break;
 
 			/* Case 1 and 2 above */
-			if (vma->vm_start >= last_vma_end)
+			if (vma->vm_start >= last_vma_end) {
+				smap_gather_stats(vma, &mss, 0);
+				last_vma_end = vma->vm_end;
 				continue;
+			}
 
 			/* Case 4 above */
-			if (vma->vm_end > last_vma_end)
+			if (vma->vm_end > last_vma_end) {
 				smap_gather_stats(vma, &mss, last_vma_end);
+				last_vma_end = vma->vm_end;
+			}
 		}
 	} for_each_vma(vmi, vma);
 


