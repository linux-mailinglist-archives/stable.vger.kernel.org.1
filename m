Return-Path: <stable+bounces-166801-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB35EB1DD9C
	for <lists+stable@lfdr.de>; Thu,  7 Aug 2025 21:42:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 961F5620439
	for <lists+stable@lfdr.de>; Thu,  7 Aug 2025 19:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A301218E96;
	Thu,  7 Aug 2025 19:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PXQy9TOq"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3F42165EC
	for <stable@vger.kernel.org>; Thu,  7 Aug 2025 19:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754595775; cv=none; b=VhbohCLthzbRz3x5D5JxakzTniBnWH1ylDdQwGUVl6+u9BxGpcNWFDW09/7OnZEbHVMFJNHJfqNYe6lQDVP812WH6FHzzqtqeNmYU+znk6wxGwIjjshwkR/ZIpSpHKg1umjN4zYPHpWhfwuwVOz+SqzIf9IJ020oxNDRREzLFfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754595775; c=relaxed/simple;
	bh=OSZE3N09J+XSSRuD+ORoixfPCPu4RAFdLr8zoR1QR2s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QdyquLPotMZNj3O7bQUxsepP3Z89Txj/4MVkl40xu+6YNcXbuMbHFGu6Ab1ByL3n0197SSuHqYSbQ3JA4QiOp3zS1cuLtUeaeVIteTjopHzwfxdQFquba7Ia7JNfIr6y0wG4VJKInPnA9SrqEEVk5a8FjyvSpW5sXjiYfFKpVgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PXQy9TOq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754595772;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=3LaDDgMqq/ecpftpql7G8nbETipKVAUsT3I+eSzopR4=;
	b=PXQy9TOqDAOEEleHTaa8BRpu7dC7hJhTXrz9Z6epJzx8RYc6tz9lyjji2b+pvXzqxkRPvv
	WzRGzQaCzAhKTz7TW9bgqx+NqtkaRes8SpyYH3swbdv4vUSObU2PRoVuIYmxvUnc0mdJwC
	IEuP7MiRsMRCUbq3KQKJ+l7cbe7EpeQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656-rEdeiSZfPYK8KbXBUWcRrQ-1; Thu, 07 Aug 2025 15:42:51 -0400
X-MC-Unique: rEdeiSZfPYK8KbXBUWcRrQ-1
X-Mimecast-MFC-AGG-ID: rEdeiSZfPYK8KbXBUWcRrQ_1754595770
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-459d7da3647so11209935e9.0
        for <stable@vger.kernel.org>; Thu, 07 Aug 2025 12:42:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754595770; x=1755200570;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3LaDDgMqq/ecpftpql7G8nbETipKVAUsT3I+eSzopR4=;
        b=iQduVUZNBR/O7Q1lPcrARFAZZaMY6nfdkdNBdnaOWFipU/6c0Q/uussa9C2eFrY554
         pyrIwUgAJSxSrkiWpROGQGFG/nDrKUIAjOXKwEKTSFjosDDgELpShO1UUy8q2vL1p2Gg
         +To49CMCvZ6xDYwW5J4IASCSNgdHTJaDSkuctkzUHz6Bq/2r/p3c7nr28NnKjcn7XllM
         qalkiGMxRQWzUArS9kFVdTBJnC2JdnPs7bXVnUE3jEcJx9uOHdOcPm0UVyYaU9rvlE7A
         6r98ZGipgT637GepbczdcOkAybzWepJpcwB87ft163ii18xAYRSg3hyN9Ab9bxV6YxIt
         RE3g==
X-Forwarded-Encrypted: i=1; AJvYcCUsGmQECM/moXj0f/0TIfSe4B/bJrFAQdIZBmR5++1ka25KN9xZhaDoGMWYMdAGBADLls7ieqE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyctGk9tQVHMbhz6xA8oAMe2nKqW2Bv/skfQZ7ubQ34joto3Dz
	3AEfNvrmy6okSOVNiubcnnjowAh4t/ugGPSM2MpPUeF8MS3WuucnG2MlvhFdUeXl2xVP6pYmAXn
	tYcw3Z9jPENigoUeB5efbo6Hgn9IZdyxwbGaydX7A7bBHkVDsRAEcCl6DuA==
X-Gm-Gg: ASbGncvuCR1U09QIJXRr3W/4fxheaw/rBJcKdfXRnfS8RPN/BhJ5mTO/UwlKWHMxzos
	mA5TeoOFvix9+1Q0HWQfjVOG/I5enf58ssCdPmfmZL4F9eWcrQvivlCCcq46o/zHuRmTqnYg+b3
	SkXMgci2c9E+38hUkxqNgRlQqq7TfZnGrqBS7wpDJUeHBDRq8NGjTN9x3EFjjAFtQNJlnjdibqk
	iqmq02m9N7t1+POuew1ZnmjB4EsBNf4Y4HfpHqqtGbQBqu6PCLmOtfTKJMHWFc5peVO/7MqTQAv
	+6IJlVNyBkYLo3zoWrC0ROADMyvDuVwkf9B5UnfmGwRT14ccwQuOlzXdtoVq6sYm+pQSt8KqSOk
	mCo2b4kcRTaw1Zseuw/agQXZ6TwR6cfpDrO9RLoC5BCDJN/1YCrBFvY3HdvDskmFhsUc=
X-Received: by 2002:a05:600c:1c0f:b0:456:19be:5cc with SMTP id 5b1f17b1804b1-459f4f51f9fmr1973315e9.14.1754595769787;
        Thu, 07 Aug 2025 12:42:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGo6/clDb9BEZnuq3BiNmIprNXnt5JJSKR4eR1BFzhC172fm2kELBr9Eg3I29jiJ/sow7TFFw==
X-Received: by 2002:a05:600c:1c0f:b0:456:19be:5cc with SMTP id 5b1f17b1804b1-459f4f51f9fmr1973095e9.14.1754595769330;
        Thu, 07 Aug 2025 12:42:49 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f49:bc00:12fa:1681:c754:1630? (p200300d82f49bc0012fa1681c7541630.dip0.t-ipconnect.de. [2003:d8:2f49:bc00:12fa:1681:c754:1630])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e587e154sm116116445e9.27.2025.08.07.12.42.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Aug 2025 12:42:48 -0700 (PDT)
Message-ID: <43f91e3e-84c5-4fd1-9b63-4e2cb28dab36@redhat.com>
Date: Thu, 7 Aug 2025 21:42:47 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/1] userfaultfd: fix a crash in UFFDIO_MOVE when PMD
 is a migration entry
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, peterx@redhat.com, aarcange@redhat.com,
 lokeshgidra@google.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 syzbot+b446dbe27035ef6bd6c2@syzkaller.appspotmail.com, stable@vger.kernel.org
References: <20250806220022.926763-1-surenb@google.com>
 <3eba855a-740c-4423-b2ed-24d622af29a5@redhat.com>
 <CAJuCfpExxYOtsWZo6r0FncA0TMeuhpe3SdhLbF+udtbqQ+B_Qg@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <CAJuCfpExxYOtsWZo6r0FncA0TMeuhpe3SdhLbF+udtbqQ+B_Qg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 07.08.25 17:27, Suren Baghdasaryan wrote:
> On Thu, Aug 7, 2025 at 3:31 AM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 07.08.25 00:00, Suren Baghdasaryan wrote:
>>> When UFFDIO_MOVE encounters a migration PMD entry, it proceeds with
>>> obtaining a folio and accessing it even though the entry is swp_entry_t.
>>> Add the missing check and let split_huge_pmd() handle migration entries.
>>>
>>> Fixes: adef440691ba ("userfaultfd: UFFDIO_MOVE uABI")
>>> Reported-by: syzbot+b446dbe27035ef6bd6c2@syzkaller.appspotmail.com
>>> Closes: https://lore.kernel.org/all/68794b5c.a70a0220.693ce.0050.GAE@google.com/
>>> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
>>> Reviewed-by: Peter Xu <peterx@redhat.com>
>>> Cc: stable@vger.kernel.org
>>> ---
>>> Changes since v3 [1]
>>> - Updated the title and changelog, per Peter Xu
>>> - Added Reviewed-by: per Peter Xu
>>>
>>> [1] https://lore.kernel.org/all/20250806154015.769024-1-surenb@google.com/
>>>
>>>    mm/userfaultfd.c | 17 ++++++++++-------
>>>    1 file changed, 10 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
>>> index 5431c9dd7fd7..116481606be8 100644
>>> --- a/mm/userfaultfd.c
>>> +++ b/mm/userfaultfd.c
>>> @@ -1826,13 +1826,16 @@ ssize_t move_pages(struct userfaultfd_ctx *ctx, unsigned long dst_start,
>>>                        /* Check if we can move the pmd without splitting it. */
>>>                        if (move_splits_huge_pmd(dst_addr, src_addr, src_start + len) ||
>>>                            !pmd_none(dst_pmdval)) {
>>> -                             struct folio *folio = pmd_folio(*src_pmd);
>>> -
>>> -                             if (!folio || (!is_huge_zero_folio(folio) &&
>>> -                                            !PageAnonExclusive(&folio->page))) {
>>> -                                     spin_unlock(ptl);
>>> -                                     err = -EBUSY;
>>> -                                     break;
>>> +                             /* Can be a migration entry */
>>> +                             if (pmd_present(*src_pmd)) {
>>> +                                     struct folio *folio = pmd_folio(*src_pmd);
>>> +
>>> +                                     if (!folio
>>
>>
>> How could you get !folio here? That only makes sense when calling
>> vm_normal_folio_pmd(), no?
> 
> Yes, I think you are right, this check is not needed. I can fold it
> into this fix or post a separate cleanup patch. I'm guessing a
> separate patch would be better?

I think you can just post a fixup inline here and ask Andrew to squash 
it. He will shout if he wants a completely new version :)

-- 
Cheers,

David / dhildenb


