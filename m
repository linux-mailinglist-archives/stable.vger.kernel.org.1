Return-Path: <stable+bounces-116691-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7A27A3975B
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 10:45:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABFF53A6497
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 09:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8944022FF42;
	Tue, 18 Feb 2025 09:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Goq8RuS/"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6622922FF30
	for <stable@vger.kernel.org>; Tue, 18 Feb 2025 09:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739871724; cv=none; b=AC5qh/n06A5sMNYrw/SBChz+9zeUcvaDegBojlEJmZ1wcsYKVPPtX7xGxF8FApKuJYj+2uv4DABsis6OureNcODFZamBPXgJIsyvjtWS4yy0gLEc2GNRwbkI6kmhdPOvfag6WdO2OD+hyMLk+DM0oWSPNy4/C9CY8a8l5Gvri5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739871724; c=relaxed/simple;
	bh=wVGPaox1rquTlvbJhxatn2I1LdYx6lqWUIEj7tD2WE4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NYf9n3wlkcA8NkODLqR7THXFc9K1JQ0kXAhNz4qAd7EF0Sowauib9O+wDllObGm/hjnz/O2YuXDYJLdRaHvdj9lWWGNBMplXJPry1iOVVX6P7u9TsajJ/o5FLAqkzpdp/Fd62oyaZ3H4p2uQIPGwpfX9CyikYBnfhCKRLXchmzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Goq8RuS/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739871721;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=M30K112iXvL+buuCd+uGjdadu2X+xHSjfHAUWZF/zVk=;
	b=Goq8RuS/AmCVqmoF/fvvyMRQWeN4jqHs24qEoG1IF8aDAnJfo0COyr5qBWES3wpnw9iPmj
	kGnOUBwMPcGECXLG7DvoFYTZWIXbmyNtpTzvQDSiZWp+SVDqdqh1jKRD3NQMRK8p5YoyGW
	vgKOh8n8LvO4zI1shTNYYrX4qdgS6Js=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-NpCnxpcSPjOAN8Lr4hpFbQ-1; Tue, 18 Feb 2025 04:41:59 -0500
X-MC-Unique: NpCnxpcSPjOAN8Lr4hpFbQ-1
X-Mimecast-MFC-AGG-ID: NpCnxpcSPjOAN8Lr4hpFbQ_1739871719
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-38f29b4d4adso2396866f8f.3
        for <stable@vger.kernel.org>; Tue, 18 Feb 2025 01:41:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739871718; x=1740476518;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=M30K112iXvL+buuCd+uGjdadu2X+xHSjfHAUWZF/zVk=;
        b=Nxeax8NGIRQGJwVwTozypxUxXafKliKjN+E/eh3qD3kb9FOob8S27mrP8jrrdHFLDb
         PEdNowqZTybC8HUYIUqSAZfAZ3MVRQShwDNZBcKcX/sP8hPGe36E5ZeWAIyPxBw0L7AP
         bMrvut4NFu4sRFPhyOwtHTTG95km4Hz6rTk4UFgU0G0+zOjqVsOzdCBjPO2KscrdHy/Z
         iUiSU8KW/zMQYfgUy4hr+hcEvWLhj7y4iGn0nqZfst151RLpUE+90cysqZkMSRlGsHQk
         /5oOtfakjm422MP9Eb9HLbV3FCO3WDW4eV3DSnFN4Hcbxco2JRhvRjugflstOIjr+kHw
         NcjA==
X-Forwarded-Encrypted: i=1; AJvYcCX/IPwldcdMhHNs7OAW9OYF876eH+qOuBQ+Ww774K3VIaCvu6tbC/pfm4/SLWYMgKrL5xs74n4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9DWNzRhC+yf1Yo9ENbXJ7K5DX21Ula0D+0IYS/8q7/+bCWFyW
	C6DB6ecVhxepaWLNcIQbyHJZ1v6ONkg2vSI2x5+xNMuMcattccgKpXb3MXVutccSBdcik8t58a6
	YWoI3A4Kd3gja25RC9C34NUuerbFoyrHQ3AFroFX64AGjEAIG6yT8iA==
X-Gm-Gg: ASbGnctdvLekLdvurjZpZVcGImovgFbeqClKfe+k6zf/M6awzFsdhkMKQpFEoQaQ2LB
	XygOBUVJ9q4dLYFxM+LxifaIb6Ufq6iodrovHdWLh4kIq1cCUkzacM24afNfLSKbOzc4LWPuquJ
	QJVDJptCSizvn07vHXXnIX8PH1IY/Bfe2Sv2x1GFe+IRvZH37xy/I/K5dgkYRsJoGFIl831Dq8i
	/ie7Ri2rAyOAXGjhvHeS4s8BWnfm3dlxu2cnZ7SnnCFyHnqs48YJypRiWKNGZgT7XbSyu7LcwLq
	XaypwIHSN61trw+cUjWDaKV9ta+EnBzSDA==
X-Received: by 2002:a5d:414b:0:b0:38d:cbc2:29f6 with SMTP id ffacd0b85a97d-38f33f28bd8mr7954078f8f.17.1739871718567;
        Tue, 18 Feb 2025 01:41:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFiC6dZBgkU4sXkLmMtGBhraG+XvqU3eQxB9VGznunCnea9qEzoayTCOPvHJX0afs4UaG5+ng==
X-Received: by 2002:a5d:414b:0:b0:38d:cbc2:29f6 with SMTP id ffacd0b85a97d-38f33f28bd8mr7954051f8f.17.1739871718141;
        Tue, 18 Feb 2025 01:41:58 -0800 (PST)
Received: from [192.168.3.141] (p5b0c61a2.dip0.t-ipconnect.de. [91.12.97.162])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259f8273sm14184140f8f.89.2025.02.18.01.41.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2025 01:41:57 -0800 (PST)
Message-ID: <048ca765-bf44-46ab-87d4-328dc0979159@redhat.com>
Date: Tue, 18 Feb 2025 10:41:56 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/hugetlb: wait for hugepage folios to be freed
To: Ge Yang <yangge1116@126.com>, akpm@linux-foundation.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 21cnbao@gmail.com, baolin.wang@linux.alibaba.com, muchun.song@linux.dev,
 osalvador@suse.de, liuzixing@hygon.cn
References: <1739514729-21265-1-git-send-email-yangge1116@126.com>
 <37363b17-88b0-4ccc-a115-8c9f1d83a1b5@redhat.com>
 <d043bdd2-a978-4a09-869e-b6e43f5ce409@126.com>
 <2d0b01c5-a736-41d5-a0f7-db0da065d049@redhat.com>
 <406c6713-356b-4acf-bcd0-e5a6c1e9adcf@126.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <406c6713-356b-4acf-bcd0-e5a6c1e9adcf@126.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 18.02.25 10:22, Ge Yang wrote:
> 
> 
> 在 2025/2/18 16:55, David Hildenbrand 写道:
>> On 15.02.25 06:50, Ge Yang wrote:
>>>
>>>
>>> 在 2025/2/14 16:08, David Hildenbrand 写道:
>>>> On 14.02.25 07:32, yangge1116@126.com wrote:
>>>>> From: Ge Yang <yangge1116@126.com>
>>>>>
>>>>> Since the introduction of commit b65d4adbc0f0 ("mm: hugetlb: defer
>>>>> freeing
>>>>> of HugeTLB pages"), which supports deferring the freeing of HugeTLB
>>>>> pages,
>>>>> the allocation of contiguous memory through cma_alloc() may fail
>>>>> probabilistically.
>>>>>
>>>>> In the CMA allocation process, if it is found that the CMA area is
>>>>> occupied
>>>>> by in-use hugepage folios, these in-use hugepage folios need to be
>>>>> migrated
>>>>> to another location. When there are no available hugepage folios in the
>>>>> free HugeTLB pool during the migration of in-use HugeTLB pages, new
>>>>> folios
>>>>> are allocated from the buddy system. A temporary state is set on the
>>>>> newly
>>>>> allocated folio. Upon completion of the hugepage folio migration, the
>>>>> temporary state is transferred from the new folios to the old folios.
>>>>> Normally, when the old folios with the temporary state are freed, it is
>>>>> directly released back to the buddy system. However, due to the
>>>>> deferred
>>>>> freeing of HugeTLB pages, the PageBuddy() check fails, ultimately
>>>>> leading
>>>>> to the failure of cma_alloc().
>>>>>
>>>>> Here is a simplified call trace illustrating the process:
>>>>> cma_alloc()
>>>>>        ->__alloc_contig_migrate_range() // Migrate in-use hugepage
>>>>>            ->unmap_and_move_huge_page()
>>>>>                ->folio_putback_hugetlb() // Free old folios
>>>>>        ->test_pages_isolated()
>>>>>            ->__test_page_isolated_in_pageblock()
>>>>>                 ->PageBuddy(page) // Check if the page is in buddy
>>>>>
>>>>> To resolve this issue, we have implemented a function named
>>>>> wait_for_hugepage_folios_freed(). This function ensures that the
>>>>> hugepage
>>>>> folios are properly released back to the buddy system after their
>>>>> migration
>>>>> is completed. By invoking wait_for_hugepage_folios_freed() following
>>>>> the
>>>>> migration process, we guarantee that when test_pages_isolated() is
>>>>> executed, it will successfully pass.
>>>>
>>>> Okay, so after every successful migration -> put of src, we wait for the
>>>> src to actually get freed.
>>>>
>>>> When migrating multiple hugetlb folios, we'd wait once per folio.
>>>>
>>>> It reminds me a bit about pcp caches, where folios are !buddy until the
>>>> pcp was drained.
>>>>
>>> It seems that we only track unmovable, reclaimable, and movable pages on
>>> the pcp lists. For specific details, please refer to the
>>> free_frozen_pages() function.
>>
>> It reminded me about PCP caches, because we effectively also have to
>> wait for some stuck folios to properly get freed to the buddy.
>>
> It seems that when an isolated page is freed, it won't be placed back
> into the PCP caches.

I recall there are cases when the page was in the pcp before the 
isolation started, which is why we drain the pcp at some point (IIRC).

-- 
Cheers,

David / dhildenb


