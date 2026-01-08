Return-Path: <stable+bounces-206264-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 899BFD040F3
	for <lists+stable@lfdr.de>; Thu, 08 Jan 2026 16:54:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B09A83068F58
	for <lists+stable@lfdr.de>; Thu,  8 Jan 2026 15:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA873369975;
	Thu,  8 Jan 2026 07:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SEBObw/h"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58FA1366DD9;
	Thu,  8 Jan 2026 07:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767858212; cv=none; b=o8hIOgZvkcMQi5Otj+uo/Go8LDPWv/2t1GgwTAMV0fUVOm2GVtCNgaXq3EexPzQKxScG1F4/iicKIlE5pRwClg5OLDYgrr2FxJ5vHmvdcxdb9g3FVxPnp7e0gCgiNqQZNR/8a2hydSZKbgoQvuJRyvWmOhCSGatypUN17kP1Yjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767858212; c=relaxed/simple;
	bh=Fe1SfEGvcGfbfIoKKQ09NHTBe71uIN7abXQxmfUOnHk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P3fHLaI723oVtDDUprS7kv0MBooUAqSWJZ9XxNZRC1OpSOJ3yDvbgWVlnNOuAe8Pcc0kcMO2OO7cJqE5u1Vc9+VEQ2Hj1K1yTzknWbmgGAhwGBzUS2Fl9lJ27A0COz9zhBt6/5v9FoNvZAbV2sgOYW+kTIIF+5FsjVLfQKe+pZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SEBObw/h; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767858201; x=1799394201;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Fe1SfEGvcGfbfIoKKQ09NHTBe71uIN7abXQxmfUOnHk=;
  b=SEBObw/hQexvttmx5qRT3/hB6awoQj+Bg8brpVc74h8wf1gUv1BFirO6
   cjIR7GsX07o1o4wS/82uzLwonhBpgUJAwSldCj/lgo49EwYs73dqIdnTw
   Ql/wIHgV3mOecF623kJxPq1sLspiWzt4BgEwry70t1PzslzCqMNHigIUw
   H3P0/7MEXOnj6kp9SJCuTYs6RJLCvpLf9pqI3YI26pqhOn1m5A1JvIzXO
   akxMOWhShIbUajY48hzk9p09TvSHOyxouK28QiTmxC+OSsYZlUOfM+BbH
   droy2gpPZGAKVu8i1ds3xAe7vWEzkO+UwIIc3L+3c4pN8DefdYXeBLVCu
   A==;
X-CSE-ConnectionGUID: ZReEbrl9RuiJYccACizvdQ==
X-CSE-MsgGUID: V+n2jcbKS0ud9fupGkD+uw==
X-IronPort-AV: E=McAfee;i="6800,10657,11664"; a="80594471"
X-IronPort-AV: E=Sophos;i="6.21,210,1763452800"; 
   d="scan'208";a="80594471"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2026 23:43:11 -0800
X-CSE-ConnectionGUID: p6WLCRF3R6+P08HC0d2uWw==
X-CSE-MsgGUID: cjT6wEkRQtOqzYJXcuPrIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,210,1763452800"; 
   d="scan'208";a="208201933"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.240.14]) ([10.124.240.14])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2026 23:43:08 -0800
Message-ID: <c812f99a-499e-4add-bd36-3cabbfb8f49f@linux.intel.com>
Date: Thu, 8 Jan 2026 15:43:05 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf Documentation: Correct branch stack sampling
 call-stack option
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 Zide Chen <zide.chen@intel.com>, Falcon Thomas <thomas.falcon@intel.com>,
 Dapeng Mi <dapeng1.mi@intel.com>, Xudong Hao <xudong.hao@intel.com>,
 stable@vger.kernel.org
References: <20251216013949.1557008-1-dapeng1.mi@linux.intel.com>
 <e2a105fc-8b5c-4c7d-ba29-de8bb560cc85@linux.intel.com>
 <aV9LVqqrhfW6DfbQ@google.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <aV9LVqqrhfW6DfbQ@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 1/8/2026 2:14 PM, Namhyung Kim wrote:
> Hello,
>
> On Wed, Jan 07, 2026 at 08:58:53AM +0800, Mi, Dapeng wrote:
>> @Arnaldo, @Kim, @Ian
>>
>> Kindly ping ... 
> Sorry for the delay.
>
>> On 12/16/2025 9:39 AM, Dapeng Mi wrote:
>>> The correct call-stack option for branch stack sampling should be "stack"
>>> instead of "call_stack". Correct it.
>>>
>>> $perf record -e instructions -j call_stack -- sleep 1
>>> unknown branch filter call_stack, check man page
>>>
>>>  Usage: perf record [<options>] [<command>]
>>>     or: perf record [<options>] -- <command> [<options>]
>>>
>>>     -j, --branch-filter <branch filter mask>
>>>                           branch stack filter modes
>>>
>>> Cc: stable@vger.kernel.org
>>> Fixes: 955f6def5590 ("perf record: Add remaining branch filters: "no_cycles", "no_flags" & "hw_index"")
>>> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Reviewed-by: Namhyung Kim <namhyung@kernel.org>

Thanks a lot. :)


>
> Thanks,
> Namhyung
>
>>> ---
>>>  tools/perf/Documentation/perf-record.txt | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
>>> index e8b9aadbbfa5..3d19e77c9c53 100644
>>> --- a/tools/perf/Documentation/perf-record.txt
>>> +++ b/tools/perf/Documentation/perf-record.txt
>>> @@ -454,7 +454,7 @@ following filters are defined:
>>>  	- no_tx: only when the target is not in a hardware transaction
>>>  	- abort_tx: only when the target is a hardware transaction abort
>>>  	- cond: conditional branches
>>> -	- call_stack: save call stack
>>> +	- stack: save call stack
>>>  	- no_flags: don't save branch flags e.g prediction, misprediction etc
>>>  	- no_cycles: don't save branch cycles
>>>  	- hw_index: save branch hardware index
>>>
>>> base-commit: cb015814f8b6eebcbb8e46e111d108892c5e6821

