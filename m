Return-Path: <stable+bounces-121350-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83810A56357
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 10:14:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC62B16AE9E
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 09:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4950F1E1E0B;
	Fri,  7 Mar 2025 09:14:46 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81F594642D
	for <stable@vger.kernel.org>; Fri,  7 Mar 2025 09:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741338886; cv=none; b=JsNR6o8zwkGq9VjMBlV/PuOTrNmxjcF3N3RDyh2AhfCYhXDF50B2fqUyIGjU1zr9ud7wcQ4djw0vr7mTa+CTvu1/EPbmKUYbA/apgL4EGAlDK3c5VA3c8tJj1SsqdkQwnZAZ5SgCz9+kFijE8UgHttHyiXmxUKccJV5/RscibY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741338886; c=relaxed/simple;
	bh=PwrBoBaLlznL3z1vHZ2Bod2CDEb/3F2S/QX1KUyiuTE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=OIyxtwb9JyO5Wg610vPqt6QB+kmhOmXSfTdrG14f+N5LUL09PWmkzohpmr5RTGcwwUwmg03w7lRhXVCzuJt53kEU1rlr5Fy3BvOoItrco3zsvM9gnl93FTst5KvgXGTKmjMjUH67CciXwZNVCtl16ltURfzdLcqyxd0SfVPj2as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C6CD71477;
	Fri,  7 Mar 2025 01:14:56 -0800 (PST)
Received: from [10.57.84.99] (unknown [10.57.84.99])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A5D943F66E;
	Fri,  7 Mar 2025 01:14:43 -0800 (PST)
Message-ID: <b0cc6679-fb67-4047-82c9-4cd85076022d@arm.com>
Date: Fri, 7 Mar 2025 09:14:41 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6.y] arm64: hugetlb: Fix huge_ptep_get_and_clear() for
 non-present ptes
Content-Language: en-GB
To: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
References: <20250306120703-d2316e4be6b8a37f@stable.kernel.org>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20250306120703-d2316e4be6b8a37f@stable.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 06/03/2025 19:11, Sasha Levin wrote:
> [ Sasha's backport helper bot ]
> 
> Hi,
> 
> Summary of potential issues:
> ❌ Build failures detected

I think this is becuase you didn't include the dependent patch? See below.

> ⚠️ Found matching upstream commit but patch is missing proper reference to it

Same question as the other patch, I thought adding:

(cherry picked from commit 49c87f7677746f3c5bd16c81b23700bb6b88bfd4)

to the commit log was sufficient?

> 
> Found matching upstream commit: 49c87f7677746f3c5bd16c81b23700bb6b88bfd4
> 
> Note: The patch differs from the upstream commit:
> ---
> 1:  49c87f7677746 ! 1:  180bfe1de8d8a arm64: hugetlb: Fix huge_ptep_get_and_clear() for non-present ptes
>     @@ Commit message
>          Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>          Link: https://lore.kernel.org/r/20250226120656.2400136-3-ryan.roberts@arm.com
>          Signed-off-by: Will Deacon <will@kernel.org>
>     +    (cherry picked from commit 49c87f7677746f3c5bd16c81b23700bb6b88bfd4)
>     +    Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>      
>       ## arch/arm64/mm/hugetlbpage.c ##
>      @@ arch/arm64/mm/hugetlbpage.c: static int find_num_contig(struct mm_struct *mm, unsigned long addr,
>     @@ arch/arm64/mm/hugetlbpage.c: static pte_t get_clear_contig(struct mm_struct *mm,
>       			     unsigned long pgsize,
>       			     unsigned long ncontig)
>       {
>     --	pte_t orig_pte = __ptep_get(ptep);
>     +-	pte_t orig_pte = ptep_get(ptep);
>      -	unsigned long i;
>      -
>      -	for (i = 0; i < ncontig; i++, addr += pgsize, ptep++) {
>     --		pte_t pte = __ptep_get_and_clear(mm, addr, ptep);
>     +-		pte_t pte = ptep_get_and_clear(mm, addr, ptep);
>      -
>      -		/*
>      -		 * If HW_AFDBM is enabled, then the HW could turn on
>     @@ arch/arm64/mm/hugetlbpage.c: static pte_t get_clear_contig(struct mm_struct *mm,
>      +	pte_t pte, tmp_pte;
>      +	bool present;
>      +
>     -+	pte = __ptep_get_and_clear(mm, addr, ptep);
>     ++	pte = ptep_get_and_clear(mm, addr, ptep);
>      +	present = pte_present(pte);
>      +	while (--ncontig) {
>      +		ptep++;
>      +		addr += pgsize;
>     -+		tmp_pte = __ptep_get_and_clear(mm, addr, ptep);
>     ++		tmp_pte = ptep_get_and_clear(mm, addr, ptep);
>      +		if (present) {
>      +			if (pte_dirty(tmp_pte))
>      +				pte = pte_mkdirty(pte);
>     @@ arch/arm64/mm/hugetlbpage.c: static pte_t get_clear_contig(struct mm_struct *mm,
>       }
>       
>       static pte_t get_clear_contig_flush(struct mm_struct *mm,
>     -@@ arch/arm64/mm/hugetlbpage.c: pte_t huge_ptep_get_and_clear(struct mm_struct *mm, unsigned long addr,
>     +@@ arch/arm64/mm/hugetlbpage.c: pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
>       {
>       	int ncontig;
>       	size_t pgsize;
>     --	pte_t orig_pte = __ptep_get(ptep);
>     +-	pte_t orig_pte = ptep_get(ptep);
>      -
>      -	if (!pte_cont(orig_pte))
>     --		return __ptep_get_and_clear(mm, addr, ptep);
>     +-		return ptep_get_and_clear(mm, addr, ptep);
>      -
>      -	ncontig = find_num_contig(mm, addr, ptep, &pgsize);
>       
> ---
> 
> Results of testing on various branches:
> 
> | Branch                    | Patch Apply | Build Test |
> |---------------------------|-------------|------------|
> | stable/linux-6.6.y        |  Success    |  Failed    |
> 
> Build Errors:
> Build error for stable/linux-6.6.y:
>     arch/arm64/mm/hugetlbpage.c: In function 'huge_ptep_get_and_clear':
>     arch/arm64/mm/hugetlbpage.c:404:35: error: 'sz' undeclared (first use in this function); did you mean 's8'?
>       404 |         ncontig = num_contig_ptes(sz, &pgsize);
>           |                                   ^~
>           |                                   s8

The previous patch (see 20250306144716.71199-1-ryan.roberts@arm.com) adds the sz
parameter to the function. I think you built this without that patch present? I
sent them out as a pair for that reason.

Should I be doing anything in the commit log or email body to mark up the
dependency?

Thanks,
Ryan



>     arch/arm64/mm/hugetlbpage.c:404:35: note: each undeclared identifier is reported only once for each function it appears in
>     make[4]: *** [scripts/Makefile.build:243: arch/arm64/mm/hugetlbpage.o] Error 1
>     make[4]: Target 'arch/arm64/mm/' not remade because of errors.
>     make[3]: *** [scripts/Makefile.build:480: arch/arm64/mm] Error 2
>     make[3]: Target 'arch/arm64/' not remade because of errors.
>     make[2]: *** [scripts/Makefile.build:480: arch/arm64] Error 2
>     make[2]: Target './' not remade because of errors.
>     make[1]: *** [/home/sasha/build/linus-next/Makefile:1916: .] Error 2
>     make[1]: Target '__all' not remade because of errors.
>     make: *** [Makefile:234: __sub-make] Error 2
>     make: Target '__all' not remade because of errors.


