Return-Path: <stable+bounces-92896-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B147B9C6A8D
	for <lists+stable@lfdr.de>; Wed, 13 Nov 2024 09:28:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2693FB22346
	for <lists+stable@lfdr.de>; Wed, 13 Nov 2024 08:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8787F189F33;
	Wed, 13 Nov 2024 08:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FERQF8vW"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7829517BB1A
	for <stable@vger.kernel.org>; Wed, 13 Nov 2024 08:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731486522; cv=none; b=X+qO+eWNxYmEvU+x/AiJJQLeOu7b7/n/zFhZ8CyvtfiXiCWoiUqvMFwC+V/jfQSTiwD3Cbyhu09Ry59vMnuozDEZTwrj7YyyLWseT9vbrwQXSdsr19sH2Ped/oFt1EVD0F24zt8Y1yokjZuCLEUEgrqyvyEf/2ciI8qfrm5gZ2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731486522; c=relaxed/simple;
	bh=2MRQH1L1Adq1f2SqbpFtLJn7gbrSszO+6T3aaV94IZU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SUfnjOsaiWa1rqyRkr/VCtWB1EuQMZ81FTYSKTcx5jleccJt3HikRPMauMgi0nMva+6FrOkEf2wCeP7ppj8R2bAvnjjXzYLAq+okejYFEWnlRyxvXH7F64lXfb+iV+uBdMoNyjl1i1vMq/UrZW5yJNF97o/1Cd4k6bFHihSG1JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FERQF8vW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731486519;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ANsLgiG9ydXh1ltK9+hJKMhTRlW66aK4qxMaryulQkQ=;
	b=FERQF8vWJM05HHwZKZDsVr2kk6dZ2yj0ZM+yWSe9qrYWNZKnxhiXjFW56233fQI01HM6I6
	9nuihA9a/D8hpeaKNR1ZE61uL4TpQo1Zu7CjBfTWwECh0JpYRh/bvESS/phsKolqLmFQFG
	TbwJH1+oJhimr5w4ZRKEqqEGRBxz3X0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-e9mI1f24N5a8vFCvfuYCPg-1; Wed, 13 Nov 2024 03:28:37 -0500
X-MC-Unique: e9mI1f24N5a8vFCvfuYCPg-1
X-Mimecast-MFC-AGG-ID: e9mI1f24N5a8vFCvfuYCPg
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-432d7a082b5so428655e9.0
        for <stable@vger.kernel.org>; Wed, 13 Nov 2024 00:28:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731486516; x=1732091316;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ANsLgiG9ydXh1ltK9+hJKMhTRlW66aK4qxMaryulQkQ=;
        b=jNlsSGEG+ydogNqswGJO/fDdPoWyXa6KXXOegPI2g0TRhZGBW2GM4l3U8c1AyZmINz
         NoOQFsk7BmFo0yf95E+mpLzktKzqS6BrODLLk8ultvtRLno5FDdTyaYqj5RGMOqMJxYh
         vlBRGCMKsp+nExbzIH30g+Va8WJKebr/bp6ZwtE0kpBbA4dsoQWuGThfoReVzBtLYXjV
         RAbLjiqvFtCWOpSoIR/lmmkDitdOXe3Cf+Mx9ytFp4ygdZDPYzem6W6MVciq+v2YM8f8
         G9771nslqlDNk50gY/th6sSwmQDq0GdYpgcWRqRgSbGmqCT2NeIg3Qtp6YkS4PTH7aWs
         ebpA==
X-Forwarded-Encrypted: i=1; AJvYcCUgor06dQ3MsyqzY1Nxle+s9sB95KhRRGEa9lZcTCujfskD6WQYgOOMcKeRyYx8CBk9MkYkmb4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxk1dqEXpyM/LCdOT36qvXj7479RPBf7ogJJT+kWjezYxTV3vpM
	Y3pS36vhlrdpa3dEY4D79XJGziB+X+8KjvZkKT6r/5YuMK/1RM/O9/YyErdoI+zRYlAU+rIcPYd
	891ieqHAvB0+OK3El9U0qoUMa479x1DmyeH3FBAi7G/UykqHaE1bF4YkKhGp6Dw==
X-Received: by 2002:a05:6000:4006:b0:37d:3baa:9f34 with SMTP id ffacd0b85a97d-381f1a6665cmr17295956f8f.1.1731486516618;
        Wed, 13 Nov 2024 00:28:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEE5mnO7bLpEgKGRXY/GOcFnek1LfoqT2xZHePqAx5C0p/vhHzaDE/gjD82YOtmT2BBIyX5ow==
X-Received: by 2002:a05:6000:4006:b0:37d:3baa:9f34 with SMTP id ffacd0b85a97d-381f1a6665cmr17295932f8f.1.1731486516234;
        Wed, 13 Nov 2024 00:28:36 -0800 (PST)
Received: from ?IPV6:2003:cb:c708:1500:d584:7ad8:d3f7:5539? (p200300cbc7081500d5847ad8d3f75539.dip0.t-ipconnect.de. [2003:cb:c708:1500:d584:7ad8:d3f7:5539])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381fc0f5f91sm9180316f8f.62.2024.11.13.00.28.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Nov 2024 00:28:34 -0800 (PST)
Message-ID: <88211032-80e1-4067-a74c-c9dcea1abff8@redhat.com>
Date: Wed, 13 Nov 2024 09:28:34 +0100
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
 <fe1b512e-a9ba-454a-b4ac-d4471f1b0c6e@redhat.com>
 <CALOAHbD6HsrMhY0S_d9XA0LRdMGr6wwxFYAnv6u-d7VRFt6aKg@mail.gmail.com>
 <cf446ada-ad3a-41a4-b775-6cb32f846f2a@redhat.com>
 <CALOAHbA=GuxdfQ8j-bnz=MT=0DTnrcNu5PcXvftfNh37WzRy1Q@mail.gmail.com>
 <a1fe53f7-a520-488c-9136-4e5e1421427e@redhat.com>
 <CALOAHbAohzxsG7Fq2kNDc5twbtpzJRCPbJ1C=oYB8fy8PsQzaQ@mail.gmail.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CALOAHbAohzxsG7Fq2kNDc5twbtpzJRCPbJ1C=oYB8fy8PsQzaQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 13.11.24 03:16, Yafang Shao wrote:
> On Tue, Nov 12, 2024 at 11:19 PM David Hildenbrand <david@redhat.com> wrote:
>>
>>>> Sorry, but this code is getting quite confusing, especially with such
>>>> misleading "large folio" comments.
>>>>
>>>> Even without MADV_HUGEPAGE we will be allocating large folios, as
>>>> emphasized by Willy [1]. So the only thing MADV_HUGEPAGE controls is
>>>> *which* large folios we allocate. .. as Willy says [2]: "We were only
>>>> intending to breach the 'max' for the MADV_HUGE case, not for all cases."
>>>>
>>>> I have no idea how *anybody* should derive from the code here that we
>>>> treat MADV_HUGEPAGE in a special way.
>>>>
>>>> Simply completely confusing.
>>>>
>>>> My interpretation of "I don't know if we should try to defend a stupid
>>>> sysadmin against the consequences of their misconfiguration like this"
>>>> means" would be "drop this patch and don't change anything".
>>>
>>> Without this change, large folios won’t function as expected.
>>> Currently, to support MADV_HUGEPAGE, you’d need to set readahead_kb to
>>> 2MB, 4MB, or more. However, many applications run without
>>   > MADV_HUGEPAGE, and a larger readahead_kb might not be optimal for> them.
>>
>> Someone configured: "Don't readahead more than 128KiB"
>>
>> And then we complain why we "don't readahead more than 128KiB".
> 
> That is just bikeshielding.

It's called "reading the documentation and trying to make sense of a 
patch". ;)

> 
> So, what’s your suggestion? Simply setting readahead_kb to 2MB? That
> would almost certainly cause issues elsewhere.

I'm not 100% sure. I'm trying to make sense of it all.

And I assume there is a relevant difference now between "readahead 2M 
using all 4k pages" and "readahead 2M using a single large folio".

I agree that likely readahead using many 4k pages is a worse idea than 
just using a single large folio ... if we manage to allocate one. And 
it's all not that clear in the code ...

FWIW, I looked at "read_ahead_kb" values on my Fedora40 notebook and 
they are all set to 128KiB. I'm not so sure if they really should be 
that small ... or if large folio readahead code should just be able to 
exceed it.

>> "mm/filemap: Support VM_HUGEPAGE for file mappings" talks about "even if
>> we have no history of readahead being successful".
>>
>> So not about exceeding the configured limit, but exceeding the
>> "readahead history".
>>
>> So I consider VM_HUGEPAGE the sign here to "ignore readahead history"
>> and not to "violate the config".
> 
> MADV_HUGEPAGE is definitely a new addition to readahead, and its
> behavior isn’t yet defined in the documentation. All we need to do is
> clarify its behavior there. The documentation isn’t set in stone—we
> can update it as long as it doesn’t disrupt existing applications.

If Willy thinks this is the way to go, then we should document that 
MADV_HUGEPAGE may ignore the parameter, agreed.

I still don't understand your one comment:

"It's worth noting that if read_ahead_kb is set to a larger value that 
isn't aligned with huge page sizes (e.g., 4MB + 128KB), it may still 
fail to map to hugepages."

Do you mean that MADV_HUGEPAGE+read_ahead_kb<=4M will give you 2M pages, 
but MADV_HUGEPAGE+read_ahead_kb>4M won't? Or is this the case without 
MADV_HUGEPAGE?

If MADV_HUGEPAGE ignores read_ahead_kb completely, it's easy to document.

> 
>>
>> But that's just my opinion.
>>
>>>
>>>>
>>>> No changes to API, no confusing code.
>>>
>>> New features like large folios can often create confusion with
>>> existing rules or APIs, correct?
>>
>> We should not try making it even more confusing, if possible.
> 
> A quick tip for you: the readahead size already exceeds readahead_kb
> even without MADV_HUGEPAGE. You might want to spend some time tracing
> that behavior.

Care to save me some time and point me at what you mean?

> 
> In summary, it’s really the readahead code itself that’s causing the
> confusion—not MADV_HUGEPAGE.


Let me dig into the code in more detail if can make sense of it all.

-- 
Cheers,

David / dhildenb


