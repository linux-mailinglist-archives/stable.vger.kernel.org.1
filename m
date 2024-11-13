Return-Path: <stable+bounces-92904-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0A429C6CCB
	for <lists+stable@lfdr.de>; Wed, 13 Nov 2024 11:24:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F7E228C5C2
	for <lists+stable@lfdr.de>; Wed, 13 Nov 2024 10:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC2681FBF78;
	Wed, 13 Nov 2024 10:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="evaNkDBx"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5604D1FBF65
	for <stable@vger.kernel.org>; Wed, 13 Nov 2024 10:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731493450; cv=none; b=sOPS/7S/1wvIjoaqtMmzYnjHfdGDyLRHuYKJU3Mw46JczdHasqI0bXMnsa7s3I8R+jInxenvPOTuR1F4AK0TriO9BEEsKM4LVmO6p7QHLbImPDR21moSR74fA5tvhEmJfIcyJ7BRNHrMCyxXujaE/dArbv64y9KO+sRPzFLTUB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731493450; c=relaxed/simple;
	bh=F46gwdhcxcM5JsxNXuyXKC9088vuLK+3hUcXIWdwh6I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YkIeus+IN/IdGbh0E9phk6v5lVw6GLZx96UFMxfOgYtY9PRxfNP4HIYQCZJw3TVDloGXeJ1H7mSLripPFytIoFxVBOZ/vZPySu43XEggAQgoUD9//rBkOmZZBF4GwlF5K0kswrIAwGW2oC/nfP0CODpMvlBBZP/25Nhx2t7W+yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=evaNkDBx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731493447;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=TCEGIDibxZZMvKb1dAzkiE67T57ndASH9Dl3yy+Sa6g=;
	b=evaNkDBxn//NHMRQBJlSNRyAqwqXCJqr3YET6H0MLwVOh0yJxSqHm131zqIHVihxLwdqfu
	10Xf3CbncXXtDr2z/r9u0F0xwjrdhwJUaRlefxdGdsxjJH/3uCyqacI8LmZG+AP6Cdw7l7
	r3+Bf7o3hekUA5DsjyQBftpp2soQc0w=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-RkiIWAccNmWUBOj3RDcWTQ-1; Wed, 13 Nov 2024 05:24:06 -0500
X-MC-Unique: RkiIWAccNmWUBOj3RDcWTQ-1
X-Mimecast-MFC-AGG-ID: RkiIWAccNmWUBOj3RDcWTQ
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2fb4c08c02cso26320751fa.1
        for <stable@vger.kernel.org>; Wed, 13 Nov 2024 02:24:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731493444; x=1732098244;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TCEGIDibxZZMvKb1dAzkiE67T57ndASH9Dl3yy+Sa6g=;
        b=e4XJEeGJ921xdAyx7vDob8QCWy4iJ76BNvY1+Cjtu49T0ivekqFhE2c4zHUXuYdZau
         w8iYXafFsNJXZ68IL02WJAPKlc2ApZoRuARpg5PTD7rp+u6CF5L/UXhCy4FJBriMFf3w
         NV+tyL1Yh4G7E+b6lzSdKi/CHUatXvtAgEqC0RhuxqkxYIaF63UsVv0wCeQUSWhI2hY9
         cAhmr7Jml2P6BvGsVfRpA47GbSyGWf17UEFoBd5bqF7CiD2BarHgjX8T1WWi942CWu9N
         rahxyS38maTClkZoRhKUH2yS/aklSeKyemO6fEUiRaF8puEz7GBfIwqVQ0sR6RVqCZ5a
         Uo7w==
X-Forwarded-Encrypted: i=1; AJvYcCWgh/CrM3AxQ/iudXapBDTUna4jIN+yF0Tu2T/7QTOihjgWu8CwGGWZdkjNkj3Mjwf4PSr3gIY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+QMWYlAK7e+ZarDmrzEgVJyLJfiCXfwJmxigGpvdYHergCY94
	PGBjwVlpz1X4oCiiBWH4i/eNIaZ1ogeg7iejWnql8FCiT7+2RU9zzMjsv+N2DfNmJGAX52b59Uj
	4FfoYr8O+9W+Xbmj3HEn3Gw8sqxQLoNZtZ74nsq7NWyOyhvhPfTGcwOoQMIl7og==
X-Received: by 2002:a2e:b8c6:0:b0:2fa:be1a:a4b0 with SMTP id 38308e7fff4ca-2ff4c5df51fmr13781871fa.21.1731493444416;
        Wed, 13 Nov 2024 02:24:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF40AmK7faue/JZFIdOBwQko55dQj12ocsi0rYZXQDfJo60WQnzM69G2KayOlFNMoj/egQ37g==
X-Received: by 2002:a2e:b8c6:0:b0:2fa:be1a:a4b0 with SMTP id 38308e7fff4ca-2ff4c5df51fmr13781661fa.21.1731493443937;
        Wed, 13 Nov 2024 02:24:03 -0800 (PST)
Received: from ?IPV6:2003:cb:c708:1500:d584:7ad8:d3f7:5539? (p200300cbc7081500d5847ad8d3f75539.dip0.t-ipconnect.de. [2003:cb:c708:1500:d584:7ad8:d3f7:5539])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432d552d0a8sm19092625e9.39.2024.11.13.02.24.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Nov 2024 02:24:02 -0800 (PST)
Message-ID: <c9316f7c-025e-4ca7-831c-b74d777efa78@redhat.com>
Date: Wed, 13 Nov 2024 11:24:01 +0100
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
 <88211032-80e1-4067-a74c-c9dcea1abff8@redhat.com>
 <CALOAHbCY94=YDZcuLk5wS1jg1ycAD9Cx9=3CgxE9VOAsnj87vQ@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CALOAHbCY94=YDZcuLk5wS1jg1ycAD9Cx9=3CgxE9VOAsnj87vQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

>>
>> FWIW, I looked at "read_ahead_kb" values on my Fedora40 notebook and
>> they are all set to 128KiB. I'm not so sure if they really should be
>> that small ...
> 
> It depends on the use case. For our hardop servers, we set it to 4MB,
> as they prioritize throughput over latency. However, for our
> Kubernetes servers, we keep it at 128KB since those services are more
> latency-sensitive, and increasing it could lead to more frequent
> latency spikes.

Thanks for sharing.

> 
>> or if large folio readahead code should just be able to
>> exceed it.
>>
>>>> "mm/filemap: Support VM_HUGEPAGE for file mappings" talks about "even if
>>>> we have no history of readahead being successful".
>>>>
>>>> So not about exceeding the configured limit, but exceeding the
>>>> "readahead history".
>>>>
>>>> So I consider VM_HUGEPAGE the sign here to "ignore readahead history"
>>>> and not to "violate the config".
>>>
>>> MADV_HUGEPAGE is definitely a new addition to readahead, and its
>>> behavior isn’t yet defined in the documentation. All we need to do is
>>> clarify its behavior there. The documentation isn’t set in stone—we
>>> can update it as long as it doesn’t disrupt existing applications.
>>
>> If Willy thinks this is the way to go, then we should document that
>> MADV_HUGEPAGE may ignore the parameter, agreed.
> 
> I'll submit an additional patch to update the documentation for MADV_HUGEPAGE.
> 
>>
>> I still don't understand your one comment:
>>
>> "It's worth noting that if read_ahead_kb is set to a larger value that
>> isn't aligned with huge page sizes (e.g., 4MB + 128KB), it may still
>> fail to map to hugepages."
>>
>> Do you mean that MADV_HUGEPAGE+read_ahead_kb<=4M will give you 2M pages,
>> but MADV_HUGEPAGE+read_ahead_kb>4M won't? Or is this the case without
>> MADV_HUGEPAGE?
> 
> Typically, users set read_ahead_kb to aligned sizes, such as 128KB,
> 256KB, 512KB, 1MB, 2MB, 4MB, or 8MB. With this patch, MADV_HUGEPAGE
> functions well for all these settings. However, if read_ahead_kb is
> set to a non-hugepage-aligned size (e.g., 4MB + 128KB), MADV_HUGEPAGE
> won’t work. This is because the initial readahead size for
> MADV_HUGEPAGE is set to 4MB, as established in commit 4687fdbb805a:
> 
>     ra->size = HPAGE_PMD_NR;
>     if (!(vmf->vma->vm_flags & VM_RAND_READ))
>         ra->size *= 2;
> 
> However, as Willy noted, non-aligned settings are quite stupid, so we
> should disregard them.

Right. What I've been wondering, to make this code easier to understand, 
if there should be some kind of ra->size_fixed=true parameter that tells 
readahead code to simply not mess with the ra->size until something 
changes. (below)

[...]

>>> A quick tip for you: the readahead size already exceeds readahead_kb
>>> even without MADV_HUGEPAGE. You might want to spend some time tracing
>>> that behavior.
>>
>> Care to save me some time and point me at what you mean?
> 
> I reached this conclusion by tracing ra->size in each
> page_cache_ra_order() call, but I’m not fully equipped to provide all
> the details ;）

I've been staring at the readhead code for 30 minutes and I am still 
lost. Either I'm too stupid for the code or the code is too complicated.


If we'd have something like

ra->start += ra->size;
/*
  * If someone like VM_HUGEPAGE fixed the size, just don't mess with it.
  */
if (!ra->size_fixed)
	ra->size = get_next_ra_size(ra, max_pages);
ra->async_size = ra->size;

It would be a lot clearer at least to me -- and we'd likely be able to 
get rid of the "unaligned readhahead" oddity.

If we'd grep for who sets "size_fixed", we could even figure out how all 
of this belongs together.

-- 
Cheers,

David / dhildenb


