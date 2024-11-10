Return-Path: <stable+bounces-92035-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B2C9C3103
	for <lists+stable@lfdr.de>; Sun, 10 Nov 2024 07:08:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29586281C9F
	for <lists+stable@lfdr.de>; Sun, 10 Nov 2024 06:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AE8214658D;
	Sun, 10 Nov 2024 06:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="cqh99Dp8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD41113D29A;
	Sun, 10 Nov 2024 06:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731218933; cv=none; b=HFsfNQaabYOT+spHPFd/BgTw/b38Eno/2to1OurJt8VZs1GaXmqfKW3O9JZcpRFpRMB02UGWPC9e2vJh5qSJayS3hN0q/z9xvp/p04rHY6wJDT/NHXAZukS/tBeP2UF5CgA28M64py93OEDJIyDEu+KVCWvF8sAOpo8q8ZS0ygk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731218933; c=relaxed/simple;
	bh=wy79TuJ2a/ajLjOa8f7cpFQV6aT8x76jlquZrtIaC+8=;
	h=Date:To:From:Subject:Message-Id; b=lBCWw6IXwCVJGH3k5LyG2GtxWYnGk65rHkN2DFubTbIYp5WOkMpaYp1+a8OuG4rHSujYiO850iWiLUhC3emmnzmLMohQ0CevpIz8RUE098hXX9u7+yowwfYajNvALVglbM7orWj3HhzRrE2UldZWaDR9HsviY7Z+jsIx6ocxIVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=cqh99Dp8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BAB3C4CECD;
	Sun, 10 Nov 2024 06:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1731218932;
	bh=wy79TuJ2a/ajLjOa8f7cpFQV6aT8x76jlquZrtIaC+8=;
	h=Date:To:From:Subject:From;
	b=cqh99Dp82rJRhtJhXw44coKkK7qUxyzLJNcB3xVCYuShWenveZnpcTlUaRfze+APi
	 PXOJ1TWbK4fuAVs902UDpnEbachFvac7zF1DXvD/2hMMZvtNLuFFnwUQj09H63SUH5
	 tSn0y9NjrxUswXi7uwkebVVcJ+C+ZrX+wnd6Tmqo=
Date: Sat, 09 Nov 2024 22:08:51 -0800
To: mm-commits@vger.kernel.org,stable@vger.kernel.org,Liam.Howlett@Oracle.com,thehajime@gmail.com,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: + nommu-pass-null-argument-to-vma_iter_prealloc.patch added to mm-hotfixes-unstable branch
Message-Id: <20241110060852.3BAB3C4CECD@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>


The patch titled
     Subject: nommu: pass NULL argument to vma_iter_prealloc()
has been added to the -mm mm-hotfixes-unstable branch.  Its filename is
     nommu-pass-null-argument-to-vma_iter_prealloc.patch

This patch will shortly appear at
     https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/nommu-pass-null-argument-to-vma_iter_prealloc.patch

This patch will later appear in the mm-hotfixes-unstable branch at
    git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

Before you just go and hit "reply", please:
   a) Consider who else should be cc'ed
   b) Prefer to cc a suitable mailing list as well
   c) Ideally: find the original patch on the mailing list and do a
      reply-to-all to that, adding suitable additional cc's

*** Remember to use Documentation/process/submit-checklist.rst when testing your code ***

The -mm tree is included into linux-next via the mm-everything
branch at git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
and is updated there every 2-3 working days

------------------------------------------------------
From: Hajime Tazaki <thehajime@gmail.com>
Subject: nommu: pass NULL argument to vma_iter_prealloc()
Date: Sat, 9 Nov 2024 07:28:34 +0900

When deleting a vma entry from a maple tree, it has to pass NULL to
vma_iter_prealloc() in order to calculate internal state of the tree, but
it passed a wrong argument.  As a result, nommu kernels crashed upon
accessing a vma iterator, such as acct_collect() reading the size of vma
entries after do_munmap().

This commit fixes this issue by passing a right argument to the
preallocation call.

Link: https://lkml.kernel.org/r/20241108222834.3625217-1-thehajime@gmail.com
Fixes: b5df09226450 ("mm: set up vma iterator for vma_iter_prealloc() calls")
Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
Reviewed-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/nommu.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/mm/nommu.c~nommu-pass-null-argument-to-vma_iter_prealloc
+++ a/mm/nommu.c
@@ -573,7 +573,7 @@ static int delete_vma_from_mm(struct vm_
 	VMA_ITERATOR(vmi, vma->vm_mm, vma->vm_start);
 
 	vma_iter_config(&vmi, vma->vm_start, vma->vm_end);
-	if (vma_iter_prealloc(&vmi, vma)) {
+	if (vma_iter_prealloc(&vmi, NULL)) {
 		pr_warn("Allocation of vma tree for process %d failed\n",
 		       current->pid);
 		return -ENOMEM;
_

Patches currently in -mm which might be from thehajime@gmail.com are

nommu-pass-null-argument-to-vma_iter_prealloc.patch


