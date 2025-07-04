Return-Path: <stable+bounces-160202-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09A79AF954E
	for <lists+stable@lfdr.de>; Fri,  4 Jul 2025 16:20:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D7CD1C44308
	for <lists+stable@lfdr.de>; Fri,  4 Jul 2025 14:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FF441A4F3C;
	Fri,  4 Jul 2025 14:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jEmCGds6"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9643017A30A
	for <stable@vger.kernel.org>; Fri,  4 Jul 2025 14:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751638848; cv=none; b=kpfxme65s23wKHcJ0XxGONcvzvQ5+yjNwXLqOaDcFAL0LxTy8qT+RbZRSo8Dkqoqe84QCEoON3mxgfp4Hx05rlW/ZoebD/IsvtIPwA/V4wy7QsJLL4wly6taHNOehU/N/Qw/pVcS8EA03jFNIZnC+jJ5cjmtkyxLmF19F8p2XVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751638848; c=relaxed/simple;
	bh=LEugG4mzd2CRtbZmjSvzUzMzua440SgKtSi+2P+kwHI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uDRWB3f5bxCopbmyBTcySNI5CnI/rA6V+xkCyFimxAhOjpvdZrefj/7FgKUBHqnxhvULxZAYdXLIiXo07hnrlfuMA/DBQphd80o8DR+wSpuu/MnhmnjcYSoCAWDTWe0B9q6Cg95Unmlxf6f0t+6XX41gFjC3X4T/gePWir0273s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jEmCGds6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751638844;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=FPWR8/6FevG48UmfkMhjqNTe4/LZAWg9DvTsvfd8iaY=;
	b=jEmCGds6SCt8IAiL3D3MN2vb9XqOs2C8qYq24BvpNUVqIPcdpGVDQRhZXTXBYbq8BHVujs
	idQVEY5a5h/bOx08POo5VHso+D6XyFCdc7pvZoWSCvBHtZ6WJXt+yzfwakZpWB8/gCO5VT
	lqxDgLC5lDgL0YKL4QtAAghwuOi+PhE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-367-_Xxk-S8VNlqS0-9NbEhQSw-1; Fri, 04 Jul 2025 10:20:43 -0400
X-MC-Unique: _Xxk-S8VNlqS0-9NbEhQSw-1
X-Mimecast-MFC-AGG-ID: _Xxk-S8VNlqS0-9NbEhQSw_1751638842
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a52bfda108so485035f8f.3
        for <stable@vger.kernel.org>; Fri, 04 Jul 2025 07:20:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751638842; x=1752243642;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FPWR8/6FevG48UmfkMhjqNTe4/LZAWg9DvTsvfd8iaY=;
        b=Un6olBgy5R1D+iAQ0GXbGALm9kjQJ3cW7SeklH9ysHydnoLgCHu4DMi3ZvAFLjXZJv
         U1RN+Ym7brka+wRWzKqWArsLtXZYF3gTCVu0e9Ewk/bd8vSeSe6NctmLS9SULz/p6Uta
         yvf99iKaGAXvIHhiOsPOAC8GAUR2X7j3kxHHQDYWLq/JGgSaft9JZC2AaWVMIi+G14/y
         KZiMJFNUJqR/x33EPPC1hPr3rO1zuBx/YfHQ95tbqzl6fGrQGSNc8xyZhiYlBYRI6U0T
         IAPY1fULZfFmfrc+fu7mocvI0yjaA63Wim+mV+2ml4vvFD6vyuVj27AiQSMaE1+oU6h6
         SekA==
X-Forwarded-Encrypted: i=1; AJvYcCXKCUXFWV4d+Pj07mPhnnxfujPh8ITSbn+NqzKs5Rn/rgnF1G94dz8ttSQEIR8XJc8ScGe5dN0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwslSTDUkPwkoOZ9tAuDMI7GKlCLe1fNKS121TVNQHCEXHRGcFN
	Q68qDUFCqrjTmqzlL6A1p/D8fXoFd5P2XKTqAgWm0BL8n7xVkjUnojCsPePDfAl96xyx2eE+KqQ
	t6RUwgYJZk7M8y7Mg9Pvq+CQ10ENLL4fotJ7zNLzcq5m1Z6PzD5pVjDCemA==
X-Gm-Gg: ASbGncs91ynNaj3n24q/MFUAh0HUjMJnKEmWQ3D90zGJKU2odqi5y8txdr3LdCpZRPw
	ZoTBaP4+685XCyw8FBIT4tu/VvSpGHX1aph9s2mf2obhA+Gesqo4WI1Zu+EBWjAAZs4AH0X/RMx
	xH+qCuuNhCz695LiEiUambQ9KBy4B6/y3NCkA5Qwc/4wU6I0o9uaxeU8SKaSQC30YMecOXwY2EU
	2Ex2+y98ibgMInZJvD/3xGLqvytFMJFJ48mlr6rz9pna9QdbyJPf85A6mMwXusxkD4gQFrTAgj9
	reNvnbf4qxdi9f1CkVQ2LdGjmTr+cahwRG59RwyfOPvk59s5bPnrqoO5lAEUm8o7SUDALWZ+KCW
	JirpPmTogtBZM03pop0XjWsG4b2lJodG4Eo3gmQWH6NK5bVs=
X-Received: by 2002:a5d:5f8d:0:b0:3a4:f70e:abda with SMTP id ffacd0b85a97d-3b4964eafb0mr2523313f8f.10.1751638841936;
        Fri, 04 Jul 2025 07:20:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG+/kiTWcuui6KC8nKQ4kO8+DE7sHGdoqJ0Z4Ks5m7aF9X96EBl8jRZQtA50Mb5hMtiVeqQ5Q==
X-Received: by 2002:a5d:5f8d:0:b0:3a4:f70e:abda with SMTP id ffacd0b85a97d-3b4964eafb0mr2523272f8f.10.1751638841478;
        Fri, 04 Jul 2025 07:20:41 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f2c:5500:988:23f9:faa0:7232? (p200300d82f2c5500098823f9faa07232.dip0.t-ipconnect.de. [2003:d8:2f2c:5500:988:23f9:faa0:7232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454b161f351sm28210535e9.4.2025.07.04.07.20.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Jul 2025 07:20:41 -0700 (PDT)
Message-ID: <dfcc7a23-2f28-4387-ab2b-07ab56b933fe@redhat.com>
Date: Fri, 4 Jul 2025 16:20:40 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] x86/mm: Disable hugetlb page table sharing on 32-bit
To: Jann Horn <jannh@google.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Cc: Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
 Vitaly Chikunov <vt@altlinux.org>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, Dave Hansen <dave.hansen@intel.com>,
 stable@vger.kernel.org
References: <20250702-x86-2level-hugetlb-v2-1-1a98096edf92@google.com>
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
 ZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT7CwZgEEwEIAEICGwMGCwkIBwMCBhUIAgkKCwQW
 AgMBAh4BAheAAhkBFiEEG9nKrXNcTDpGDfzKTd4Q9wD/g1oFAl8Ox4kFCRKpKXgACgkQTd4Q
 9wD/g1oHcA//a6Tj7SBNjFNM1iNhWUo1lxAja0lpSodSnB2g4FCZ4R61SBR4l/psBL73xktp
 rDHrx4aSpwkRP6Epu6mLvhlfjmkRG4OynJ5HG1gfv7RJJfnUdUM1z5kdS8JBrOhMJS2c/gPf
 wv1TGRq2XdMPnfY2o0CxRqpcLkx4vBODvJGl2mQyJF/gPepdDfcT8/PY9BJ7FL6Hrq1gnAo4
 3Iv9qV0JiT2wmZciNyYQhmA1V6dyTRiQ4YAc31zOo2IM+xisPzeSHgw3ONY/XhYvfZ9r7W1l
 pNQdc2G+o4Di9NPFHQQhDw3YTRR1opJaTlRDzxYxzU6ZnUUBghxt9cwUWTpfCktkMZiPSDGd
 KgQBjnweV2jw9UOTxjb4LXqDjmSNkjDdQUOU69jGMUXgihvo4zhYcMX8F5gWdRtMR7DzW/YE
 BgVcyxNkMIXoY1aYj6npHYiNQesQlqjU6azjbH70/SXKM5tNRplgW8TNprMDuntdvV9wNkFs
 9TyM02V5aWxFfI42+aivc4KEw69SE9KXwC7FSf5wXzuTot97N9Phj/Z3+jx443jo2NR34XgF
 89cct7wJMjOF7bBefo0fPPZQuIma0Zym71cP61OP/i11ahNye6HGKfxGCOcs5wW9kRQEk8P9
 M/k2wt3mt/fCQnuP/mWutNPt95w9wSsUyATLmtNrwccz63XOwU0EVcufkQEQAOfX3n0g0fZz
 Bgm/S2zF/kxQKCEKP8ID+Vz8sy2GpDvveBq4H2Y34XWsT1zLJdvqPI4af4ZSMxuerWjXbVWb
 T6d4odQIG0fKx4F8NccDqbgHeZRNajXeeJ3R7gAzvWvQNLz4piHrO/B4tf8svmRBL0ZB5P5A
 2uhdwLU3NZuK22zpNn4is87BPWF8HhY0L5fafgDMOqnf4guJVJPYNPhUFzXUbPqOKOkL8ojk
 CXxkOFHAbjstSK5Ca3fKquY3rdX3DNo+EL7FvAiw1mUtS+5GeYE+RMnDCsVFm/C7kY8c2d0G
 NWkB9pJM5+mnIoFNxy7YBcldYATVeOHoY4LyaUWNnAvFYWp08dHWfZo9WCiJMuTfgtH9tc75
 7QanMVdPt6fDK8UUXIBLQ2TWr/sQKE9xtFuEmoQGlE1l6bGaDnnMLcYu+Asp3kDT0w4zYGsx
 5r6XQVRH4+5N6eHZiaeYtFOujp5n+pjBaQK7wUUjDilPQ5QMzIuCL4YjVoylWiBNknvQWBXS
 lQCWmavOT9sttGQXdPCC5ynI+1ymZC1ORZKANLnRAb0NH/UCzcsstw2TAkFnMEbo9Zu9w7Kv
 AxBQXWeXhJI9XQssfrf4Gusdqx8nPEpfOqCtbbwJMATbHyqLt7/oz/5deGuwxgb65pWIzufa
 N7eop7uh+6bezi+rugUI+w6DABEBAAHCwXwEGAEIACYCGwwWIQQb2cqtc1xMOkYN/MpN3hD3
 AP+DWgUCXw7HsgUJEqkpoQAKCRBN3hD3AP+DWrrpD/4qS3dyVRxDcDHIlmguXjC1Q5tZTwNB
 boaBTPHSy/Nksu0eY7x6HfQJ3xajVH32Ms6t1trDQmPx2iP5+7iDsb7OKAb5eOS8h+BEBDeq
 3ecsQDv0fFJOA9ag5O3LLNk+3x3q7e0uo06XMaY7UHS341ozXUUI7wC7iKfoUTv03iO9El5f
 XpNMx/YrIMduZ2+nd9Di7o5+KIwlb2mAB9sTNHdMrXesX8eBL6T9b+MZJk+mZuPxKNVfEQMQ
 a5SxUEADIPQTPNvBewdeI80yeOCrN+Zzwy/Mrx9EPeu59Y5vSJOx/z6OUImD/GhX7Xvkt3kq
 Er5KTrJz3++B6SH9pum9PuoE/k+nntJkNMmQpR4MCBaV/J9gIOPGodDKnjdng+mXliF3Ptu6
 3oxc2RCyGzTlxyMwuc2U5Q7KtUNTdDe8T0uE+9b8BLMVQDDfJjqY0VVqSUwImzTDLX9S4g/8
 kC4HRcclk8hpyhY2jKGluZO0awwTIMgVEzmTyBphDg/Gx7dZU1Xf8HFuE+UZ5UDHDTnwgv7E
 th6RC9+WrhDNspZ9fJjKWRbveQgUFCpe1sa77LAw+XFrKmBHXp9ZVIe90RMe2tRL06BGiRZr
 jPrnvUsUUsjRoRNJjKKA/REq+sAnhkNPPZ/NNMjaZ5b8Tovi8C0tmxiCHaQYqj7G2rgnT0kt
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250702-x86-2level-hugetlb-v2-1-1a98096edf92@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02.07.25 10:32, Jann Horn wrote:
> Only select ARCH_WANT_HUGE_PMD_SHARE on 64-bit x86.
> Page table sharing requires at least three levels because it involves
> shared references to PMD tables; 32-bit x86 has either two-level paging
> (without PAE) or three-level paging (with PAE), but even with
> three-level paging, having a dedicated PGD entry for hugetlb is only
> barely possible (because the PGD only has four entries), and it seems
> unlikely anyone's actually using PMD sharing on 32-bit.
> 
> Having ARCH_WANT_HUGE_PMD_SHARE enabled on non-PAE 32-bit X86 (which
> has 2-level paging) became particularly problematic after commit
> 59d9094df3d7 ("mm: hugetlb: independent PMD page table shared count"),
> since that changes `struct ptdesc` such that the `pt_mm` (for PGDs) and
> the `pt_share_count` (for PMDs) share the same union storage - and with
> 2-level paging, PMDs are PGDs.
> 
> (For comparison, arm64 also gates ARCH_WANT_HUGE_PMD_SHARE on the
> configuration of page tables such that it is never enabled with 2-level
> paging.)
> 
> Reported-by: Vitaly Chikunov <vt@altlinux.org>
> Closes: https://lore.kernel.org/r/srhpjxlqfna67blvma5frmy3aa@altlinux.org
> Suggested-by: Dave Hansen <dave.hansen@intel.com>
> Tested-by: Vitaly Chikunov <vt@altlinux.org>
> Fixes: cfe28c5d63d8 ("x86: mm: Remove x86 version of huge_pmd_share.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jann Horn <jannh@google.com>
> ---

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


