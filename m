Return-Path: <stable+bounces-179449-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38EB0B560BF
	for <lists+stable@lfdr.de>; Sat, 13 Sep 2025 14:25:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20D661B279B2
	for <lists+stable@lfdr.de>; Sat, 13 Sep 2025 12:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B7462EC572;
	Sat, 13 Sep 2025 12:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nIfss0nL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9102EC570
	for <stable@vger.kernel.org>; Sat, 13 Sep 2025 12:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757766299; cv=none; b=etB2eTliAj6gOxEaTA3JYFZvyWvI4NXvCMsVAq8dcZa4QyAmuMJy4pUqw2tFvKRFt9dxWMDxrtfnHhfVoiQD2cuJyy0BqfA3Wur7RoWcDDGWP4iDRmq83AEBm8HgaQTtEcRUao8vXPIh4nkAEE01a9i+ecBQ4dRdl7L3irBS57A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757766299; c=relaxed/simple;
	bh=nTwicFe6U6XsBOdkykiehzgH6foMkevg4/d9WH46xQ4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=GXPjsMWsYHAJeilLXS+I/B5Y/qCwGAZV/Snv30uSMik6mx7rxzbxQhg8wtljmKI86ibQupeTRkE3hSXl51dwb/FjONvpKAGoK0OVBexQxf/tYjTapLrJR8GAkYQSJvr28OdjvWQIq0S3rh7sgpNB3xrCHY1hkWBPSSBJOnefEck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nIfss0nL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80375C4CEEB;
	Sat, 13 Sep 2025 12:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757766298;
	bh=nTwicFe6U6XsBOdkykiehzgH6foMkevg4/d9WH46xQ4=;
	h=Subject:To:Cc:From:Date:From;
	b=nIfss0nLQGe1TRlJgyMFe+KZH/ip2Rq7DoU8WME7NHcHhI8Zglww3EjpJqoRBEQhV
	 hyp3s22ojVd13JTlL3cL7/3eGm2qGat1a5sQfy6Uc9U0E6h2PKsAvMyOsscnyehWFo
	 0bwCBQrPvYBN9HGmVl+D/Foufi94rjpWr8VBKMrI=
Subject: FAILED: patch "[PATCH] mm/khugepaged: fix the address passed to notifier on testing" failed to apply to 5.10-stable tree
To: richard.weiyang@gmail.com,Liam.Howlett@oracle.com,akpm@linux-foundation.org,baohua@kernel.org,baolin.wang@linux.alibaba.com,david@redhat.com,dev.jain@arm.com,lorenzo.stoakes@oracle.com,npache@redhat.com,ryan.roberts@arm.com,stable@vger.kernel.org,ziy@nvidia.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 13 Sep 2025 14:24:45 +0200
Message-ID: <2025091345-baton-doorstep-d211@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 394bfac1c7f7b701c2c93834c5761b9c9ceeebcf
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025091345-baton-doorstep-d211@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

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


