Return-Path: <stable+bounces-192223-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B021FC2D07C
	for <lists+stable@lfdr.de>; Mon, 03 Nov 2025 17:15:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F66D3B6512
	for <lists+stable@lfdr.de>; Mon,  3 Nov 2025 15:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97616313E28;
	Mon,  3 Nov 2025 15:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aqT5Iikw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51772287518;
	Mon,  3 Nov 2025 15:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762182984; cv=none; b=jtVIG8qDTBleOM5Jx/2qUEcC6TJDvd6KikpTB0kCwoOc/qxqWDKp+cxTLAG2hMmS7KVQUl/k7AvDHV2l6xvAE9ZIwG09lKbDzJm9HjmjHVzRzNoerHGiYlHvV6B3GMes0Ng5jjatuCYjLHp44jyQPGSjhBTnZhfrIMdxh/qsbXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762182984; c=relaxed/simple;
	bh=a7Sly8r5rJSn8UiWfcBTEec93SjyF2qNVYwgy1GFu3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cL5cGEGla5CUkQLK3GXbznLkjUercN7MGzr7HypzPnfr9TbSFFHi+iaLBNfKraG2d//jbXKRJdEwSJ+CzLQR+kdRVpQzZNndHC9Ytxfftm+iy1xgYvjzAfqg8xqpGZ6n+PGgiu0Jc0nED7clY9Ic/YdLdCXgax3+jdN6Oah4vwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aqT5Iikw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCF2AC4CEE7;
	Mon,  3 Nov 2025 15:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762182983;
	bh=a7Sly8r5rJSn8UiWfcBTEec93SjyF2qNVYwgy1GFu3U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aqT5IikweKWlorBwalEXS2IlYs1upmgnJ6ht0nany2uPjrTvyTJihkpYi7lOCgFP8
	 safG2ointwkqDoMMip3YC0INvu1QKps+DwITD2ckNnw93COpyXjWzmQT2+zSI/usjU
	 uc4hmWYj0ozFXDnMa0eyuW4/oRrKr+lnKXZfBXf6A93HuQTN6mEQc39pWcprNCTi9/
	 5+MAjRhMZCULhmC3NTUlw+VFzbpC0VVvnEDV4FMPuiLSEiLXry6GGu2wXYvUtPm0gQ
	 JQFuNzPpWTLzFxoPO27DtY10O3C4AwU2JnCbHiyQQ99QG8754il1VVCFiFvdMhDhXL
	 P1MXDW4GbBeoA==
Date: Mon, 3 Nov 2025 15:16:18 +0000
From: Will Deacon <will@kernel.org>
To: Dev Jain <dev.jain@arm.com>
Cc: catalin.marinas@arm.com, ryan.roberts@arm.com, rppt@kernel.org,
	shijie@os.amperecomputing.com, yang@os.amperecomputing.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] arm64/pageattr: Propagate return value from
 __change_memory_common
Message-ID: <aQjHQt2rYL6av4qw@willie-the-truck>
References: <20251103061306.82034-1-dev.jain@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251103061306.82034-1-dev.jain@arm.com>

On Mon, Nov 03, 2025 at 11:43:06AM +0530, Dev Jain wrote:
> Post a166563e7ec3 ("arm64: mm: support large block mapping when rodata=full"),
> __change_memory_common has a real chance of failing due to split failure.
> Before that commit, this line was introduced in c55191e96caa, still having
> a chance of failing if it needs to allocate pagetable memory in
> apply_to_page_range, although that has never been observed to be true.
> In general, we should always propagate the return value to the caller.
> 
> Cc: stable@vger.kernel.org
> Fixes: c55191e96caa ("arm64: mm: apply r/o permissions of VM areas to its linear alias as well")
> Signed-off-by: Dev Jain <dev.jain@arm.com>
> ---
> Based on Linux 6.18-rc4.
> 
>  arch/arm64/mm/pageattr.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
> index 5135f2d66958..b4ea86cd3a71 100644
> --- a/arch/arm64/mm/pageattr.c
> +++ b/arch/arm64/mm/pageattr.c
> @@ -148,6 +148,7 @@ static int change_memory_common(unsigned long addr, int numpages,
>  	unsigned long size = PAGE_SIZE * numpages;
>  	unsigned long end = start + size;
>  	struct vm_struct *area;
> +	int ret;
>  	int i;
>  
>  	if (!PAGE_ALIGNED(addr)) {
> @@ -185,8 +186,10 @@ static int change_memory_common(unsigned long addr, int numpages,
>  	if (rodata_full && (pgprot_val(set_mask) == PTE_RDONLY ||
>  			    pgprot_val(clear_mask) == PTE_RDONLY)) {
>  		for (i = 0; i < area->nr_pages; i++) {
> -			__change_memory_common((u64)page_address(area->pages[i]),
> +			ret = __change_memory_common((u64)page_address(area->pages[i]),
>  					       PAGE_SIZE, set_mask, clear_mask);
> +			if (ret)
> +				return ret;

Hmm, this means we can return failure half-way through the operation. Is
that something callers are expecting to handle? If so, how can they tell
how far we got?

Will

