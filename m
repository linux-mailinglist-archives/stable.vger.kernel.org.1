Return-Path: <stable+bounces-189150-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A493AC0260A
	for <lists+stable@lfdr.de>; Thu, 23 Oct 2025 18:16:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83DDB1AA69F5
	for <lists+stable@lfdr.de>; Thu, 23 Oct 2025 16:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62047291C07;
	Thu, 23 Oct 2025 16:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WYSwDUhq"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD43286881
	for <stable@vger.kernel.org>; Thu, 23 Oct 2025 16:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761236080; cv=none; b=vE0gQLjyM+Pe+mpXsCKorl0UyIoZppJi9F+tqJSVA81VlCf8cw0BSIcFBOKVGG0NIZjRomvdFMCHneVwl8NLQjkyR/4EUMKBYn91ZGE1qgwuQ7gFw9srgYocw04Ym5bAOOLn+QsEmKP3iM11ZYidjmttFXFy1gnjBMXoz9tjvJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761236080; c=relaxed/simple;
	bh=vFYoSYTGyB/NYB7UIddMfOV8esqvQn0hyGvAAAvg0E0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=bxqUh+X7f3MQjCh0GH8lgj6PYvl1bkYSs1IwBsfYqj3EhXjUfn9GZB4uzCp8jJtnh5ulXojUyFl6f5nAtrDyUAYGwz7qGBDZwRhmBWUk8e67xEUKPrvxMoS21aBL7uiN8rjQj9zkxktzikTyeJsU6V3Tttc0CyGj4ZuVtlhIcCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WYSwDUhq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761236077;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=k0dhmDMYo3HiSSPV4Zrtr3RDrc7RUUpux3gluKAN+yE=;
	b=WYSwDUhqbAqzEUi3BCCduvXMMUVRN3vQn+TwKyCyZpWiL6FfmajkIOejZGXAq4EEtPglzz
	VEv1ExJ/GjBljkoOb4eQ1lBe7c2wENRPcIDzZUi/I/ohv/qXCEnHI0NoZ0MiwBODXH1ZEa
	1YH00/uhduAA+u23mWxe+7QP40fsVwU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-ztzHTdJJOsiicFbBOoxXDg-1; Thu, 23 Oct 2025 12:14:36 -0400
X-MC-Unique: ztzHTdJJOsiicFbBOoxXDg-1
X-Mimecast-MFC-AGG-ID: ztzHTdJJOsiicFbBOoxXDg_1761236075
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-4298b98f376so533252f8f.3
        for <stable@vger.kernel.org>; Thu, 23 Oct 2025 09:14:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761236075; x=1761840875;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k0dhmDMYo3HiSSPV4Zrtr3RDrc7RUUpux3gluKAN+yE=;
        b=Qfu2qHAy+oWPz9vthehSzF8FBOAGx9DIYngdZdkq8nF5OhnsEVL6zCR9CQB2KMZy9w
         ELxIU6tn5jFYcZl2wjrrp6703oN4Mpm/x1m6PdojDFKzPu5yc0wruNYyzwXWajYPHQau
         en/+UOy1weV10Iab9h5ZTSYWQwv5Am02z1ulZyTsY7Hmt094Lrzne/qE0YQFmtksNfdR
         gRU6iWqXgreevutx3TmKs8t/HQJfCzENJcJJcNC/gp24l7FOGjLKqqPn1A7A/PyttQan
         oaEcsZ1GMuTBEX4Eals+pk+/cCycJFmwMneGPf5pJEFoV2p4ZV6vd5v0OZqFqbJUe1pk
         Um2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUERtljE/gcN2Gc4nAEcS1PW1dafZ6odl206L03IdEfSl3j4xcQ8hyXo7veEnx6ypm8hzxp/Z8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0H/1+Lsa5JamYOohrQG9s5KE/DQSEiBs4LK6uwBUlOoiYBj/f
	kk9Zf6vt40FBMlq4Wm3YnlsjQLDQWmWSfmbqeNkqwEXKyWxjr71J/GEPZ1qeIzhniJpSWLDxdwH
	AxSEGaQUVEg+arxmFQZrVWxzOGx7vXvICx7AWQWKQddtWgsADQGrrDE0WVA==
X-Gm-Gg: ASbGnctzdZ1Ju/d02iQcXSDwv5KJBuEWwD/5eaNOsA9VeUc694sgSs5gZlUKPyq3yX1
	QnI5fZETKWD+ur43TyIY2wXGJa3UJiKUykfM3Z7LZ9E0OcGG2Kwq/QAia+rDs4lTPI+Qv9Ba85A
	Rcfj7kS917u6QhJ9bDbNZL5s+sOkwkjzgIDs1QPL6huRszfmeNmJi81TB52KhZArSTwsUrcXDpo
	7yOfMwXbg9yiitzwR9eEsCHmSmcc+2sCHE4iFWeYVg+mkrKXvZKsoiaqGRCAbLYSkWeMylW+KtO
	6Q84Qc75lI0wCRBS/Dl1Y67mlh5l/QkNvCsz7uz8ozmDj9y6w+QUjh8lRfNG/dAfxGl3fh9UXCu
	gVfWCLhSMRiYeUHYWiQhv+tKdVslIcJBFrny2DIHtAv7HhTXcZWvnHFjBr240kanffIrl1kgtje
	2crD7sMarmn9OpKm45uzrTisSauhs=
X-Received: by 2002:a05:6000:2389:b0:427:151:3db6 with SMTP id ffacd0b85a97d-42704d8e226mr18440191f8f.24.1761236074728;
        Thu, 23 Oct 2025 09:14:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGMl8voI5z2PSFRyYE4kSrkNvMWAwhecqefVjAYNEcQcmIlYYmJhCc3BoVGRfcbppN1W9F1PQ==
X-Received: by 2002:a05:6000:2389:b0:427:151:3db6 with SMTP id ffacd0b85a97d-42704d8e226mr18440161f8f.24.1761236074258;
        Thu, 23 Oct 2025 09:14:34 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3? (p200300d82f4e3200c99da38b3f3ad4b3.dip0.t-ipconnect.de. [2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475c427f685sm106391125e9.2.2025.10.23.09.14.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 09:14:33 -0700 (PDT)
Message-ID: <f0715f2c-ee27-4e13-84d0-5df156410527@redhat.com>
Date: Thu, 23 Oct 2025 18:14:32 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] mm/shmem: fix THP allocation and fallback loop
From: David Hildenbrand <david@redhat.com>
To: Kairui Song <ryncsn@gmail.com>, linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Hugh Dickins
 <hughd@google.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Liam Howlett <liam.howlett@oracle.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Mariano Pache <npache@redhat.com>, Matthew Wilcox <willy@infradead.org>,
 Ryan Roberts <ryan.roberts@arm.com>, Zi Yan <ziy@nvidia.com>,
 linux-kernel@vger.kernel.org, Kairui Song <kasong@tencent.com>,
 stable@vger.kernel.org
References: <20251023065913.36925-1-ryncsn@gmail.com>
 <774c443f-f12f-4d4f-93b1-8913734b62b2@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <774c443f-f12f-4d4f-93b1-8913734b62b2@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23.10.25 18:13, David Hildenbrand wrote:
> On 23.10.25 08:59, Kairui Song wrote:
>> From: Kairui Song <kasong@tencent.com>
>>
>> The order check and fallback loop is updating the index value on every
>> loop, this will cause the index to be wrongly aligned by a larger value
>> while the loop shrinks the order.
>>
>> This may result in inserting and returning a folio of the wrong index
>> and cause data corruption with some userspace workloads [1].
>>
>> Cc: stable@vger.kernel.org
>> Link: https://lore.kernel.org/linux-mm/CAMgjq7DqgAmj25nDUwwu1U2cSGSn8n4-Hqpgottedy0S6YYeUw@mail.gmail.com/ [1]
>> Fixes: e7a2ab7b3bb5d ("mm: shmem: add mTHP support for anonymous shmem")
>> Signed-off-by: Kairui Song <kasong@tencent.com>
>>
>> ---
>>
>> Changes from V2:
>> - Introduce a temporary variable to improve code,
>>     no behavior change, generated code is identical.
>> - Link to V2: https://lore.kernel.org/linux-mm/20251022105719.18321-1-ryncsn@gmail.com/
>>
>> Changes from V1:
>> - Remove unnecessary cleanup and simplify the commit message.
>> - Link to V1: https://lore.kernel.org/linux-mm/20251021190436.81682-1-ryncsn@gmail.com/
>>
>> ---
>>    mm/shmem.c | 9 ++++++---
>>    1 file changed, 6 insertions(+), 3 deletions(-)
>>
>> diff --git a/mm/shmem.c b/mm/shmem.c
>> index b50ce7dbc84a..e1dc2d8e939c 100644
>> --- a/mm/shmem.c
>> +++ b/mm/shmem.c
>> @@ -1882,6 +1882,7 @@ static struct folio *shmem_alloc_and_add_folio(struct vm_fault *vmf,
>>    	struct shmem_inode_info *info = SHMEM_I(inode);
>>    	unsigned long suitable_orders = 0;
>>    	struct folio *folio = NULL;
>> +	pgoff_t aligned_index;
>>    	long pages;
>>    	int error, order;
>>    
>> @@ -1895,10 +1896,12 @@ static struct folio *shmem_alloc_and_add_folio(struct vm_fault *vmf,
>>    		order = highest_order(suitable_orders);
>>    		while (suitable_orders) {
>>    			pages = 1UL << order;
>> -			index = round_down(index, pages);
>> -			folio = shmem_alloc_folio(gfp, order, info, index);
>> -			if (folio)
>> +			aligned_index = round_down(index, pages);
>> +			folio = shmem_alloc_folio(gfp, order, info, aligned_index);
>> +			if (folio) {
>> +				index = aligned_index;
>>    				goto allocated;
>> +			}
> 
> Was the found by code inspection or was there a report about this?

Answering my own question, the "Link:" above should be

Closes: 
https://lore.kernel.org/linux-mm/CAMgjq7DqgAmj25nDUwwu1U2cSGSn8n4-Hqpgottedy0S6YYeUw@mail.gmail.com/


-- 
Cheers

David / dhildenb


