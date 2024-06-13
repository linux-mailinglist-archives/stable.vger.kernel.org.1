Return-Path: <stable+bounces-50427-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C8739065C3
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 09:55:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 432401C2376A
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 07:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6F1A13CA8E;
	Thu, 13 Jun 2024 07:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Hin1Vm8L"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A5F13C9DE
	for <stable@vger.kernel.org>; Thu, 13 Jun 2024 07:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718265323; cv=none; b=NRXh9Xf7meQbFbc6lgT1DQHfotug8WmAK4gbdprDagRGHLHRWyZWVNCW6HlwHk6dKb27qHHPCInylV962IEkROPw7jMkOSdJLWz4wCFf5QKAT97QnCjLj2BG24mS2KXdBJVeCyhs8mitweDT/jnqN8rcn6J/TYGrIaNJR6nMNZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718265323; c=relaxed/simple;
	bh=y9AW3P2DGJuEiuI/P2nbMZPWyCuo4LFF8BonHE5rwXw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=c6yfEz+nIibRS0ZKEKCmX8XducooPWIM/et9X9gznSzt0SY5NgvBBEBQWK8meFfjsY4ZqhGXZAJClLrBNNNdTQsaCnP4xxtR2BLfG077jBw+SRsZGTR4FEzxO2zTKx9HJ9t4M+AHHrULT55RctgOM50f2cscGCV+MQ2WbBoV+Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Hin1Vm8L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 136E1C2BBFC;
	Thu, 13 Jun 2024 07:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718265323;
	bh=y9AW3P2DGJuEiuI/P2nbMZPWyCuo4LFF8BonHE5rwXw=;
	h=Subject:To:Cc:From:Date:From;
	b=Hin1Vm8LGtGh1VFLjlegDrCItnbdnAf4p1eHRPQci+0eQgb/D1Q1IzjsH7moCbhKz
	 SIz722kkgCIwUMjGjvp1tlU44yOrK0YY7vHhKpD9wC6gTUpBgqu6CA8IRysr5Txf/y
	 N8IcOl5Yj0Zk5RGJDzRLk7Hjnfp7OsW1LAg1T36U=
Subject: FAILED: patch "[PATCH] mm/hugetlb: pass correct order_per_bit to" failed to apply to 5.15-stable tree
To: fvdl@google.com,akpm@linux-foundation.org,david@redhat.com,m.szyprowski@samsung.com,muchun.song@linux.dev,roman.gushchin@linux.dev,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 13 Jun 2024 09:55:17 +0200
Message-ID: <2024061317-rework-obituary-d23b@gregkh>
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
git cherry-pick -x 55d134a7b499c77e7cfd0ee41046f3c376e791e5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024061317-rework-obituary-d23b@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

55d134a7b499 ("mm/hugetlb: pass correct order_per_bit to cma_declare_contiguous_nid")
a01f43901cfb ("hugetlb: be sure to free demoted CMA pages to CMA")
79dfc695525f ("hugetlb: add demote hugetlb page sysfs interfaces")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 55d134a7b499c77e7cfd0ee41046f3c376e791e5 Mon Sep 17 00:00:00 2001
From: Frank van der Linden <fvdl@google.com>
Date: Thu, 4 Apr 2024 16:25:15 +0000
Subject: [PATCH] mm/hugetlb: pass correct order_per_bit to
 cma_declare_contiguous_nid

The hugetlb_cma code passes 0 in the order_per_bit argument to
cma_declare_contiguous_nid (the alignment, computed using the page order,
is correctly passed in).

This causes a bit in the cma allocation bitmap to always represent a 4k
page, making the bitmaps potentially very large, and slower.

It would create bitmaps that would be pretty big.  E.g.  for a 4k page
size on x86, hugetlb_cma=64G would mean a bitmap size of (64G / 4k) / 8
== 2M.  With HUGETLB_PAGE_ORDER as order_per_bit, as intended, this
would be (64G / 2M) / 8 == 4k.  So, that's quite a difference.

Also, this restricted the hugetlb_cma area to ((PAGE_SIZE <<
MAX_PAGE_ORDER) * 8) * PAGE_SIZE (e.g.  128G on x86) , since
bitmap_alloc uses normal page allocation, and is thus restricted by
MAX_PAGE_ORDER.  Specifying anything about that would fail the CMA
initialization.

So, correctly pass in the order instead.

Link: https://lkml.kernel.org/r/20240404162515.527802-2-fvdl@google.com
Fixes: cf11e85fc08c ("mm: hugetlb: optionally allocate gigantic hugepages using cma")
Signed-off-by: Frank van der Linden <fvdl@google.com>
Acked-by: Roman Gushchin <roman.gushchin@linux.dev>
Acked-by: David Hildenbrand <david@redhat.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Muchun Song <muchun.song@linux.dev>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 228c886c46c1..5dc3f5ea3a2e 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -7794,9 +7794,9 @@ void __init hugetlb_cma_reserve(int order)
 		 * huge page demotion.
 		 */
 		res = cma_declare_contiguous_nid(0, size, 0,
-						PAGE_SIZE << HUGETLB_PAGE_ORDER,
-						 0, false, name,
-						 &hugetlb_cma[nid], nid);
+					PAGE_SIZE << HUGETLB_PAGE_ORDER,
+					HUGETLB_PAGE_ORDER, false, name,
+					&hugetlb_cma[nid], nid);
 		if (res) {
 			pr_warn("hugetlb_cma: reservation failed: err %d, node %d",
 				res, nid);


