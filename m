Return-Path: <stable+bounces-116683-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44573A39649
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 10:00:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9A8616CBA8
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 08:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A6FC22D4E5;
	Tue, 18 Feb 2025 08:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="clxO81Zq"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512621EB1A6
	for <stable@vger.kernel.org>; Tue, 18 Feb 2025 08:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739868909; cv=none; b=NjOVFvMg6RZ5ppRck0C6XfcNV4Zd/Vw1cWtg9yw7Y60tBLHruvAM9JpOcKdAitNmhFG+Gc+vZLxQ8ZNejdIMO+QShhy/5SKEJzBCwGFEr94r3V4/bAvYncrNk085mm/E6jOHPx20Ao2wX7JzjubJj2F2GjlPZWKU7YoVTk2gxnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739868909; c=relaxed/simple;
	bh=wyo+DNeKX24yPz86D8zPeOTVB8dbEtWhhX1F/yV8fvE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XRdaL3uYHErTvTriv0Lh2gSC/FmlVhjOBPQyYM4+drjVk5UI4NnQnF4AaEr/0QCR2HQxICUCtqwlEo7EToU3oPzBaIcmF8Y8gW0QAEF2fu+Xp91ry0ySsoeu1Y4DTr1xzbT/2miRGj1Q97r4XWSKXK/8ffVsRA/0nsjU2ewPe+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=clxO81Zq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739868907;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=UFFus1oWqoyUZPw3Xk0cZbDYX9MY4kd682Ycm0D9p7E=;
	b=clxO81ZqteM6O8vSQoEPm/hQkO1jgzRPCQWU7JLeONiib2EQ1SiLiiPNeHpyQ7ed1zl6yw
	yUdIg4VPbrGU18veqON9sWetCiaC0eIMJqqaQ9ULXkrbobXtZD5/5VkAybt5vNna4WFXb/
	z8nUPCgrTTroJpn6el2TS9SwHiRXpqA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-195-ZQPd-jq4Oty8t0ianOe4eQ-1; Tue, 18 Feb 2025 03:55:04 -0500
X-MC-Unique: ZQPd-jq4Oty8t0ianOe4eQ-1
X-Mimecast-MFC-AGG-ID: ZQPd-jq4Oty8t0ianOe4eQ_1739868904
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43961fb0bafso26517455e9.2
        for <stable@vger.kernel.org>; Tue, 18 Feb 2025 00:55:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739868903; x=1740473703;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UFFus1oWqoyUZPw3Xk0cZbDYX9MY4kd682Ycm0D9p7E=;
        b=JAf6PAIbiL1BNrafoz/5ou+dhd9ltkyE0nGSI9iEy5IGneu/nyfpedaLrNKYgQIDtE
         htAZz/5TGTYzcQe6hQAT6RZG3qtib6o1Is+Mlj+usC05jP19IuSxe2R71Tttjd4FR6oX
         uI95PtfXWPlaUiQaXlQNCb+b2pJXdqLcYkqNCPwW+9errFZ+oo/5K21+EDX6bUHBooH7
         qHOuN3V4vxA30DZdamuwjxUk6j3dV2pIqUJtmayFKrpfjYa6YOWeRqbEH/Cyc2ihNVML
         S/5ko8Fn9syQNcpRCzUrtvRYA0jPzp5FhN+iOBkttVbk7KSAYV7bgDdRWzId1WRtP7aF
         ruRQ==
X-Forwarded-Encrypted: i=1; AJvYcCXOMvexbb2cAhrrlvviXmmqbeXkWQI3AQU9fXuAxFOTpvfEW2mk/DLGHj4o3ZNvU2KpOaVL97I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yww+/J1Zm2VtlsFrUxqJQ5b7jY8AhoIBFeZcF5twrwYMqKoTS5+
	dLaT3GE1s3ZKQHTIXMCFgo1DvVUPP+F+1dhSyDAtzKLdgixQCjgy+987/+cU5J9HiZuNwt9l9jx
	Xo08xFxVjmM+52ablCxFY6zsVhqaVJw51PfVXh0V8Y3ZB892Me9C5gw==
X-Gm-Gg: ASbGncsifx22IHmQfbAG9KbNVA1cf05nHya64X+cpr90gLsIWLfIikYV30BDMdzlQwN
	0O+Wmodsls7izIlQdZwEEfHli99LTU/TUKBDGdCrH2yNTBj9PFAVTb5bXJ2oXTKQ+jIfj2orW8o
	5Tq0b2DpeUfq4DnBTg8hmqkhKHS3yhWEP6CMixKPH3rUpjUoBqXIZbGRuTOD9M9zgNl5l4SITGX
	5gsT/hlY/GG9GszmCCCov9iJxrbNcFnVoL7lQSYSLNJ8J5o3vgeNwlG5GhUmJNSNaoxCuC2hoUN
	2R9rq4qbxUObdFZ4TEQ+KC6s73X5O/uaP1KI/Fod701YUZ0Su75koHSJtlfqXRU7FmjjINWU7er
	//AiCMmI5mPzEdSdgpAHlLomzMU52Ozd+
X-Received: by 2002:a05:6000:1569:b0:38f:5057:5810 with SMTP id ffacd0b85a97d-38f50575957mr2623386f8f.25.1739868903643;
        Tue, 18 Feb 2025 00:55:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEapAOSzbnTgE8PHXgWNcoR8rGw241hTyspFAst+fDNiZHY4OwVZpwEEqz1inQFu8uRiveKoQ==
X-Received: by 2002:a05:6000:1569:b0:38f:5057:5810 with SMTP id ffacd0b85a97d-38f50575957mr2623352f8f.25.1739868903272;
        Tue, 18 Feb 2025 00:55:03 -0800 (PST)
Received: from ?IPV6:2003:cb:c70d:fb00:d3ed:5f44:1b2d:12af? (p200300cbc70dfb00d3ed5f441b2d12af.dip0.t-ipconnect.de. [2003:cb:c70d:fb00:d3ed:5f44:1b2d:12af])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259f85c2sm14872740f8f.91.2025.02.18.00.55.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2025 00:55:02 -0800 (PST)
Message-ID: <2d0b01c5-a736-41d5-a0f7-db0da065d049@redhat.com>
Date: Tue, 18 Feb 2025 09:55:00 +0100
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
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <d043bdd2-a978-4a09-869e-b6e43f5ce409@126.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 15.02.25 06:50, Ge Yang wrote:
> 
> 
> 在 2025/2/14 16:08, David Hildenbrand 写道:
>> On 14.02.25 07:32, yangge1116@126.com wrote:
>>> From: Ge Yang <yangge1116@126.com>
>>>
>>> Since the introduction of commit b65d4adbc0f0 ("mm: hugetlb: defer
>>> freeing
>>> of HugeTLB pages"), which supports deferring the freeing of HugeTLB
>>> pages,
>>> the allocation of contiguous memory through cma_alloc() may fail
>>> probabilistically.
>>>
>>> In the CMA allocation process, if it is found that the CMA area is
>>> occupied
>>> by in-use hugepage folios, these in-use hugepage folios need to be
>>> migrated
>>> to another location. When there are no available hugepage folios in the
>>> free HugeTLB pool during the migration of in-use HugeTLB pages, new
>>> folios
>>> are allocated from the buddy system. A temporary state is set on the
>>> newly
>>> allocated folio. Upon completion of the hugepage folio migration, the
>>> temporary state is transferred from the new folios to the old folios.
>>> Normally, when the old folios with the temporary state are freed, it is
>>> directly released back to the buddy system. However, due to the deferred
>>> freeing of HugeTLB pages, the PageBuddy() check fails, ultimately leading
>>> to the failure of cma_alloc().
>>>
>>> Here is a simplified call trace illustrating the process:
>>> cma_alloc()
>>>       ->__alloc_contig_migrate_range() // Migrate in-use hugepage
>>>           ->unmap_and_move_huge_page()
>>>               ->folio_putback_hugetlb() // Free old folios
>>>       ->test_pages_isolated()
>>>           ->__test_page_isolated_in_pageblock()
>>>                ->PageBuddy(page) // Check if the page is in buddy
>>>
>>> To resolve this issue, we have implemented a function named
>>> wait_for_hugepage_folios_freed(). This function ensures that the hugepage
>>> folios are properly released back to the buddy system after their
>>> migration
>>> is completed. By invoking wait_for_hugepage_folios_freed() following the
>>> migration process, we guarantee that when test_pages_isolated() is
>>> executed, it will successfully pass.
>>
>> Okay, so after every successful migration -> put of src, we wait for the
>> src to actually get freed.
>>
>> When migrating multiple hugetlb folios, we'd wait once per folio.
>>
>> It reminds me a bit about pcp caches, where folios are !buddy until the
>> pcp was drained.
>>
> It seems that we only track unmovable, reclaimable, and movable pages on
> the pcp lists. For specific details, please refer to the
> free_frozen_pages() function.

It reminded me about PCP caches, because we effectively also have to 
wait for some stuck folios to properly get freed to the buddy.

-- 
Cheers,

David / dhildenb


