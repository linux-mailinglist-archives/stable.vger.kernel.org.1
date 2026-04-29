Return-Path: <stable+bounces-241944-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uHuvOtFw8mljrQEAu9opvQ
	(envelope-from <stable+bounces-241944-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 22:57:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5230849A486
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 22:57:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 755BC302D967
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 20:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C01C83A9DA1;
	Wed, 29 Apr 2026 20:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XdtRAtnq"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2774301471;
	Wed, 29 Apr 2026 20:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777496268; cv=none; b=Qb04n+jjAX/1M1DZ/+wyLpU4YLDQbAHEcYc8svWKPOionp4rDYyYIETQ5rPPmCdqsUUOnrkGSfyQTFJbyaUMtvFO1gLAVAUuhNtkG6srT17JM2Xi/tsJOWK7sJaU0Ia2k03S+L5bnQ54uWdlkgav7X0A4NttXSyMycRcWIa+BAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777496268; c=relaxed/simple;
	bh=lyl6ZdbZMvyo4kBR/Heezz16UodXnoTk7aVo1YqqJsM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KO3a1WKqIeVNRDFdfzcgGUTn9XCk/a/XGxbmxh2L8aN/NUY65j5NS9YnEj84dOmG8erJ7h3vzToyjKfwm+1y4zTcMtYgkWNM4VVx9XCXP4zrFrSQUhO77h49oOzc2NchhEEs43iBxdidJFkJqcwG1Z4G9KBTN2oMu9Z4ZNx3iLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XdtRAtnq; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777496266; x=1809032266;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=lyl6ZdbZMvyo4kBR/Heezz16UodXnoTk7aVo1YqqJsM=;
  b=XdtRAtnqt3xvkT6OZZJUeHC4NMtUXMCmM2lCv8ewAL0rGcOVE5o0JaWc
   6/EZ61deqrv7gFwbiYrLc7Kbe3Gq7eZLQJP00HIjTUKA3llku0AR4AerE
   gweNXu1MaZjUiyDUq71vxsQ5GQzhvmHLjdunqRXE8tdIBvOXA8uboXLuq
   IF4JcgZ+TSScj1yaOAnidz5HC9QQRRqHQF7N4reKdNNQx1++MbCwXt2kc
   Ae6zVExTr7dUu9a6n/Ng7zxMvWEgm+qgV6MM9Vx78P0vANMTsz83KlNO7
   nHO27f2hrLuS0t/MVlrT8qwIZ78jhDzmbGcCq2YUjA+ehBIzMwTqYsfY4
   A==;
X-CSE-ConnectionGUID: 8nQ/2ovcSoef560yVMWpZA==
X-CSE-MsgGUID: jws3igJTTc6DWBeq/7gcpA==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="78330743"
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="78330743"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 13:57:45 -0700
X-CSE-ConnectionGUID: Kz7BqNLbSP6hnjcLs+yDmQ==
X-CSE-MsgGUID: yZlLZ4X9T/6M0+33iYrbIA==
X-ExtLoop1: 1
Received: from unknown (HELO [10.241.241.31]) ([10.241.241.31])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 13:57:45 -0700
Message-ID: <3fbb8451-62a3-49c3-bf76-ceb2ca4794cb@intel.com>
Date: Wed, 29 Apr 2026 13:57:44 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] perf/x86/intel: Fix kernel address leakages in LBR
 stack
To: Dapeng Mi <dapeng1.mi@linux.intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Dapeng Mi <dapeng1.mi@intel.com>, Falcon Thomas <thomas.falcon@intel.com>,
 Xudong Hao <xudong.hao@intel.com>, stable@vger.kernel.org
References: <20260414021440.928068-1-dapeng1.mi@linux.intel.com>
 <20260414021440.928068-2-dapeng1.mi@linux.intel.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <20260414021440.928068-2-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 5230849A486
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-241944-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zide.chen@intel.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]



On 4/13/2026 7:14 PM, Dapeng Mi wrote:
> Prior to the arch-LBR which supports CPL filtering, the kernel address
> could be leaked to user space even PERF_SAMPLE_BRANCH_USER is required.

This sounds correct to catch these branches, since only the target CPL
counts. The software filtering is implemented to match the HW behavior:

Legacy LBR.
CPL_EQ_0: When set, do not capture branches ending in ring 0
CPL_NEQ_0: When set, do not capture branches ending in ring >0

Arch LBR:
For operations which change the CPL, the operation is recorded in LBRs
only if the CPL at the end of the operation is enabled for LBR
recording. In cases where the CPL transitions from a value that is
filtered out to a value that is enabled for LBR
recording, the FROM_IP address for the recorded CPL transition branch or
event will be 0FFFFFFFFFFFFFFFFH.

> 
> e.g., run below command on Intel Tigerlake platform,
> 
> ```
> $./perf record -e cycles:p -o - --branch-filter any,save_type,u -- \
>  	./perf bench syscall basic --loop 1000 | \
> 	./perf script -i - --fields brstack|tr ' ' '\n'| \
> 	grep -E '0x[89a-f][0-9a-f]{15}'
> 
>     Total time: 0.000 [sec]
> 
>       0.219000 usecs/op
>      4,566,210 ops/sec
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.551 MB - ]
> 0xffffffff93c001c8/0x7f12a2b1d647/P/-/-/16959/SYSRET/-
> 0xffffffff93c001c8/0x7f12a2b1d5c2/P/-/-/17535/SYSRET/-
> 0xffffffff93c01928/0x7f12a2861000/P/-/-/6719/ERET/-
> 0xffffffff93c01928/0x7f12a297a000/P/-/-/8575/ERET/-
> ```

Thus, filtering with USR=1, it's correct that ERET/SYSRET show up in the
above command running on TG because the target CPL is 3. However, the
from address should be hidden with 0xFFFFFFFFFFFFFFFF.

Instead, this appears a bug on platforms with CPL filtering (SPR, etc.)
that filters out these branches. This is because for ERET/SYSRET, the
br_type is 8 (OTHER_BRANCH), so even on arch LBR, it gets the type from
branch_type() which incorrectly translates type 8 to 0 (X86_BR_NONE).

Therefore, something needs to be done in get_branch_type() to handle
OTHER_BRANCH.

> The SYSRET/ERET branch calls are found the in the LBR stack, whose "from"
> addresses are obviously kernel address.
> 
> Currently intel_pmu_lbr_filter() only filters out the LBR entries whose
> "to" address is a kernel address but doesn't check the "from" address.
> 
> To fix the issue, extend the software filtering to both "from" and "to"
> addresses.
> 
> Cc: stable@vger.kernel.org
> Reported-by: Ian Rogers <irogers@google.com>
> Fixes: 47125db27e47 ("perf/x86/intel/lbr: Support Architectural LBR")
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> ---
>  arch/x86/events/intel/lbr.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
> index 16977e4c6f8a..deef81c16571 100644
> --- a/arch/x86/events/intel/lbr.c
> +++ b/arch/x86/events/intel/lbr.c
> @@ -1212,7 +1212,7 @@ intel_pmu_lbr_filter(struct cpu_hw_events *cpuc)
>  {
>  	u64 from, to;
>  	int br_sel = cpuc->br_sel;
> -	int i, j, type, to_plm;
> +	int i, j, type, to_plm, from_plm;
>  	bool compress = false;
>  
>  	/* if sampling all branches, then nothing to filter */
> @@ -1244,8 +1244,15 @@ intel_pmu_lbr_filter(struct cpu_hw_events *cpuc)
>  				type |= X86_BR_NO_TX;
>  		}
>  
> -		/* if type does not correspond, then discard */
> -		if ((type & ~X86_BR_PLM) == X86_BR_NONE || (br_sel & type) != type) {
> +		from_plm = kernel_ip(from) ? X86_BR_KERNEL : X86_BR_USER;
> +		/*
> +		 * If type does not correspond, then discard.
> +		 * Especially filter out the entries whose from or to address
> +		 * is a kernel address while only X86_BR_USER is set. This prevents
> +		 * kernel address from being leaked into a user-space-only LBR stack.
> +		 */
> +		if ((type & ~X86_BR_PLM) == X86_BR_NONE || (br_sel & type) != type ||
> +		    (!(br_sel & X86_BR_KERNEL) && (from_plm & X86_BR_KERNEL))) {
>  			cpuc->lbr_entries[i].from = 0;
>  			compress = true;
>  		}


