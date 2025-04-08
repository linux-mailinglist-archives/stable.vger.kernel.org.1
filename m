Return-Path: <stable+bounces-130155-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CEA43A802EA
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 13:51:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91A1D7A9ED7
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 11:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 173A8267F57;
	Tue,  8 Apr 2025 11:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="b+fHlOy7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BABF9227BA4;
	Tue,  8 Apr 2025 11:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744112964; cv=none; b=OWw9ZYt+H9BwErTbvx0tFBq5eOY8qWYI7QG1pXH3RDTP6Z6UCRexqiime8E8mEtu5xZqT8YCgikgSevNlGd0fdrMCRe1zwlJGPJekDxgJDbJ/6PvNil62SnGiVltUd40PlMM54+ZvNrRkAwwroEYkukZD0Shd8KEWIutQhE3q9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744112964; c=relaxed/simple;
	bh=baf+VIx/3EHoF2iI5/mVl6y+NGFuhh6jJA3HtTY4CQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X9IMsUcHtahQ6ZX3RJo+X4t1nyiYRPyy32iZsPZZI70Uebem4ErRDpxuKMj/IUDiscAr+lPxVRcpULJxgi4XwCEaLV3NiGRQgSVZ4AOnfRGs64x7ecXFe+9HlEIlQk5EkLl63FVnWSp0jB6hl5XYYtXPU76Y4J/fhtBu74K454M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=b+fHlOy7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9B4AC4CEE5;
	Tue,  8 Apr 2025 11:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744112964;
	bh=baf+VIx/3EHoF2iI5/mVl6y+NGFuhh6jJA3HtTY4CQQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b+fHlOy7pACPDjfs6qIzCKC0ihY75lCreZtlCWL27obEpRYcqOv+CuAx3TkNTvWM6
	 NWm/hHwC/can47gzjKYFYZuiCSddqYLP9psfZpf9AViSAfDmr5L1XySId5yvKsS6T+
	 i0kHfaQOJMUD7Z/Ar1v16Yb9I8kBaLqbRnTzkDTc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jann Horn <jannh@google.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [PATCH 5.15 264/279] x86/mm: Fix flush_tlb_range() when used for zapping normal PMDs
Date: Tue,  8 Apr 2025 12:50:47 +0200
Message-ID: <20250408104833.515324932@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104826.319283234@linuxfoundation.org>
References: <20250408104826.319283234@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jann Horn <jannh@google.com>

commit 3ef938c3503563bfc2ac15083557f880d29c2e64 upstream.

On the following path, flush_tlb_range() can be used for zapping normal
PMD entries (PMD entries that point to page tables) together with the PTE
entries in the pointed-to page table:

    collapse_pte_mapped_thp
      pmdp_collapse_flush
        flush_tlb_range

The arm64 version of flush_tlb_range() has a comment describing that it can
be used for page table removal, and does not use any last-level
invalidation optimizations. Fix the X86 version by making it behave the
same way.

Currently, X86 only uses this information for the following two purposes,
which I think means the issue doesn't have much impact:

 - In native_flush_tlb_multi() for checking if lazy TLB CPUs need to be
   IPI'd to avoid issues with speculative page table walks.
 - In Hyper-V TLB paravirtualization, again for lazy TLB stuff.

The patch "x86/mm: only invalidate final translations with INVLPGB" which
is currently under review (see
<https://lore.kernel.org/all/20241230175550.4046587-13-riel@surriel.com/>)
would probably be making the impact of this a lot worse.

Fixes: 016c4d92cd16 ("x86/mm/tlb: Add freed_tables argument to flush_tlb_mm_range")
Signed-off-by: Jann Horn <jannh@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/20250103-x86-collapse-flush-fix-v1-1-3c521856cfa6@google.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/include/asm/tlbflush.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -227,7 +227,7 @@ void flush_tlb_multi(const struct cpumas
 	flush_tlb_mm_range((vma)->vm_mm, start, end,			\
 			   ((vma)->vm_flags & VM_HUGETLB)		\
 				? huge_page_shift(hstate_vma(vma))	\
-				: PAGE_SHIFT, false)
+				: PAGE_SHIFT, true)
 
 extern void flush_tlb_all(void);
 extern void flush_tlb_mm_range(struct mm_struct *mm, unsigned long start,



