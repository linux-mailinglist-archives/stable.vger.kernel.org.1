Return-Path: <stable+bounces-7486-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A57ED8172C4
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:12:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6F111C24E6F
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 14:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 159553A1AD;
	Mon, 18 Dec 2023 14:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XFCyzZo3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A741D148;
	Mon, 18 Dec 2023 14:09:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58B99C433C7;
	Mon, 18 Dec 2023 14:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702908596;
	bh=BlXFZoDKz3PvDFbUAukcwOxObe04u9OxJUIbQ7X4RfE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XFCyzZo3YyCSiaCcZluNI/kgk/3zxWlW4f9tJ5zjd8SCd8VWmdX4LqivcW/ffR2oN
	 rD1bBZ9hps5s2UVlo6pIfMvXm1mmG+NogWovNtd/Wh9pYovLO9cg7VrmrXDwGJ+4KA
	 VWBceyBV0ImD1gpJ4Yfykka1dtJQhk2GTCnVWY38=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	James Houghton <jthoughton@google.com>,
	Will Deacon <will@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 5.10 50/62] arm64: mm: Always make sw-dirty PTEs hw-dirty in pte_modify
Date: Mon, 18 Dec 2023 14:52:14 +0100
Message-ID: <20231218135048.459906779@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231218135046.178317233@linuxfoundation.org>
References: <20231218135046.178317233@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: James Houghton <jthoughton@google.com>

commit 3c0696076aad60a2f04c019761921954579e1b0e upstream.

It is currently possible for a userspace application to enter an
infinite page fault loop when using HugeTLB pages implemented with
contiguous PTEs when HAFDBS is not available. This happens because:

1. The kernel may sometimes write PTEs that are sw-dirty but hw-clean
   (PTE_DIRTY | PTE_RDONLY | PTE_WRITE).

2. If, during a write, the CPU uses a sw-dirty, hw-clean PTE in handling
   the memory access on a system without HAFDBS, we will get a page
   fault.

3. HugeTLB will check if it needs to update the dirty bits on the PTE.
   For contiguous PTEs, it will check to see if the pgprot bits need
   updating. In this case, HugeTLB wants to write a sequence of
   sw-dirty, hw-dirty PTEs, but it finds that all the PTEs it is about
   to overwrite are all pte_dirty() (pte_sw_dirty() => pte_dirty()),
   so it thinks no update is necessary.

We can get the kernel to write a sw-dirty, hw-clean PTE with the
following steps (showing the relevant VMA flags and pgprot bits):

i.   Create a valid, writable contiguous PTE.
       VMA vmflags:     VM_SHARED | VM_READ | VM_WRITE
       VMA pgprot bits: PTE_RDONLY | PTE_WRITE
       PTE pgprot bits: PTE_DIRTY | PTE_WRITE

ii.  mprotect the VMA to PROT_NONE.
       VMA vmflags:     VM_SHARED
       VMA pgprot bits: PTE_RDONLY
       PTE pgprot bits: PTE_DIRTY | PTE_RDONLY

iii. mprotect the VMA back to PROT_READ | PROT_WRITE.
       VMA vmflags:     VM_SHARED | VM_READ | VM_WRITE
       VMA pgprot bits: PTE_RDONLY | PTE_WRITE
       PTE pgprot bits: PTE_DIRTY | PTE_WRITE | PTE_RDONLY

Make it impossible to create a writeable sw-dirty, hw-clean PTE with
pte_modify(). Such a PTE should be impossible to create, and there may
be places that assume that pte_dirty() implies pte_hw_dirty().

Signed-off-by: James Houghton <jthoughton@google.com>
Fixes: 031e6e6b4e12 ("arm64: hugetlb: Avoid unnecessary clearing in huge_ptep_set_access_flags")
Cc: <stable@vger.kernel.org>
Acked-by: Will Deacon <will@kernel.org>
Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
Link: https://lore.kernel.org/r/20231204172646.2541916-3-jthoughton@google.com
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/include/asm/pgtable.h |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -744,6 +744,12 @@ static inline pte_t pte_modify(pte_t pte
 	if (pte_hw_dirty(pte))
 		pte = pte_mkdirty(pte);
 	pte_val(pte) = (pte_val(pte) & ~mask) | (pgprot_val(newprot) & mask);
+	/*
+	 * If we end up clearing hw dirtiness for a sw-dirty PTE, set hardware
+	 * dirtiness again.
+	 */
+	if (pte_sw_dirty(pte))
+		pte = pte_mkdirty(pte);
 	return pte;
 }
 



