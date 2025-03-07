Return-Path: <stable+bounces-121426-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7981AA56F77
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 18:45:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C576A7AB43A
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 17:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44A9E23FC68;
	Fri,  7 Mar 2025 17:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EzKNOtGh"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3524623E355
	for <stable@vger.kernel.org>; Fri,  7 Mar 2025 17:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741369423; cv=none; b=tY8PN61y6KMc7BTiXJQgoSR5K5ibtctcymWuRC6ZeZdnWu+u7u+oyA9XF1m+xFpuR5oX2mxevQLY1+weypJH3QYVBpbDQ3yNVPfN/CIRi+ra3EM+YZtFodyFJsKN8GtPo22CkM5Uc0iKWJHh+heOUzI0bE8HW9Q/KJXv0URZR9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741369423; c=relaxed/simple;
	bh=60vohEiMEApZR4nLnfno/LrXHhbOoJAKQwBR7WhFeDE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sZwi10LOj4HodC2HKROo8vQ0UDTuHXZCPdn5lhL5P0x8WZA7K7fkx6QbX9+dZX7WRBu+iJ8NKAahDPeB0xLSc3Pms9R079hJJIYu459+vu/rxp4KUF7lfef666lL9AdVr+/gaC4zKA+Uc55HPEhHWAGKGbP8DtMvehB850J+NlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EzKNOtGh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741369420;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ssD53hVxTYei45HA/qWDyDYoSrpwLT2aETtzN0PpbiY=;
	b=EzKNOtGhG3hQl+hwoAeLktUASD291KVKMF0kFMe5IyDwmphV9if6dqPaValQhEWHSJIAV1
	HDMgLqSoAJH0ZNlIi4m75Bc7/qmy98Tj6bVotokl/LQxxAXmyFhHznvZbLzUCQlLYgpLCN
	XpBJiqJ+0C6HQSC+iAImmED5Tbks0c8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-c2nxgk1yOiamOrnxl5GGBg-1; Fri, 07 Mar 2025 12:43:38 -0500
X-MC-Unique: c2nxgk1yOiamOrnxl5GGBg-1
X-Mimecast-MFC-AGG-ID: c2nxgk1yOiamOrnxl5GGBg_1741369418
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3912fc9861cso767977f8f.1
        for <stable@vger.kernel.org>; Fri, 07 Mar 2025 09:43:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741369418; x=1741974218;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ssD53hVxTYei45HA/qWDyDYoSrpwLT2aETtzN0PpbiY=;
        b=A6CZCVbY6omRlNHZlKsuNK8BXg0Rf/fYWKorzmgbaR0MNTunbyWQ47cHRx+gktHDA4
         1uecXuadhea+hGJblmCAquROZBnBuSDHyFt1ovWQi5TgqY8iNOIG001ORFQkW+0dHsQz
         58X0jSqyE27u6QrHhiQf//FaXNvKhHaOCN/hb+80gkkARfDjDJ7sZ3cIb2u0p1rYy1aF
         iOZ33gHbfr0UqlDtRiA9PGQBa1ZL/7i/GsW27962nQLVmHi9ERuCLPQuNGDS40Bpzk0k
         2QuuRjTNGxTffqeS8fSGp/I0Ceo2I1b1jbkrakbfjbcDusM/pfzE8a8LnHr6FNhQof5y
         oWcQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUwPvA/zw2GpExzr/XYgk9HwiWxOHIV5ZM1e4WBCNcRs5I2xVSE0JV+fz/WdXsyyofFE10MhY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9H3zgZEJIjfvE812vSMvCetpJSBfGGP6yHQucDa+mBwhjvQK2
	MUgadeWY8ipkSjJm+qhAj34C6oYuOmtVrpr3Lkomx4V/lBSj0Dguj2tNo7kK9FHZDKSyvBYsICP
	iEbtIeR+0PbWXuthAqqNZ33nPIfJmjyUCW06O/59Xh1CCY9h4P8KzaQ==
X-Gm-Gg: ASbGncv1T8bHIe2/DWcU7zXCjm4NUSMkygw0TXQ6LAr9n4CLxqPgQqkz3aGRAtYWfMm
	dTsK9En6Tpa/Weji+qMIdxjCIs706FAajWBxNlA/74Wva6mDKj+YIBMTDg7sOrClL4q5KnHduUc
	XWDOiwc3k+L5zdvE+qOf9jyU4bbmaU4cNwB16ofwslTXqZmk5uhxCFe1P7r22S9CANS2LuTE2HA
	/a5u0mp+x6U5NxRFDBt1s22mCsM8+jkWTHJKxDGCd4r4M5wVYKbs6CfnF1tMyWdBm5ERGs9pTzX
	qIczPmCf7lQVM0ZUTt9+ojG8Iae2IH0oXFuL/Jcx/4JJNhKtM6Rwr+/HTc3LFV9UZn9b9THxZac
	9Ce50kLKRQR4et74eUZ/exzBz+5akKdAOQWhrgw==
X-Received: by 2002:a05:6000:18a3:b0:391:2e19:9ab with SMTP id ffacd0b85a97d-39132da8e5dmr2428197f8f.47.1741369417615;
        Fri, 07 Mar 2025 09:43:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGltnvAubGl1bA54vpc9cRsNvD8yx49qAt0cTcAw9YyB1BLXfs2F8swCZL5LZ0PFPmKZTZsHg==
X-Received: by 2002:a05:6000:18a3:b0:391:2e19:9ab with SMTP id ffacd0b85a97d-39132da8e5dmr2428184f8f.47.1741369417165;
        Fri, 07 Mar 2025 09:43:37 -0800 (PST)
Received: from ?IPV6:2003:cb:c721:7400:ab0b:9ceb:d2:6a17? (p200300cbc7217400ab0b9ceb00d26a17.dip0.t-ipconnect.de. [2003:cb:c721:7400:ab0b:9ceb:d2:6a17])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912bfdfddcsm6079481f8f.35.2025.03.07.09.43.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Mar 2025 09:43:35 -0800 (PST)
Message-ID: <ba694acd-07b7-4f28-828a-19bf4c803ca0@redhat.com>
Date: Fri, 7 Mar 2025 18:43:35 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] mm/madvise: Always set ptes via arch helpers
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Ryan Roberts <ryan.roberts@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Oscar Salvador <osalvador@suse.de>
References: <20250307123307.262298-1-ryan.roberts@arm.com>
 <dbdeb4d7-f7b9-4b10-ada3-c2d37e915f6d@lucifer.local>
 <03997253-0717-4ecb-8ac8-4a7ba49481a3@arm.com>
 <3653c47f-f21a-493e-bcc4-956b99b6c501@lucifer.local>
 <2308a4d0-273e-4cf8-9c9f-3008c42b6d18@arm.com>
 <d9cd67d7-f322-4131-a080-f7db9bf0f1fc@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <d9cd67d7-f322-4131-a080-f7db9bf0f1fc@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>> It's certainly not read-only in general. Just having a quick look to verify, the
>> very first callback I landed on was clear_refs_pte_range(), which implements
>> .pmd_entry to clear the softdirty and access flags from a leaf pmd or from all
>> the child ptes.
> 
> Yup sorry I misspoke, working some long hours atm so forgive me :) what I meant
> to say is that we either read or modify existing.
> 
> And yes users do do potentially crazy things and yada yada.
> 
> David and I have spoken quite a few times about implementing generic page
> table code that could help abstract a lot of things, and it feels like this
> logic could all be rejigged in some fashion as to prevent the kind of
> 'everybody does their own handler' logic.q

Oscar is currently prototyping a new pt walker that will batch entries 
(e.g., folio ranges, pte none ares), and not use indirect calls. The 
primary focus will will read-traversal, but nothing speaks against 
modifications (likely helpers for installing pte_none()->marker could be 
handy, and just creating page tables if we hit pmd_none() etc.).

Not sure yet how many use cases we can cover with the initial approach. 
But the idea is to start with something that works for many cases, to 
then gradually improve it.


> 
> I guess I felt it was more _dangerous_ as you are establishing _new_
> mappings here, with the page tables being constructed for you up to the PTE
> level.
> 
> And wanted to 'lock things down' somewhat.
> 
> But indeed, all this cries out for a need for a more generalised, robust
> interface that handles some of what the downstream users of this are doing.
> 
>>
>>>
>>> When setting things are a little different, I'd rather not open up things to a
>>> user being able to do *whatever*, but rather limit to the smallest scope
>>> possible for installing the PTE.
>>
>> Understandable, but personally I think it will lead to potential misunderstandings:
>>
>>   - it will get copy/pasted as an example of how to set a pte (which is wrong;
>> you have to use set_pte_at()/set_ptes()). There is currently only a single other
>> case of direct dereferencing a pte to set it (in write_protect_page()).
> 
> Yeah, at least renaming the param could help, as 'ptep' implies you really
> do have a pointer to the page table entry.
> 
> If we didn't return an error we could just return the PTE value or
> something... hm.
> 
>>
>>   - new users of .install_pte may assume (like I did) that the passed in ptep is
>> pointing to the pgtable and they will manipulate it with arch helpers. arm64
>> arch helpers all assume they are only ever passed pointers into pgtable memory.
>> It will end horribly if that is not the case.
> 
> It will end very horribly indeed :P or perhaps with more of a fizzle than
> anticipated...

Yes, I'm hoping we can avoid new users with the old api ... :)

> 
>>
>>>
>>> And also of course, it allows us to _mandate_ that set_pte_at() is used so we do
>>> the right thing re: arches :)
>>>
>>> I could have named the parameter better though, in guard_install_pte_entry()
>>> would be better to have called it 'new_pte' or something.
>>
>> I'd suggest at least describing this in the documentation in pagewalk.h. Or
>> better yet, you could make the pte the return value for the function. Then it is
>> clear because you have no pointer. You'd lose the error code but the only user
>> of this currently can't fail anyway.
> 
> Haha and here you make the same point I did above... great minds :)
> 
> I mean yeah returning a pte would make it clearer what you're doing, but
> then it makes it different from every other callback... but this already is
> different :)
> 
> I do very much want the ability to return an error value to stop the walk
> (if you return >0 you can indicate to caller that a non-error stop occurred
> for instance, something I use on the reading side).
> 
> But we do need to improve this one way or another, at the very least the
> documentation/comments.
> 
> David - any thoughts?

Maybe document "don't use this until we have something better" :D


> 
> I'm not necessarily against just making this consitent, but I like this
> property of us controlling what happens instead of just giving a pointer
> into the page table - the principle of exposing the least possible.
> 
> ANWYAY, I will add to my ever expanding whiteboard TODO list [literally the
> only todo that work for me] to look at this, will definitely improve docs
> at very least.

Maybe we can talk at LSF/MM about this. I assume Oscar might be 
partially covering that in his hugetlb talk.

-- 
Cheers,

David / dhildenb


