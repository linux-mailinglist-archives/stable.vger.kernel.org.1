Return-Path: <stable+bounces-183664-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 385A3BC7B0D
	for <lists+stable@lfdr.de>; Thu, 09 Oct 2025 09:24:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD246188D194
	for <lists+stable@lfdr.de>; Thu,  9 Oct 2025 07:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DE702D061D;
	Thu,  9 Oct 2025 07:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GChpJ92O"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F567298CA4
	for <stable@vger.kernel.org>; Thu,  9 Oct 2025 07:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759994639; cv=none; b=MlP7T9FoyEk/HIuZJhX6d1hW9lqL7W5acqdkWMFIVxbUJbhUtvmIxxeR/N1K0fIUQCuzUuOCXAbEfcrtoi42gE60l7wSpTbSvEzppGXVKxSDPgJ9wwzE1zf7meVdQnIGg19nU6In1Ks3OP8yo4O1QI+J+5ccTJ5A2tXaVfGtilw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759994639; c=relaxed/simple;
	bh=qe7wmEOWrnFt1L6lrujKsVxC2MTfqabFmhgmrDs/I94=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J4rlPsGnJtZQbOkd1iEQWaBhh6XlJAoNeLKgT/pd3CkPV62mMBH3XjBeZ0QSea0nBCYkaqMdVVKEw3undYT+JuL7D84oA7l+5RZ6KNCqhFbyoeP0YHpJ0XaGlmSoiT8sSdlSNP3j+QjzJMTXCJveBb0p81NwcrCXM69vZ2+eNYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GChpJ92O; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759994636;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=eWNm9RVbxSdHs4WXMVxPHAelQ7JHZVOamF/5YzHwKUw=;
	b=GChpJ92Ofsg4efW+PyaPxKNrdSGHiUnQw+mgfZBDCw6BioBjBhMDJkWN8cPnT0xILyIn66
	BMgE2Rn27tWnOzzp0ar8Z069tb/3gUGAMzK+fBn9guUK2xDlXssn8+nrR8xw4cAvu2u1Ma
	QrpsSWSTagZEJLfg2sDm82fyW1FJbc4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-cnVVozm9Pbiq6EAgt_qb-A-1; Thu, 09 Oct 2025 03:23:54 -0400
X-MC-Unique: cnVVozm9Pbiq6EAgt_qb-A-1
X-Mimecast-MFC-AGG-ID: cnVVozm9Pbiq6EAgt_qb-A_1759994633
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3ecdc9dbc5fso371758f8f.1
        for <stable@vger.kernel.org>; Thu, 09 Oct 2025 00:23:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759994633; x=1760599433;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eWNm9RVbxSdHs4WXMVxPHAelQ7JHZVOamF/5YzHwKUw=;
        b=FenHSyOZb9sTFPM5nG63O4pIoFV9BvIJNRwfF1vU0Cb6qihBvnhVjyAsh33qhfjETM
         VSgRzZ+fDkI7mdFNifDIxs0qPkXM/oVvqwg7mCsaNpEa3nR27yY1Mjg2oDEWuq50vcaA
         rFWI+hB0OzqvTADCh8uda/vr0kbXOYPiGJz8YzRS22HK92OJjEFwbCBEz3tk97uLcSFD
         LK2JkWekC8JNfMUkijQc4eAxpAaFmJ3piYvbaTh7xHmuQ2heTmBH87gJ8neEnjQj+cc/
         gI3MBRWhFQ4uSIMfPDGGDtyBP9uLZItgpwYuzhQKf7aF/BS1hngip3IiElzcnnAp3saU
         1YFQ==
X-Forwarded-Encrypted: i=1; AJvYcCW2zxH7sQmBqh9EcOpOsZ21v16UNYM038oRLkSnhfWygae+79wGwYHAPugiBvvdTl+dfmOifFc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1pkaqZpzXu/vVvxIz8l9fYCgWJer+AuA20Yx5pG7WSrN6rxy0
	GxtyRkpUQk8qI9h0EDA/TE70Ype4zX1wJrvgSX5MMllnWVRxC7fAE8oX6OPpuX1b2KtXa7Kefsq
	95XWDSkRaa2IMTu+DaXCyuWznMB6qjqz7Oes+DYBr2IWFMNRD5ux2q8AbEw==
X-Gm-Gg: ASbGncvUGsynHZlGLG0M2j0fqMqa2uTsLVpEC8qngYLhtpEaZ1FV0kdI99o1AEjf4OW
	qUsLS+2YjUot0I7jC6ucVNT7hWfWQmwMYXLklT783THcwDtN3PIM7MG6pVpKxtswDzJz60Qc7TV
	4kuRj5HYEoFU89XGHukMbgoQJOwQcdWc11P89CPiC9qac5ZjjbBG0WZpGg5LimSNBSpB2PCfLJX
	uP4InKJLXmU0/1oOG7cIEaCjiyGhINi8qon/84b9mMkCYc5xnjGfL2+QYeSgKZ8aIN9eMs9jLsu
	ug4254va7uz4jwFOeXWW741dGh1beZfICX6+3dl5gLyR4K310ag7zbzRVp1urbjRvwTazNUzr3G
	TdZV7SPPt
X-Received: by 2002:a5d:584f:0:b0:3fe:d6df:c679 with SMTP id ffacd0b85a97d-4266e8e4563mr3738204f8f.55.1759994633417;
        Thu, 09 Oct 2025 00:23:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFuEcg4bk1Pe3uVgOdw8Gn6sWJObDLQJrWwb68mJVt1z3tdiZp/95/RumQE4BoLLosHPrY5tg==
X-Received: by 2002:a5d:584f:0:b0:3fe:d6df:c679 with SMTP id ffacd0b85a97d-4266e8e4563mr3738187f8f.55.1759994632988;
        Thu, 09 Oct 2025 00:23:52 -0700 (PDT)
Received: from [192.168.3.141] (tmo-083-189.customers.d1-online.com. [80.187.83.189])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8a6daasm33593052f8f.7.2025.10.09.00.23.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Oct 2025 00:23:52 -0700 (PDT)
Message-ID: <8a65e8c1-3028-4f9c-bf1f-c8f1d3956192@redhat.com>
Date: Thu, 9 Oct 2025 09:23:49 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Bug: Performance regression in 1013af4f585f: mm/hugetlb: fix
 huge_pmd_unshare() vs GUP-fast race
To: Prakash Sangappa <prakash.sangappa@oracle.com>
Cc: Jann Horn <jannh@google.com>, "Uschakow, Stanislav" <suschako@amazon.de>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>, "trix@redhat.com"
 <trix@redhat.com>, "ndesaulniers@google.com" <ndesaulniers@google.com>,
 "nathan@kernel.org" <nathan@kernel.org>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "muchun.song@linux.dev" <muchun.song@linux.dev>,
 "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Liam Howlett <liam.howlett@oracle.com>, "osalvador@suse.de"
 <osalvador@suse.de>, "vbabka@suse.cz" <vbabka@suse.cz>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <4d3878531c76479d9f8ca9789dc6485d@amazon.de>
 <CAG48ez2yrEtEUnG15nbK+hern0gL9W-9hTy3fVY+rdz8QBkSNA@mail.gmail.com>
 <2dcf12d0-e29c-4c9b-aeac-a0b803d2c2fd@redhat.com>
 <805DB7B5-23C2-437F-BB94-2188E310FD75@oracle.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <805DB7B5-23C2-437F-BB94-2188E310FD75@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 09.10.25 00:54, Prakash Sangappa wrote:
> 
> 
>> On Sep 1, 2025, at 4:26 AM, David Hildenbrand <david@redhat.com> wrote:
>>
>> On 01.09.25 12:58, Jann Horn wrote:
>>> Hi!
>>> On Fri, Aug 29, 2025 at 4:30 PM Uschakow, Stanislav <suschako@amazon.de> wrote:
>>>> We have observed a huge latency increase using `fork()` after ingesting the CVE-2025-38085 fix which leads to the commit `1013af4f585f: mm/hugetlb: fix huge_pmd_unshare() vs GUP-fast race`. On large machines with 1.5TB of memory with 196 cores, we identified mmapping of 1.2TB of shared memory and forking itself dozens or hundreds of times we see a increase of execution times of a factor of 4. The reproducer is at the end of the email.
>>> Yeah, every 1G virtual address range you unshare on unmap will do an
>>> extra synchronous IPI broadcast to all CPU cores, so it's not very
>>> surprising that doing this would be a bit slow on a machine with 196
>>> cores.
>>
>> What is the use case for this extreme usage of fork() in that context? Is it just something people noticed and it's suboptimal, or is this a real problem for some use cases?
> 
> Our DB team is reporting performance issues due to this change. While running TPCC,  Database
> timeouts & shuts down(crashes). This is seen when there are a large number of
> processes(thousands) involved. It is not so prominent when there are lesser number of
> processes.
> 
> Backing out this change addresses the problem.

I suspect the timeouts are due to fork() taking longer, and there is no 
kernel crash etc, right?

-- 
Cheers

David / dhildenb


