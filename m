Return-Path: <stable+bounces-179448-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6297AB560B9
	for <lists+stable@lfdr.de>; Sat, 13 Sep 2025 14:25:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6093565954
	for <lists+stable@lfdr.de>; Sat, 13 Sep 2025 12:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C38A526057A;
	Sat, 13 Sep 2025 12:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cErB0qsG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839542E8DFF
	for <stable@vger.kernel.org>; Sat, 13 Sep 2025 12:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757766296; cv=none; b=b9aJqC7FHvYeFMq6TuB6wc4rs1+AdmauOpmY+yIBurVRuwx9i8BGFvBfM4yobYl19bjMPnt12+73zeK46iWZf15/ef2FJUaA2tvQSXh8JEA4XA1ylUKnKlNDAWSKf6Gurm3WdqcaN3XSebVMsF5NbywE914bwDrExTi4oy7X6+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757766296; c=relaxed/simple;
	bh=QiFPts0erJGC/oz5hQ/etNFFrwn9X3QWUM9rFG12Yxo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=EZcvMCU6VE9rS559HDU4MH9b/3b5qhETxYRzZ0mH4RwVubZmtUz0Vk+1fqZTrTvhwdZc6AK5ziPOyI3WpNnxD28cqGUWOioh9QRliq4WZMRs+BYYngM05+trmBeiWv0RlilCvww6M7xGk2DCV4Oj75acAzyV+omRy6DsMtLc/lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cErB0qsG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5F95C4CEEB;
	Sat, 13 Sep 2025 12:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757766296;
	bh=QiFPts0erJGC/oz5hQ/etNFFrwn9X3QWUM9rFG12Yxo=;
	h=Subject:To:Cc:From:Date:From;
	b=cErB0qsGvTlH2KW/tLNcDd0ztqXOHCE9+EWQ0c43qU7thgW2q0nzlBJQGNFXAZJdO
	 alosIAHIDi2cgrrYtPJzRitRz9N7j9/NISb1kkS9R1tMKpPS8NyNowLJJ4xpDrG6eI
	 mHxlixeRjfBZdF41kOWf/I7r/xr0193PMmD+Pj7A=
Subject: FAILED: patch "[PATCH] mm/khugepaged: fix the address passed to notifier on testing" failed to apply to 6.1-stable tree
To: richard.weiyang@gmail.com,Liam.Howlett@oracle.com,akpm@linux-foundation.org,baohua@kernel.org,baolin.wang@linux.alibaba.com,david@redhat.com,dev.jain@arm.com,lorenzo.stoakes@oracle.com,npache@redhat.com,ryan.roberts@arm.com,stable@vger.kernel.org,ziy@nvidia.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 13 Sep 2025 14:24:44 +0200
Message-ID: <2025091344-pronounce-zoning-2e65@gregkh>
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
git cherry-pick -x 394bfac1c7f7b701c2c93834c5761b9c9ceeebcf
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025091344-pronounce-zoning-2e65@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 394bfac1c7f7b701c2c93834c5761b9c9ceeebcf Mon Sep 17 00:00:00 2001
From: Wei Yang <richard.weiyang@gmail.com>
Date: Fri, 22 Aug 2025 06:33:18 +0000
Subject: [PATCH] mm/khugepaged: fix the address passed to notifier on testing
 young

Commit 8ee53820edfd ("thp: mmu_notifier_test_young") introduced
mmu_notifier_test_young(), but we are passing the wrong address.
In xxx_scan_pmd(), the actual iteration address is "_address" not
"address".  We seem to misuse the variable on the very beginning.

Change it to the right one.

[akpm@linux-foundation.org fix whitespace, per everyone]
Link: https://lkml.kernel.org/r/20250822063318.11644-1-richard.weiyang@gmail.com
Fixes: 8ee53820edfd ("thp: mmu_notifier_test_young")
Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
Reviewed-by: Dev Jain <dev.jain@arm.com>
Reviewed-by: Zi Yan <ziy@nvidia.com>
Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Liam R. Howlett <Liam.Howlett@oracle.com>
Cc: Nico Pache <npache@redhat.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Barry Song <baohua@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 6b40bdfd224c..b486c1d19b2d 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1417,8 +1417,8 @@ static int hpage_collapse_scan_pmd(struct mm_struct *mm,
 		 */
 		if (cc->is_khugepaged &&
 		    (pte_young(pteval) || folio_test_young(folio) ||
-		     folio_test_referenced(folio) || mmu_notifier_test_young(vma->vm_mm,
-								     address)))
+		     folio_test_referenced(folio) ||
+		     mmu_notifier_test_young(vma->vm_mm, _address)))
 			referenced++;
 	}
 	if (!writable) {


