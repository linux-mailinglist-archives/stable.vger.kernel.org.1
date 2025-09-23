Return-Path: <stable+bounces-181532-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC429B96DB2
	for <lists+stable@lfdr.de>; Tue, 23 Sep 2025 18:40:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F4F43A87C1
	for <lists+stable@lfdr.de>; Tue, 23 Sep 2025 16:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23541319615;
	Tue, 23 Sep 2025 16:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RVQzuncC"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353A8328593
	for <stable@vger.kernel.org>; Tue, 23 Sep 2025 16:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758645615; cv=none; b=WdA/32udPdR+mgWwvxFzvfH6UjqegGEoHxUkkw+6IJskCGyPkj/ziGCUZNxnsA9SFb/9W0/iVI/Q4rMY9nkaiDyw985gPI1d21+jxVYq3WzbkGl2fd6/A6q8XciBRhKUMpA0I+ZYUeWVlrxyem5q2woFDd3JJYTD2Gd1L++mFLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758645615; c=relaxed/simple;
	bh=v6aURaDs+tw/LcqebUp4Qfb9IevUnqYg10u7uRZCLNc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mde9y4h1c9q0tAnwZp+KynLXU390IsYTOxAgKUIrz2PVu4KZfSqxi2XaqhJbLjprB+IuR28BQrxY9kHrDvIEtPt7yRbq2bOoTlFGIWCQkzbLRjnRcze4pNNJkecAQtHLvrgvfis+ViaUegYVIww3bWQfB23xX4+YQQoZCTYrjQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RVQzuncC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758645613;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=L1QkzrTGCwMnovMp2G8JNLttd8EAbqBA5tlzUuHhOxE=;
	b=RVQzuncCBC/RdIu0dOF5UsXDI9dRgd/v++5jJL1xyhl2kr+bpQqKv42hhQvdrEdB9REsH3
	DPVXKz2nzoYFJXcqA1Y70CxKnsoBIATxVuX4EmjZyVFDGbufpkogXf21ND4Tv3R1viI/bq
	5OGEteMm+gIs4I8HaIpAnTSdbnYGtMA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-cco2_MGKMf-uWGiG9Kgwlg-1; Tue, 23 Sep 2025 12:40:11 -0400
X-MC-Unique: cco2_MGKMf-uWGiG9Kgwlg-1
X-Mimecast-MFC-AGG-ID: cco2_MGKMf-uWGiG9Kgwlg_1758645611
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3ed9557f976so4993723f8f.3
        for <stable@vger.kernel.org>; Tue, 23 Sep 2025 09:40:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758645610; x=1759250410;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L1QkzrTGCwMnovMp2G8JNLttd8EAbqBA5tlzUuHhOxE=;
        b=HlEugsW4xfxR6DpP0W/77n/xwgndK66OonmcbQNF8ShC0VPqgCYaDCNezWe7mkwyNd
         KwArYIHBD4TzEc44w3jvXm25ONiQgqAZ0qvFb5oj7Hs+mHtcIi2mR5XDmla9TaqbV/tn
         mRgz0R+PJ17PJTfg+L0zQAgZZUaMKkbuHejmZIRajXq403L8Aj5OtkDgiedSoyKw147+
         NtUC5ZPWAD19fsdoWJvH0b+JP2Jh9HX+JmcaPWRNEZqP/DDS/MHDKE/gqf6uf26k3CLY
         fNCbCKmjZ4knTW4SdsKc1bvvB6UUWO9kb2CCM+/j+9GSquYGqC/5Y4aSH/sg3HbRbG6E
         jH0A==
X-Forwarded-Encrypted: i=1; AJvYcCWZYkHh8/qAkLzM6HMHpid/cJj03PzVelWCjfca63ypFSrNJGzmyzfFd/7/aep+/tiEqFp541w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJlSTxOcSPBbbEblOGqN4QCOvYH+eiMxhEJaWQL+Wo7ots6pd0
	K3BCwyBjXEcfrgfgu5FhE1pXzH7qdfxBd+T6bDcSeIbpmk960j6B95AQYS/KsJjkmgldOipjwI2
	HoSRiWfqukumyvdkFyeCRB0lCCuG0ZOjl85aSaOc27jfusLV0m1eycz1tLA==
X-Gm-Gg: ASbGnctEHarkQGSRdDgQbMaVkS0Iz4vaa38OBa2+1EefG1NnAUrpHqQsh23d19rKp8H
	QH75HO5FKCdVK9ZBE3ZvbZ9tO7eJgJ6MUl454EcOyjO3SslfOG9n39PJDlODDIiZfpQYjQ5s5/N
	0sR6tB7M7JLIyTDZKBJEmapbv7/j1mNOFUQbZ4w7AQ4PCCfz/TEWXKloxCa0NZN/Q2Fhcri2j/N
	xSz38asZEvnXiixKS9b1C21bYvHQtOgqfk/o9yo4uxMJhWuJlJ3GxBCF1yYq9kBdIvTGBPnGgKH
	TxdFksWtuT7ZJhiq8t3HT6IMpOqKX1HEOGHC6iQV+5AbWYcaDYPNlO8TMhlyVg2sl7Xp2wWYr2+
	TJvq7zvHmn+NNapZ4pmN84CFJqS9eQBnysVnS3bewVLo64l00v6MRm1iisL0aeWDyZQ==
X-Received: by 2002:a05:6000:607:b0:3e3:e7a0:1fec with SMTP id ffacd0b85a97d-405c6c1be66mr2624142f8f.16.1758645610507;
        Tue, 23 Sep 2025 09:40:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHlBeAzcC62U49+wQ4+N2FLeq7Mpxq7qWokF6XhNbNHyY0QVTf/R3ihiA3HW6AmAgoSQoynKg==
X-Received: by 2002:a05:6000:607:b0:3e3:e7a0:1fec with SMTP id ffacd0b85a97d-405c6c1be66mr2624093f8f.16.1758645609976;
        Tue, 23 Sep 2025 09:40:09 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f4f:700:c9db:579f:8b2b:717c? (p200300d82f4f0700c9db579f8b2b717c.dip0.t-ipconnect.de. [2003:d8:2f4f:700:c9db:579f:8b2b:717c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3fcb01a9049sm9757269f8f.61.2025.09.23.09.40.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Sep 2025 09:40:09 -0700 (PDT)
Message-ID: <45a7aa69-16df-4809-8ccd-c08c404d55cb@redhat.com>
Date: Tue, 23 Sep 2025 18:40:06 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] mm/thp: fix MTE tag mismatch when replacing
 zero-filled subpages
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Lance Yang <lance.yang@linux.dev>, akpm@linux-foundation.org,
 lorenzo.stoakes@oracle.com, usamaarif642@gmail.com, yuzhao@google.com,
 ziy@nvidia.com, baolin.wang@linux.alibaba.com, baohua@kernel.org,
 voidice@gmail.com, Liam.Howlett@oracle.com, cerasuolodomenico@gmail.com,
 hannes@cmpxchg.org, kaleshsingh@google.com, npache@redhat.com,
 riel@surriel.com, roman.gushchin@linux.dev, rppt@kernel.org,
 ryan.roberts@arm.com, dev.jain@arm.com, ryncsn@gmail.com,
 shakeel.butt@linux.dev, surenb@google.com, hughd@google.com,
 willy@infradead.org, matthew.brost@intel.com, joshua.hahnjy@gmail.com,
 rakie.kim@sk.com, byungchul@sk.com, gourry@gourry.net,
 ying.huang@linux.alibaba.com, apopple@nvidia.com, qun-wei.lin@mediatek.com,
 Andrew.Yang@mediatek.com, casper.li@mediatek.com,
 chinwen.chang@mediatek.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
 linux-mm@kvack.org, ioworker0@gmail.com, stable@vger.kernel.org
References: <20250922021458.68123-1-lance.yang@linux.dev>
 <aNGGUXLCn_bWlne5@arm.com> <a3412715-6d9d-4809-9588-ba08da450d16@redhat.com>
 <aNKJ5glToE4hMhWA@arm.com> <aNLHexcNI53HQ46A@arm.com>
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
In-Reply-To: <aNLHexcNI53HQ46A@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23.09.25 18:14, Catalin Marinas wrote:
> On Tue, Sep 23, 2025 at 12:52:06PM +0100, Catalin Marinas wrote:
>> I just realised that on arm64 with MTE we won't get any merging with the
>> zero page even if the user page isn't mapped with PROT_MTE. In
>> cpu_enable_mte() we zero the tags in the zero page and set
>> PG_mte_tagged. The reason is that we want to use the zero page with
>> PROT_MTE mappings (until tag setting causes CoW). Hmm, the arm64
>> memcmp_pages() messed up KSM merging with the zero page even before this
>> patch.
> [...]
>> diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
>> index e5e773844889..72a1dfc54659 100644
>> --- a/arch/arm64/kernel/mte.c
>> +++ b/arch/arm64/kernel/mte.c
>> @@ -73,6 +73,8 @@ int memcmp_pages(struct page *page1, struct page *page2)
>>   {
>>   	char *addr1, *addr2;
>>   	int ret;
>> +	bool page1_tagged = page_mte_tagged(page1) && !is_zero_page(page1);
>> +	bool page2_tagged = page_mte_tagged(page2) && !is_zero_page(page2);
>>   
>>   	addr1 = page_address(page1);
>>   	addr2 = page_address(page2);
>> @@ -83,11 +85,10 @@ int memcmp_pages(struct page *page1, struct page *page2)
>>   
>>   	/*
>>   	 * If the page content is identical but at least one of the pages is
>> -	 * tagged, return non-zero to avoid KSM merging. If only one of the
>> -	 * pages is tagged, __set_ptes() may zero or change the tags of the
>> -	 * other page via mte_sync_tags().
>> +	 * tagged, return non-zero to avoid KSM merging. Ignore the zero page
>> +	 * since it is always tagged with the tags cleared.
>>   	 */
>> -	if (page_mte_tagged(page1) || page_mte_tagged(page2))
>> +	if (page1_tagged || page2_tagged)
>>   		return addr1 != addr2;
>>   
>>   	return ret;
> 
> Unrelated to this discussion, I got an internal report that Linux hangs
> during boot with CONFIG_DEFERRED_STRUCT_PAGE_INIT because
> try_page_mte_tagging() locks up on uninitialised page flags.
> 
> Since we (always?) map the zero page as pte_special(), set_pte_at()

Yes. (if pte_special is implemented by the arch of course)

> won't check if the tags have to be initialised, so we can skip the
> PG_mte_tagged altogether. We actually had this code for some time until
> we introduced the pte_special() check in set_pte_at().
> 
> So alternative patch that also fixes the deferred struct page init (on
> the assumptions that the zero page is always mapped as pte_special():
> 

LGTM!

-- 
Cheers

David / dhildenb


