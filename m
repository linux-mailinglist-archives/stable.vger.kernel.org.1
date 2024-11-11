Return-Path: <stable+bounces-92148-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CAF69C41CB
	for <lists+stable@lfdr.de>; Mon, 11 Nov 2024 16:26:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4ADB5284DB2
	for <lists+stable@lfdr.de>; Mon, 11 Nov 2024 15:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70BFE49625;
	Mon, 11 Nov 2024 15:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cww/RLff"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C5153389
	for <stable@vger.kernel.org>; Mon, 11 Nov 2024 15:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731338779; cv=none; b=IxDees5h5bo6ttQP4NGeM9o6Fc8SRcZZ3ePtoRy5B2XAvoWz53EkDb+vRGrSH2R4zW4MsKzImnm0IHDqqqsrMOfBHWndUtAe4bl4EJOMz2F2mP9o9CmVRBDndnGj0JVql1CGD0ylY4gFEk0TunUwV60zYtW8Pp3NBdhJHrvbOEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731338779; c=relaxed/simple;
	bh=Fydw77vXbRFV9RH9lH4MqtCszn7+i/pbvTq7cgzg1t8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=W6hOIkWHZjWZQqHtuGXGkNQJPAi0K5b8fh1MuqsmIhq3QYEbZRdczXXg4scKYqIGG9tubhcS/KunJPTM30lTQe/N+W3cH64UYdrt38DLuxVtbRTVONrTYAMhwQAXJOQEYjARhmI7dWtbdvrQ6gQ7DcD2+jEbXX2+aGMPd/OBRKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cww/RLff; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731338776;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=+nycZMjhWDh3vO36kpuEhW9kVC30oxcyFbYQDlbddPk=;
	b=cww/RLffafWm2ElwvNYsWCANo5Oyg2M4KGwUEmmgTwXDOMUXaDQWfSW9R7Ise6oezSyKQF
	OKqWIChpZkffsygxSepRoWzHytz+Y/HDpiKxKoMGfi2S4BtixPfwKX/RNz2f9tOeNc+MGp
	+5TnJ/UfXur3mgkRSn7RwNcvdumHw5w=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-481-mpTsBrAJMYufawR8cBdZhA-1; Mon, 11 Nov 2024 10:26:15 -0500
X-MC-Unique: mpTsBrAJMYufawR8cBdZhA-1
X-Mimecast-MFC-AGG-ID: mpTsBrAJMYufawR8cBdZhA
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43157e3521dso32821115e9.1
        for <stable@vger.kernel.org>; Mon, 11 Nov 2024 07:26:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731338774; x=1731943574;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:from:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+nycZMjhWDh3vO36kpuEhW9kVC30oxcyFbYQDlbddPk=;
        b=nSflIHDtEOqcctD7y6Uh/r5U41wxfeAGFQKMIDC+uc6SP1y6Ey3E6IlbFdMfKd1XDO
         UbXqJmPCxP4zQY3kaO2mAxsJjpu+5sNAHA+grkGlo9kl4JekZRcREZiM9wcJUaN2GB9d
         6IIHPAaj4GFSMFEncnqxBMXf7VB7vRKZIEBRRzHnn1QQz7t1+3aFmeCehSl4uXyDww3P
         80jN2vhSTWCKZqGsVCM5uXrwbXST7/GuUbIFLTdL1enaWUQPN6mq7ZhgexEzhzj3vciN
         PYvmbzfUOZWeA9QZXoa1uQwoqwt8DmAJyl50QlzUDGMzx2Bn/jmQirNjSYmHqSavQpCk
         EIqg==
X-Forwarded-Encrypted: i=1; AJvYcCXOncOuG8FjLHcRoW+8KGdY/cvSj2YzvK4ydtln+jmbAw/sUAxkNWlDXF6bnDo1U0fHQd8woQk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yze0DuBxX/L/jFPXpZIvttCTEKDEHSeHVloePjrckdolVg6UQSN
	Ra1Wq6S7X0FKFZvhR/xT3O1gv9V63GHgDcmwFKk5cQVXFfOFDztDQ3yZPkaptsMjLCwBrznDrbT
	fmHxBgk2jZqjG3r9GbUKNbKlcvnwBqj8c05+E3smXHjmSPyGlpO3F1A==
X-Received: by 2002:a5d:47ae:0:b0:37d:481e:8e29 with SMTP id ffacd0b85a97d-381f186bfdemr10591597f8f.25.1731338773914;
        Mon, 11 Nov 2024 07:26:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFk+/3Aoj5VAHD1rke9vbvpH/Q7jKzsHC7BMeQVpaQKOcPAIQgVb1txMY5ccP6/JbOPGGiocQ==
X-Received: by 2002:a5d:47ae:0:b0:37d:481e:8e29 with SMTP id ffacd0b85a97d-381f186bfdemr10591586f8f.25.1731338773575;
        Mon, 11 Nov 2024 07:26:13 -0800 (PST)
Received: from ?IPV6:2003:cb:c730:4300:18eb:6c63:a196:d3a2? (p200300cbc730430018eb6c63a196d3a2.dip0.t-ipconnect.de. [2003:cb:c730:4300:18eb:6c63:a196:d3a2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432bc472a48sm65206655e9.0.2024.11.11.07.26.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2024 07:26:12 -0800 (PST)
Message-ID: <b18d9e88-efe3-4051-b7de-6390a699fe30@redhat.com>
Date: Mon, 11 Nov 2024 16:26:11 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm/readahead: Fix large folio support in async
 readahead
From: David Hildenbrand <david@redhat.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: willy@infradead.org, akpm@linux-foundation.org, linux-mm@kvack.org,
 stable@vger.kernel.org
References: <20241108141710.9721-1-laoar.shao@gmail.com>
 <85cfc467-320f-4388-b027-2cbad85dfbed@redhat.com>
 <CALOAHbAe8GSf2=+sqzy32pWM2jtENmDnZcMhBEYruJVyWa_dww@mail.gmail.com>
 <fe1b512e-a9ba-454a-b4ac-d4471f1b0c6e@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <fe1b512e-a9ba-454a-b4ac-d4471f1b0c6e@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11.11.24 16:05, David Hildenbrand wrote:
> On 11.11.24 15:28, Yafang Shao wrote:
>> On Mon, Nov 11, 2024 at 6:33 PM David Hildenbrand <david@redhat.com> wrote:
>>>
>>> On 08.11.24 15:17, Yafang Shao wrote:
>>>> When testing large folio support with XFS on our servers, we observed that
>>>> only a few large folios are mapped when reading large files via mmap.
>>>> After a thorough analysis, I identified it was caused by the
>>>> `/sys/block/*/queue/read_ahead_kb` setting. On our test servers, this
>>>> parameter is set to 128KB. After I tune it to 2MB, the large folio can
>>>> work as expected. However, I believe the large folio behavior should not be
>>>> dependent on the value of read_ahead_kb. It would be more robust if the
>>>> kernel can automatically adopt to it.
>>>
>>> Now I am extremely confused.
>>>
>>> Documentation/ABI/stable/sysfs-block:
>>>
>>> "[RW] Maximum number of kilobytes to read-ahead for filesystems on this
>>> block device."
>>>
>>>
>>> So, with your patch, will we also be changing the readahead size to
>>> exceed that, or simply allocate larger folios and not exceeding the
>>> readahead size (e.g., leaving them partially non-filled)?
>>
>> Exceeding the readahead size for the MADV_HUGEPAGE case is
>> straightforward; this is what the current patch accomplishes.
>>
> 
> Okay, so this only applies with MADV_HUGEPAGE I assume. Likely we should
> also make that clearer in the subject.
> 
> mm/readahead: allow exceeding configured read_ahead_kb with MADV_HUGEPAGE
> 
> 
> If this is really a fix, especially one that deserves CC-stable, I
> cannot tell. Willy is the obvious expert :)
> 
>>>
>>> If you're also changing the readahead behavior to exceed the
>>> configuration parameter it would sound to me like "I am pushing the
>>> brake pedal and my care brakes; fix the brakes to adopt whether to brake
>>> automatically" :)
>>>
>>> Likely I am missing something here, and how the read_ahead_kb parameter
>>> is used after your patch.
>>
>> The read_ahead_kb parameter continues to function for
>> non-MADV_HUGEPAGE scenarios, whereas special handling is required for
>> the MADV_HUGEPAGE case. It appears that we ought to update the
>> Documentation/ABI/stable/sysfs-block to reflect the changes related to
>> large folios, correct?
> 
> Yes, how it related to MADV_HUGEPAGE. I would assume that it would get
> ignored, but ...
> 
> ... staring at get_next_ra_size(), it's not quite ignored, because we
> still us it as a baseline to detect how much we want to bump up the
> limit when the requested size is small? (*2 vs *4 etc) :/
> 
> So the semantics are really starting to get weird, unless I am missing
> something important.
Likely what I am missing is that the value of get_next_ra_size() will never be relevant
in that case. I assume the following would end up doing the same:

iff --git a/mm/readahead.c b/mm/readahead.c
index 475d2940a1edb..cc7f883f83d86 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -668,7 +668,12 @@ void page_cache_async_ra(struct readahead_control *ractl,
         ra->start = start;
         ra->size = start - index;       /* old async_size */
         ra->size += req_count;
-       ra->size = get_next_ra_size(ra, max_pages);
+       /*
+        * Allow the actual size to exceed the readahead window for
+        * MADV_HUGEPAGE.
+        */
+       if (ra->size < max_pages)
+               ra->size = get_next_ra_size(ra, max_pages);
         ra->async_size = ra->size;
  readit:
         ractl->_index = ra->start;


So maybe it should just be in get_next_ra_size() where we clarify what "max_pages"
means and why we simply decide to ignore the value ...

-- 
Cheers,

David / dhildenb


