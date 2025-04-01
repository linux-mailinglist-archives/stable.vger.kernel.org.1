Return-Path: <stable+bounces-127353-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D28C1A7820C
	for <lists+stable@lfdr.de>; Tue,  1 Apr 2025 20:24:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E990166914
	for <lists+stable@lfdr.de>; Tue,  1 Apr 2025 18:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C167F20E6ED;
	Tue,  1 Apr 2025 18:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UPzhVCcn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0A61D86C6;
	Tue,  1 Apr 2025 18:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743531852; cv=none; b=AbBVb+NiusSJtFWUi4yWsHqoRoIXuMFe1Q/tHFAyg7cjTPKO0gwFSBWyx9dnXnQJG1ALPooRBqBUcXH5g0CFNmy5Ta8ovicjAk5Knj64eDtmSgqHfb/qWJdiy+FzrHSmj3Gb51EIdM7kR9WhGJguWQZCs+CM8vUxLSUM5rJ/WwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743531852; c=relaxed/simple;
	bh=KTcMGgyL2q1le24N8XakU/yxOfOsOdvydsbqXqMm6d0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M8abGwDf4empDmVA/2t8oMKRHmnO1TULHSj/h0VFn9E2bSXMoVUiiHT4LNy8S4n+9bM1Fmxvhmj7P7+DwsbSPYLReIB2y9a/pfnZgzrFI817jmkGtE5ofI/dFXYCRt6HQYr2eAD2NBR2zto+O6j6wF03R5QoKUoIV5tCQXzoZOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UPzhVCcn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7E37C4CEE4;
	Tue,  1 Apr 2025 18:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743531852;
	bh=KTcMGgyL2q1le24N8XakU/yxOfOsOdvydsbqXqMm6d0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UPzhVCcnqf7ZhwYLw+1gfp9L15fi+g7ZCxtt9zGXruJPgmj/WCIgb9gnuFqcjqYpC
	 hQffMxhpf7Xk6GxzcgD/yHxWkpTYzplqLXYwiYt+6S2o9RryHfE1jKJLYMUS/xZGT+
	 cL0roMEKfdzQm6Afk7ANtfKPaO4/+YGOGDZnHuQhP8WN39jQME12tfF/QiShy3ZM9B
	 qdC00t0QGR/Znpbh+STbHucdR1MzcW6GgRrWv2iJsFMYj7ijr3wI4R6sbKlzTKqgeh
	 IG4fVilpyLTJLJseWlQTlovNtwsFJV3gY8povBmN8rZ3enK+ayh3HFQD64DpXc7mN9
	 1gEjs5j/oKhKQ==
Date: Tue, 1 Apr 2025 20:24:04 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, tglx@linutronix.de, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] perf/x86/intel/uncore: Add error handling for
 uncore_msr_box_ctl()
Message-ID: <Z-wvRLi55EnMGniG@gmail.com>
References: <20250401141741.2705-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250401141741.2705-1-vulab@iscas.ac.cn>


* Wentao Liang <vulab@iscas.ac.cn> wrote:

> In mtl_uncore_msr_init_box(), the return value of uncore_msr_box_ctl()
> needs to be checked before being used as the parameter of wrmsrl().
> A proper implementation can be found in ivbep_uncore_msr_init_box().
> 
> Add error handling for uncore_msr_box_ctl() to ensure the MSR write
> operation is only performed when a valid MSR address is returned.
> 
> Fixes: c828441f21dd ("perf/x86/intel/uncore: Add Meteor Lake support")
> Cc: stable@vger.kernel.org # v6.3+
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  arch/x86/events/intel/uncore_snb.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/events/intel/uncore_snb.c b/arch/x86/events/intel/uncore_snb.c
> index 3934e1e4e3b1..84070388f495 100644
> --- a/arch/x86/events/intel/uncore_snb.c
> +++ b/arch/x86/events/intel/uncore_snb.c
> @@ -691,7 +691,10 @@ static struct intel_uncore_type mtl_uncore_hac_cbox = {
>  
>  static void mtl_uncore_msr_init_box(struct intel_uncore_box *box)
>  {
> -	wrmsrl(uncore_msr_box_ctl(box), SNB_UNC_GLOBAL_CTL_EN);
> +	unsigned int msr = uncore_msr_box_ctl(box);
> +
> +	if (msr)
> +		wrmsrl(msr, SNB_UNC_GLOBAL_CTL_EN);

Exactly what happens without this patch, do we crash during boot due to 
the incorrect wrmsr()?

Thanks,

	Ingo

