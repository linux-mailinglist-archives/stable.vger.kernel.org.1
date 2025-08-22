Return-Path: <stable+bounces-172442-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98E17B31CB7
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 16:52:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D4BEB4394B
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 14:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDF863074A0;
	Fri, 22 Aug 2025 14:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pBICrRze"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD09B214232
	for <stable@vger.kernel.org>; Fri, 22 Aug 2025 14:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755873856; cv=none; b=WEEArf1UWSGC5tb3WcOVkDdDE90uMQIN7g9vfxL9xgvqwKF2jZNRBuvxKiKt2zWChR9rb6HMcZAOZQUjD+9WgDwTEFW98EkW+dzSz6QmBnAaHD6Vess9p3/5QdPJ2hx3kFm9kh7fQM749gmvsgKxzSedjInYLra/Dz3kHwOTubs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755873856; c=relaxed/simple;
	bh=vG+nf0xIim3hpmGAUICKY+lIMGOSE9+9BxLqObN/z8Q=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=FyZ3/U3zG9oAtoJkNz3e4LsxHKbv+qMzmRd7udWIBkB9B3aBr/Lj1dJ2tbxC+AnkFPXyV7lN/x1jX6Kgc7A/5/3xQZcwAiSiLA7vmmij4pK+X03D44hiMHG0RiJVvST1OMoSn0owwifMfLlO5GRpFFiBG1kujgbmnmyz5N3bThM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pBICrRze; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB1E2C113CF;
	Fri, 22 Aug 2025 14:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755873856;
	bh=vG+nf0xIim3hpmGAUICKY+lIMGOSE9+9BxLqObN/z8Q=;
	h=Subject:To:Cc:From:Date:From;
	b=pBICrRzeRr+6VgEy/OvWo9sutgT15eVCiIa1P8rcFa2+5DLtcDkjjul5aTkjxroBt
	 VEcx0eEuuOFu7X+ohS/k6lJIo5j3sATyU+xPEpMRRS0ysX4/dnnfxIj3qYY48m2rt0
	 JuU/mBlGgQmFXuXZEVJ3mUsVbmK8mGI+w4BOaHuY=
Subject: FAILED: patch "[PATCH] mm/memory-failure: fix infinite UCE for VM_PFNMAP pfn" failed to apply to 5.15-stable tree
To: tujinjiang@huawei.com,akpm@linux-foundation.org,david@redhat.com,jane.chu@oracle.com,linmiaohe@huawei.com,nao.horiguchi@gmail.com,osalvador@suse.de,stable@vger.kernel.org,wangkefeng.wang@huawei.com,xueshuai@linux.alibaba.com,ziy@nvidia.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 22 Aug 2025 16:44:05 +0200
Message-ID: <2025082205-cinch-riverboat-7a85@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 2e6053fea379806269c4f7f5e36b523c9c0fb35c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025082205-cinch-riverboat-7a85@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2e6053fea379806269c4f7f5e36b523c9c0fb35c Mon Sep 17 00:00:00 2001
From: Jinjiang Tu <tujinjiang@huawei.com>
Date: Fri, 15 Aug 2025 15:32:09 +0800
Subject: [PATCH] mm/memory-failure: fix infinite UCE for VM_PFNMAP pfn

When memory_failure() is called for a already hwpoisoned pfn,
kill_accessing_process() will be called to kill current task.  However, if
the vma of the accessing vaddr is VM_PFNMAP, walk_page_range() will skip
the vma in walk_page_test() and return 0.

Before commit aaf99ac2ceb7 ("mm/hwpoison: do not send SIGBUS to processes
with recovered clean pages"), kill_accessing_process() will return EFAULT.
For x86, the current task will be killed in kill_me_maybe().

However, after this commit, kill_accessing_process() simplies return 0,
that means UCE is handled properly, but it doesn't actually.  In such
case, the user task will trigger UCE infinitely.

To fix it, add .test_walk callback for hwpoison_walk_ops to scan all vmas.

Link: https://lkml.kernel.org/r/20250815073209.1984582-1-tujinjiang@huawei.com
Fixes: aaf99ac2ceb7 ("mm/hwpoison: do not send SIGBUS to processes with recovered clean pages")
Signed-off-by: Jinjiang Tu <tujinjiang@huawei.com>
Acked-by: David Hildenbrand <david@redhat.com>
Acked-by: Miaohe Lin <linmiaohe@huawei.com>
Reviewed-by: Jane Chu <jane.chu@oracle.com>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Naoya Horiguchi <nao.horiguchi@gmail.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Shuai Xue <xueshuai@linux.alibaba.com>
Cc: Zi Yan <ziy@nvidia.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index e2e685b971bb..fc30ca4804bf 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -853,9 +853,17 @@ static int hwpoison_hugetlb_range(pte_t *ptep, unsigned long hmask,
 #define hwpoison_hugetlb_range	NULL
 #endif
 
+static int hwpoison_test_walk(unsigned long start, unsigned long end,
+			     struct mm_walk *walk)
+{
+	/* We also want to consider pages mapped into VM_PFNMAP. */
+	return 0;
+}
+
 static const struct mm_walk_ops hwpoison_walk_ops = {
 	.pmd_entry = hwpoison_pte_range,
 	.hugetlb_entry = hwpoison_hugetlb_range,
+	.test_walk = hwpoison_test_walk,
 	.walk_lock = PGWALK_RDLOCK,
 };
 


