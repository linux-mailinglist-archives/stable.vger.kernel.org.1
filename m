Return-Path: <stable+bounces-159149-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F36CAEFB9E
	for <lists+stable@lfdr.de>; Tue,  1 Jul 2025 16:07:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B33E4A55B4
	for <lists+stable@lfdr.de>; Tue,  1 Jul 2025 14:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62249277C88;
	Tue,  1 Jul 2025 14:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TdUP0JMc"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475D927586E
	for <stable@vger.kernel.org>; Tue,  1 Jul 2025 14:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751378612; cv=none; b=l1i9eVw5qP2QrrKtQ44YtSJBRmLHIDItYZUHM51Uu29V6S91Un1Yz8/tV8RDbZ2we5+BYu1066GKK3cvAmE6+QSUm0UqG5oogvFlSChQ6nvfqOu5f53yCS1UZbOu73Fbv0awl7N/3wJBz2XHadX3inReY32g+X3fkoLktBq/1vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751378612; c=relaxed/simple;
	bh=CJewpNtDiYZKR0vYTwM+1BlRGsnnKuzz930O/B6QLb8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cD1XYHfh724zkvB8qzFXFI77NEd7pkCmObEXyo4/nP/7b0n89KWI3vqkeV1IS4MRn9xxMJ5APkZiR0GOZGdF0aIXWFFtmmp/Yp5PIzcMo7iZsjIc9xUGaU000gprw5Pnw4cWnGUVyl/TM87hW7j1ktJtOlPps+NSPTDkE8E8fOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TdUP0JMc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751378609;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=RTx+g/ICXN+t4dz9YafghFmb5+aFmfAwgPNFgDgkBAM=;
	b=TdUP0JMcoj2+FB4ngGDFMGYRVegDRbs7WVuBjuYGumtWbC+JKjMQwPsuxLY35LArDGz6L6
	Bpum5EHkL+TizrPb8gmVSeVnqiEhyYo9JavbldAsgF/hR21/1ZnU5CRkgajAL5W4j49t1r
	kIFar0aXMHEu+6N8Pc/AGe+5kWXQxho=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-3IbCNjxEMYu-H0Ewo4RS6Q-1; Tue, 01 Jul 2025 10:03:19 -0400
X-MC-Unique: 3IbCNjxEMYu-H0Ewo4RS6Q-1
X-Mimecast-MFC-AGG-ID: 3IbCNjxEMYu-H0Ewo4RS6Q_1751378594
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-450df53d461so26966055e9.1
        for <stable@vger.kernel.org>; Tue, 01 Jul 2025 07:03:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751378594; x=1751983394;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RTx+g/ICXN+t4dz9YafghFmb5+aFmfAwgPNFgDgkBAM=;
        b=NMy9ZCJlOIM0aeHMfASv67hSJuGpMBT8lrqDowcyXFC2OJ94ZmWVFRKlEzQ2h+3Omk
         Ustx4nnJJlm2f70ttDAvbIf1/M4pIKEkUF31tNg6+phoF/o0crKrQu8T6ZE7jqvUO/4H
         Q9jimRAqgmiYVN/0KSXPbo3VitgVISg4JaaLZQp+ZvhszUlxP/PtFtix9Vbc+4RoodMN
         XOc23m8mpk+kcktKARO6DlmwxWccXFoulCi3yXKHuSQjzNTMSmJ3Oj/bSnDmp9Pbm4Zz
         hyZjh/qh/xejvn/PCi8PVcWy67jXzYtCesqURrqnz6VI7Jtu0vfuTIFUYgW6ntBaNWKZ
         l2sw==
X-Forwarded-Encrypted: i=1; AJvYcCXhYeyBwnD/MDF7HjpZXXFpesleixP3jHsLSyOZj9gX9qktYDBf20F99lT49CalQQGw+s1U8Ng=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIuUprt47HIAKyFJNAwU+5c0h3NFACkg6fwNH8nn4rXgCC6h8k
	1Qk8+wc99okb14p/PlfO9TsmBqV1v4Jm3JserdBWnEEgJbxm2yDSbKqSpGob0TsBV85D/G03G9W
	UDly8bmdGw6zrIZ8q53hdYqxMmuJKNtfGcfvqh6UxceZfrmE+IgAAv0u26A==
X-Gm-Gg: ASbGncv+fUKLHPn6Q7NA+glX3Ox6K2YdejI6uK9DXKLnCamn2kMPVgUwiQ0UZr4+SRk
	UUeMXnMidjjWWNIGKitgzAQTyf4vd9j/xB3BXAgliCr1I/rymbOWmGzlcrP9jOGH9pBE8L+dPVa
	BEmO6IixuIS8q54KFLXL1/2fTlSziRli6S22mzudjq+y8fLSLb3MmVCwI5KvmSLDd4MRinC0TYs
	2LYE5kaEc4fn8iHRTj9SvRuH6pFZg2isvWmmuOst3KJsP9EoRV3dOS+7m4wVt7vA+XQeqGj2LNo
	rTfFFAjmMN2Y3WiZYmtnWjpZ1LOX6rm2wBDdQMxP8WX8HJwvAqJns7Dr3nc+nl+GSI3FbWIPGSn
	2dtOG+Iq2/awVCjjlcLHYXKDLgQQcAJf9asrGddqWT1bJ0sDYgg==
X-Received: by 2002:adf:b64f:0:b0:3a0:9dfc:da4 with SMTP id ffacd0b85a97d-3a8ff5201efmr11485710f8f.42.1751378591831;
        Tue, 01 Jul 2025 07:03:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG7R3QME11ZBj9+BG46czHqpSceP+vF115DNdQ6LNVtWM1I1Qv3+VwohoaUOVRnSiIQOjQm8w==
X-Received: by 2002:adf:b64f:0:b0:3a0:9dfc:da4 with SMTP id ffacd0b85a97d-3a8ff5201efmr11485359f8f.42.1751378588233;
        Tue, 01 Jul 2025 07:03:08 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f18:7500:202e:b0f1:76d6:f9af? (p200300d82f187500202eb0f176d6f9af.dip0.t-ipconnect.de. [2003:d8:2f18:7500:202e:b0f1:76d6:f9af])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a87e947431sm13377312f8f.0.2025.07.01.07.03.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jul 2025 07:03:07 -0700 (PDT)
Message-ID: <330f29ee-ba55-4ae6-a695-ddaba58d5cb8@redhat.com>
Date: Tue, 1 Jul 2025 16:03:06 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] mm/rmap: fix potential out-of-bounds page table
 access during batched unmap
To: Lance Yang <ioworker0@gmail.com>, akpm@linux-foundation.org,
 21cnbao@gmail.com
Cc: baolin.wang@linux.alibaba.com, chrisl@kernel.org, kasong@tencent.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-riscv@lists.infradead.org,
 lorenzo.stoakes@oracle.com, ryan.roberts@arm.com, v-songbaohua@oppo.com,
 x86@kernel.org, huang.ying.caritas@gmail.com, zhengtangquan@oppo.com,
 riel@surriel.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
 harry.yoo@oracle.com, mingzhe.yang@ly.com, stable@vger.kernel.org,
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>
References: <20250630011305.23754-1-lance.yang@linux.dev>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250630011305.23754-1-lance.yang@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30.06.25 03:13, Lance Yang wrote:
> From: Lance Yang <lance.yang@linux.dev>
> 
> As pointed out by David[1], the batched unmap logic in try_to_unmap_one()
> may read past the end of a PTE table when a large folio's PTE mappings
> are not fully contained within a single page table.
> 
> While this scenario might be rare, an issue triggerable from userspace must
> be fixed regardless of its likelihood. This patch fixes the out-of-bounds
> access by refactoring the logic into a new helper, folio_unmap_pte_batch().
> 
> The new helper correctly calculates the safe batch size by capping the scan
> at both the VMA and PMD boundaries. To simplify the code, it also supports
> partial batching (i.e., any number of pages from 1 up to the calculated
> safe maximum), as there is no strong reason to special-case for fully
> mapped folios.
> 
> [1] https://lore.kernel.org/linux-mm/a694398c-9f03-4737-81b9-7e49c857fcbe@redhat.com
> 
> Fixes: 354dffd29575 ("mm: support batched unmap for lazyfree large folios during reclamation")
> Cc: <stable@vger.kernel.org>
> Acked-by: Barry Song <baohua@kernel.org>
> Suggested-by: David Hildenbrand <david@redhat.com>

Realized this now: This should probably be a "Reported-by:" with the 
"Closes:" and and a link to my mail.

-- 
Cheers,

David / dhildenb


