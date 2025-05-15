Return-Path: <stable+bounces-144492-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C333AAB8113
	for <lists+stable@lfdr.de>; Thu, 15 May 2025 10:43:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D02141BC245F
	for <lists+stable@lfdr.de>; Thu, 15 May 2025 08:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A23B285419;
	Thu, 15 May 2025 08:40:17 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 480161A23A0;
	Thu, 15 May 2025 08:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747298417; cv=none; b=rvFYKqjzGFmjRF4ZVhjNkyrr3jn3Od8O4h/6vtOn6TFF0LeBhi+iPSTQueLbWBmVG9sjEq6V9NVoU9Pj6HSz1ucur9x3QAW+w3kV4/9XBDhwwMgTcauzpvvKQviWfdXxjT8GfNrcQhD2fZPHH7TYUFnqaeM10/u3RbbPVVBbnYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747298417; c=relaxed/simple;
	bh=iGPLC7alKVMRN6/e5ZztVooLrAljgiLXr6wjYMcHwTg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jhFB1/L0+MIrRZT88s/n6/fXPh+L1HAT2seQynBNVeJtG6vbgXAZOPLDKIXcGL3o3YrQE99YwI397PajzAIbyfjcfStpOk0SMa5BGvloK+LscJES+bF7AScmpr4LOwbWmMXhF9Tma9akDziSiv8OqmM3zpPM2O54Wkm1+qWguB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C79D014BF;
	Thu, 15 May 2025 01:40:01 -0700 (PDT)
Received: from [10.162.40.26] (K4MQJ0H1H2.blr.arm.com [10.162.40.26])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2E50B3F673;
	Thu, 15 May 2025 01:40:09 -0700 (PDT)
Message-ID: <73a67d06-b497-40a2-8cb2-3b80c6ba59d1@arm.com>
Date: Thu, 15 May 2025 14:10:07 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: Check pxd_leaf() instead of !pxd_table() while
 tearing down page tables
To: David Hildenbrand <david@redhat.com>, catalin.marinas@arm.com,
 will@kernel.org
Cc: ryan.roberts@arm.com, anshuman.khandual@arm.com, mark.rutland@arm.com,
 yang@os.amperecomputing.com, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
References: <20250515063450.86629-1-dev.jain@arm.com>
 <332ecda7-14c4-4dc3-aeff-26801b74ca04@redhat.com>
 <4904d02f-6595-4230-a321-23327596e085@arm.com>
 <6fe7848c-485e-4639-b65c-200ed6abe119@redhat.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <6fe7848c-485e-4639-b65c-200ed6abe119@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 15/05/25 2:06 pm, David Hildenbrand wrote:
> On 15.05.25 10:22, Dev Jain wrote:
>>
>>
>> On 15/05/25 1:43 pm, David Hildenbrand wrote:
>>> On 15.05.25 08:34, Dev Jain wrote:
>>>> Commit 9c006972c3fe removes the pxd_present() checks because the caller
>>>> checks pxd_present(). But, in case of vmap_try_huge_pud(), the caller
>>>> only
>>>> checks pud_present(); pud_free_pmd_page() recurses on each pmd through
>>>> pmd_free_pte_page(), wherein the pmd may be none.
>>> The commit states: "The core code already has a check for pXd_none()",
>>> so I assume that assumption was not true in all cases?
>>>
>>> Should that one problematic caller then check for pmd_none() instead?
>>
>>   From what I could gather of Will's commit message, my interpretation is
>> that the concerned callers are vmap_try_huge_pud and vmap_try_huge_pmd.
>> These individually check for pxd_present():
>>
>> if (pmd_present(*pmd) && !pmd_free_pte_page(pmd, addr))
>>     return 0;
>>
>> The problem is that vmap_try_huge_pud will also iterate on pte entries.
>> So if the pud is present, then pud_free_pmd_page -> pmd_free_pte_page
>> may encounter a none pmd and trigger a WARN.
> 
> Yeah, pud_free_pmd_page()->pmd_free_pte_page() looks shaky.
> 
> I assume we should either have an explicit pmd_none() check in 
> pud_free_pmd_page() before calling pmd_free_pte_page(), or one in 
> pmd_free_pte_page().
> 
> With your patch, we'd be calling pte_free_kernel() on a NULL pointer, 
> which sounds wrong -- unless I am missing something important.
> 
>>
>>>
>>> If you were able to trigger this WARN, it's always a good idea to
>>> include the splat in the commit.
>>
>> I wasn't able to, it is just an observation from code inspection.
> 
> That better be included in the patch description :)

I did, actually. My bad for not putting in spaces, I notice now that the 
description looks horrible to the eye :)

> 


