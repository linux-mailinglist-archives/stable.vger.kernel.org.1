Return-Path: <stable+bounces-48306-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 836E28FE81A
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 15:44:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE6E2B24566
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 13:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EADF1850B6;
	Thu,  6 Jun 2024 13:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eFAnytJw"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C5419642D;
	Thu,  6 Jun 2024 13:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717681482; cv=none; b=QexpgPx3vB0iOHA4oZZfv7dwZn+aFLbqv7+XJP6WSCkvSn0vI2PMlX6UGlQn7zfIn0ZV3lirzTbU6sAVazp7zj8A61yMjyYcS+TvY+5ZMnmPO0yMSPuB9opJchTGztrt6dxKw3jOr5pYwgZJB6zHCy3ss2xy8XyKMxIG/0/z+zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717681482; c=relaxed/simple;
	bh=lq7yE7QHdLhqmzRBDqpM7MNtwj4dP5zB26YYW2zA/rQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M7uU4wXHwRt2xFBMX5vmux1tjpj3fVh0vfTQFdDeC3bk5GRvvEbq7KHj882IOGFgjx7xZ4o7fEjrrL5ol3/huEf25lCEWmdkOMs5zbl3956+lPJc/hNua2u6/HfFdSymyoMMy5hOIYyPyYiQJLGPoO9GzpRUYpxhEf/y0VbkJxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eFAnytJw; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717681480; x=1749217480;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=lq7yE7QHdLhqmzRBDqpM7MNtwj4dP5zB26YYW2zA/rQ=;
  b=eFAnytJwViFYBS6xqugBZZ4NW7ce1E3xJSkT2nAEH/Pv58fSQspngDAy
   ek1DnWXbCGv8T9xtciJD2uQUlNuA6WFtZ03u03Br18BX0GXAvP/eJETT/
   Spa4soie6t57+Pg0F5LslA5WQ9gPkiyKtig2+FHfTi8XqQvFyW6IXJ0N0
   U31MlIAHxW9m86mqdyEJXNDG+EH0mPcrMOGjY8/mDxiu14ebla5y0L6v/
   jeHwXlXan/ZQo9AUWbxY4WoWgMRJ7aZpueAvKu7+3PEC38KtyrgAld/zD
   NC9B4/10iRxszpB7JIAI490nUEl1zDS7wWYu071624ErYt9z+5Z6IdvXc
   A==;
X-CSE-ConnectionGUID: coc32HTHQqKI2I1e4Zq/ww==
X-CSE-MsgGUID: UHgnPOujRTWlHPQ8+OPt2Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11095"; a="25004528"
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="25004528"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2024 06:44:39 -0700
X-CSE-ConnectionGUID: GLottgdCSheTmgjT8VIBnA==
X-CSE-MsgGUID: AtEl53KdR3WXtdiwM29u/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="37977429"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2024 06:44:39 -0700
Received: from [10.212.72.92] (kliang2-mobl1.ccr.corp.intel.com [10.212.72.92])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id AEF5F20B5703;
	Thu,  6 Jun 2024 06:44:37 -0700 (PDT)
Message-ID: <31ec235a-70f6-435b-b99b-5d59f4989ba6@linux.intel.com>
Date: Thu, 6 Jun 2024 09:44:36 -0400
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf stat: Fix the hard-coded metrics calculation on the
 hybrid
To: Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>
Cc: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 "Khalil, Amiri" <amiri.khalil@intel.com>, stable@vger.kernel.org
References: <20240605160848.4116061-1-kan.liang@linux.intel.com>
 <CAP-5=fV+-ytA2st17Ar-jQ5xYqrWtxnF2TcADKrC5WoPyKz4wQ@mail.gmail.com>
 <CAM9d7cjuHYDMvcq10ZD=3LSmia4WcvAzsme89B-odHYBAZzWYg@mail.gmail.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <CAM9d7cjuHYDMvcq10ZD=3LSmia4WcvAzsme89B-odHYBAZzWYg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2024-06-06 3:34 a.m., Namhyung Kim wrote:
> On Wed, Jun 5, 2024 at 10:21 AM Ian Rogers <irogers@google.com> wrote:
>>
>> On Wed, Jun 5, 2024 at 9:10 AM <kan.liang@linux.intel.com> wrote:
>>>
>>> From: Kan Liang <kan.liang@linux.intel.com>
>>>
>>> The hard-coded metrics is wrongly calculated on the hybrid machine.
>>>
>>> $ perf stat -e cycles,instructions -a sleep 1
>>>
>>>  Performance counter stats for 'system wide':
>>>
>>>         18,205,487      cpu_atom/cycles/
>>>          9,733,603      cpu_core/cycles/
>>>          9,423,111      cpu_atom/instructions/     #  0.52  insn per cycle
>>>          4,268,965      cpu_core/instructions/     #  0.23  insn per cycle
>>>
>>> The insn per cycle for cpu_core should be 4,268,965 / 9,733,603 = 0.44.
>>>
>>> When finding the metric events, the find_stat() doesn't take the PMU
>>> type into account. The cpu_atom/cycles/ is wrongly used to calculate
>>> the IPC of the cpu_core.
>>>
>>> Fixes: 0a57b910807a ("perf stat: Use counts rather than saved_value")
>>> Reported-by: "Khalil, Amiri" <amiri.khalil@intel.com>
>>> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
>>
>> Reviewed-by: Ian Rogers <irogers@google.com>
>>
>> Thanks,
>> Ian
>>
>>> Cc: stable@vger.kernel.org
>>> ---
>>>  tools/perf/util/stat-shadow.c | 4 ++++
>>>  1 file changed, 4 insertions(+)
>>>
>>> diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
>>> index 3466aa952442..4d0edc061f1a 100644
>>> --- a/tools/perf/util/stat-shadow.c
>>> +++ b/tools/perf/util/stat-shadow.c
>>> @@ -176,6 +176,10 @@ static double find_stat(const struct evsel *evsel, int aggr_idx, enum stat_type
>>>                 if (type != evsel__stat_type(cur))
>>>                         continue;
>>>
>>> +               /* Ignore if not the PMU we're looking for. */
>>> +               if (evsel->pmu != cur->pmu)
>>> +                       continue;
> 
> Hmm.. Don't some metrics need events from different PMU?
> Like cycles per sec or branch instructions per sec..
>

Right.

In the hard-coded metrics, the events from a different PMU are
SW_CPU_CLOCK and SW_TASK_CLOCK. They both have the stat type,
STAT_NSECS. Perf should ignore the PMU checking for the type as below.
I will send a V2 to fix it.

diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index 3466aa952442..d01335f18808 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -176,6 +176,9 @@ static double find_stat(const struct evsel *evsel,
int aggr_idx, enum stat_type
		if (type != evsel__stat_type(cur))
			continue;

+		if ((type != STAT_NSECS) && (evsel->pmu != cur->pmu))
+			continue;
+
		aggr = &cur->stats->aggr[aggr_idx];
		if (type == STAT_NSECS)
			return aggr->counts.val;


Thanks,
Kan

> Thanks,
> Namhyung
> 
> 
>>> +
>>>                 aggr = &cur->stats->aggr[aggr_idx];
>>>                 if (type == STAT_NSECS)
>>>                         return aggr->counts.val;
>>> --
>>> 2.35.1
>>>
> 

