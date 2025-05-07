Return-Path: <stable+bounces-142025-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B1FEAADBDB
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 11:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AA721C00CDA
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 09:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A3D1BD9D0;
	Wed,  7 May 2025 09:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GVrtC8Ux"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5DA1BC099
	for <stable@vger.kernel.org>; Wed,  7 May 2025 09:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746611425; cv=none; b=YLiFMz+Z0f5pI2hACfHinbKSjBPwHWkcwNQOshyiAD5opmDbxjZM4FxIbzmvenSH1tNNg44dVqzRUDpTeoZL+LX8xtkgm0yCQs31skcXiczI38qxcYhK48JW/+RG87qtMnKSTmSYhIiS8yfiLR5y+LlyLH5lZqXX9Pm5YXMjh+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746611425; c=relaxed/simple;
	bh=Ocq0P3HOIZlDwZjP6yOr1+JTI+qxP/IRYm7s7N1B3e8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p8Ujd/m2HNpV1pWPD9vOH42lL88E7cEUyCTxUcK01z5D0yoeYi1U+DKnH1IAdxDSgpHcaBYMorx+ph763yg5lu9EBxw/U3BqnJRoA1/Hg6bpOypgFJc4khbO8lwAZPPoDfpWfSG/oRIYqpcUPzWxAfU+DGfQfOFriwG/hwa0FF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GVrtC8Ux; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746611422;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=WVKm+prTo91mCK4sWi9nK8ro46xY5ZiQCNeKWZ2n6iY=;
	b=GVrtC8UxVXNpmlz+3QXUO9gp5EkjdSNVeB8k+7ReFua5nwZZ0vKPB7qrI1ZMZsy6Oyk3AZ
	5NgOcm4kWLu2oGI81OVy3XM4vAIW4SEVeVM31JtbNHjHVX5l55OKRSo1NA3JRGqHQ/0ADX
	rDptin1DeCgh5TAH97lMsGUS+yL6Hgo=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-XxAkNUmLMjKPdwMG9yeUbw-1; Wed, 07 May 2025 05:50:21 -0400
X-MC-Unique: XxAkNUmLMjKPdwMG9yeUbw-1
X-Mimecast-MFC-AGG-ID: XxAkNUmLMjKPdwMG9yeUbw_1746611420
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-7394792f83cso5166366b3a.3
        for <stable@vger.kernel.org>; Wed, 07 May 2025 02:50:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746611420; x=1747216220;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WVKm+prTo91mCK4sWi9nK8ro46xY5ZiQCNeKWZ2n6iY=;
        b=W5NAi6APqp6PfuYYN4T5NNMb33z9W9IHKPDTazjnsbUEuEucEJBBjWLHFarxxFnioN
         B3fW2xVfPSU7x7TYHyk0jKUZrgYHg6qwY5lDExAlhyPKIbPTKvgPOcvrLxdGiYw9Elhd
         ttLLgJA9TADS9rKRiUlNzbckQsMJ2tF5PSIberm4WKh6YXHNtu386WGFlndij+9nVFT3
         dPl2DCOM+jZ/7P6PUgdgnpHkcIpggd+qaiDeCZbQOnA1IB1fnM+HcudeusJjesIrkfqk
         ivtVYP+Rf+k8oMlRdRXWlVoCnpCPItJqFHsnjKVtmlsNLbjdTiIL8T5IRRHNXg2qUBtx
         IHhQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZC76TDKDELKHoV5au76h5fM3Srj/Ec2lT9myPgDiLfm93bf0HTG63zmi17LwSt/9wy7tGByg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkWlZ8pciDsIEmegKVzf6LSQubzF3W3xuJ+DeyGBJMfmN6/UrD
	kuXIeoVhihLdc8w7eRYDkdvD7AyC7F3r38sgcEohrkDWnIvWbY6SOrr46ObZyS0K40B0+UhqNS6
	vbgoESuxcQBycyI3xij6chMVThwYreKU+wXN3sF9hElYOXg4kEaegwg==
X-Gm-Gg: ASbGncsti4R00VbSbfJ0eak3/WFIi/FmVzbkIQoh4WCf+DHrio5BXvW9iu2DcQNexiN
	kxEH1xpLloG2UNanMEsTLWEwtw0YtptEvNtthDYmpD3yZN1c6fHxqwEXnUyir7Fc37aE4OI2F0E
	LYm2Pt5x6tceHJS0O1cOmK8E4jR2Epc92xAHh2iPx6xnbObS+0RvI3P3mKKlSWr6IFaykBaNKTQ
	2rbwI9buL8N7IyHXkS9tPkCM9X8fL+JGT60Pq53avm29v5pXPpSmo3j4IikOF5kHYl961tbz4xm
	YWi9hLSY/uGrsIa3d6Na1x5R8r1S8iZwEZXMoWxGOfe21/dG5L275DIgfADBfmeX1j6VGdb7QRi
	JP3KfXc/ukN1UNIOEK/BeNUKmqokLu7BFyMX7qyk=
X-Received: by 2002:a05:6a00:2a06:b0:73e:2dc5:a93c with SMTP id d2e1a72fcca58-7409cf0f945mr3319250b3a.11.1746611420399;
        Wed, 07 May 2025 02:50:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHVA37Uyq+XuIDleGXUMxF5Rlx1CmJawsIQUf6ZGk0Jxt0AkI56K7rfY3hb7Ni+UPjopi5iAA==
X-Received: by 2002:a05:6a00:2a06:b0:73e:2dc5:a93c with SMTP id d2e1a72fcca58-7409cf0f945mr3319224b3a.11.1746611419983;
        Wed, 07 May 2025 02:50:19 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f12:d400:ed3c:fb0c:1ec0:c628? (p200300d82f12d400ed3cfb0c1ec0c628.dip0.t-ipconnect.de. [2003:d8:2f12:d400:ed3c:fb0c:1ec0:c628])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74058db8befsm10590578b3a.40.2025.05.07.02.50.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 May 2025 02:50:19 -0700 (PDT)
Message-ID: <0ec57b2e-0a1c-443f-89e1-608d5bccbf26@redhat.com>
Date: Wed, 7 May 2025 11:50:15 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] mm: mmap: map MAP_STACK to VM_NOHUGEPAGE only if THP
 is enabled
To: Ignacio.MorenoGonzalez@kuka.com, lorenzo.stoakes@oracle.com
Cc: Liam.Howlett@oracle.com, akpm@linux-foundation.org,
 yang@os.amperecomputing.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20250507-map-map_stack-to-vm_nohugepage-only-if-thp-is-enabled-v3-1-80929f30df7f@kuka.com>
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
In-Reply-To: <20250507-map-map_stack-to-vm_nohugepage-only-if-thp-is-enabled-v3-1-80929f30df7f@kuka.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07.05.25 11:11, Ignacio Moreno Gonzalez via B4 Relay wrote:
> From: Ignacio Moreno Gonzalez <Ignacio.MorenoGonzalez@kuka.com>
> 
> commit c4608d1bf7c6 ("mm: mmap: map MAP_STACK to VM_NOHUGEPAGE") maps
> the mmap option MAP_STACK to VM_NOHUGEPAGE. This is also done if
> CONFIG_TRANSPARENT_HUGETABLES is not defined. But in that case, the
> VM_NOHUGEPAGE does not make sense.
> 
> Fixes: c4608d1bf7c6 ("mm: mmap: map MAP_STACK to VM_NOHUGEPAGE")
> Cc: stable@vger.kernel.org
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Reviewed-by: Yang Shi <yang@os.amperecomputing.com>
> Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> Signed-off-by: Ignacio Moreno Gonzalez <Ignacio.MorenoGonzalez@kuka.com>
> ---
> I discovered this issue when trying to use the tool CRIU to checkpoint
> and restore a container. Our running kernel is compiled without
> CONFIG_TRANSPARENT_HUGETABLES. CRIU parses the output of

I'm sure you mean CONFIG_TRANSPARENT_HUGEPAGE ?

> /proc/<pid>/smaps and saves the "nh" flag. When trying to restore the
> container, CRIU fails to restore the "nh" mappings, since madvise()
> MADV_NOHUGEPAGE always returns an error because
> CONFIG_TRANSPARENT_HUGETABLES is not defined.

This should go into the patch description; it explains how this is 
actually causing issues.

> 
> The mapping MAP_STACK -> VM_NOHUGEPAGE was introduced by commit
> c4608d1bf7c6 ("mm: mmap: map MAP_STACK to VM_NOHUGEPAGE") in order to
> fix a regression introduced by commit efa7df3e3bb5 ("mm: align larger
> anonymous mappings on THP boundaries"). The change introducing the
> regression (efa7df3e3bb5) was limited to THP kernels, but its fix
> (c4608d1bf7c6) is applied without checking if THP is set.
> 
> The mapping MAP_STACK -> VM_NOHUGEPAGE should only be applied if THP is
> enabled.
> ---
> Changes in v3:
> - Exclude non-stable patch (for huge_mm.h) from this series to avoid mixing stable and non-stable patches, as suggested by Andrew.
> - Extend description in cover letter.
> - Link to v2: https://lore.kernel.org/r/20250506-map-map_stack-to-vm_nohugepage-only-if-thp-is-enabled-v2-0-f11f0c794872@kuka.com
> 
> Changes in v2:
> - [Patch 1/2] Use '#ifdef' instead of '#if defined(...)'
> - [Patch 1/2] Add 'Fixes: c4608d1bf7c6...'
> - Create [Patch 2/2]
> 
> - Link to v1: https://lore.kernel.org/r/20250502-map-map_stack-to-vm_nohugepage-only-if-thp-is-enabled-v1-1-113cc634cd51@kuka.com
> ---
>   include/linux/mman.h | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/include/linux/mman.h b/include/linux/mman.h
> index bce214fece16b9af3791a2baaecd6063d0481938..f4c6346a8fcd29b08d43f7cd9158c3eddc3383e1 100644
> --- a/include/linux/mman.h
> +++ b/include/linux/mman.h
> @@ -155,7 +155,9 @@ calc_vm_flag_bits(struct file *file, unsigned long flags)
>   	return _calc_vm_trans(flags, MAP_GROWSDOWN,  VM_GROWSDOWN ) |
>   	       _calc_vm_trans(flags, MAP_LOCKED,     VM_LOCKED    ) |
>   	       _calc_vm_trans(flags, MAP_SYNC,	     VM_SYNC      ) |
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
>   	       _calc_vm_trans(flags, MAP_STACK,	     VM_NOHUGEPAGE) |
> +#endif
>   	       arch_calc_vm_flag_bits(file, flags);
>   }

LGTM. I'm surprise we even have VM_NOHUGEPAGE on kernels ... without 
THP. I mean, as you say, even setting MADV_NOHUGEPAGE does not wrok.

-- 
Cheers,

David / dhildenb


