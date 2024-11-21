Return-Path: <stable+bounces-94521-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8610C9D4E1B
	for <lists+stable@lfdr.de>; Thu, 21 Nov 2024 14:51:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47B2D282A29
	for <lists+stable@lfdr.de>; Thu, 21 Nov 2024 13:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E17C31D7E50;
	Thu, 21 Nov 2024 13:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VDXgzCby"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E801F5E6
	for <stable@vger.kernel.org>; Thu, 21 Nov 2024 13:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732197064; cv=none; b=W+htAkkSU8P5j7PG9dzfkEcQtszJiYXu/Eu/piCpMTdlzwOUe6kO9/Kgwr6M/wM6etgZDNvgFtXxPzHZFAvFqacStwkso9IURf1yKi6ILDeW2Z01vyM/yrM9zHqhgCg33Hd8oh4z8RDOq42K5aG4vxTRUq+i2AgSdRgD1soXdp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732197064; c=relaxed/simple;
	bh=4d40igTiPLwx48bZDZOhhhi9XJf/WmCL9uv24wl5Ujs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=SYYD5LZ1bACL3GoBxRwwN+zQ4aCYPcvppVAjTR+CaNNpnGEZ7Ngu7DlM/FFF5iWLQ3lXIZ9mTEpCbt7mc7PyrFr7jBzIi5EXqghp4YOpsek4ltNMAObcZXYYReCFPYygvJ3lACBOkHd/CMqAyfRR69/Qb+AjcrzyWF+gM8fvfZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VDXgzCby; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732197062;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=WAsLa1es1p3tVD2xuZw9teX+HJV0RZHqbPvj3c6eKSE=;
	b=VDXgzCby1+xBR1fY+Z9sPwTPv1bN6sPgNm0DaEGMH2eBgLYDqWO62EVEvFdrJ9QPzhxzSQ
	Z7rbjiQ6ZOPEynwv9YNLerLF8AcUsYrKlawp5J74+GRiod5bx7xsV7UzuIh5eC4q0FdAEv
	EIgKbbEmlvkuDcITZF7vpn92k0qk3gk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-3_HCCXxtNRqnVH0fPX7MPg-1; Thu, 21 Nov 2024 08:51:00 -0500
X-MC-Unique: 3_HCCXxtNRqnVH0fPX7MPg-1
X-Mimecast-MFC-AGG-ID: 3_HCCXxtNRqnVH0fPX7MPg
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4314a22ed8bso6141375e9.1
        for <stable@vger.kernel.org>; Thu, 21 Nov 2024 05:51:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732197059; x=1732801859;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:from:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WAsLa1es1p3tVD2xuZw9teX+HJV0RZHqbPvj3c6eKSE=;
        b=eAUHOhRfIC8zGZoZpM4PRAWdNGAHIEBfjGvIY06BkHvtJmjl9JdBRD9r4QDkcGixac
         sJHXlAKW/xKdOCqDXsUZ+riI7L4IlGj8BKM2OTrmpbFiEt5DBdwiZAm/KeQw7+dCRkqA
         PHYDgTtzma2BQUZPThCc4sMVjK13uIR+oiVOI5oruwi+ZUDgiikxmKh3zC5uL2kUCpjf
         VOH7Z9D7b+TcxfvMiGuUa3oksEUzseW1fcRL7BcsyQm8UHK5nNM9EA/ihZx+qZiPX49Q
         GqOSBQBBTYaNdYp7Jvm/dIknYzwfP2764iUmt1I6FDassxolZ50FbK3F/kkbtRtD+rh0
         AclA==
X-Forwarded-Encrypted: i=1; AJvYcCUTtzHixeaYjacqIS3BKCZbDvBMD+XyOHGF2qagBDD3yy64afHk/4Fm0dAVvY7PLSm1prAse9I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGGjCTj6MtzO7gF1Q2NN90AQ834z+3rNHWgSw/Pq+01OsdaqxB
	ZeIsmKBfi1aj7Hy6E/UTYrqjrz7FGbuXEP3YqSILg9DIrPZbd1AYJBDLPuYqJa9fYkT0fPUnr1h
	IcHyiAm6CZlYi1Q/jsU5k3yd3j8GRV5mHv07zduZKgn2dXOMaGi9vww==
X-Gm-Gg: ASbGncsMK7FBsdHiyPO5QaZ8sq01Sx6oJBaDfrzPSUDER/zUUnuLHvcq/UbbBmG3r8r
	UpoRWXdC76bS296255MeyDWpSv/iBKr+VnGjgd05sgs/YjDC4ap2R6qxEGI+vjFj+uy79cHfETd
	qIKGisXrBkG1KrgPd/U7iARJPLQd5eCGjjgnDXJQD+vk5cofyF4KTMkBsmVuqLGtW4s9SfEnyoA
	ev+ARH+L0GA4mCgEKav7jNHGwFM74NPDdAwER1NmchoshpcWdFCEyopDOnOkRmhQwmdG6Zu8Eyr
	/OhHsEKybrdIL8/9bHujat6zRlLhlr5isRZ6F1tM3nkYF9+TbM457bIjSZrzSeM57TQBvu9ruLc
	=
X-Received: by 2002:a05:6000:1ac8:b0:382:4503:728a with SMTP id ffacd0b85a97d-38254b20a01mr6145069f8f.53.1732197059622;
        Thu, 21 Nov 2024 05:50:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGSw+20gWEiAkvgehCCjoS5ixieY+L2WLbKow5IUX9mwzcqyh+s8ZyTE30Q7sOmQlFHcyhrlA==
X-Received: by 2002:a05:6000:1ac8:b0:382:4503:728a with SMTP id ffacd0b85a97d-38254b20a01mr6145054f8f.53.1732197059312;
        Thu, 21 Nov 2024 05:50:59 -0800 (PST)
Received: from ?IPV6:2003:cb:c70c:de00:1200:8636:b63b:f43? (p200300cbc70cde0012008636b63b0f43.dip0.t-ipconnect.de. [2003:cb:c70c:de00:1200:8636:b63b:f43])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38254933d52sm5232332f8f.80.2024.11.21.05.50.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2024 05:50:58 -0800 (PST)
Message-ID: <25ead85f-2716-4362-8fb5-3422699e308c@redhat.com>
Date: Thu, 21 Nov 2024 14:50:57 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/huge_memory: Fix to make vma_adjust_trans_huge() use
 find_vma() correctly
From: David Hildenbrand <david@redhat.com>
To: Jeongjun Park <aha310510@gmail.com>, akpm@linux-foundation.org
Cc: dave@stgolabs.net, willy@infradead.org, Liam.Howlett@oracle.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
References: <20241121124113.66166-1-aha310510@gmail.com>
 <26b82074-891f-4e26-b0a7-328ee2fa08d3@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <26b82074-891f-4e26-b0a7-328ee2fa08d3@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21.11.24 14:44, David Hildenbrand wrote:
> On 21.11.24 13:41, Jeongjun Park wrote:
>> vma_adjust_trans_huge() uses find_vma() to get the VMA, but find_vma() uses
>> the returned pointer without any verification, even though it may return NULL.
>> In this case, NULL pointer dereference may occur, so to prevent this,
>> vma_adjust_trans_huge() should be fix to verify the return value of find_vma().
>>
>> Cc: <stable@vger.kernel.org>
>> Fixes: 685405020b9f ("mm/khugepaged: stop using vma linked list")
> 
> If that's an issue, wouldn't it have predated that commit?
> 
> struct vm_area_struct *next = vma->vm_next;
> unsigned long nstart = next->vm_start;
> 
> Would have also assumed that there is a next VMA that can be
> dereferenced, no?
> 

And looking into the details, we only assume that there is a next VMA if 
we are explicitly told to by the caller of vma_adjust_trans_huge() using 
"adjust_next".

There is only one such caller, 
vma_merge_existing_range()->commit_merge() where we set adj_start -> 
"adjust_next" where we seem to have a guarantee that there is a next VMA.

So I don't think there is an issue here (although the code does look 
confusing ...).

Not sure, though, if a

if (WARN_ON_ONCE(!next))
	return;

would be reasonable.

-- 
Cheers,

David / dhildenb


