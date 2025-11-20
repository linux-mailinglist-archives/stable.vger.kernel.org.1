Return-Path: <stable+bounces-195299-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 16847C753B1
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 17:06:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 0FC8B2C8DC
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 15:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF14D3376AC;
	Thu, 20 Nov 2025 15:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="T9XftDCk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD8934405D
	for <stable@vger.kernel.org>; Thu, 20 Nov 2025 15:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763654046; cv=none; b=eW2nFq/nGHlemAGy7Bni+kUORmUGZtlHNe53nE4pMnC7/z+rXiiiOPUU1KWBlGdJ/f92GcXU1vK4K+cuMIE4agugxRSE7GYpF13rsvK2m7xJTwBFJPCD0iwk1noDNG6mVywNQRIQsluVQtjWHOy950ofBdVjYKveXiSyn2B4J6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763654046; c=relaxed/simple;
	bh=MYXMptv3BtFW+50tXMkjSt/J4mQ36XjiOKqe4hd2ts0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=BAK1J0uBjKCvaQ5nGenUzqfQzgG0SIJ7VSoCl0oAxTzkUUOJDcGiKT+/itvX1AIiu71m/rrPAd6G6PTHqoxI0VTFCH6cA1a/Vf1WrH2p3LFYOxlZqrDu9ls73snmuUwloFgog/k70VADuihkic1tHstG8ljvROgjALtX7RE0pbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=T9XftDCk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7550C116C6;
	Thu, 20 Nov 2025 15:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1763654046;
	bh=MYXMptv3BtFW+50tXMkjSt/J4mQ36XjiOKqe4hd2ts0=;
	h=Subject:To:Cc:From:Date:From;
	b=T9XftDCkB0zGKH+25LRssr48Jqub1m2G4ErrwIqvK/+65fgl9tigI+Y8iMqpeNY53
	 6bQ97SmDDQZxerBnwhYGnoAKfsjzIsyJ0H750fpLjTtyqhD1jLDIRoYZ9Dya4xszRP
	 f/xYez8u4JE5wVRxRXgInpINgQAGi5jQhmvL7el8=
Subject: FAILED: patch "[PATCH] ksm: use range-walk function to jump over holes in" failed to apply to 6.1-stable tree
To: pedrodemargomes@gmail.com,akpm@linux-foundation.org,chengming.zhou@linux.dev,craftfever@airmail.cc,david@redhat.com,stable@vger.kernel.org,xu.xin16@zte.com.cn
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 20 Nov 2025 16:54:02 +0100
Message-ID: <2025112001-kitten-trickily-a02d@gregkh>
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
git cherry-pick -x f5548c318d6520d4fa3c5ed6003eeb710763cbc5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025112001-kitten-trickily-a02d@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f5548c318d6520d4fa3c5ed6003eeb710763cbc5 Mon Sep 17 00:00:00 2001
From: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
Date: Wed, 22 Oct 2025 12:30:59 -0300
Subject: [PATCH] ksm: use range-walk function to jump over holes in
 scan_get_next_rmap_item

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

#include <unistd.h>
#include <stdio.h>
#include <sys/mman.h>

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

diff --git a/mm/ksm.c b/mm/ksm.c
index 7bc726b50b2f..c4e730409949 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -2455,6 +2455,95 @@ static bool should_skip_rmap_item(struct folio *folio,
 	return true;
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
@@ -2542,21 +2631,27 @@ static struct ksm_rmap_item *scan_get_next_rmap_item(struct page **page)
 			ksm_scan.address = vma->vm_end;
 
 		while (ksm_scan.address < vma->vm_end) {
+			struct ksm_next_page_arg ksm_next_page_arg;
 			struct page *tmp_page = NULL;
-			struct folio_walk fw;
 			struct folio *folio;
 
 			if (ksm_test_exit(mm))
 				break;
 
-			folio = folio_walk_start(&fw, vma, ksm_scan.address, 0);
-			if (folio) {
-				if (!folio_is_zone_device(folio) &&
-				     folio_test_anon(folio)) {
-					folio_get(folio);
-					tmp_page = fw.page;
-				}
-				folio_walk_end(&fw, vma);
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
 
 			if (tmp_page) {


