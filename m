Return-Path: <stable+bounces-207902-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id EC604D0BCDB
	for <lists+stable@lfdr.de>; Fri, 09 Jan 2026 19:14:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 615CA30260E9
	for <lists+stable@lfdr.de>; Fri,  9 Jan 2026 18:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 483CA365A19;
	Fri,  9 Jan 2026 18:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FHSr4Wti"
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E123644A5
	for <stable@vger.kernel.org>; Fri,  9 Jan 2026 18:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767982491; cv=none; b=lgeo0DmLnaVqTgahLSkrynxWFNH3ZwfD4ch0NzVR5NSsGPpdWcNdfKYlWSmlSDh4IBFN/IUh7T9Ejze0annIfuMdN3//YYPZbf0ofZIbxeMYkCbxHDnpWxrbDk9XA1jOtLdWgZeQEGU9uhXYigmaVGYOg4XIqgjHyCBm5QDclzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767982491; c=relaxed/simple;
	bh=EVxd5KRLjY1aqx6lD0YrBb3H02xLC1MgVijISkXNyXE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BZsbylBGAIPVCbq4RZqx3hpkv04E6lB4S+qXalA7aDcLpK7KE2MPGyRHgBykYnpziL0Ji3pcK6kiRe5eVTCzrlmhs2pnPdkQI+AA42uTCelEd8Iuw6YXeraWx1A5r0C9Ea2Q12F4XPACNJ0NCEPafOIr9l7fllXOUXIKIN3/RZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FHSr4Wti; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-5eea9f9c29bso994775137.2
        for <stable@vger.kernel.org>; Fri, 09 Jan 2026 10:14:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767982488; x=1768587288; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ESxnid/qnkj8TJ5d9YpzAgD9zS8D5bkzkSc5pbk8vyc=;
        b=FHSr4WtiP9l1Laqazu9qw0vmtJoWZ9X0qZg8ZrZ8QK3Kyz/m7BsPL90ooi0XoAa4C6
         DckjTiRg63hyC0t9Qh4KIA49oghp6iC1+oERUUbVfQebqHyYqTCS3EZMJm4mwozo7Kxh
         QJw6j/r8i/YmzfN3Z9FZXX+SR4c9GxqMb+xRmVsG/l1zOsMaGitmy0TAMLz+XOqxqBM8
         XMg+qoU+CTvU6ps3y0YegjTnC56V3ECEwDjbyiMl4Y+pU11F+Rd8JIaPwbgJ+9hWariT
         aR8O3AXzWbD+3luNRC9/nQpoWIIV2Naa2tf5BL0GcGAYPaoNdyVLM41TkcGZJaM+w09D
         Z6Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767982488; x=1768587288;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ESxnid/qnkj8TJ5d9YpzAgD9zS8D5bkzkSc5pbk8vyc=;
        b=vb3RbQhww2Ph6OtA2dwrzw4PIDRn9ITmOnupYKS/kgt16QUpurTWyckPz9h84R3OEs
         0YOn1rFFfZvpboJwIpPPDwWUhZyULUAyUyhReVDDTp5QIMKJ/Sw0DD4KSROSRj4eoose
         HOFuFldpLrQjEeuJVW1dr47c2aOmYAHfkAl/v3/EjURHQH5UA6IJaVlF7XZbxKUD1dmq
         05+rD/C7VTwDljwQsYuhE/jssMp5agOJiE9z3tdbE9y/2gg0GZlfgxjVPFhn9zgjtc4g
         NaDQZoJ55grliIO+v5veizZtHQX7ygAFbGnqdQ3VZfJUyUKgPMjJOpGPuymYvIr1nwT4
         PN9A==
X-Gm-Message-State: AOJu0YwzgDekLKkTkIY944X6ihjez0NjxKAThDBVHTq8xfNitZHQ6dcG
	/v7vv80DrephcF5VECqOcfKnkSxUlpmtnA5JMJs9yzOj0U2j+F18qXoN/oRpHg==
X-Gm-Gg: AY/fxX4gFgtBWmaR6nsiVobvpP49944Byn1P3Bd4izvixERZWr5BkDembgJBitZPP0Z
	VD0S6kwtOHCPRR4Z1enf24ouMjxLmIzq+0KPf/k2EQZvotNoTiOQiuLn6BaPW7J1s0hbAfEqpWD
	honL+kqDPa5JNwvkjIiirgrwvyovnGEk3PShq9pYkMWd/0gNamsoF1CnUqmuLSbMEMj/xB84RR8
	EdjkCPWZxHy0bMjbkbtgNGUd5aU3JNioYWcZ3oJRGAvOiVdr6VEOU796jrjcT6FBW54UNVzpycB
	G9YlVcMeaibtGuOi9oX4M7p9+U+1pFiPnm1X1bKz5ApnN3LfBbz2rMsR9jPetLG1yfx4qLaUdOH
	EGemwkJRldCzbpEGKVORsao5NeZNHhqJGWsVSuzU+lzt7Un3lfATOWLrcYOUECfqwBjLbOvXgz5
	egPcpiZaWGf7QKqSW/oLraAsTOM+iQ/fUN//TKdfsiqaNJ+EEZTqaTcuSBZkaD5pMVCYhbRtM=
X-Google-Smtp-Source: AGHT+IHhLVrMNDn475xRRzdbOWkAx0DUNdt5BitXFo1NcmYjrFOLdSjKW+XQ1qUI1J3tAK+FEnwIzQ==
X-Received: by 2002:a05:6102:4410:b0:5ef:49d0:5862 with SMTP id ada2fe7eead31-5ef49d05999mr1455358137.34.1767982486560;
        Fri, 09 Jan 2026 10:14:46 -0800 (PST)
Received: from weg-ThinkPad-P16v-Gen-2.. ([2804:30c:274c:de00:5b01:c139:2126:4ac7])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5ee9fe7f478sm5195097137.3.2026.01.09.10.14.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 10:14:46 -0800 (PST)
From: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
To: stable@vger.kernel.org
Cc: Zhi.Yang@windriver.com,
	Pedro Demarchi Gomes <pedrodemargomes@gmail.com>,
	David Hildenbrand <david@redhat.com>,
	craftfever <craftfever@airmail.cc>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	xu xin <xu.xin16@zte.com.cn>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.6.y] ksm: use range-walk function to jump over holes in scan_get_next_rmap_item
Date: Fri,  9 Jan 2026 15:11:38 -0300
Message-ID: <20260109181138.751202-1-pedrodemargomes@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2025112000-stage-compare-58a2@gregkh>
References: <2025112000-stage-compare-58a2@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>

commit f5548c318d6520d4fa3c5ed6003eeb710763cbc5 upstream.

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
[ change page to folios ]
Signed-off-by: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
---
 mm/ksm.c | 126 +++++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 113 insertions(+), 13 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index 2e4cd681622d..84024e766c99 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -2304,6 +2304,95 @@ static struct ksm_rmap_item *get_next_rmap_item(struct ksm_mm_slot *mm_slot,
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
+	pmd = pmdp_get_lockless(pmdp);
+	if (!pmd_present(pmd))
+		return 0;
+
+	if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) && pmd_leaf(pmd)) {
+		ptl = pmd_lock(mm, pmdp);
+		pmd = pmdp_get(pmdp);
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
+	.walk_lock = PGWALK_RDLOCK,
+};
+
 static struct ksm_rmap_item *scan_get_next_rmap_item(struct page **page)
 {
 	struct mm_struct *mm;
@@ -2390,32 +2479,43 @@ static struct ksm_rmap_item *scan_get_next_rmap_item(struct page **page)
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


