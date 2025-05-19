Return-Path: <stable+bounces-144753-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E3FAABB855
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 11:09:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5FF03B48EC
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 09:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C19926AA93;
	Mon, 19 May 2025 09:08:47 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63A391B4248;
	Mon, 19 May 2025 09:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747645727; cv=none; b=AODgUnZKAdxa8LQQFDYq7uScqeJrSws1T+WzyNa0pIkCioubh9E1Yri/AjrgjBTTF03M5yzcvGNhGhY66KOlyaseMnCvCTTuJ4m73uIK0L+cT2fqYzSusS9TGrF0f+OozSGtmcIgpAW0JvG97NNwlNho0ZRexQSqdLZz+8QOyh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747645727; c=relaxed/simple;
	bh=qDvYY1v4Y0BU963Hawd5E4mFGQJhIeIKAwmTeH1m+F0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AEYC+n5iBhZDMNOV/lCHy+JnSEfM1b2IIfhjXk7YmOv1vMvinpt90ppKVfjwf6g/ytoe5Ai5ByMs9kfhlPIRRSGGFVd43nShAtQ+UMKgeTs1GR7wqZagMQT9LE7TElisEjT4jLpmd9P56TupQCKLW79airE8dGaMX9KG0k2PnTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 543B51655;
	Mon, 19 May 2025 02:08:28 -0700 (PDT)
Received: from [10.57.95.69] (unknown [10.57.95.69])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BEE2E3F6A8;
	Mon, 19 May 2025 02:08:39 -0700 (PDT)
Message-ID: <5763d921-f8a8-4ca6-b5b5-ad96eb5cda11@arm.com>
Date: Mon, 19 May 2025 10:08:38 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64: Restrict pagetable teardown to avoid false
 warning
Content-Language: en-GB
To: Dev Jain <dev.jain@arm.com>, catalin.marinas@arm.com, will@kernel.org
Cc: david@redhat.com, anshuman.khandual@arm.com, mark.rutland@arm.com,
 yang@os.amperecomputing.com, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
References: <20250518095445.31044-1-dev.jain@arm.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20250518095445.31044-1-dev.jain@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/05/2025 10:54, Dev Jain wrote:
> Commit 9c006972c3fe removes the pxd_present() checks because the caller

nit: please use the standard format for describing commits: Commit 9c006972c3fe
("arm64: mmu: drop pXd_present() checks from pXd_free_pYd_table()")

> checks pxd_present(). But, in case of vmap_try_huge_pud(), the caller only
> checks pud_present(); pud_free_pmd_page() recurses on each pmd through
> pmd_free_pte_page(), wherein the pmd may be none. Thus it is possible to
> hit a warning in the latter, since pmd_none => !pmd_table(). Thus, add
> a pmd_present() check in pud_free_pmd_page().
> 
> This problem was found by code inspection.
> 
> This patch is based on 6.15-rc6.

nit: please remove this to below the "---", its not part of the commit log.

> 
> Fixes: 9c006972c3fe (arm64: mmu: drop pXd_present() checks from pXd_free_pYd_table())
> 

nit: remove empty line; the tags should all be in a single block with no empty
lines.

> Cc: <stable@vger.kernel.org>
> Reported-by: Ryan Roberts <ryan.roberts@arm.com> 
> Signed-off-by: Dev Jain <dev.jain@arm.com>
> ---
> v1->v2:
>  - Enforce check in caller
> 
>  arch/arm64/mm/mmu.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index ea6695d53fb9..5b1f4cd238ca 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -1286,7 +1286,8 @@ int pud_free_pmd_page(pud_t *pudp, unsigned long addr)
>  	next = addr;
>  	end = addr + PUD_SIZE;
>  	do {
> -		pmd_free_pte_page(pmdp, next);
> +		if (pmd_present(*pmdp))

pmd_free_pte_page() is using READ_ONCE() to access the *pmdp to ensure it can't
be torn. I suspect we don't technically need that in these functions because
there can be no race with a writer. But the arm64 arch code always uses
READ_ONCE() for dereferencing pgtable entries for safely. Perhaps we should be
consistent here?

		if (pmd_present(READ_ONCE(*pmdp)))

> +			pmd_free_pte_page(pmdp, next);
>  	} while (pmdp++, next += PMD_SIZE, next != end);
>  
>  	pud_clear(pudp);


