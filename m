Return-Path: <stable+bounces-55937-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B34591A2C4
	for <lists+stable@lfdr.de>; Thu, 27 Jun 2024 11:40:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30ADB2846C9
	for <lists+stable@lfdr.de>; Thu, 27 Jun 2024 09:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1012C13AA4C;
	Thu, 27 Jun 2024 09:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="TReDolmK"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FF4F13A41D;
	Thu, 27 Jun 2024 09:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719481204; cv=none; b=FwXIYOLlBkOSO6pQ5m3kTikqGk6bYqkOrQvFrxa0zKQFYsdtL8YOvurHjdriHVph8ygP0V9Es6h8RNMoQtxLG7t/bjpfjzh4X/lshZCHKgGijK5LZLru7E+t6wm6izSQx/nhFrCq7QmdMD1hDamGjsqLVJXKSRTU1+5h7jJ/Xv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719481204; c=relaxed/simple;
	bh=ojlYo42aYoswPCWmxbUpPQOhP56Wko77wa7TwJSuzpI=;
	h=From:To:Cc:Subject:Date:Message-Id; b=RRjnMqC+ADuqI86iy9tUzXu6hxDt0TMjPDhAhZ69a6ZP9GHzuAG/tthhDxtDUbl4Sy1ajWe1MQ9L12hlFt7ZtrB9+Fsa17FskREswambvGV95HSJR/T7IsBt/9sP1SkXeBIHJik5L89efE3ri1ZZ1yVHiLd4Q6NyZJzShdytqc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=TReDolmK; arc=none smtp.client-ip=220.197.31.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=6xGCK3vdlcLd1W/Bs/
	Fp3r0CvMSGjItZew3IZE6at+k=; b=TReDolmKAyQPbR9HCYIBi4m+eFXTCT1XmE
	thQEWPhM+ayAXUtvfUPQDO0x94AmLBJ9ZxXTgJAVXbe8ysCjh2W2zp/YyYguJ+0n
	UC3XHK0Wz86ulmpYE2zJEFV5SHGZRTkOl/OTGzAZ/bvwwqLPTN9/tODdPvT3P0Fp
	+DJOhh4gY=
Received: from hg-OptiPlex-7040.hygon.cn (unknown [118.242.3.34])
	by gzga-smtp-mta-g0-2 (Coremail) with SMTP id _____wDnD_l1KH1mY9GFAA--.8903S2;
	Thu, 27 Jun 2024 16:53:11 +0800 (CST)
From: yangge1116@126.com
To: akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	21cnbao@gmail.com,
	peterx@redhat.com,
	baolin.wang@linux.alibaba.com,
	liuzixing@hygon.cn,
	yangge <yangge1116@126.com>
Subject: [PATCH] mm/gup: Use try_grab_page() instead of try_grab_folio() in gup slow path
Date: Thu, 27 Jun 2024 16:53:08 +0800
Message-Id: <1719478388-31917-1-git-send-email-yangge1116@126.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID:_____wDnD_l1KH1mY9GFAA--.8903S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3WF45KrWkXF48uF17Zr47Arb_yoWxAr47pF
	4xWwn8tw4DJr17Can7JF4DZr4Sy3s7Ka18CFWfCw4fZa13t34YkF1xJFyrJr98G3y8uFWr
	AF42yF1Uua1DJwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jjLvNUUUUU=
X-CM-SenderInfo: 51dqwwjhrrila6rslhhfrp/1tbiGBwLG2VLcCYqdAAAsy
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

From: yangge <yangge1116@126.com>

If a large number of CMA memory are configured in system (for
example, the CMA memory accounts for 50% of the system memory),
starting a SEV virtual machine will fail. During starting the SEV
virtual machine, it will call pin_user_pages_fast(..., FOLL_LONGTERM,
...) to pin memory. Normally if a page is present and in CMA area,
pin_user_pages_fast() will first call __get_user_pages_locked() to
pin the page in CMA area, and then call
check_and_migrate_movable_pages() to migrate the page from CMA area
to non-CMA area. But the current code calling __get_user_pages_locked()
will fail, because it call try_grab_folio() to pin page in gup slow
path.

The commit 57edfcfd3419 ("mm/gup: accelerate thp gup even for "pages
!= NULL"") uses try_grab_folio() in gup slow path, which seems to be
problematic because try_grap_folio() will check if the page can be
longterm pinned. This check may fail and cause __get_user_pages_lock()
to fail. However, these checks are not required in gup slow path,
seems we can use try_grab_page() instead of try_grab_folio(). In
addition, in the current code, try_grab_page() can only add 1 to the
page's refcount. We extend this function so that the page's refcount
can be increased according to the parameters passed in.

The following log reveals it:

[  464.325306] WARNING: CPU: 13 PID: 6734 at mm/gup.c:1313 __get_user_pages+0x423/0x520
[  464.325464] CPU: 13 PID: 6734 Comm: qemu-kvm Kdump: loaded Not tainted 6.6.33+ #6
[  464.325477] RIP: 0010:__get_user_pages+0x423/0x520
[  464.325515] Call Trace:
[  464.325520]  <TASK>
[  464.325523]  ? __get_user_pages+0x423/0x520
[  464.325528]  ? __warn+0x81/0x130
[  464.325536]  ? __get_user_pages+0x423/0x520
[  464.325541]  ? report_bug+0x171/0x1a0
[  464.325549]  ? handle_bug+0x3c/0x70
[  464.325554]  ? exc_invalid_op+0x17/0x70
[  464.325558]  ? asm_exc_invalid_op+0x1a/0x20
[  464.325567]  ? __get_user_pages+0x423/0x520
[  464.325575]  __gup_longterm_locked+0x212/0x7a0
[  464.325583]  internal_get_user_pages_fast+0xfb/0x190
[  464.325590]  pin_user_pages_fast+0x47/0x60
[  464.325598]  sev_pin_memory+0xca/0x170 [kvm_amd]
[  464.325616]  sev_mem_enc_register_region+0x81/0x130 [kvm_amd]

Fixes: 57edfcfd3419 ("mm/gup: accelerate thp gup even for "pages != NULL"")
Cc: <stable@vger.kernel.org>
Signed-off-by: yangge <yangge1116@126.com>
---
 mm/gup.c         | 26 ++++++++++++--------------
 mm/huge_memory.c |  2 +-
 mm/internal.h    |  2 +-
 3 files changed, 14 insertions(+), 16 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 6ff9f95..bb58909 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -222,7 +222,7 @@ static void gup_put_folio(struct folio *folio, int refs, unsigned int flags)
  *   -ENOMEM		FOLL_GET or FOLL_PIN was set, but the page could not
  *			be grabbed.
  */
-int __must_check try_grab_page(struct page *page, unsigned int flags)
+int __must_check try_grab_page(struct page *page, int refs, unsigned int flags)
 {
 	struct folio *folio = page_folio(page);
 
@@ -233,7 +233,7 @@ int __must_check try_grab_page(struct page *page, unsigned int flags)
 		return -EREMOTEIO;
 
 	if (flags & FOLL_GET)
-		folio_ref_inc(folio);
+		folio_ref_add(folio, refs);
 	else if (flags & FOLL_PIN) {
 		/*
 		 * Don't take a pin on the zero page - it's not going anywhere
@@ -248,13 +248,13 @@ int __must_check try_grab_page(struct page *page, unsigned int flags)
 		 * so that the page really is pinned.
 		 */
 		if (folio_test_large(folio)) {
-			folio_ref_add(folio, 1);
-			atomic_add(1, &folio->_pincount);
+			folio_ref_add(folio, refs);
+			atomic_add(refs, &folio->_pincount);
 		} else {
-			folio_ref_add(folio, GUP_PIN_COUNTING_BIAS);
+			folio_ref_add(folio, refs * GUP_PIN_COUNTING_BIAS);
 		}
 
-		node_stat_mod_folio(folio, NR_FOLL_PIN_ACQUIRED, 1);
+		node_stat_mod_folio(folio, NR_FOLL_PIN_ACQUIRED, refs);
 	}
 
 	return 0;
@@ -729,7 +729,7 @@ static struct page *follow_huge_pud(struct vm_area_struct *vma,
 	    gup_must_unshare(vma, flags, page))
 		return ERR_PTR(-EMLINK);
 
-	ret = try_grab_page(page, flags);
+	ret = try_grab_page(page, 1, flags);
 	if (ret)
 		page = ERR_PTR(ret);
 	else
@@ -806,7 +806,7 @@ static struct page *follow_huge_pmd(struct vm_area_struct *vma,
 	VM_BUG_ON_PAGE((flags & FOLL_PIN) && PageAnon(page) &&
 			!PageAnonExclusive(page), page);
 
-	ret = try_grab_page(page, flags);
+	ret = try_grab_page(page, 1, flags);
 	if (ret)
 		return ERR_PTR(ret);
 
@@ -969,7 +969,7 @@ static struct page *follow_page_pte(struct vm_area_struct *vma,
 		       !PageAnonExclusive(page), page);
 
 	/* try_grab_page() does nothing unless FOLL_GET or FOLL_PIN is set. */
-	ret = try_grab_page(page, flags);
+	ret = try_grab_page(page, 1, flags);
 	if (unlikely(ret)) {
 		page = ERR_PTR(ret);
 		goto out;
@@ -1233,7 +1233,7 @@ static int get_gate_page(struct mm_struct *mm, unsigned long address,
 			goto unmap;
 		*page = pte_page(entry);
 	}
-	ret = try_grab_page(*page, gup_flags);
+	ret = try_grab_page(*page, 1, gup_flags);
 	if (unlikely(ret))
 		goto unmap;
 out:
@@ -1636,22 +1636,20 @@ static long __get_user_pages(struct mm_struct *mm,
 			 * pages.
 			 */
 			if (page_increm > 1) {
-				struct folio *folio;
 
 				/*
 				 * Since we already hold refcount on the
 				 * large folio, this should never fail.
 				 */
-				folio = try_grab_folio(page, page_increm - 1,
+				ret = try_grab_page(page, page_increm - 1,
 						       foll_flags);
-				if (WARN_ON_ONCE(!folio)) {
+				if (WARN_ON_ONCE(ret)) {
 					/*
 					 * Release the 1st page ref if the
 					 * folio is problematic, fail hard.
 					 */
 					gup_put_folio(page_folio(page), 1,
 						      foll_flags);
-					ret = -EFAULT;
 					goto out;
 				}
 			}
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 425374a..18604e4 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1332,7 +1332,7 @@ struct page *follow_devmap_pmd(struct vm_area_struct *vma, unsigned long addr,
 	if (!*pgmap)
 		return ERR_PTR(-EFAULT);
 	page = pfn_to_page(pfn);
-	ret = try_grab_page(page, flags);
+	ret = try_grab_page(page, 1, flags);
 	if (ret)
 		page = ERR_PTR(ret);
 
diff --git a/mm/internal.h b/mm/internal.h
index 2ea9a88..5305bbf 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1227,7 +1227,7 @@ int migrate_device_coherent_page(struct page *page);
  * mm/gup.c
  */
 struct folio *try_grab_folio(struct page *page, int refs, unsigned int flags);
-int __must_check try_grab_page(struct page *page, unsigned int flags);
+int __must_check try_grab_page(struct page *page, int refs, unsigned int flags);
 
 /*
  * mm/huge_memory.c
-- 
2.7.4


