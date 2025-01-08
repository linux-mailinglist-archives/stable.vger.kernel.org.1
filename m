Return-Path: <stable+bounces-108037-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F14BFA066E1
	for <lists+stable@lfdr.de>; Wed,  8 Jan 2025 22:09:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC9F01608A5
	for <lists+stable@lfdr.de>; Wed,  8 Jan 2025 21:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B976204F7D;
	Wed,  8 Jan 2025 21:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dMzt+vbc"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2805D2040B2
	for <stable@vger.kernel.org>; Wed,  8 Jan 2025 21:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736370327; cv=none; b=pr3PrBq6yOxJm/KnCXEoykrLE/aIEkbh3Z0fhjk5V3YrfnfIgDb/q5fkoT7tYblkSbo8JeWBzGuSY8x1fdkCoJ75/vp3qpswLQotJeuTbWe3VE9aPMSlMDo6f2ZC8DkJBhMkno+rTZ8SKbjTdsk+/S5e9oTsrINoqh3Dwh8Lp18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736370327; c=relaxed/simple;
	bh=Raz49Fo5VAnvx4zpgTkW/duUtGOhYIN/NmVC51vMOOA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X3E56Lkul32s4Bjha9larNw7xO6SbJ6Ie3kE+IekrENtMQoDgq59PetUtb02KRP1sdWJlQhTQVht5vxFqrH8mnCQYyJmXDXI2U+nA14Rci4B2EVJ3ASp86WyuCEVxsJwd79iczbSEsxAurp326N9SVJtrwZ/zsdS4y/OkZ+ZSkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dMzt+vbc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736370325;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=h4I0PNtnOUgDMotr1i41d8Tf931XThjDVkaFxQw2VQg=;
	b=dMzt+vbcL8uZ+1OQu2jD2m8MGhz9tsXl5vsCHntquaV2xOJB9NGvAKLp5ZwXIdiyaKUXLW
	Z9iWgLrBZ6kQhHGBpSM4/whiaXFoY0eCKbjM6AVzYxMdVNQTf501A0Ek47LwADhxUldfeV
	kGmiynxxM9IOqLNClQwSBT/on7Q67JY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-572-OjQDI9ryNFCgGRhqvuxVAQ-1; Wed, 08 Jan 2025 16:05:23 -0500
X-MC-Unique: OjQDI9ryNFCgGRhqvuxVAQ-1
X-Mimecast-MFC-AGG-ID: OjQDI9ryNFCgGRhqvuxVAQ
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43624b08181so978795e9.0
        for <stable@vger.kernel.org>; Wed, 08 Jan 2025 13:05:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736370322; x=1736975122;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=h4I0PNtnOUgDMotr1i41d8Tf931XThjDVkaFxQw2VQg=;
        b=mCdHc4BIsMBZjEGMWmkf0oBpCN5DARyl9JGx/tmaHY3spmHKIue9A0od8KkMPUVthf
         kQbDlwHzf8EsfrdYJ9kiMEYH7iFrSoN/W6fZc7MYsfsKcjhotTQrE1qHNu+b+EbgcKlV
         rJ9SG47TjCB3fjAuTH1zubzG++F0TTHqsSKqXw9A8CPqJeXO30H6QcX22zzwxuN4iYoH
         fRDSGTjFzlo65TZ8V0WE6YKSf8QKAbtdOxToNeEs0i3m5p9MmNgoMk6/p6+g9qaQPBxG
         /kVRAX7CYViUe6vI87xAvr0OfYG8ILrC3PSww7p0coLRSSweRVtoaWQ514kTDQely9p3
         CUnw==
X-Forwarded-Encrypted: i=1; AJvYcCW4tHyjuJGgVakdccIteS+jRKbYk862gocFzMpf+ZamKJ2Ich4G8B/VUa5KpVRAPPSbatn4tcU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZoGWjb7QZ58QbPQwC6aTgDAhe5V8U0PITnd9b4ukpXXhyfTX/
	ddu1507JJ0/qlolXiQ9aQ6cf0nM7e/JnDG+Ncw6qfidtEJhhOnt9GVzXkzLkuDlEukLQH4L0f4A
	z6LbHsq/SNdnt31qE4ox4e3AETBC10qH/BrDbdYsk2yBpiVOpJlBASw==
X-Gm-Gg: ASbGnctFxpitBgIZslEvB3AcC4Gd2VPXXFaoFZy9qcFItI6TjUdF2Sa8lCxR7CW5e0W
	iBEdk3Nxgpbm309TF58UwvyDo1yqNVuEckAljm7pJJirqtht4dzB3ZXaL9z+sHa4B7TLzuvwvOy
	vw1vX7AM58IGeRB/YY8+XR/46iQKMQNsWtXKperpkLk5UYt15grzyb3roNpjoQyvMc4gcCe7Xdh
	AH03LewL8JN2ijZ4YvNRVFGENjvyINNBVd/KXOB2+E9o6Hs6h9V6tbv9bVM1t+6/wKPSWh/LDWR
	dHot1z+S1lCvOpVj7qLPRwuvi7QmJhV8CPVRXIgZ83Nv+MoSwWc63a/rBhe4FNFv6ym8BmwN3F8
	TwOydaQ==
X-Received: by 2002:a7b:c5cb:0:b0:434:ffb2:f9cf with SMTP id 5b1f17b1804b1-436e883c091mr6735395e9.14.1736370322144;
        Wed, 08 Jan 2025 13:05:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHIwp3X0Bhq73aFRylg0Uw3bZY3PG5lXDQl2uIJujsYoN115Ss6zK5awOBbJ1u9Ueagl93VQw==
X-Received: by 2002:a7b:c5cb:0:b0:434:ffb2:f9cf with SMTP id 5b1f17b1804b1-436e883c091mr6735225e9.14.1736370321854;
        Wed, 08 Jan 2025 13:05:21 -0800 (PST)
Received: from ?IPV6:2003:cb:c70d:3a00:d73c:6a8:ca9f:1df7? (p200300cbc70d3a00d73c06a8ca9f1df7.dip0.t-ipconnect.de. [2003:cb:c70d:3a00:d73c:6a8:ca9f:1df7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e2e1eb34sm32630455e9.35.2025.01.08.13.05.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jan 2025 13:05:20 -0800 (PST)
Message-ID: <fc1241a6-6760-4f73-840d-4f3a538644aa@redhat.com>
Date: Wed, 8 Jan 2025 22:05:18 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] replace free hugepage folios after migration
To: Ge Yang <yangge1116@126.com>, akpm@linux-foundation.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 21cnbao@gmail.com, baolin.wang@linux.alibaba.com, muchun.song@linux.dev,
 liuzixing@hygon.cn
References: <1734503588-16254-1-git-send-email-yangge1116@126.com>
 <0ca35fe5-9799-4518-9fb1-701c88501a8d@redhat.com>
 <d6d92a36-4ed7-4ae8-8b74-48f79a502a36@126.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <d6d92a36-4ed7-4ae8-8b74-48f79a502a36@126.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Sorry for the late reply, holidays ...

>> Did you ever try allocating a larger range with a single
>> alloc_contig_range() call, that possibly has to migrate multiple hugetlb
>> folios in one go (and maybe just allocates one of the just-freed hugetlb
>> folios as migration target)?
>>
> 
> I have tried using a single alloc_contig_range() call to allocate a
> larger contiguous range, and it works properly. This is because during
> the period between __alloc_contig_migrate_range() and
> isolate_freepages_range(), no one allocates a hugetlb folio from the
> free hugetlb pool.

Did you trigger the following as well?

alloc_contig_range() that covers multiple in-use hugetlb pages, like

[ huge 0 ] [ huge 1 ] [ huge 2 ] [ huge 3 ]

I assume the following happens:

To migrate huge 0, we have to allocate a fresh page from the buddy. 
After migration, we return now-free huge 0 to the pool.

To migrate huge 1, we can just grab now-free huge 0 from the pool, and 
not allocate a fresh one from the buddy.

At least that's my impression when reading 
alloc_migration_target()->alloc_hugetlb_folio_nodemask().

Or is for some reason available_huge_pages()==false and we always end up 
in alloc_migrate_hugetlb_folio()->alloc_fresh_hugetlb_folio()?

Sorry for the stupid questions, the code is complicated, and I cannot 
see how this would work.

-- 
Cheers,

David / dhildenb


