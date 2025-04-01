Return-Path: <stable+bounces-127343-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7296DA77F3C
	for <lists+stable@lfdr.de>; Tue,  1 Apr 2025 17:43:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 555E216C639
	for <lists+stable@lfdr.de>; Tue,  1 Apr 2025 15:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A38920C028;
	Tue,  1 Apr 2025 15:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ipp1WJCc"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A32020B7EA;
	Tue,  1 Apr 2025 15:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743522225; cv=none; b=ZXRYP+TPIWz8V7tkPqUiovAKFpa5PtvndQKAQAn5QVID5mcwR27FtDih9Tl/x5BkuLwnt7p3bhTJDTDB8sJ/zoCkL1jYuF0M6uSUKjFKvsSPnUWtF0r8vDpxILLHHoeKyrXodeZmEHLBCm1L1XKTRkljtCbSj1vBRGSZR4EMPwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743522225; c=relaxed/simple;
	bh=4w8JxMYmUN/hofnf3aIKzSE6bEfKElyRfzgCxkelj2w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VoWAd1HqKvsRa1+g4V8Gqax42q3uk9DVOkm6pJc2kUfsDpwlHW6j17qTYBUrKHWqUoOaa6Fa3ioI5fMdB0Ppu/WPZXr9rIfmO/imB7K8rRDFpKuTqymEmOmzibY4lScydU/esaQ9AXJBmIR/RiGrfQgAHjKWrk2eErPEvpaG4kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ipp1WJCc; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743522224; x=1775058224;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4w8JxMYmUN/hofnf3aIKzSE6bEfKElyRfzgCxkelj2w=;
  b=Ipp1WJCcEki10skoySjT49JNo0eWfpi44dHDNNGA3U5eJZZPHGsaecKG
   riyBQ53zoQwE1hejF7rITNeuYjDAwqzc8K84kJbcakUOS0ijU2omya+Du
   BLli3gbVaV9CvlCdT6D/z3tPHCL1XZ7NVG50Gge6jPMPksGg590wHykpx
   RL2q6ifmLXEk83K5TNiRPYI2t89Cnylca1fknQ17rkF93ehUztI3MareH
   62t4oWrETBQf36QB5JM/yEhFxLprvMTtqih8aNJ1hoVyxrXKpnkRBcPIc
   tdg67cn/UvlhaVzd0cHFh/2F40MYB8Jk6HocGsKYoKtJWWUnQfA35sgDW
   Q==;
X-CSE-ConnectionGUID: DVfxGcIfT9y2sSQct/cT1Q==
X-CSE-MsgGUID: yb/08h3gTD2ozlJbE78LQQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11391"; a="48644221"
X-IronPort-AV: E=Sophos;i="6.14,293,1736841600"; 
   d="scan'208";a="48644221"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2025 08:43:43 -0700
X-CSE-ConnectionGUID: 3Q2/5j2VTr+UEkUhevD6BQ==
X-CSE-MsgGUID: Tvp0ztAqTsGAV1dBxMVc2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,293,1736841600"; 
   d="scan'208";a="130550716"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2025 08:43:42 -0700
Received: from [10.246.136.14] (kliang2-mobl1.ccr.corp.intel.com [10.246.136.14])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 498CF20B5736;
	Tue,  1 Apr 2025 08:43:40 -0700 (PDT)
Message-ID: <dbf181f0-076f-43e8-aa09-88a8a13ae307@linux.intel.com>
Date: Tue, 1 Apr 2025 11:43:39 -0400
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/x86/intel/uncore: Add error handling for
 uncore_msr_box_ctl()
To: Wentao Liang <vulab@iscas.ac.cn>, peterz@infradead.org, mingo@redhat.com,
 acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com,
 adrian.hunter@intel.com, tglx@linutronix.de, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20250401141741.2705-1-vulab@iscas.ac.cn>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20250401141741.2705-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2025-04-01 10:17 a.m., Wentao Liang wrote:
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

Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

Thanks,
Kan> ---
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
>  }
>  
>  static struct intel_uncore_ops mtl_uncore_msr_ops = {


