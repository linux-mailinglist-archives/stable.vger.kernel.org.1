Return-Path: <stable+bounces-203369-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A3EE9CDC078
	for <lists+stable@lfdr.de>; Wed, 24 Dec 2025 11:43:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7DCDD301E6FA
	for <lists+stable@lfdr.de>; Wed, 24 Dec 2025 10:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F1E13191D4;
	Wed, 24 Dec 2025 10:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="KsQeBJaL"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f100.google.com (mail-ua1-f100.google.com [209.85.222.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60453191A1
	for <stable@vger.kernel.org>; Wed, 24 Dec 2025 10:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766573018; cv=none; b=hryQ73BPhrYkNod1xCiddqIDgAobm+3Iq7J3Fv62hzkyAwnYm/8vBmoZeYNc/6vXpROp6b6RLfLqY4p1KrFdNsXmoFLvnxD6CbhiGkIQsLHX9GTzeCUIpUmbw4XaifMdZfJoEzapCnrWhjQzaDbq3nDLysu5tmQwMxO9NbdtBTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766573018; c=relaxed/simple;
	bh=gN0Z6TQyRvgaq7lyEKqsD7oNpurphVB/Y6c1nH9WX5s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TIIeL0F13OcMgubTIoehcG3e/mUefpU/DxhJ+rBDV2a4Bnh7wahXcljQOTwjPgmmPm+p1eFArU5PaDWoh0Y+34RrfKJ792PtpqOXpThIs4RY0bM8Y7E4saAh7a/bZMDihFBEl2iNEOdfW8n8Qws1njeHt8jJe/ndAfoW4NualGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=KsQeBJaL; arc=none smtp.client-ip=209.85.222.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ua1-f100.google.com with SMTP id a1e0cc1a2514c-94121102a54so3605413241.1
        for <stable@vger.kernel.org>; Wed, 24 Dec 2025 02:43:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766573016; x=1767177816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qs1L9yogvjoOS4UWjYKVRJa3NcwdJKzh6wcPXeXPOP0=;
        b=gY/CeV3+ybNKcWNo5NrKSzNZ07Mxo66okOWc2yFYi0ZAnjbBOtbjQaw3ZwGsZFoMiR
         A3uC4NkWVG+nH0fZ2LakmAXWAA6NiPJiJgoHPQJISSM7KjqwSSFJI3TJ6fbDoWN4bPI0
         uyIKZZ8PpeHdZqswrLZWeIqHgrQ+QjGRjwN8j5cW7OEjK/8lnL6m5tLP3vMakVQ9pxBi
         hQwYnIchaXF6xB4uldXN22X5GIdr+1+IbdpvrZEvE0DWsBXVhdv0Cr/qekcM82VQgjdh
         ceSW/guEiD3MxMIA0kQPLpI1Ao7W65U+DpvJ/gRhTZUGUnJgRx2p0QX9KNHFpD3bje4n
         5CLA==
X-Gm-Message-State: AOJu0YzTpFPYrZQusrT9WCtOo9AN40YXMs3C2neTsplaAuB5FatrrbxH
	zcrzVmWby4B1M+5usa/K9mggUEjdnmHHagJlnCF76zj99/beCv/pTHUE2rpzVxLYietfhqp8sbl
	WHBH8ZxYxp6dM1kkdoO7WUs3Alelcc2TKXSzdV28vm7p7rg4bIajXGIi436EOIB6wTe/xqR3LqG
	kXobeyrSVd+TS6DCt1OH+RKBVtGFjRgiZn6T6aqtaUsPpoC8xzfvsF81J5KRwGd/1ATFSCm4Z93
	vKBmbZizX8=
X-Gm-Gg: AY/fxX4UWBOpQBy1bcZJVSlyABAVfWSjGz3ok69NNFzA62nC0HdNsNErcFMakxas38a
	XgzVfI/7Fw5GsXUtuZz8Np6ySm5kh+bKiT7QWoM836iMwharNXgGKabbrB5Ce+WEflhHL1tJeYd
	aM0lTiyBHCgBsEUiOZojADK8CQho5m+powgY0tfoeddulVt5Ub+naD7z34zXDM9gdcAos9X5c9I
	bvXnogPvTjOfW0zN1UOe5pStkXvJ5xnJa69XgHvfChPIO60WflAEVSdPlzHGa8EWAtmGVLiveah
	Ay0HzbxCYBVD4lyMBb7xHNIJPME+l+P4dVwy3lxieeD5GSiVDRxQd9wTheY9gpsbb/NQsiwh4lr
	K5qaiDAbWUoCeXhd2cn4RjULaihQyjMkbY8IegfpMB94+uVeWYRBtLEcyLwipx57JQt69s2rssB
	ftfVhmDNCmxV3Larg73/CDSPtu+xrOl2ANXNLMs77/zg==
X-Google-Smtp-Source: AGHT+IFZwR9TQ/Av/oCjJ+9749LoXvk/pWrzJoYI8p/IAeWRxa0wK8OxnbIb3pvZ7IEeh09fsdlXhWDGhM2C
X-Received: by 2002:a05:6102:2b97:b0:5d7:dea0:d6c4 with SMTP id ada2fe7eead31-5eb1a635626mr5826174137.7.1766573015767;
        Wed, 24 Dec 2025 02:43:35 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-19.dlp.protect.broadcom.com. [144.49.247.19])
        by smtp-relay.gmail.com with ESMTPS id ada2fe7eead31-5eb1aa5375fsm2341408137.1.2025.12.24.02.43.35
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Dec 2025 02:43:35 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b62da7602a0so6000183a12.2
        for <stable@vger.kernel.org>; Wed, 24 Dec 2025 02:43:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1766573014; x=1767177814; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qs1L9yogvjoOS4UWjYKVRJa3NcwdJKzh6wcPXeXPOP0=;
        b=KsQeBJaLsuRW3y46EXnXALwJ0XwhI8HCsIXdvUAGuIxv9bNEd9D5n1iGDXnB5Gqtv1
         JoksMQBC8PNGC/sLJW19Np9u0kD+E7LdTMMuGxg7N75XLO9VL6mt/UcIaRzBWLO4lTnP
         KlSKa0XOVS5jFuBPdCsGplT8kAOBB+w1Ot9IE=
X-Received: by 2002:a05:7022:62a0:b0:11a:342e:8a98 with SMTP id a92af1059eb24-12172136c4emr20604529c88.0.1766573014256;
        Wed, 24 Dec 2025 02:43:34 -0800 (PST)
X-Received: by 2002:a05:7022:62a0:b0:11a:342e:8a98 with SMTP id a92af1059eb24-12172136c4emr20604480c88.0.1766573013386;
        Wed, 24 Dec 2025 02:43:33 -0800 (PST)
Received: from photon-dev-haas.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1217254c734sm68746919c88.13.2025.12.24.02.43.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Dec 2025 02:43:33 -0800 (PST)
From: Ajay Kaher <ajay.kaher@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: dave.hansen@linux.intel.com,
	luto@kernel.org,
	peterz@infradead.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	hpa@zytor.com,
	akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vamsi-krishna.brahmajosyula@broadcom.com,
	yin.ding@broadcom.com,
	tapas.kundu@broadcom.com,
	xingwei lee <xrivendell7@gmail.com>,
	yuxin wang <wang1315768607@163.com>,
	Marius Fleischer <fleischermarius@gmail.com>,
	David Hildenbrand <david@redhat.com>,
	Ingo Molnar <mingo@kernel.org>,
	Rik van Riel <riel@surriel.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH v6.1 2/2] x86/mm/pat: Fix VM_PAT handling when fork() fails in copy_page_range()
Date: Wed, 24 Dec 2025 10:24:32 +0000
Message-Id: <20251224102432.923410-3-ajay.kaher@broadcom.com>
X-Mailer: git-send-email 2.40.4
In-Reply-To: <20251224102432.923410-1-ajay.kaher@broadcom.com>
References: <20251224102432.923410-1-ajay.kaher@broadcom.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

From: David Hildenbrand <david@redhat.com>

[ Upstream commit dc84bc2aba85a1508f04a936f9f9a15f64ebfb31 ]

If track_pfn_copy() fails, we already added the dst VMA to the maple
tree. As fork() fails, we'll cleanup the maple tree, and stumble over
the dst VMA for which we neither performed any reservation nor copied
any page tables.

Consequently untrack_pfn() will see VM_PAT and try obtaining the
PAT information from the page table -- which fails because the page
table was not copied.

The easiest fix would be to simply clear the VM_PAT flag of the dst VMA
if track_pfn_copy() fails. However, the whole thing is about "simply"
clearing the VM_PAT flag is shaky as well: if we passed track_pfn_copy()
and performed a reservation, but copying the page tables fails, we'll
simply clear the VM_PAT flag, not properly undoing the reservation ...
which is also wrong.

So let's fix it properly: set the VM_PAT flag only if the reservation
succeeded (leaving it clear initially), and undo the reservation if
anything goes wrong while copying the page tables: clearing the VM_PAT
flag after undoing the reservation.

Note that any copied page table entries will get zapped when the VMA will
get removed later, after copy_page_range() succeeded; as VM_PAT is not set
then, we won't try cleaning VM_PAT up once more and untrack_pfn() will be
happy. Note that leaving these page tables in place without a reservation
is not a problem, as we are aborting fork(); this process will never run.

A reproducer can trigger this usually at the first try:

  https://gitlab.com/davidhildenbrand/scratchspace/-/raw/main/reproducers/pat_fork.c

  WARNING: CPU: 26 PID: 11650 at arch/x86/mm/pat/memtype.c:983 get_pat_info+0xf6/0x110
  Modules linked in: ...
  CPU: 26 UID: 0 PID: 11650 Comm: repro3 Not tainted 6.12.0-rc5+ #92
  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-2.fc40 04/01/2014
  RIP: 0010:get_pat_info+0xf6/0x110
  ...
  Call Trace:
   <TASK>
   ...
   untrack_pfn+0x52/0x110
   unmap_single_vma+0xa6/0xe0
   unmap_vmas+0x105/0x1f0
   exit_mmap+0xf6/0x460
   __mmput+0x4b/0x120
   copy_process+0x1bf6/0x2aa0
   kernel_clone+0xab/0x440
   __do_sys_clone+0x66/0x90
   do_syscall_64+0x95/0x180

Likely this case was missed in:

  d155df53f310 ("x86/mm/pat: clear VM_PAT if copy_p4d_range failed")

... and instead of undoing the reservation we simply cleared the VM_PAT flag.

Keep the documentation of these functions in include/linux/pgtable.h,
one place is more than sufficient -- we should clean that up for the other
functions like track_pfn_remap/untrack_pfn separately.

Fixes: d155df53f310 ("x86/mm/pat: clear VM_PAT if copy_p4d_range failed")
Fixes: 2ab640379a0a ("x86: PAT: hooks in generic vm code to help archs to track pfnmap regions - v3")
Reported-by: xingwei lee <xrivendell7@gmail.com>
Reported-by: yuxin wang <wang1315768607@163.com>
Reported-by: Marius Fleischer <fleischermarius@gmail.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
Link: https://lore.kernel.org/r/20250321112323.153741-1-david@redhat.com
Closes: https://lore.kernel.org/lkml/CABOYnLx_dnqzpCW99G81DmOr+2UzdmZMk=T3uxwNxwz+R1RAwg@mail.gmail.com/
Closes: https://lore.kernel.org/lkml/CAJg=8jwijTP5fre8woS4JVJQ8iUA6v+iNcsOgtj9Zfpc3obDOQ@mail.gmail.com/
Signed-off-by: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org
[ Ajay: Modified to apply on v6.1 ]
Signed-off-by: Ajay Kaher <ajay.kaher@broadcom.com>
---
 arch/x86/mm/pat/memtype.c | 52 +++++++++++++++++++++------------------
 include/linux/pgtable.h   | 28 ++++++++++++++++-----
 kernel/fork.c             |  4 +++
 mm/memory.c               | 11 +++------
 4 files changed, 58 insertions(+), 37 deletions(-)

diff --git a/arch/x86/mm/pat/memtype.c b/arch/x86/mm/pat/memtype.c
index 1ad881017..67438ed59 100644
--- a/arch/x86/mm/pat/memtype.c
+++ b/arch/x86/mm/pat/memtype.c
@@ -1029,29 +1029,42 @@ static int get_pat_info(struct vm_area_struct *vma, resource_size_t *paddr,
 	return -EINVAL;
 }
 
-/*
- * track_pfn_copy is called when vma that is covering the pfnmap gets
- * copied through copy_page_range().
- *
- * If the vma has a linear pfn mapping for the entire range, we get the prot
- * from pte and reserve the entire vma range with single reserve_pfn_range call.
- */
-int track_pfn_copy(struct vm_area_struct *vma)
+int track_pfn_copy(struct vm_area_struct *dst_vma,
+		struct vm_area_struct *src_vma, unsigned long *pfn)
 {
+	const unsigned long vma_size = src_vma->vm_end - src_vma->vm_start;
 	resource_size_t paddr;
-	unsigned long vma_size = vma->vm_end - vma->vm_start;
 	pgprot_t pgprot;
+	int rc;
 
-	if (vma->vm_flags & VM_PAT) {
-		if (get_pat_info(vma, &paddr, &pgprot))
-			return -EINVAL;
-		/* reserve the whole chunk covered by vma. */
-		return reserve_pfn_range(paddr, vma_size, &pgprot, 1);
-	}
+	if (!(src_vma->vm_flags & VM_PAT))
+		return 0;
+
+	/*
+	 * Duplicate the PAT information for the dst VMA based on the src
+	 * VMA.
+	 */
+	if (get_pat_info(src_vma, &paddr, &pgprot))
+		return -EINVAL;
+	rc = reserve_pfn_range(paddr, vma_size, &pgprot, 1);
+	if (rc)
+		return rc;
 
+	/* Reservation for the destination VMA succeeded. */
+	dst_vma->vm_flags |= VM_PAT;
+	*pfn = PHYS_PFN(paddr);
 	return 0;
 }
 
+void untrack_pfn_copy(struct vm_area_struct *dst_vma, unsigned long pfn)
+{
+	untrack_pfn(dst_vma, pfn, dst_vma->vm_end - dst_vma->vm_start);
+	/*
+	 * Reservation was freed, any copied page tables will get cleaned
+	 * up later, but without getting PAT involved again.
+	 */
+}
+
 /*
  * prot is passed in as a parameter for the new mapping. If the vma has
  * a linear pfn mapping for the entire range, or no vma is provided,
@@ -1136,15 +1149,6 @@ void untrack_pfn(struct vm_area_struct *vma, unsigned long pfn,
 		vma->vm_flags &= ~VM_PAT;
 }
 
-/*
- * untrack_pfn_clear is called if the following situation fits:
- *
- * 1) while mremapping a pfnmap for a new region,  with the old vma after
- * its pfnmap page table has been removed.  The new vma has a new pfnmap
- * to the same pfn & cache type with VM_PAT set.
- * 2) while duplicating vm area, the new vma fails to copy the pgtable from
- * old vma.
- */
 void untrack_pfn_clear(struct vm_area_struct *vma)
 {
 	vma->vm_flags &= ~VM_PAT;
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 500a612ff..943c47c95 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -1195,14 +1195,25 @@ static inline void track_pfn_insert(struct vm_area_struct *vma, pgprot_t *prot,
 }
 
 /*
- * track_pfn_copy is called when vma that is covering the pfnmap gets
- * copied through copy_page_range().
+ * track_pfn_copy is called when a VM_PFNMAP VMA is about to get the page
+ * tables copied during copy_page_range(). On success, stores the pfn to be
+ * passed to untrack_pfn_copy().
  */
-static inline int track_pfn_copy(struct vm_area_struct *vma)
+static inline int track_pfn_copy(struct vm_area_struct *dst_vma,
+		struct vm_area_struct *src_vma, unsigned long *pfn)
 {
 	return 0;
 }
 
+/*
+ * untrack_pfn_copy is called when a VM_PFNMAP VMA failed to copy during
+ * copy_page_range(), but after track_pfn_copy() was already called.
+ */
+static inline void untrack_pfn_copy(struct vm_area_struct *dst_vma,
+		unsigned long pfn)
+{
+}
+
 /*
  * untrack_pfn is called while unmapping a pfnmap for a region.
  * untrack can be called for a specific region indicated by pfn and size or
@@ -1214,8 +1225,10 @@ static inline void untrack_pfn(struct vm_area_struct *vma,
 }
 
 /*
- * untrack_pfn_clear is called while mremapping a pfnmap for a new region
- * or fails to copy pgtable during duplicate vm area.
+ * untrack_pfn_clear is called in the following cases on a VM_PFNMAP VMA:
+ *
+ * 1) During mremap() on the src VMA after the page tables were moved.
+ * 2) During fork() on the dst VMA, immediately after duplicating the src VMA.
  */
 static inline void untrack_pfn_clear(struct vm_area_struct *vma)
 {
@@ -1226,7 +1239,10 @@ extern int track_pfn_remap(struct vm_area_struct *vma, pgprot_t *prot,
 			   unsigned long size);
 extern void track_pfn_insert(struct vm_area_struct *vma, pgprot_t *prot,
 			     pfn_t pfn);
-extern int track_pfn_copy(struct vm_area_struct *vma);
+extern int track_pfn_copy(struct vm_area_struct *dst_vma,
+		struct vm_area_struct *src_vma, unsigned long *pfn);
+extern void untrack_pfn_copy(struct vm_area_struct *dst_vma,
+		unsigned long pfn);
 extern void untrack_pfn(struct vm_area_struct *vma, unsigned long pfn,
 			unsigned long size);
 extern void untrack_pfn_clear(struct vm_area_struct *vma);
diff --git a/kernel/fork.c b/kernel/fork.c
index cbd68079c..992068b7f 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -476,6 +476,10 @@ struct vm_area_struct *vm_area_dup(struct vm_area_struct *orig)
 		*new = data_race(*orig);
 		INIT_LIST_HEAD(&new->anon_vma_chain);
 		dup_anon_vma_name(orig, new);
+
+		/* track_pfn_copy() will later take care of copying internal state. */
+		if (unlikely(new->vm_flags & VM_PFNMAP))
+			untrack_pfn_clear(new);
 	}
 	return new;
 }
diff --git a/mm/memory.c b/mm/memory.c
index 41a03adcf..38e08d378 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1278,12 +1278,12 @@ int
 copy_page_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma)
 {
 	pgd_t *src_pgd, *dst_pgd;
-	unsigned long next;
 	unsigned long addr = src_vma->vm_start;
 	unsigned long end = src_vma->vm_end;
 	struct mm_struct *dst_mm = dst_vma->vm_mm;
 	struct mm_struct *src_mm = src_vma->vm_mm;
 	struct mmu_notifier_range range;
+	unsigned long next, pfn;
 	bool is_cow;
 	int ret;
 
@@ -1294,11 +1294,7 @@ copy_page_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma)
 		return copy_hugetlb_page_range(dst_mm, src_mm, dst_vma, src_vma);
 
 	if (unlikely(src_vma->vm_flags & VM_PFNMAP)) {
-		/*
-		 * We do not free on error cases below as remove_vma
-		 * gets called on error from higher level routine
-		 */
-		ret = track_pfn_copy(src_vma);
+		ret = track_pfn_copy(dst_vma, src_vma, &pfn);
 		if (ret)
 			return ret;
 	}
@@ -1335,7 +1331,6 @@ copy_page_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma)
 			continue;
 		if (unlikely(copy_p4d_range(dst_vma, src_vma, dst_pgd, src_pgd,
 					    addr, next))) {
-			untrack_pfn_clear(dst_vma);
 			ret = -ENOMEM;
 			break;
 		}
@@ -1345,6 +1340,8 @@ copy_page_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma)
 		raw_write_seqcount_end(&src_mm->write_protect_seq);
 		mmu_notifier_invalidate_range_end(&range);
 	}
+	if (ret && unlikely(src_vma->vm_flags & VM_PFNMAP))
+		untrack_pfn_copy(dst_vma, pfn);
 	return ret;
 }
 
-- 
2.40.4


