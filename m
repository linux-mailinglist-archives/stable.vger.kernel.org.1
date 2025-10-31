Return-Path: <stable+bounces-191800-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 106D5C24691
	for <lists+stable@lfdr.de>; Fri, 31 Oct 2025 11:20:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 749F24F26E3
	for <lists+stable@lfdr.de>; Fri, 31 Oct 2025 10:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B527433FE03;
	Fri, 31 Oct 2025 10:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EbyfUn/U"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8CA33F8BA
	for <stable@vger.kernel.org>; Fri, 31 Oct 2025 10:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761906000; cv=none; b=iZLYLyjdQlj3POvpjRGNMn3FmyOmkQU8k1Kzbhns+LxkggCrEo4UbxHN66gfpBgokE7hkL5gkXedJZoV69FCQ7r6LZtwYJAEuhy9x4OZ45xFkwnj54cM+SgzlTkuR3+8FjZjam40hVXk8aHPXHUvddKFyu5jTv9RiCopx8/FtNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761906000; c=relaxed/simple;
	bh=Futz9rPqdcpNZR/dNrHDdyBGLoH2jmV0bTLWGdXsz4c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R1Q6ZXRgIUNO5wIIB66VW6S1qb/AfXqtnai0nALrOrSEf6r2/fDjq7ustZVwSiNdZsXg5jTEX9AF659SLFsY2Y8HuXLIfxpC2kH1CVVvtm2zJFDmJQrDgsqQZMn0/HYXSVQBXWNJYfh7bhknzCz3MJLukuDQdeYi1XypEA0IJs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EbyfUn/U; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761905997;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=OUhdGI6/kAp9JoyXZrueKpHAebmQrRzAuLyMXHq++7U=;
	b=EbyfUn/UiroGuNmE3s2sKxsZPuMSdE0ZvSKn1dTAT37rbkA6KWe91Wi0NYkb+ykbhOlR3k
	SKf7kPydnRQZ9WzQJOABxZOS6Hk48rvInKa6BEXDqAX+h6+M90i4f+zQKpOzh88J+8badE
	OXy083apVMUnHIil+9he1I/lySJFav8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-387-jdcIRq6OOIGKEq-UiC0Vog-1; Fri, 31 Oct 2025 06:19:54 -0400
X-MC-Unique: jdcIRq6OOIGKEq-UiC0Vog-1
X-Mimecast-MFC-AGG-ID: jdcIRq6OOIGKEq-UiC0Vog_1761905993
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-429bf2f85faso463998f8f.0
        for <stable@vger.kernel.org>; Fri, 31 Oct 2025 03:19:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761905993; x=1762510793;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OUhdGI6/kAp9JoyXZrueKpHAebmQrRzAuLyMXHq++7U=;
        b=ng0FPbi+tdF9a5DghHKF4tUzN3n0pHekpBIQDAFUFNljP2ohtFMwf1kQDd5XAWTAoH
         qNhyEzydpRCY6T5cBnzM3U01yaBGWeLKwJR0jgxRvEEp2PD7RvJS5z8lrYgE8ZqYHU0W
         rA8Ae38d89LvfAV65+3qs46F0xZz0h5T5ANsE2gpLPwjJQ6gp8zRo6EuD2VXkkOPWhav
         LUhiaDSAbj7Z1jy4Q/rrMxIZOT+7i0dEve+uK8bDMXdLRi4aQQ3H+pXwAc5pW4lEkPII
         pchlSTTSPMD29gf8EfVX0YSgyCmXDDFS8J0whYL8GdIH/nNE9FKHcIRS8lJy+GzW7H7O
         HZQQ==
X-Forwarded-Encrypted: i=1; AJvYcCV76d69AdcH7OXzeye7/K4faahgNGu+tU60cODt4SIOgHvnfruYtDSam62OAnng7dYeRXev8Uw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnYWAdXrua98TnV7/ocMx1I0Ogg4IAp99r/uZdEq+tZE7T2E/g
	LGEyjQkdUnp/3O8zVnsXDSEeXFnXclnO/A21xsGJHhwCUTCE5G4F9rze2PCuHOIHc3LK+CTd1Zf
	Be8nSVs5Tttvi8+Nj1IWZh7JBS2wb/n4zDYZM8ol6Irg5I/hFRGzXB+MwDQ==
X-Gm-Gg: ASbGncttKVXImNK5Ysobu0ilKGGeSNHRCWBBhDchzscdZBppACnTNxjBr0OnJjaVQWQ
	9cs+f1XqkndB1wYh9gNma9rkLC6g3O82QnMc0kjuGeN1sQKmdilg21VlFUQqc2Hl0xL8O8BtPus
	gHvp6VeiEQinJG+C6+Eaj19r8zKkV7VsrZTtHFFH97TAhM8vUZ8dRZSndF2/pbOd6PRUYeuwBEp
	ggWM368+FZODCIL5aVVhz24Vejgz4u7XlVO+InRZeGPCoNHeObP72I0cEKXkkKHmIeRMNmAxkCG
	KzudztqgjEzP4HoEX5r+QBFzNu7FZLBOvgMhkqad+pfNEQJS7C++6Ck376xOU/akQqtIHJF/9CG
	jMfdO6J7pB/Z7c8+AbksYMmJZpYC4g4NrtbpI/BGGFdCZeQ5FOpJ3rp7k1Z8+SNx0rjHMhNgEon
	2sFJ0QkqF1+eVSRMYRSDUec8GJoRI=
X-Received: by 2002:a5d:5d85:0:b0:426:dac0:8ee8 with SMTP id ffacd0b85a97d-429bcd05203mr2998221f8f.10.1761905993331;
        Fri, 31 Oct 2025 03:19:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH8jpSFh3hhPp3PzJX0f48uDqqqBw7iyd7GjZkB/l1xZ2kBNbllkQmlUEXSQLnQvjsz9LvTiQ==
X-Received: by 2002:a5d:5d85:0:b0:426:dac0:8ee8 with SMTP id ffacd0b85a97d-429bcd05203mr2998195f8f.10.1761905992898;
        Fri, 31 Oct 2025 03:19:52 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f3f:4b00:ee13:8c22:5cc5:d169? (p200300d82f3f4b00ee138c225cc5d169.dip0.t-ipconnect.de. [2003:d8:2f3f:4b00:ee13:8c22:5cc5:d169])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429c13e0311sm2647741f8f.30.2025.10.31.03.19.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Oct 2025 03:19:52 -0700 (PDT)
Message-ID: <38f0ff98-3dcd-4dc2-87f1-3ea34bb9935a@redhat.com>
Date: Fri, 31 Oct 2025 11:19:50 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] mm/secretmem: fix use-after-free race in fault
 handler
To: Mike Rapoport <rppt@kernel.org>, Lance Yang <lance.yang@linux.dev>
Cc: akpm@linux-foundation.org, big-sleep-vuln-reports@google.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 lorenzo.stoakes@oracle.com, willy@infradead.org, stable@vger.kernel.org
References: <CAEXGt5QeDpiHTu3K9tvjUTPqo+d-=wuCNYPa+6sWKrdQJ-ATdg@mail.gmail.com>
 <20251031091818.66843-1-lance.yang@linux.dev> <aQSIdCpf-2pJLwAF@kernel.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <aQSIdCpf-2pJLwAF@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 31.10.25 10:59, Mike Rapoport wrote:
> On Fri, Oct 31, 2025 at 05:18:18PM +0800, Lance Yang wrote:
>> From: Lance Yang <lance.yang@linux.dev>
>>
>> The error path in secretmem_fault() frees a folio before restoring its
>> direct map status, which is a race leading to a panic.
> 
> Let's use the issue description from the report:
> 
> When a page fault occurs in a secret memory file created with
> `memfd_secret(2)`, the kernel will allocate a new folio for it, mark
> the underlying page as not-present in the direct map, and add it to
> the file mapping.
> 
> If two tasks cause a fault in the same page concurrently, both could
> end up allocating a folio and removing the page from the direct map,
> but only one would succeed in adding the folio to the file
> mapping. The task that failed undoes the effects of its attempt by (a)
> freeing the folio again and (b) putting the page back into the direct
> map. However, by doing these two operations in this order, the page
> becomes available to the allocator again before it is placed back in
> the direct mapping.
> 
> If another task attempts to allocate the page between (a) and (b), and
> the kernel tries to access it via the direct map, it would result in a
> supervisor not-present page fault.
>   
>> Fix the ordering to restore the map before the folio is freed.
> 
> ... restore the direct map
> 
> With these changes
> 
> Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Fully agreed

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb


