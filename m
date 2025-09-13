Return-Path: <stable+bounces-179450-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7558FB560BB
	for <lists+stable@lfdr.de>; Sat, 13 Sep 2025 14:25:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AAE3C7B1529
	for <lists+stable@lfdr.de>; Sat, 13 Sep 2025 12:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 435BE2ECD05;
	Sat, 13 Sep 2025 12:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="okecxrv8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A842ECD07
	for <stable@vger.kernel.org>; Sat, 13 Sep 2025 12:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757766302; cv=none; b=AZpK9seTa5laVVcL7bS+NHS1S1U5nUkywEyQQ9qB7QnAz8vYOeZ/VIIDBkp84V9M79eQUIQeJ3FGME0kgwXEKcpr9lHXu7HbYSmMkK66HQoZbXsk+FXV2fzR5IQDprCaY6v/b5JpHnwPXiRckgw3WI9q4cRS+xgTEYjPqpKn1p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757766302; c=relaxed/simple;
	bh=Yf51P1oOYBnpJwdNQPoGhon5rJahkHdxK66RKrfdgA4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Jv0Y7Xc2CoYTnt6PskhMzbUZSmVFvDZVSb1e4p1t1tAz3/jEP4Jz6InKBX6tB+lU0K63XbIjC4+8y6mvSIqMuhXbqriNgbOQXZxz1MbrH0AUNzXILgLCuKV7FIgHY0peSRb1kzOybn4Ovgsk+vpXbEB2Kx4DrLaxex5uPfjdVWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=okecxrv8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B7ADC4CEEB;
	Sat, 13 Sep 2025 12:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757766301;
	bh=Yf51P1oOYBnpJwdNQPoGhon5rJahkHdxK66RKrfdgA4=;
	h=Subject:To:Cc:From:Date:From;
	b=okecxrv8WmILf3+GO2iZf90RSZDoVxS1EH0nOreKeXjW4MFOpJ+cpomdcXlT59DWx
	 XW+lW6JPUVndoJRZOdmuI/GEeH+cAm6SJ+t/H0ydj86hxUjyMmhFDjdpyPrHtUR5L0
	 7wrrKoC+b4w5dhF5l9eFuCKb9Yv9vnHC7EZdjv7g=
Subject: FAILED: patch "[PATCH] mm/khugepaged: fix the address passed to notifier on testing" failed to apply to 5.15-stable tree
To: richard.weiyang@gmail.com,Liam.Howlett@oracle.com,akpm@linux-foundation.org,baohua@kernel.org,baolin.wang@linux.alibaba.com,david@redhat.com,dev.jain@arm.com,lorenzo.stoakes@oracle.com,npache@redhat.com,ryan.roberts@arm.com,stable@vger.kernel.org,ziy@nvidia.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 13 Sep 2025 14:24:45 +0200
Message-ID: <2025091345-oblong-ambiance-8200@gregkh>
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
git cherry-pick -x 394bfac1c7f7b701c2c93834c5761b9c9ceeebcf
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025091345-oblong-ambiance-8200@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

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


