Return-Path: <stable+bounces-240260-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MArGHQgd6Gm/FAIAu9opvQ
	(envelope-from <stable+bounces-240260-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 02:57:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E9847440F56
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 02:57:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E3BC8302F436
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 00:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 748CC1E5702;
	Wed, 22 Apr 2026 00:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ow712zn0"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE4F1DF26E;
	Wed, 22 Apr 2026 00:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776819449; cv=none; b=I/8LXENhLo857b7Q6ht4IiKbWJi3Kuj9co0igP+aYvPw+KeeP+zGtShFmPpUvM+SSYJr/NsSWkaZ93ubX5iHD4GnEZHhFbf3QUWx1nN41rjnd77RQ2Zlbzib7v/ftrrl4+onDWqrbEagm/DcA5dqCiBVsI9LFflqwEg8KUiEkF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776819449; c=relaxed/simple;
	bh=nhehAw6Z+DPT+nNjSZV2c7dJLnh4W2YjeY8ZBqsswOs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iF4Z9Rth3Lwwa1h0cJMUj8BAGiMsO1BOGyWLfYQ8HBuGmJKjIBwNJeUdb6Lyykyo33H6T6/w4I1sfoi/WQSs5zSxc7y+2Z0pHdt9xlju/Hy+VDBUInnaSEfMPLXWLloYOem8pIJ8J01WYIlhdPN30gMwaBPdVPcZfGpOTXJbWDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ow712zn0; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776819448; x=1808355448;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=nhehAw6Z+DPT+nNjSZV2c7dJLnh4W2YjeY8ZBqsswOs=;
  b=Ow712zn0mgufhCneo08gYIOyrqv4WXbNFHeT6vxcMyLB3PIPZMrRtqAr
   9AdOj4MudeRoI7r/b6qrTww5N9LpCfbvPDK0uqFGZtVTzsL1YRMjX8s5j
   Sytg+3wk+WTvErb7RS0cliUWH2zIhEe1yP++WRUJkF3bNbinfJvgAq12O
   m5+0BSWgt0GZsgB0sVSckRw6wLeP1DGyTNzWiQFp1129P0AnpiO+DGHi6
   k4xz6CPHVKoer8dtvp1+S9k3R7NG1AYAr1cxlPlJjXrsU9XqrCh9PlzK8
   B16V9fpFleZKjZfFNtjUSMuDXRhEidJl7x34rpsfqs+0DF04aNpBFa2jc
   w==;
X-CSE-ConnectionGUID: qiPHIe0DTLCrCNFeqtYPxA==
X-CSE-MsgGUID: 0oNrcRYURmiRR+55gWYPlQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11763"; a="77835357"
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="77835357"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2026 17:57:27 -0700
X-CSE-ConnectionGUID: u7N3OE2PTwK/DKD5a6g9kw==
X-CSE-MsgGUID: qniPAnqBRme7nBL9zTBu6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="255673856"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.147]) ([10.124.241.147])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2026 17:57:23 -0700
Message-ID: <e25134c3-87c8-4c2e-b9f6-d6222bfaa5eb@linux.intel.com>
Date: Wed, 22 Apr 2026 08:57:20 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v2 1/4] perf/x86/intel: Clear stale ACR mask before
 updating new mask
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
 <20260420024528.2130065-2-dapeng1.mi@linux.intel.com>
 <aef6XiN8TTWdIAiK@tassilo>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <aef6XiN8TTWdIAiK@tassilo>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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
	TAGGED_FROM(0.00)[bounces-240260-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,linux.intel.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E9847440F56
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 4/22/2026 6:29 AM, Andi Kleen wrote:
>> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
>> index 4768236c054b..774ae9a4eeaf 100644
>> --- a/arch/x86/events/intel/core.c
>> +++ b/arch/x86/events/intel/core.c
>> @@ -3334,6 +3334,12 @@ static void intel_pmu_acr_late_setup(struct cpu_hw_events *cpuc)
>>  	struct perf_event *event, *leader;
>>  	int i, j, idx;
>>  
>> +	/* Clear stale ACR mask first. */
>> +	for (i = 0; i < cpuc->n_events; i++) {
>> +		event = cpuc->event_list[i];
>> +		event->hw.config1 = 0;
>> +	}
> Are you sure nothing else could be using config1?
>
> In principle ACR events can be used with some config1 setting.

Yes, the field "hw.config1" is introduced for support auto counter reload,
it's only used to store the ACR counter indices. Thanks.

https://lore.kernel.org/all/20250327195217.2683619-6-kan.liang@linux.intel.com/


>
>
> -Andi

