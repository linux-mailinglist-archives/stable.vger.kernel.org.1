Return-Path: <stable+bounces-186195-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 930E1BE533C
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 21:13:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D8ED3B5E67
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 19:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02C2428A3F2;
	Thu, 16 Oct 2025 19:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DwNNa1xl"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419E02641C6
	for <stable@vger.kernel.org>; Thu, 16 Oct 2025 19:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760642035; cv=none; b=lz6y7DGJcphhRHuaX8kB4oZZp/+OFeUyOLMbMGi+n+CJDFh9W1kjQRSd3A98vs0b1l618ZIZXIUxFMXTmlgvzbw0Md+Xfn6BgRSFN77yRqlGKxhOcNGZgGcoaPL/0iIbXTe5IRkNZahCbmytxb62ZlVWrNkeMU4enE+tufoO1qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760642035; c=relaxed/simple;
	bh=4qBipVPoBhYeIJEev22aR1xq5N8meGLNCefqEh/uhR4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kiQEoBtUDpcCIYmkBp0uJgFQgIl/eTK9zAykWYgo1inn3cm40EQtJaDz16o11PqgUP/Y3BQvHUXgqxavnM/IagmqaB05qqRtLz2PoQPu82aEiaZyAeoDJWA1ul0kN82wEqb9CqMh9O9HpYpj2fjuettSSN4RdPXN75RpmHJrcjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DwNNa1xl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760642033;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=JaZdjRa7yEZiZyCMhP1rrLiVtpOhbGtyEZuYlYpV77E=;
	b=DwNNa1xlsxzc3adw/mUYEc+FBpDbHUX5y2rSrMR2oYO9Nijm46za4j/v80Wq/c30s/wED7
	ijvurSDX+Fj+Iul+nE/TWz3itI7LKg5hR5q5Z9NDAF4NHekngaYOkPKd9G0qz/1eSSgikN
	0zeO1dyurTSKQ6Zz4VqhL60p9XNyB5Y=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-576-pwfC6IKsMwKJsFhjfNmgvQ-1; Thu, 16 Oct 2025 15:13:51 -0400
X-MC-Unique: pwfC6IKsMwKJsFhjfNmgvQ-1
X-Mimecast-MFC-AGG-ID: pwfC6IKsMwKJsFhjfNmgvQ_1760642031
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-47113dcc1e0so6927435e9.3
        for <stable@vger.kernel.org>; Thu, 16 Oct 2025 12:13:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760642030; x=1761246830;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JaZdjRa7yEZiZyCMhP1rrLiVtpOhbGtyEZuYlYpV77E=;
        b=Qul1mm0mDcxLg8nFIqcirIH8m3Uj55hTLOfWfe+VMnKwKMtbSqp/GaouoKYKO2jwnD
         dN3MdbcRyyQ4qA0H1WMqfJEk22KVOCs9QCje+oWoOUfi63eHg3lPiQQnPlk26SchOzV5
         YkS+35zULKkz2qcAzU8UT1dUsi3/NvD3h/agxhLt+/EVbe3wQQXk34YkuqI4o72Zq4Br
         IbmVu3AT5C3aPcEj0C8wgFmKjCb7w1ykceusq+hE3CqDG9AytOnKoeOmlOCkydUzvs+s
         GpLPsSfv7j63KYMrW9drgOEC5jIJkZvEwkWUtmQZ8luuFDTND0u3P3hxuHd7zzmV4Upf
         SuLw==
X-Forwarded-Encrypted: i=1; AJvYcCXLgN9+g7mT3VThN9yWRMWzOf6LxII7nUGcugtiLbowSd5js6ntv0rWZDqJfZoYYIw67PM41nM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyt+BAcF9YT3PQUYQRGOUDS4a0AX2/jw0sZ5SCu3W0UDaUfOvM0
	7BksiBrznC1bRpuDZxN2JMDiByYfOZEILHCAhfysBXjU3M2bhUDerF8AakE0w5UlS3ojNmIggz+
	5rlCVBXZYoNkW9NV3xupPTec7zqR4qp384XeJgOtbv6BuOHq7VVo88aiGoA==
X-Gm-Gg: ASbGnctS5H85luE0ysk3Io0Lt7MbwC1Zau7sbv1MFYbCmuPZYTjaQ5Ry4qYw+VRA/r0
	agnSoA0Wzi33G5nn/OGMajyLwaVLVerlV03k3OyYwHF7Dl03S2NF5Iz1DILaqk2SxSeB7yUdiv1
	nwzKVnic0pcxS5t4uK5ZdQJqeUVI4jGZWl6mjUDhfZA7u4q0zK7FbKitKGRzHIT12r5g+nKdRmh
	WAz4vwJn56b+6YFzNjAOdygB3UGwTf9UWoQasLvBfENoIh8XDS3NRoMcw6Ipo6Ah79E0XV3T1hY
	o0p1E65VURQJSNZJra59CtwsUyyAQ++RRXTXnmtGS026vtCdwbS35Vot33Qz2Ckj/3hxkhoaYAg
	zzrUH34E5aJUttTQJdtz7h04D7Y1zk6FPjAwLnEDJcZD8XQJycFrIuNiOR5wwOqcRlmI6nxAPgZ
	FDKrLlKHylqCJkgiCNNW0AFdzRlF8=
X-Received: by 2002:a05:600c:5287:b0:471:7a:7922 with SMTP id 5b1f17b1804b1-47117874a26mr10089155e9.6.1760642030625;
        Thu, 16 Oct 2025 12:13:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENXdoVpKL4SaZsI8wh6bbHQjJKXIIrDbzHNFmgs/sQ0Xp2kcBJz/Qzps/cepiaqf/0WuYRCQ==
X-Received: by 2002:a05:600c:5287:b0:471:7a:7922 with SMTP id 5b1f17b1804b1-47117874a26mr10088955e9.6.1760642030199;
        Thu, 16 Oct 2025 12:13:50 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f0c:c200:fa4a:c4ff:1b32:21ce? (p200300d82f0cc200fa4ac4ff1b3221ce.dip0.t-ipconnect.de. [2003:d8:2f0c:c200:fa4a:c4ff:1b32:21ce])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-471144d1765sm56096685e9.17.2025.10.16.12.13.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Oct 2025 12:13:49 -0700 (PDT)
Message-ID: <f9d4b143-be84-47ee-9ff9-43169ea592b6@redhat.com>
Date: Thu, 16 Oct 2025 21:13:48 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Bug: Performance regression in 1013af4f585f: mm/hugetlb: fix
 huge_pmd_unshare() vs GUP-fast race
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Jann Horn <jannh@google.com>, "Uschakow, Stanislav" <suschako@amazon.de>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>, "trix@redhat.com"
 <trix@redhat.com>, "ndesaulniers@google.com" <ndesaulniers@google.com>,
 "nathan@kernel.org" <nathan@kernel.org>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "muchun.song@linux.dev" <muchun.song@linux.dev>,
 "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
 "liam.howlett@oracle.com" <liam.howlett@oracle.com>,
 "osalvador@suse.de" <osalvador@suse.de>, "vbabka@suse.cz" <vbabka@suse.cz>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <4d3878531c76479d9f8ca9789dc6485d@amazon.de>
 <CAG48ez2yrEtEUnG15nbK+hern0gL9W-9hTy3fVY+rdz8QBkSNA@mail.gmail.com>
 <c7fc5bd8-a738-4ad4-9c79-57e88e080b93@redhat.com>
 <45084140-cd90-4fd8-bd31-f1a8a4d64bad@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <45084140-cd90-4fd8-bd31-f1a8a4d64bad@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


>>
>> (I don't understand how the page table can be used for "normal,
>> non-hugetlb". I could only see how it is used for the remaining user for
>> hugetlb stuff, but that's different question)
> 
> Right, this surely is related only to hugetlb PTS, otherwise the refcount
> shouldn't be a factor no?

The example from Jann is scary. But I think it checks out.

> 
>>
>> How does the fix work when an architecture does not issue IPIs for TLB
>> shootdown? To handle gup-fast on these architectures, we use RCU.
>>
>> So I'm wondering whether we use RCU somehow.
> 
> Presumably you mean whether we _can_ use RCU somehow?

No, whether there is an implied RCU sync before the page table gets 
reused, see my reply from Jann.

> 
>>
>> But note that in gup_fast_pte_range(), we are validating whether the PMD
>> changed:
>>
>> if (unlikely(pmd_val(pmd) != pmd_val(*pmdp)) ||
>>      unlikely(pte_val(pte) != pte_val(ptep_get(ptep)))) {
>> 	gup_put_folio(folio, 1, flags);
>> 	goto pte_unmap;
>> }
> 
> Right and as per the comment there:
> 
> /*
>   ...
>   * For THP collapse, it's a bit more complicated because GUP-fast may be
>   * walking a pgtable page that is being freed (pte is still valid but pmd
>   * can be cleared already).  To avoid race in such condition, we need to
>   * also check pmd here to make sure pmd doesn't change (corresponds to
>   * pmdp_collapse_flush() in the THP collapse code path).
>   ...
>   */
> 
> So if this can correctly handle a cleared PMD entry in the teardown case, surely
> it can handle it in this case also?

Right.

But see my other mail, on architectures that don't free page tables with 
RCU we still need the IPI, so that is nasty.

> 
>>
>>
>> So in case the page table got reused in the meantime, we should just back
>> off and be fine, right?
> 
> Yeah seems to be the case to me.
> 
>>
>> --
>> Cheers
>>
>> David / dhildenb
>>
> 
> So it seems like you have a proposal here - could you send a patch so we can
> assess it please? :)

It's a bit tricky, I think I have to discuss with Jann some more first. 
But right now my understanding is that Janns fix might not have taken 
care of arch without the IPI sync -- I might be wrong.

-- 
Cheers

David / dhildenb


