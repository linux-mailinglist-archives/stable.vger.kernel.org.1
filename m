Return-Path: <stable+bounces-191462-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BD78C14A2C
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 13:31:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3755D582626
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 12:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC6351E51EE;
	Tue, 28 Oct 2025 12:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PM2aBzdo"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC0A23D291
	for <stable@vger.kernel.org>; Tue, 28 Oct 2025 12:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761654650; cv=none; b=keKX6l3FpCtvRFX/9FPYOY5F/6AYAPEpx+rvbx8YJ2+Is7/jXA/mMngIaN0oVPU/V9TzAqLmnT2R+8CVNR3Z+pfvpALvwHBwSOsc0s92KyVIna1wpplq+Ach0UAE3oJkO4JumdA1kPehGGYkkea1cczriKeV0O0ub/GZ7edSWJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761654650; c=relaxed/simple;
	bh=YCOJspC8AR5t5kkIm7/R7G5qffr1ytnTF/NVlSkEs6U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YiJUVsrvQhubzj3se2hIVXhq3/PdmCsP6yH3JhFmd48JTj1JYv+u6UsA7dVgk+sf+4sNmyTX7Q9Gmm9Oz7hW7u1/eFROP/sIkgTdKrslhcxZCEZXT89UiFmJvegh5drS6AS794mijql6RIwgE/YZvjXiWL1okd4tqVBdGaXcF/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PM2aBzdo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761654647;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=caqFFVQ8CNc5/R1/dbClJ7vCcMhRSm3xqXDsXqZLJ3g=;
	b=PM2aBzdowR8IuoMzT7Xc81FITfQ6FKsSdePFD7Q9nBEzWU56ixQTZtVRVb/cWeJndP+90n
	/eGGpmr9W4M9C8Bt/8RbdCWKLOdZ5GV7K45SDoVp3nf+NEvftqbrh9JJJZBtm9ChRct048
	pj+WWm9xWYKftTKQ8O3o8DIxDFiHEY8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-349-meixGVxQMaCbNjb-W6OtSg-1; Tue, 28 Oct 2025 08:30:46 -0400
X-MC-Unique: meixGVxQMaCbNjb-W6OtSg-1
X-Mimecast-MFC-AGG-ID: meixGVxQMaCbNjb-W6OtSg_1761654645
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-42992cb2ee8so2033483f8f.3
        for <stable@vger.kernel.org>; Tue, 28 Oct 2025 05:30:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761654645; x=1762259445;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=caqFFVQ8CNc5/R1/dbClJ7vCcMhRSm3xqXDsXqZLJ3g=;
        b=KqOdKkNV2zyRhUTuHW8p7QnI7wqD1eUjMdiQIFHFf734KMyfdWVpG0JqYv6et/TaEi
         mBe85zTqwLB1ZE++LmDk3rPQabngWiAxtLZjD7wTrUJnEm0Rck6mB+NAA1q8RAfCYDJF
         /3QwOxs2Lx8BvlD0tqbjr5j8PvCbZLxdbIvSn52qo3Bet3QtDlNC9GptZDsI1QerHoRv
         CEhsqHsalBlsdLWOhj++ipoPaakm32gad9WDmvZiF44gYGjwLaqbXDbHvtS4LF4/z17P
         h1mE/PtwfbUl4w8BcRDaRqpfBWm9T8cTjIbZ43uIxRRrlPbQvbpRYEPmkF6ZThVLSDwY
         TFtA==
X-Forwarded-Encrypted: i=1; AJvYcCUICdB2usuBb6CbFQQPnjp8mCQafVrN3RmwEAF1fQSwJsYwk9GPg1t9J29cj7LSxaz2OVppj8A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9k2pSqUXMkRnTht+tJgefg/lAOT3Srp+t8rCsqtJBpz0n/u1b
	hpv1poiNxV69AfLHvveTHLK0aiZfuaKBNuFFhn6Vb76AFnbgCa+hXQo8NUIVryXSOx04TN8aWgs
	392AcrgAIbUOeHn7Vz2sKOcb/qiCYxvHjNsPGCWR9FSsN1loAgE5QlNr8rw==
X-Gm-Gg: ASbGncv4MjRsuJj5HoeDnv+3CAf4ZTONLzfCHn16WMo3CKb7NGm2Q072GHzs6wzuP4p
	66eu7if5HsJ3XtAJSuYyLhw/dFgmHJsJcrZfsHjEOuz70P8C8kbr6OfAbw+37B5WFhS1y6lxnHH
	ZuKbCxd14LuQoy77AB3JhjLqZhZGCq4zOZ9J2II1sC67Ggvceyo2UQjpfIAdnkqM9pVd7tvAqCB
	tMlyaSIU0dT9L5wF86EJCJipLjLgKF+zUcRLqLpG7PjZQrqqFE35SMJz30C6/goJES32Bmdq2Ey
	FDtVU8XjALYXJZaTHyqJ5/NtRsUfTBMO0UJSSGkCQHyXM5RMuYs/K8YTJtQ6DoZgvyLCS+OQHPJ
	5cQ+xLFIR7Sswe40NzS7NvCWPNmrejYKk
X-Received: by 2002:a05:6000:40ca:b0:429:927e:f2d with SMTP id ffacd0b85a97d-429a7e7c749mr2889989f8f.38.1761654645142;
        Tue, 28 Oct 2025 05:30:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG7VWu1SeQzGMTvsGngxg3n6PbbCnycHv6IKEDtKtHjHqjgMWOZby3dOBVswiYkPRmc1I0l4Q==
X-Received: by 2002:a05:6000:40ca:b0:429:927e:f2d with SMTP id ffacd0b85a97d-429a7e7c749mr2889962f8f.38.1761654644712;
        Tue, 28 Oct 2025 05:30:44 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952b7badsm19778750f8f.7.2025.10.28.05.30.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 05:30:44 -0700 (PDT)
Message-ID: <bcfd4b80-df1b-4b6c-8ae2-1b3dbd8de23a@redhat.com>
Date: Tue, 28 Oct 2025 13:30:43 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/mremap: Honour writable bit in mremap pte batching
To: Pedro Falcato <pfalcato@suse.de>, Dev Jain <dev.jain@arm.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
 Barry Song <baohua@kernel.org>, "open list:MEMORY MAPPING"
 <linux-mm@kvack.org>
References: <20251028063952.90313-1-dev.jain@arm.com>
 <jmxnalmkkc5ztfhokqtzqihsdji2gprnv5z4tzruxi6iqgfkni@aerronulpyem>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <jmxnalmkkc5ztfhokqtzqihsdji2gprnv5z4tzruxi6iqgfkni@aerronulpyem>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28.10.25 12:48, Pedro Falcato wrote:
> On Tue, Oct 28, 2025 at 12:09:52PM +0530, Dev Jain wrote:
>> Currently mremap folio pte batch ignores the writable bit during figuring
>> out a set of similar ptes mapping the same folio. Suppose that the first
>> pte of the batch is writable while the others are not - set_ptes will
>> end up setting the writable bit on the other ptes, which is a violation
>> of mremap semantics. Therefore, use FPB_RESPECT_WRITE to check the writable
>> bit while determining the pte batch.
>>
> 
> Hmm, it seems to be like we're doing the wrong thing by default here?
> I must admit I haven't followed the contpte work as much as I would've
> liked, but it doesn't make much sense to me why FPB_RESPECT_WRITE would
> be an option you have to explicitly pass, and where folio_pte_batch (the
> "simple" interface) doesn't Just Do The Right Thing for naive callers.

We use the "simple" version to apply to as many callers as possible: the 
common case, not some "let's be super careful" scenarios.

> 
> Auditing all callers:
>   - khugepaged clears a variable number of ptes
>   - memory.c clears a variable number of ptes
>   - mempolicy.c grabs folios for migrations
>   - mlock.c steps over nr_ptes - 1 ptes, speeding up traversal
>   - mremap is borked since we're remapping nr_ptes ptes
>   - rmap.c TTU unmaps nr_ptes ptes for a given folio
> 
>   so while the vast majority of callers don't seem to care, it would make
>   sense that folio_pte_batch() works conservatively by default, and
>   folio_pte_batch_flags() would allow for further batching (or maybe
>   we would add a separate folio_pte_batch_clear() or
>   folio_pte_batch_greedy() or whatnot).

I think really the tricky part is when we'e not only scanning or 
clearing, but actually want to "set" ptes again based on the result, 
like we do here.

For that we could consider having a second variant. But if it ends up 
having only a single caller, it's also not that great.

> 
>> Cc: stable@vger.kernel.org #6.17
>> Fixes: f822a9a81a31 ("mm: optimize mremap() by PTE batching")
>> Reported-by: David Hildenbrand <david@redhat.com>
>> Debugged-by: David Hildenbrand <david@redhat.com>
>> Signed-off-by: Dev Jain <dev.jain@arm.com>
> 
> But the solution itself looks okay to me. so, fwiw:
> 
> Acked-by: Pedro Falcato <pfalcato@suse.de>
> 

Backport might end up being a bit tricky I suspect.

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb


