Return-Path: <stable+bounces-139550-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D69CAAA8461
	for <lists+stable@lfdr.de>; Sun,  4 May 2025 08:47:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 973D81899FBC
	for <lists+stable@lfdr.de>; Sun,  4 May 2025 06:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 492BE1805B;
	Sun,  4 May 2025 06:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KIxDnhmU"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2708228F4
	for <stable@vger.kernel.org>; Sun,  4 May 2025 06:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746341273; cv=none; b=bVfRrxoxe+rNqFtRoDJVTEO9iJzEFCxCqKtpGF0DrUp/YpMRG3P3+Qz44IXAaXGsChzpGp4/BFPDhV0xsDZBDX93gdCI05RKbIGuexLJXA6SLJ++/Eaz3rnhi4q4GxXI8xgXEZM9aE2H7MzdWOydXXYwsUraDeq82IV0gcSIc3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746341273; c=relaxed/simple;
	bh=NBEDOUE4AU+xXaqBrIn8CLcvl5OR/IKmphbzpPdz5+0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J8e2QxOjZu8nBuX0I8/Q+FjBk25VfEMTBoYvA0ASWlvT1PR3DBQuRUBqyL7u65GtrHQVEintfBJaFIHfnLA8T3kox0ao7Wd1jNhbWTZSV0Z+jAf7HpyhOTFFar+IdZh/LqV0aG2z+z3s56hzSohBP7YoZsuPeHtzYuwb8vhJsuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KIxDnhmU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746341270;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=VciL2Vnq4XFO2l1GLh+8tGcQoZiSbi51G5aHAKQPPMU=;
	b=KIxDnhmUGJcDkB5LqvJ77cKUbArdysuAdogLAvAnCzgvuYGjWPjg6uQ0/1PY/wI927auLT
	xsbm0bjq3GS5CVFJEwrSPObbDhWuf12DaeXymDhyXhrfMoqQIHrnILlwDyyO0n1UqEc5kj
	HcpnKlKX/qESBtAzGknhPF3KSDUTPj8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-E7RGbhuuPoCQYDSIf66GxQ-1; Sun, 04 May 2025 02:47:48 -0400
X-MC-Unique: E7RGbhuuPoCQYDSIf66GxQ-1
X-Mimecast-MFC-AGG-ID: E7RGbhuuPoCQYDSIf66GxQ_1746341268
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43f251dc364so18744115e9.2
        for <stable@vger.kernel.org>; Sat, 03 May 2025 23:47:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746341268; x=1746946068;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VciL2Vnq4XFO2l1GLh+8tGcQoZiSbi51G5aHAKQPPMU=;
        b=jq6z/Ah2gqdG8ia+mozVXM73joNy832t18ffdSrc4eYuI9/S/u7uEIVZNKsaHddz1x
         mtQZ/vDkZoBa6bGHu/1vIV2YSLcOS0S8oCtJbl71J47Tv2hmCzbeXm3xbjjoXWhaMoTG
         HzL7auTBpCjCvKeSoj9z382eC7JQ2NhiewBO5CDjUmocAygG3AwOyGKQcx8LDAR4SdKR
         YnHL28WKKTc7haZ7pqyP95Nrj6A2wuEKvXOlRmWjcJtO73McNmXjwYaYJN/+hIu+6ikT
         6ZPkmOBwm2lDJ9sAm4cEsOolqsCpZWMGkHmizzzqQ/girUSOSVRlAy+NY2fCGTCSzTlU
         gcCQ==
X-Forwarded-Encrypted: i=1; AJvYcCVkDMqptjo2hqkULL8a7nAmO0g4VlC6XZ/1WUvBWYpu5cAJb+YurmPpRzIRPnry4/0zDakzlxs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhJGXOILvgBX/dASfbU8LHQuWIkxrDn5nNHOzn9SpR41/auclj
	kUuepijyLdNBlUKa50JWVnF87VeIjkyyCuWyFJX98jz4Nm+k5MsqF8ttWoosgUwGwTi4c4mu8Ks
	KiTiZ8xAsgbrtY4VKFrpkwXs6VPGlrNkMvp5h9QO2OPf2pK/qnqmyjQ==
X-Gm-Gg: ASbGncsNt28a51djLMhEWedipuwON69g8SbYdRXGcG4GoSUzB5nQDKWMT3k7EF+4Vvd
	KpoR6WP5iF7zTkR3YDq/pwtd2sYKBoJDRTQv9QeIfYJDQ2NoJ0teLbq6rcQQEKHDb4WKeOCshJ4
	Xho114WjEaTXWDAJ9wKyqOeGyBYnXp1ohyodxkyF4IaLQ2pIGHrhh9h3UoqIHcBAOX0NxLinJhp
	qgG4UPRcRnM/phVroppOClG/HlHfIY171gZJhFuWhInK2VfsX4uymS2Nm7m219b+9ZdcVxhQrn7
	OCv2khOoc/3tjsTxtt49bV74ac0H/RO5ViETre/K/LQ4hovElMg9JV4Ck6Ry7q4LziD0YAvG1J5
	kdS1sI2Q4GT3vAMPRjoda1wfaCWMFrPGxN4etpBE=
X-Received: by 2002:a05:600c:5290:b0:43d:fa59:bcee with SMTP id 5b1f17b1804b1-441c49340e5mr20735045e9.33.1746341267771;
        Sat, 03 May 2025 23:47:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFXFB3FR+eN6PCitQ4q59SAduxE/fk7xHIzBkM+MEWxbylSCKCwT4qO0+BHzou0JizYj1Y0jw==
X-Received: by 2002:a05:600c:5290:b0:43d:fa59:bcee with SMTP id 5b1f17b1804b1-441c49340e5mr20734905e9.33.1746341267422;
        Sat, 03 May 2025 23:47:47 -0700 (PDT)
Received: from ?IPV6:2003:cb:c732:7200:c4da:f12e:1fa8:eaef? (p200300cbc7327200c4daf12e1fa8eaef.dip0.t-ipconnect.de. [2003:cb:c732:7200:c4da:f12e:1fa8:eaef])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441b2b20a65sm138626545e9.32.2025.05.03.23.47.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 May 2025 23:47:46 -0700 (PDT)
Message-ID: <9e3fb101-9a5d-43bb-924a-0df3c38333f8@redhat.com>
Date: Sun, 4 May 2025 08:47:45 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] mm: fix folio_pte_batch() on XEN PV
To: Andrew Morton <akpm@linux-foundation.org>, =?UTF-8?Q?Petr_Van=C4=9Bk?=
 <arkamar@atlas.cz>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Ryan Roberts <ryan.roberts@arm.com>, xen-devel@lists.xenproject.org,
 x86@kernel.org, stable@vger.kernel.org
References: <20250502215019.822-1-arkamar@atlas.cz>
 <20250502215019.822-2-arkamar@atlas.cz>
 <20250503182858.5a02729fcffd6d4723afcfc2@linux-foundation.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250503182858.5a02729fcffd6d4723afcfc2@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 04.05.25 03:28, Andrew Morton wrote:
> On Fri,  2 May 2025 23:50:19 +0200 Petr Vaněk <arkamar@atlas.cz> wrote:
> 
>> On XEN PV, folio_pte_batch() can incorrectly batch beyond the end of a
>> folio due to a corner case in pte_advance_pfn(). Specifically, when the
>> PFN following the folio maps to an invalidated MFN,
>>
>> 	expected_pte = pte_advance_pfn(expected_pte, nr);
>>
>> produces a pte_none(). If the actual next PTE in memory is also
>> pte_none(), the pte_same() succeeds,
>>
>> 	if (!pte_same(pte, expected_pte))
>> 		break;
>>
>> the loop is not broken, and batching continues into unrelated memory.
>>
>> ...
> 
> Looks OK for now I guess but it looks like we should pay some attention
> to what types we're using.
> >> --- a/mm/internal.h
>> +++ b/mm/internal.h
>> @@ -248,11 +248,9 @@ static inline int folio_pte_batch(struct folio *folio, unsigned long addr,
>>   		pte_t *start_ptep, pte_t pte, int max_nr, fpb_t flags,
>>   		bool *any_writable, bool *any_young, bool *any_dirty)
>>   {
>> -	unsigned long folio_end_pfn = folio_pfn(folio) + folio_nr_pages(folio);
>> -	const pte_t *end_ptep = start_ptep + max_nr;
>>   	pte_t expected_pte, *ptep;
>>   	bool writable, young, dirty;
>> -	int nr;
>> +	int nr, cur_nr;
>>   
>>   	if (any_writable)
>>   		*any_writable = false;
>> @@ -265,11 +263,15 @@ static inline int folio_pte_batch(struct folio *folio, unsigned long addr,
>>   	VM_WARN_ON_FOLIO(!folio_test_large(folio) || max_nr < 1, folio);
>>   	VM_WARN_ON_FOLIO(page_folio(pfn_to_page(pte_pfn(pte))) != folio, folio);
>>   
>> +	/* Limit max_nr to the actual remaining PFNs in the folio we could batch. */
>> +	max_nr = min_t(unsigned long, max_nr,
>> +		       folio_pfn(folio) + folio_nr_pages(folio) - pte_pfn(pte));
>> +
> 
> Methinks max_nr really wants to be unsigned long. 

We only batch within a single PTE table, so an integer was sufficient.

The unsigned value is the result of a discussion with Ryan regarding similar/related
(rmap) functions:

"
Personally I'd go with signed int (since
that's what all the counters in struct folio that we are manipulating are,
underneath the atomic_t) then check that nr_pages > 0 in
__folio_rmap_sanity_checks().
"

https://lore.kernel.org/linux-mm/20231204142146.91437-14-david@redhat.com/T/#ma0bfff0102f0f2391dfa94aa22a8b7219b92c957

As soon as we let "max_nr" be an "unsigned long", also the return value
should be an "unsigned long", and everybody calling that function.

In this case here, we should likely just use whatever type "max_nr" is.

Not sure myself if we should change that here to unsigned long or long. Some
callers also operate with the negative values IIRC (e.g., adjust the RSS by doing -= nr).

> That will permit the
> cleanup of quite a bit of truncation, extension, signedness conversion
> and general type chaos in folio_pte_batch()'s various callers.
> > And...
> 
> Why does folio_nr_pages() return a signed quantity?  It's a count.

A partial answer is in 1ea5212aed068 ("mm: factor out large folio handling
from folio_nr_pages() into folio_large_nr_pages()"), where I stumbled over the
reason for a signed value myself and at least made the other
functions be consistent with folio_nr_pages():

"
     While at it, let's consistently return a "long" value from all these
     similar functions.  Note that we cannot use "unsigned int" (even though
     _folio_nr_pages is of that type), because it would break some callers that
     do stuff like "-folio_nr_pages()".  Both "int" or "unsigned long" would
     work as well.

"

Note that folio_nr_pages() returned a "long" since the very beginning. Probably using
a signed value for consistency because also mapcounts / refcounts are all signed.


> 
> And why the heck is folio_pte_batch() inlined?  It's larger then my
> first hard disk and it has five callsites!

:)

In case of fork/zap we really want it inlined because

(1) We want to optimize out all of the unnecessary checks we added for other users

(2) Zap/fork code is very sensitive to function call overhead

Probably, as that function sees more widespread use, we might want a
non-inlined variant that can be used in places where performance doesn't
matter all that much (although I am not sure there will be that many).

-- 
Cheers,

David / dhildenb


