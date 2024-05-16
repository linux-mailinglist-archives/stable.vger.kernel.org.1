Return-Path: <stable+bounces-45328-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB1D68C7C7C
	for <lists+stable@lfdr.de>; Thu, 16 May 2024 20:31:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A98B1C21745
	for <lists+stable@lfdr.de>; Thu, 16 May 2024 18:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5694D15749C;
	Thu, 16 May 2024 18:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WvrPgcwY"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3908B157496;
	Thu, 16 May 2024 18:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715883676; cv=none; b=ItD9XWL046KG66LTx1U1euEz05ORB4iAW7PdBWtpRFsTgYadsf3Gm26fRwT0qzL1lUeXnNK4CzjH45iXyZ0YxzXD+OZmHl88lwkYAqBoSF3NkYj6wvEx0Gi4qT//u2ig9ZSwarUOS8DM3TUAqcDwvPTl0ej8+wyNfFyZEYWgg94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715883676; c=relaxed/simple;
	bh=x30ssAyOCyVVdjMVH1dprDFSGM0wJHE43G2Q53C4vIM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UoPyHgJ4le4nUXyPHQS82VqX5on0dTPNRYRDGDkiCf9Ffz4zXiNEEcVBCptPxJwN/9b8+MC6APR708OEUky0vkcMA8c04itYzBAQTFhUOJSzm8dZ5OwXdYsRXoS9dsMCmGQkncilPnYwRVPilyhSGiD6nbR/lHvL/Clt/rBUflg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WvrPgcwY; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715883675; x=1747419675;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=x30ssAyOCyVVdjMVH1dprDFSGM0wJHE43G2Q53C4vIM=;
  b=WvrPgcwY+lEpSrakyQNiXt2iBQvtBqd18AmH7q52VfBr8Lodr6DvUJBy
   NbzHEGsGzUpKe27WV5ys34IZX+7tZpFm9KrEgjyaQ0NwOBjERPiqK2mRY
   EW8QdWu6JzZUC3jHe99pFhWkg4Xk3H0k/a0jsYHXvci6JPYWc/OtAqBiv
   Ig9roQLsM0KI782xG85vsULQbXLg09x2taznDS2n48avStQGtlpliATEI
   2FGVH7EOe2bj48GP9k0xP2+7ttjKxq1rOOtlKigj+3+vZJkxLECcdNM3Z
   +qs/wJc213hrnaS3rIFs0DBBWjdpTdG+1KAiYOPDLnGfzV6yqH83f2r84
   A==;
X-CSE-ConnectionGUID: 85TBpD4tSgGHSdWX82vdnw==
X-CSE-MsgGUID: txpAQOWiQSeSaLOn6ZWjKQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="34538460"
X-IronPort-AV: E=Sophos;i="6.08,165,1712646000"; 
   d="scan'208";a="34538460"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2024 11:21:14 -0700
X-CSE-ConnectionGUID: 3DytZcwnSZuwL3XZVEl0CA==
X-CSE-MsgGUID: FENhqiQURM6Jm90jQkTTTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,165,1712646000"; 
   d="scan'208";a="36262176"
Received: from msatwood-mobl.amr.corp.intel.com (HELO [10.125.108.164]) ([10.125.108.164])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2024 11:21:14 -0700
Message-ID: <8286f8b9-488c-418f-8bad-d23871a8afab@intel.com>
Date: Thu, 16 May 2024 11:21:13 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] x86/cpu: Fix boot on Intel Quark X1000
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
 linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Adam Dunlap <acdunlap@google.com>,
 stable@vger.kernel.org
References: <20240516173928.3960193-1-andriy.shevchenko@linux.intel.com>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <20240516173928.3960193-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/16/24 10:39, Andy Shevchenko wrote:
> The initial change to set x86_virt_bits to the correct value straight
> away broke boot on Intel Quark X1000 CPUs (which are family 5, model 9,
> stepping 0)

Do you know what _actually_ broke?  Like was there a crash somewhere?

> With deeper investigation it appears that the Quark doesn't have
> the bit 19 set in 0x01 CPUID leaf, which means it doesn't provide
> any clflush instructions and hence the cache alignment is set to 0.
> The actual cache line size is 16 bytes, hence we may set the alignment
> accordingly. At the same time the physical and virtual address bits
> are retrieved via 0x80000008 CPUID leaf.

This seems to be saying that ->x86_clflush_size must come from CPUID.
But there _are_ CPUID-independent defaults set in identify_cpu().  How
do those fit in?

> Note, we don't really care about the value of x86_clflush_size as it
> is either used with a proper check for the instruction to be present,
> or, like in PCI case, it assumes 32 bytes for all supported 32-bit CPUs
> that have actually smaller cache line sizes and don't advertise it.

Are you trying to say that having ->x86_clflush_size==0 is not fatal
while having ->x86_cache_alignment==0 _is_ fatal?

> The commit fbf6449f84bf ("x86/sev-es: Set x86_virt_bits to the correct
> value straight away, instead of a two-phase approach") basically
> revealed the issue that has been present from day 1 of introducing
> the Quark support.

How did it do that, exactly?  It's still not crystal clear.

> diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
> index be30d7fa2e66..2bffae158dd5 100644
> --- a/arch/x86/kernel/cpu/intel.c
> +++ b/arch/x86/kernel/cpu/intel.c
> @@ -321,6 +321,15 @@ static void early_init_intel(struct cpuinfo_x86 *c)
>  #ifdef CONFIG_X86_64
>  	set_cpu_cap(c, X86_FEATURE_SYSENTER32);
>  #else
> +	/*
> +	 * The Quark doesn't have bit 19 set in 0x01 CPUID leaf, which means
> +	 * it doesn't provide any clflush instructions and hence the cache
> +	 * alignment is set to 0. The actual cache line size is 16 bytes,
> +	 * hence set the alignment accordingly. At the same time the physical
> +	 * and virtual address bits are retrieved via 0x80000008 CPUID leaf.
> +	 */
> +	if (c->x86 == 5 && c->x86_model == 9)
> +		c->x86_cache_alignment = 16;

What are the odds that another CPU has this issue?  I'm thinking we
should just set a default in addition to hacking around this for Quark.

