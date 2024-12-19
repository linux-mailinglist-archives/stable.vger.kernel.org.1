Return-Path: <stable+bounces-105262-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A4C9F732A
	for <lists+stable@lfdr.de>; Thu, 19 Dec 2024 04:05:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32F691893853
	for <lists+stable@lfdr.de>; Thu, 19 Dec 2024 03:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B47E2143871;
	Thu, 19 Dec 2024 03:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Sww8EWxA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA4F86350;
	Thu, 19 Dec 2024 03:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734577523; cv=none; b=lV1q1SfRcHDPhoI9aq8PszOVl2xAqnDCS0bMkIS0WvoG7WESSJhKuUa8QaU5K9zX3DsFjXWlWWl0Tx3dYhbPoMNBtimvZZFD4RCdLr14t4jJIi7Y0ZeJW1ru4X003j6lda6gIKzXpaEtddE5iSlEUdcrwI5/tZ77fU56sJtCxec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734577523; c=relaxed/simple;
	bh=M0E2r66ewwqWqyGEnV+GLQRv6fIxecVSFEeWHQxetKQ=;
	h=Date:To:From:Subject:Message-Id; b=UDSParx0J7Gx5OQVMiw106kPczEut4M6n62QYM4TRRbz4wfmgfOMnyQK/LEgxZ6+JfGivRp8BCS9MJ8I5gExB1IMQ6wykOKEnCLXbNhOFDM8seQYqxNZl+2+Xq5FMYY21s2XnmjiwL71L3srJZNrbNZqFySkexy6uklQ9oVVqrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Sww8EWxA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00019C4CECD;
	Thu, 19 Dec 2024 03:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1734577523;
	bh=M0E2r66ewwqWqyGEnV+GLQRv6fIxecVSFEeWHQxetKQ=;
	h=Date:To:From:Subject:From;
	b=Sww8EWxA4hvChlvrIq2JDENczlWuEcg2ORDeU9A11QItN2TkM2nBR0uEV3O1SyDtl
	 fxr4AUZ2wVqGlHklaQQIfgI23xTPpVVVCsCAh7LUCDzAdABmOBpjCgUbcklHvPIn1Z
	 uUHSV2I0Y++KsTrcITZVPLz56/QnvrSNDsUkHCkg=
Date: Wed, 18 Dec 2024 19:05:22 -0800
To: mm-commits@vger.kernel.org,ying.huang@intel.com,willy@infradead.org,stable@vger.kernel.org,muchun.song@linux.dev,david@redhat.com,wangkefeng.wang@huawei.com,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: [merged mm-hotfixes-stable] mm-use-aligned-address-in-copy_user_gigantic_page.patch removed from -mm tree
Message-Id: <20241219030523.00019C4CECD@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>


The quilt patch titled
     Subject: mm: use aligned address in copy_user_gigantic_page()
has been removed from the -mm tree.  Its filename was
     mm-use-aligned-address-in-copy_user_gigantic_page.patch

This patch was dropped because it was merged into the mm-hotfixes-stable branch
of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

------------------------------------------------------
From: Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: mm: use aligned address in copy_user_gigantic_page()
Date: Mon, 28 Oct 2024 22:56:56 +0800

In current kernel, hugetlb_wp() calls copy_user_large_folio() with the
fault address.  Where the fault address may be not aligned with the huge
page size.  Then, copy_user_large_folio() may call
copy_user_gigantic_page() with the address, while
copy_user_gigantic_page() requires the address to be huge page size
aligned.  So, this may cause memory corruption or information leak,
addtional, use more obvious naming 'addr_hint' instead of 'addr' for
copy_user_gigantic_page().

Link: https://lkml.kernel.org/r/20241028145656.932941-2-wangkefeng.wang@huawei.com
Fixes: 530dd9926dc1 ("mm: memory: improve copy_user_large_folio()")
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Cc: Huang Ying <ying.huang@intel.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Muchun Song <muchun.song@linux.dev>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/hugetlb.c |    5 ++---
 mm/memory.c  |    5 +++--
 2 files changed, 5 insertions(+), 5 deletions(-)

--- a/mm/hugetlb.c~mm-use-aligned-address-in-copy_user_gigantic_page
+++ a/mm/hugetlb.c
@@ -5340,7 +5340,7 @@ again:
 					break;
 				}
 				ret = copy_user_large_folio(new_folio, pte_folio,
-						ALIGN_DOWN(addr, sz), dst_vma);
+							    addr, dst_vma);
 				folio_put(pte_folio);
 				if (ret) {
 					folio_put(new_folio);
@@ -6643,8 +6643,7 @@ int hugetlb_mfill_atomic_pte(pte_t *dst_
 			*foliop = NULL;
 			goto out;
 		}
-		ret = copy_user_large_folio(folio, *foliop,
-					    ALIGN_DOWN(dst_addr, size), dst_vma);
+		ret = copy_user_large_folio(folio, *foliop, dst_addr, dst_vma);
 		folio_put(*foliop);
 		*foliop = NULL;
 		if (ret) {
--- a/mm/memory.c~mm-use-aligned-address-in-copy_user_gigantic_page
+++ a/mm/memory.c
@@ -6852,13 +6852,14 @@ void folio_zero_user(struct folio *folio
 }
 
 static int copy_user_gigantic_page(struct folio *dst, struct folio *src,
-				   unsigned long addr,
+				   unsigned long addr_hint,
 				   struct vm_area_struct *vma,
 				   unsigned int nr_pages)
 {
-	int i;
+	unsigned long addr = ALIGN_DOWN(addr_hint, folio_size(dst));
 	struct page *dst_page;
 	struct page *src_page;
+	int i;
 
 	for (i = 0; i < nr_pages; i++) {
 		dst_page = folio_page(dst, i);
_

Patches currently in -mm which might be from wangkefeng.wang@huawei.com are

mm-dont-try-thp-align-for-fs-without-get_unmapped_area.patch


