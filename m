Return-Path: <stable+bounces-194613-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 414EBC521EF
	for <lists+stable@lfdr.de>; Wed, 12 Nov 2025 12:55:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 71B6C4EDE47
	for <lists+stable@lfdr.de>; Wed, 12 Nov 2025 11:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF20A313556;
	Wed, 12 Nov 2025 11:50:42 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC0BF314A67;
	Wed, 12 Nov 2025 11:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762948242; cv=none; b=bXTojtJ9Ark+62/CdnGjH9GZS7c5yeakILwk5wSuUm0hJcWV2W9uY6WURJNkFJfFmUk6IpUTOrDlqEKSmmlzxqdCkZXWbXs7QfkpdWYbMD3mRbfsLQE81hI1KFnuFQ0807m/A1U3CufgyU/bmVjpi6+BmM5i9R6hvSE8yLwplXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762948242; c=relaxed/simple;
	bh=wH9YiYK5vf3a4Yc3A4ClIKZkBIbThYXlZe1vwVAK5SM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pnnL8CdK6O4ciiyezyMT1ZMNaIRO1/cC0QH2w1vIGqC1hYMxaJptZtneRH9Z4ErQ/DWrvxNXjL7X71cLu2hy373e6SXfEMpY4uRd3MAo2EELJdWXdBIPYCbVFmMFViTx3WrkRk6JNbn9gGgw0svKcUBHyd00wsCWVPaNYIYhGZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub4.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4d616J1lGlz9sSb;
	Wed, 12 Nov 2025 12:15:36 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IDngTuJZ3gRw; Wed, 12 Nov 2025 12:15:36 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4d616J0kqSz9sSZ;
	Wed, 12 Nov 2025 12:15:36 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 03A088B76E;
	Wed, 12 Nov 2025 12:15:36 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id WbBSOMNQv6aS; Wed, 12 Nov 2025 12:15:35 +0100 (CET)
Received: from [192.168.235.99] (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 69C278B764;
	Wed, 12 Nov 2025 12:15:35 +0100 (CET)
Message-ID: <caf091d5-6122-4cd7-bdbd-88b3f9a4029e@csgroup.eu>
Date: Wed, 12 Nov 2025 12:15:35 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] powerpc, mm: Fix mprotect on book3s 32-bit
To: Dave Vasilevsky <dave@vasilevsky.ca>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Nadav Amit <nadav.amit@gmail.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Ritesh Harjani <ritesh.list@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, linux-mm@kvack.org
References: <20251111-vasi-mprotect-g3-v2-1-881c94afbc42@vasilevsky.ca>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Content-Language: fr-FR
In-Reply-To: <20251111-vasi-mprotect-g3-v2-1-881c94afbc42@vasilevsky.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 11/11/2025 à 22:42, Dave Vasilevsky a écrit :
> On 32-bit book3s with hash-MMUs, tlb_flush() was a no-op. This was
> unnoticed because all uses until recently were for unmaps, and thus
> handled by __tlb_remove_tlb_entry().
> 
> After commit 4a18419f71cd ("mm/mprotect: use mmu_gather") in kernel 5.19,
> tlb_gather_mmu() started being used for mprotect as well. This caused
> mprotect to simply not work on these machines:
> 
>    int *ptr = mmap(NULL, 4096, PROT_READ|PROT_WRITE,
>                    MAP_PRIVATE|MAP_ANONYMOUS, -1, 0);
>    *ptr = 1; // force HPTE to be created
>    mprotect(ptr, 4096, PROT_READ);
>    *ptr = 2; // should segfault, but succeeds
> 
> Fixed by making tlb_flush() actually flush TLB pages. This finally
> agrees with the behaviour of boot3s64's tlb_flush().
> 
> Fixes: 4a18419f71cd ("mm/mprotect: use mmu_gather")
> Signed-off-by: Dave Vasilevsky <dave@vasilevsky.ca>
> Cc: stable@vger.kernel.org

A small comment below

Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>

> ---
> Changes in v2:
> - Flush entire TLB if full mm is requested.
> - Link to v1: https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Fr%2F20251027-vasi-mprotect-g3-v1-1-3c5187085f9a%40vasilevsky.ca&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7C7b1beec4921c4c67c95108de216b416f%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C638984941704616710%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=mJL3gS4YkTUAWmivSWL5AE9BlhAQ0R%2FI3eBwYwN26nA%3D&reserved=0
> ---
>   arch/powerpc/include/asm/book3s/32/tlbflush.h | 8 ++++++--
>   arch/powerpc/mm/book3s32/tlb.c                | 9 +++++++++
>   2 files changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/book3s/32/tlbflush.h b/arch/powerpc/include/asm/book3s/32/tlbflush.h
> index e43534da5207aa3b0cb3c07b78e29b833c141f3f..b8c587ad2ea954f179246a57d6e86e45e91dcfdc 100644
> --- a/arch/powerpc/include/asm/book3s/32/tlbflush.h
> +++ b/arch/powerpc/include/asm/book3s/32/tlbflush.h
> @@ -11,6 +11,7 @@
>   void hash__flush_tlb_mm(struct mm_struct *mm);
>   void hash__flush_tlb_page(struct vm_area_struct *vma, unsigned long vmaddr);
>   void hash__flush_range(struct mm_struct *mm, unsigned long start, unsigned long end);
> +void hash__flush_gather(struct mmu_gather *tlb);
>   
>   #ifdef CONFIG_SMP
>   void _tlbie(unsigned long address);
> @@ -28,9 +29,12 @@ void _tlbia(void);
>    */
>   static inline void tlb_flush(struct mmu_gather *tlb)
>   {
> -	/* 603 needs to flush the whole TLB here since it doesn't use a hash table. */
> -	if (!mmu_has_feature(MMU_FTR_HPTE_TABLE))
> +	if (mmu_has_feature(MMU_FTR_HPTE_TABLE)) {
> +		hash__flush_gather(tlb);
> +	} else {
> +		/* 603 needs to flush the whole TLB here since it doesn't use a hash table. */
>   		_tlbia();
> +	}

You should keep the comment on 603 outside the if/else and remove the 
braces, in line with 
https://docs.kernel.org/process/coding-style.html#placing-braces-and-spaces

>   }
>   
>   static inline void flush_range(struct mm_struct *mm, unsigned long start, unsigned long end)
> diff --git a/arch/powerpc/mm/book3s32/tlb.c b/arch/powerpc/mm/book3s32/tlb.c
> index 9ad6b56bfec96e989b96f027d075ad5812500854..e54a7b0112322e5818d80facd2e3c7722e6dd520 100644
> --- a/arch/powerpc/mm/book3s32/tlb.c
> +++ b/arch/powerpc/mm/book3s32/tlb.c
> @@ -105,3 +105,12 @@ void hash__flush_tlb_page(struct vm_area_struct *vma, unsigned long vmaddr)
>   		flush_hash_pages(mm->context.id, vmaddr, pmd_val(*pmd), 1);
>   }
>   EXPORT_SYMBOL(hash__flush_tlb_page);
> +
> +void hash__flush_gather(struct mmu_gather *tlb)
> +{
> +	if (tlb->fullmm || tlb->need_flush_all)
> +		hash__flush_tlb_mm(tlb->mm);
> +	else
> +		hash__flush_range(tlb->mm, tlb->start, tlb->end);
> +}
> +EXPORT_SYMBOL(hash__flush_gather);
> 
> ---
> base-commit: 24172e0d79900908cf5ebf366600616d29c9b417
> change-id: 20251027-vasi-mprotect-g3-f8f5278d4140
> 
> Best regards,


