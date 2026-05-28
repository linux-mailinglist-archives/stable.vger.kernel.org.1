Return-Path: <stable+bounces-255080-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yIVBIMSEGGrhkggAu9opvQ
	(envelope-from <stable+bounces-255080-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:09:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E9B945F61AE
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:09:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A9C05301E7D9
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 18:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D91B4028DC;
	Thu, 28 May 2026 18:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iLuk9nui"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB24318BA6;
	Thu, 28 May 2026 18:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779991660; cv=none; b=ZuNTkLqKFIN7MHB7SryB5EHLc6QSbZh8VPK+pacDSvwDwWsxIbBe1RsYkMkpo5WcRxVti9cuxmnlZwdWj+ls4RYNaQl7b7hqQyQwmjM4Y8Mn2iDLK9oq31A/+0NOHbSvdu2mHENSBI85tKpJ8nPf209pGzTxy8S5UxXYGzdYHNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779991660; c=relaxed/simple;
	bh=tMelLFH+iAL0BW0b/Gdpw2FXWvd2zu83e6Vm8CX7ldk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g2Iwuaw098Be5PhiB796eB+5hWJwZ1xcm34x82jPqsYMPaHMWzeCN+aqfTtj6TeOYpfnMQZTWyqeI97h4jcx8EodR895LpwCvehFnlt2HICgSGbDKS36ok/aRQIB2+IbPHdCErwBXY5vINkwnw7+9oNMkdwx1NKkwQB3Hn7GLRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iLuk9nui; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779991659; x=1811527659;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=tMelLFH+iAL0BW0b/Gdpw2FXWvd2zu83e6Vm8CX7ldk=;
  b=iLuk9nuivxqiTfm3w4EQVX6Kt8O+xw4aFnMchBJxTy213Gc4ljefNDtW
   U0zmTx/f/ony25vRf6sIC6Eyzni6+bmSBIcYajCD10vcNJHfEJUqOVU71
   i7cy6P18GhfYXrMJkyddplHViVtYb89CEzu4At9v5PUuytsTgueXtpDsG
   BCJBsnAoKMc4KbZuTeh7AkmnLVeGwn52/W/UzrNgBdQb3Ok1RAbEYYuPK
   hFdi03ArlWWYl4wn0d7JHwWF3xKhpiQw7ljgoktWFmh12mUzd7HXIh5Fx
   D3gc9gMQKLL8tj97w1SG5kih1ukGpRU9wUqhrhv+NFniDsfk9Bh5Xi4rT
   A==;
X-CSE-ConnectionGUID: KEsj76Q/Rl2FyPP5N8zYvw==
X-CSE-MsgGUID: QM5Mbs2zTfii5e1ItOtLtA==
X-IronPort-AV: E=McAfee;i="6800,10657,11800"; a="80566456"
X-IronPort-AV: E=Sophos;i="6.24,173,1774335600"; 
   d="scan'208";a="80566456"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 11:07:39 -0700
X-CSE-ConnectionGUID: 2A9BV3v2Qc+kVX9T3qCDeg==
X-CSE-MsgGUID: 6ycwWnXTQvOzVPrmTbFklQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,173,1774335600"; 
   d="scan'208";a="244441491"
Received: from soc-cp83kr3.clients.intel.com (HELO [10.122.185.5]) ([10.122.185.5])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 11:07:38 -0700
Message-ID: <73ec703b-ad87-4afc-8bff-1d86a895bea8@intel.com>
Date: Thu, 28 May 2026 13:07:37 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 4/7] perf/x86/intel/uncore: Defer ADL global PMON
 enable to enable_box()
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 stable@vger.kernel.org
References: <20260527151154.130505-1-zide.chen@intel.com>
 <20260527151154.130505-4-zide.chen@intel.com>
 <66f281e5-0653-4f67-80c7-de64adb0a4e7@linux.intel.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <66f281e5-0653-4f67-80c7-de64adb0a4e7@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zide.chen@intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255080-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+]
X-Rspamd-Queue-Id: E9B945F61AE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 5/28/2026 1:35 AM, Mi, Dapeng wrote:
> 
> On 5/27/2026 11:11 PM, Zide Chen wrote:
>> On some Raptor Cove CPUs, enabling uncore PMON globally at driver init
>> may increase power consumption even when no perf events are in use.
>>
>> Drop adl_uncore_msr_init_box() and defer programming the global control
>> register to enable_box(), so it is only set when a box is actually used.
>>
>> IMC and IMC freerunning counters use a separate control path and are
>> unaffected.
>>
>> Cc: stable@vger.kernel.org
> 
> Need a "Fixes" tag?

Not really. This is a workaround for hardware issues rather than a fix
for software bugs.

> Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> 
> 
>> Signed-off-by: Zide Chen <zide.chen@intel.com>
>> ---
>>  arch/x86/events/intel/uncore_snb.c | 7 -------
>>  1 file changed, 7 deletions(-)
>>
>> diff --git a/arch/x86/events/intel/uncore_snb.c b/arch/x86/events/intel/uncore_snb.c
>> index 3dbc6bacbd9d..edddd4f9ab5f 100644
>> --- a/arch/x86/events/intel/uncore_snb.c
>> +++ b/arch/x86/events/intel/uncore_snb.c
>> @@ -563,12 +563,6 @@ void tgl_uncore_cpu_init(void)
>>  	skl_uncore_msr_ops.init_box = rkl_uncore_msr_init_box;
>>  }
>>  
>> -static void adl_uncore_msr_init_box(struct intel_uncore_box *box)
>> -{
>> -	if (box->pmu->pmu_idx == 0)
>> -		wrmsrq(ADL_UNC_PERF_GLOBAL_CTL, SNB_UNC_GLOBAL_CTL_EN);
>> -}
>> -
>>  static void adl_uncore_msr_enable_box(struct intel_uncore_box *box)
>>  {
>>  	wrmsrq(ADL_UNC_PERF_GLOBAL_CTL, SNB_UNC_GLOBAL_CTL_EN);
>> @@ -587,7 +581,6 @@ static void adl_uncore_msr_exit_box(struct intel_uncore_box *box)
>>  }
>>  
>>  static struct intel_uncore_ops adl_uncore_msr_ops = {
>> -	.init_box	= adl_uncore_msr_init_box,
>>  	.enable_box	= adl_uncore_msr_enable_box,
>>  	.disable_box	= adl_uncore_msr_disable_box,
>>  	.exit_box	= adl_uncore_msr_exit_box,


