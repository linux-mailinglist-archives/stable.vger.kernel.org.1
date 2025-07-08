Return-Path: <stable+bounces-160486-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BEC0FAFCAD5
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 14:49:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D55BB480970
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 12:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B0851C84D6;
	Tue,  8 Jul 2025 12:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="MgbluKzk"
X-Original-To: stable@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBAFB215798
	for <stable@vger.kernel.org>; Tue,  8 Jul 2025 12:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751978909; cv=none; b=f5N/524NvalVXmi+txMcJND9IpS+TOz5WRIEsWrR6zVl4A8gGk0woqB5nsQO8xVMqMFfUrSn//21KwAhiBU5IZsuTJAZ5v+BGrArq7Zoupbg4zTx5qwc+N0yZOGrzmTA6kN6xFcIcb3CWfvbz9Wgp6RjCooZ8ukpR8HebCO2hYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751978909; c=relaxed/simple;
	bh=RW3m1d9AgGvJfTIIzNLK6Yx6MOF6x9ovaKPOh7Zft20=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Eti6pXf50OJAllzHttBByLUa5ANqYqGnBgB0Zn27Z6XfAbzHv9auGtivQskxMX/KqMCqlCfxXefMeGCxLCod1F32VvFC2bINlRi8truBaIRgaJ3HZqLL+7MrRY2trRf5SZgGUUG+OkRrbeNckYwIRtWl9eQnP+M7sKzcBJMtAfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=MgbluKzk; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from fedora.intra.ispras.ru (unknown [10.10.165.16])
	by mail.ispras.ru (Postfix) with ESMTPSA id EB4C24076176;
	Tue,  8 Jul 2025 12:48:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru EB4C24076176
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1751978898;
	bh=ptejpQ6vwQDJ5G9kxUNZgJb4b3jMnundj3BEvGTdydc=;
	h=From:To:Cc:Subject:Date:From;
	b=MgbluKzkqYLSRRLrSLHplA/vCXk/deqBOh05uMheFTCtU1Z1hJpc5M/1Z+ozPtA4Y
	 otz8PyZWzclYJOAKPj63Z5qedo1Fhs031+IpXnWvWwSzMWPrC9AxhPD3R0u6W72raR
	 qKFu+OYuWjNutvNJQaJ7yLaElErH1U9Aqwboclzg=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: stable@vger.kernel.org
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Oscar Salvador <osalvador@suse.de>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Jann Horn <jannh@google.com>,
	linux-mm@kvack.org,
	lvc-project@linuxtesting.org,
	Muchun Song <muchun.song@linux.dev>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Pedro Falcato <pfalcato@suse.de>
Subject: [PATCH 6.1] mm/hugetlb: fix assertion splat in hugetlb_split()
Date: Tue,  8 Jul 2025 15:47:41 +0300
Message-ID: <20250708124743.939155-1-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No upstream commit exists for this patch.

The following assertion is firing on 5.10 to 6.1 stable kernels after
backport of upstream commit 081056dc00a2 ("mm/hugetlb: unshare page tables
during VMA split, not before"):

  WARNING: CPU: 0 PID: 11489 at include/linux/fs.h:503 i_mmap_assert_write_locked include/linux/fs.h:503 [inline]
  WARNING: CPU: 0 PID: 11489 at include/linux/fs.h:503 hugetlb_split+0x267/0x300 mm/hugetlb.c:4917
  Modules linked in:
  CPU: 0 PID: 11489 Comm: syz-executor.4 Not tainted 6.1.142-syzkaller-00296-gfd0df5221577 #0
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
  RIP: 0010:i_mmap_assert_write_locked include/linux/fs.h:503 [inline]
  RIP: 0010:hugetlb_split+0x267/0x300 mm/hugetlb.c:4917
  Call Trace:
   <TASK>
   __vma_adjust+0xd73/0x1c10 mm/mmap.c:736
   vma_adjust include/linux/mm.h:2745 [inline]
   __split_vma+0x459/0x540 mm/mmap.c:2385
   do_mas_align_munmap+0x5f2/0xf10 mm/mmap.c:2497
   do_mas_munmap+0x26c/0x2c0 mm/mmap.c:2646
   __mmap_region mm/mmap.c:2694 [inline]
   mmap_region+0x19f/0x1770 mm/mmap.c:2912
   do_mmap+0x84b/0xf20 mm/mmap.c:1432
   vm_mmap_pgoff+0x1af/0x280 mm/util.c:520
   ksys_mmap_pgoff+0x41f/0x5a0 mm/mmap.c:1478
   do_syscall_x64 arch/x86/entry/common.c:51 [inline]
   do_syscall_64+0x35/0x80 arch/x86/entry/common.c:81
   entry_SYSCALL_64_after_hwframe+0x6e/0xd8
  RIP: 0033:0x46a269
   </TASK>

Those branches lack commit ccf1d78d8b86 ("mm/mmap: move vma_prepare before
vma_adjust_trans_huge") so the needed locks are taken just after the newly
added hugetlb_split().

Adjust the position of vma_adjust_trans_huge() blocks with the lock-taking
code.

Found by Linux Verification Center (linuxtesting.org) with Syzkaller.

Fixes: 081056dc00a2 ("mm/hugetlb: unshare page tables during VMA split, not before")
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
---

Tested with testcases/kernel/mem/hugetlb/hugemmap suite provided by LTP.

For the report see:
https://lore.kernel.org/stable/CAG48ez3LqUwXxhRY56tqQCpfGJsJ-GeXFG9FCcTZEBo2bWOK8Q@mail.gmail.com/T/#u

 mm/mmap.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 0f303dc8425a..941880ed62d7 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -543,8 +543,6 @@ inline int vma_expand(struct ma_state *mas, struct vm_area_struct *vma,
 	if (mas_preallocate(mas, vma, GFP_KERNEL))
 		goto nomem;
 
-	vma_adjust_trans_huge(vma, start, end, 0);
-
 	if (file) {
 		mapping = file->f_mapping;
 		root = &mapping->i_mmap;
@@ -562,6 +560,8 @@ inline int vma_expand(struct ma_state *mas, struct vm_area_struct *vma,
 		vma_interval_tree_remove(vma, root);
 	}
 
+	vma_adjust_trans_huge(vma, start, end, 0);
+
 	vma->vm_start = start;
 	vma->vm_end = end;
 	vma->vm_pgoff = pgoff;
@@ -727,15 +727,6 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned long start,
 		return -ENOMEM;
 	}
 
-	/*
-	 * Get rid of huge pages and shared page tables straddling the split
-	 * boundary.
-	 */
-	vma_adjust_trans_huge(orig_vma, start, end, adjust_next);
-	if (is_vm_hugetlb_page(orig_vma)) {
-		hugetlb_split(orig_vma, start);
-		hugetlb_split(orig_vma, end);
-	}
 	if (file) {
 		mapping = file->f_mapping;
 		root = &mapping->i_mmap;
@@ -775,6 +766,16 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned long start,
 			vma_interval_tree_remove(next, root);
 	}
 
+	/*
+	 * Get rid of huge pages and shared page tables straddling the split
+	 * boundary.
+	 */
+	vma_adjust_trans_huge(orig_vma, start, end, adjust_next);
+	if (is_vm_hugetlb_page(orig_vma)) {
+		hugetlb_split(orig_vma, start);
+		hugetlb_split(orig_vma, end);
+	}
+
 	if (start != vma->vm_start) {
 		if ((vma->vm_start < start) &&
 		    (!insert || (insert->vm_end != start))) {
-- 
2.50.0


