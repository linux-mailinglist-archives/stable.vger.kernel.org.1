Return-Path: <stable+bounces-191337-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D4526C11FBA
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 00:22:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 369944E9773
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 23:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D63632D0FA;
	Mon, 27 Oct 2025 23:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ufgn7wwv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E0532D0D8;
	Mon, 27 Oct 2025 23:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761607335; cv=none; b=SLhNiCj5tTocTz2FKy/52G/vEoA4a+yeJJNDTXTiCXYTAdKhXc4N4uIagAUeg80fNwpqcYLY7vCdfgkR0ui38/KuQDn82/gnXhgfxVoY4sUfcpdxWQ/RHNszAJTPrFmk9iDExpZnuv7Ha5noa+Pc7eun8jP+lESLB+/Mz8l3HFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761607335; c=relaxed/simple;
	bh=onxRzI4qOeKxeNuAcJ0ae/Pha4L/2LJ+E+8mbQS1rjs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=RHOtD0TLrF8otszBH6STXgoqypxX42vTYJ03OGAOvh31fOLOFMn+/Xai22fdteFMrQrsoihQObDuFka1emi5JzG79uzlBbNKSl1i/fxu4/cWh3NGasV6WRhGbKT613Ezwe+Rae6GcfTu8ify8l34Cl5/IhHXSjQi819MSU6kNZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ufgn7wwv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4548BC116B1;
	Mon, 27 Oct 2025 23:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761607335;
	bh=onxRzI4qOeKxeNuAcJ0ae/Pha4L/2LJ+E+8mbQS1rjs=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=Ufgn7wwvyEHJcYZm2u94ouAm/8OKru7xfw5V091ddfWYr9FvF3m1ze4nwm6AThnD6
	 C1u9dzYYCuQtC0mSexKvqflAl7SCsTBjBri8Skl6CMxU/9b7Ya/v7w41p2kcjgocxm
	 fOSwm6lrPaBd824qX26A6KQohob1A4m5OXX6Jt9GPHPPG6+x2waM4q3npwFYOSldsZ
	 JHpQE7yU9RhHmHInFAIYurnyLmj03wHwJRgTg07GHb0Eyj7KvEqhRD1GDYWY9oW9j/
	 gwynTtyxW3Q0/NRAS8NJnG3rG0bTcQ7gyExWms1Ml87HO3eKasgcO9+dwUyvTB1p3m
	 vYu1RiebHn/pQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C993CCF9E0;
	Mon, 27 Oct 2025 23:22:15 +0000 (UTC)
From: Dave Vasilevsky via B4 Relay <devnull+dave.vasilevsky.ca@kernel.org>
Date: Mon, 27 Oct 2025 19:21:47 -0400
Subject: [PATCH] powerpc: Fix mprotect on book3s32
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251027-vasi-mprotect-g3-v1-1-3c5187085f9a@vasilevsky.ca>
X-B4-Tracking: v=1; b=H4sIAIr+/2gC/x3MQQqAIBBA0avErBtQS5SuEi0ix5pFKhoRhHdPW
 r7F/y8UykwFpu6FTDcXjqFB9h1sxxp2QnbNoITSUiiD91oYz5TjRduF+4Deeq2MdaMcBbQsZfL
 8/Mt5qfUDcHtzDGIAAAA=
X-Change-ID: 20251027-vasi-mprotect-g3-f8f5278d4140
To: Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Nadav Amit <nadav.amit@gmail.com>, 
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Dave Vasilevsky <dave@vasilevsky.ca>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761607334; l=2972;
 i=dave@vasilevsky.ca; s=20251027; h=from:subject:message-id;
 bh=E1aBGzZxrKFyEjSh5tyf0kwyoQ+SazFw/xbQmkHQC8c=;
 b=stXn+ddNorVpT4m4xv4DpE0jTKLzbB53xuvhLM3AsQqN7nWd+GkbidV1wVWZ/ynrPTQgsSvxj
 RF8akzSsGFIAuOfxrGVn1gCyHKBiUqsfRdMLRLPFG2DkjhzYuR0HhW/
X-Developer-Key: i=dave@vasilevsky.ca; a=ed25519;
 pk=Jsd1btZeqqg6x6y73Dx0YrleQb3A3pCBnUeE0qmoKq4=
X-Endpoint-Received: by B4 Relay for dave@vasilevsky.ca/20251027 with
 auth_id=556
X-Original-From: Dave Vasilevsky <dave@vasilevsky.ca>
Reply-To: dave@vasilevsky.ca

From: Dave Vasilevsky <dave@vasilevsky.ca>

On 32-bit book3s with hash-MMUs, tlb_flush() was a no-op. This was
unnoticed because all uses until recently were for unmaps, and thus
handled by __tlb_remove_tlb_entry().

After commit 4a18419f71cd ("mm/mprotect: use mmu_gather") in kernel 5.19,
tlb_gather_mmu() started being used for mprotect as well. This caused
mprotect to simply not work on these machines:

  int *ptr = mmap(NULL, 4096, PROT_READ|PROT_WRITE,
                  MAP_PRIVATE|MAP_ANONYMOUS, -1, 0);
  *ptr = 1; // force HPTE to be created
  mprotect(ptr, 4096, PROT_READ);
  *ptr = 2; // should segfault, but succeeds

Fixed by making tlb_flush() actually flush TLB pages. This finally
agrees with the behaviour of boot3s64's tlb_flush().

Fixes: 4a18419f71cd ("mm/mprotect: use mmu_gather")
Signed-off-by: Dave Vasilevsky <dave@vasilevsky.ca>
---
 arch/powerpc/include/asm/book3s/32/tlbflush.h | 8 ++++++--
 arch/powerpc/mm/book3s32/tlb.c                | 6 ++++++
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/32/tlbflush.h b/arch/powerpc/include/asm/book3s/32/tlbflush.h
index e43534da5207aa3b0cb3c07b78e29b833c141f3f..b8c587ad2ea954f179246a57d6e86e45e91dcfdc 100644
--- a/arch/powerpc/include/asm/book3s/32/tlbflush.h
+++ b/arch/powerpc/include/asm/book3s/32/tlbflush.h
@@ -11,6 +11,7 @@
 void hash__flush_tlb_mm(struct mm_struct *mm);
 void hash__flush_tlb_page(struct vm_area_struct *vma, unsigned long vmaddr);
 void hash__flush_range(struct mm_struct *mm, unsigned long start, unsigned long end);
+void hash__flush_gather(struct mmu_gather *tlb);
 
 #ifdef CONFIG_SMP
 void _tlbie(unsigned long address);
@@ -28,9 +29,12 @@ void _tlbia(void);
  */
 static inline void tlb_flush(struct mmu_gather *tlb)
 {
-	/* 603 needs to flush the whole TLB here since it doesn't use a hash table. */
-	if (!mmu_has_feature(MMU_FTR_HPTE_TABLE))
+	if (mmu_has_feature(MMU_FTR_HPTE_TABLE)) {
+		hash__flush_gather(tlb);
+	} else {
+		/* 603 needs to flush the whole TLB here since it doesn't use a hash table. */
 		_tlbia();
+	}
 }
 
 static inline void flush_range(struct mm_struct *mm, unsigned long start, unsigned long end)
diff --git a/arch/powerpc/mm/book3s32/tlb.c b/arch/powerpc/mm/book3s32/tlb.c
index 9ad6b56bfec96e989b96f027d075ad5812500854..3da95ecfbbb296303082e378425e92a5fbdbfac8 100644
--- a/arch/powerpc/mm/book3s32/tlb.c
+++ b/arch/powerpc/mm/book3s32/tlb.c
@@ -105,3 +105,9 @@ void hash__flush_tlb_page(struct vm_area_struct *vma, unsigned long vmaddr)
 		flush_hash_pages(mm->context.id, vmaddr, pmd_val(*pmd), 1);
 }
 EXPORT_SYMBOL(hash__flush_tlb_page);
+
+void hash__flush_gather(struct mmu_gather *tlb)
+{
+	hash__flush_range(tlb->mm, tlb->start, tlb->end);
+}
+EXPORT_SYMBOL(hash__flush_gather);

---
base-commit: dcb6fa37fd7bc9c3d2b066329b0d27dedf8becaa
change-id: 20251027-vasi-mprotect-g3-f8f5278d4140

Best regards,
-- 
Dave Vasilevsky <dave@vasilevsky.ca>



