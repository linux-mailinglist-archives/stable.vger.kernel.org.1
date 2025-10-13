Return-Path: <stable+bounces-184207-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3861FBD2927
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 12:28:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 957241896769
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 10:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5715B2FF169;
	Mon, 13 Oct 2025 10:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d1W0UT4W"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB9915E5BB;
	Mon, 13 Oct 2025 10:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760351286; cv=none; b=GjrO7LlNZgOTziv9Ud9CMOPke2IYHJcacsLrHxt8qRqPX79p7uR0M9EaLtaQQ7C+Uc3UNsxgMUfykMV+6kbN/Znl2nL39jmG59rnv8DAy90FNiDpM+hSK9CSDiD46JWVznUuxkCafHGuGC6mB/uYkktAKYJg8ljDyn4pyTtJUBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760351286; c=relaxed/simple;
	bh=s0w3JaZHDtFhUxNRTBxHh5RglvYahX/gtsSUHvYN60s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p9b41J0vbK3AxeJTDPcViOS7AzCg3U1RBGBBOboYxGEKx9hNCIjiCtBXIoVuFA0B7O0W3fCBROXuIY6DENbGy9pkO7ntCSYGBMEfBXyJiQdFK9qd41c9notE96hBTsL2fB6IDBeNQ+gvSxVmXz1EqS/NkqVChpM1hhXNtFNYQr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d1W0UT4W; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760351284; x=1791887284;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=s0w3JaZHDtFhUxNRTBxHh5RglvYahX/gtsSUHvYN60s=;
  b=d1W0UT4WA/0ESYkO/0NoEwgMGnM1iJ3mzyeePytCH107nR9Ffk5r11aZ
   39F7PMYpIyKYVcDKE+iidpQYj74SGOVBwxOiQZp/fVOqTYcV4m9xVWKda
   VfOWgiigeK9HAT9Ugz0a8CugI/8ke24emR9ZUA12aF4wMjPTNS6VbNRvZ
   FhEGwsUcyJUSTkI4hkAUB0ET527OVL4uh/41OGyrm556ugZCMlfB6kprr
   cFHdsmCYZRXgG1njDFXsg3oq5/Ih38iVo2VleUC6su1ktED6eDTxpz1EJ
   vdCS1kbaWbnkC8aNaQUCxe2cbQvzo0LLG/jrpWNJJ9bENbM/7ltYXyTYA
   A==;
X-CSE-ConnectionGUID: 03BksFiiS4atwkOhXkv76A==
X-CSE-MsgGUID: 5RJ/ikreRB2Z2Jrc3hDh1g==
X-IronPort-AV: E=McAfee;i="6800,10657,11580"; a="72744233"
X-IronPort-AV: E=Sophos;i="6.19,225,1754982000"; 
   d="scan'208";a="72744233"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2025 03:28:03 -0700
X-CSE-ConnectionGUID: CPI72lI4SLeQZnyRPzy0YQ==
X-CSE-MsgGUID: /Zw2L53iSvO4+aRDFz7FQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,225,1754982000"; 
   d="scan'208";a="186855631"
Received: from unknown (HELO [10.238.2.75]) ([10.238.2.75])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2025 03:28:00 -0700
Message-ID: <c8c40795-a459-4218-ba78-24f057c53a51@linux.intel.com>
Date: Mon, 13 Oct 2025 18:27:58 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf tools: Fix bool return value in gzip_is_compressed()
To: Namhyung Kim <namhyung@kernel.org>
Cc: Miaoqian Lin <linmq006@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20250828104652.53724-1-linmq006@gmail.com>
 <4ecf3e76-27f8-47fd-a07d-7da2489af55f@linux.intel.com>
 <aOzDh4yhR5F0nMTG@google.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <aOzDh4yhR5F0nMTG@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 10/13/2025 5:16 PM, Namhyung Kim wrote:
> Hello,
>
> On Sat, Oct 11, 2025 at 11:48:56AM +0800, Mi, Dapeng wrote:
>> On 8/28/2025 6:46 PM, Miaoqian Lin wrote:
>>> gzip_is_compressed() returns -1 on error but is declared as bool.
>>> And -1 gets converted to true, which could be misleading.
>>> Return false instead to match the declared type.
>>>
>>> Fixes: 88c74dc76a30 ("perf tools: Add gzip_is_compressed function")
>>> Cc: <stable@vger.kernel.org>
>>> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
>>> ---
>>>  tools/perf/util/zlib.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/tools/perf/util/zlib.c b/tools/perf/util/zlib.c
>>> index 78d2297c1b67..1f7c06523059 100644
>>> --- a/tools/perf/util/zlib.c
>>> +++ b/tools/perf/util/zlib.c
>>> @@ -88,7 +88,7 @@ bool gzip_is_compressed(const char *input)
>>>  	ssize_t rc;
>>>  
>>>  	if (fd < 0)
>>> -		return -1;
>>> +		return false;
>>>  
>>>  	rc = read(fd, buf, sizeof(buf));
>>>  	close(fd);
>> Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> We have 43fa1141e2c1af79 ("perf util: Fix compression checks returning -1
> as bool").

Good to know this has been fixed. Thanks. :)


>
> Thanks,
> Namhyung
>

