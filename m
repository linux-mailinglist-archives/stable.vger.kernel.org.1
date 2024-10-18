Return-Path: <stable+bounces-86776-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD239A37A6
	for <lists+stable@lfdr.de>; Fri, 18 Oct 2024 09:53:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C675F1F25541
	for <lists+stable@lfdr.de>; Fri, 18 Oct 2024 07:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6568189BA2;
	Fri, 18 Oct 2024 07:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BPjvQUVw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75ED2905
	for <stable@vger.kernel.org>; Fri, 18 Oct 2024 07:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729237981; cv=none; b=DCLVf0G0dwx1+6vDHzsHdn4AYLinTE2y1dKRsilPWoX+em3De2jhZ9A7s4U/ZqNqsVKakVk4gphNLFBv4KKkpOVACsCi3dpS2TjvYaIkdiOD/LYbd+VrxyGq1lQPypd9auMIK4/HM9ed9zQuwB8fg0jEi0nuaPjeMwkxsPjjZac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729237981; c=relaxed/simple;
	bh=CFw0iXXJWmF+4l69A8eGpwRoqg6GARK2LdA/W3WZjgc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=uP4Ad1vYHiHiw7y976oGCD05PoouvoqMymwtb+Lj+mHeF+BYdG9xWltDYAaISntu9YF0nlRBQj0oo/r1kMRpKlnUtWlbq571g4ILp0YEYc++6Pdy6gNmrIfkZS3EESOoKi54ROnphTkwetZ5PNQ5q63Zb2nCW9+TxIj17HAxIUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BPjvQUVw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29E82C4CEC3;
	Fri, 18 Oct 2024 07:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729237981;
	bh=CFw0iXXJWmF+4l69A8eGpwRoqg6GARK2LdA/W3WZjgc=;
	h=Subject:To:Cc:From:Date:From;
	b=BPjvQUVwobOVJ0O+YHOueFH5emASaG5HFBQaCqngTK/fHXbwCAKBtqxDbgE7jhQg5
	 zEorQbzSj/mDoR+SdIrIhl9mKA7/e61HPsHQic8JM0n5MurWACFcCa7adfJXzOrVRo
	 qDD4bWsTzchdGcNurPVbx9pBIdn67YS/rueYEuXY=
Subject: FAILED: patch "[PATCH] mm/swapfile: skip HugeTLB pages for unuse_vma" failed to apply to 4.19-stable tree
To: liushixin2@huawei.com,akpm@linux-foundation.org,muchun.song@linux.dev,nao.horiguchi@gmail.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 18 Oct 2024 09:52:58 +0200
Message-ID: <2024101858-rewire-vocation-c981@gregkh>
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
git cherry-pick -x 7528c4fb1237512ee18049f852f014eba80bbe8d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024101858-rewire-vocation-c981@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7528c4fb1237512ee18049f852f014eba80bbe8d Mon Sep 17 00:00:00 2001
From: Liu Shixin <liushixin2@huawei.com>
Date: Tue, 15 Oct 2024 09:45:21 +0800
Subject: [PATCH] mm/swapfile: skip HugeTLB pages for unuse_vma

I got a bad pud error and lost a 1GB HugeTLB when calling swapoff.  The
problem can be reproduced by the following steps:

 1. Allocate an anonymous 1GB HugeTLB and some other anonymous memory.
 2. Swapout the above anonymous memory.
 3. run swapoff and we will get a bad pud error in kernel message:

  mm/pgtable-generic.c:42: bad pud 00000000743d215d(84000001400000e7)

We can tell that pud_clear_bad is called by pud_none_or_clear_bad in
unuse_pud_range() by ftrace.  And therefore the HugeTLB pages will never
be freed because we lost it from page table.  We can skip HugeTLB pages
for unuse_vma to fix it.

Link: https://lkml.kernel.org/r/20241015014521.570237-1-liushixin2@huawei.com
Fixes: 0fe6e20b9c4c ("hugetlb, rmap: add reverse mapping for hugepage")
Signed-off-by: Liu Shixin <liushixin2@huawei.com>
Acked-by: Muchun Song <muchun.song@linux.dev>
Cc: Naoya Horiguchi <nao.horiguchi@gmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/swapfile.c b/mm/swapfile.c
index eb782fcd5627..b0915f3fab31 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -2313,7 +2313,7 @@ static int unuse_mm(struct mm_struct *mm, unsigned int type)
 
 	mmap_read_lock(mm);
 	for_each_vma(vmi, vma) {
-		if (vma->anon_vma) {
+		if (vma->anon_vma && !is_vm_hugetlb_page(vma)) {
 			ret = unuse_vma(vma, type);
 			if (ret)
 				break;


