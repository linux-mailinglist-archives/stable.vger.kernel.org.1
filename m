Return-Path: <stable+bounces-240262-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SNDPCGwj6GlmFwIAu9opvQ
	(envelope-from <stable+bounces-240262-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 03:25:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7972644117A
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 03:24:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C67C3302813B
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 01:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2D602DC332;
	Wed, 22 Apr 2026 01:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cmCErcyy"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3D82DB7B7;
	Wed, 22 Apr 2026 01:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776821092; cv=none; b=jWwbT14JuqVz4RzfVOtT7VW0qymK0fgc+Z8XQTuSMMmJ6lnNCGw1xXzKHB3tv+dOB/yqU29KElxbj/LP65lGjvSfuAsvAtYtlD1LbaygeCXO6oKVdy75/Xn8ODRJen7yjFFgZ75oki47oaVqZr93ZWLFkTflet2Qyjjp/xNvbbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776821092; c=relaxed/simple;
	bh=RvQJPe/c1FEaL4W7mviTX+t1PEC36kRAsnbojvr4DYs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f8fJYQnPppwH10eTFCdt/ZHmmQUtDwNhzYF3SFGASrqmCWECHulzy+m8YZ/FrHd59UXu++vYZ/BAgpkbNSeQ2osvOgYQIIpJl9R/xpsJqgZf9ouQoIncIjz4JjIWGsaWDxLTDtvgY2LZlSvwo2/1m4IWyKg/hEM9+MmLYp3VnYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cmCErcyy; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776821090; x=1808357090;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=RvQJPe/c1FEaL4W7mviTX+t1PEC36kRAsnbojvr4DYs=;
  b=cmCErcyypEo2+68/s8woeDa3OrpBIkQ2osGtkzCjgOFqh7av4ZxDNf+u
   VrCr0/wSvy/CRXMclHvpgcX8HO6VhI9xzE5of4LG8HpbvDfZxrd7ZK1rC
   fDho7g+YMmFN877SGVEJQ4bmI+ZX3MNc/q+zFBtgiWviDBQbEuhml8cL3
   arVTgbLlY7C1A544kIVhqkfv+OaaWgWEsbxe87c8FRohL0ukN+ydsT7jz
   IDdku9oH8cuCmAvo0eVH9SLmzJp4McYrLJLqOxsHDLx8gDF5HS3JTXhPP
   wNyJdDrz04qlnJaJpTj28YJ5zPiPyUQBF5sunLghqmbfvWJEtUbIt6H9M
   Q==;
X-CSE-ConnectionGUID: 4IMzsqSbScaIfw+P/Xqu/g==
X-CSE-MsgGUID: fFJuZjCURYa/lXDjEEv5Fw==
X-IronPort-AV: E=McAfee;i="6800,10657,11763"; a="80356117"
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="80356117"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2026 18:24:49 -0700
X-CSE-ConnectionGUID: iugpKQt7T1q0HjPfV0U8Xw==
X-CSE-MsgGUID: p6AYKrUXTcKDzqnRjO/kig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="232123865"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.147]) ([10.124.241.147])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2026 18:24:45 -0700
Message-ID: <f1cb6c84-d8ff-46a0-a062-816fce9fc164@linux.intel.com>
Date: Wed, 22 Apr 2026 09:24:42 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v2 2/4] perf/x86/intel: Disable PMI for self-reloaded ACR
 events
To: Andi Kleen <ak@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Eranian Stephane <eranian@google.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Dapeng Mi <dapeng1.mi@intel.com>,
 Zide Chen <zide.chen@intel.com>, Falcon Thomas <thomas.falcon@intel.com>,
 Xudong Hao <xudong.hao@intel.com>, stable@vger.kernel.org
References: <20260420024528.2130065-1-dapeng1.mi@linux.intel.com>
 <20260420024528.2130065-3-dapeng1.mi@linux.intel.com>
 <aef8InBGlZaXNuPk@tassilo>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <aef8InBGlZaXNuPk@tassilo>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-240262-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dapeng1.mi@linux.intel.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.intel.com:mid]
X-Rspamd-Queue-Id: 7972644117A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 4/22/2026 6:37 AM, Andi Kleen wrote:
> On Mon, Apr 20, 2026 at 10:45:26AM +0800, Dapeng Mi wrote:
>> @@ -3306,6 +3306,15 @@ static void intel_pmu_enable_event(struct perf_event *event)
>>  		intel_set_masks(event, idx);
>>  		static_call_cond(intel_pmu_enable_acr_event)(event);
>>  		static_call_cond(intel_pmu_enable_event_ext)(event);
>> +		/*
>> +		 * For self-reloaded ACR event, don't enable PMI since
>> +		 * HW won't set overflow bit in GLOBAL_STATUS. Otherwise,
>> +		 * the PMI would be recognized as a suspicious NMI.
>> +		 */
>> +		if (is_acr_self_reload_event(event))
>> +			hwc->config &= ~ARCH_PERFMON_EVENTSEL_INT;
>> +		else if (!event->attr.precise_ip)
>> +			hwc->config |= ARCH_PERFMON_EVENTSEL_INT;
> It seems weird to either clear or set the bit. You don't know the previous
> state of the bit here? I would assume it starts with zero?

It's hard and unsafe to trace the previous state. Generally speaking, the
PMI bit would always be set by default at the initialization, then it would
be cleared later if it's a PEBS or ACR self-reloaded event. 


>
>> +static inline bool is_acr_self_reload_event(struct perf_event *event)
>> +{
>> +	struct hw_perf_event *hwc = &event->hw;
>> +
>> +	if (hwc->idx < 0)
>> +		return false;
>> +
>> +	return test_bit(hwc->idx, (unsigned long *)&hwc->config1);
> Are you sure this doesn't conflict with some other non ACR usage of config1?

Yes, currently hw.config1 is only used to store ACR  event indices.

Thanks.


>
>
> -Andi

