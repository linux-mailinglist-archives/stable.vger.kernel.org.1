Return-Path: <stable+bounces-176836-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A6634B3E180
	for <lists+stable@lfdr.de>; Mon,  1 Sep 2025 13:27:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8423A7AE4E9
	for <lists+stable@lfdr.de>; Mon,  1 Sep 2025 11:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42500317718;
	Mon,  1 Sep 2025 11:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TGy4bM5v"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863EF3176EB
	for <stable@vger.kernel.org>; Mon,  1 Sep 2025 11:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756725988; cv=none; b=krFYjkIxuSiRd/Zt71nwZrMybf0LTXC1Hb84mlzX/8mtIcKJLk1NrFklbJjHScmOde34IdYe5a5w500OvRP7DZiRohrhyGs1AWaKb/s1fuj+Cusq+8klgfJqnwrNU5JX90tB1GDc6AT7ofquMQKmYinxmCG5uEyjeFW65TlGiFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756725988; c=relaxed/simple;
	bh=/NWv3c04DS16F/w0PY4X5U5b60Dai9t+dLQYZKVHL2I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nnOey540938XWwlJiwTVrx9c/5Kll/P4n26ff53Kckw0btA2xQSqB4CXT8r/nzdZ03ctAmZWIYGzz1FNOVwIRgpdM1VkQXnXbvkHQ6PNVBPtPtxHr1m1jk225oKnM1yVW7Qltl8hDqoZgZ5damdtGHlwYjJ6ADGmQgLR8bYswJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TGy4bM5v; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756725985;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=+0iUXkssVvvwl4l+6dfL0IIQ3dvJMYipttZeZiZiVu4=;
	b=TGy4bM5vutP5VtuADgZjb8UhY+YD9+pg5K/Q8x4Bd7ubGELGk/Sy2JJCDGYa+3NLqOpa99
	ADwiY59UeMTiISyYjzxf0QFmJT33VxKoDt1gzZJcQfNdiuVEodgDaFx62vtWFag6OEBkUL
	LQ4aJ8q/FTgJTrWGZtF2chD3aBR3Iyw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-99-P07W-rpiMUWUvRFz7CLNFw-1; Mon, 01 Sep 2025 07:26:24 -0400
X-MC-Unique: P07W-rpiMUWUvRFz7CLNFw-1
X-Mimecast-MFC-AGG-ID: P07W-rpiMUWUvRFz7CLNFw_1756725983
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45b7d497abbso25284825e9.0
        for <stable@vger.kernel.org>; Mon, 01 Sep 2025 04:26:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756725983; x=1757330783;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+0iUXkssVvvwl4l+6dfL0IIQ3dvJMYipttZeZiZiVu4=;
        b=kiRtcJxNdZVmHYdPxotyYEBNQu0n+HQUkwmDXPAMUq5fsn2cojhY8O5Ob8PeGvVbQ4
         gL2s89R/8Va5qnWifFHTN06rRRadTcUHw3dMi1z1wyLgsKdHisp7FgXkVohnjalBfQQq
         Zte4cLXEIesK6CCSrid01HqSqcbj52MX2GDbg97tI+xPpCJgiqdUN7maGcbAjYo3U4f+
         S/9zt96VQq4gGGKv2p51pEnNC8zbOgRzZscTgtDogpPa828k4LsgEoqsh/T+451x3+M/
         wmSVnKM7O0UkMGwcJdVojLBnvqAezEcCVKaiBFtxQgt/oNZVJuxQ/5MdXWdTqtPdEY0J
         F6GQ==
X-Forwarded-Encrypted: i=1; AJvYcCUa1WNpLhFYU+B6ds475Z7I8z8nMiXfOca5hAkuxHG/xLh1ZjkTYZNw/pC/6ZN9VhSm8DNwqoc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVbZkHDCFiagZVr+MM0k8DBUvHSiBQppqItaXJ1peAni7xi4zR
	/0xfZf2UyKQgGAdg27IZf8usf8CRx0OLnospE3bd3vXpx5JugllwUAD17OlX380Qe/1P9VpFLht
	AVaUoyT/N8e2q8V55pTELvkLkB9Zf9wLz53pi+B6IUKe2v3md9jm3RHcgHg==
X-Gm-Gg: ASbGncvAN5oTq/jirg5LU7j1zgeuWbZolQkkkz0u/Rt7Q8M/Zo7HH5S5Lm1eOFkC/5D
	rQBf3ytq3JywjslftYRmhu14xWApNe8Hx6jhEq0xYF1UGTxfLYW9PQrG2Qc4BcwscbEmgaFAHoh
	cuMfbIwRpVij4N6F40DhDeX18wAjoGXo/QN7oiKOdc1F6I+DQCLrxRPSbyT2bS4BIk+D2suh+lI
	v3DCnudIAoq/3cjSPtdWG3vQk4SwjbbrLFQ76VBYDWNJEvlkwHc2L5QZ0h/9eO8XjKBZ4kbsjTc
	OiRYvcep9r2Lf2mVd0ZuJIK9k3N4k3sg3FG5biZnEagW+Q33LuHJtEBjQ25zP11ikUGPmfMbVMu
	59HcLzL0uoman1trR6MGnbeku+s/LWw5yyIwWXNuIoGd2/iUY/pG7a2ipYeoDdXqaSpo=
X-Received: by 2002:a05:600c:35ca:b0:45b:8939:8b19 with SMTP id 5b1f17b1804b1-45b89398d7amr45473015e9.8.1756725982891;
        Mon, 01 Sep 2025 04:26:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEDSGyETaSLlIJWU3uzoaaoqfMZkiytSvPl1Lt94HwmLorgIbYtX0kyMO60lbJbmccNczIMnQ==
X-Received: by 2002:a05:600c:35ca:b0:45b:8939:8b19 with SMTP id 5b1f17b1804b1-45b89398d7amr45472785e9.8.1756725982455;
        Mon, 01 Sep 2025 04:26:22 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f37:2b00:948c:dd9f:29c8:73f4? (p200300d82f372b00948cdd9f29c873f4.dip0.t-ipconnect.de. [2003:d8:2f37:2b00:948c:dd9f:29c8:73f4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b6f0c6fe5sm233491715e9.5.2025.09.01.04.26.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Sep 2025 04:26:21 -0700 (PDT)
Message-ID: <2dcf12d0-e29c-4c9b-aeac-a0b803d2c2fd@redhat.com>
Date: Mon, 1 Sep 2025 13:26:20 +0200
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

What is the use case for this extreme usage of fork() in that context? 
Is it just something people noticed and it's suboptimal, or is this a 
real problem for some use cases?

-- 
Cheers

David / dhildenb


