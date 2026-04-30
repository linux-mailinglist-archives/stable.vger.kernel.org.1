Return-Path: <stable+bounces-241973-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6DEgKs+u8mkatgEAu9opvQ
	(envelope-from <stable+bounces-241973-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 03:22:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EC17049BFCD
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 03:22:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 21F12302AE27
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 01:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E18412609FD;
	Thu, 30 Apr 2026 01:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hTDvD+xS"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7BD9258CE7;
	Thu, 30 Apr 2026 01:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777512137; cv=none; b=SHCmAMT1mdnw+MhfXi2s+XalofbdbWHTUdL2eKJv4Fow/LHw5bLO/GwhcHycXO/T6Y1TEz6FwHBPn3V5f/g3H4hNpkCTIXOALatRadHMIp7XTPDfCXuBrMsBn7zikoFaXgP5gpsd9HkDhYarWtoivrDgiLSk4E8ZQJkdinGyUPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777512137; c=relaxed/simple;
	bh=tHUc23y70EGrdqKcDG61yYGuDR+LZYbjpPzuz8uFSyk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X9getnZEMaKaCw+fQonnbQwZLs4Ny+uUByHmCGe6FnatdIMdRzHjsbNFzb5qH6a7JK4GSCwwHq7+dsmcR9uJSQ1ZnJ0thQQ3YT+apg5F0RwQnbT6yw/1yRYnznAn+HqJRZlmtJEj/lvOJJMMA641TQUH3DzRdxKlKDAJZRtiX5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hTDvD+xS; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777512136; x=1809048136;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=tHUc23y70EGrdqKcDG61yYGuDR+LZYbjpPzuz8uFSyk=;
  b=hTDvD+xSbkiDdh5Am3EuCuCDrksomEJxDl8gwxOYfyXf2z5GuXZjiaGF
   Shf7/k8MGn9egbPw5cm2jM0e2DzQ8ixjXO9Ujw4gFmEex+QuEjta3aXIA
   QFETZx1Gkd2gDPqfEqIECabLSzz53/Vdl1T3TEGDZ0zMtll2xAwDV+XLA
   U5aOcNGolmKd6EyLnduN15tcFWvYCtEE5vOrt7knlm8Stgr2x3BM/McBS
   ldq/7H9qvg6mib6k/9e8bq2I57c+HN0e4K4BcDGcsIY85OYUJbTJ4/zp3
   8nvYQl092FHdm1xL06Yi0QVISC7gMhd1FKNxMVsbYYZLoYbugMYkTLQ5f
   A==;
X-CSE-ConnectionGUID: R2rBUkVfT6ixVkuT9KYsTg==
X-CSE-MsgGUID: Z7UCZZZHRXeKMaHdB1IkyQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="89828077"
X-IronPort-AV: E=Sophos;i="6.23,207,1770624000"; 
   d="scan'208";a="89828077"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 18:22:15 -0700
X-CSE-ConnectionGUID: fRhvcAWlReegYwsoCGaR4Q==
X-CSE-MsgGUID: 8oSvWKdHQWKFd8SWZ/poWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,207,1770624000"; 
   d="scan'208";a="238405857"
Received: from unknown (HELO [10.238.2.250]) ([10.238.2.250])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 18:22:11 -0700
Message-ID: <605f3965-798b-42d2-ad00-de5a6466a292@linux.intel.com>
Date: Thu, 30 Apr 2026 09:22:08 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] perf/x86/intel: Fix kernel address leakages in LBR
 stack
To: "Chen, Zide" <zide.chen@intel.com>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
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
 <3fbb8451-62a3-49c3-bf76-ceb2ca4794cb@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <3fbb8451-62a3-49c3-bf76-ceb2ca4794cb@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: EC17049BFCD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-241973-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,linux.intel.com:mid]


On 4/30/2026 4:57 AM, Chen, Zide wrote:
>
> On 4/13/2026 7:14 PM, Dapeng Mi wrote:
>> Prior to the arch-LBR which supports CPL filtering, the kernel address
>> could be leaked to user space even PERF_SAMPLE_BRANCH_USER is required.
> This sounds correct to catch these branches, since only the target CPL
> counts. The software filtering is implemented to match the HW behavior:
>
> Legacy LBR.
> CPL_EQ_0: When set, do not capture branches ending in ring 0
> CPL_NEQ_0: When set, do not capture branches ending in ring >0
>
> Arch LBR:
> For operations which change the CPL, the operation is recorded in LBRs
> only if the CPL at the end of the operation is enabled for LBR
> recording. In cases where the CPL transitions from a value that is
> filtered out to a value that is enabled for LBR
> recording, the FROM_IP address for the recorded CPL transition branch or
> event will be 0FFFFFFFFFFFFFFFFH.

Yes, this is exactly what HW does.


>
>> e.g., run below command on Intel Tigerlake platform,
>>
>> ```
>> $./perf record -e cycles:p -o - --branch-filter any,save_type,u -- \
>>  	./perf bench syscall basic --loop 1000 | \
>> 	./perf script -i - --fields brstack|tr ' ' '\n'| \
>> 	grep -E '0x[89a-f][0-9a-f]{15}'
>>
>>     Total time: 0.000 [sec]
>>
>>       0.219000 usecs/op
>>      4,566,210 ops/sec
>> [ perf record: Woken up 1 times to write data ]
>> [ perf record: Captured and wrote 0.551 MB - ]
>> 0xffffffff93c001c8/0x7f12a2b1d647/P/-/-/16959/SYSRET/-
>> 0xffffffff93c001c8/0x7f12a2b1d5c2/P/-/-/17535/SYSRET/-
>> 0xffffffff93c01928/0x7f12a2861000/P/-/-/6719/ERET/-
>> 0xffffffff93c01928/0x7f12a297a000/P/-/-/8575/ERET/-
>> ```
> Thus, filtering with USR=1, it's correct that ERET/SYSRET show up in the
> above command running on TG because the target CPL is 3. However, the
> from address should be hidden with 0xFFFFFFFFFFFFFFFF.

Hmm, in theory forcing the "from" IP to 0xFFFFFFFFFFFFFFFF seems a better
idea, don't lose SYSRET/ERET trace and no kernel address leakage as well.

It works for legacy LBR, but arch-LBR HW already forces the "from" IP to
0xFFFFFFFFFFFFFFFF , SW has no way to figure out the real branch type, so
the branch type has to be converted X86_BR_NONE which leads to this entry
is dropped.

Beside, I'm not sure if this would break current test case. @Ian, how's
your idea on this?


>
> Instead, this appears a bug on platforms with CPL filtering (SPR, etc.)
> that filters out these branches. This is because for ERET/SYSRET, the
> br_type is 8 (OTHER_BRANCH), so even on arch LBR, it gets the type from
> branch_type() which incorrectly translates type 8 to 0 (X86_BR_NONE).

As above explained, this doesn't work for arch-LBR.

Thanks.


>
> Therefore, something needs to be done in get_branch_type() to handle
> OTHER_BRANCH.
>
>> The SYSRET/ERET branch calls are found the in the LBR stack, whose "from"
>> addresses are obviously kernel address.
>>
>> Currently intel_pmu_lbr_filter() only filters out the LBR entries whose
>> "to" address is a kernel address but doesn't check the "from" address.
>>
>> To fix the issue, extend the software filtering to both "from" and "to"
>> addresses.
>>
>> Cc: stable@vger.kernel.org
>> Reported-by: Ian Rogers <irogers@google.com>
>> Fixes: 47125db27e47 ("perf/x86/intel/lbr: Support Architectural LBR")
>> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
>> ---
>>  arch/x86/events/intel/lbr.c | 13 ++++++++++---
>>  1 file changed, 10 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
>> index 16977e4c6f8a..deef81c16571 100644
>> --- a/arch/x86/events/intel/lbr.c
>> +++ b/arch/x86/events/intel/lbr.c
>> @@ -1212,7 +1212,7 @@ intel_pmu_lbr_filter(struct cpu_hw_events *cpuc)
>>  {
>>  	u64 from, to;
>>  	int br_sel = cpuc->br_sel;
>> -	int i, j, type, to_plm;
>> +	int i, j, type, to_plm, from_plm;
>>  	bool compress = false;
>>  
>>  	/* if sampling all branches, then nothing to filter */
>> @@ -1244,8 +1244,15 @@ intel_pmu_lbr_filter(struct cpu_hw_events *cpuc)
>>  				type |= X86_BR_NO_TX;
>>  		}
>>  
>> -		/* if type does not correspond, then discard */
>> -		if ((type & ~X86_BR_PLM) == X86_BR_NONE || (br_sel & type) != type) {
>> +		from_plm = kernel_ip(from) ? X86_BR_KERNEL : X86_BR_USER;
>> +		/*
>> +		 * If type does not correspond, then discard.
>> +		 * Especially filter out the entries whose from or to address
>> +		 * is a kernel address while only X86_BR_USER is set. This prevents
>> +		 * kernel address from being leaked into a user-space-only LBR stack.
>> +		 */
>> +		if ((type & ~X86_BR_PLM) == X86_BR_NONE || (br_sel & type) != type ||
>> +		    (!(br_sel & X86_BR_KERNEL) && (from_plm & X86_BR_KERNEL))) {
>>  			cpuc->lbr_entries[i].from = 0;
>>  			compress = true;
>>  		}

