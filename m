Return-Path: <stable+bounces-133997-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F37A2A928DF
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 20:38:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29FE11B61A33
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 18:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18D19257426;
	Thu, 17 Apr 2025 18:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Kems5nmJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9714263C6C;
	Thu, 17 Apr 2025 18:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744914782; cv=none; b=HbL/dQqAvIjz7igdNC9x2KdSh650vs2Tr8SxkImgum8fHyAGKZIZNuSfYULZfllquYGPcNULZtVH9VQhjWrDQqdwynZ8nIUbu/zUKzCHmIlP4P8z2YDgyeAyRjaWvxc1fuvh8Vp7S/aDakurYAEVwSz+lWRHn3Nylj7dgNgRW0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744914782; c=relaxed/simple;
	bh=I4AmL69d0/OTqKqnzBRabh6iV8TSeqkeG/hvumrUtZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OBXEFdxsXuzLbA1HtjiE+YMS+yM0m0YoQxW9VB+KDhFonDxe8xoyL9xUqTBq8hZQKGViNNeQ9YETuf+h8fIAiO/IItZsX9I7z1tHbc8us8DEhk06eWuYidRnOIJKCLtrhYev0GIK5M2+XSWpju7uGkDSjCYMVNzrp38jGOEW000=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Kems5nmJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCB2EC4CEE4;
	Thu, 17 Apr 2025 18:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744914782;
	bh=I4AmL69d0/OTqKqnzBRabh6iV8TSeqkeG/hvumrUtZU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Kems5nmJoTA9R8zYH679HQhTG3tMv6UezA5hCKWXSpiMMcI1kvJxmwB/35fNhM2GS
	 HFCJHacRlNUp27JV6cn8vtmIg2bZxpMXw+XhKVzkyCRysmMhevatfUhnkx25ZFECMc
	 9x1aqzQ7AkU1j6Yg2CtHUtWmz6aSemHBEp1e39tE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ryan Roberts <ryan.roberts@arm.com>,
	David Hildenbrand <david@redhat.com>,
	Juergen Gross <jgross@suse.com>,
	Andreas Larsson <andreas@gaisler.com>,
	Borislav Betkov <bp@alien8.de>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Ingo Molnar <mingo@redhat.com>,
	"Matthew Wilcow (Oracle)" <willy@infradead.org>,
	Thomas Gleinxer <tglx@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.13 328/414] mm: fix lazy mmu docs and usage
Date: Thu, 17 Apr 2025 19:51:26 +0200
Message-ID: <20250417175124.626145750@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250417175111.386381660@linuxfoundation.org>
References: <20250417175111.386381660@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ryan Roberts <ryan.roberts@arm.com>

commit 691ee97e1a9de0cdb3efb893c1f180e3f4a35e32 upstream.

Patch series "Fix lazy mmu mode", v2.

I'm planning to implement lazy mmu mode for arm64 to optimize vmalloc.  As
part of that, I will extend lazy mmu mode to cover kernel mappings in
vmalloc table walkers.  While lazy mmu mode is already used for kernel
mappings in a few places, this will extend it's use significantly.

Having reviewed the existing lazy mmu implementations in powerpc, sparc
and x86, it looks like there are a bunch of bugs, some of which may be
more likely to trigger once I extend the use of lazy mmu.  So this series
attempts to clarify the requirements and fix all the bugs in advance of
that series.  See patch #1 commit log for all the details.


This patch (of 5):

The docs, implementations and use of arch_[enter|leave]_lazy_mmu_mode() is
a bit of a mess (to put it politely).  There are a number of issues
related to nesting of lazy mmu regions and confusion over whether the
task, when in a lazy mmu region, is preemptible or not.  Fix all the
issues relating to the core-mm.  Follow up commits will fix the
arch-specific implementations.  3 arches implement lazy mmu; powerpc,
sparc and x86.

When arch_[enter|leave]_lazy_mmu_mode() was first introduced by commit
6606c3e0da53 ("[PATCH] paravirt: lazy mmu mode hooks.patch"), it was
expected that lazy mmu regions would never nest and that the appropriate
page table lock(s) would be held while in the region, thus ensuring the
region is non-preemptible.  Additionally lazy mmu regions were only used
during manipulation of user mappings.

Commit 38e0edb15bd0 ("mm/apply_to_range: call pte function with lazy
updates") started invoking the lazy mmu mode in apply_to_pte_range(),
which is used for both user and kernel mappings.  For kernel mappings the
region is no longer protected by any lock so there is no longer any
guarantee about non-preemptibility.  Additionally, for RT configs, the
holding the PTL only implies no CPU migration, it doesn't prevent
preemption.

Commit bcc6cc832573 ("mm: add default definition of set_ptes()") added
arch_[enter|leave]_lazy_mmu_mode() to the default implementation of
set_ptes(), used by x86.  So after this commit, lazy mmu regions can be
nested.  Additionally commit 1a10a44dfc1d ("sparc64: implement the new
page table range API") and commit 9fee28baa601 ("powerpc: implement the
new page table range API") did the same for the sparc and powerpc
set_ptes() overrides.

powerpc couldn't deal with preemption so avoids it in commit b9ef323ea168
("powerpc/64s: Disable preemption in hash lazy mmu mode"), which
explicitly disables preemption for the whole region in its implementation.
x86 can support preemption (or at least it could until it tried to add
support nesting; more on this below).  Sparc looks to be totally broken in
the face of preemption, as far as I can tell.

powerpc can't deal with nesting, so avoids it in commit 47b8def9358c
("powerpc/mm: Avoid calling arch_enter/leave_lazy_mmu() in set_ptes"),
which removes the lazy mmu calls from its implementation of set_ptes().
x86 attempted to support nesting in commit 49147beb0ccb ("x86/xen: allow
nesting of same lazy mode") but as far as I can tell, this breaks its
support for preemption.

In short, it's all a mess; the semantics for
arch_[enter|leave]_lazy_mmu_mode() are not clearly defined and as a result
the implementations all have different expectations, sticking plasters and
bugs.

arm64 is aiming to start using these hooks, so let's clean everything up
before adding an arm64 implementation.  Update the documentation to state
that lazy mmu regions can never be nested, must not be called in interrupt
context and preemption may or may not be enabled for the duration of the
region.  And fix the generic implementation of set_ptes() to avoid
nesting.

arch-specific fixes to conform to the new spec will proceed this one.

These issues were spotted by code review and I have no evidence of issues
being reported in the wild.

Link: https://lkml.kernel.org/r/20250303141542.3371656-1-ryan.roberts@arm.com
Link: https://lkml.kernel.org/r/20250303141542.3371656-2-ryan.roberts@arm.com
Fixes: bcc6cc832573 ("mm: add default definition of set_ptes()")
Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
Acked-by: David Hildenbrand <david@redhat.com>
Acked-by: Juergen Gross <jgross@suse.com>
Cc: Andreas Larsson <andreas@gaisler.com>
Cc: Borislav Betkov <bp@alien8.de>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Juegren Gross <jgross@suse.com>
Cc: Matthew Wilcow (Oracle) <willy@infradead.org>
Cc: Thomas Gleinxer <tglx@linutronix.de>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/pgtable.h |   14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -222,10 +222,14 @@ static inline int pmd_dirty(pmd_t pmd)
  * hazard could result in the direct mode hypervisor case, since the actual
  * write to the page tables may not yet have taken place, so reads though
  * a raw PTE pointer after it has been modified are not guaranteed to be
- * up to date.  This mode can only be entered and left under the protection of
- * the page table locks for all page tables which may be modified.  In the UP
- * case, this is required so that preemption is disabled, and in the SMP case,
- * it must synchronize the delayed page table writes properly on other CPUs.
+ * up to date.
+ *
+ * In the general case, no lock is guaranteed to be held between entry and exit
+ * of the lazy mode. So the implementation must assume preemption may be enabled
+ * and cpu migration is possible; it must take steps to be robust against this.
+ * (In practice, for user PTE updates, the appropriate page table lock(s) are
+ * held, but for kernel PTE updates, no lock is held). Nesting is not permitted
+ * and the mode cannot be used in interrupt context.
  */
 #ifndef __HAVE_ARCH_ENTER_LAZY_MMU_MODE
 #define arch_enter_lazy_mmu_mode()	do {} while (0)
@@ -287,7 +291,6 @@ static inline void set_ptes(struct mm_st
 {
 	page_table_check_ptes_set(mm, ptep, pte, nr);
 
-	arch_enter_lazy_mmu_mode();
 	for (;;) {
 		set_pte(ptep, pte);
 		if (--nr == 0)
@@ -295,7 +298,6 @@ static inline void set_ptes(struct mm_st
 		ptep++;
 		pte = pte_next_pfn(pte);
 	}
-	arch_leave_lazy_mmu_mode();
 }
 #endif
 #define set_pte_at(mm, addr, ptep, pte) set_ptes(mm, addr, ptep, pte, 1)



