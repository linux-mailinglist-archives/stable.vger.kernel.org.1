Return-Path: <stable+bounces-148072-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD25BAC7AF4
	for <lists+stable@lfdr.de>; Thu, 29 May 2025 11:23:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C63F37B0AA6
	for <lists+stable@lfdr.de>; Thu, 29 May 2025 09:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8603921C187;
	Thu, 29 May 2025 09:23:04 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 856ED219302;
	Thu, 29 May 2025 09:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748510584; cv=none; b=MaEFHNkU0PuZ01NIXsELfxNzcDTk9hgRCf2AJPvH+rl4UoYVp1nGL1Fb9UPRQF1klpZY7D0fcB8nEOWsx0TlC9kkzaKyMCfYqKIWBXn6SZWVtXmEwEz0/nmx+1+bHbwkxMtVrqgV8ZSkCNWUfb9897fjVr8FrY+XPnLJG2PS5is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748510584; c=relaxed/simple;
	bh=sfzG8mKqdZm7/xXGBLDcri6zOyCd7+jQh2rsTTlVB0U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gEZrL3XcKUbIt4y8Se2S9JhaKcjYwaa8EnYWgWBqeji+UlQXxz8NFjB/Pq+zKPLltIUSaAPOfXvVY6w6Nhlcbv+kh/Cs4gC2+3jpW7sc2XjY9Tv07PXwK5LSrRP3qcTkTRtC48FIh6CtUI9IyiwP8AAanmsRH+vpVPpJeKI9A7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6D847176A;
	Thu, 29 May 2025 02:22:45 -0700 (PDT)
Received: from [10.163.62.34] (unknown [10.163.62.34])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AC93B3F5A1;
	Thu, 29 May 2025 02:22:57 -0700 (PDT)
Message-ID: <6aacbf96-e685-43fd-b77d-2242d57cb2f3@arm.com>
Date: Thu, 29 May 2025 14:52:54 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] arm64: Restrict pagetable teardown to avoid false
 warning
To: Dev Jain <dev.jain@arm.com>, catalin.marinas@arm.com, will@kernel.org
Cc: david@redhat.com, ryan.roberts@arm.com, mark.rutland@arm.com,
 yang@os.amperecomputing.com, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
References: <20250527082633.61073-1-dev.jain@arm.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20250527082633.61073-1-dev.jain@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/27/25 13:56, Dev Jain wrote:
> Commit 9c006972c3fe removes the pxd_present() checks because the caller
> checks pxd_present(). But, in case of vmap_try_huge_pud(), the caller only
> checks pud_present(); pud_free_pmd_page() recurses on each pmd through
> pmd_free_pte_page(), wherein the pmd may be none. Thus it is possible to
> hit a warning in the latter, since pmd_none => !pmd_table(). Thus, add
> a pmd_present() check in pud_free_pmd_page().
> 
> This problem was found by code inspection.
> 
> Fixes: 9c006972c3fe (arm64: mmu: drop pXd_present() checks from pXd_free_pYd_table())
> Cc: <stable@vger.kernel.org>
> Reported-by: Ryan Roberts <ryan.roberts@arm.com> 
> Acked-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Dev Jain <dev.jain@arm.com>
> ---
> This patch is based on 6.15-rc6.
> 
> v2->v3:
>  - Use pmdp_get()
> 
> v1->v2:
>  - Enforce check in caller
> 
>  arch/arm64/mm/mmu.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index ea6695d53fb9..5a9bf291c649 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -1286,7 +1286,8 @@ int pud_free_pmd_page(pud_t *pudp, unsigned long addr)
>  	next = addr;
>  	end = addr + PUD_SIZE;
>  	do {
> -		pmd_free_pte_page(pmdp, next);
> +		if (pmd_present(pmdp_get(pmdp)))
> +			pmd_free_pte_page(pmdp, next);
>  	} while (pmdp++, next += PMD_SIZE, next != end);
>  
>  	pud_clear(pudp);

Agree with Ryan about keeping pmd_present() to be consistent.

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

