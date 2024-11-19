Return-Path: <stable+bounces-94017-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D1BE9D284A
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 15:35:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DC29282CC7
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 14:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB96B1CCEC6;
	Tue, 19 Nov 2024 14:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UxxdH3Hc"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C8414658D
	for <stable@vger.kernel.org>; Tue, 19 Nov 2024 14:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732026939; cv=none; b=n9CUxd/TsI8l0u5lxrJupjP8SjQ/3loORMb0UIQACkMKXMj5hIFh5ZJJcn54HvsVi3ciBXvnN8n2yrVx1j+B+D0Xz+LhEcpSuNoXJR7mJgaN33F9bikhr7oXD2WsLPfjyDGV8eFTwPNXG3FEdKvisCrWrqHeGLt0ny1GAPeiY0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732026939; c=relaxed/simple;
	bh=inyP8EzpXjrTYOwbBZhVZakTi62ByPip/mFB2T5+hAk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gD3Hl7JWfwkso+wLwnA1FK0zRCtOjUDmHXoc/u6PmymdJAnBSByYAKlSDffnJhjC5ELHXx/QlAans/XSgQNHuSTzPyKHh+rEmkREa0HIEGgKufmlaj9Hen+wSYhAQZ3J3ixJO68fIS5lPyioLqnFw+nN67FghT9jNo+cpLjPrqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UxxdH3Hc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732026936;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=JKx890WpfnsU0/gagsqAu/7bg4tMVV8GUtdV3TL7xsM=;
	b=UxxdH3Hc3xxHGVkKbPSchB0vztmPosD97VhIDHDqHVXarC/0h9H49NOP/0OFHg3a8+u9ty
	Vyq7ZcylmRcPVgCtWq+3oyr0AA+RxELHUywJrzcjog6iFM3FGYTVJPXgKRA/P+90V5/iMS
	V+1Tz51CovcItTC3pvDfB7y1u7uMB7Y=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-W4otyrVuPiWGk1PT-Uz1vw-1; Tue, 19 Nov 2024 09:35:35 -0500
X-MC-Unique: W4otyrVuPiWGk1PT-Uz1vw-1
X-Mimecast-MFC-AGG-ID: W4otyrVuPiWGk1PT-Uz1vw
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4314a22ed8bso29026355e9.1
        for <stable@vger.kernel.org>; Tue, 19 Nov 2024 06:35:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732026934; x=1732631734;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JKx890WpfnsU0/gagsqAu/7bg4tMVV8GUtdV3TL7xsM=;
        b=PyXFI3ke8iawjlnGpJAuABlpHXkGSrHIHzzwwDhTmcK1hMUPYv8X6vblt0GoJTQhkU
         VHuhfSpyLobR1Pt10HDN+g9r5unZq5oPWVkrkh/CGB7QP6Leh9gBdlEfwiBufOmMbMAO
         NNhrzMN4PBvMnvdUFM1CmGFWZmNy9LGajgBPZ4VJFDyTrPvBebbxxZ7zhceREDSwarKt
         /tHAvjR5sRZTYGLXdiLLIWlT5Vtrl8DIU9bSQ2WKDW5l455LV8H4NvPSrl+IPv0/5xMy
         nfwAxcWsFMRsuGvVCgf5PGc/oi70U3VHmSPnE1ThozCjiXb+uSvs7k2JRKBTaRXyIPqt
         p1BQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpEHaHmPEEK1kmO+K0wrmuKXo808aFYHnAf/RD6dZt5L2BV6iouiy5jCD9e1FeB10ZivrIYkI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYIv+mckxBJh/frBBA3urcgPjGn15iu3T9eG2yZv4+4IWrbvTX
	nGOloanIQh06KgnXGxP9AvKlSwdQkqGvPqxKDsYIFTy01LYexlFf+ocUfODJFmSGeQ5qUw5Zykn
	cP1ECehdsumQz4xHRxB1I37D68GGylWvdLZcAbGJyq+a2gLBSRmsR0Q==
X-Received: by 2002:a05:600c:5492:b0:431:5d89:646e with SMTP id 5b1f17b1804b1-432df792df0mr123888915e9.32.1732026934044;
        Tue, 19 Nov 2024 06:35:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGWNHgoarbx3hUcQezjymarz8pGO7PL0597K0482rDOTfSC0yJPFVaW9DwAPbLFRBl1lqybvA==
X-Received: by 2002:a05:600c:5492:b0:431:5d89:646e with SMTP id 5b1f17b1804b1-432df792df0mr123888685e9.32.1732026933695;
        Tue, 19 Nov 2024 06:35:33 -0800 (PST)
Received: from ?IPV6:2003:cb:c74b:d000:3a9:de5c:9ae6:ccb3? (p200300cbc74bd00003a9de5c9ae6ccb3.dip0.t-ipconnect.de. [2003:cb:c74b:d000:3a9:de5c:9ae6:ccb3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432dab80582sm195595185e9.19.2024.11.19.06.35.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Nov 2024 06:35:33 -0800 (PST)
Message-ID: <db6e1966-3824-45cd-8cae-740348780002@redhat.com>
Date: Tue, 19 Nov 2024 15:35:31 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm: Respect mmap hint address when aligning for THP
To: Kalesh Singh <kaleshsingh@google.com>
Cc: kernel-team@android.com, android-mm@google.com,
 Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>,
 Yang Shi <yang@os.amperecomputing.com>, Rik van Riel <riel@surriel.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Suren Baghdasaryan <surenb@google.com>,
 Minchan Kim <minchan@kernel.org>, Hans Boehm <hboehm@google.com>,
 Lokesh Gidra <lokeshgidra@google.com>, stable@vger.kernel.org,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Jann Horn <jannh@google.com>,
 Yang Shi <shy828301@gmail.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20241118214650.3667577-1-kaleshsingh@google.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20241118214650.3667577-1-kaleshsingh@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18.11.24 22:46, Kalesh Singh wrote:
> Commit efa7df3e3bb5 ("mm: align larger anonymous mappings on THP
> boundaries") updated __get_unmapped_area() to align the start address
> for the VMA to a PMD boundary if CONFIG_TRANSPARENT_HUGEPAGE=y.
> 
> It does this by effectively looking up a region that is of size,
> request_size + PMD_SIZE, and aligning up the start to a PMD boundary.
> 
> Commit 4ef9ad19e176 ("mm: huge_memory: don't force huge page alignment
> on 32 bit") opted out of this for 32bit due to regressions in mmap base
> randomization.
> 
> Commit d4148aeab412 ("mm, mmap: limit THP alignment of anonymous
> mappings to PMD-aligned sizes") restricted this to only mmap sizes that
> are multiples of the PMD_SIZE due to reported regressions in some
> performance benchmarks -- which seemed mostly due to the reduced spatial
> locality of related mappings due to the forced PMD-alignment.
> 
> Another unintended side effect has emerged: When a user specifies an mmap
> hint address, the THP alignment logic modifies the behavior, potentially
> ignoring the hint even if a sufficiently large gap exists at the requested
> hint location.
> 
> Example Scenario:
> 
> Consider the following simplified virtual address (VA) space:
> 
>      ...
> 
>      0x200000-0x400000 --- VMA A
>      0x400000-0x600000 --- Hole
>      0x600000-0x800000 --- VMA B
> 
>      ...
> 
> A call to mmap() with hint=0x400000 and len=0x200000 behaves differently:
> 
>    - Before THP alignment: The requested region (size 0x200000) fits into
>      the gap at 0x400000, so the hint is respected.
> 
>    - After alignment: The logic searches for a region of size
>      0x400000 (len + PMD_SIZE) starting at 0x400000.
>      This search fails due to the mapping at 0x600000 (VMA B), and the hint
>      is ignored, falling back to arch_get_unmapped_area[_topdown]().
> 
> In general the hint is effectively ignored, if there is any
> existing mapping in the below range:
> 
>       [mmap_hint + mmap_size, mmap_hint + mmap_size + PMD_SIZE)
> 
> This changes the semantics of mmap hint; from ""Respect the hint if a
> sufficiently large gap exists at the requested location" to "Respect the
> hint only if an additional PMD-sized gap exists beyond the requested size".
> 
> This has performance implications for allocators that allocate their heap
> using mmap but try to keep it "as contiguous as possible" by using the
> end of the exisiting heap as the address hint. With the new behavior
> it's more likely to get a much less contiguous heap, adding extra
> fragmentation and performance overhead.
> 
> To restore the expected behavior; don't use thp_get_unmapped_area_vmflags()
> when the user provided a hint address, for anonymous mappings.
> 
> Note: As, Yang Shi, pointed out: the issue still remains for filesystems
> which are using thp_get_unmapped_area() for their get_unmapped_area() op.
> It is unclear what worklaods will regress for if we ignore THP alignment
> when the hint address is provided for such file backed mappings -- so this
> fix will be handled separately.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Yang Shi <yang@os.amperecomputing.com>
> Cc: Rik van Riel <riel@surriel.com>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: Suren Baghdasaryan <surenb@google.com>
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Hans Boehm <hboehm@google.com>
> Cc: Lokesh Gidra <lokeshgidra@google.com>
> Cc: <stable@vger.kernel.org>
> Fixes: efa7df3e3bb5 ("mm: align larger anonymous mappings on THP boundaries")
> Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
> Reviewed-by: Rik van Riel <riel@surriel.com>
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> ---

LGTM. Hopefully that's the end of this story :)

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


