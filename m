Return-Path: <stable+bounces-165747-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F7E6B183C6
	for <lists+stable@lfdr.de>; Fri,  1 Aug 2025 16:29:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54A8D7A7890
	for <lists+stable@lfdr.de>; Fri,  1 Aug 2025 14:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B52B26B95B;
	Fri,  1 Aug 2025 14:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IGdlUFe7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6183269AFB;
	Fri,  1 Aug 2025 14:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754058559; cv=none; b=KQxqNOp48Qi6lDTDGziKVANiBYoFCmzBDFz9HIQDUF2H9alOs5+U3/nxxTq79+0v+//DuV3sSqfOq8Y9m7H2KjVjN2JqEUb3rMCzF1Y2fSl+h/en9GJi1zVbEo1xYQsjJd8zQncDk46XkH83rlpQ9vPBEg2hKs/cVEMx1D5UMm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754058559; c=relaxed/simple;
	bh=tFUMDxejLbYRp6nHK4kYnIu6fQ9xVWf6kSqvk6y4oP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PUDFp96G0mtlmm350ULkZJB5zsoqjFfgA8OTkEuyrKEO4v4y1GDLT+GqOH6Fl6TqXZ6tkkLSZ0dR56fIOPo7WpAbrkAcIVSenc2rQXeXVgdZyUUz2nG4PWOU4PuqbT7JXfYc8lmxmWoT/WflMC+jAr7q6wcMZ/CwJTtzDs1w4M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IGdlUFe7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 110C9C4CEE7;
	Fri,  1 Aug 2025 14:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754058559;
	bh=tFUMDxejLbYRp6nHK4kYnIu6fQ9xVWf6kSqvk6y4oP0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IGdlUFe7mmEULI2N9ygPLdMMRSR4pA41SrFviHUJ8QEYEgN9E49W/OVc9jAoqM5yO
	 jBLiDkxukEgInsuJof4aH/LNKu+djDxZpCXjDEKGHNk/Dab/TmqKrAbwHOvWgXKYlS
	 vkw0XV+y4yfKETXSi5+Kewi7ACROcVin4bWLpbvr0qZPo2upDxTU04CWk1ULDf/j86
	 wuv8EApB4qzxybl209R1QfcxF73JSynAzmrC7++ZP4Q2QwiqRydkUJdJ1F3lrGQJRj
	 GvARfYBAsQoe2adzE3tnYVUmqSrnq+ZA3rarJglHoTYO9PBvJMPW8lefI7ptSxPz3W
	 QwJPGAWbjRb8Q==
Date: Fri, 1 Aug 2025 10:29:17 -0400
From: Sasha Levin <sashal@kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, peterx@redhat.com,
	aarcange@redhat.com, surenb@google.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] mm/userfaultfd: fix missing PTE unmap for non-migration
 entries
Message-ID: <aIzPPWTaf_88i8-a@lappy>
References: <20250630031958.1225651-1-sashal@kernel.org>
 <20250630175746.e52af129fd2d88deecc25169@linux-foundation.org>
 <a4d8b292-154a-4d14-90e4-6c822acf1cfb@redhat.com>
 <aG06QBVeBJgluSqP@lappy>
 <a8f863b1-ea06-4396-b4da-4dca41e3d9a5@redhat.com>
 <aItjffoR7molh3QF@lappy>
 <214e78a0-7774-4b1e-8d85-9a66d2384744@redhat.com>
 <aIzAj9xUOPCsmZEG@lappy>
 <593b222e-1a62-475c-9502-76e128d3625d@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="X3x0H1EPY+A97Av3"
Content-Disposition: inline
In-Reply-To: <593b222e-1a62-475c-9502-76e128d3625d@redhat.com>


--X3x0H1EPY+A97Av3
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Fri, Aug 01, 2025 at 04:06:14PM +0200, David Hildenbrand wrote:
>On 01.08.25 15:26, Sasha Levin wrote:
>>On Thu, Jul 31, 2025 at 02:56:25PM +0200, David Hildenbrand wrote:
>>>On 31.07.25 14:37, Sasha Levin wrote:
>>>>On Tue, Jul 08, 2025 at 05:42:16PM +0200, David Hildenbrand wrote:
>>>>>On 08.07.25 17:33, Sasha Levin wrote:
>>>>>>On Tue, Jul 08, 2025 at 05:10:44PM +0200, David Hildenbrand wrote:
>>>>>>>On 01.07.25 02:57, Andrew Morton wrote:
>>>>>>>>On Sun, 29 Jun 2025 23:19:58 -0400 Sasha Levin <sashal@kernel.org> wrote:
>>>>>>>>
>>>>>>>>>When handling non-swap entries in move_pages_pte(), the error handling
>>>>>>>>>for entries that are NOT migration entries fails to unmap the page table
>>>>>>>>>entries before jumping to the error handling label.
>>>>>>>>>
>>>>>>>>>This results in a kmap/kunmap imbalance which on CONFIG_HIGHPTE systems
>>>>>>>>>triggers a WARNING in kunmap_local_indexed() because the kmap stack is
>>>>>>>>>corrupted.
>>>>>>>>>
>>>>>>>>>Example call trace on ARM32 (CONFIG_HIGHPTE enabled):
>>>>>>>>>   WARNING: CPU: 1 PID: 633 at mm/highmem.c:622 kunmap_local_indexed+0x178/0x17c
>>>>>>>>>   Call trace:
>>>>>>>>>     kunmap_local_indexed from move_pages+0x964/0x19f4
>>>>>>>>>     move_pages from userfaultfd_ioctl+0x129c/0x2144
>>>>>>>>>     userfaultfd_ioctl from sys_ioctl+0x558/0xd24
>>>>>>>>>
>>>>>>>>>The issue was introduced with the UFFDIO_MOVE feature but became more
>>>>>>>>>frequent with the addition of guard pages (commit 7c53dfbdb024 ("mm: add
>>>>>>>>>PTE_MARKER_GUARD PTE marker")) which made the non-migration entry code
>>>>>>>>>path more commonly executed during userfaultfd operations.
>>>>>>>>>
>>>>>>>>>Fix this by ensuring PTEs are properly unmapped in all non-swap entry
>>>>>>>>>paths before jumping to the error handling label, not just for migration
>>>>>>>>>entries.
>>>>>>>>
>>>>>>>>I don't get it.
>>>>>>>>
>>>>>>>>>--- a/mm/userfaultfd.c
>>>>>>>>>+++ b/mm/userfaultfd.c
>>>>>>>>>@@ -1384,14 +1384,15 @@ static int move_pages_pte(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd,
>>>>>>>>>  		entry = pte_to_swp_entry(orig_src_pte);
>>>>>>>>>  		if (non_swap_entry(entry)) {
>>>>>>>>>+			pte_unmap(src_pte);
>>>>>>>>>+			pte_unmap(dst_pte);
>>>>>>>>>+			src_pte = dst_pte = NULL;
>>>>>>>>>  			if (is_migration_entry(entry)) {
>>>>>>>>>-				pte_unmap(src_pte);
>>>>>>>>>-				pte_unmap(dst_pte);
>>>>>>>>>-				src_pte = dst_pte = NULL;
>>>>>>>>>  				migration_entry_wait(mm, src_pmd, src_addr);
>>>>>>>>>  				err = -EAGAIN;
>>>>>>>>>-			} else
>>>>>>>>>+			} else {
>>>>>>>>>  				err = -EFAULT;
>>>>>>>>>+			}
>>>>>>>>>  			goto out;
>>>>>>>>
>>>>>>>>where we have
>>>>>>>>
>>>>>>>>out:
>>>>>>>>	...
>>>>>>>>	if (dst_pte)
>>>>>>>>		pte_unmap(dst_pte);
>>>>>>>>	if (src_pte)
>>>>>>>>		pte_unmap(src_pte);
>>>>>>>
>>>>>>>AI slop?
>>>>>>
>>>>>>Nah, this one is sadly all me :(
>>>>>
>>>>>Haha, sorry :P
>>>>
>>>>So as I was getting nowhere with this, I asked AI to help me :)
>>>>
>>>>If you're not interested in reading LLM generated code, feel free to
>>>>stop reading now...
>>>>
>>>>After it went over the logs, and a few prompts to point it the right
>>>>way, it ended up generating a patch (below) that made sense, and fixed
>>>>the warning that LKFT was being able to trigger.
>>>>
>>>>If anyone who's more familiar with the code than me (and the AI) agrees
>>>>with the patch and ways to throw their Reviewed-by, I'll send out the
>>>>patch.
>>>
>>>Seems to check out for me. In particular, out pte_unmap() everywhere
>>>else in that function (and mremap.c:move_ptes) are ordered properly.
>>>
>>>Even if it would not fix the issue, it would be a cleanup :)
>>>
>>>Acked-by: David Hildenbrand <david@redhat.com>
>>
>>David, I ended up LLM generating a .cocci script to detect this type of
>>issues, and it ended up detecting a similar issue in
>>arch/loongarch/mm/init.c.
>
>Does loongarch have these kmap_local restrictions?
>
>>
>>Would you be open to reviewing both the .cocci script as well as the
>>loongarch fix?
>
>Sure, if it's prechecked by you no problem.

Yup. Though I definitely learned a thing or two about Coccinelle patches
during this experiment.

-- 
Thanks,
Sasha

--X3x0H1EPY+A97Av3
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-coccinelle-add-semantic-patch-to-detect-kmap_local-L.patch"

From 8beef54a334bb244574506491472e1c955388198 Mon Sep 17 00:00:00 2001
From: Sasha Levin <sashal@kernel.org>
Date: Fri, 1 Aug 2025 08:47:24 -0400
Subject: [PATCH 1/2] coccinelle: add semantic patch to detect kmap_local LIFO
 violations

Add a Coccinelle semantic patch to detect violations of kmap_local's
Last-In-First-Out (LIFO) ordering requirement. When using kmap_local_page(),
kmap_atomic(), pte_offset_map(), or pte_offset_map_rw_nolock() variants,
the mappings must be unmapped in reverse order to maintain correct highmem
slot ordering.

This semantic patch identifies patterns where:
- Multiple kmap operations are unmapped in the wrong order
- The same pattern applies to pte_offset_map() and kmap_atomic()
- Conditional unmapping patterns that violate LIFO ordering

These violations can cause warnings on CONFIG_HIGHPTE systems:
  WARNING: CPU: 0 PID: 604 at mm/highmem.c:622 kunmap_local_indexed+0x178/0x17c
  addr \!= __fix_to_virt(FIX_KMAP_BEGIN + idx)

Co-developed-by: Claude claude-opus-4-20250514
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 scripts/coccinelle/api/kmap_local_lifo.cocci | 114 +++++++++++++++++++
 1 file changed, 114 insertions(+)
 create mode 100644 scripts/coccinelle/api/kmap_local_lifo.cocci

diff --git a/scripts/coccinelle/api/kmap_local_lifo.cocci b/scripts/coccinelle/api/kmap_local_lifo.cocci
new file mode 100644
index 000000000000..e6ba780753de
--- /dev/null
+++ b/scripts/coccinelle/api/kmap_local_lifo.cocci
@@ -0,0 +1,114 @@
+// SPDX-License-Identifier: GPL-2.0
+/// Detect violations of kmap_local LIFO ordering
+///
+/// kmap_local_page() and pte_offset_map() operations must follow
+/// Last-In-First-Out (LIFO) ordering. This means if you map A then B,
+/// you must unmap B then A.
+///
+// Confidence: High
+// Copyright: (C) 2025 Sasha Levin
+
+virtual report
+
+// Pattern 1: kmap_local_page() followed by kunmap_local() in wrong order
+@kmap_lifo@
+expression E1, E2;
+identifier ptr1 != ptr2;
+identifier ptr2;
+position p1, p2, p3, p4;
+@@
+
+ptr1 = kmap_local_page(E1)@p1;
+... when != kunmap_local(ptr1)
+ptr2 = kmap_local_page(E2)@p2;
+... when != kunmap_local(ptr1)
+    when != kunmap_local(ptr2)
+kunmap_local(ptr1)@p3;
+... when != kunmap_local(ptr2)
+kunmap_local(ptr2)@p4;
+
+@script:python depends on report@
+p1 << kmap_lifo.p1;
+p2 << kmap_lifo.p2;
+p3 << kmap_lifo.p3;
+ptr1 << kmap_lifo.ptr1;
+ptr2 << kmap_lifo.ptr2;
+@@
+
+coccilib.report.print_report(p3[0], "WARNING: kmap_local LIFO violation - %s mapped before %s but unmapped first" % (ptr1, ptr2))
+
+// Pattern 2: pte_offset_map() followed by pte_unmap() in wrong order
+@pte_lifo@
+expression E1, E2, E3, E4;
+identifier ptr1 != ptr2;
+identifier ptr2;
+position p1, p2, p3, p4;
+@@
+
+ptr1 = pte_offset_map(E1, E2)@p1;
+... when != pte_unmap(ptr1)
+ptr2 = pte_offset_map(E3, E4)@p2;
+... when != pte_unmap(ptr1)
+    when != pte_unmap(ptr2)
+pte_unmap(ptr1)@p3;
+... when != pte_unmap(ptr2)
+pte_unmap(ptr2)@p4;
+
+@script:python depends on report@
+p1 << pte_lifo.p1;
+p2 << pte_lifo.p2;
+p3 << pte_lifo.p3;
+ptr1 << pte_lifo.ptr1;
+ptr2 << pte_lifo.ptr2;
+@@
+
+coccilib.report.print_report(p3[0], "WARNING: pte_offset_map LIFO violation - %s mapped before %s but unmapped first" % (ptr1, ptr2))
+
+// Pattern 3: kmap_atomic() followed by kunmap_atomic() in wrong order
+@atomic_lifo@
+expression E1, E2;
+identifier ptr1 != ptr2;
+identifier ptr2;
+position p1, p2, p3, p4;
+@@
+
+ptr1 = kmap_atomic(E1)@p1;
+... when != kunmap_atomic(ptr1)
+ptr2 = kmap_atomic(E2)@p2;
+... when != kunmap_atomic(ptr1)
+    when != kunmap_atomic(ptr2)
+kunmap_atomic(ptr1)@p3;
+... when != kunmap_atomic(ptr2)
+kunmap_atomic(ptr2)@p4;
+
+@script:python depends on report@
+p1 << atomic_lifo.p1;
+p2 << atomic_lifo.p2;
+p3 << atomic_lifo.p3;
+ptr1 << atomic_lifo.ptr1;
+ptr2 << atomic_lifo.ptr2;
+@@
+
+coccilib.report.print_report(p3[0], "WARNING: kmap_atomic LIFO violation - %s mapped before %s but unmapped first" % (ptr1, ptr2))
+
+// Pattern 4: Specific pattern for userfaultfd conditional unmapping
+@userfault_pattern@
+identifier dst_pte, src_pte;
+position p1, p2, p3, p4;
+@@
+
+dst_pte@p1 = pte_offset_map_rw_nolock(...);
+... when exists
+src_pte@p2 = pte_offset_map_rw_nolock(...);
+... when exists
+when any
+if (dst_pte)
+	pte_unmap(dst_pte)@p3;
+if (src_pte)
+	pte_unmap(src_pte)@p4;
+
+@script:python depends on report@
+p3 << userfault_pattern.p3;
+@@
+
+coccilib.report.print_report(p3[0], "WARNING: pte_offset_map_rw_nolock LIFO violation - dst_pte mapped before src_pte but unmapped first")
-- 
2.39.5


--X3x0H1EPY+A97Av3
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0002-LoongArch-fix-kmap_local_page-LIFO-ordering-in-copy_.patch"

From a547687db03ecfe13ddc74e452357df78f880255 Mon Sep 17 00:00:00 2001
From: Sasha Levin <sashal@kernel.org>
Date: Fri, 1 Aug 2025 09:17:04 -0400
Subject: [PATCH 2/2] LoongArch: fix kmap_local_page() LIFO ordering in
 copy_user_highpage()

The current implementation violates kmap_local_page()'s LIFO ordering
requirement by unmapping the pages in the same order they were mapped.

This was introduced by commit 477a0ebec101 ("LoongArch: Replace
kmap_atomic() with kmap_local_page() in copy_user_highpage()") when
converting from kmap_atomic() to kmap_local_page(). The original code
correctly unmapped in reverse order, but the conversion swapped the
mapping order while keeping the unmapping order unchanged, resulting
in a LIFO violation.

kmap_local_page() requires unmapping to be done in reverse order
(Last-In-First-Out). Currently we map vfrom and then vto, but unmap
vfrom and then vto, which is incorrect. This patch corrects it to
unmap vto first, then vfrom.

This issue was detected by the kmap_local_lifo.cocci semantic patch.

Fixes: 477a0ebec101 ("LoongArch: Replace kmap_atomic() with kmap_local_page() in copy_user_highpage()")
Co-developed-by: Claude claude-opus-4-20250514
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/loongarch/mm/init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/loongarch/mm/init.c b/arch/loongarch/mm/init.c
index c3e4586a7975..01c43f455486 100644
--- a/arch/loongarch/mm/init.c
+++ b/arch/loongarch/mm/init.c
@@ -47,8 +47,8 @@ void copy_user_highpage(struct page *to, struct page *from,
 	vfrom = kmap_local_page(from);
 	vto = kmap_local_page(to);
 	copy_page(vto, vfrom);
-	kunmap_local(vfrom);
 	kunmap_local(vto);
+	kunmap_local(vfrom);
 	/* Make sure this page is cleared on other CPU's too before using it */
 	smp_wmb();
 }
-- 
2.39.5


--X3x0H1EPY+A97Av3--

