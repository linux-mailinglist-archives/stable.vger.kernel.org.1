Return-Path: <stable+bounces-172925-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34982B357AF
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 10:54:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EB201B65DAE
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 08:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5597C1B6D08;
	Tue, 26 Aug 2025 08:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DoXDlZ6V"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450209460
	for <stable@vger.kernel.org>; Tue, 26 Aug 2025 08:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756198436; cv=none; b=AGGvLl4RHWCXYaD/kSzPIwABmAeVnYLsC7bB5PFDahv2+AXyDBevTgBdwPIAbumK/vFEbXPaxPzuEjAKmGWn4Zkj7pGPHYbUkRUH2J+6Rn+Z9RlZN7esLoMJgKkhfZE5zYk0bq1hz3cPJPxPBD+pUMRt+G4iS/0neL5UEEgTidg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756198436; c=relaxed/simple;
	bh=hEpRw+/vah2PpumkIjxYmiulDBSpy+OEMof98cfj5fA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aehclxiFxVXog8WLOV3frvcm1ZMgJDJEnkHtf/65dPR5mg0ZN9fsDNSrMnMEpNxadJbhEqnV8ZcbzR1iqwAacnlRCkOWmOxUqhsSR7gg39awSK56uTllIh4f/daxyGCjUQ3DTIBZKHzxHZ0yb1Rx3p4wF1HWgw2kxXA8RP5rM1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DoXDlZ6V; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756198433;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=APZznLybhVD19xT3RfskgWTFRpI96KkL2CP6iOiZhOc=;
	b=DoXDlZ6VbImGtbwKiokJdBHD8uolcOB2srUpOLzDtoR+abbJ+Hwee3MTEx6Ao2KJ54Ze2S
	vEQvjVwXqnTef9ZyGzmipsG8ZlU477nDSlr88OzqMA48cFzZKyXfM3ywb4VREL9+wgnp9v
	jzojQV/d1Kbvh8IOlhtrHeqiBABUGZc=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-hnm9BBkaNoSBsP9Zof_zgQ-1; Tue, 26 Aug 2025 04:53:49 -0400
X-MC-Unique: hnm9BBkaNoSBsP9Zof_zgQ-1
X-Mimecast-MFC-AGG-ID: hnm9BBkaNoSBsP9Zof_zgQ_1756198428
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-afcb7348249so468396566b.0
        for <stable@vger.kernel.org>; Tue, 26 Aug 2025 01:53:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756198428; x=1756803228;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=APZznLybhVD19xT3RfskgWTFRpI96KkL2CP6iOiZhOc=;
        b=b9W4dKcEbIZGMOvhzgI0RVW46ILbd13yI5xzvpIohpbSb7mDzi9ULS/XDb85FKVHfQ
         HG+jOhDnEkSp/hjttoBWuSNhHowoKYj7I/8I8SKoW3E9LqQWnMz8OG4EMoURm9Hrjdlw
         uPKEAzYCVOJ/L00wPyrDhjbt89qWR5WxfYcxipigWjyJ7AifRWuF+Mg3DzCZrAcaNriJ
         mLvZJcRszaHPabvjUirwqmjxjEsDmZ5kbyZJI2n98OX9dq8/cPHK4OjqLkYXy28P02YM
         SVn02NYhdh00y/O4MV2hb/gb/M5TDzoig85bfMKETUkvB7MtBYx7YtTk0XLOofyuCJeC
         RaxQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOsSv93mnNU6uK4AggNKA7JMHQ6vyCpX/WoXt4DZW8c5LiwMl3mNNScttoVzAN0z8eDVUAeqY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq6cnZAHAp4kK8U58B3hMN1AXnZ4OsqAPVwG0wr2mc1vp4NFhR
	yqSxT4veYko+5EdyVyy5+wSzYUbvw3E3pR3iFMsVAmMvq/P0+ceFkeuqlt1PRylShQ4wDE3X4UX
	DQji3TtzPhPKi0PAB63vbyl8D+hLuC/xQjKvRamE3ZQaETUdq6CjWJfZDeQ==
X-Gm-Gg: ASbGncvVf0RvMOwQ1vj65gfBEXUmWwFHlOuj8H97EzJFuwoo99W6jdLNdEFPvQZp+qR
	W2CyViPH+jzR8Vi2qNvV8M/MmeBrvEqyYUB3TAcvFzmvM1IwmX0Rg8DFYPTyX/z7qJsx2SE0Rje
	rCB4YqnlqLhSEnZwA/VrOmKtggG2ZhNcCOFXJcXt3Zwk/hDTJe+zaiZmudeGJNkn+GXc3S/o25e
	A6iPLuOn0Qn7hpNDSUCuPNqA4F6sKKIrsvUdpBkioqZ/U1b1PoOzkgr3bcUYuB3NkTaaEflZ82A
	1TLoa1RvZNEYQj6GZUtcarxCaNy/J0lBFrFHDTXKDP6ygg8GjT2kUViAYYYC8ci+Bw5o0tVuDA=
	=
X-Received: by 2002:a17:906:6a16:b0:afe:8bc8:d7bf with SMTP id a640c23a62f3a-afe8bc8d966mr450781966b.26.1756198428297;
        Tue, 26 Aug 2025 01:53:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFpl/o4mt0UnJPVGPS05+bdnJXcqQoJaT1Czt0kEXYHRDnKIHrYNNuzvosXE032ZUm5rLbSMg==
X-Received: by 2002:a17:906:6a16:b0:afe:8bc8:d7bf with SMTP id a640c23a62f3a-afe8bc8d966mr450780166b.26.1756198427826;
        Tue, 26 Aug 2025 01:53:47 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61c310ab189sm6875327a12.8.2025.08.26.01.53.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Aug 2025 01:53:47 -0700 (PDT)
Message-ID: <0a2004c2-76e7-43ea-be47-b6c957e0fc14@redhat.com>
Date: Tue, 26 Aug 2025 10:53:45 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/khugepaged: fix the address passed to notifier on
 testing young
To: Wei Yang <richard.weiyang@gmail.com>, akpm@linux-foundation.org,
 lorenzo.stoakes@oracle.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
 npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org
Cc: linux-mm@kvack.org, "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 stable@vger.kernel.org
References: <20250822063318.11644-1-richard.weiyang@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250822063318.11644-1-richard.weiyang@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22.08.25 08:33, Wei Yang wrote:
> Commit 8ee53820edfd ("thp: mmu_notifier_test_young") introduced
> mmu_notifier_test_young(), but we should pass the address need to test.

... "but we are passing the wrong address".

> In xxx_scan_pmd(), the actual iteration address is "_address" not
> "address". We seem to misuse the variable on the very beginning.
> 
> Change it to the right one.
> 
> Fixes: 8ee53820edfd ("thp: mmu_notifier_test_young")
> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> Cc: Liam R. Howlett <Liam.Howlett@oracle.com>
> Cc: Nico Pache <npache@redhat.com>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: Dev Jain <dev.jain@arm.com>
> Cc: Barry Song <baohua@kernel.org>
> CC: <stable@vger.kernel.org>
> 
> ---
> The original commit 8ee53820edfd is at 2011.
> Then the code is moved to khugepaged.c in commit b46e756f5e470 ("thp:
> extract khugepaged from mm/huge_memory.c") in 2022.
> ---
>   mm/khugepaged.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 24e18a7f8a93..b000942250d1 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -1418,7 +1418,7 @@ static int hpage_collapse_scan_pmd(struct mm_struct *mm,
>   		if (cc->is_khugepaged &&
>   		    (pte_young(pteval) || folio_test_young(folio) ||
>   		     folio_test_referenced(folio) || mmu_notifier_test_young(vma->vm_mm,
> -								     address)))
> +								     _address)))

Please just put that into a single line, that's a perfectly reasonable 
case to exceed 80 chars.


Acked-by: David Hildenbrand <david@redhat.com>

>   			referenced++;
>   	}
>   	if (!writable) {

Maybe, just maybe, it's because of *horrible* variable naming.

Can someone please send a cleanup to rename address -> pmd_addr and
_address -> pte_addr or sth like that?

pretty much any naming is better than this.

-- 
Cheers

David / dhildenb


