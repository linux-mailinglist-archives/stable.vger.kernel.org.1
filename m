Return-Path: <stable+bounces-254723-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qJqgA//iF2pOUQgAu9opvQ
	(envelope-from <stable+bounces-254723-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 08:38:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 64EF75ED536
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 08:38:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 870443198DD3
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 06:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2052C33B6DF;
	Thu, 28 May 2026 06:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MmP2iNPg"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4028733D4F2;
	Thu, 28 May 2026 06:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779950146; cv=none; b=us/iAsgRKM3dU6NyDkFJV6o1sZ3HqkEMpJ0ExaTyKc2qPHiw8SU9RPvISYHyatayhS6Y76VsLv0vMxTaUSvkQYc9wgrnLtN+nrQ12VUCE5AAWV7ZD9FmnkJ+FpvgjUGyPaKIYhFV41fvbhsabVSV7iUCaGklarwKTYo3E9PAdgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779950146; c=relaxed/simple;
	bh=BEkMylpTGSrordPuXcwLIc+Y+IlQ1YbqnmsHlXNKmRQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VdY9GpaRrwz/rMMPTSX0t3QDV5fDJQHvbYuqYBoewIheq0aIY9Je6Xwb3UMB200k7RBLOyrbylpU0sRt+LEbq0RpmEJYGB2Dvb4GVA0eSq75F3gjpmXSwK82o+E4T0/svS8EPeVT8zBhKuMrbCtlIIJ2/bg7LpVV+tUbJV7Hi/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MmP2iNPg; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779950145; x=1811486145;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=BEkMylpTGSrordPuXcwLIc+Y+IlQ1YbqnmsHlXNKmRQ=;
  b=MmP2iNPgFYT8gwCI0uPxqIfaIUImNEWNSvtVD8it6pFimq6alPdbCfs2
   5ePBBhW8Hi0DvG/PAYBddBs+g9URdKOSBmcLO6kE4B53QeoJBIsUqIzHY
   c/L7L4zeziBMmiaxQ8N1Zn9Q40Ke9QNqdD7mUJoRb2vO364m+eKBiee6N
   edvPoUEqy8IsO3bRCL8ZOfpCWuZ5T21uGquhKwIe3LrDRxyvNalzMu0x2
   +NRxyn62FJi4yrqiFP6Mn4Li0XWoltvXu8SS3/4I04eMi7xq6FO05a1Jv
   W1Rvs4GDxn5BQwLuGJV0gxSTQbLNY75qwEGCA0zB7XBXs34Mef+HNDPuC
   A==;
X-CSE-ConnectionGUID: vl2WJb3qQcK+zWf2KAq06A==
X-CSE-MsgGUID: PEZ4a9O1TWWVXE6SOtjMIQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11799"; a="80691278"
X-IronPort-AV: E=Sophos;i="6.24,172,1774335600"; 
   d="scan'208";a="80691278"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 23:35:45 -0700
X-CSE-ConnectionGUID: mNHQwPbBSyi+z3R43x4IWw==
X-CSE-MsgGUID: fGgv+rhUTwasSRB3i2wOtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,172,1774335600"; 
   d="scan'208";a="241429723"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.147]) ([10.124.241.147])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 23:35:41 -0700
Message-ID: <66f281e5-0653-4f67-80c7-de64adb0a4e7@linux.intel.com>
Date: Thu, 28 May 2026 14:35:39 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 4/7] perf/x86/intel/uncore: Defer ADL global PMON
 enable to enable_box()
To: Zide Chen <zide.chen@intel.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 stable@vger.kernel.org
References: <20260527151154.130505-1-zide.chen@intel.com>
 <20260527151154.130505-4-zide.chen@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260527151154.130505-4-zide.chen@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-254723-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dapeng1.mi@linux.intel.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.intel.com:mid,intel.com:email,intel.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 64EF75ED536
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 5/27/2026 11:11 PM, Zide Chen wrote:
> On some Raptor Cove CPUs, enabling uncore PMON globally at driver init
> may increase power consumption even when no perf events are in use.
>
> Drop adl_uncore_msr_init_box() and defer programming the global control
> register to enable_box(), so it is only set when a box is actually used.
>
> IMC and IMC freerunning counters use a separate control path and are
> unaffected.
>
> Cc: stable@vger.kernel.org

Need a "Fixes" tag?

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>


> Signed-off-by: Zide Chen <zide.chen@intel.com>
> ---
>  arch/x86/events/intel/uncore_snb.c | 7 -------
>  1 file changed, 7 deletions(-)
>
> diff --git a/arch/x86/events/intel/uncore_snb.c b/arch/x86/events/intel/uncore_snb.c
> index 3dbc6bacbd9d..edddd4f9ab5f 100644
> --- a/arch/x86/events/intel/uncore_snb.c
> +++ b/arch/x86/events/intel/uncore_snb.c
> @@ -563,12 +563,6 @@ void tgl_uncore_cpu_init(void)
>  	skl_uncore_msr_ops.init_box = rkl_uncore_msr_init_box;
>  }
>  
> -static void adl_uncore_msr_init_box(struct intel_uncore_box *box)
> -{
> -	if (box->pmu->pmu_idx == 0)
> -		wrmsrq(ADL_UNC_PERF_GLOBAL_CTL, SNB_UNC_GLOBAL_CTL_EN);
> -}
> -
>  static void adl_uncore_msr_enable_box(struct intel_uncore_box *box)
>  {
>  	wrmsrq(ADL_UNC_PERF_GLOBAL_CTL, SNB_UNC_GLOBAL_CTL_EN);
> @@ -587,7 +581,6 @@ static void adl_uncore_msr_exit_box(struct intel_uncore_box *box)
>  }
>  
>  static struct intel_uncore_ops adl_uncore_msr_ops = {
> -	.init_box	= adl_uncore_msr_init_box,
>  	.enable_box	= adl_uncore_msr_enable_box,
>  	.disable_box	= adl_uncore_msr_disable_box,
>  	.exit_box	= adl_uncore_msr_exit_box,

