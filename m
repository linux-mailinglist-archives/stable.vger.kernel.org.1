Return-Path: <stable+bounces-183665-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 516E5BC7BD6
	for <lists+stable@lfdr.de>; Thu, 09 Oct 2025 09:40:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05CA53A68CF
	for <lists+stable@lfdr.de>; Thu,  9 Oct 2025 07:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ECD3265CA8;
	Thu,  9 Oct 2025 07:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lei51xPd"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DAE41DED52
	for <stable@vger.kernel.org>; Thu,  9 Oct 2025 07:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759995645; cv=none; b=iu2M8ELFtHLHA549jH/f+D0wUGpd6sSMYz349ozvdB4eLCeRoURQgtRkCt0Xmac+klXKsy41t3OSF+9gTz9hNhb4gYAAUh8a9h8CwlmbVhcbG5n88AuDvILO7/lqMHCMSQaZWbQxVM5d3cMS75Cf65K8ONN7G+Lk9wgsnINvZOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759995645; c=relaxed/simple;
	bh=FbRvNRG53mvcxQHobPkffQk9qMLOOwloJQhAz6nxH2o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tsN7+FUu5q60zPN9MXnRLcirw3wyMO1GNM9ddk0BBEQda9YH8ziDzL44SJQNNjWl+mT0++iCb+e4iPCKzDb5ws4GqeujptOl7R++dSKrTbFiFTlLediabPxHr/N2Z/wpvGrhnIPzJU9mkxnuVWDg5vCJzG7pjxny0HNBWyruDrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Lei51xPd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759995642;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=4T6bYmZE+LO9vR1ksJGNOmn5mFmrEK+ilv0kzm2Rmso=;
	b=Lei51xPdfCntzMWMwlvgntAuCqogywAvtSnH3ILB2rhIo+o/RV4rlS+4TYyHeNwT+g4g7g
	JjA4iYcLGbM7PIE6jZJKEtSVXwRJdPsmtWqrbwOazpnggEvAtKOtrLmxczkJaj9m7AN39x
	EcWHPkoF5kgQjj2FGVg/1rrA8krRpK4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-533-aWvo8u45PE6c6fjKrjhG3A-1; Thu, 09 Oct 2025 03:40:41 -0400
X-MC-Unique: aWvo8u45PE6c6fjKrjhG3A-1
X-Mimecast-MFC-AGG-ID: aWvo8u45PE6c6fjKrjhG3A_1759995640
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3ecdc9dbc5fso383144f8f.1
        for <stable@vger.kernel.org>; Thu, 09 Oct 2025 00:40:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759995640; x=1760600440;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4T6bYmZE+LO9vR1ksJGNOmn5mFmrEK+ilv0kzm2Rmso=;
        b=bEVfDmBwX1A53AKUZCucQUH9n3rPuINBBCVapCaPrIQa67dx1f9MkZBCfP12Y+Cvuy
         9ZzcWWi1VkFjRbG55NQab7FKv3kOXWHIW3+cE7HSQSdzJFF4v2Tp0vBGZZT8/Xh3nbV0
         7cZbG9h/45lWsn5ENAR7mYzsx/i4F4YPgOIPJL+f4ItpCWqrUg851yKUK8j4gNVFggae
         uliqaJYyNWBhWH89e7Yg458X/eEkTO5NpUkwsuKMgraGfRqe5KsV1wMsacfUjL+PFh8o
         o/4USvQQdyPuBOHVMOypngZ8Tm/SawlV74J+GsBtnQEE7/7yP55yD1v5sDNJawVbY+tC
         JwkQ==
X-Forwarded-Encrypted: i=1; AJvYcCXfzDqkLd8wvZZZ0FLfwPWrYjkuiJT5fOZXORlD+r6oGXTkjJyxAfEnvLG7HjCiqAEVRSb4HCk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo9l/38GKJk/ylKQ1kaZ4nGAgULnS96r64x7GPw03yrTlYNwcH
	ja6dvugHFxTChAAJwO/t93gr9quyH/VaNSBfn1y83OBLDPnXaJn2tRl8dSUhRxPWBsBk/FuC4M5
	kwAtp0e+E/+kFSH5Aj6Wwv5U2moGiAVAe6FvKMv+nd52Ok+QShPGyat+jDQ==
X-Gm-Gg: ASbGncuYvsd75HZaKrP3jLaSTYqfnMZpOYItLRPar6L21n5cqHQHwIKQIoMmeKu8Dzn
	i00Sl3RrikkA/GnVs6VeDx0k/OZn+YxKy89rzOBB2nzQm0oN2Dp8ml038NmyH5Ub8eI/G1mt6R0
	YoBx/Wk4abTS4I7Jg00Og6BvZ/0qrOhju5GmwHBlv4ixTc57FuZqTZafHoDqWh/EyeKb33t1hDX
	R9ySmPDsgpDclhBjxM5xWUzpRdSJECiLK0yzillOxvRT5hNwv38AEoNCZZcmQNWtMGgXV5nKsJd
	RxPTDwD1fcjgibpzmMZbkTM4EFNyO8vdT9Y76iNToU8K9IhXpG1rWYf87t9OvV2pvqi+xXtCQx0
	wS51DUXPj
X-Received: by 2002:a05:6000:607:b0:425:72a0:a981 with SMTP id ffacd0b85a97d-42666abb02bmr3831518f8f.2.1759995639884;
        Thu, 09 Oct 2025 00:40:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWMrszMDlMbAC3kv3AzOArS5/qJRRP5l/pf0umDvfvnlRGQEsSMcDv4DZOlUxZZACt2Yd3Vg==
X-Received: by 2002:a05:6000:607:b0:425:72a0:a981 with SMTP id ffacd0b85a97d-42666abb02bmr3831503f8f.2.1759995639459;
        Thu, 09 Oct 2025 00:40:39 -0700 (PDT)
Received: from [192.168.3.141] (tmo-083-189.customers.d1-online.com. [80.187.83.189])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8e96e0sm33332407f8f.33.2025.10.09.00.40.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Oct 2025 00:40:38 -0700 (PDT)
Message-ID: <c7fc5bd8-a738-4ad4-9c79-57e88e080b93@redhat.com>
Date: Thu, 9 Oct 2025 09:40:34 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Bug: Performance regression in 1013af4f585f: mm/hugetlb: fix
 huge_pmd_unshare() vs GUP-fast race
To: Jann Horn <jannh@google.com>, "Uschakow, Stanislav" <suschako@amazon.de>
Cc: "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "trix@redhat.com" <trix@redhat.com>,
 "ndesaulniers@google.com" <ndesaulniers@google.com>,
 "nathan@kernel.org" <nathan@kernel.org>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "muchun.song@linux.dev" <muchun.song@linux.dev>,
 "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
 "lorenzo.stoakes@oracle.com" <lorenzo.stoakes@oracle.com>,
 "liam.howlett@oracle.com" <liam.howlett@oracle.com>,
 "osalvador@suse.de" <osalvador@suse.de>, "vbabka@suse.cz" <vbabka@suse.cz>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <4d3878531c76479d9f8ca9789dc6485d@amazon.de>
 <CAG48ez2yrEtEUnG15nbK+hern0gL9W-9hTy3fVY+rdz8QBkSNA@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <CAG48ez2yrEtEUnG15nbK+hern0gL9W-9hTy3fVY+rdz8QBkSNA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 01.09.25 12:58, Jann Horn wrote:
> Hi!
> 
> On Fri, Aug 29, 2025 at 4:30 PM Uschakow, Stanislav <suschako@amazon.de> wrote:
>> We have observed a huge latency increase using `fork()` after ingesting the CVE-2025-38085 fix which leads to the commit `1013af4f585f: mm/hugetlb: fix huge_pmd_unshare() vs GUP-fast race`. On large machines with 1.5TB of memory with 196 cores, we identified mmapping of 1.2TB of shared memory and forking itself dozens or hundreds of times we see a increase of execution times of a factor of 4. The reproducer is at the end of the email.
> 
> Yeah, every 1G virtual address range you unshare on unmap will do an
> extra synchronous IPI broadcast to all CPU cores, so it's not very
> surprising that doing this would be a bit slow on a machine with 196
> cores.
> 
>> My observation/assumption is:
>>
>> each child touches 100 random pages and despawns
>> on each despawn `huge_pmd_unshare()` is called
>> each call to `huge_pmd_unshare()` syncrhonizes all threads using `tlb_remove_table_sync_one()` leading to the regression
> 
> Yeah, makes sense that that'd be slow.
> 
> There are probably several ways this could be optimized - like maybe
> changing tlb_remove_table_sync_one() to rely on the MM's cpumask
> (though that would require thinking about whether this interacts with
> remote MM access somehow), or batching the refcount drops for hugetlb
> shared page tables through something like struct mmu_gather, or doing
> something special for the unmap path, or changing the semantics of
> hugetlb page tables such that they can never turn into normal page
> tables again. However, I'm not planning to work on optimizing this.

I'm currently looking at the fix and what sticks out is "Fix it with an 
explicit broadcast IPI through tlb_remove_table_sync_one()".

(I don't understand how the page table can be used for "normal, 
non-hugetlb". I could only see how it is used for the remaining user for 
hugetlb stuff, but that's different question)

How does the fix work when an architecture does not issue IPIs for TLB 
shootdown? To handle gup-fast on these architectures, we use RCU.

So I'm wondering whether we use RCU somehow.

But note that in gup_fast_pte_range(), we are validating whether the PMD 
changed:

if (unlikely(pmd_val(pmd) != pmd_val(*pmdp)) ||
     unlikely(pte_val(pte) != pte_val(ptep_get(ptep)))) {
	gup_put_folio(folio, 1, flags);
	goto pte_unmap;
}


So in case the page table got reused in the meantime, we should just 
back off and be fine, right?

-- 
Cheers

David / dhildenb


