Return-Path: <stable+bounces-151615-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A4CF6AD0270
	for <lists+stable@lfdr.de>; Fri,  6 Jun 2025 14:44:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 026A0188F87F
	for <lists+stable@lfdr.de>; Fri,  6 Jun 2025 12:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E7A228853C;
	Fri,  6 Jun 2025 12:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CLtUpVPe"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7112356B9
	for <stable@vger.kernel.org>; Fri,  6 Jun 2025 12:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749213846; cv=none; b=e0NJITKMpsOW2Nbzlek4tXObAp5j/pSYc/IfVloKI7LgaCCo1sHjAOElCrtOERaeX4L9hLIafPwSWQda4ZHVn+o9X56HaGMPp3FZLhjGBk4hN4zlNg0I7JSwO4H71pVwO0TGb5znwBid3sjk7ykCPzC4hndgfZMbBWnp3tPfKWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749213846; c=relaxed/simple;
	bh=K+fyfi/7cEPPZS+4gqzT7NBL7maJ3CTpPImf2Tt/67o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ItiXy9I3RTv4AlFir7VrJcSACGNuMzYTIHmrKqKhMyQ46YBd7n1BugFOLY7iQenbgLKlH44OzRPHjiCz/6fPsPRvJTE/pc87U1neYt5j3BEy+Up/HK+5x9S8bWbNmk0B0A2rG6aOOgp16mJClxVmF/5f9M+8nN3WQrtYbZQFuho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CLtUpVPe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749213843;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ar6SpSKanTLEMwpjfI2VMVmh2BTyW0PkU6fFk/apfzs=;
	b=CLtUpVPe6YNNy1+dniK4aD9AED0jOD2j4rFimxjhk7TL/pqrGnU5Ul6AMM5Pg3/WOItOIc
	6dtaNK/mV9aayXF65fYST4jGYc+r1fT0HBwnlR8BUJIipsLQLi4X8P7yImGfeIEQhFN4qp
	jlyJKx2NKFeli0g0Wm0fdXG/KVf43JE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-HSKh4252PL2JhTMFnqIAZg-1; Fri, 06 Jun 2025 08:44:02 -0400
X-MC-Unique: HSKh4252PL2JhTMFnqIAZg-1
X-Mimecast-MFC-AGG-ID: HSKh4252PL2JhTMFnqIAZg_1749213841
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-450d9f96f61so14651715e9.1
        for <stable@vger.kernel.org>; Fri, 06 Jun 2025 05:44:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749213841; x=1749818641;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ar6SpSKanTLEMwpjfI2VMVmh2BTyW0PkU6fFk/apfzs=;
        b=rhkDTXMiniGos6dTaNeV2FrDQ/lybWdO8JR3UgA0qelwP0ReMr/V+OKBXMJb3jhp+l
         9lozF9OyUBcFvz8uMz0Kcjs6y0padZ+vG5aJfr9qMsLabITPCFCUqwRSLSk+ZZbI0Ec5
         GSRy6Rg4ew4y1mNW7lTGSkJv1zTqhqQOOrc6ChG3hNZU/Zufo//43M2bkX1SCau99+qB
         DUem+1YkJ0kgEEa5OHzhr+SmX0gPv2SJFB6JBv+cwGTmbv1HTVw9tSELfBlEBicJb0rh
         Te2ZmPlZULpowNNOwi3++W0ZrJEghrB8wW9NFgcweaY6r74b5EQGZ0NrlNv76y7g2Tl6
         vDrQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQzFq226KCxc/yy0bSVBCFxTK/QEHi1z0lnIbnh3SDqXhZWuDV/B53NcjwjjuXLvfdjnTrtus=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzp4L9pMmR4zjUJ+hLPUukygAfyIvWLcapL8cCiLIK+I8vhnsb1
	M1XAAIYbkVKCSJTCn1+HtS+e2d2kXDJVRUHiAmWCnmpN+Hov+0G9a6lZ8c4BoOPdw4MXdIIm3GE
	FBsOeixXu/CLSbBCFue9iWwxV8QIOH7CHBIelQ2pbiWZ1sWDTXMHLcKOg8w==
X-Gm-Gg: ASbGncu/6Dscd7SUvhjQGnpugYZ7oxGrBwFtJNm140dDyIBSYdV1UzeiP9b98gisHio
	FYmUx4FojOn2Q3g2SHN6A69q4+9iF4Htzag0XEnSetj4V5tAKZWwyF8VDaR8mUR59kWRVVtqZJO
	BWrNvi3FXR5m/6dDhntGJZ0CwdZfUw+SpwwHlCc16wQqo1tLvWFMvqNdK4rfUTFpm1hUnctHh9j
	8x/FUIxh9M+9f6odHsRsymYtX+ClzouMYMz9zguaZUeNmXu9AeQwKzxjeXu6Ul1wec1Od9jZW5A
	lcR/Y1CdqO28/GE+sE/CtGUG0pAT9i/E8vbLgAbGxA+4wFmE4ryBgCxyNZb3BL7IOv/6OfKeS0U
	V8aIetr4rKAF8ztlAP4zBoPMUfl2r+Jcs144nPLkzzA==
X-Received: by 2002:a05:600c:1c83:b0:441:b5cb:4f94 with SMTP id 5b1f17b1804b1-4520136a9f3mr33012205e9.5.1749213840975;
        Fri, 06 Jun 2025 05:44:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHU8HkkhEPbHgrJMNZ4OfhFtq64ki74ST8iAN9Am0Inv9D8PpEDiwbPnzWb3zxKPDvGBs9jCA==
X-Received: by 2002:a05:600c:1c83:b0:441:b5cb:4f94 with SMTP id 5b1f17b1804b1-4520136a9f3mr33011955e9.5.1749213840553;
        Fri, 06 Jun 2025 05:44:00 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f19:9c00:568:7df7:e1:293d? (p200300d82f199c0005687df700e1293d.dip0.t-ipconnect.de. [2003:d8:2f19:9c00:568:7df7:e1:293d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4526e1595d4sm20040765e9.16.2025.06.06.05.43.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Jun 2025 05:44:00 -0700 (PDT)
Message-ID: <4f4fab59-abc2-4700-8477-edcb68d633df@redhat.com>
Date: Fri, 6 Jun 2025 14:43:58 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] mm: Close theoretical race where stale TLB entries
 could linger
To: Ryan Roberts <ryan.roberts@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
 Mel Gorman <mgorman@suse.de>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20250606092809.4194056-1-ryan.roberts@arm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250606092809.4194056-1-ryan.roberts@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06.06.25 11:28, Ryan Roberts wrote:
> Commit 3ea277194daa ("mm, mprotect: flush TLB if potentially racing with
> a parallel reclaim leaving stale TLB entries") described a theoretical
> race as such:
> 
> """
> Nadav Amit identified a theoritical race between page reclaim and
> mprotect due to TLB flushes being batched outside of the PTL being held.
> 
> He described the race as follows:
> 
> 	CPU0                            CPU1
> 	----                            ----
> 					user accesses memory using RW PTE
> 					[PTE now cached in TLB]
> 	try_to_unmap_one()
> 	==> ptep_get_and_clear()
> 	==> set_tlb_ubc_flush_pending()
> 					mprotect(addr, PROT_READ)
> 					==> change_pte_range()
> 					==> [ PTE non-present - no flush ]
> 
> 					user writes using cached RW PTE
> 	...
> 
> 	try_to_unmap_flush()
> 
> The same type of race exists for reads when protecting for PROT_NONE and
> also exists for operations that can leave an old TLB entry behind such
> as munmap, mremap and madvise.
> """
> 
> The solution was to introduce flush_tlb_batched_pending() and call it
> under the PTL from mprotect/madvise/munmap/mremap to complete any
> pending tlb flushes.
> 
> However, while madvise_free_pte_range() and
> madvise_cold_or_pageout_pte_range() were both retro-fitted to call
> flush_tlb_batched_pending() immediately after initially acquiring the
> PTL, they both temporarily release the PTL to split a large folio if
> they stumble upon one. In this case, where re-acquiring the PTL
> flush_tlb_batched_pending() must be called again, but it previously was
> not. Let's fix that.
> 
> There are 2 Fixes: tags here: the first is the commit that fixed
> madvise_free_pte_range(). The second is the commit that added
> madvise_cold_or_pageout_pte_range(), which looks like it copy/pasted the
> faulty pattern from madvise_free_pte_range().
> 
> This is a theoretical bug discovered during code review.
> 
> Cc: stable@vger.kernel.org
> Fixes: 3ea277194daa ("mm, mprotect: flush TLB if potentially racing with a parallel reclaim leaving stale TLB entries")
> Fixes: 9c276cc65a58 ("mm: introduce MADV_COLD")
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
> 
> Applies on today's mm-unstable (3f676fe5c7a0). All mm selftests continue to
> pass.
> 
> Thanks,
> Ryan

LGTM

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


