Return-Path: <stable+bounces-179820-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBEBFB7F421
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 15:28:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC8C9527F4C
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 10:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11B9A2F83CD;
	Wed, 17 Sep 2025 10:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gjBwbsd5"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A332356B9
	for <stable@vger.kernel.org>; Wed, 17 Sep 2025 10:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758105519; cv=none; b=pum3ovevwEwrTRc6+hFc5j4dutsh77MJ2v8i0DiX9FlnfZLcSYm24C0rwUcXusCJBm+1AyA1S/yR6YgCAQQhKYpWQDga+J+ASDlMgb+U53dekb/S2uDdqaLLBwbrztiiDbqBc0dxjNw/V15V8mp4rWB9aKKHA4GwYjxVznlBZcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758105519; c=relaxed/simple;
	bh=uys/W2sJ8/JPqZgfhzw7G25uk132Iw0CP8xM8xaTQLo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s8N4wPhod7hRMSnHr4RTuvl4dMOrY42kyRDSBS7GpZJuBsMAdtplcRO4z57zgl50rJOsOmbrIwj7ZkfOkN9/pyIdurQaYAdxIc4UJMIjuBnkTJCXT0jvG68fRjEecl1Mzjr+zKP3eZTWODMDkZM2So3RaN8vwwnOeDZLEDqJjlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gjBwbsd5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758105517;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=soTuum+uvrVdwH4G5wCW13aWL0UwyqwjoUoslGSKOfc=;
	b=gjBwbsd5gWAunocqcOPHXf81BJwpAaEqfIXjXBpY++IogrMk/f0P0BS7rBdhA37TCJcan6
	XizEiCefOHtpR9T3HGXZX8Sl4NQBRfTEYW583vm8+DwW4/yDBBhHNu/6ORKRxdqcp7IJk2
	ldjQNPiHCMESYgvhpRKXawavZGp+K+4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-57-zQQDjx3TNJS3KHdbk3Dazw-1; Wed, 17 Sep 2025 06:38:35 -0400
X-MC-Unique: zQQDjx3TNJS3KHdbk3Dazw-1
X-Mimecast-MFC-AGG-ID: zQQDjx3TNJS3KHdbk3Dazw_1758105515
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3ccd58af2bbso274745f8f.0
        for <stable@vger.kernel.org>; Wed, 17 Sep 2025 03:38:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758105515; x=1758710315;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=soTuum+uvrVdwH4G5wCW13aWL0UwyqwjoUoslGSKOfc=;
        b=MUAwkqNWRoawM3SoWqjYCWIl+qVtp0m7P0QWxgs59m64lQakG3o5j9xLSnjNklyir3
         GRnZOhxcwcGBq06n5oQ0Ve+0Ibr+dJQ3xVjrsfsUwR7Px9RXOCljtpwydupKVykIKFmp
         d2vhbSvk0g9opwnCHRPdxXUFT+dylSoSE71neNg4UM1qf8HkCF/xtnDSqql5zk6sBdje
         C0WP9uee14GZFf47K38CLctIgeHsxrSqqGzfqhhXYaje/El8fnqHLewU5dIhxVKrD9Tu
         XyrHugTPbGUTmIYWAPskuhhCo14q0M5gkGBWb5yvZ9idliK2crCcOhilHuXFXWoivqEt
         Y69w==
X-Forwarded-Encrypted: i=1; AJvYcCUbmulZ3Tkdd+GEswyZZlKzAQAvKoJZah4rFUE4ejENZLa3aDwfv1c+FYZm9Ut4zyk3SArYcyk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6SKkt/3jEjvK55XUEHM/MqOBmq7JCOsJY8eT+R2wxOiAdZKz7
	X50dHlli7/1P1gCmszOubtEqIiZLxs/WzQmRYKVKeS13dxgKWPoLBSvCRsA4coyZev7IF9IIlz8
	IiGvxXLuz/pvQgZiSHlIX5WWLk+EVVP2gs5DLnAdFXMGMBV3VAw5zG+oEKQ==
X-Gm-Gg: ASbGnctK85+ziFqtKP8KDsRTSFTw4oKv6kcMiUGgeTdnuDMK5Kb9Y2raraCPoLsIpMU
	I4B4dG7LAYVUjPhfi0UK8TdIIlzfo60zKflWdeVVWoJErmb/UP80j6f9oN5V0rBhFCS8GSwdhUZ
	7MZ4gS52SsN5YZcHgntFR/jYKakuOok1or/2RbYgUzJw45ZT2Uetr7PRsYLrKf2Vne1U1q9mg4h
	eJ+vBd0LySQToyEKekqBWhPAmidlOJl9JrkUFD5jY4je9SDXnOxLI9PGPCuPqeU3eiXLT27WHBB
	q8AIlfuWO0gAZChCHFI/iVkjeBysjrfypr/Sy4Mg8FrBB9O2Zlfb/4ibjTu6rN6/IYk2Qxy5bnt
	KYLp0UY1ywi3+yX7X8soM+7j6iWsKLRXcLMXkGtPyFHK6W6vbVjCMKGc+sMhGDTsK
X-Received: by 2002:a05:6000:4009:b0:3ea:c893:95b6 with SMTP id ffacd0b85a97d-3eca04743f7mr5153577f8f.27.1758105514581;
        Wed, 17 Sep 2025 03:38:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH8tKIbcNk5D2bluX7BbsWlrG22DyI/8RTeAIZckT7d1/mvHIE0aGsiKEPHwv0/JBjR38b5Xg==
X-Received: by 2002:a05:6000:4009:b0:3ea:c893:95b6 with SMTP id ffacd0b85a97d-3eca04743f7mr5153552f8f.27.1758105514108;
        Wed, 17 Sep 2025 03:38:34 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f27:6d00:7b96:afc9:83d0:5bd? (p200300d82f276d007b96afc983d005bd.dip0.t-ipconnect.de. [2003:d8:2f27:6d00:7b96:afc9:83d0:5bd])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e95b111b68sm15518054f8f.32.2025.09.17.03.38.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 03:38:33 -0700 (PDT)
Message-ID: <6dde7c50-a222-4984-bb69-07ace724f161@redhat.com>
Date: Wed, 17 Sep 2025 12:38:32 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] mm/ksm: Fix incorrect KSM counter handling in
 mm_struct during fork
To: Donet Tom <donettom@linux.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Ritesh Harjani <ritesh.list@gmail.com>, Xu Xin <xu.xin16@zte.com.cn>,
 Chengming Zhou <chengming.zhou@linux.dev>,
 Wei Yang <richard.weiyang@gmail.com>,
 Aboorva Devarajan <aboorvad@linux.ibm.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org,
 Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>,
 stable@vger.kernel.org
References: <cover.1757946863.git.donettom@linux.ibm.com>
 <4044e7623953d9f4c240d0308cf0b2fe769ee553.1757946863.git.donettom@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
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
 ZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT7CwZoEEwEIAEQCGwMCF4ACGQEFCwkIBwICIgIG
 FQoJCAsCBBYCAwECHgcWIQQb2cqtc1xMOkYN/MpN3hD3AP+DWgUCaJzangUJJlgIpAAKCRBN
 3hD3AP+DWhAxD/9wcL0A+2rtaAmutaKTfxhTP0b4AAp1r/eLxjrbfbCCmh4pqzBhmSX/4z11
 opn2KqcOsueRF1t2ENLOWzQu3Roiny2HOU7DajqB4dm1BVMaXQya5ae2ghzlJN9SIoopTWlR
 0Af3hPj5E2PYvQhlcqeoehKlBo9rROJv/rjmr2x0yOM8qeTroH/ZzNlCtJ56AsE6Tvl+r7cW
 3x7/Jq5WvWeudKrhFh7/yQ7eRvHCjd9bBrZTlgAfiHmX9AnCCPRPpNGNedV9Yty2Jnxhfmbv
 Pw37LA/jef8zlCDyUh2KCU1xVEOWqg15o1RtTyGV1nXV2O/mfuQJud5vIgzBvHhypc3p6VZJ
 lEf8YmT+Ol5P7SfCs5/uGdWUYQEMqOlg6w9R4Pe8d+mk8KGvfE9/zTwGg0nRgKqlQXrWRERv
 cuEwQbridlPAoQHrFWtwpgYMXx2TaZ3sihcIPo9uU5eBs0rf4mOERY75SK+Ekayv2ucTfjxr
 Kf014py2aoRJHuvy85ee/zIyLmve5hngZTTe3Wg3TInT9UTFzTPhItam6dZ1xqdTGHZYGU0O
 otRHcwLGt470grdiob6PfVTXoHlBvkWRadMhSuG4RORCDpq89vu5QralFNIf3EysNohoFy2A
 LYg2/D53xbU/aa4DDzBb5b1Rkg/udO1gZocVQWrDh6I2K3+cCs7BTQRVy5+RARAA59fefSDR
 9nMGCb9LbMX+TFAoIQo/wgP5XPyzLYakO+94GrgfZjfhdaxPXMsl2+o8jhp/hlIzG56taNdt
 VZtPp3ih1AgbR8rHgXw1xwOpuAd5lE1qNd54ndHuADO9a9A0vPimIes78Hi1/yy+ZEEvRkHk
 /kDa6F3AtTc1m4rbbOk2fiKzzsE9YXweFjQvl9p+AMw6qd/iC4lUk9g0+FQXNdRs+o4o6Qvy
 iOQJfGQ4UcBuOy1IrkJrd8qq5jet1fcM2j4QvsW8CLDWZS1L7kZ5gT5EycMKxUWb8LuRjxzZ
 3QY1aQH2kkzn6acigU3HLtgFyV1gBNV44ehjgvJpRY2cC8VhanTx0dZ9mj1YKIky5N+C0f21
 zvntBqcxV0+3p8MrxRRcgEtDZNav+xAoT3G0W4SahAaUTWXpsZoOecwtxi74CyneQNPTDjNg
 azHmvpdBVEfj7k3p4dmJp5i0U66Onmf6mMFpArvBRSMOKU9DlAzMi4IvhiNWjKVaIE2Se9BY
 FdKVAJaZq85P2y20ZBd08ILnKcj7XKZkLU5FkoA0udEBvQ0f9QLNyyy3DZMCQWcwRuj1m73D
 sq8DEFBdZ5eEkj1dCyx+t/ga6x2rHyc8Sl86oK1tvAkwBNsfKou3v+jP/l14a7DGBvrmlYjO
 59o3t6inu6H7pt7OL6u6BQj7DoMAEQEAAcLBfAQYAQgAJgIbDBYhBBvZyq1zXEw6Rg38yk3e
 EPcA/4NaBQJonNqrBQkmWAihAAoJEE3eEPcA/4NaKtMQALAJ8PzprBEXbXcEXwDKQu+P/vts
 IfUb1UNMfMV76BicGa5NCZnJNQASDP/+bFg6O3gx5NbhHHPeaWz/VxlOmYHokHodOvtL0WCC
 8A5PEP8tOk6029Z+J+xUcMrJClNVFpzVvOpb1lCbhjwAV465Hy+NUSbbUiRxdzNQtLtgZzOV
 Zw7jxUCs4UUZLQTCuBpFgb15bBxYZ/BL9MbzxPxvfUQIPbnzQMcqtpUs21CMK2PdfCh5c4gS
 sDci6D5/ZIBw94UQWmGpM/O1ilGXde2ZzzGYl64glmccD8e87OnEgKnH3FbnJnT4iJchtSvx
 yJNi1+t0+qDti4m88+/9IuPqCKb6Stl+s2dnLtJNrjXBGJtsQG/sRpqsJz5x1/2nPJSRMsx9
 5YfqbdrJSOFXDzZ8/r82HgQEtUvlSXNaXCa95ez0UkOG7+bDm2b3s0XahBQeLVCH0mw3RAQg
 r7xDAYKIrAwfHHmMTnBQDPJwVqxJjVNr7yBic4yfzVWGCGNE4DnOW0vcIeoyhy9vnIa3w1uZ
 3iyY2Nsd7JxfKu1PRhCGwXzRw5TlfEsoRI7V9A8isUCoqE2Dzh3FvYHVeX4Us+bRL/oqareJ
 CIFqgYMyvHj7Q06kTKmauOe4Nf0l0qEkIuIzfoLJ3qr5UyXc2hLtWyT9Ir+lYlX9efqh7mOY
 qIws/H2t
In-Reply-To: <4044e7623953d9f4c240d0308cf0b2fe769ee553.1757946863.git.donettom@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15.09.25 17:03, Donet Tom wrote:
> Currently, the KSM-related counters in `mm_struct`, such as
> `ksm_merging_pages`, `ksm_rmap_items`, and `ksm_zero_pages`, are
> inherited by the child process during fork. This results in inconsistent
> accounting.
> 
> When a process uses KSM, identical pages are merged and an rmap item is
> created for each merged page. The `ksm_merging_pages` and
> `ksm_rmap_items` counters are updated accordingly. However, after a
> fork, these counters are copied to the child while the corresponding
> rmap items are not. As a result, when the child later triggers an
> unmerge, there are no rmap items present in the child, so the counters
> remain stale, leading to incorrect accounting.
> 
> A similar issue exists with `ksm_zero_pages`, which maintains both a
> global counter and a per-process counter. During fork, the per-process
> counter is inherited by the child, but the global counter is not
> incremented. Since the child also references zero pages, the global
> counter should be updated as well. Otherwise, during zero-page unmerge,
> both the global and per-process counters are decremented, causing the
> global counter to become inconsistent.
> 
> To fix this, ksm_merging_pages and ksm_rmap_items are reset to 0
> during fork, and the global ksm_zero_pages counter is updated with the
> per-process ksm_zero_pages value inherited by the child. This ensures
> that KSM statistics remain accurate and reflect the activity of each
> process correctly.
> 
> Fixes: 7609385337a4 ("ksm: count ksm merging pages for each process")
> Fixes: cb4df4cae4f2 ("ksm: count allocated ksm rmap_items for each process")
> Fixes: e2942062e01d ("ksm: count all zero pages placed by KSM")
> cc: stable@vger.kernel.org # v6.6
> Signed-off-by: Donet Tom <donettom@linux.ibm.com>
> ---
>   include/linux/ksm.h | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/ksm.h b/include/linux/ksm.h
> index 22e67ca7cba3..067538fc4d58 100644
> --- a/include/linux/ksm.h
> +++ b/include/linux/ksm.h
> @@ -56,8 +56,14 @@ static inline long mm_ksm_zero_pages(struct mm_struct *mm)
>   static inline void ksm_fork(struct mm_struct *mm, struct mm_struct *oldmm)
>   {
>   	/* Adding mm to ksm is best effort on fork. */
> -	if (mm_flags_test(MMF_VM_MERGEABLE, oldmm))
> +	if (mm_flags_test(MMF_VM_MERGEABLE, oldmm)) {
> +		long nr_ksm_zero_pages = atomic_long_read(&mm->ksm_zero_pages);
> +
> +		mm->ksm_merging_pages = 0;
> +		mm->ksm_rmap_items = 0;
> +		atomic_long_add(nr_ksm_zero_pages, &ksm_zero_pages);
>   		__ksm_enter(mm);

That LGTM. KSM is all weird in combination with fork(), but that's 
something for another day to improve I guess.

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb


