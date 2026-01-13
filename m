Return-Path: <stable+bounces-208267-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 39281D1916B
	for <lists+stable@lfdr.de>; Tue, 13 Jan 2026 14:23:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 22BDB3040A4A
	for <lists+stable@lfdr.de>; Tue, 13 Jan 2026 13:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1B4538B9BD;
	Tue, 13 Jan 2026 13:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lctqbV+U"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A391E30DEB7
	for <stable@vger.kernel.org>; Tue, 13 Jan 2026 13:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768310517; cv=none; b=E0ky28vCIKIeEzcW5lcO0ZGNIl5jq0rVGIeidlZkz6331xGnAZJ0kGzbVhgceSHgKA6G5t2akdsCwNRzEoJ6UqRg+zIsAyObyglbLDr5PASYHX2sIVaZR0qNk8U12MKT9Uss6G3y3MI3Q9IOHigs4HWc9f2tGpWlfC06I1HQsQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768310517; c=relaxed/simple;
	bh=2HuKym16ziymxJl/nU4mnjckDF0IpSm0a2wd6+UY424=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VY3+Eo1CxWmY/uGg2K2We5SsqnkhY6s3aiYqPfc1frvfOxGBhkRP9Udhm7/PshNMNLj+wK/ws0YMIukt+NA8IYDPYsgd8B4Hn73qM08nbyKvSpOLG9HfimMcU6on1BFeVnxsij3BaLgmfdbKpEvVGScztmPCl6iRUh84nKlVeF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lctqbV+U; arc=none smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-11f36012fb2so9888175c88.1
        for <stable@vger.kernel.org>; Tue, 13 Jan 2026 05:21:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768310514; x=1768915314; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k4uNdbx58ikZvknyOpt8Hs3LwzUS22ffRXDQExCzRK0=;
        b=lctqbV+UGKvnbdxzXdMj2e4TqGLh4mHIoyyQcVoYiFVqbLe4MVwENpRIsU0D1iXEk1
         mFpjVCWee57ZSkoMh9squAwX0qQoQZQzv/K1OJlIPoMNqsZgmokSlhcUMEO8xQ5JGvg1
         +Iiv4Jn4qq2Ef19CzBLqw1IEoHQId0Bg9JIZOhgr5X0uMPYrJMiDAnju1Iqh4o8Vfgyo
         lrR2hmwhyhvqO83YWPAxLcrpbDVnwrpPGok7Fb36ZPcgRpWIkxYrWnv9fkzLAu5bOH+E
         svH41xvnNxXXSMPH7p2Q4b3RkAQItSlSW8yup0d7TfubyQ+YQCBew6JsbfYrMhC1dtQp
         C33g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768310514; x=1768915314;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=k4uNdbx58ikZvknyOpt8Hs3LwzUS22ffRXDQExCzRK0=;
        b=qiEzdbu+Gu/XkxC1VyDQAW6jvNPKYrjSXsvhmhMOcMAQS7vV2fmFPD2EVTHojJy51/
         /D7tb5OF6sApNLnewzo+3T13q29cUn6Ad4IhiJcTszljFyOOHpdmdL13AjommD61r3hw
         M2Vjx0WYXJzQ3A1tIHa5Z5Tm5q8Jn6jYItGBc+2wzg7lz9QLO6J0foyScOYK9F/R+16E
         1iRt9pW//MTN96nvAk4bpL5YVmJ6rQVMZfi/5NfyqGNlWK6W5w0mKGP/FzF/sXw3nNRB
         aHCTUYO9MTMKTnfT8tBicwwyIH1TtOM8n1e5uIsKl0XkEp8EcJwacz1fUg2bSHJcZqN5
         Cg5Q==
X-Gm-Message-State: AOJu0YxnGaswvU1Vtz3nY4zAhLshtTQdNaE46HYvAVVqXwzFnR4936cb
	a3b3dDvObeDXTdH9M6bywdW8JPypTyOo0iyLr7u5xNGepJQwSw0XpvotMDN4Yg==
X-Gm-Gg: AY/fxX5hzr4LooB7bLpXOVh5gJC2lEvgFxGkThLCvyneVkalzoWmK12BoIjo6yWGDc2
	3HYsdm4bOMVm5zQdEFcf4jxSAZfusWjEcvuZtu23UIDvh9MmxldAcr9kKoU0qfO8Ha5OUyVY0eo
	RoKZvlg99TRFN4HOONqaVFEQN96krJNbHhQkiCz74iEeoTJGCIsKOS5seU1t1uDejaZXDkv8mgO
	QLsm3IYMiLLMbAtGnZvrIJ/a/r6qiY53C7bj15zFzeNk88xsU12WpvFODRJeq67SyOTxMyUBgGp
	hOYLl17v2aQ2s7z6aQRkBXiweOl3RkE06MP/GJ9PNEnnALRNKdwVJM6X2raOcPk7eUXp3y90kGS
	wJD/e8s/mFm0kcTMNIDiHrN9uIqr44jbEOve6vwr1IeFFuERSibS2+S/zPXtSTJnUxqMxhv/gU9
	5eLpeajg7LmyRMLPrzLk01tc0kfkJEns8lEhvShzTA1Yh2anmp1WwM93t45P7wGgH9uSNYbcs=
X-Google-Smtp-Source: AGHT+IHxw+fRPU4W7P7OBoPrHxoKffSp8aCUMcH1c4gMhKM2NpWsJsDFmLa0YjtRmx24kk+py+xEXg==
X-Received: by 2002:a05:7022:985:b0:11b:99a2:9082 with SMTP id a92af1059eb24-121f8adcfe2mr15425584c88.15.1768310513333;
        Tue, 13 Jan 2026 05:21:53 -0800 (PST)
Received: from weg-ThinkPad-P16v-Gen-2.. ([2804:30c:274c:de00:6a34:91bb:fdd0:8bea])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b1707b0b2bsm17368853eec.23.2026.01.13.05.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 05:21:52 -0800 (PST)
From: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
To: stable@vger.kernel.org
Cc: Zhi.Yang@windriver.com,
	Pedro Demarchi Gomes <pedrodemargomes@gmail.com>,
	David Hildenbrand <david@redhat.com>,
	craftfever <craftfever@airmail.cc>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	xu xin <xu.xin16@zte.com.cn>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.1.y 2/2] ksm: use range-walk function to jump over holes in scan_get_next_rmap_item
Date: Tue, 13 Jan 2026 10:01:56 -0300
Message-ID: <20260113130156.220078-2-pedrodemargomes@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260113130156.220078-1-pedrodemargomes@gmail.com>
References: <2025112001-kitten-trickily-a02d@gregkh>
 <20260113130156.220078-1-pedrodemargomes@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>

[ Upstream commit f5548c318d6520d4fa3c5ed6003eeb710763cbc5 ]

Currently, scan_get_next_rmap_item() walks every page address in a VMA to
locate mergeable pages.  This becomes highly inefficient when scanning
large virtual memory areas that contain mostly unmapped regions, causing
ksmd to use large amount of cpu without deduplicating much pages.

This patch replaces the per-address lookup with a range walk using
walk_page_range().  The range walker allows KSM to skip over entire
unmapped holes in a VMA, avoiding unnecessary lookups.  This problem was
previously discussed in [1].

Consider the following test program which creates a 32 TiB mapping in the
virtual address space but only populates a single page:

/* 32 TiB */
const size_t size = 32ul * 1024 * 1024 * 1024 * 1024;

int main() {
        char *area = mmap(NULL, size, PROT_READ | PROT_WRITE,
                          MAP_NORESERVE | MAP_PRIVATE | MAP_ANON, -1, 0);

        if (area == MAP_FAILED) {
                perror("mmap() failed\n");
                return -1;
        }

        /* Populate a single page such that we get an anon_vma. */
        *area = 0;

        /* Enable KSM. */
        madvise(area, size, MADV_MERGEABLE);
        pause();
        return 0;
}

$ ./ksm-sparse  &
$ echo 1 > /sys/kernel/mm/ksm/run

Without this patch ksmd uses 100% of the cpu for a long time (more then 1
hour in my test machine) scanning all the 32 TiB virtual address space
that contain only one mapped page.  This makes ksmd essentially deadlocked
not able to deduplicate anything of value.  With this patch ksmd walks
only the one mapped page and skips the rest of the 32 TiB virtual address
space, making the scan fast using little cpu.

Link: https://lkml.kernel.org/r/20251023035841.41406-1-pedrodemargomes@gmail.com
Link: https://lkml.kernel.org/r/20251022153059.22763-1-pedrodemargomes@gmail.com
Link: https://lore.kernel.org/linux-mm/423de7a3-1c62-4e72-8e79-19a6413e420c@redhat.com/ [1]
Fixes: 31dbd01f3143 ("ksm: Kernel SamePage Merging")
Signed-off-by: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
Co-developed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
Reported-by: craftfever <craftfever@airmail.cc>
Closes: https://lkml.kernel.org/r/020cf8de6e773bb78ba7614ef250129f11a63781@murena.io
Suggested-by: David Hildenbrand <david@redhat.com>
Acked-by: David Hildenbrand <david@redhat.com>
Cc: Chengming Zhou <chengming.zhou@linux.dev>
Cc: xu xin <xu.xin16@zte.com.cn>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
[ replace pmdp_get_lockless with pmd_read_atomic and pmdp_get with
 READ_ONCE(*pmdp) ]
Signed-off-by: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
---
 mm/ksm.c | 126 +++++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 113 insertions(+), 13 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index cb272b6fde59..616a8f7c5c60 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -39,6 +39,7 @@
 #include <linux/freezer.h>
 #include <linux/oom.h>
 #include <linux/numa.h>
+#include <linux/pagewalk.h>
 
 #include <asm/tlbflush.h>
 #include "internal.h"
@@ -2223,6 +2224,94 @@ static struct ksm_rmap_item *get_next_rmap_item(struct ksm_mm_slot *mm_slot,
 	return rmap_item;
 }
 
+struct ksm_next_page_arg {
+	struct folio *folio;
+	struct page *page;
+	unsigned long addr;
+};
+
+static int ksm_next_page_pmd_entry(pmd_t *pmdp, unsigned long addr, unsigned long end,
+		struct mm_walk *walk)
+{
+	struct ksm_next_page_arg *private = walk->private;
+	struct vm_area_struct *vma = walk->vma;
+	pte_t *start_ptep = NULL, *ptep, pte;
+	struct mm_struct *mm = walk->mm;
+	struct folio *folio;
+	struct page *page;
+	spinlock_t *ptl;
+	pmd_t pmd;
+
+	if (ksm_test_exit(mm))
+		return 0;
+
+	cond_resched();
+
+	pmd = pmd_read_atomic(pmdp);
+	if (!pmd_present(pmd))
+		return 0;
+
+	if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) && pmd_leaf(pmd)) {
+		ptl = pmd_lock(mm, pmdp);
+		pmd = READ_ONCE(*pmdp);
+
+		if (!pmd_present(pmd)) {
+			goto not_found_unlock;
+		} else if (pmd_leaf(pmd)) {
+			page = vm_normal_page_pmd(vma, addr, pmd);
+			if (!page)
+				goto not_found_unlock;
+			folio = page_folio(page);
+
+			if (folio_is_zone_device(folio) || !folio_test_anon(folio))
+				goto not_found_unlock;
+
+			page += ((addr & (PMD_SIZE - 1)) >> PAGE_SHIFT);
+			goto found_unlock;
+		}
+		spin_unlock(ptl);
+	}
+
+	start_ptep = pte_offset_map_lock(mm, pmdp, addr, &ptl);
+	if (!start_ptep)
+		return 0;
+
+	for (ptep = start_ptep; addr < end; ptep++, addr += PAGE_SIZE) {
+		pte = ptep_get(ptep);
+
+		if (!pte_present(pte))
+			continue;
+
+		page = vm_normal_page(vma, addr, pte);
+		if (!page)
+			continue;
+		folio = page_folio(page);
+
+		if (folio_is_zone_device(folio) || !folio_test_anon(folio))
+			continue;
+		goto found_unlock;
+	}
+
+not_found_unlock:
+	spin_unlock(ptl);
+	if (start_ptep)
+		pte_unmap(start_ptep);
+	return 0;
+found_unlock:
+	folio_get(folio);
+	spin_unlock(ptl);
+	if (start_ptep)
+		pte_unmap(start_ptep);
+	private->page = page;
+	private->folio = folio;
+	private->addr = addr;
+	return 1;
+}
+
+static struct mm_walk_ops ksm_next_page_ops = {
+	.pmd_entry = ksm_next_page_pmd_entry,
+};
+
 static struct ksm_rmap_item *scan_get_next_rmap_item(struct page **page)
 {
 	struct mm_struct *mm;
@@ -2307,32 +2396,43 @@ static struct ksm_rmap_item *scan_get_next_rmap_item(struct page **page)
 			ksm_scan.address = vma->vm_end;
 
 		while (ksm_scan.address < vma->vm_end) {
+			struct ksm_next_page_arg ksm_next_page_arg;
+			struct page *tmp_page = NULL;
+			struct folio *folio;
+
 			if (ksm_test_exit(mm))
 				break;
-			*page = follow_page(vma, ksm_scan.address, FOLL_GET);
-			if (IS_ERR_OR_NULL(*page)) {
-				ksm_scan.address += PAGE_SIZE;
-				cond_resched();
-				continue;
+
+			int found;
+
+			found = walk_page_range_vma(vma, ksm_scan.address,
+						    vma->vm_end,
+						    &ksm_next_page_ops,
+						    &ksm_next_page_arg);
+
+			if (found > 0) {
+				folio = ksm_next_page_arg.folio;
+				tmp_page = ksm_next_page_arg.page;
+				ksm_scan.address = ksm_next_page_arg.addr;
+			} else {
+				VM_WARN_ON_ONCE(found < 0);
+				ksm_scan.address = vma->vm_end - PAGE_SIZE;
 			}
-			if (is_zone_device_page(*page))
-				goto next_page;
-			if (PageAnon(*page)) {
-				flush_anon_page(vma, *page, ksm_scan.address);
-				flush_dcache_page(*page);
+			if (tmp_page) {
+				flush_anon_page(vma, tmp_page, ksm_scan.address);
+				flush_dcache_page(tmp_page);
 				rmap_item = get_next_rmap_item(mm_slot,
 					ksm_scan.rmap_list, ksm_scan.address);
 				if (rmap_item) {
 					ksm_scan.rmap_list =
 							&rmap_item->rmap_list;
 					ksm_scan.address += PAGE_SIZE;
+					*page = tmp_page;
 				} else
-					put_page(*page);
+					folio_put(folio);
 				mmap_read_unlock(mm);
 				return rmap_item;
 			}
-next_page:
-			put_page(*page);
 			ksm_scan.address += PAGE_SIZE;
 			cond_resched();
 		}
-- 
2.43.0


