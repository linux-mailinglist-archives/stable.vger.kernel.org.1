Return-Path: <stable+bounces-114488-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13C93A2E66D
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 09:29:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 959DD168140
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 08:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A5571C2457;
	Mon, 10 Feb 2025 08:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M+YP1i4o"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF841BEF9C
	for <stable@vger.kernel.org>; Mon, 10 Feb 2025 08:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739176107; cv=none; b=Iv6BepHtDxqq5T0V2/F2W9MBF577Xb22r2csAt3wcZJ41VEbT0ktmbHMuHjunXP6W2/SKKjkvjoJmjaki7wwQdY2FMSqI0cZTFR4nveQfoi9cTg9Bi2MRYkJl7FbyEU+HT0dZVNcLdoObbyw4zGRYoedQRu1V5VJtMO7UYytDhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739176107; c=relaxed/simple;
	bh=V5wU/29c7mNYE3/QefZiuSHFC/1Vw5d/10zz4ZCU6wU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N43TqdS9/SyAehxOttHBgK4Q5VVGBeOP8lhmiq75NqG9fpWJTC96qWmjnhHgps9hTWaokBtIiv2p40e1f/y4W234ML4CnJKXkvaoeBO2uBPjKmkEFxWplMNT8gqdO7xSWuz4zQQfaYRs6zUO6beZnpKrzBz9fr8+ehgWO9rDFb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M+YP1i4o; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739176104;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=bicHG7zjx2UMOO4n8zha5UgWZ2e74X0E23kGVMNRanQ=;
	b=M+YP1i4ov1YX7VO7QzVXrUeDafkSoLJJxts1lQqabdATlAc+sPwGUs1he2sfHX7lV71PNV
	soeGAPSFKlD2tp18N94+lNkPNUVAWDSmyO9BdOS7MLWJuxHGV2I43tNp3YQHxyyiZYZyiP
	PzhdqJCaCloavZCLxQxwmzlDPqzDedc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-TVFOjA4oNNKEgC8eA4nkaA-1; Mon, 10 Feb 2025 03:28:22 -0500
X-MC-Unique: TVFOjA4oNNKEgC8eA4nkaA-1
X-Mimecast-MFC-AGG-ID: TVFOjA4oNNKEgC8eA4nkaA
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43933b8d9b1so8412085e9.3
        for <stable@vger.kernel.org>; Mon, 10 Feb 2025 00:28:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739176101; x=1739780901;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bicHG7zjx2UMOO4n8zha5UgWZ2e74X0E23kGVMNRanQ=;
        b=CTV6QeZdkrCo1dzpJylKkXcaLPoQIepMfqeZU5O3auJB46/ivnA4mO23biWJxo18iT
         YLKNAPQUlC1ECnSlpePtPkc5zAFfYnhtw/AFB0jKnuHchp7h67JHeQ1Icbw4kJ4NhVfD
         o+ZDQ9/0Kk2BtjKakwix2ezQINBjhSD8lH0P4OiHKlEa0wQfNBfw9acRbvVXdcuONWGK
         /tZxkmX6A8eUMRqDWORNg5sWMUcVA4Utxse5xNpBnvI0A2PJF5GpYwGhOpYIbkDjpcWS
         XXPlgoyUQr1wwub/ZfVWqYTIdmz1ihQi25IK1kzcml91k8UanfDWgF8xALqJr4EFHn6n
         tGAw==
X-Forwarded-Encrypted: i=1; AJvYcCVL9XLHPy8b6XxsTMGYiTDR+gHVsMyJX2hdWqFgWGj30VHg6iuAO3gR5NYnPLiiQ6hw1VSORZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqWfGZt/Jf27+b5hmLFzwul1CYDbTWpq/fImqEG1EAjrqkkPvP
	zTzSS+fmQkcVAY11yRXQie8lFDuEIWRbA+IOZtyOEcZI7CmWc7cQJiSnZmdncpvBUsnSINxx+SU
	K/QiGgdlw/x7hQouZRIjczo9DLsZCzvmfbormPCGrdd0G3cHqtSZCrA==
X-Gm-Gg: ASbGncuZMfZroe9DwQxwdEdSDafaWnuDwFZcTObzdoEC2f+9ZmbRaCrFKTcJ6WT5ULm
	4v+XASuWGMU1h2Lf6RGnKo4jXFeVE2lujkEIbMVMfvtKkFGqKW80r5kLFZvYlyGfyobrvnoMmec
	wkgJg4vjUby371gw7xHi8GG7f99J4CxSM+3HOP1zSTagyR0xuzJ32JvBPC3KVR0XiZAg9LYKsfL
	LK1Lan4gylYJYRfcwxi4jmYBzYsCC1K/DjT0fFaWGKNuuyasH8wBDRw9aeHxYDTEVXkeHFuV6VJ
	DapH24oT8LMPBLOibPSdwN6P0hN4hNSVhTt2qxnru+QWwlc6AAMn/mu7eK4zqibhcL1TBRYXiE2
	VpiVFZCrT3UCINgyfHyk18z/poY4n7HuT
X-Received: by 2002:a05:600c:3c8f:b0:439:3e90:c535 with SMTP id 5b1f17b1804b1-4393e90c71cmr40397955e9.0.1739176101209;
        Mon, 10 Feb 2025 00:28:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGVe5xArCsukLiDpa1Z9D7uo1ruE78+ptabaMmnnCZmgUIOVJ8TIj/+l2P6inhlogLtasPzog==
X-Received: by 2002:a05:600c:3c8f:b0:439:3e90:c535 with SMTP id 5b1f17b1804b1-4393e90c71cmr40397635e9.0.1739176100798;
        Mon, 10 Feb 2025 00:28:20 -0800 (PST)
Received: from ?IPV6:2003:cb:c734:b800:12c4:65cd:348a:aee6? (p200300cbc734b80012c465cd348aaee6.dip0.t-ipconnect.de. [2003:cb:c734:b800:12c4:65cd:348a:aee6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dd295200asm6517640f8f.44.2025.02.10.00.28.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Feb 2025 00:28:19 -0800 (PST)
Message-ID: <bb2fbccc-f25b-4c31-98a3-e1699a86dbb5@redhat.com>
Date: Mon, 10 Feb 2025 09:28:17 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/cma: add an API to enable/disable concurrent memory
 allocation for the CMA
To: Barry Song <21cnbao@gmail.com>, Ge Yang <yangge1116@126.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 baolin.wang@linux.alibaba.com, aisheng.dong@nxp.com, liuzixing@hygon.cn
References: <1737717687-16744-1-git-send-email-yangge1116@126.com>
 <CAGsJ_4y2zjCzRUgxkx2GpspFBD9Yon=R3SLaGezk9drQz+ikrQ@mail.gmail.com>
 <28edc5df-eed5-45b8-ab6d-76e63ef635a9@126.com>
 <CAGsJ_4yC=950MCeLDc-8inT52zH6GSEGBBfk+A0dwWEDE5_CMg@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAGsJ_4yC=950MCeLDc-8inT52zH6GSEGBBfk+A0dwWEDE5_CMg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 08.02.25 22:34, Barry Song wrote:
> On Sat, Feb 8, 2025 at 9:50 PM Ge Yang <yangge1116@126.com> wrote:
>>
>>
>>
>> 在 2025/1/28 17:58, Barry Song 写道:
>>> On Sat, Jan 25, 2025 at 12:21 AM <yangge1116@126.com> wrote:
>>>>
>>>> From: yangge <yangge1116@126.com>
>>>>
>>>> Commit 60a60e32cf91 ("Revert "mm/cma.c: remove redundant cma_mutex lock"")
>>>> simply reverts to the original method of using the cma_mutex to ensure
>>>> that alloc_contig_range() runs sequentially. This change was made to avoid
>>>> concurrency allocation failures. However, it can negatively impact
>>>> performance when concurrent allocation of CMA memory is required.
>>>
>>> Do we have some data?
>> Yes, I will add it in the next version, thanks.
>>>
>>>>
>>>> To address this issue, we could introduce an API for concurrency settings,
>>>> allowing users to decide whether their CMA can perform concurrent memory
>>>> allocations or not.
>>>
>>> Who is the intended user of cma_set_concurrency?
>> We have some drivers that use cma_set_concurrency(), but they have not
>> yet been merged into the mainline. The cma_alloc_mem() function in the
>> mainline also supports concurrent allocation of CMA memory. By applying
>> this patch, we can also achieve significant performance improvements in
>> certain scenarios. I will provide performance data in the next version.
>> I also feel it is somewhat
>>> unsafe since cma->concurr_alloc is not protected by any locks.
>> Ok, thanks.
>>>
>>> Will a user setting cma->concurr_alloc = 1 encounter the original issue that
>>> commit 60a60e32cf91 was attempting to fix?
>>>
>> Yes, if a user encounters the issue described in commit 60a60e32cf91,
>> they will not be able to set cma->concurr_alloc to 1.
> 
> A user who hasn't encountered a problem yet doesn't mean they won't
> encounter it; it most likely just means the testing time hasn't been long
> enough.
> 
> Is it possible to implement a per-CMA lock or range lock that simultaneously
> improves performance and prevents the original issue that commit
> 60a60e32cf91 aimed to fix?
> 
> I strongly believe that cma->concurr_alloc is not the right approach. Let's
> not waste our time on this kind of hack or workaround.  Instead, we should
> find a proper fix that remains transparent to users.

Fully agreed.

IIUC, the problem is that we find a pageblock is already isolated. It 
might be sufficient to return -EAGAIN in that case from 
alloc_contig_range_noprof()->start_isolate_page_range() and retry in 
CMA. ideally, we'd have a way to wait on some event (e.g., any pageblock 
transitioning from isolated -> !isolated).

-- 
Cheers,

David / dhildenb


