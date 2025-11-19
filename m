Return-Path: <stable+bounces-195172-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A87AC6EF4A
	for <lists+stable@lfdr.de>; Wed, 19 Nov 2025 14:41:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 79DF32E8FE
	for <lists+stable@lfdr.de>; Wed, 19 Nov 2025 13:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 438462DC76E;
	Wed, 19 Nov 2025 13:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DA0pdX4y"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31FF83254B7
	for <stable@vger.kernel.org>; Wed, 19 Nov 2025 13:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763559673; cv=none; b=DRC7411pNmdZdGx+O/gK5TdQbcp/knNTrGEmqOTJP8zk6VsWngAaHuqF7tcoFtw6pHzULTgP/tK1l0f9ylyDueUx84ZAdqOu6roRNn5yUvcD2LJvOpFKmLyATZds782uyZDzJsETHGKqNW9OaeHaeN1ynnxf2uX8ZvnhNU3HOZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763559673; c=relaxed/simple;
	bh=JMG/zd8KalQx0EfURdkuyAJsiN8zQfCG9pitp8A1JAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lXyRJfDQJdbzwidY7mAeCrIcvhuaG2oDz27lmNcl4JsE7lfJxzxFoXscSLsYVidxjNva1YMtbxEw6vIhr8apwchAyuZNXDcHT9HFO4/fkZSGdPRxltlPo4NeuzuZhpYk+nlsCPACJ9G1oUsHWnyxldjGEnyCUJ5xv0t7zNJdpF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DA0pdX4y; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b75c7cb722aso291870866b.1
        for <stable@vger.kernel.org>; Wed, 19 Nov 2025 05:41:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763559668; x=1764164468; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k/bYghiR1NKi6Ugt9MldXXYgGqUjbAjc5MFUJnrN65w=;
        b=DA0pdX4ykWbsA5dHvEyJGsONc9kNCWewUTRx7rC2JlzkcA5SO+Cf/SE3m2tE30BYMr
         jxg7wvz+XI3+DcjmP0r/TnOzJX+xtq3EWWl7kjTfWCLXalRkSPGgjo0L/Kuk8/nQEkfP
         Vdj1fjxAGBdNCfPnb7ayPcbyNagTvB95R9aaBb4gfoE6SGYaVPPdQSXr3CcrtbqSQ9m4
         EzoO9g+Nhfw4Ks1I4dyHaBBH4Zji6xFfrn95AVgG6GKRnGFosMumiRLLt2qCtg6LUfsQ
         JUjV6WC7M5N78wiGTV6TmevufiyLLbjBQV3/jywbhbE+CvyT0HgFzZYYnEuJFhN4bB/q
         v/eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763559668; x=1764164468;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k/bYghiR1NKi6Ugt9MldXXYgGqUjbAjc5MFUJnrN65w=;
        b=vP2OYAbw1d26lKjwNKSIZOKNsNaVi4VJ1ytI0Tb7wesNm10e6Nku3LRubgkvAsO1Gl
         oiACzOYAHdZ0Q4T+I0JDdWxHIUmdSlzxRjlvjrCjSGrLZb024GS0MPYS5S9fuURwC3rT
         Dplb0JPTglsq7P1pRYjD7sIrWFrq0gMXrB/wXbJamwr8/cDs3HdXVPTOUe82T5TMG6wD
         hbZkMe2tnCQy5Vq8j9dP5Wh/PCV6aFC103TItBFAz7r+A/6yOFvvMbNtEOFZzG5xczxe
         6a9FIBcVHznzNQcFo5TtL9cvolU5oiCWnMxqhZC6SpWoPWO4j/GgR1sY+X8yl6Rj5TzL
         1bUQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+YAGfFNEFpOrVyoqeNyD804rfLjXuT3X8Y9jT4Ncas2YkpFy3Mv9NrMpn16aLe+AMHFWRO+4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXlcqUDaL8p5J54tKsyk8YZvxvbK7he4V5KhbhxpwUXJQ12eIW
	rzFF0VwjCEhjZDh5aXQxydP6xOJwGThY4874a/0t3HhchHv9WpNsbhRb
X-Gm-Gg: ASbGncvqd+nJr4b5VtbaKp85kYhhXdTiIP0p2gcev91zXDgkz1g61ffq90thNt6CJY+
	36OqMcUPb+pt5/xlE/lywBDuGViEae64EYa5z7l/dwhPFZjoECkgw6jjhcCRgsg6ir7AH16gOAy
	PYX1q/+bVlodDbQs1SaV2LGZ2rVVTbEkfpOwoSTaJJxOblCEsZEIT81OHwmZH7/TEVA9EWaEWfX
	BAem9OsD8Cht2ADfX1+2k7ZrWelKtQzzS8OCGbF7HGcFYqTvWxWzogA5KgkB+IA2PPn2g7cUBiO
	L1YBOr696JOBWs7OzR/jKBSY5GOQZUl06KcwC16Y+CMv42kq63y2W0xDrjQ+Ch4/eDaf/6QVfih
	Fg5nDxbFTYt+8R2+89paogaJOsoH/hiAV/v8T3y53duaMr8PIUUKQGemfwQ0ZTGLJx+AKxt4IwA
	LiyG5OV25gIBRi6Q==
X-Google-Smtp-Source: AGHT+IFLZtFqPwcZsXNVn485Ak8+kST95+upGdcVr5akj8JIUOsSoxuzBdGr+yhvA650LKVUGjHUzw==
X-Received: by 2002:a17:907:7b91:b0:b70:fd2f:6a46 with SMTP id a640c23a62f3a-b736780c18fmr2213378266b.20.1763559667699;
        Wed, 19 Nov 2025 05:41:07 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b734fad45afsm1629403166b.24.2025.11.19.05.41.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Nov 2025 05:41:07 -0800 (PST)
Date: Wed, 19 Nov 2025 13:41:06 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Zi Yan <ziy@nvidia.com>
Cc: "David Hildenbrand (Red Hat)" <david@kernel.org>,
	Wei Yang <richard.weiyang@gmail.com>, akpm@linux-foundation.org,
	lorenzo.stoakes@oracle.com, baolin.wang@linux.alibaba.com,
	Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com,
	dev.jain@arm.com, baohua@kernel.org, lance.yang@linux.dev,
	linux-mm@kvack.org, stable@vger.kernel.org
Subject: Re: [PATCH] mm/huge_memory: fix NULL pointer deference when
 splitting shmem folio in swap cache
Message-ID: <20251119134106.t7jmnl2k5w265en6@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20251119012630.14701-1-richard.weiyang@gmail.com>
 <a5437eb1-0d5f-48eb-ba20-70ef9d02396b@kernel.org>
 <20251119122325.cxolq3kalokhlvop@master>
 <59b1d49f-42f5-4e7e-ae23-7d96cff5b035@kernel.org>
 <950DEF53-2447-46FA-83D4-5D119C660521@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <950DEF53-2447-46FA-83D4-5D119C660521@nvidia.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Wed, Nov 19, 2025 at 08:08:01AM -0500, Zi Yan wrote:
>On 19 Nov 2025, at 7:54, David Hildenbrand (Red Hat) wrote:
>
>>>
>>>> So I think we should try to keep truncation return -EBUSY. For the shmem
>>>> case, I think it's ok to return -EINVAL. I guess we can identify such folios
>>>> by checking for folio_test_swapcache().
>>>>
>>>
>>> Hmm... Don't get how to do this nicely.
>>>
>>> Looks we can't do it in folio_split_supported().
>>>
>>> Or change folio_split_supported() return error code directly?
>>
>>
>> On upstream, I would do something like the following (untested):
>>
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index 2f2a521e5d683..33fc3590867e2 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -3524,6 +3524,9 @@ bool non_uniform_split_supported(struct folio *folio, unsigned int new_order,
>>                                 "Cannot split to order-1 folio");
>>                 if (new_order == 1)
>>                         return false;
>> +       } else if (folio_test_swapcache(folio)) {
>> +               /* TODO: support shmem folios that are in the swapcache. */
>> +               return false;

Hmm... we are filtering out all swapcache instead of just shmem swapcache?

Is it possible for (folio->mapping && folio_test_swapcache(folio)) reach here?
Looks the logic is little different, but maybe I missed something.

OK, my brain is out of state. Hope I don't make stupid mistake.

>>         } else if (IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) &&
>>             !mapping_large_folio_support(folio->mapping)) {
>>                 /*
>> @@ -3556,6 +3559,9 @@ bool uniform_split_supported(struct folio *folio, unsigned int new_order,
>>                                 "Cannot split to order-1 folio");
>>                 if (new_order == 1)
>>                         return false;
>> +       } else if (folio_test_swapcache(folio)) {
>> +               /* TODO: support shmem folios that are in the swapcache. */
>> +               return false;
>You are splitting the truncate case into shmem one and page cache one.
>This is only for shmem in the swap cache and ...
>
>>         } else  if (new_order) {
>>                 if (IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) &&
>>                     !mapping_large_folio_support(folio->mapping)) {
>> @@ -3619,6 +3625,15 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
>>         if (folio != page_folio(split_at) || folio != page_folio(lock_at))
>>                 return -EINVAL;
>>  +       /*
>> +        * Folios that just got truncated cannot get split. Signal to the
>> +        * caller that there was a race.
>> +        *
>> +        * TODO: support shmem folios that are in the swapcache.
>
>this is for page cache one. So this TODO is not needed.
>
>> +        */
>> +       if (!is_anon && !folio->mapping && !folio_test_swapcache(folio))
>> +               return -EBUSY;
>> +
>>         if (new_order >= folio_order(folio))
>>                 return -EINVAL;
>>  @@ -3659,17 +3674,7 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
>>                 gfp_t gfp;
>>                  mapping = folio->mapping;
>> -
>> -               /* Truncated ? */
>> -               /*
>> -                * TODO: add support for large shmem folio in swap cache.
>> -                * When shmem is in swap cache, mapping is NULL and
>> -                * folio_test_swapcache() is true.
>> -                */
>> -               if (!mapping) {
>> -                       ret = -EBUSY;
>> -                       goto out;
>> -               }
>> +               VM_WARN_ON_ONCE_FOLIO(!mapping, folio);
>>                  min_order = mapping_min_folio_order(folio->mapping);
>>                 if (new_order < min_order) {
>>
>>
>> So rule out the truncated case earlier, leaving only the swapcache check to be handled
>> later.
>>
>> Thoughts?
>
>I thought the truncated case includes both page cache and shmem in the swap cache.
>
>Otherwise, it looks good to me.
>
>>>
>>>>
>>>> Probably worth mentioning that this was identified by code inspection?
>>>>
>>>
>>> Agree.
>>>
>>>>>
>>>>> Fixes: c010d47f107f ("mm: thp: split huge page to any lower order pages")
>>>>> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
>>>>> Cc: Zi Yan <ziy@nvidia.com>
>>>>> Cc: <stable@vger.kernel.org>
>>>>
>>>> Hmm, what would this patch look like when based on current upstream? We'd
>>>> likely want to get that upstream asap.
>>>>
>>>
>>> This depends whether we want it on top of [1].
>>>
>>> Current upstream doesn't have it [1] and need to fix it in two places.
>>>
>>> Andrew mention prefer a fixup version in [2].
>>>
>>> [1]: lkml.kernel.org/r/20251106034155.21398-1-richard.weiyang@gmail.com
>>> [2]: lkml.kernel.org/r/20251118140658.9078de6aab719b2308996387@linux-foundation.org
>>
>> As we will want to backport this patch, likely we want to have it apply on current master.
>>
>> Bur Andrew can comment what he prefers in this case of a stable fix.
>
>That could mess up with mm-new tree[1] based on Andrew's recent feedback.
>
>[1] https://lore.kernel.org/all/20251118140658.9078de6aab719b2308996387@linux-foundation.org/
>
>--
>Best Regards,
>Yan, Zi

-- 
Wei Yang
Help you, Help me

