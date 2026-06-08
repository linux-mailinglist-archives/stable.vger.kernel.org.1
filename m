Return-Path: <stable+bounces-261944-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id R/HCAcQhJmqFSgIAu9opvQ
	(envelope-from <stable+bounces-261944-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 08 Jun 2026 03:58:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 54FBD65227D
	for <lists+stable@lfdr.de>; Mon, 08 Jun 2026 03:58:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=N4PITdgx;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-261944-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-261944-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 82F5E300B63B
	for <lists+stable@lfdr.de>; Mon,  8 Jun 2026 01:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EC2F30F523;
	Mon,  8 Jun 2026 01:56:59 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25CA2EEE9C;
	Mon,  8 Jun 2026 01:56:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780883819; cv=none; b=eNfA7gsM7yh2V8Nv4T1/NkBhhZhLB8lWg/M4YwCihJ4Yn29/KlumZmdhjbLbWtRp9QLRD94wJyOarwoO4nfDv43TTzxT1uVY2qMbLKLwjB109x/vuAa9mRTjsKNZXrLs+58IKqAwmyHyh9SxmMMjOfj0E7P0urFfTFbYw0uH4aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780883819; c=relaxed/simple;
	bh=AXbKzZmARMiJ9DZeCI0Mu9/VI4+YDbO3Pie7AOhUzEA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UetvP9UpyfeWGlShywtAR4V+dqMa3Fg61hQ8QSDlBIDBJuoD/FOqhh4KhsnywnuDZHCWMivcIdFyclTSvwHGHz3PY2XAgNH/aPBFPQLgc7+w3Ti+r++qij+BsgoXNNIolTz3trWfxfK5Vcu++D43aU/Wnck2nKTZKra97Ag6t4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N4PITdgx; arc=none smtp.client-ip=198.175.65.19
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780883817; x=1812419817;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=AXbKzZmARMiJ9DZeCI0Mu9/VI4+YDbO3Pie7AOhUzEA=;
  b=N4PITdgxgn3fyEcdDxUubNq46/YRw3ad1TC1pfuwxt2Z/XItbF71Yrc+
   yYv5XLnnPPiZNmpWkf/SYqc0ndPlwh/TMZgcIjnL0E1hgHWSl4gOu+3gJ
   iQvipDAB4rH3HclhRxSv4aT+xg54PvQAlzxhoGMZ+WSgtGHzOTm7WiecB
   Apopb3uP/1+oR7p7bW+REfzoaJ6ntaT0SO15XruWS5WzPBlOb6hQ2P981
   RL6WOQYglm2oymq2NSgOI+6tlf8Dw9uBS1jmGrssNLVadxW6fElBTO8eJ
   cm3/N/Jglvpk4o78aMC0HP6uiGDrvzA3P41p35IdLICIAgz1Epyxg/x4d
   w==;
X-CSE-ConnectionGUID: OwhEGyyFS2el0bkmqzBEUw==
X-CSE-MsgGUID: hSeI/ddWThC+Hrv+4w/v2A==
X-IronPort-AV: E=McAfee;i="6800,10657,11810"; a="81590989"
X-IronPort-AV: E=Sophos;i="6.24,193,1774335600"; 
   d="scan'208";a="81590989"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2026 18:56:57 -0700
X-CSE-ConnectionGUID: GltD6Je4ShuHvuy+X9V6lQ==
X-CSE-MsgGUID: B1zarMINQ9OlI2v91YuKaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,193,1774335600"; 
   d="scan'208";a="244293130"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.147]) ([10.124.241.147])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2026 18:56:51 -0700
Message-ID: <5290112b-4ef1-46e8-936a-a71f9f3c0b03@linux.intel.com>
Date: Mon, 8 Jun 2026 09:56:48 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/8] perf/x86/intel: Fix redundant branch type check in
 intel_pmu_lbr_filter()
To: "Falcon, Thomas" <thomas.falcon@intel.com>,
 "alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
 "ak@linux.intel.com" <ak@linux.intel.com>,
 "peterz@infradead.org" <peterz@infradead.org>,
 "acme@kernel.org" <acme@kernel.org>, "mingo@redhat.com" <mingo@redhat.com>,
 "Hunter, Adrian" <adrian.hunter@intel.com>,
 "namhyung@kernel.org" <namhyung@kernel.org>, "Rogers, Ian"
 <irogers@google.com>, "Eranian, Stephane" <eranian@google.com>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "Chen, Zide" <zide.chen@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
 "Mi, Dapeng1" <dapeng1.mi@intel.com>, "Hao, Xudong" <xudong.hao@intel.com>
References: <20260605011136.2043393-1-dapeng1.mi@linux.intel.com>
 <20260605011136.2043393-5-dapeng1.mi@linux.intel.com>
 <5f1cedec93b2ea87cb89f259b0eaeddba69093bf.camel@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <5f1cedec93b2ea87cb89f259b0eaeddba69093bf.camel@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261944-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:thomas.falcon@intel.com,m:alexander.shishkin@linux.intel.com,m:ak@linux.intel.com,m:peterz@infradead.org,m:acme@kernel.org,m:mingo@redhat.com,m:adrian.hunter@intel.com,m:namhyung@kernel.org,m:irogers@google.com,m:eranian@google.com,m:stable@vger.kernel.org,m:zide.chen@intel.com,m:linux-kernel@vger.kernel.org,m:linux-perf-users@vger.kernel.org,m:dapeng1.mi@intel.com,m:xudong.hao@intel.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[dapeng1.mi@linux.intel.com,stable@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	DKIM_TRACE(0.00)[intel.com:+];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dapeng1.mi@linux.intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,intel.com:email,intel.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 54FBD65227D


On 6/6/2026 2:28 AM, Falcon, Thomas wrote:
> On Fri, 2026-06-05 at 09:11 +0800, Dapeng Mi wrote:
>> In intel_pmu_lbr_filter(), the 'type' variable is bitwise ORed with
>> 'to_plm' (which contains X86_BR_USER and/or X86_BR_KERNEL bits). Because
>> of this, 'type' can never equal X86_BR_NONE (0) after the assignment.
>>
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
>>
>> Original patch link:
>> https://lore.kernel.org/all/20260414021440.928068-1-dapeng1.mi@linux.intel.com/
>>
>>  arch/x86/events/intel/lbr.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
>> index 72f2adcda7c6..16977e4c6f8a 100644
>> --- a/arch/x86/events/intel/lbr.c
>> +++ b/arch/x86/events/intel/lbr.c
>> @@ -1245,7 +1245,7 @@ intel_pmu_lbr_filter(struct cpu_hw_events *cpuc)
>>  		}
>>  
>>  		/* if type does not correspond, then discard */
>> -		if (type == X86_BR_NONE || (br_sel & type) != type) {
>> +		if ((type & ~X86_BR_PLM) == X86_BR_NONE || (br_sel & type) != type) {
> Looking at intel_pmu_lbr_filter...
>
> 	if (static_cpu_has(X86_FEATURE_ARCH_LBR) &&
> 	    type <= ARCH_LBR_BR_TYPE_KNOWN_MAX) {
> 		to_plm = kernel_ip(to) ? X86_BR_KERNEL : X86_BR_USER;
> 		type = arch_lbr_br_type_map[type] | to_plm;
> 	} else
> 		type = branch_type(from, to, cpuc->lbr_entries[i].abort);
>
> In the else case, it does look (branch_type -> get_branch_type) can return X86_BR_NONE without OR'ing it with X86_BR_KERNEL or X86_BR_USER, so the condition checking the type for X86_BR_NONE is not exactly "dead code."
>
> One example:
>
> static int get_branch_type(unsigned long from, unsigned long to, int abort,
> 			   bool fused, int *offset)
> {
> ...
> 	 * maybe zero if lbr did not fill up after a reset by the time
> 	 * we get a PMU interrupt
> 	 */
> 	if (from == 0 || to == 0)
> 		return X86_BR_NONE;
> ...
>
> Though in those cases, it doesn't seem like this change would make a difference. I guess it isn't clear to me what issue this change is fixing.

Yes, the "dead code" is not accurate. For hardware decoding (the if case),
the validation is some kind of dead code, but for the software decoding,
it's not. I would adjust the wording in next version. Thanks.


>
> Thanks,
> Tom
>
>>  			cpuc->lbr_entries[i].from = 0;
>>  			compress = true;
>>  		}

