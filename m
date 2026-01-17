Return-Path: <stable+bounces-210188-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E341D391B5
	for <lists+stable@lfdr.de>; Sun, 18 Jan 2026 00:38:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1440D3005006
	for <lists+stable@lfdr.de>; Sat, 17 Jan 2026 23:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DD592DE703;
	Sat, 17 Jan 2026 23:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ghGw/IzV"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D64F1DB13A
	for <stable@vger.kernel.org>; Sat, 17 Jan 2026 23:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768693106; cv=none; b=N3aqSAiCTGqRZGqVtGtlmVT16Do/VJ+aZY/nEBoCvrdmTXyTkaJvpagWv/1vtOnZt4dkIx3KhT9+F4m9I4/gJ9FeJWfTQ/y9sW7LBEsUya+ec/GHrRVA2Upi6MsF2de4xyIgj/fiWJJMFDoZmmgIlbF5PqmPBtUbj5gAn90dC5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768693106; c=relaxed/simple;
	bh=uCUVGlEBWUtzRqtydV37xJ7Ey7mDH19HVF4ZrgsKsXo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oP2os4EM3kizFGWN1Nvmnu8uOGzCfFmxqSHhLfbeOX/7hLSHqf2RBDD68di0ZZkMeypYeNRPh/aOAKachQXNtSqVz2MD7JdGpYZSzo/iVTCzo5YYX6gIFac/uNuTWlO36Jb6akUONRfO6K46G1WTDEXcxVvlpxOZtOZEISLxouw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ghGw/IzV; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-2ae38f81be1so3905544eec.0
        for <stable@vger.kernel.org>; Sat, 17 Jan 2026 15:38:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768693103; x=1769297903; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CHHFw0JINQWRuNVDcAOXPf1m768XNkaV7bYMOf557+U=;
        b=ghGw/IzVlFBHxNAVuB9/VcmHu0GBD5kxgX0Sf/ZQkTYeJWAWrPkIjE2v2aUpC/ULsl
         eab6MXs1GGWJB3dxglsdffwI+AO+vzoeKlSxRInnHreXbEg+NqQznMRtAYPkvg4kVCcf
         ZJ9O3PwNxmd25fFlVlexzTGWfsujj6s+4x2jxkr07lCeWq9WqDX528vL6MXpz0DbfOZs
         XNbB0DT/0sMw+FBXheo707q7qw/UvHEsDtvA8kyBLsYDFnDzPV0o0tPS/44zXd5achwp
         4xWN4CJE9PS0LFpxU2of8gblE2i/8JfQ8T5OGlVhm7lnfMPN8BCvfcE7Hg+anBh/+yql
         pQ6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768693103; x=1769297903;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CHHFw0JINQWRuNVDcAOXPf1m768XNkaV7bYMOf557+U=;
        b=OHf45VPq241pm2pI2BffHiOnZvdtjxmffOGVgYCbouoy82FuBzi0ROqD3N72enLmCr
         yMh4FpediRMmIPOQZHgVDXd6OBhRThfqGJn700gTssu1sql9VbQ6nb3EEy5NdZRE84kZ
         uGugriPStNqAic59xmSzzMHfTOlcOHIVIqvxa9xPpcd0mhHpuDmc2jJqrEY3xKJ0DKJn
         vrg8AA4HpC3fvdtWazYdHl0OtHd3fgljPIxH6Hj8X1vZSsUnrCBZ7BTjAC30AgvyVD2p
         ZsH78MZHBaWX6aoZCPKTBhpKRsvVh/axkVlLDfVbqp+H1dqBTtOIio3TbsbQo6ckRvDa
         eO0Q==
X-Gm-Message-State: AOJu0YzRf05f1350eu7FHfnQQXx0/Zgt4vMZ6VoD4jbW8FEtmA5Gm+kP
	dOR5LMQxI9e5fEIbyeUnfnuDOxrVzlSMKudRv1aKPHTwE5BAwvalPMj7Qr0r4g==
X-Gm-Gg: AY/fxX6DRhO9jAlKVxfkxjLz6FRjQJhKPPMspy/eOkqfvrBqDKyCTUS+KZBpjmuQnYE
	hwwvwgxce0SXsUo3FR2SWs3BVMsfWgf/oipF6gWcWvjwWt/m9ew+yzNI1sNKAQTnaz24IkBSUn0
	aSENDD5tNOipWkvN8zkGMROMcFdoPWPetx6Pv86U+ZMNYsg8Awv/DcOweZLj/IHhqqdg3PjXfhs
	8BEaBljMg/mi+Y7RiUTGPuyUOR5o7F5Uatbh/TPQYpo2gNvPOKqZAHOHe7VYy4p5nX7qItRSpAb
	6j6b2SMrkDtV6n+9xgfbWKpT7x+HdsiecIO9TyIaif5G1buru2KmKUXfAoWzsf/J4gM0OgEikkZ
	2MqqEFoJw3Dg2OzNMsiZSTYTMPhVR9Ul3Yx+TUzu473PVRF3wjOvV9g/xSygE0mI/g0VFet9ofG
	JOFh0/XNVsgzRZ7PY73OPhmNBlMDNZr+5p4BNu+4VeyAVPwe2AFMdukoyxzg==
X-Received: by 2002:a05:7301:e06:b0:2ae:5dc2:3b11 with SMTP id 5a478bee46e88-2b6b46d3163mr6314450eec.2.1768693103106;
        Sat, 17 Jan 2026 15:38:23 -0800 (PST)
Received: from ryzoh.168.0.127 ([2804:14c:5fc8:8033:57d9:5109:d588:7feb])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-2b6b34c0f7fsm7452064eec.3.2026.01.17.15.38.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jan 2026 15:38:22 -0800 (PST)
From: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
To: stable@vger.kernel.org
Cc: Zhi.Yang@windriver.com,
	Pedro Demarchi Gomes <pedrodemargomes@gmail.com>,
	David Hildenbrand <david@redhat.com>,
	craftfever <craftfever@airmail.cc>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	xu xin <xu.xin16@zte.com.cn>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 5.10.y 2/2] ksm: use range-walk function to jump over holes in scan_get_next_rmap_item
Date: Sat, 17 Jan 2026 20:38:01 -0300
Message-ID: <20260117233801.339606-2-pedrodemargomes@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260117233801.339606-1-pedrodemargomes@gmail.com>
References: <2025112005-turmoil-elsewhere-e83d@gregkh>
 <20260117233801.339606-1-pedrodemargomes@gmail.com>
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
index 25b8362a4f89..94d17fb3f184 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -38,6 +38,7 @@
 #include <linux/freezer.h>
 #include <linux/oom.h>
 #include <linux/numa.h>
+#include <linux/pagewalk.h>
 
 #include <asm/tlbflush.h>
 #include "internal.h"
@@ -2223,6 +2224,89 @@ static struct rmap_item *get_next_rmap_item(struct mm_slot *mm_slot,
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
@@ -2302,29 +2386,40 @@ static struct rmap_item *scan_get_next_rmap_item(struct page **page)
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
2.47.3


