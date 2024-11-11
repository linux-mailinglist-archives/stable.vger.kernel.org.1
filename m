Return-Path: <stable+bounces-92145-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B5659C4175
	for <lists+stable@lfdr.de>; Mon, 11 Nov 2024 16:06:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DFBD1C2231F
	for <lists+stable@lfdr.de>; Mon, 11 Nov 2024 15:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 626E1136E21;
	Mon, 11 Nov 2024 15:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="atb8FxcA"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1134D8CE
	for <stable@vger.kernel.org>; Mon, 11 Nov 2024 15:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731337558; cv=none; b=mHPDp+i0iUCpcC3i2ECa13CpoPJ5zK6zbLshBZS9juK2RSSbsgrB6bxIMNYs4qggKsVD6+2y9sIuZXU3XrSMieQuXXhzGmDODse5t1cqQxq/L/j1ZQMg6akuyCtrpQ/rw+KwXrRuBxJ0TwWvSGfN4ZFIxt0Xe3wUOyHVDa+4oPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731337558; c=relaxed/simple;
	bh=C3cfL/EefuZiz8HEAbC5xCfLD+D4Wv3T5BT3TkOJPM8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=syh6bTvuPZuE6eworWAiWZ6WKpUdwZXUypjok/N4LsKY3Kj5OCjWxC2Nk7EVsxqnZi3w6dgHpWDLpTAr6UvJMrN11OqVPonMd+jaxkRatCbNpJdn5sYUrwScNItjQobhyW+LtEL1Mff8H3KiW2l1kDYVc5JuAR0lBdiXqqZrW+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=atb8FxcA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731337555;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=38kTQdBgCTmqd1jZvKRcA8iAZWv4IqdGy2B3UW1o1T0=;
	b=atb8FxcAYiilZitOdiK2sRBDn+G4Grx6Itb//DE1Ct40YCC3R5MbrZ1QbD4ykf46NsOZ03
	Zrzp94kExY/jjnS8idIdj2zxjPjyAV7ana+lqddbsSwInpAVQX+9oiUji471Y8rnCl/EY3
	8QzjRSkgtvWRjxe4mvj7sV5gVsVNqBs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-t-6NuS8QMtaWXY_Sw6mO6A-1; Mon, 11 Nov 2024 10:05:54 -0500
X-MC-Unique: t-6NuS8QMtaWXY_Sw6mO6A-1
X-Mimecast-MFC-AGG-ID: t-6NuS8QMtaWXY_Sw6mO6A
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-431518ae047so29658415e9.0
        for <stable@vger.kernel.org>; Mon, 11 Nov 2024 07:05:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731337552; x=1731942352;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=38kTQdBgCTmqd1jZvKRcA8iAZWv4IqdGy2B3UW1o1T0=;
        b=GsdxqNV7W16dkxhfXvQjuM4VKb7agFD+eFbxVE3aVXxSStGdhteTEXISRFwwI3JbXH
         2lOAZI3KqUJAJv4vA0C9cqZIyJ6FpPn72TbQfjJQFUhhk4zzdUiZthGpiLjVO3PhoHV2
         R4Vn5zgSZnZsHQQXHlMXQGi69sNQ2dCj5YC0XSXAPrq+150RwCE8ssC78u9gxmshaVvy
         5UbEQ6GhQrADkFwFV18HepVE8boRuUrbqvNfm9dBr23A/v0Z0BoioQmOTg216fy6QgCO
         sv5w0eVKp1sTBJE2cNGo381i3T+J5S/iyLJKdKxXJIEjEScx5V9sLPGKFa0zP7ZTHpXg
         Pz2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUiUkSsYBaU/9rS+Nphkr3NNn+jHrvUk1qhKVDSFteepnt7//OpmRN8oG/1Dv2z213DLnDif/A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJsNRcyd8sQz098+ISADMm3BbgbM2i4mlfBH1PU9kToQXrY6XG
	E71ITVntjBfZDLWYHhPs+0I9R/cb+WbUcjanBqdusxhSL7pYWI93IyojymSIBTCcCiHXxlu5GKc
	lXKs1utAbbVJnA2ji26uwe/LqmRPm0+MeuOd9hnBfrpJpBvgdRi0M06E/D0eItQ==
X-Received: by 2002:a05:6000:1acc:b0:37c:cc7c:761c with SMTP id ffacd0b85a97d-381f1a6675fmr9298834f8f.3.1731337552399;
        Mon, 11 Nov 2024 07:05:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHAKfJXePAZhSn0W1o6XxMGdfw7SigQp+zTlVoy586N0Pb+krSGmc3qMW5MgXEZZiUPXRc34Q==
X-Received: by 2002:a05:6000:1acc:b0:37c:cc7c:761c with SMTP id ffacd0b85a97d-381f1a6675fmr9298794f8f.3.1731337551947;
        Mon, 11 Nov 2024 07:05:51 -0800 (PST)
Received: from ?IPV6:2003:cb:c730:4300:18eb:6c63:a196:d3a2? (p200300cbc730430018eb6c63a196d3a2.dip0.t-ipconnect.de. [2003:cb:c730:4300:18eb:6c63:a196:d3a2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381ed97ce0fsm13072723f8f.33.2024.11.11.07.05.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2024 07:05:50 -0800 (PST)
Message-ID: <fe1b512e-a9ba-454a-b4ac-d4471f1b0c6e@redhat.com>
Date: Mon, 11 Nov 2024 16:05:49 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm/readahead: Fix large folio support in async
 readahead
To: Yafang Shao <laoar.shao@gmail.com>
Cc: willy@infradead.org, akpm@linux-foundation.org, linux-mm@kvack.org,
 stable@vger.kernel.org
References: <20241108141710.9721-1-laoar.shao@gmail.com>
 <85cfc467-320f-4388-b027-2cbad85dfbed@redhat.com>
 <CALOAHbAe8GSf2=+sqzy32pWM2jtENmDnZcMhBEYruJVyWa_dww@mail.gmail.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CALOAHbAe8GSf2=+sqzy32pWM2jtENmDnZcMhBEYruJVyWa_dww@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11.11.24 15:28, Yafang Shao wrote:
> On Mon, Nov 11, 2024 at 6:33 PM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 08.11.24 15:17, Yafang Shao wrote:
>>> When testing large folio support with XFS on our servers, we observed that
>>> only a few large folios are mapped when reading large files via mmap.
>>> After a thorough analysis, I identified it was caused by the
>>> `/sys/block/*/queue/read_ahead_kb` setting. On our test servers, this
>>> parameter is set to 128KB. After I tune it to 2MB, the large folio can
>>> work as expected. However, I believe the large folio behavior should not be
>>> dependent on the value of read_ahead_kb. It would be more robust if the
>>> kernel can automatically adopt to it.
>>
>> Now I am extremely confused.
>>
>> Documentation/ABI/stable/sysfs-block:
>>
>> "[RW] Maximum number of kilobytes to read-ahead for filesystems on this
>> block device."
>>
>>
>> So, with your patch, will we also be changing the readahead size to
>> exceed that, or simply allocate larger folios and not exceeding the
>> readahead size (e.g., leaving them partially non-filled)?
> 
> Exceeding the readahead size for the MADV_HUGEPAGE case is
> straightforward; this is what the current patch accomplishes.
> 

Okay, so this only applies with MADV_HUGEPAGE I assume. Likely we should 
also make that clearer in the subject.

mm/readahead: allow exceeding configured read_ahead_kb with MADV_HUGEPAGE


If this is really a fix, especially one that deserves CC-stable, I 
cannot tell. Willy is the obvious expert :)

>>
>> If you're also changing the readahead behavior to exceed the
>> configuration parameter it would sound to me like "I am pushing the
>> brake pedal and my care brakes; fix the brakes to adopt whether to brake
>> automatically" :)
>>
>> Likely I am missing something here, and how the read_ahead_kb parameter
>> is used after your patch.
> 
> The read_ahead_kb parameter continues to function for
> non-MADV_HUGEPAGE scenarios, whereas special handling is required for
> the MADV_HUGEPAGE case. It appears that we ought to update the
> Documentation/ABI/stable/sysfs-block to reflect the changes related to
> large folios, correct?

Yes, how it related to MADV_HUGEPAGE. I would assume that it would get 
ignored, but ...

... staring at get_next_ra_size(), it's not quite ignored, because we 
still us it as a baseline to detect how much we want to bump up the 
limit when the requested size is small? (*2 vs *4 etc) :/

So the semantics are really starting to get weird, unless I am missing 
something important.

[...]

> Perhaps a more straightforward solution would be to implement it
> directly at the callsite, as demonstrated below?

Likely something into this direction might be better, but Willy is the 
expert that code.

> 
> diff --git a/mm/readahead.c b/mm/readahead.c
> index 3dc6c7a128dd..187efae95b02 100644
> --- a/mm/readahead.c
> +++ b/mm/readahead.c
> @@ -642,7 +642,11 @@ void page_cache_async_ra(struct readahead_control *ractl,
>                          1UL << order);
>          if (index == expected) {
>                  ra->start += ra->size;
> -               ra->size = get_next_ra_size(ra, max_pages);
> +               /*
> +                * Allow the actual size to exceed the readahead window for a
> +                * large folio.

"a large folio" -> "with MADV_HUGEPAGE" ? Or can this be hit on 
different paths that are not covered in the patch description?

-- 
Cheers,

David / dhildenb


