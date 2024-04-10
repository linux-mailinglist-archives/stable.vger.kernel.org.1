Return-Path: <stable+bounces-37945-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E76C589EF29
	for <lists+stable@lfdr.de>; Wed, 10 Apr 2024 11:49:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F0652821E5
	for <lists+stable@lfdr.de>; Wed, 10 Apr 2024 09:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F30C156C6A;
	Wed, 10 Apr 2024 09:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Esn2y6qK"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6EF156C61
	for <stable@vger.kernel.org>; Wed, 10 Apr 2024 09:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712742581; cv=none; b=aStx9kBwbovHfmvHo6lQXejVbbJUEvmSi491r2ya5y5s58jsv8fZ+hw+XmDHa4d0r32odfnaq//qf49+zOIU5u/HIr3uOQ8QhKDWCiEEd/5SepuWqna1LFCuGuN/40Vf4Vkk7S9hnKf72rwPvR8MkyD20uNEqCMvTuVuM2t3Xc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712742581; c=relaxed/simple;
	bh=Dz0U4MtKKt62/93kSPJLvqY+NprcC08lHXPgjHscEu4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l7Wb9CF2OPwPYMxgZFVcel4ZvVDjKkVdIzu5syZx0ZMIe36XLpTdXrbOIGN1jUctMFEgB/R/XWHC62qpXzEkEQ+pDRbu4wZfc8ZhxppjMnllPj7U2ZJZRKIDXr5+9v/KfAr+g6FAw05qsy7YfOuEHo2NjSFqkiz8DTNgLGT51Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Esn2y6qK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712742576;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SLgkdtKP5xEvuxJfv510L2IZoMaLRA49O3EEV48gyjg=;
	b=Esn2y6qK5MmBjO+fYXetg8/0aIqkwcF/6QpYTngaNNJb0L+7OS1Y4YN970H/UK2PRGsv6H
	GLKOwi1UqH2CflgY/KWPoP6hFChN+BMT7d6R0MRr6sNd4t056BOVVOgFgG9Ku9P70vnQFp
	3gEMt/uhFr8Xhvf4NZtDJMeAwMK4b0Y=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-112-SrgoXWhqN_ehkFSCzEqENw-1; Wed, 10 Apr 2024 05:49:33 -0400
X-MC-Unique: SrgoXWhqN_ehkFSCzEqENw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8B3AA180A577;
	Wed, 10 Apr 2024 09:49:32 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.193.162])
	by smtp.corp.redhat.com (Postfix) with ESMTP id DB4E1490F9;
	Wed, 10 Apr 2024 09:49:29 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: stable@vger.kernel.org
Cc: David Hildenbrand <david@redhat.com>,
	Wupeng Ma <mawupeng1@huawei.com>,
	Ingo Molnar <mingo@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 5.4.y] x86/mm/pat: fix VM_PAT handling in COW mappings
Date: Wed, 10 Apr 2024 11:49:08 +0200
Message-ID: <20240410094908.191993-1-david@redhat.com>
In-Reply-To: <2024040847-departure-lining-fed7@gregkh>
References: <2024040847-departure-lining-fed7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

PAT handling won't do the right thing in COW mappings: the first PTE (or,
in fact, all PTEs) can be replaced during write faults to point at anon
folios.  Reliably recovering the correct PFN and cachemode using
follow_phys() from PTEs will not work in COW mappings.

Using follow_phys(), we might just get the address+protection of the anon
folio (which is very wrong), or fail on swap/nonswap entries, failing
follow_phys() and triggering a WARN_ON_ONCE() in untrack_pfn() and
track_pfn_copy(), not properly calling free_pfn_range().

In free_pfn_range(), we either wouldn't call memtype_free() or would call
it with the wrong range, possibly leaking memory.

To fix that, let's update follow_phys() to refuse returning anon folios,
and fallback to using the stored PFN inside vma->vm_pgoff for COW mappings
if we run into that.

We will now properly handle untrack_pfn() with COW mappings, where we
don't need the cachemode.  We'll have to fail fork()->track_pfn_copy() if
the first page was replaced by an anon folio, though: we'd have to store
the cachemode in the VMA to make this work, likely growing the VMA size.

For now, lets keep it simple and let track_pfn_copy() just fail in that
case: it would have failed in the past with swap/nonswap entries already,
and it would have done the wrong thing with anon folios.

Simple reproducer to trigger the WARN_ON_ONCE() in untrack_pfn():

<--- C reproducer --->
 #include <stdio.h>
 #include <sys/mman.h>
 #include <unistd.h>
 #include <liburing.h>

 int main(void)
 {
         struct io_uring_params p = {};
         int ring_fd;
         size_t size;
         char *map;

         ring_fd = io_uring_setup(1, &p);
         if (ring_fd < 0) {
                 perror("io_uring_setup");
                 return 1;
         }
         size = p.sq_off.array + p.sq_entries * sizeof(unsigned);

         /* Map the submission queue ring MAP_PRIVATE */
         map = mmap(0, size, PROT_READ | PROT_WRITE, MAP_PRIVATE,
                    ring_fd, IORING_OFF_SQ_RING);
         if (map == MAP_FAILED) {
                 perror("mmap");
                 return 1;
         }

         /* We have at least one page. Let's COW it. */
         *map = 0;
         pause();
         return 0;
 }
<--- C reproducer --->

On a system with 16 GiB RAM and swap configured:
 # ./iouring &
 # memhog 16G
 # killall iouring
[  301.552930] ------------[ cut here ]------------
[  301.553285] WARNING: CPU: 7 PID: 1402 at arch/x86/mm/pat/memtype.c:1060 untrack_pfn+0xf4/0x100
[  301.553989] Modules linked in: binfmt_misc nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_g
[  301.558232] CPU: 7 PID: 1402 Comm: iouring Not tainted 6.7.5-100.fc38.x86_64 #1
[  301.558772] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebu4
[  301.559569] RIP: 0010:untrack_pfn+0xf4/0x100
[  301.559893] Code: 75 c4 eb cf 48 8b 43 10 8b a8 e8 00 00 00 3b 6b 28 74 b8 48 8b 7b 30 e8 ea 1a f7 000
[  301.561189] RSP: 0018:ffffba2c0377fab8 EFLAGS: 00010282
[  301.561590] RAX: 00000000ffffffea RBX: ffff9208c8ce9cc0 RCX: 000000010455e047
[  301.562105] RDX: 07fffffff0eb1e0a RSI: 0000000000000000 RDI: ffff9208c391d200
[  301.562628] RBP: 0000000000000000 R08: ffffba2c0377fab8 R09: 0000000000000000
[  301.563145] R10: ffff9208d2292d50 R11: 0000000000000002 R12: 00007fea890e0000
[  301.563669] R13: 0000000000000000 R14: ffffba2c0377fc08 R15: 0000000000000000
[  301.564186] FS:  0000000000000000(0000) GS:ffff920c2fbc0000(0000) knlGS:0000000000000000
[  301.564773] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  301.565197] CR2: 00007fea88ee8a20 CR3: 00000001033a8000 CR4: 0000000000750ef0
[  301.565725] PKRU: 55555554
[  301.565944] Call Trace:
[  301.566148]  <TASK>
[  301.566325]  ? untrack_pfn+0xf4/0x100
[  301.566618]  ? __warn+0x81/0x130
[  301.566876]  ? untrack_pfn+0xf4/0x100
[  301.567163]  ? report_bug+0x171/0x1a0
[  301.567466]  ? handle_bug+0x3c/0x80
[  301.567743]  ? exc_invalid_op+0x17/0x70
[  301.568038]  ? asm_exc_invalid_op+0x1a/0x20
[  301.568363]  ? untrack_pfn+0xf4/0x100
[  301.568660]  ? untrack_pfn+0x65/0x100
[  301.568947]  unmap_single_vma+0xa6/0xe0
[  301.569247]  unmap_vmas+0xb5/0x190
[  301.569532]  exit_mmap+0xec/0x340
[  301.569801]  __mmput+0x3e/0x130
[  301.570051]  do_exit+0x305/0xaf0
...

Link: https://lkml.kernel.org/r/20240403212131.929421-3-david@redhat.com
Signed-off-by: David Hildenbrand <david@redhat.com>
Reported-by: Wupeng Ma <mawupeng1@huawei.com>
Closes: https://lkml.kernel.org/r/20240227122814.3781907-1-mawupeng1@huawei.com
Fixes: b1a86e15dc03 ("x86, pat: remove the dependency on 'vm_pgoff' in track/untrack pfn vma routines")
Fixes: 5899329b1910 ("x86: PAT: implement track/untrack of pfnmap regions for x86 - v3")
Acked-by: Ingo Molnar <mingo@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit 04c35ab3bdae7fefbd7c7a7355f29fa03a035221)
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/x86/mm/pat.c | 50 ++++++++++++++++++++++++++++++++++-------------
 mm/memory.c       |  4 ++++
 2 files changed, 40 insertions(+), 14 deletions(-)

diff --git a/arch/x86/mm/pat.c b/arch/x86/mm/pat.c
index c7c4e2f8c6a5..39d1c35e7491 100644
--- a/arch/x86/mm/pat.c
+++ b/arch/x86/mm/pat.c
@@ -34,6 +34,7 @@
 
 #include "pat_internal.h"
 #include "mm_internal.h"
+#include "../../mm/internal.h"	/* is_cow_mapping() */
 
 #undef pr_fmt
 #define pr_fmt(fmt) "" fmt
@@ -955,6 +956,38 @@ static void free_pfn_range(u64 paddr, unsigned long size)
 		free_memtype(paddr, paddr + size);
 }
 
+static int get_pat_info(struct vm_area_struct *vma, resource_size_t *paddr,
+		pgprot_t *pgprot)
+{
+	unsigned long prot;
+
+	VM_WARN_ON_ONCE(!(vma->vm_flags & VM_PAT));
+
+	/*
+	 * We need the starting PFN and cachemode used for track_pfn_remap()
+	 * that covered the whole VMA. For most mappings, we can obtain that
+	 * information from the page tables. For COW mappings, we might now
+	 * suddenly have anon folios mapped and follow_phys() will fail.
+	 *
+	 * Fallback to using vma->vm_pgoff, see remap_pfn_range_notrack(), to
+	 * detect the PFN. If we need the cachemode as well, we're out of luck
+	 * for now and have to fail fork().
+	 */
+	if (!follow_phys(vma, vma->vm_start, 0, &prot, paddr)) {
+		if (pgprot)
+			*pgprot = __pgprot(prot);
+		return 0;
+	}
+	if (is_cow_mapping(vma->vm_flags)) {
+		if (pgprot)
+			return -EINVAL;
+		*paddr = (resource_size_t)vma->vm_pgoff << PAGE_SHIFT;
+		return 0;
+	}
+	WARN_ON_ONCE(1);
+	return -EINVAL;
+}
+
 /*
  * track_pfn_copy is called when vma that is covering the pfnmap gets
  * copied through copy_page_range().
@@ -965,20 +998,13 @@ static void free_pfn_range(u64 paddr, unsigned long size)
 int track_pfn_copy(struct vm_area_struct *vma)
 {
 	resource_size_t paddr;
-	unsigned long prot;
 	unsigned long vma_size = vma->vm_end - vma->vm_start;
 	pgprot_t pgprot;
 
 	if (vma->vm_flags & VM_PAT) {
-		/*
-		 * reserve the whole chunk covered by vma. We need the
-		 * starting address and protection from pte.
-		 */
-		if (follow_phys(vma, vma->vm_start, 0, &prot, &paddr)) {
-			WARN_ON_ONCE(1);
+		if (get_pat_info(vma, &paddr, &pgprot))
 			return -EINVAL;
-		}
-		pgprot = __pgprot(prot);
+		/* reserve the whole chunk covered by vma. */
 		return reserve_pfn_range(paddr, vma_size, &pgprot, 1);
 	}
 
@@ -1053,7 +1079,6 @@ void untrack_pfn(struct vm_area_struct *vma, unsigned long pfn,
 		 unsigned long size)
 {
 	resource_size_t paddr;
-	unsigned long prot;
 
 	if (vma && !(vma->vm_flags & VM_PAT))
 		return;
@@ -1061,11 +1086,8 @@ void untrack_pfn(struct vm_area_struct *vma, unsigned long pfn,
 	/* free the chunk starting from pfn or the whole chunk */
 	paddr = (resource_size_t)pfn << PAGE_SHIFT;
 	if (!paddr && !size) {
-		if (follow_phys(vma, vma->vm_start, 0, &prot, &paddr)) {
-			WARN_ON_ONCE(1);
+		if (get_pat_info(vma, &paddr, NULL))
 			return;
-		}
-
 		size = vma->vm_end - vma->vm_start;
 	}
 	free_pfn_range(paddr, size);
diff --git a/mm/memory.c b/mm/memory.c
index d514f69d9717..f8d76c66311d 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4428,6 +4428,10 @@ int follow_phys(struct vm_area_struct *vma,
 		goto out;
 	pte = *ptep;
 
+	/* Never return PFNs of anon folios in COW mappings. */
+	if (vm_normal_page(vma, address, pte))
+		goto unlock;
+
 	if ((flags & FOLL_WRITE) && !pte_write(pte))
 		goto unlock;
 
-- 
2.44.0


