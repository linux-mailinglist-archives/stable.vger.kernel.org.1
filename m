Return-Path: <stable+bounces-45565-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9B188CC013
	for <lists+stable@lfdr.de>; Wed, 22 May 2024 13:17:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6871FB2214A
	for <lists+stable@lfdr.de>; Wed, 22 May 2024 11:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EDED823DC;
	Wed, 22 May 2024 11:17:13 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6097BB17;
	Wed, 22 May 2024 11:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716376633; cv=none; b=elSUWCm/ZTD0vZJOi5ztw3VTfMh3ZQI6AwLrpCfRvLPemKRx4Pz5eU2b8N9TBMJK90o2NBEjrMQslMq6UjckP8l8mnPW6IHpJP6uQX6SxrcCM8HOSSFHJyanCCVHz382DZ4QHYT60lfxwDId1qaWUfpfAdIRu+XGSWg4lfBDiHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716376633; c=relaxed/simple;
	bh=CPEqhqyGm2UZF8UZo0VoyFgQT3dnqGYzpOjGsl/H4IE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hz34u17DKb3a7SFS1xXzII4J3LINXUNjuh4bem41a7LeE4igEtUXcF4vTEV1aHjoT7c5NnR23ZVd7it9cGUMVG/aZEWd/sZkjNKFhTFONxGXoM4zwfT2Aa0EfrwyxOaPkk8DGpV3972nuEKl0t8c1v0j1RbYZ+PeZ1tYyiLEOCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id F3A84240008;
	Wed, 22 May 2024 11:16:57 +0000 (UTC)
Message-ID: <35bf5362-ae70-4fbe-acff-691bfe4a9e34@ghiti.fr>
Date: Wed, 22 May 2024 13:16:56 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] riscv: force PAGE_SIZE linear mapping if
 debug_pagealloc is enabled
To: Nam Cao <namcao@linutronix.de>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alexghiti@rivosinc.com>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <cover.1715750938.git.namcao@linutronix.de>
 <2e391fa6c6f9b3fcf1b41cefbace02ee4ab4bf59.1715750938.git.namcao@linutronix.de>
Content-Language: en-US
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <2e391fa6c6f9b3fcf1b41cefbace02ee4ab4bf59.1715750938.git.namcao@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: alex@ghiti.fr

Hi Nam,

On 15/05/2024 07:50, Nam Cao wrote:
> debug_pagealloc is a debug feature which clears the valid bit in page table
> entry for freed pages to detect illegal accesses to freed memory.
>
> For this feature to work, virtual mapping must have PAGE_SIZE resolution.
> (No, we cannot map with huge pages and split them only when needed; because
> pages can be allocated/freed in atomic context and page splitting cannot be
> done in atomic context)
>
> Force linear mapping to use small pages if debug_pagealloc is enabled.
>
> Note that it is not necessary to force the entire linear mapping, but only
> those that are given to memory allocator. Some parts of memory can keep
> using huge page mapping (for example, kernel's executable code). But these
> parts are minority, so keep it simple. This is just a debug feature, some
> extra overhead should be acceptable.
>
> Fixes: 5fde3db5eb02 ("riscv: add ARCH_SUPPORTS_DEBUG_PAGEALLOC support")
> Signed-off-by: Nam Cao <namcao@linutronix.de>
> Cc: stable@vger.kernel.org
> ---
> Interestingly this feature somehow still worked when first introduced.
> My guess is that back then only 2MB page size is used. When a 4KB page is
> freed, the entire 2MB will be (incorrectly) invalidated by this feature.
> But 2MB is quite small, so no one else happen to use other 4KB pages in
> this 2MB area. In other words, it used to work by luck.
>
> Now larger page sizes are used, so this feature invalidate large chunk of
> memory, and the probability that someone else access this chunk and
> trigger a page fault is much higher.
>
>   arch/riscv/mm/init.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index 2574f6a3b0e7..73914afa3aba 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -682,6 +682,9 @@ void __init create_pgd_mapping(pgd_t *pgdp,
>   static uintptr_t __init best_map_size(phys_addr_t pa, uintptr_t va,
>   				      phys_addr_t size)
>   {
> +	if (debug_pagealloc_enabled())
> +		return PAGE_SIZE;
> +
>   	if (pgtable_l5_enabled &&
>   	    !(pa & (P4D_SIZE - 1)) && !(va & (P4D_SIZE - 1)) && size >= P4D_SIZE)
>   		return P4D_SIZE;


You can add:

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks,

Alex


