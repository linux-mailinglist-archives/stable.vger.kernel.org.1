Return-Path: <stable+bounces-224808-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OPRMO8lismntMAAAu9opvQ
	(envelope-from <stable+bounces-224808-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 07:52:57 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E94126E0DB
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 07:52:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0ECFE30484E8
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 06:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32E473A6F1A;
	Thu, 12 Mar 2026 06:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="js1oqny9"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8C6302CD5;
	Thu, 12 Mar 2026 06:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773298372; cv=none; b=IYX1rIHs+2RscnYCcbuHMbYYj19vVb2Qr7cwOHltv+jXfZ9dVpXBYr7EUXlp32G/BkqctixoGzp9pV88BrsnqLtrIfs21JlENmM6F0ZHA5CSCs9U5gJrSPTfEWaZypcus5sOiUCqkl/tBvpv0I+GPxqNnVLCCblRvrktefwhYuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773298372; c=relaxed/simple;
	bh=8I/I+1yrDYc20jEasy+FWA3EIROpAGFwzDYInxrihcs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S8rBjwmGstGEm84aJp11XRwOF1a35Gt02TNCFBwqP7sTxIEU5iAhXdpT5uLS35Meurspt9jKJWQI0kGw6iaL9a7c5I5NOxi7FgeItSOFPC+xj81vCQsr7QKy5v/Vp/LI8jmzd6U9QgQBzKOuqw0fPl6OktXOZ7q4njxNCUJkfWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=js1oqny9; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773298370; x=1804834370;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8I/I+1yrDYc20jEasy+FWA3EIROpAGFwzDYInxrihcs=;
  b=js1oqny9xFYgHspKuDc+XK7cHVAqDRk+SIYpqeTwCMOjBywchrxhxf3Z
   8cU1reP/PCip3h0zGvvG/WUwticAYlHaYRKbpS0414yofYJtUQC3lO7Hk
   8xves493c56l4LLnA7v66FbstdSAEQSKkP/Tt8gKEjLW2iNnfc3tD0euL
   NVoIxZWqW1YS9b7UqBQ0QpGIIErRMQ7BXbtKTJfChHV91i+7UCj76XT3u
   LShbanNRisjEP2haalZJ0brLQ8urNpKaHDDAMc5VuyJ9u4RvU8elGGbKA
   hMzhpGw3ZubHtS4pI1I5CHhkFBi3iqsyU7YIdLR6iOyCttC7hvSR/L6/k
   A==;
X-CSE-ConnectionGUID: MJSWCaPQS5ecwtXgKBPCIw==
X-CSE-MsgGUID: +BiYCcdFTjSjIFBYJIBWAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11726"; a="85856926"
X-IronPort-AV: E=Sophos;i="6.23,115,1770624000"; 
   d="scan'208";a="85856926"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 23:52:49 -0700
X-CSE-ConnectionGUID: w7RPRgpxTjuG4hsNC+hbUQ==
X-CSE-MsgGUID: EOEueEzFQMOVJcRwIZ0hSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,115,1770624000"; 
   d="scan'208";a="225688143"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.147]) ([10.124.241.147])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 23:52:46 -0700
Message-ID: <a856792a-89ee-4de5-9923-106a23c31206@linux.intel.com>
Date: Thu, 12 Mar 2026 14:52:43 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND Patch 2/2] perf/x86/intel: Add missing branch counters
 constraint apply
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Dapeng Mi <dapeng1.mi@intel.com>, Zide Chen <zide.chen@intel.com>,
 Falcon Thomas <thomas.falcon@intel.com>, Xudong Hao <xudong.hao@intel.com>,
 stable@vger.kernel.org
References: <20260228053320.140406-1-dapeng1.mi@linux.intel.com>
 <20260228053320.140406-2-dapeng1.mi@linux.intel.com>
 <20260311201625.GW606826@noisy.programming.kicks-ass.net>
 <0a720411-0b24-42eb-9897-856b1175aa82@linux.intel.com>
 <20260312064145.GA606826@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260312064145.GA606826@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
	TAGGED_FROM(0.00)[bounces-224808-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dapeng1.mi@linux.intel.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,linux.intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0E94126E0DB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 3/12/2026 2:41 PM, Peter Zijlstra wrote:
> On Thu, Mar 12, 2026 at 10:31:28AM +0800, Mi, Dapeng wrote:
>> On 3/12/2026 4:16 AM, Peter Zijlstra wrote:
>>> On Sat, Feb 28, 2026 at 01:33:20PM +0800, Dapeng Mi wrote:
>>>> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
>>>> index 4768236c054b..4b042d71104f 100644
>>>> --- a/arch/x86/events/intel/core.c
>>>> +++ b/arch/x86/events/intel/core.c
>>>> @@ -4628,6 +4628,19 @@ static inline void intel_pmu_set_acr_caused_constr(struct perf_event *event,
>>>>  		event->hw.dyn_constraint &= hybrid(event->pmu, acr_cause_mask64);
>>>>  }
>>>>  
>>>> +static inline int intel_set_branch_counter_constr(struct perf_event *event,
>>>> +						  int *num)
>>>> +{
>>>> +	if (branch_sample_call_stack(event))
>>>> +		return -EINVAL;
>>>> +	if (branch_sample_counters(event)) {
>>>> +		(*num)++;
>>>> +		event->hw.dyn_constraint &= x86_pmu.lbr_counters;
>>>> +	}
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>>  static int intel_pmu_hw_config(struct perf_event *event)
>>>>  {
>>>>  	int ret = x86_pmu_hw_config(event);
>>>> @@ -4698,21 +4711,18 @@ static int intel_pmu_hw_config(struct perf_event *event)
>>>>  		 * group, which requires the extra space to store the counters.
>>>>  		 */
>>>>  		leader = event->group_leader;
>>>> +		if (intel_set_branch_counter_constr(leader, &num))
>>>>  			return -EINVAL;
>>>>  		leader->hw.flags |= PERF_X86_EVENT_BRANCH_COUNTERS;
>>>>  
>>>>  		for_each_sibling_event(sibling, leader) {
>>>> +			if (intel_set_branch_counter_constr(sibling, &num))
>>>> +				return -EINVAL;
>>>> +		}
>>>> +
>>> Do the new bit is this, right?
>> Actually not, the key change is the below one. The last event in the group
>> is not applied the branch counter constraint.
>>
>> Assume we have a event group {cycles,instructions,branches}. When the 3rd
>> event "branches" is created and the function intel_pmu_hw_config() is
>> called for the "branches" event to check the config.  The event leader is
>> "cycles" and the sibling event has only the "instructions" event at that
>> time since the 3rd event "branches" is in creation and still not added into
>> the sibling_list. So for_each_sibling_event() can't really iterate the
>> "branches" event.
>>
>>
>>>> +		if (event != leader) {
>>>> +			if (intel_set_branch_counter_constr(event, &num))
>>>>  				return -EINVAL;
>>>>  		}
>>> The point being that for_each_sibling_event() will not have iterated the
>>> event because its not on the list yet?
>> Yes. 
>>
>>
>>> That wasn't really clear from the changelog and I think that deserves a
>>> comment as well.
>> Sure. I would add comment and enhance the changelog to make it clearer. Thanks.
>>
> I already fixed everything up. Should be in queue/perf/urgent.

Thanks. 

Peter, As Ian points out, the patch "perf/x86: Update cap_user_rdpmc base
on rdpmc user disable state" has a bug
(https://lore.kernel.org/all/CAP-5=fWr2L6miiFZ6Km3HYEdmqp3T0NBL=WY3buKdKztW+HvmA@mail.gmail.com/).
I would posted a patch to fix the issue. Thanks.



>

