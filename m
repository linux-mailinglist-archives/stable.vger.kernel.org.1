Return-Path: <stable+bounces-58964-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2ABE92C97F
	for <lists+stable@lfdr.de>; Wed, 10 Jul 2024 06:07:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20B631C22A90
	for <lists+stable@lfdr.de>; Wed, 10 Jul 2024 04:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 271A93236;
	Wed, 10 Jul 2024 04:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OpLPNDfL"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74997482C8
	for <stable@vger.kernel.org>; Wed, 10 Jul 2024 04:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720584441; cv=none; b=Xlo+Mw8BcB2DaVbbA6wi1OO+cyd2h+oowrY6/z8ToW2v7rnqWx4fcMdeFxZcsBQBEcc6OpckDshY/Z0bNJ5U1KlxdTgIz0T+5/buDyl+dQDBnamuX/t5pwNGFaLeuylk2Ds0Et6o4Y36TTkj9Nxf052n0T7D1P2lZB1Fuzjd2Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720584441; c=relaxed/simple;
	bh=6C/zfirQyq6m6PQ2ie5sKNrqCqnMEGBVl959DNIy4sU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DzmOjqcz5NZ7RsywQDbVAxINLj3Y9LzheyHy8UicON6UdJIB4Wh3EGAdlFoBlL14w5Z/0zXIoM2LF40rx0+jxaeEMrKwX0RGA6X/lzFk9+WAAKwWYhzceZ68slN8KyJUTqy0YS7sjDqjoe7nEkVrIme3Xf3qeSv+MvjADrkE9NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OpLPNDfL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720584439;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=4Hmp8L/082HRxXsOQKXBMeEH8mcc0CR8XLOKRVBeYOU=;
	b=OpLPNDfLa4ss8u+6gFYKfC/yt/Kfm8+It5BZ2ZeeGmD4e8IHFO3/ACQu0yDfm4FlQviuoZ
	rtFpJT7hIXsfQYJsiiG+b8OJWWRTJQjNGdjIb1oMky3a5k9bShA5j/4G0YtngW7odae5uj
	HoHQ3trTZA92uu7z0D5x1ZG4ucpUC/0=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-353-9urRGGgOPL-gPJ_cMZ54FQ-1; Wed, 10 Jul 2024 00:07:17 -0400
X-MC-Unique: 9urRGGgOPL-gPJ_cMZ54FQ-1
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1fb3b398923so29052235ad.2
        for <stable@vger.kernel.org>; Tue, 09 Jul 2024 21:07:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720584436; x=1721189236;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Hmp8L/082HRxXsOQKXBMeEH8mcc0CR8XLOKRVBeYOU=;
        b=OJBW3650bJjykLMfbroW7e8nS5E/GAKKLHr41DiAzHJ2Ktv0z49MOVxJVJ3eWWBgi5
         oZMnjX3D3Zns+uiMWut7Uzx6Y79OQI6+VqbaBU1mgJV0JWYuwqMWRInam4OOLZLi3/1H
         ViAZn52ceKhqA9Mp7LnM2+J13lprqX28ZmV47NG+6RadCNnt8JfxO8TMXfBTeP5mg6ql
         RQOCpmjUkk1cqHXuHy/TPSilcidwyeUCFtfuZ/YpTYV/6Dxtccdz/TQqcJVgzQ5eFMdZ
         IGsN1cZZQMrWaPrss+IHgG5oagJ75RRCfoD1WorK0LFoyEtO8SGUum+wYvbAHt44MPS3
         r+lA==
X-Forwarded-Encrypted: i=1; AJvYcCW2KcgAPIb10xESe5Z90WKVYLBn+v8sqaaS1+8tcrPb9tv4cSPTIBiOKH4FXD98XYSoxE1sveYIlPnO9B3Eh4238OF4MsCq
X-Gm-Message-State: AOJu0Yz+wnL6bkETjz+FVhxl3i0Nwge5wgB7D9ZId7Qvcmy4R+mqPp4A
	OKqD+Wsj9pNjtsJHESVJRrkq4UpOdTnq8uLMdUrGv8r9HaJLN/051UjSN8I0sRjxQgUF1URrWom
	ZQmUh9sfeEx8qPbSXs1I1Nqo43v3AOKWZ9XADAYQHPUxIfYC/rZLFbA==
X-Received: by 2002:a17:902:ec8a:b0:1fb:9b91:d7db with SMTP id d9443c01a7336-1fbb6d3d3b6mr44602045ad.19.1720584436223;
        Tue, 09 Jul 2024 21:07:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHVPYdr4bPLEq6M4tEtg9rbxzBv1IyFaW+LEhahGAul2R/CZttE0zE6k2ed4WL4HvkfL/CfIg==
X-Received: by 2002:a17:902:ec8a:b0:1fb:9b91:d7db with SMTP id d9443c01a7336-1fbb6d3d3b6mr44601915ad.19.1720584435800;
        Tue, 09 Jul 2024 21:07:15 -0700 (PDT)
Received: from [172.20.2.228] ([4.28.11.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6ab7d38sm23489205ad.137.2024.07.09.21.07.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jul 2024 21:07:15 -0700 (PDT)
Message-ID: <c3d96f76-abd2-48d6-a20b-86cdfb91f122@redhat.com>
Date: Wed, 10 Jul 2024 06:07:13 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: Fix PTE_AF handling in fault path on architectures
 with HW AF support
To: Ram Tummala <rtummala@nvidia.com>, akpm@linux-foundation.org,
 fengwei.yin@intel.com
Cc: willy@infradead.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 apopple@nvidia.com, stable@vger.kernel.org
References: <20240710000942.623704-1-rtummala@nvidia.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240710000942.623704-1-rtummala@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10.07.24 02:09, Ram Tummala wrote:
> Commit 3bd786f76de2 ("mm: convert do_set_pte() to set_pte_range()")
> replaced do_set_pte() with set_pte_range() and that introduced a regression
> in the following faulting path of non-anonymous vmas on CPUs with HW AF
> support.
> 
> handle_pte_fault()
>    do_pte_missing()
>      do_fault()
>        do_read_fault() || do_cow_fault() || do_shared_fault()
>          finish_fault()
>            set_pte_range()
> 
> The polarity of prefault calculation is incorrect. This leads to prefault
> being incorrectly set for the faulting address. The following if check will
> incorrectly clear the PTE_AF bit instead of setting it and the access will
> fault again on the same address due to the missing PTE_AF bit.
> 
>      if (prefault && arch_wants_old_prefaulted_pte())
>          entry = pte_mkold(entry);
> 
> On a subsequent fault on the same address, the faulting path will see a non
> NULL vmf->pte and instead of reaching the do_pte_missing() path, PTE_AF
> will be correctly set in handle_pte_fault() itself.
> 
> Due to this bug, performance degradation in the fault handling path will be
> observed due to unnecessary double faulting.
> 
> Cc: stable@vger.kernel.org
> Fixes: 3bd786f76de2 ("mm: convert do_set_pte() to set_pte_range()")
> Signed-off-by: Ram Tummala <rtummala@nvidia.com>
> ---

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


