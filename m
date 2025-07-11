Return-Path: <stable+bounces-161671-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60BC6B02198
	for <lists+stable@lfdr.de>; Fri, 11 Jul 2025 18:21:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7635F1CC27F1
	for <lists+stable@lfdr.de>; Fri, 11 Jul 2025 16:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6DBB2F2737;
	Fri, 11 Jul 2025 16:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hJOzn7fF"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A902F0C72
	for <stable@vger.kernel.org>; Fri, 11 Jul 2025 16:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752250733; cv=none; b=jjQVnHQbPcX0aYG5ignH03jWcYAylNhUiqLHhiV2seSbe+bG/xFcjz/EmGrvVfhBdT2Y64hBXufMQ6QU4kWfUCQL8lj8qKqlq7NzduTVlWYT3NvcNIBUHgrpCsh+cao1OAS5DcY3/PfcQ0hHd0vqHaRmlMJnbPBuZZgqqaeWOR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752250733; c=relaxed/simple;
	bh=RmuyxikP3jhhp0nnQevk5CM+a6W6OZAcoIpkbcZxKzc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=agimS72G2i/4n+m8siEA97C4DIs0kfyVNAajIUmlc6ZdUiOiVKSXGREi87qCPmfze5aKhvm6JHftn4fXrTFBrkMchuoLGFfLs9Pyxgo+iXJFkHGY+dyOuViL2tg6LCSoWT7YRDlc4K9CyO+saMOkORS8SKI6j2EzgJkKEVH2CzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hJOzn7fF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752250730;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Nn/tyjLuDZQnek6uqzyr2XAecXIQlMAuAiSgJfPbL7U=;
	b=hJOzn7fFCTMVb+XLE9nsh9OqivmbyrTCa4fIAcgpdrYb/Tgt8ggYJaI9jzEn+aK1w1w3fl
	dGBt4jMxho2ks0L9zbBbhmAG4x76SQL8hJq9rKeS0FqB4AemShd2ZHZOGO0oT1WKmyZfek
	Sa/QbFb4uDu8EOULmt+eJ/iSuFKMLtY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-Knxn6mFLOLORWLslBDR1ag-1; Fri, 11 Jul 2025 12:18:48 -0400
X-MC-Unique: Knxn6mFLOLORWLslBDR1ag-1
X-Mimecast-MFC-AGG-ID: Knxn6mFLOLORWLslBDR1ag_1752250727
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-450d244bfabso18848565e9.0
        for <stable@vger.kernel.org>; Fri, 11 Jul 2025 09:18:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752250727; x=1752855527;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Nn/tyjLuDZQnek6uqzyr2XAecXIQlMAuAiSgJfPbL7U=;
        b=mqFOIkHF7HOa6st8jTT1Z2SJdTTS8KFcrHav1fqNCOTo41VPdBuMCFYOFmjv3jOPor
         5JgMFt94m/la6nsMZnOenQ+xPjq2dkZMrSW15Tl01lAz98IYXGoMKprQTPeELnh9roQK
         Uizd8BlNWMyTWGN8szDUhARezaZ/Cl5gKd2z/CpbK0srKmfZ/VpZPbk/ChZO7P9/DJ/w
         63XrvvMDruKLHO4M53HnspOCUs2WFZ61Gd/4UszBG/5Bw/EmPPFLY7W0UYGixE3to3c9
         45dRMmLto57KJYodRLcZTbbPUC4VIL3c5TXAjO/z/35o9cGCe9DH1ZJpVFDXhCoUwuzK
         G/0g==
X-Forwarded-Encrypted: i=1; AJvYcCXegULgxKFANZ8WBCn5k+BpLKb+otcss3Ts0Gd+4SxG0+n6Cr/Mvf7f5XZ48bntW1dCtO8Olew=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIiT4ixsH4MtGJHegd3TK2sEwQej6KycI9JvSwshOaJV+/m3pH
	KqvChr+oMQFzNZKrS/SsG1FnTHCBVYBtO+Bbov74mUmyCzMMq5RPAP0WBG0doeUDb+dO3pbsSTR
	QWYcZHI+RCopRlyBiHhbuj5goI6zBiBjPRa8pQkyrWMWxfZCjqoZGXrhFhg==
X-Gm-Gg: ASbGncsBaz2IKKKVDSnN07EzRCl/jB77WShPM8QWr8kuD+gSLrjaTBs/wvIymPV/d7I
	NW6njfUMl/33cmPXqCsfYzE3rHiYBrdL63NM6JV6TQAQ2kIQ6vKJBMkdwL4CK+SG4tfxjW4XOW/
	OFd6AlLEDCmqXldwNZwvGOiJN+DE/MFAn0ezS0CFUq0AsmBTPvEYPB9yK8T8NiRl6ef8WTVybuM
	jaz64GBNv5/a9uglWM/GP8NDe1/bTcGFlOyZd1PmD4QU8tuDCwdUBiaYCagJ3os6DhIqq0fYPrw
	9G68EbS9ZcZgPSPE7RqJRNxlCjdZGhMmwTeEP6yTqJ47x3FQxEXUNQGCVNvINm4+eoOycrdfudF
	PwfaOBv+5TH2hk+gAYyRqHeFnq2PkGet7qFK7zeZh/VYiTU1wl69FsrEfCejIJ/DZyNI=
X-Received: by 2002:a05:6000:1acb:b0:3a4:ef36:1f4d with SMTP id ffacd0b85a97d-3b5f2dfe068mr3165949f8f.38.1752250727311;
        Fri, 11 Jul 2025 09:18:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFNEjxN0hZ8U7KjaRWXdNv8tLd+TjKw2qwDu6OkeGx6IP2NJytzdTy4QA+AXWSLgx0V7mfpjQ==
X-Received: by 2002:a05:6000:1acb:b0:3a4:ef36:1f4d with SMTP id ffacd0b85a97d-3b5f2dfe068mr3165906f8f.38.1752250726806;
        Fri, 11 Jul 2025 09:18:46 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f3c:3a00:5662:26b3:3e5d:438e? (p200300d82f3c3a00566226b33e5d438e.dip0.t-ipconnect.de. [2003:d8:2f3c:3a00:5662:26b3:3e5d:438e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e0d732sm4957680f8f.52.2025.07.11.09.18.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jul 2025 09:18:46 -0700 (PDT)
Message-ID: <02146c79-a4de-430f-8357-0608e796fa60@redhat.com>
Date: Fri, 11 Jul 2025 18:18:44 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC V1 PATCH mm-hotfixes 1/3] mm: introduce and use
 {pgd,p4d}_populate_kernel()
To: Harry Yoo <harry.yoo@oracle.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski
 <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Andrey Ryabinin <ryabinin.a.a@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
 Andrew Morton <akpm@linux-foundation.org>, Dennis Zhou <dennis@kernel.org>,
 Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@gentwo.org>
Cc: "H . Peter Anvin" <hpa@zytor.com>, Alexander Potapenko
 <glider@google.com>, Andrey Konovalov <andreyknvl@gmail.com>,
 Dmitry Vyukov <dvyukov@google.com>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>,
 Juergen Gross <jgross@suse.com>, Kevin Brodsky <kevin.brodsky@arm.com>,
 Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
 Joao Martins <joao.m.martins@oracle.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Jane Chu
 <jane.chu@oracle.com>, Alistair Popple <apopple@nvidia.com>,
 Mike Rapoport <rppt@kernel.org>, Gwan-gyeong Mun
 <gwan-gyeong.mun@intel.com>, "Aneesh Kumar K . V"
 <aneesh.kumar@linux.ibm.com>, x86@kernel.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-mm@kvack.org, stable@vger.kernel.org
References: <20250709131657.5660-1-harry.yoo@oracle.com>
 <20250709131657.5660-2-harry.yoo@oracle.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250709131657.5660-2-harry.yoo@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09.07.25 15:16, Harry Yoo wrote:
> Intrdocue and use {pgd,p4d}_pouplate_kernel() in core MM code when
> populating PGD and P4D entries corresponding to the kernel address
> space. The main purpose of these helpers is to ensure synchronization of
> the kernel portion of the top-level page tables whenever such an entry
> is populated.
> 
> Until now, the kernel has relied on each architecture to handle
> synchronization of top-level page tables in an ad-hoc manner.
> For example, see commit 9b861528a801 ("x86-64, mem: Update all PGDs for
> direct mapping and vmemmap mapping changes").
> 
> However, this approach has proven fragile, as it's easy to forget to
> perform the necessary synchronization when introducing new changes.
> 
> To address this, introduce _kernel() varients of the page table

s/varients/variants/

> population helpers that invoke architecture-specific hooks to properly
> synchronize the page tables.

I was expecting to see the sync be done in common code -- such that it 
cannot be missed :)

But it's really just rerouting to the arch code where the sync can be 
done, correct?

-- 
Cheers,

David / dhildenb


