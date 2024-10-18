Return-Path: <stable+bounces-86777-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59A229A37DC
	for <lists+stable@lfdr.de>; Fri, 18 Oct 2024 09:57:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8800B1C23BE3
	for <lists+stable@lfdr.de>; Fri, 18 Oct 2024 07:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80DC818C332;
	Fri, 18 Oct 2024 07:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Y1bzuP8m"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412081442F4
	for <stable@vger.kernel.org>; Fri, 18 Oct 2024 07:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729238261; cv=none; b=V6VbkWyFWrOMAoSFKCTZUBBZU3Ssz6G4aTrEILI1pdDIp/Uu32zM9rzXzozEO41laUOKhBlNTrVMGMwytdCiAzkq/erMbtygs+BlgLGKsBU7gH9TpJ8FTmt4EDWIdP1/dTuXuBLrL6X03agQR0YHI6ztqsEkZ4lv6vsTujxL4x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729238261; c=relaxed/simple;
	bh=RWpJKVIveKl0rdnR1QnaTJqLaF0xZ/O+DPLJTFjp/1s=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=YKtF01DFYqSi31QtUtXv/XwP6xhK6CBiJz4YgPwJ908sG+YCnwmxbBGzHZWDtb8AdTOg7FRQI+bplXHBiUypL0uThwT4P99ba7WJ5nF3EpdhlWLl0LA/DfkH4ErXWd/bxql8mWZN57LvdxvdwG9GLuBrqoY8PYBsIU+A9WaJHWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Y1bzuP8m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66BE1C4CEC3;
	Fri, 18 Oct 2024 07:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729238260;
	bh=RWpJKVIveKl0rdnR1QnaTJqLaF0xZ/O+DPLJTFjp/1s=;
	h=Subject:To:Cc:From:Date:From;
	b=Y1bzuP8mvrzndsLQIXl1SMihTl2EPFNMBU/XYMBkGGNN3u3Giug/KD9C7JnVhoAC4
	 be2O19Uc69PUD6ExapwzCh1UY/VeIsWO3uUa9GZ0/JJVBfEwBA2Z/6jGMg+HlXx1xn
	 uv6U1YAnGkdvizW3HDDKAQjpgDY1ktBjC8+WPHxU=
Subject: FAILED: patch "[PATCH] mm: don't install PMD mappings when THPs are disabled by the" failed to apply to 6.1-stable tree
To: david@redhat.com,akpm@linux-foundation.org,bfu@redhat.com,borntraeger@linux.ibm.com,frankja@linux.ibm.com,hughd@google.com,imbrenda@linux.ibm.com,ryan.roberts@arm.com,stable@vger.kernel.org,thuth@redhat.com,wangkefeng.wang@huawei.com,willy@infradead.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 18 Oct 2024 09:57:37 +0200
Message-ID: <2024101837-mammogram-headsman-2dec@gregkh>
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
git cherry-pick -x 2b0f922323ccfa76219bcaacd35cd50aeaa13592
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024101837-mammogram-headsman-2dec@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2b0f922323ccfa76219bcaacd35cd50aeaa13592 Mon Sep 17 00:00:00 2001
From: David Hildenbrand <david@redhat.com>
Date: Fri, 11 Oct 2024 12:24:45 +0200
Subject: [PATCH] mm: don't install PMD mappings when THPs are disabled by the
 hw/process/vma

We (or rather, readahead logic :) ) might be allocating a THP in the
pagecache and then try mapping it into a process that explicitly disabled
THP: we might end up installing PMD mappings.

This is a problem for s390x KVM, which explicitly remaps all PMD-mapped
THPs to be PTE-mapped in s390_enable_sie()->thp_split_mm(), before
starting the VM.

For example, starting a VM backed on a file system with large folios
supported makes the VM crash when the VM tries accessing such a mapping
using KVM.

Is it also a problem when the HW disabled THP using
TRANSPARENT_HUGEPAGE_UNSUPPORTED?  At least on x86 this would be the case
without X86_FEATURE_PSE.

In the future, we might be able to do better on s390x and only disallow
PMD mappings -- what s390x and likely TRANSPARENT_HUGEPAGE_UNSUPPORTED
really wants.  For now, fix it by essentially performing the same check as
would be done in __thp_vma_allowable_orders() or in shmem code, where this
works as expected, and disallow PMD mappings, making us fallback to PTE
mappings.

Link: https://lkml.kernel.org/r/20241011102445.934409-3-david@redhat.com
Fixes: 793917d997df ("mm/readahead: Add large folio readahead")
Signed-off-by: David Hildenbrand <david@redhat.com>
Reported-by: Leo Fu <bfu@redhat.com>
Tested-by: Thomas Huth <thuth@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Janosch Frank <frankja@linux.ibm.com>
Cc: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/memory.c b/mm/memory.c
index c0869a962ddd..30feedabc932 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4920,6 +4920,15 @@ vm_fault_t do_set_pmd(struct vm_fault *vmf, struct page *page)
 	pmd_t entry;
 	vm_fault_t ret = VM_FAULT_FALLBACK;
 
+	/*
+	 * It is too late to allocate a small folio, we already have a large
+	 * folio in the pagecache: especially s390 KVM cannot tolerate any
+	 * PMD mappings, but PTE-mapped THP are fine. So let's simply refuse any
+	 * PMD mappings if THPs are disabled.
+	 */
+	if (thp_disabled_by_hw() || vma_thp_disabled(vma, vma->vm_flags))
+		return ret;
+
 	if (!thp_vma_suitable_order(vma, haddr, PMD_ORDER))
 		return ret;
 


