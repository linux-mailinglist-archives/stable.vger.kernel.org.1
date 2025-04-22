Return-Path: <stable+bounces-135038-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E60BAA95E9B
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 08:47:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE1E91893176
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 06:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4147D1E5207;
	Tue, 22 Apr 2025 06:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P7lqufgC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F103B19AD70;
	Tue, 22 Apr 2025 06:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745304424; cv=none; b=gg1r6pRFgMGtPYYvzJMSHSjIIiXsYzeR/7JONHsccJWFv50pKSliJSwneaOB7K1UR25PGDYb95quYUnyH1on9ZxnuQnzHQWw87jZD4vSfkablY6v3iNqdfCuqTq5NtGbOvC+z0BoqnA0cE2zJRS6lYPZ2JL3lGHIJQW1xXSBGFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745304424; c=relaxed/simple;
	bh=248s4YbqUI0bkXldB1s2DNY9icarQmLxLtUIqWeTp48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=orNi5eT0PAnVyOhuiFcgQCNFnwYGry0dtxTp0LOfmuXW/APmvU8PiEYeziuX4nikI7mjpaT/vR3Lf9aCv3bwwCmr7L4kwYVT+tU1Hyga3gLSDlzklOF6YcJ4j6QCe/PA3K91hqV76lPAwgXzA2fSH8q5k6tvUTc9Nm6ohSyel5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P7lqufgC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17BC9C4CEE9;
	Tue, 22 Apr 2025 06:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745304423;
	bh=248s4YbqUI0bkXldB1s2DNY9icarQmLxLtUIqWeTp48=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P7lqufgC1r1MRyreG2VdkJT8kZZOh/jxKD4YvTBbtx4CISvgjmXjhpqq/9EmYMIhm
	 jbHU8lSyFbgntE2aIf0qTKkEOjS3pihkKpIlyqnSRHrwxQrLhJkOccoFUW3vHTKM3e
	 ACSYYEGZHwsAKnkji+/29pGUrDCpnpI/pvji6JaoF6wHWgxqwlcUHwIA3Ni2pB1ejM
	 hlEWblTydv21Zmy5NsWr2l2KlbGqUTZTqGX5KGIisxiJ99xC1qk1nxFdShm6ih9Yi+
	 tccEW6nfFNzHcyCrrxMfJMQj/DXeQ38tYTtHOWEm0LbhQfle6j8NQOTaREOubPj/G/
	 dxaeooQ8vSteg==
Date: Tue, 22 Apr 2025 08:46:59 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, andrew.cooper3@citrix.com,
	Len Brown <len.brown@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] Handle Ice Lake MONITOR erratum
Message-ID: <aAc7Y5x_frQUB2Gc@gmail.com>
References: <20250421192205.7CC1A7D9@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250421192205.7CC1A7D9@davehans-spike.ostc.intel.com>


* Dave Hansen <dave.hansen@linux.intel.com> wrote:

> 
> From: Dave Hansen <dave.hansen@linux.intel.com>
> 
> Andrew Cooper reported some boot issues on Ice Lake servers when
> running Xen that he tracked down to MWAIT not waking up. Do the safe
> thing and consider them buggy since there's a published erratum.
> Note: I've seen no reports of this occurring on Linux.
> 
> Add Ice Lake servers to the list of shaky MONITOR implementations with
> no workaround available. Also, before the if() gets too unwieldy, move
> it over to a x86_cpu_id array. Additionally, add a comment to the
> X86_BUG_MONITOR consumption site to make it clear how and why affected
> CPUs get IPIs to wake them up.
> 
> There is no equivalent erratum for the "Xeon D" Ice Lakes so
> INTEL_ICELAKE_D is not affected.
> 
> The erratum is called ICX143 in the "3rd Gen Intel Xeon Scalable
> Processors, Codename Ice Lake Specification Update". It is Intel
> document 637780, currently available here:
> 
> 	https://cdrdv2.intel.com/v1/dl/getContent/637780
> 
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Andrew Cooper <andrew.cooper3@citrix.com>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Cc: Len Brown <len.brown@intel.com>
> Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: stable@vger.kernel.org
> 
> ---
> 
>  b/arch/x86/include/asm/mwait.h |    3 +++
>  b/arch/x86/kernel/cpu/intel.c  |   17 ++++++++++++++---
>  2 files changed, 17 insertions(+), 3 deletions(-)
> 
> diff -puN arch/x86/kernel/cpu/intel.c~ICX-MONITOR-bug arch/x86/kernel/cpu/intel.c
> --- a/arch/x86/kernel/cpu/intel.c~ICX-MONITOR-bug	2025-04-18 13:54:46.022590596 -0700
> +++ b/arch/x86/kernel/cpu/intel.c	2025-04-18 15:15:19.374365069 -0700
> @@ -513,6 +513,19 @@ static void init_intel_misc_features(str
>  }
>  
>  /*
> + * These CPUs have buggy MWAIT/MONITOR implementations that
> + * usually manifest as hangs or stalls at boot.
> + */
> +#define MWAIT_VFM(_vfm)	\
> +	X86_MATCH_VFM_FEATURE(_vfm, X86_FEATURE_MWAIT, 0)
> +static const struct x86_cpu_id monitor_bug_list[] = {
> +	MWAIT_VFM(INTEL_ATOM_GOLDMONT),
> +	MWAIT_VFM(INTEL_LUNARLAKE_M),
> +	MWAIT_VFM(INTEL_ICELAKE_X),	/* Erratum ICX143 */
> +	{},
> +};

While it's just an internal helper, macro names should still be 
intuitive:

  s/MWAIT_VFM
   /VFM_MWAIT_BUG

or so?

Thanks,

	Ingo

