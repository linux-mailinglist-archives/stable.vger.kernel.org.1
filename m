Return-Path: <stable+bounces-241968-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IJQ1EXml8mk0tQEAu9opvQ
	(envelope-from <stable+bounces-241968-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 02:42:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9256B49BCF8
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 02:42:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 17A203015890
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 00:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 614611E1E04;
	Thu, 30 Apr 2026 00:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CSAkxanz"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3231DA0E1;
	Thu, 30 Apr 2026 00:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777509746; cv=none; b=dC5O3VRvP1TfMxpBk+QAnbmuWxl+BH2aMyMqej1hTe7Lci53iZ2cbBVpO5XRQQlbvfdmXuz8ZrrnTCPytRjHm8aP8zL+fyjOaAz9+GmMV35W9QIi7WTey5u6ZomOjE+T8mmFFKHJck5zOcCaeWRB6h8tuUnPrVbMi7A6JOiO8s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777509746; c=relaxed/simple;
	bh=CFkQlQoustuLQuz9Og38T5MQgKOUNOg50wj8B6yJ+tg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mgNksLmLVUDcr+SFjyDvbsWdPAGtLpgsR4RUJQ2J7FZHqiK3pJuXSRPjU5f0WbH8Di4NLxlIP2UnA7vUZLixHAK3JkWpa5/V7Qijk93Ej4QqUMGWV6s0ZIq/XYLm6ZgsFUvPM0I/NG/GcCVZVLZjo7lBugJdl/0Pe8q8p9FlqUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CSAkxanz; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777509744; x=1809045744;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=CFkQlQoustuLQuz9Og38T5MQgKOUNOg50wj8B6yJ+tg=;
  b=CSAkxanz+vIUTc//XI6DSiU96MHvWCQFQpB16jkalc7RnW0VntaOWX45
   eG5RLSFqO3ccyfuZmfHKLbdAZDn6O+6HY05pdeYSt08AMqRvzXOWChfgi
   IZkA+3M/g08SBEUAqZUrJtXRAw6LaNxGIR+1oNuk64R8sz/mRKffXBD9q
   lgRzMgazsk08G+OO1khuNuaI67WX5WmCZyNdIq+jIY341oETQoEC6c6U4
   qOhc7P8ASoKLzaiLjoXkYRiU+RQJEiZOnW7M7vnn1RiaXIybSz89E0UHP
   ZYNKXF7UzWGzq8ybl7QQkR0FhfnTljPRYJSwNsq5tvFUh73MukB9f2ESP
   g==;
X-CSE-ConnectionGUID: D3+09mOBSMOoqXzsKUjpxA==
X-CSE-MsgGUID: K+f4aBxTTNK/Q9JGT4hohg==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="78641381"
X-IronPort-AV: E=Sophos;i="6.23,207,1770624000"; 
   d="scan'208";a="78641381"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 17:42:23 -0700
X-CSE-ConnectionGUID: jK4F5DvgRaeMZGVWQy0xAw==
X-CSE-MsgGUID: cI5MWfXVSim3cEClan1TlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,207,1770624000"; 
   d="scan'208";a="231781101"
Received: from unknown (HELO [10.238.2.250]) ([10.238.2.250])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 17:42:19 -0700
Message-ID: <7c17b02f-ed3d-4c11-b499-44ab6aae6b69@linux.intel.com>
Date: Thu, 30 Apr 2026 08:42:18 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] perf/x86/intel: Fix redundant branch type check in
 intel_pmu_lbr_filter()
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
 <0b6dbecd-f3e1-40ca-97a2-e0df36a39704@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <0b6dbecd-f3e1-40ca-97a2-e0df36a39704@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 9256B49BCF8
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
	TAGGED_FROM(0.00)[bounces-241968-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.intel.com:mid,intel.com:dkim,intel.com:email]


On 4/30/2026 4:58 AM, Chen, Zide wrote:
>
> On 4/13/2026 7:14 PM, Dapeng Mi wrote:
>> In intel_pmu_lbr_filter(), the 'type' variable is bitwise ORed with
>> 'to_plm' (which contains X86_BR_USER and/or X86_BR_KERNEL bits). Because
>> of this, 'type' can never equal X86_BR_NONE (0) after the assignment.
> Nit: In legacy LBR case, it could if get_branch_type() returns X86_BR_NONE.

Yeah, it's correct and need to change the description slightly.

Thanks.


>
>> As a result, the subsequent check 'if (type == X86_BR_NONE)' is dead code
>> and the entries with X86_BR_NONE type would not be skipped eventually.
>>
>> Correct this by masking out the X86_BR_KERNEL and X86_BR_USER bits
>> before performing the X86_BR_NONE comparison.
>>
>> Cc: stable@vger.kernel.org
>> Fixes: 47125db27e47 ("perf/x86/intel/lbr: Support Architectural LBR")
>> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
>> ---
>>  arch/x86/events/intel/lbr.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
>> index 72f2adcda7c6..16977e4c6f8a 100644
>> --- a/arch/x86/events/intel/lbr.c
>> +++ b/arch/x86/events/intel/lbr.c
>> @@ -1245,7 +1245,7 @@ intel_pmu_lbr_filter(struct cpu_hw_events *cpuc)
>>  		}
>>  
>>  		/* if type does not correspond, then discard */
>> -		if (type == X86_BR_NONE || (br_sel & type) != type) {
>> +		if ((type & ~X86_BR_PLM) == X86_BR_NONE || (br_sel & type) != type) {
>>  			cpuc->lbr_entries[i].from = 0;
>>  			compress = true;
>>  		}

