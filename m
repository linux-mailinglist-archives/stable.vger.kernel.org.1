Return-Path: <stable+bounces-81535-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31DF3994200
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 10:35:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94B0328F206
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 08:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F8841E6DC9;
	Tue,  8 Oct 2024 07:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Dog0Kn5Y"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3EA1E573F
	for <stable@vger.kernel.org>; Tue,  8 Oct 2024 07:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728374289; cv=none; b=PkzbKNAdFh6A+fktowNoCKSrs+sHTqNvDw+DiyWwdUpFKXpAhYoUnTHP6mUNVSZYA7qBfIOXyzPt8DeywTTu0ZESlf79JyFN5NmDh3ddguIAQc/6Uan9tkggXIYBiftdPbS9hkZAjRt/aecRUZj1mXqUsWXnfraULJxTs90JG+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728374289; c=relaxed/simple;
	bh=wCCqfEz6DdFrWWciNOJjsQOLoAG1ndMV94GtscM3NLE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XkR6r7tOGQNRLOay65gMukAaq9vtkvkMacdWF/8yItmbZjwLF/dDbUEPRsNqq+D/phQdS+DmmGqkLu1fl8Nx+eEeMkgMdVixveNm1ccPkm/+o+pWHYqCYqhNeeUdC5FHUW5g7A4J/Wt1YvvmxD9XaPJiUX+KHxcKjZCcglFqB7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Dog0Kn5Y; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7ea06275ef2so1329689a12.0
        for <stable@vger.kernel.org>; Tue, 08 Oct 2024 00:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1728374287; x=1728979087; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ilwU71p4JFHuhR5ku0P7wUYkTrTMS6pYXE6vb6DDuiw=;
        b=Dog0Kn5YkkVQQTyZVAak9Qd0OT8Zzfwg3+pCHRxSAdjxjnBsvn6Jvdk/0vt13j0pls
         Lp0bA4GHlSh8EPMNMPNyTfZ7RdNOJh/u6dAcpVgOtfoFNvituzCRHaXa0xMrQ9bE1qDW
         Yw4PTDfKd0j4Fuq+q/UlMxEHsMHyDV90jOuLz7++czaA3ZlaE4Po0jmZtGqgygsvO2iw
         6moioErt4kbu6L2tz+VAHW1a/J+1xqJ31aXsQvTdp++sdBIpyL+bwGaJSR45T5F3PJeN
         fuOW4++j+pD3itYy7So0bAzFWwLgye1OA2QKov7bBAzpJfTOAVeOmcyZmrw5sFgctClx
         s59Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728374287; x=1728979087;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ilwU71p4JFHuhR5ku0P7wUYkTrTMS6pYXE6vb6DDuiw=;
        b=ZyjPJeJm6rvmv8MN0jqS2lWQJDQNsJrnrQzilNmUIfUxDHHPGZBy/ES5JqnBhKG075
         /rJwjF4mK1JaoEAJuZZuXyvnr8cKe654xu9N5QjGDG3hRUq2AEfiVhffArmuDLg6gTt/
         Zj5LkWNi2d3Te/fT8YUTkjmyAolfUS6bmhr/oz1L/e3BcnIhoTFDZMkoCIeq5Lmjvs67
         wvwfTplabDSxuit1CxfFuQw+xweUK29qP322aOKXTlIe3kJ1C7QlC5L9gpqj291DwThz
         rn3zIKb45UAN2uFxffBIITOo26gjoxdWeTbzGLiTUzQINzEncSKqsaISJLkk9LEkIVvA
         bv4A==
X-Forwarded-Encrypted: i=1; AJvYcCUpDoHK64EYs+puVeTTfoRLbzMSDPcdrGEEfYU7pM2xKv8m71kXz8FGrIKU3uyRXslvtA31K/Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwH5Sij8DCiSrfi1KUKROzRFMe6Ou8RN64hoMKKflh8ikH0M8lI
	6punYnrqBdM1stEcH7Tt7bVKmtvxYcLtmgDSrFf+W9xbWIWYD7p1/Zrv1EzRDeI=
X-Google-Smtp-Source: AGHT+IHN1g2uzj5AhSKq4svLeyrNe2KgneEIeIGEQbArzd+een94HcwN+eGFkVCRRabnx0ftu/fetg==
X-Received: by 2002:a05:6a20:e18a:b0:1cf:658e:5107 with SMTP id adf61e73a8af0-1d6dfa44dd3mr22323407637.21.1728374286725;
        Tue, 08 Oct 2024 00:58:06 -0700 (PDT)
Received: from [10.68.125.128] ([203.208.167.150])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0d67bc8sm5764221b3a.177.2024.10.08.00.58.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2024 00:58:06 -0700 (PDT)
Message-ID: <b989a811-f764-4b3d-b536-be4e68c0638e@bytedance.com>
Date: Tue, 8 Oct 2024 15:58:00 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/mremap: Fix move_normal_pmd/retract_page_tables race
Content-Language: en-US
To: David Hildenbrand <david@redhat.com>
Cc: Jann Horn <jannh@google.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org, willy@infradead.org, hughd@google.com,
 lorenzo.stoakes@oracle.com, joel@joelfernandes.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20241007-move_normal_pmd-vs-collapse-fix-2-v1-1-5ead9631f2ea@google.com>
 <1c114925-9206-42b1-b24b-bb123853a359@bytedance.com>
 <75fac79a-0ff2-4ba0-bdd7-954efe2d9f41@redhat.com>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <75fac79a-0ff2-4ba0-bdd7-954efe2d9f41@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/10/8 15:52, David Hildenbrand wrote:
> On 08.10.24 05:53, Qi Zheng wrote:
>> Hi Jann,
>>
>> On 2024/10/8 05:42, Jann Horn wrote:
>>
>> [...]
>>
>>>
>>> diff --git a/mm/mremap.c b/mm/mremap.c
>>> index 24712f8dbb6b..dda09e957a5d 100644
>>> --- a/mm/mremap.c
>>> +++ b/mm/mremap.c
>>> @@ -238,6 +238,7 @@ static bool move_normal_pmd(struct vm_area_struct 
>>> *vma, unsigned long old_addr,
>>>    {
>>>        spinlock_t *old_ptl, *new_ptl;
>>>        struct mm_struct *mm = vma->vm_mm;
>>> +    bool res = false;
>>>        pmd_t pmd;
>>>        if (!arch_supports_page_table_move())
>>> @@ -277,19 +278,25 @@ static bool move_normal_pmd(struct 
>>> vm_area_struct *vma, unsigned long old_addr,
>>>        if (new_ptl != old_ptl)
>>>            spin_lock_nested(new_ptl, SINGLE_DEPTH_NESTING);
>>> -    /* Clear the pmd */
>>>        pmd = *old_pmd;
>>> +
>>> +    /* Racing with collapse? */
>>> +    if (unlikely(!pmd_present(pmd) || pmd_leaf(pmd)))
>>
>> Since we already hold the exclusive mmap lock, after a racing
>> with collapse occurs, the pmd entry cannot be refilled with
>> new content by page fault. So maybe we only need to recheck
>> pmd_none(pmd) here?
> 
> My thinking was that it is cheap and more future proof to check that we 
> really still have a page table here. For example, what if collapse code 
> is ever changed to replace the page table by the collapsed PMD?

Ah, make sense.

Acked-by: Qi Zheng <zhengqi.arch@bytedance.com>

> 
> So unless there is a good reason not to have this check here, I would 
> keep it like that.
> 
> Thanks!
> 

