Return-Path: <stable+bounces-58128-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BD5692852D
	for <lists+stable@lfdr.de>; Fri,  5 Jul 2024 11:35:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 294B428623F
	for <lists+stable@lfdr.de>; Fri,  5 Jul 2024 09:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69EDD146A89;
	Fri,  5 Jul 2024 09:34:50 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96152146018;
	Fri,  5 Jul 2024 09:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720172090; cv=none; b=grYUWa1H3YrUM7P1flSg30EX/e6V+CWQeI54L67CVh9odz8O+qy20UuFSthTpBqpLAjeWMabOmwvPuC1Bp/U2SY8WxGdiYKwS7wj6gGhK5tq/yiDmyXEcf/urqJAYM5QhlBr6o2INi0CrjuodTmdmSfUkwdEqDHmTYHvxgoUI2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720172090; c=relaxed/simple;
	bh=ClpXwmxX/iI8KJIciRRFV8mBW7xSc8xL23a+yxJ4flI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BuP1zJ4pWDmKYwuQ01ypIJ9HFXaE3tM2OTBfF5wiZlyOkiKwdfyZ2saVVNnjfHoHgTRgeOIZwUrpfDd5M79tR5ZBvXZ05Z7GWRAV7J5FhM1R4NOwm7N/sVVoAt3ah5RWl8bNxKsyp9ciw4Naj8ME+KpfoyU2Pdvxpeqbrwy9Drg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1DF55367;
	Fri,  5 Jul 2024 02:35:13 -0700 (PDT)
Received: from [10.57.74.223] (unknown [10.57.74.223])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 569DD3F762;
	Fri,  5 Jul 2024 02:34:45 -0700 (PDT)
Message-ID: <d3b5e990-90c7-4d68-a83e-0e42142439fd@arm.com>
Date: Fri, 5 Jul 2024 10:34:43 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm: Fix khugepaged activation policy
Content-Language: en-GB
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jonathan Corbet <corbet@lwn.net>, David Hildenbrand <david@redhat.com>,
 Barry Song <baohua@kernel.org>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 Lance Yang <ioworker0@gmail.com>, Yang Shi <shy828301@gmail.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20240704091051.2411934-1-ryan.roberts@arm.com>
 <20240704113325.fb9f1b04f99abaac315b5c88@linux-foundation.org>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20240704113325.fb9f1b04f99abaac315b5c88@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04/07/2024 19:33, Andrew Morton wrote:
> On Thu,  4 Jul 2024 10:10:50 +0100 Ryan Roberts <ryan.roberts@arm.com> wrote:
> 
>> Since the introduction of mTHP, the docuementation has stated that
>> khugepaged would be enabled when any mTHP size is enabled, and disabled
>> when all mTHP sizes are disabled. There are 2 problems with this; 1.
>> this is not what was implemented by the code and 2. this is not the
>> desirable behavior.
>>
>> Desirable behavior is for khugepaged to be enabled when any PMD-sized
>> THP is enabled, anon or file. (Note that file THP is still controlled by
>> the top-level control so we must always consider that, as well as the
>> PMD-size mTHP control for anon). khugepaged only supports collapsing to
>> PMD-sized THP so there is no value in enabling it when PMD-sized THP is
>> disabled. So let's change the code and documentation to reflect this
>> policy.
>>
>> Further, per-size enabled control modification events were not
>> previously forwarded to khugepaged to give it an opportunity to start or
>> stop. Consequently the following was resulting in khugepaged eroneously
>> not being activated:
>>
>>   echo never > /sys/kernel/mm/transparent_hugepage/enabled
>>   echo always > /sys/kernel/mm/transparent_hugepage/hugepages-2048kB/enabled
>>
>> ...
>>
>> -static inline bool hugepage_flags_enabled(void)
>> +static inline bool hugepage_pmd_enabled(void)
>>  {
>>  	/*
>> -	 * We cover both the anon and the file-backed case here; we must return
>> -	 * true if globally enabled, even when all anon sizes are set to never.
>> -	 * So we don't need to look at huge_anon_orders_inherit.
>> +	 * We cover both the anon and the file-backed case here; file-backed
>> +	 * hugepages, when configured in, are determined by the global control.
>> +	 * Anon pmd-sized hugepages are determined by the pmd-size control.
>>  	 */
>> -	return hugepage_global_enabled() ||
>> -	       READ_ONCE(huge_anon_orders_always) ||
>> -	       READ_ONCE(huge_anon_orders_madvise);
>> +	return (IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) && hugepage_global_enabled()) ||
>> +	       test_bit(PMD_ORDER, &huge_anon_orders_always) ||
>> +	       test_bit(PMD_ORDER, &huge_anon_orders_madvise) ||
>> +	       (test_bit(PMD_ORDER, &huge_anon_orders_inherit) && hugepage_global_enabled());
>>  }
> 
> That's rather a mouthful.  Is this nicer?

Sure, I'll take your version into v3.

> 
> static inline bool hugepage_pmd_enabled(void)
> {
> 	/*
> 	 * We cover both the anon and the file-backed case here; file-backed
> 	 * hugepages, when configured in, are determined by the global control.
> 	 * Anon pmd-sized hugepages are determined by the pmd-size control.
> 	 */
> 	if (IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) &&
> 			hugepage_global_enabled())
> 		return true;
> 	if (test_bit(PMD_ORDER, &huge_anon_orders_always))
> 		return true;
> 	if (test_bit(PMD_ORDER, &huge_anon_orders_madvise))
> 		return true;
> 	if (test_bit(PMD_ORDER, &huge_anon_orders_inherit) &&
> 			hugepage_global_enabled())
> 		return true;
> 	return false;
> }
> 
> Also, that's a pretty large function to be inlined.  It could be a
> non-inline function static to khugepaged.c.  But I suppose that's a
> separate patch.

Yeah fair point. I'll respin it now as a static in khugepaged.c.



