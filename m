Return-Path: <stable+bounces-110923-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4086A2028F
	for <lists+stable@lfdr.de>; Tue, 28 Jan 2025 01:28:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CB3E16477C
	for <lists+stable@lfdr.de>; Tue, 28 Jan 2025 00:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 934164A1A;
	Tue, 28 Jan 2025 00:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LlBD5oYb"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A757516415;
	Tue, 28 Jan 2025 00:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738024127; cv=none; b=E9vfe95H9D1u4z0knMxltHmZAuMtsEbU8cJVr48LskT60/2Jj+APKBp8pBvKkn1/6mL7X64ivDLglysjBZM9baHmFsXqy7Ppb3SaVjkK70rk4vooD3V2/Dynz+/maYh1oyNJ+NdRlJDLYA2sM+3gCOXOe3ZSvbHsT+Kub20PR8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738024127; c=relaxed/simple;
	bh=lRQCBu7CY8tPcCZTDPclXD0AtVkECEQvUNU8JxSxbVQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CcdGUnHT8+wZ6nRrqZr3+5r8CT7rj+JNThGD7JJXZN83Sem9ow25rrFuL8Oj77M7y0xEFFUcB4wP91Ak3pUbvEH0f5QHd9ldhIV9tY4s4S9U4WzbjEQ/u7Rt5UI8ji4gZZn95O7cY3MgmlnS2pbSCSxQdnJlhCri+F+QBO9BuzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LlBD5oYb; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738024126; x=1769560126;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=lRQCBu7CY8tPcCZTDPclXD0AtVkECEQvUNU8JxSxbVQ=;
  b=LlBD5oYb131nSVkOOL8IZkvwl4kwB4YR+1kUFSjIGtFpXITagcKjFE7d
   MM1WHw0toT75Y9nBrYjCRQRBNW5+OUWdPzQef0ln+26+wP7DV3la4/xrh
   kdYOnehlp/rS1Vx7tSFVyY7/TBnRrVLL4Yyb9LKda8ZuNGDUxe0P0QRW/
   U2Lrk/vM3kClUllOvc60l3aMlWUQ0sbGTIDmmtI7cb+9TwdL/VPQ9xiwN
   eJmGMlEeq3CXNJtkOaRefHew4KluNpRuE45G+znhsf8Ze7MmuthOFAOxU
   j/knjWf6KRdA2Cwkb7P14nWTXYxwIaMNKAEC18Nq8W6z4RcTajfZNhEWu
   Q==;
X-CSE-ConnectionGUID: EaVBiYLWQcq4zmY1nbtl4w==
X-CSE-MsgGUID: /N+ugYWnTRe1AQtV5H9ooA==
X-IronPort-AV: E=McAfee;i="6700,10204,11328"; a="49096667"
X-IronPort-AV: E=Sophos;i="6.13,239,1732608000"; 
   d="scan'208";a="49096667"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2025 16:28:44 -0800
X-CSE-ConnectionGUID: zWZR48ZRRoK9A2TolSCx+Q==
X-CSE-MsgGUID: uUuwgUKBRR2o3r9CmwEvBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,239,1732608000"; 
   d="scan'208";a="113596602"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2025 16:28:43 -0800
Received: from [10.246.136.10] (kliang2-mobl1.ccr.corp.intel.com [10.246.136.10])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 1016820B5713;
	Mon, 27 Jan 2025 16:28:41 -0800 (PST)
Message-ID: <1d9209e0-52a0-4b26-a0a4-dcceff4c4acc@linux.intel.com>
Date: Mon, 27 Jan 2025 19:28:40 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/20] perf/x86/intel: Fix ARCH_PERFMON_NUM_COUNTER_LEAF
To: Peter Zijlstra <peterz@infradead.org>
Cc: Dapeng Mi <dapeng1.mi@linux.intel.com>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Dapeng Mi <dapeng1.mi@intel.com>, stable@vger.kernel.org
References: <20250123140721.2496639-1-dapeng1.mi@linux.intel.com>
 <20250123140721.2496639-3-dapeng1.mi@linux.intel.com>
 <20250127162917.GM16742@noisy.programming.kicks-ass.net>
 <6d5c45b4-53ad-403f-9de3-a25b80a44e0e@linux.intel.com>
 <20250127212901.GB9557@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20250127212901.GB9557@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2025-01-27 4:29 p.m., Peter Zijlstra wrote:
> On Mon, Jan 27, 2025 at 11:43:53AM -0500, Liang, Kan wrote:
> 
>> But they are used for a 64-bit register.
>> The ARCH_PERFMON_NUM_COUNTER_LEAF is for the CPUID enumeration, which is
>> a u32.
> 
> A well, but CPUID should be using unions, no?
> 
> we have cpuid10_e[abd]x cpuid28_e[abc]x, so wheres cpuid23_e?x at?
> 

Sure, I will add a cpuid23_e?x to make them consistent.

Thanks,
Kan

