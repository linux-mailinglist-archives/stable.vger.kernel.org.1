Return-Path: <stable+bounces-52164-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E169086BD
	for <lists+stable@lfdr.de>; Fri, 14 Jun 2024 10:51:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC07D1C21AD5
	for <lists+stable@lfdr.de>; Fri, 14 Jun 2024 08:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 249CA190470;
	Fri, 14 Jun 2024 08:51:09 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66AB187546
	for <stable@vger.kernel.org>; Fri, 14 Jun 2024 08:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718355069; cv=none; b=rEvOpt7JKWlbKcuN+8OvP8ZQnAzBSIwwl/Y+tp00xyEB+iPUj4myAQzs1aEqY9SJOc6Tqc+NzpNjWyMviheo/ANy9ukfZmyxDy/n04wjBzze/NFa1Xq7hu7BYd0myuuxRJc8NXT+NxJUxyM/D00HCDsQ2rUSxVk5YJr0agGptNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718355069; c=relaxed/simple;
	bh=pYD9i/lxDw5B8ce15enfoVfcDt2/Cm5hQueyX/ZzqqM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gJc0lixzdp+GwiXR3wfrd1SEvvQKbLFpXhnPec6zwOKLY7LEBP2rEgJW0DNk0bXEV8pY78XcRQS0Ws7zbkblSlO3peBYQ2EjG+R6zjZ2I0ZW4e85aUQFCydkrU0AH4bRTmISepCJWoYe5dzhLWBI4QXo/N5EFPlclgnh/yZl53E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
From: Sam James <sam@gentoo.org>
To: stable@vger.kernel.org
Cc: Greg KH <gregkh@linuxfoundation.org>,
	leah.rumancik@gmail.com,
	Miaohe Lin <linmiaohe@huawei.com>,
	Sam James <sam@gentoo.org>
Subject: [PATCH 6.6] Revert "fork: defer linking file vma until vma is fully initialized"
Date: Fri, 14 Jun 2024 09:50:59 +0100
Message-ID: <20240614085102.3198934-1-sam@gentoo.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit cec11fa2eb512ebe3a459c185f4aca1d44059bbf.

The backport is incomplete and causes xfstests failures. The consequences
of the incomplete backport seem worse than the original issue, so pick
the lesser evil and revert until a full backport is ready.

Link: https://lore.kernel.org/stable/20240604004751.3883227-1-leah.rumancik@gmail.com/
Reported-by: Leah Rumancik <leah.rumancik@gmail.com>
Signed-off-by: Sam James <sam@gentoo.org>
---
 kernel/fork.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index 2eab916b504bf..177ce7438db6b 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -727,15 +727,6 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
 		} else if (anon_vma_fork(tmp, mpnt))
 			goto fail_nomem_anon_vma_fork;
 		vm_flags_clear(tmp, VM_LOCKED_MASK);
-		/*
-		 * Copy/update hugetlb private vma information.
-		 */
-		if (is_vm_hugetlb_page(tmp))
-			hugetlb_dup_vma_private(tmp);
-
-		if (tmp->vm_ops && tmp->vm_ops->open)
-			tmp->vm_ops->open(tmp);
-
 		file = tmp->vm_file;
 		if (file) {
 			struct address_space *mapping = file->f_mapping;
@@ -752,6 +743,12 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
 			i_mmap_unlock_write(mapping);
 		}
 
+		/*
+		 * Copy/update hugetlb private vma information.
+		 */
+		if (is_vm_hugetlb_page(tmp))
+			hugetlb_dup_vma_private(tmp);
+
 		/* Link the vma into the MT */
 		if (vma_iter_bulk_store(&vmi, tmp))
 			goto fail_nomem_vmi_store;
@@ -760,6 +757,9 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
 		if (!(tmp->vm_flags & VM_WIPEONFORK))
 			retval = copy_page_range(tmp, mpnt);
 
+		if (tmp->vm_ops && tmp->vm_ops->open)
+			tmp->vm_ops->open(tmp);
+
 		if (retval)
 			goto loop_out;
 	}
-- 
2.45.2


