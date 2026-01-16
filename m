Return-Path: <stable+bounces-210079-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EA05D379ED
	for <lists+stable@lfdr.de>; Fri, 16 Jan 2026 18:23:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1AE653022F09
	for <lists+stable@lfdr.de>; Fri, 16 Jan 2026 17:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD37D34C826;
	Fri, 16 Jan 2026 17:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KvH8wnIO"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1ADC23D2B2
	for <stable@vger.kernel.org>; Fri, 16 Jan 2026 17:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768584174; cv=none; b=PECqL0BlnMCQHphw+bFpm9ZYygJQAFzISxhlMgckYmAusZYkd1viYielQ11Ub8EKCs+PdnIsq3Le9tP4txjjI2Kr2s8WhnMfNL28/Q30XplxcC7eXLoRV7GagxZ9bRcKBQTXg2hqeWUjP9yywuDDoVAJoFOc+usDSBz76syP+do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768584174; c=relaxed/simple;
	bh=mYR7uJHwwVj1djMynhXO+ag/XN9zK8PANEL3JPNxoK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LZ3kE6usHoY9x1rFghEHxqMFkgq3RHDXH+6jpx3f21Bm5yry3I+dAdyzjosFhM3HGOveG9ccNP0Ct96CWf3RqB1UmrEJAu3OYuDHphgS2j6V8vYk3b7XC55ZAbH7wmawOMaYEw5oQ2kNcRnP5ulKIIB4ef5hkjmAEDczCtsjAUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KvH8wnIO; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-1233b172f02so2780991c88.0
        for <stable@vger.kernel.org>; Fri, 16 Jan 2026 09:22:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768584168; x=1769188968; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BrgCTzClwcoTly2OjQCVr+vL9rrJfPOVN9q4NqaxWpE=;
        b=KvH8wnIOdsCFpHSJWj98Ud3IMQZY93sfcY3AVeedC/BOi+lwX1aSUtKyUnapSfUgy0
         FRC9iVPdlRc23H2zOh/+m4TEkEhYfpu71mghjPIgSoPI/s/KLpgo/arH4VHJBsIwVZct
         VHw64iyXrSzVTFgsaRWtZLINIZ5+vkeGB+W4PlnzvI/conG2HJ7r6y+VRbvkZZFMwxiR
         GxWP/PC3LX20ht4ENn3kQdaPJXSvMxi4/pu/1pDAWp5hqzgITTm+WKjkYXG1lkRMJILZ
         SRU9WVAqvByKNGgVjkxK02RbTlH/uS4DZJqVN3Ntuyxmmysb1k/1A5OifU2OiYx9CR2O
         /cfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768584168; x=1769188968;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BrgCTzClwcoTly2OjQCVr+vL9rrJfPOVN9q4NqaxWpE=;
        b=fhO275mGxxpyjwf/Wl7FuChfFUN3x/HHXwT27RR0EpN9ENT3UIJlcIRwBGvZbjwWTh
         mCbJ5DKwYIdlhZ/itQpoB886jnY9kx490av/Pei1aj63U+XU3r+65H3PAT5l0T5B5HGW
         bUoe11EJpXgqOVc7FcsvoquNTIIxMrXrJNXEWIIYLyYchRqnGj2Baaf/J5xU74lNVoIS
         Uq8lI52RMBQzqE9K4fY6u8a20BP9b3bGBJbHNgh+2Vb3CdcKQ1qFXIFdsXZk4l3cluw1
         +9WzHFxG+/kZuIPFwDSJXuPYwngzcRnN9XZP2IZnf0x0Fcl2qALrF9wv2GfJBVwKdZ8X
         bSCQ==
X-Gm-Message-State: AOJu0YzYbpeEcZ3HRw5hOcoXx/a9DtTVBcfZx/F/bY9ttpmTIOSWQdyn
	dLmnE9/JpqToInttY2UowyRmVdfFVNeqfLvfUmM9cCV+yGYs0tQWpdu6WTlCkg==
X-Gm-Gg: AY/fxX5P+7CRIlZqMDE7NyMcg+bpXz7+Ed2MfDSUhva99mX0npMHTGn1yOMaeFEIwAA
	QDpb/ny50x5TwtC4HLmpynrJft9B9IkK1zLrTvkPX8DiCt2RhFS1WriY6on2oSnpNqf+W8Ah+y6
	tmPv/OXe8DToOliFyerFDIzwuSHX1m1Bt61d6yiDqy2VghujNv1h00RKwwEVmes06q+rtL4GOyO
	sOqWmDO73k/0UiW5yEISLl88xtmdWzrvwrJ4u37CX4SP2wvH/fxy5TcFkcX17OB1sEw3KJl0MRA
	mnfWnVxx+go06D+Al9jjvHr+RcQx9PFmpjSSt/c/53gKVagrsAsyvOf4s1v36q0VpXGyNbIevIF
	OlSaJBumz2Z3X5xAXTWntJ8Ug8z/oSH191oRSUOrJTTuU44yiUgBKE83GSQLBp+LKw2tz/XFc0A
	anCET0TOIeme7bHxHl/pNy5ObMy/KeykpbjFS+V+jQowPw1si/Taju+USGJCDESp3BeklxNrs=
X-Received: by 2002:a05:7022:2396:b0:11e:3e9:3e9f with SMTP id a92af1059eb24-1244a764723mr2261152c88.50.1768584167364;
        Fri, 16 Jan 2026 09:22:47 -0800 (PST)
Received: from weg-ThinkPad-P16v-Gen-2.. ([2804:30c:274c:de00:6aad:5873:dac7:9b5c])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1244ad740c5sm3537705c88.8.2026.01.16.09.22.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 09:22:47 -0800 (PST)
From: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
To: stable@vger.kernel.org
Cc: Zhi.Yang@windriver.com,
	Pedro Demarchi Gomes <pedrodemargomes@gmail.com>,
	David Hildenbrand <david@redhat.com>,
	craftfever <craftfever@airmail.cc>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	xu xin <xu.xin16@zte.com.cn>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 5.15.y 2/2] ksm: use range-walk function to jump over holes in scan_get_next_rmap_item
Date: Fri, 16 Jan 2026 14:19:14 -0300
Message-ID: <20260116171914.298018-2-pedrodemargomes@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260116171914.298018-1-pedrodemargomes@gmail.com>
References: <2025112003-afloat-squall-e39d@gregkh>
 <20260116171914.298018-1-pedrodemargomes@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
[ change folio to page, replace pmdp_get_lockless with pmd_read_atomic and pmdp_get with
 READ_ONCE(*pmdp) ]
Signed-off-by: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
---
 mm/ksm.c | 115 ++++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 105 insertions(+), 10 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index a5716fdec1aa..48b76785db0d 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -38,6 +38,7 @@
 #include <linux/freezer.h>
 #include <linux/oom.h>
 #include <linux/numa.h>
+#include <linux/pagewalk.h>
 
 #include <asm/tlbflush.h>
 #include "internal.h"
@@ -2214,6 +2215,89 @@ static struct rmap_item *get_next_rmap_item(struct mm_slot *mm_slot,
 	return rmap_item;
 }
 
+struct ksm_next_page_arg {
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
+
+			if (is_zone_device_page(page) || !PageAnon(page))
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
+
+		if (is_zone_device_page(page) || !PageAnon(page))
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
+	get_page(page);
+	spin_unlock(ptl);
+	if (start_ptep)
+		pte_unmap(start_ptep);
+	private->page = page;
+	private->addr = addr;
+	return 1;
+}
+
+static struct mm_walk_ops ksm_next_page_ops = {
+	.pmd_entry = ksm_next_page_pmd_entry,
+};
+
 static struct rmap_item *scan_get_next_rmap_item(struct page **page)
 {
 	struct mm_struct *mm;
@@ -2293,29 +2377,40 @@ static struct rmap_item *scan_get_next_rmap_item(struct page **page)
 			ksm_scan.address = vma->vm_end;
 
 		while (ksm_scan.address < vma->vm_end) {
+			struct ksm_next_page_arg ksm_next_page_arg;
+			struct page *tmp_page = NULL;
+			int found;
+
 			if (ksm_test_exit(mm))
 				break;
-			*page = follow_page(vma, ksm_scan.address, FOLL_GET);
-			if (IS_ERR_OR_NULL(*page)) {
-				ksm_scan.address += PAGE_SIZE;
-				cond_resched();
-				continue;
+
+			found = walk_page_range_vma(vma, ksm_scan.address,
+						    vma->vm_end,
+						    &ksm_next_page_ops,
+						    &ksm_next_page_arg);
+
+			if (found > 0) {
+				tmp_page = ksm_next_page_arg.page;
+				ksm_scan.address = ksm_next_page_arg.addr;
+			} else {
+				VM_WARN_ON_ONCE(found < 0);
+				ksm_scan.address = vma->vm_end - PAGE_SIZE;
 			}
-			if (PageAnon(*page)) {
-				flush_anon_page(vma, *page, ksm_scan.address);
-				flush_dcache_page(*page);
+			if (tmp_page) {
+				flush_anon_page(vma, tmp_page, ksm_scan.address);
+				flush_dcache_page(tmp_page);
 				rmap_item = get_next_rmap_item(slot,
 					ksm_scan.rmap_list, ksm_scan.address);
 				if (rmap_item) {
 					ksm_scan.rmap_list =
 							&rmap_item->rmap_list;
 					ksm_scan.address += PAGE_SIZE;
+					*page = tmp_page;
 				} else
-					put_page(*page);
+					put_page(tmp_page);
 				mmap_read_unlock(mm);
 				return rmap_item;
 			}
-			put_page(*page);
 			ksm_scan.address += PAGE_SIZE;
 			cond_resched();
 		}
-- 
2.43.0


