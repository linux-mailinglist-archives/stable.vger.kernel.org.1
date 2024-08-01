Return-Path: <stable+bounces-65257-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D89E945074
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 18:25:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 313531C23EA8
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 16:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD63E13C3D5;
	Thu,  1 Aug 2024 16:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fuj8ElKg"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF84C139CEE
	for <stable@vger.kernel.org>; Thu,  1 Aug 2024 16:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722529500; cv=none; b=PzJXpDOHQurWDmID5ij5b0nBWdLdjuV0lMsYUD4fSpH9NGoXI6FWHihUYNpzmdkuwcyjNZB0AWzELASuzADcKfRFS6eThVPmIna7wNmloeKDeTh3XngVAbi0dg6ZlXNGF5NP7+6Ad7ed1N/uIHkS8Cg6R8f5mqub4u/+zy4EELE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722529500; c=relaxed/simple;
	bh=2ELs703CL/0NY9BPIdHEydpSa7yuGw+agEEZ+mFR5JA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PYFYF7y1vbs3bI8iaICYettaxIu5QB5tmERxLAlzukOozZRmmXPIWtjlKH7wOqHAwieROmtXm/Kk8vDW3DFCGrd1H778c+ZU7HjlvGKmcp8ke+A1R5VDkQxSdrOfmMDMYFUtAsRiC3es/7QRm/lsh1ShqvJNWUxkz4DN46gap5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fuj8ElKg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722529497;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=XFJbBcXlBHpS4nW4qWAr2psaRpKUFfF+QCupervOmU0=;
	b=Fuj8ElKgWcbG+Bovqo5LJOscz1yANnRaXncyz5aTnoslRTJfbWdFcBCN73n3NXbwtLIkJa
	+6ZK3lW2LsDtwBpynItJqalGxjNilvKKP5rnRV7gD7J7s4wdpWR0ERf88k/1CExlpunrNu
	s3zcRzKZ3KL2jXov+eb0hTLCYuBtwwQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-9qBU16LDNLKAk-FQzQwhMQ-1; Thu, 01 Aug 2024 12:24:56 -0400
X-MC-Unique: 9qBU16LDNLKAk-FQzQwhMQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-42816aacabcso43148495e9.1
        for <stable@vger.kernel.org>; Thu, 01 Aug 2024 09:24:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722529495; x=1723134295;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XFJbBcXlBHpS4nW4qWAr2psaRpKUFfF+QCupervOmU0=;
        b=iANGniGXdj5KswdJpDY4RgBzXulqZ/BkrOSAudi/QBsn8gWoOZkG/4y/CCv3HqPHwo
         IiDWGLcpjNUXniR/QHbDbI0ZBr+BW6OEsE87iyP6Rs7Fl/YXyiCAfAEiQj2IPV6WHcmJ
         aXhoOW3Jk00jrf8DnkBx+Zser89YYD2iVUREvbAUXunV0oC9u4XSVLhFwH3WJamK/UCR
         3A8lU+qoRS5VaLvE+UguJdvqZaS57/L/MCP8WiovbKOWvmx+u+G/mJbtCQ4QUy5UXxgq
         btSMFqNmF6IUA+xHlhkgjGBVimTPkJ6sE1EhElEj0Vuk60GYW0pRJtJDTu2vclooTrAl
         LgMA==
X-Forwarded-Encrypted: i=1; AJvYcCUWcxjfdneHZvK/+EjVjKwuXOMM7cNcOrlEKriwbTGTjpefd/4LlqqJr+kv/9yN7gtHm2nieoTrueV4pr7UtpYKyOC/Ybqj
X-Gm-Message-State: AOJu0YzuFfaSZ1lIy9O4JAH0ekybILvIGPY9QpA3xwBFM398vCzAeyc4
	dlyDHmrJCY2eJyDyTOfBWREp3wD97PpkDZaQ4IK9VsYIh/BI/9wMn85lM9WXQtaejnZrLunicpW
	MmeNRjsndlNlUxdABC6QAoToKOVKRchZ/QrLUCH5ziITnL5dfPE75Ew==
X-Received: by 2002:a05:600c:1d04:b0:426:6353:4b7c with SMTP id 5b1f17b1804b1-428e6ae0069mr3474335e9.8.1722529495461;
        Thu, 01 Aug 2024 09:24:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGcBHQ5w690BMvZwXjhN/NXKdFYYgT0IoingmGcp8yVg7PSZ5XdC4JQa4Zt6D00jN47WvkTzg==
X-Received: by 2002:a05:600c:1d04:b0:426:6353:4b7c with SMTP id 5b1f17b1804b1-428e6ae0069mr3474105e9.8.1722529494961;
        Thu, 01 Aug 2024 09:24:54 -0700 (PDT)
Received: from [192.168.3.141] (p4ff235e4.dip0.t-ipconnect.de. [79.242.53.228])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-428e6e0357asm2331665e9.12.2024.08.01.09.24.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Aug 2024 09:24:54 -0700 (PDT)
Message-ID: <8cc5b94c-f861-4ca1-b339-704140ad9255@redhat.com>
Date: Thu, 1 Aug 2024 18:24:53 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] mm/hugetlb: fix hugetlb vs. core-mm PT locking
To: Peter Xu <peterx@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 James Houghton <jthoughton@google.com>, stable@vger.kernel.org,
 Oscar Salvador <osalvador@suse.de>, Muchun Song <muchun.song@linux.dev>,
 Baolin Wang <baolin.wang@linux.alibaba.com>
References: <20240731122103.382509-1-david@redhat.com>
 <541f6c23-77ad-4d46-a8ed-fb18c9b635b3@redhat.com> <ZquTHvK0Rc0xBA4y@x1n>
 <934885c5-512b-41bf-8501-b568ece34e18@redhat.com> <ZquyrTTUgvFF65ov@x1n>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <ZquyrTTUgvFF65ov@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01.08.24 18:07, Peter Xu wrote:
> On Thu, Aug 01, 2024 at 05:35:20PM +0200, David Hildenbrand wrote:
>> Hi Peter,
> 
> [...]
> 
>>>> +	else if (size >= PUD_SIZE)
>>>> +		return pud_lockptr(mm, (pud_t *) pte);
>>>> +	else if (size >= PMD_SIZE || IS_ENABLED(CONFIG_HIGHPTE))
>>>
>>> I thought this HIGHPTE can also be dropped? Because in HIGHPTE it should
>>> never have lower-than-PMD huge pages or we're in trouble.  That's why I
>>> kept one WARN_ON() in my pesudo code but only before trying to take the pte
>>> lockptr.
>>
>> Then the compiler won't optimize out the ptep_lockptr() call and we'll run
>> into a build error. And I think the HIGHPTE builderror serves good purpose.
>>
>> In file included from <command-line>:
>> In function 'ptep_lockptr',
>>      inlined from 'huge_pte_lockptr' at ./include/linux/hugetlb.h:974:9,
>>      inlined from 'huge_pte_lock' at ./include/linux/hugetlb.h:1248:8,
>>      inlined from 'pagemap_scan_hugetlb_entry' at fs/proc/task_mmu.c:2581:8:
>> ././include/linux/compiler_types.h:510:45: error: call to '__compiletime_assert_256' declared with attribute error: BUILD_BUG_ON failed: IS_ENABLED(CONFIG_HIGHPTE)
>>    510 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>>        |                                             ^
>> ././include/linux/compiler_types.h:491:25: note: in definition of macro '__compiletime_assert'
>>    491 |                         prefix ## suffix();                             \
>>        |                         ^~~~~~
>> ././include/linux/compiler_types.h:510:9: note: in expansion of macro '_compiletime_assert'
>>    510 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>>        |         ^~~~~~~~~~~~~~~~~~~
>> ./include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
>>     39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
>>        |                                     ^~~~~~~~~~~~~~~~~~
>> ./include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
>>     50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
>>        |         ^~~~~~~~~~~~~~~~
>> ./include/linux/mm.h:2874:9: note: in expansion of macro 'BUILD_BUG_ON'
>>   2874 |         BUILD_BUG_ON(IS_ENABLED(CONFIG_HIGHPTE));
> 
> Ahh.. this is in "ifdef USE_SPLIT_PTE_PTLOCKS" section.  I'm thinking maybe
> we should drop this BUILD_BUG_ON - it says "HIGHPTE shouldn't co-exist with
> USE_SPLIT_PTE_PTLOCKS", but I think it can?
> 
> Said that, I think I can also understand your point, where you see
> ptep_lockptr() a hugetlb-only function, in that case the BUILD_BUG_ON would
> make sense in hugetlb world.
> 
> So.. per my previous nitpick suggestion, IIUC we'll need to drop this
> BUILD_BUG_ON, just to say "USE_SPLIT_PTE_PTLOCKS can work with HIGHPTE" and
> perhaps slightly more readable; we'll rely on the WARN_ON to guard HIGHPTE
> won't use pte lock.

I really don't want to  drop the BUILD_BUG_ON. The function cannot 
possibly work with HIGHPTE, especially once used in other context by 
accident.

So I'll leave it like that. Feel free to optimize the hugetlb code 
further once the fix has landed (e.g., really optimize it out if we 
cannot possibly have such hugetlb sizes).

Thanks!

-- 
Cheers,

David / dhildenb


