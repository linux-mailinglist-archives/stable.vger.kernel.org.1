Return-Path: <stable+bounces-180565-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87B40B8633D
	for <lists+stable@lfdr.de>; Thu, 18 Sep 2025 19:26:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21616621E01
	for <lists+stable@lfdr.de>; Thu, 18 Sep 2025 17:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6699A31328D;
	Thu, 18 Sep 2025 17:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RVBnUIcY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB1E248F75;
	Thu, 18 Sep 2025 17:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758216389; cv=none; b=Bo7QbIggvshOtiwDZmTlizH7JuSEtsQ1zmhXtDlj5aOuskjkv7NTQti3jZmnrM9LQ86nAwB+nA1KTavpW5WuTwau8EFkSMTGbz6m7Bbq+mTg5ZmHgXbcv/efeolm845hwWfcJHEYTDLVMewyX9dQwwHT5X8p57jRHBiT8p8VCeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758216389; c=relaxed/simple;
	bh=D4nBP8hMCbB4vDax8k9rJfwFNgsqTbtX9Wh44DW4D60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sY3jCsGhqJCGpewA7dqutnvOF9PfUkHQjm3g/eEzdzwome87+l/iBel4mMiz+S8jNLDLjonDJb1D01Zy59ca/NgawIR38gGenZZY7/xMgVkYFISMAMUmdInsy5ILKHZs/X5WcBvwfi+kITIOCPHkCuY08ptEENuZS+GSkYSWASo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RVBnUIcY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D8D4C4CEE7;
	Thu, 18 Sep 2025 17:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758216388;
	bh=D4nBP8hMCbB4vDax8k9rJfwFNgsqTbtX9Wh44DW4D60=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RVBnUIcYbbyFTvxE+hMKJY7gRyallrIo9e11bETCC/H9pudYzYxfCgDm7rQjz8Zzb
	 rT9D/mJ8/1U6nczvsDDdgucWCYsgV/ltP3sHI/mloVki2AA+WkH2pHTxrCf/ZR4PNc
	 mPXweVR9+KmHYJzkHdxY+jERWlS5DgtOaobv/d+g0Q57X2ag+rKewpAD49uwUo2ohz
	 Bb8Yijvv3GY1l/nD1T/Ic1+UAZaN6BdxpQRWFvMKdh1Iwi//FFM8eW70CTGWgf3vIZ
	 /tNmhF4gGJ0TdZgKnXHiRsbINjMAUT9SJLQnsIwjP4rcVkbZl/OGCRn29QXd80nqi9
	 tZAj2QEuNMlcA==
Date: Thu, 18 Sep 2025 18:26:24 +0100
From: Will Deacon <will@kernel.org>
To: Yang Shi <yang@os.amperecomputing.com>
Cc: catalin.marinas@arm.com, ryan.roberts@arm.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [v2 PATCH] arm64: kprobes: call set_memory_rox() for kprobe page
Message-ID: <aMxAwDr11M2VG5XV@willie-the-truck>
References: <20250918162349.4031286-1-yang@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250918162349.4031286-1-yang@os.amperecomputing.com>

On Thu, Sep 18, 2025 at 09:23:49AM -0700, Yang Shi wrote:
> The kprobe page is allocated by execmem allocator with ROX permission.
> It needs to call set_memory_rox() to set proper permission for the
> direct map too. It was missed.
> 
> Fixes: 10d5e97c1bf8 ("arm64: use PAGE_KERNEL_ROX directly in alloc_insn_page")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Yang Shi <yang@os.amperecomputing.com>
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> ---
> v2: Separated the patch from BBML2 series since it is an orthogonal bug
>     fix per Ryan.
>     Fixed the variable name nit per Catalin.
>     Collected R-bs from Catalin.
> 
>  arch/arm64/kernel/probes/kprobes.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
> index 0c5d408afd95..8ab6104a4883 100644
> --- a/arch/arm64/kernel/probes/kprobes.c
> +++ b/arch/arm64/kernel/probes/kprobes.c
> @@ -10,6 +10,7 @@
>  
>  #define pr_fmt(fmt) "kprobes: " fmt
>  
> +#include <linux/execmem.h>
>  #include <linux/extable.h>
>  #include <linux/kasan.h>
>  #include <linux/kernel.h>
> @@ -41,6 +42,17 @@ DEFINE_PER_CPU(struct kprobe_ctlblk, kprobe_ctlblk);
>  static void __kprobes
>  post_kprobe_handler(struct kprobe *, struct kprobe_ctlblk *, struct pt_regs *);
>  
> +void *alloc_insn_page(void)
> +{
> +	void *addr;
> +
> +	addr = execmem_alloc(EXECMEM_KPROBES, PAGE_SIZE);
> +	if (!addr)
> +		return NULL;
> +	set_memory_rox((unsigned long)addr, 1);
> +	return addr;
> +}

Why isn't execmem taking care of this? It looks to me like the
execmem_cache_alloc() path calls set_memory_rox() but the
execmem_vmalloc() path doesn't?

It feels a bit bizarre to me that we have to provide our own wrapper
(which is identical to what s390 does). Also, how does alloc_insn_page()
handle the direct map alias on x86?

Will

