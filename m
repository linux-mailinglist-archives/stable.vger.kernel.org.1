Return-Path: <stable+bounces-148100-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9402EAC8091
	for <lists+stable@lfdr.de>; Thu, 29 May 2025 17:54:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C09A61BC3FE2
	for <lists+stable@lfdr.de>; Thu, 29 May 2025 15:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 759D422D9E5;
	Thu, 29 May 2025 15:54:36 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F14226D1E;
	Thu, 29 May 2025 15:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748534076; cv=none; b=UkdeaQvzMUnGqvNeiByDsem3OQvIvAbRE+r3e3HXi/KPuhPhr66Oai3CvBczc8SV6MVqgqRK5/BWlzZC6fRBMEnDdJjhBJ76o4jP20hlLWWSvl59UdCVHxKccd/ywzPVzm/tCKOMjbVuLtrYrM2t4/C/FCwK8s5gTKE2pnyHRgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748534076; c=relaxed/simple;
	bh=ZmpBdfuJqYt6HGws5y6gBga0OTPuYFFmkFFJjsjdLDg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QPWBNm6vru3fj7Z3SYFuXLZOagG0sR7ML2+s9L2VJzbgideSmSFJmmx/UtOs/oSJV25Np4LkLELi1dfUA5EDoeUjD5SC0f0Vkk4LcRbTSzKd+GzJPLa60v4jpOtswCLC+khpk0AzRag/MTJAWFdQOl3Zvjr8xLhTGIxfOuggeqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4b7WCF21WczKHMmm;
	Thu, 29 May 2025 23:54:33 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id A87D81A0D7D;
	Thu, 29 May 2025 23:54:31 +0800 (CST)
Received: from ultra.huawei.com (unknown [10.90.53.71])
	by APP3 (Coremail) with SMTP id _Ch0CgBX98EzgzhooMK5Ng--.57784S3;
	Thu, 29 May 2025 23:54:31 +0800 (CST)
From: Pu Lehui <pulehui@huaweicloud.com>
To: mhiramat@kernel.org,
	oleg@redhat.com,
	peterz@infradead.org,
	akpm@linux-foundation.org,
	Liam.Howlett@oracle.com,
	lorenzo.stoakes@oracle.com,
	vbabka@suse.cz,
	jannh@google.com,
	pfalcato@suse.de
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	pulehui@huawei.com
Subject: [PATCH v1 1/4] mm: Fix uprobe pte be overwritten when expanding vma
Date: Thu, 29 May 2025 15:56:47 +0000
Message-Id: <20250529155650.4017699-2-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250529155650.4017699-1-pulehui@huaweicloud.com>
References: <20250529155650.4017699-1-pulehui@huaweicloud.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgBX98EzgzhooMK5Ng--.57784S3
X-Coremail-Antispam: 1UD129KBjvJXoWxCw15WrWfZFy3Xr4DJF1xAFb_yoWrGr1rpF
	n3Jwn8Krs7JFsakryDZr1DWr93Kw1I9a1UCr1fJ34Y9r15Kr4a9FW3AF45CFy5JFZ2gF1S
	qr40q34fKay7ta7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPFb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
	A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI
	0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
	67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MI
	IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
	14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
	W8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU2HGQ
	DUUUU
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/

From: Pu Lehui <pulehui@huawei.com>

We encountered a BUG alert triggered by Syzkaller as follows:
   BUG: Bad rss-counter state mm:00000000b4a60fca type:MM_ANONPAGES val:1

And we can reproduce it with the following steps:
1. register uprobe on file at zero offset
2. mmap the file at zero offset:
   addr1 = mmap(NULL, 2 * 4096, PROT_NONE, MAP_PRIVATE, fd, 0);
3. mremap part of vma1 to new vma2:
   addr2 = mremap(addr1, 4096, 2 * 4096, MREMAP_MAYMOVE);
4. mremap back to orig addr1:
   mremap(addr2, 4096, 4096, MREMAP_MAYMOVE | MREMAP_FIXED, addr1);

In the step 3, the vma1 range [addr1, addr1 + 4096] will be remap to new
vma2 with range [addr2, addr2 + 8192], and remap uprobe anon page from
the vma1 to vma2, then unmap the vma1 range [addr1, addr1 + 4096]. In
tht step 4, the vma2 range [addr2, addr2 + 4096] will be remap back to
the addr range [addr1, addr1 + 4096]. Since the addr range
[addr1 + 4096, addr1 + 8192] still maps the file, it will take
vma_merge_new_range to expand the range, and then do uprobe_mmap in
vma_complete. Since the merged vma pgoff is also zero offset, it will
install uprobe anon page to the merged vma. However, the upcomming
move_page_tables step, which use set_pte_at to remap the vma2 uprobe pte
to the merged vma, will overwrite the newly uprobe pte in the merged
vma, and lead that pte to be orphan.

Since the uprobe pte will be remapped to the merged vma, we can
remove the unnecessary uprobe_mmap upon merged vma.

This problem was first find in linux-6.6.y and also exists in the
community syzkaller:
https://lore.kernel.org/all/000000000000ada39605a5e71711@google.com/T/

CC: stable@vger.kernel.org
Fixes: 2b1444983508 ("uprobes, mm, x86: Add the ability to install and remove uprobes breakpoints")
Suggested-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Signed-off-by: Pu Lehui <pulehui@huawei.com>
---
 mm/vma.c | 20 +++++++++++++++++---
 mm/vma.h |  7 +++++++
 2 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/mm/vma.c b/mm/vma.c
index 1c6595f282e5..b2d7c03d8aa4 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -169,6 +169,9 @@ static void init_multi_vma_prep(struct vma_prepare *vp,
 	vp->file = vma->vm_file;
 	if (vp->file)
 		vp->mapping = vma->vm_file->f_mapping;
+
+	if (vmg && vmg->skip_vma_uprobe)
+		vp->skip_vma_uprobe = true;
 }
 
 /*
@@ -358,10 +361,13 @@ static void vma_complete(struct vma_prepare *vp, struct vma_iterator *vmi,
 
 	if (vp->file) {
 		i_mmap_unlock_write(vp->mapping);
-		uprobe_mmap(vp->vma);
 
-		if (vp->adj_next)
-			uprobe_mmap(vp->adj_next);
+		if (!vp->skip_vma_uprobe) {
+			uprobe_mmap(vp->vma);
+
+			if (vp->adj_next)
+				uprobe_mmap(vp->adj_next);
+		}
 	}
 
 	if (vp->remove) {
@@ -1823,6 +1829,14 @@ struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
 		faulted_in_anon_vma = false;
 	}
 
+	/*
+	 * If the VMA we are copying might contain a uprobe PTE, ensure
+	 * that we do not establish one upon merge. Otherwise, when mremap()
+	 * moves page tables, it will orphan the newly created PTE.
+	 */
+	if (vma->vm_file)
+		vmg.skip_vma_uprobe = true;
+
 	new_vma = find_vma_prev(mm, addr, &vmg.prev);
 	if (new_vma && new_vma->vm_start < addr + len)
 		return NULL;	/* should never get here */
diff --git a/mm/vma.h b/mm/vma.h
index 9a8af9be29a8..0db066e7a45d 100644
--- a/mm/vma.h
+++ b/mm/vma.h
@@ -19,6 +19,8 @@ struct vma_prepare {
 	struct vm_area_struct *insert;
 	struct vm_area_struct *remove;
 	struct vm_area_struct *remove2;
+
+	bool skip_vma_uprobe :1;
 };
 
 struct unlink_vma_file_batch {
@@ -120,6 +122,11 @@ struct vma_merge_struct {
 	 */
 	bool give_up_on_oom :1;
 
+	/*
+	 * If set, skip uprobe_mmap upon merged vma.
+	 */
+	bool skip_vma_uprobe :1;
+
 	/* Internal flags set during merge process: */
 
 	/*
-- 
2.34.1


