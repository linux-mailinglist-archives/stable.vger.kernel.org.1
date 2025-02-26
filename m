Return-Path: <stable+bounces-119723-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9062BA46767
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 18:06:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B52DD440F54
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 16:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74A2121E082;
	Wed, 26 Feb 2025 16:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L7B74fYX"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE9F19005F
	for <stable@vger.kernel.org>; Wed, 26 Feb 2025 16:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740588741; cv=none; b=XPbeYJoddHttuVzptyoAZl1eU9LN8V03haJZgBvBWxIW+r4piMv9+kSFTbpRxIDMmZTRbdVbNyT/2TIhpK4coDEKTrwWO5Zw6D9byfvE/t+GA1qmmbE6QYI8X0RPe9UYksZHTe45AbC9ZFDZQmFnd1W4zuGqlG4ZPUYUzyyRlrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740588741; c=relaxed/simple;
	bh=Jr2awVO967PWhryCmmJTYA3ZJ8MdFBT4PF2HNMlA4gw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jHV1f1F6n6DW+XKM/HK34YI5NUj4V3zLPgpVpE70PQXy2pTPLzDJ/UMRKj5Zz6BEqQn7nv4vx1DXj/7nwfeeSi/Q2OJwNuUUffBqEMDmZ8n2DyuGB+k59KD8LdnfMdbq6WLTyOsmntpMSOLcUskTDb5uduol6XKMhzP2rPnwj+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L7B74fYX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740588738;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=+0HHkRdAiBd7Txtjs9eRODGWP9c636h+jNfm6Og71eo=;
	b=L7B74fYXpa/7k7ESRSZBuKNCeVNNidHYHi+o7pAs5xWGIZB7Dlpvz/uMJl3NSur5mZUhLB
	fqVIqcRr7PJDc7Bf00RVp0B+9YmNkyFLPy70h1E2+sSOOQxvAJW/Xd2xEHwn+KBzei1iwR
	3+yWlCKRnXC00B/bZtRXvTJJLrphL04=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122-LyuEhFX8N4OEOw33VxxWNA-1; Wed, 26 Feb 2025 11:52:16 -0500
X-MC-Unique: LyuEhFX8N4OEOw33VxxWNA-1
X-Mimecast-MFC-AGG-ID: LyuEhFX8N4OEOw33VxxWNA_1740588735
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-38f34b3f9f1so4824410f8f.0
        for <stable@vger.kernel.org>; Wed, 26 Feb 2025 08:52:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740588735; x=1741193535;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+0HHkRdAiBd7Txtjs9eRODGWP9c636h+jNfm6Og71eo=;
        b=Dne6Qzti6tlhvtpMmDv67eOI6biaFDdNua9Bjsu4bI0MXZrKiCz0E4oxsqL2bH1w8w
         9cmL3nN+lDCsaOAbNywLavgoWsV1Z+0X57sSDkLJdA3BKUtB1u4LAujhExsnb/HR/OOe
         pPBy1C4MsH/F33rJaRQDymebNtowSSrs6KNCwmPnJqWo2p3vSQEu9cpSrU4XrZEy+uW3
         rNAvM9XI2p3UY4f8ERTQtt8dpUjRnzdV14nqtel8oZZCEZACSiG8luazJqT4GDHMH3SZ
         GCovAnvup05Yl+w3q79aZXIc6NKMWepeCwkiVpgDelFRIg4MZ/eHt2UQOxDp7L5LqbkD
         yzRQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1aL0GI2mtGVjHQhx042vKBv12N+p/qAJ4EcX9iOa1IqSnEeNNbisARmxhGqHhPNIJNs5uCMc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxkp97ZvYu8i4A3jTGVHwRT9FYk2Ec/smTbQAwKTTb6frQH61Ld
	J6uYu2EcEMQFcdYwlh3pkO2+iGRIvd+WG0AkQ1lCGIQ8OK9T3WVv+Kkm5n9QmE15dVQt4AHLEh5
	46n5KZ9K1aV0Juw8bBFAxcXvftZCVeaTFRAdUDfthQElyllDnQfoZzQ==
X-Gm-Gg: ASbGncuK7ui7uFGHNOcwFbQhRUW5MmznlS73jnoVlZkxlpeR9q3zERDGgYldH3JX+we
	IxE9TBjudITjPqb5lyzHqy6T9ptUCRzoqJ3Bnve86xpEJkAxGwFKjJ57UQRL8xaz+zPwj1I8CYh
	Y5gaXpeMRNw25ALIPmp7jj44jixzYu8BGuZjNbWu9UwgfHCmRhbOQQSOR6ivdFqQ1qzUlywqIF+
	R6dFfwbLS2qj/7UtmVNoryINVfteranREg5Wz1Ng4+7d0BpIlTlMnFYDY9ZiiyzByIdCNPR3riG
	kq6/LQMl+XkIoVwfUNCAzf8+zcRuelsRQzTvpOqhvtW6cwXU3iLjwN1QkZ3ZVSALpRTfBvmIOV/
	PlRUiOBS1LzBKcyaoHbImcq/KzEmA8Tvo/EGjg/4Lu5o=
X-Received: by 2002:a5d:5f4e:0:b0:38f:2bd4:4f83 with SMTP id ffacd0b85a97d-390d4f3cb77mr4468569f8f.16.1740588735379;
        Wed, 26 Feb 2025 08:52:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF96KvSMRmM5TXBYTyKxVzIlmTEfqQ4jkwmJCUMcZF9SSmULrSOpEHRedOCic6897bciWmd2A==
X-Received: by 2002:a5d:5f4e:0:b0:38f:2bd4:4f83 with SMTP id ffacd0b85a97d-390d4f3cb77mr4468540f8f.16.1740588734974;
        Wed, 26 Feb 2025 08:52:14 -0800 (PST)
Received: from ?IPV6:2003:cb:c747:ff00:9d85:4afb:a7df:6c45? (p200300cbc747ff009d854afba7df6c45.dip0.t-ipconnect.de. [2003:cb:c747:ff00:9d85:4afb:a7df:6c45])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390cd86c93bsm6150565f8f.26.2025.02.26.08.52.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2025 08:52:14 -0800 (PST)
Message-ID: <12dfdfde-06db-4112-9979-2ed320f80439@redhat.com>
Date: Wed, 26 Feb 2025 17:52:13 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: fix finish_fault() handling for large folios
To: Matthew Wilcox <willy@infradead.org>
Cc: Brian Geffon <bgeffon@google.com>,
 Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>,
 Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Hugh Dickins
 <hughd@google.com>, Marek Maslanka <mmaslanka@google.com>
References: <20250226114815.758217-1-bgeffon@google.com>
 <Z78fT2H3BFVv50oI@casper.infradead.org>
 <121abab9-5090-486b-a3af-776a9cae04fb@redhat.com>
 <Z79BHbCL3U5aGS0Q@casper.infradead.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <Z79BHbCL3U5aGS0Q@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26.02.25 17:28, Matthew Wilcox wrote:
> On Wed, Feb 26, 2025 at 04:42:46PM +0100, David Hildenbrand wrote:
>> On 26.02.25 15:03, Matthew Wilcox wrote:
>>> On Wed, Feb 26, 2025 at 06:48:15AM -0500, Brian Geffon wrote:
>>>> When handling faults for anon shmem finish_fault() will attempt to install
>>>> ptes for the entire folio. Unfortunately if it encounters a single
>>>> non-pte_none entry in that range it will bail, even if the pte that
>>>> triggered the fault is still pte_none. When this situation happens the
>>>> fault will be retried endlessly never making forward progress.
>>>>
>>>> This patch fixes this behavior and if it detects that a pte in the range
>>>> is not pte_none it will fall back to setting just the pte for the
>>>> address that triggered the fault.
>>>
>>> Surely there's a similar problem in do_anonymous_page()?
>>
>> I recall we handle it in there correctly the last time I stared at it.
>>
>> We check pte_none to decide which folio size we can allocate (including
>> basing the decision on other factors like VMA etc), and after retaking the
>> PTL, we recheck vmf_pte_changed / pte_range_none() to make sure there were
>> no races.
> 
> Ah, so then we'll retry and allocate a folio of the right size the next
> time?

IIRC we'll retry the fault in case we had a race. Likely, if we had a 
race, somebody else installed a (large) folio and we essentially have to 
second fault. If, for some reason, the race only touched parts of the 
PTEs we tried to modify, we'll get another fault and allocate something 
(smaller) that would fit into the new empty range.

So yes, we're more flexible because we're allocating the folios and 
don't have to take whatever folio size is in the pagecache in consideration.

-- 
Cheers,

David / dhildenb


