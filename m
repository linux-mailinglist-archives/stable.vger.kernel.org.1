Return-Path: <stable+bounces-36330-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD98089B900
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 09:47:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B67A283ED4
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 07:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 992F32C85F;
	Mon,  8 Apr 2024 07:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iccnmVH6"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADCFF481BD
	for <stable@vger.kernel.org>; Mon,  8 Apr 2024 07:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712562267; cv=none; b=hl7g6fv4uH+vxapTwFRQkRiGAdFVh0PNb8+22VHpQBcGKeJq9w0zPlkK5VqvkqfzuwVJHv22CLF3x75nfhY8Aw94KskBWmOtVAnmriDz8W9uLOQTOXDABZ3fPhok/T1TOv+lFypgNHzhSOmtZO9vFJY3qs7hPWgQSdNwyzaBumE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712562267; c=relaxed/simple;
	bh=JPA0yJP5QqZqrfapKPMKDjQJHy4vOb4yce5vCTt+O0s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QLHRbGlK3voiPWX8SnPpYLmLVi77HCcZB9OnRVb9bVyx+OZbFAktaD0frOCQgYG8Ckfwuxa7WLBEF4uHkVdjoQkGTjhjYhbdiOP78pi9P3aSNfdYhwUawOL2rVCvL29KJDgqoPE5IYghXGARGrl2Qp+6M/3l9ati6ZAXR2C6CqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iccnmVH6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712562263;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=M3XrUvn56UijqLfg1EQp0iLztinagyzYc4/8ZWkHKCo=;
	b=iccnmVH6mhQu+a5pK1d5dQkEKJ/s1by+qYSKK0yMC7evhmmRhSKXy+an0dmCvR80K5YVeQ
	meE78sbWnpvcbYqGO1uwKN3qwpqE7xW9cswQgb3qa9jD4vLAQ7pBGx/jbduEmnkXh2zvWw
	YdbCb6W/cF1l+jv7d6kNqCOppL9/U0A=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-654sxxsOPkKtwTDv4jRheg-1; Mon, 08 Apr 2024 03:44:22 -0400
X-MC-Unique: 654sxxsOPkKtwTDv4jRheg-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-41489c04e3aso16545945e9.0
        for <stable@vger.kernel.org>; Mon, 08 Apr 2024 00:44:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712562261; x=1713167061;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M3XrUvn56UijqLfg1EQp0iLztinagyzYc4/8ZWkHKCo=;
        b=ovr4/H1U2SlcDT98YSWt4rMg2U5IujNfWBL/yPuJfDKrFhf8pUSWaVv8uZFjsrTfMt
         Mu+L4sWH6ro7MBGABLuFuIgebw6NfKw2VWehcGpvOP/tkUURBBMXTIpq3QEd3QicXU/t
         Yh0nV23hB5jBNhLXMqDG/xBIhbOp/btMktFDsHTzUcDJo1TDQuR4oNJslPq/+JQ7+O8g
         srrr6qktkPD65l6dBp53S2vbr9bg0Ul7wv1evoV1bNaFwX5Z25eYjYHeYiJsDzK718bm
         nEo42mS2Z1RhQJU1S20/PoJ0BRazvwt8v5E302PGb66OokrdZwJtegyEgXpqvvb+UAD+
         iB8w==
X-Forwarded-Encrypted: i=1; AJvYcCUyZmImMm/xr1Z9y2UsSWjkujltUMKEO+03de9SVtUkk+8/uiT4KaShQKBSqiFA40M2uEfxmyqXcTj7W5JkXNAka2gxI30u
X-Gm-Message-State: AOJu0YyWGiuZD0GjkwErvjNIFRMOG9S6jBs5PuLTfNH5+Ypv8EImSmxv
	IQG+JmGIoz6PjCCdjymf1bupU81E/WUeNKn9K5WQZ7bKo+vMGb+VKidfjhPInuw+5/G6OFkvmdo
	FGUQGCdmLTbresUQTsgGR1Uqwr/6/pSFNcRL3ufuU6b9CCMlkeJV2Ew==
X-Received: by 2002:a05:600c:4506:b0:414:56ec:22e7 with SMTP id t6-20020a05600c450600b0041456ec22e7mr6019626wmo.21.1712562261269;
        Mon, 08 Apr 2024 00:44:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHmacyacz5MJG/SicWG11fdsTuvTk/gi5zfBY36JmAEpCx15RoAfYjuXal36C5vz8BeSfptvA==
X-Received: by 2002:a05:600c:4506:b0:414:56ec:22e7 with SMTP id t6-20020a05600c450600b0041456ec22e7mr6019610wmo.21.1712562260868;
        Mon, 08 Apr 2024 00:44:20 -0700 (PDT)
Received: from ?IPV6:2003:cb:c718:1300:9860:66a2:fe4d:c379? (p200300cbc7181300986066a2fe4dc379.dip0.t-ipconnect.de. [2003:cb:c718:1300:9860:66a2:fe4d:c379])
        by smtp.gmail.com with ESMTPSA id v19-20020a05600c471300b004157ff88ad7sm12426642wmo.7.2024.04.08.00.44.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Apr 2024 00:44:20 -0700 (PDT)
Message-ID: <669695d1-b374-4a2e-9f8e-1bf95725ba70@redhat.com>
Date: Mon, 8 Apr 2024 09:44:19 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm,swapops: Update check in is_pfn_swap_entry for
 hwpoison entries
To: Oscar Salvador <osalvador@suse.de>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Miaohe Lin <linmiaohe@huawei.com>, Peter Xu <peterx@redhat.com>,
 stable@vger.kernel.org, Tony Luck <tony.luck@intel.com>
References: <20240407130537.16977-1-osalvador@suse.de>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 xsFNBFXLn5EBEAC+zYvAFJxCBY9Tr1xZgcESmxVNI/0ffzE/ZQOiHJl6mGkmA1R7/uUpiCjJ
 dBrn+lhhOYjjNefFQou6478faXE6o2AhmebqT4KiQoUQFV4R7y1KMEKoSyy8hQaK1umALTdL
 QZLQMzNE74ap+GDK0wnacPQFpcG1AE9RMq3aeErY5tujekBS32jfC/7AnH7I0v1v1TbbK3Gp
 XNeiN4QroO+5qaSr0ID2sz5jtBLRb15RMre27E1ImpaIv2Jw8NJgW0k/D1RyKCwaTsgRdwuK
 Kx/Y91XuSBdz0uOyU/S8kM1+ag0wvsGlpBVxRR/xw/E8M7TEwuCZQArqqTCmkG6HGcXFT0V9
 PXFNNgV5jXMQRwU0O/ztJIQqsE5LsUomE//bLwzj9IVsaQpKDqW6TAPjcdBDPLHvriq7kGjt
 WhVhdl0qEYB8lkBEU7V2Yb+SYhmhpDrti9Fq1EsmhiHSkxJcGREoMK/63r9WLZYI3+4W2rAc
 UucZa4OT27U5ZISjNg3Ev0rxU5UH2/pT4wJCfxwocmqaRr6UYmrtZmND89X0KigoFD/XSeVv
 jwBRNjPAubK9/k5NoRrYqztM9W6sJqrH8+UWZ1Idd/DdmogJh0gNC0+N42Za9yBRURfIdKSb
 B3JfpUqcWwE7vUaYrHG1nw54pLUoPG6sAA7Mehl3nd4pZUALHwARAQABzSREYXZpZCBIaWxk
 ZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT7CwZgEEwEIAEICGwMGCwkIBwMCBhUIAgkKCwQW
 AgMBAh4BAheAAhkBFiEEG9nKrXNcTDpGDfzKTd4Q9wD/g1oFAl8Ox4kFCRKpKXgACgkQTd4Q
 9wD/g1oHcA//a6Tj7SBNjFNM1iNhWUo1lxAja0lpSodSnB2g4FCZ4R61SBR4l/psBL73xktp
 rDHrx4aSpwkRP6Epu6mLvhlfjmkRG4OynJ5HG1gfv7RJJfnUdUM1z5kdS8JBrOhMJS2c/gPf
 wv1TGRq2XdMPnfY2o0CxRqpcLkx4vBODvJGl2mQyJF/gPepdDfcT8/PY9BJ7FL6Hrq1gnAo4
 3Iv9qV0JiT2wmZciNyYQhmA1V6dyTRiQ4YAc31zOo2IM+xisPzeSHgw3ONY/XhYvfZ9r7W1l
 pNQdc2G+o4Di9NPFHQQhDw3YTRR1opJaTlRDzxYxzU6ZnUUBghxt9cwUWTpfCktkMZiPSDGd
 KgQBjnweV2jw9UOTxjb4LXqDjmSNkjDdQUOU69jGMUXgihvo4zhYcMX8F5gWdRtMR7DzW/YE
 BgVcyxNkMIXoY1aYj6npHYiNQesQlqjU6azjbH70/SXKM5tNRplgW8TNprMDuntdvV9wNkFs
 9TyM02V5aWxFfI42+aivc4KEw69SE9KXwC7FSf5wXzuTot97N9Phj/Z3+jx443jo2NR34XgF
 89cct7wJMjOF7bBefo0fPPZQuIma0Zym71cP61OP/i11ahNye6HGKfxGCOcs5wW9kRQEk8P9
 M/k2wt3mt/fCQnuP/mWutNPt95w9wSsUyATLmtNrwccz63XOwU0EVcufkQEQAOfX3n0g0fZz
 Bgm/S2zF/kxQKCEKP8ID+Vz8sy2GpDvveBq4H2Y34XWsT1zLJdvqPI4af4ZSMxuerWjXbVWb
 T6d4odQIG0fKx4F8NccDqbgHeZRNajXeeJ3R7gAzvWvQNLz4piHrO/B4tf8svmRBL0ZB5P5A
 2uhdwLU3NZuK22zpNn4is87BPWF8HhY0L5fafgDMOqnf4guJVJPYNPhUFzXUbPqOKOkL8ojk
 CXxkOFHAbjstSK5Ca3fKquY3rdX3DNo+EL7FvAiw1mUtS+5GeYE+RMnDCsVFm/C7kY8c2d0G
 NWkB9pJM5+mnIoFNxy7YBcldYATVeOHoY4LyaUWNnAvFYWp08dHWfZo9WCiJMuTfgtH9tc75
 7QanMVdPt6fDK8UUXIBLQ2TWr/sQKE9xtFuEmoQGlE1l6bGaDnnMLcYu+Asp3kDT0w4zYGsx
 5r6XQVRH4+5N6eHZiaeYtFOujp5n+pjBaQK7wUUjDilPQ5QMzIuCL4YjVoylWiBNknvQWBXS
 lQCWmavOT9sttGQXdPCC5ynI+1ymZC1ORZKANLnRAb0NH/UCzcsstw2TAkFnMEbo9Zu9w7Kv
 AxBQXWeXhJI9XQssfrf4Gusdqx8nPEpfOqCtbbwJMATbHyqLt7/oz/5deGuwxgb65pWIzufa
 N7eop7uh+6bezi+rugUI+w6DABEBAAHCwXwEGAEIACYCGwwWIQQb2cqtc1xMOkYN/MpN3hD3
 AP+DWgUCXw7HsgUJEqkpoQAKCRBN3hD3AP+DWrrpD/4qS3dyVRxDcDHIlmguXjC1Q5tZTwNB
 boaBTPHSy/Nksu0eY7x6HfQJ3xajVH32Ms6t1trDQmPx2iP5+7iDsb7OKAb5eOS8h+BEBDeq
 3ecsQDv0fFJOA9ag5O3LLNk+3x3q7e0uo06XMaY7UHS341ozXUUI7wC7iKfoUTv03iO9El5f
 XpNMx/YrIMduZ2+nd9Di7o5+KIwlb2mAB9sTNHdMrXesX8eBL6T9b+MZJk+mZuPxKNVfEQMQ
 a5SxUEADIPQTPNvBewdeI80yeOCrN+Zzwy/Mrx9EPeu59Y5vSJOx/z6OUImD/GhX7Xvkt3kq
 Er5KTrJz3++B6SH9pum9PuoE/k+nntJkNMmQpR4MCBaV/J9gIOPGodDKnjdng+mXliF3Ptu6
 3oxc2RCyGzTlxyMwuc2U5Q7KtUNTdDe8T0uE+9b8BLMVQDDfJjqY0VVqSUwImzTDLX9S4g/8
 kC4HRcclk8hpyhY2jKGluZO0awwTIMgVEzmTyBphDg/Gx7dZU1Xf8HFuE+UZ5UDHDTnwgv7E
 th6RC9+WrhDNspZ9fJjKWRbveQgUFCpe1sa77LAw+XFrKmBHXp9ZVIe90RMe2tRL06BGiRZr
 jPrnvUsUUsjRoRNJjKKA/REq+sAnhkNPPZ/NNMjaZ5b8Tovi8C0tmxiCHaQYqj7G2rgnT0kt
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240407130537.16977-1-osalvador@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07.04.24 15:05, Oscar Salvador wrote:
> Tony reported that the Machine check recovery was broken in v6.9-rc1,
> as he was hitting a VM_BUG_ON when injecting uncorrectable memory errors
> to DRAM.
> After some more digging and debugging on his side, he realized that this
> went back to v6.1, with the introduction of 'commit 0d206b5d2e0d ("mm/swap: add
> swp_offset_pfn() to fetch PFN from swap entry")'.
> That commit, among other things, introduced swp_offset_pfn(), replacing
> hwpoison_entry_to_pfn() in its favour.
> 
> The patch also introduced a VM_BUG_ON() check for is_pfn_swap_entry(),
> but is_pfn_swap_entry() never got updated to cover hwpoison entries, which
> means that we would hit the VM_BUG_ON whenever we would call
> swp_offset_pfn() for such entries on environments with CONFIG_DEBUG_VM set.
> Fix this by updating the check to cover hwpoison entries as well, and update
> the comment while we are it.
> 
> Reported-by: Tony Luck <tony.luck@intel.com>
> Closes: https://lore.kernel.org/all/Zg8kLSl2yAlA3o5D@agluck-desk3/
> Tested-by: Tony Luck <tony.luck@intel.com>
> Fixes: 0d206b5d2e0d ("mm/swap: add swp_offset_pfn() to fetch PFN from swap entry")
> Cc: <stable@vger.kernel.org> # 6.1.x
> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> ---

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


