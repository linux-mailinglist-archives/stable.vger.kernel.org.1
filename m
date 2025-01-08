Return-Path: <stable+bounces-107982-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E2CA058B0
	for <lists+stable@lfdr.de>; Wed,  8 Jan 2025 11:52:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B2C93A1A2D
	for <lists+stable@lfdr.de>; Wed,  8 Jan 2025 10:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C4631F7552;
	Wed,  8 Jan 2025 10:52:24 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F8DF1F8666;
	Wed,  8 Jan 2025 10:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736333544; cv=none; b=LmXrgxOjWIf+Hfy2gyxxl7j/qJA3n+IZMKjfPfgNax3yD5Ai9vb8SH52GMiaVGa98w+cbIfvFMHRLDWIEJ88/n4Mgq/MmK1F1uN2SbsNIzue6u7bpt1SS4W6XSNJoVyEYfJF+nQdl4+db30SLUWFHUtit/P0s5lAj15GuVT+6uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736333544; c=relaxed/simple;
	bh=1rNuFu/C8Aw4joDSy0HXIgddIXjS6pDAds8KSGU8VYU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZAjxdF46QhtKWG0jfuo1FxCaEoqMQvbTikhZuSbCmoDfFG2hs65qaU0PRhuOOXV7D1Tn4HqHVo76YP6GYG9/OC2BvAdMxYXxJ4NWySWdp72bxx+5QKULq+HJLIv5htENK6Quix1WIxuywplj0+8DOYptFRfhiL7aA9PNFuSbXZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3275013D5;
	Wed,  8 Jan 2025 02:52:50 -0800 (PST)
Received: from [10.162.16.95] (a077893.blr.arm.com [10.162.16.95])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E67693F66E;
	Wed,  8 Jan 2025 02:52:17 -0800 (PST)
Message-ID: <1c1504a7-3515-48f2-8ca7-15b2379dea22@arm.com>
Date: Wed, 8 Jan 2025 16:22:15 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] arm64: mm: Populate vmemmap/linear at the page level
 for hotplugged sections
To: Zhenhua Huang <quic_zhenhuah@quicinc.com>,
 Catalin Marinas <catalin.marinas@arm.com>
Cc: will@kernel.org, ardb@kernel.org, ryan.roberts@arm.com,
 mark.rutland@arm.com, joey.gouly@arm.com, dave.hansen@linux.intel.com,
 akpm@linux-foundation.org, chenfeiyang@loongson.cn, chenhuacai@kernel.org,
 linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, quic_tingweiz@quicinc.com,
 stable@vger.kernel.org
References: <20250107074252.1062127-1-quic_zhenhuah@quicinc.com>
 <Z31--x4unDHRU5Zo@arm.com> <406d5113-ff3d-4c2a-81f0-de791bcbeffb@quicinc.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <406d5113-ff3d-4c2a-81f0-de791bcbeffb@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 1/8/25 15:37, Zhenhua Huang wrote:
> 
>>
>>>                 /*
>>> @@ -1175,9 +1178,21 @@ int __meminit vmemmap_check_pmd(pmd_t *pmdp, int node,
>>>   int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
>>>           struct vmem_altmap *altmap)
>>>   {
>>> +    unsigned long start_pfn;
>>> +    struct mem_section *ms;
>>> +
>>>       WARN_ON((start < VMEMMAP_START) || (end > VMEMMAP_END));
>>>   -    if (!IS_ENABLED(CONFIG_ARM64_4K_PAGES))
>>> +    start_pfn = page_to_pfn((struct page *)start);
>>> +    ms = __pfn_to_section(start_pfn);
>>
>> Hmm, it would have been better if the core code provided the start pfn
>> as it does for vmemmap_populate_compound_pages() but I'm fine with
>> deducting it from 'start'.
> 
> I found another bug, that even for early section, when vmemmap_populate is called, SECTION_IS_EARLY is not set. Therefore, early_section() always return false.

Hmm, well that's unexpected.

> 
> Since vmemmap_populate() occurs during section initialization, it may be hard to say it is a bug..
> However, should we instead using SECTION_MARKED_PRESENT to check? I tested well in my setup.
> 
> Hot plug flow:
> 1. section_activate -> vmemmap_populate
> 2. mark PRESENT
> 
> In contrast, the early flow:
> 1. memblocks_present -> mark PRESENT
> 2. __populate_section_memmap -> vmemmap_populate

But from a semantics perspective, should SECTION_MARKED_PRESENT be marked on a
section before SECTION_IS_EARLY ? Is it really the expected behaviour here or
that needs to be fixed first ? 

Although SYSTEM_BOOTING state check might help but section flag seems to be the
right thing to do here.

