Return-Path: <stable+bounces-172441-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D8E27B31CAC
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 16:50:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D0B01D047DE
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 14:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52DFC312819;
	Fri, 22 Aug 2025 14:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DM6jPCx/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00AD930AAD2
	for <stable@vger.kernel.org>; Fri, 22 Aug 2025 14:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755873848; cv=none; b=VNZsQWyXTq1AZ3ihFnCaGmZ71o8FodMUHKsgPodBQqMlhCs3DVWvgv9UpFQRZJgFM4elKNg0Qx9wOTFPutlXvyZMnWBrAw1X2zYJPHTaJFEHBxNiis6zXzDS2vkVSddtq9axnJ2Bc5kfxjI3wgNTbAZxlihWA6VmQi1rbMrSyS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755873848; c=relaxed/simple;
	bh=P46cp1o1khui6/DeUeJrmVFBNCPP4UotYa96YnE1dqQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=F9vdiXk0+RPUwA79uv3Bp0JlGnAJYvMZ3z/Cee6ZIzAv1IoiHRGwyY3SRGQKinHp/F1DYUaNc9NQY6bGW5hVAKq1zRy2UCwse9TghmsBWgsjYZ1LgLVVZW3iil/KKNkxRbmHwZVobY+a9EqT7jY4WBFUocUYjF/I6xGvq3wooyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DM6jPCx/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46C91C4CEED;
	Fri, 22 Aug 2025 14:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755873847;
	bh=P46cp1o1khui6/DeUeJrmVFBNCPP4UotYa96YnE1dqQ=;
	h=Subject:To:Cc:From:Date:From;
	b=DM6jPCx/25rPdCCXU6Wi7AtSjs3CT1Khkjjme4eMOKwngVrhS9tLX9UiHjmdUTPXm
	 RwG1su5HAdlz7fMj/Wzvu5w2EeS4tUbprQ5XGiMou6f6V0jh4nO1xzCs4meudUoWmW
	 0dvaESjLB9bCkASOWLvDzIrHXRLwlMjB1fmFAU2Q=
Subject: FAILED: patch "[PATCH] mm/memory-failure: fix infinite UCE for VM_PFNMAP pfn" failed to apply to 6.1-stable tree
To: tujinjiang@huawei.com,akpm@linux-foundation.org,david@redhat.com,jane.chu@oracle.com,linmiaohe@huawei.com,nao.horiguchi@gmail.com,osalvador@suse.de,stable@vger.kernel.org,wangkefeng.wang@huawei.com,xueshuai@linux.alibaba.com,ziy@nvidia.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 22 Aug 2025 16:44:04 +0200
Message-ID: <2025082204-copied-affecting-d945@gregkh>
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
git cherry-pick -x 2e6053fea379806269c4f7f5e36b523c9c0fb35c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025082204-copied-affecting-d945@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

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
 


