Return-Path: <stable+bounces-181595-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D7B8B99353
	for <lists+stable@lfdr.de>; Wed, 24 Sep 2025 11:44:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F17757A5F66
	for <lists+stable@lfdr.de>; Wed, 24 Sep 2025 09:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04D7D2D9ECF;
	Wed, 24 Sep 2025 09:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ym2fl5Ds"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9FB2D6E7C
	for <stable@vger.kernel.org>; Wed, 24 Sep 2025 09:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758707071; cv=none; b=YydgtTa8bfI6eYXkXe1ocM8bqWsrgNXBCpez8UezEvImsR3X7Z6nFqdkU64Mphtoi42tJs1f6ul3rbb6oCeouva/eqVfgTDW4g1oUZg2uBtUHxs28tYjP/O5rDk2f2vN3zYqGkeA3pODF7nLPJ5X9JxVIpi/1EbfwfZsoDtyZg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758707071; c=relaxed/simple;
	bh=4s100bPTrmRD7DGyAx9wp/K6igbRMgHRHMBH2MdPXPk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lBh4TqeBosdZLWXN/EagyCq2mjxqq11CynstwJ1yon2JHhyBv2hjG6ttaSPALbKZHBbI6SOpOdqlEV1Mc6gFBfNTDxyzE6pN0VXFkBRTHKuWHtk9jBMQZL3yBUBD7QR1t2QAgoSudGI6lcMkkXTJLpxzcwej7oI8Wo1c6ELvuS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ym2fl5Ds; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758707065;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=LATvy2V6SYrxON5S0ZwKxz6/ssurKvZ0zpsAbTZsXD4=;
	b=Ym2fl5DsEBP/zm3pmP3tCV37bPoTuhLZTx3SXhSRx/No2FLicoa8MslT2xHsSYV1flh3UQ
	YXJd4+NCoJt4CSDVyu3Ps1BMSK8bM+9oCcc2wgYkwWzICsFKdOX+dQ4QKprC5eRHoTotYY
	+ok7+B0AeZHI+t66KpmExa3j0ITYx88=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-_B1V_K_eNAeV4GxtWNmRdg-1; Wed, 24 Sep 2025 05:44:24 -0400
X-MC-Unique: _B1V_K_eNAeV4GxtWNmRdg-1
X-Mimecast-MFC-AGG-ID: _B1V_K_eNAeV4GxtWNmRdg_1758707063
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-46b15e6f227so13280175e9.1
        for <stable@vger.kernel.org>; Wed, 24 Sep 2025 02:44:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758707063; x=1759311863;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LATvy2V6SYrxON5S0ZwKxz6/ssurKvZ0zpsAbTZsXD4=;
        b=mjfJHCaWGx8kbzfiRUM/FwV9H0hPMzF0sHb9OEnODrt/r1caU3NxIEDUdWshtyrCbt
         3cGdlzx7ERwGD0iJHisAwOfdhnw4FL66bhsRnvrKIgyj+mhY0SRSN0kePc2zXBolABka
         whXtxlEte8ki+2pXI/t4LqqWD6SyVuBX822neFZGWAwBLEt9NMySnzBIFtYKmEh/cBir
         JHYbJgfZzGr8DkUWvccyYqZzdw8DFWMTWHrPxdC0pUSFTqnGZ/W+IwxcXPuLLTnMfZN1
         ax7qAzKVRIMFprzCZwH141GWGC7UQf9USF9zuAU2iu26vIbDpBx8DpIDze7X65eznxjw
         tqkQ==
X-Forwarded-Encrypted: i=1; AJvYcCVR5fDhYkEZUrM6avJkzLHKO5jD8p3tVweW4MxI3CzU012/1ee9PIXwU5hO0vulyUOFoomPiUU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBFkgxSSc0vgRtj4nzjxfTsTwSJfFJ7eUh+XM4MlC20we+kPJd
	OwYyO2Su0bl5vg5LQpTAH4wEEecK3cKuYR1LPy/rauWXhCuv4IPOgiduuoa+gmQfTDnPPDDt22W
	g4b88aDlxxUod2l9Yns2XCHVfkf3whJRBXp7OEnFJAmvEubkxmUJxyAM6yQ==
X-Gm-Gg: ASbGnctc9g3Cvdb/y58PIDFotTwoyxwNN+N0XbTbxXpEXkux8flhVEP3lMe5xBRcbJv
	zxjuhsfSBX9tSQN5xAVEJDko6XaLsvpu5hBRREo+YutLeeHYKwj5l7veVnjxizERy2yUpeWWzjj
	xgzL7qc8S+56aQLe7fXOZlX8+wKs6l4SapqW8X3QW64H3R/OXlGdd7nvsxFKpeJ9TDcFWZ/z22A
	tfRPysiJC3M884jxUIOPWmVJCMXKkz6tDHMhAijsYYxO9EXVW4QgDW6MNeF5auEuGVIbt7WGrXh
	j+hqf3W+8qb2sPEWL3svuGuybC5M9JrrUv5Ve+2K3nBcjmNHMfwt0v90sqSJGT5xvPuPR8nrCTB
	y+u2WG3kgnZDjWlt/VDqxhQMHcZQ4qPEyH45zjqxdk/9qPgOobquAB0GjGzbnGD5v8Q==
X-Received: by 2002:a05:600c:8b4c:b0:46e:1ae7:dc1a with SMTP id 5b1f17b1804b1-46e1dacdeccmr60077145e9.35.1758707062734;
        Wed, 24 Sep 2025 02:44:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFtajsvp/kDNdAlIZ81myaBdoqXgoPzgIMj71ym20C24BB7lOR6FEuJDw/hq3ekdj+UMiHTYg==
X-Received: by 2002:a05:600c:8b4c:b0:46e:1ae7:dc1a with SMTP id 5b1f17b1804b1-46e1dacdeccmr60076735e9.35.1758707062201;
        Wed, 24 Sep 2025 02:44:22 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f14:2400:afc:9797:137c:a25b? (p200300d82f1424000afc9797137ca25b.dip0.t-ipconnect.de. [2003:d8:2f14:2400:afc:9797:137c:a25b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e2aad99f8sm25671645e9.17.2025.09.24.02.44.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Sep 2025 02:44:21 -0700 (PDT)
Message-ID: <791e0d59-0eb2-481f-bf8b-ba4b413d5ebd@redhat.com>
Date: Wed, 24 Sep 2025 11:44:19 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] mm/thp: fix MTE tag mismatch when replacing
 zero-filled subpages
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Lance Yang <lance.yang@linux.dev>, akpm@linux-foundation.org,
 lorenzo.stoakes@oracle.com, usamaarif642@gmail.com, yuzhao@google.com,
 ziy@nvidia.com, baolin.wang@linux.alibaba.com, baohua@kernel.org,
 voidice@gmail.com, Liam.Howlett@oracle.com, cerasuolodomenico@gmail.com,
 hannes@cmpxchg.org, kaleshsingh@google.com, npache@redhat.com,
 riel@surriel.com, roman.gushchin@linux.dev, rppt@kernel.org,
 ryan.roberts@arm.com, dev.jain@arm.com, ryncsn@gmail.com,
 shakeel.butt@linux.dev, surenb@google.com, hughd@google.com,
 willy@infradead.org, matthew.brost@intel.com, joshua.hahnjy@gmail.com,
 rakie.kim@sk.com, byungchul@sk.com, gourry@gourry.net,
 ying.huang@linux.alibaba.com, apopple@nvidia.com, qun-wei.lin@mediatek.com,
 Andrew.Yang@mediatek.com, casper.li@mediatek.com,
 chinwen.chang@mediatek.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
 linux-mm@kvack.org, ioworker0@gmail.com, stable@vger.kernel.org
References: <20250922021458.68123-1-lance.yang@linux.dev>
 <aNGGUXLCn_bWlne5@arm.com> <a3412715-6d9d-4809-9588-ba08da450d16@redhat.com>
 <aNKJ5glToE4hMhWA@arm.com> <aNLHexcNI53HQ46A@arm.com>
 <f2fe9c01-2a8d-4de9-abd5-dbb86d15a37b@linux.dev> <aNOwuKmbAaMaEMb7@arm.com>
 <17dabd83-0849-44c9-b4a2-196af60d9676@redhat.com> <aNO7MrQt9oPT8Hic@arm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <aNO7MrQt9oPT8Hic@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24.09.25 11:34, Catalin Marinas wrote:
> On Wed, Sep 24, 2025 at 11:13:18AM +0200, David Hildenbrand wrote:
>> On 24.09.25 10:50, Catalin Marinas wrote:
>>> On Wed, Sep 24, 2025 at 10:49:27AM +0800, Lance Yang wrote:
>>>> On 2025/9/24 00:14, Catalin Marinas wrote:
>>>>> So alternative patch that also fixes the deferred struct page init (on
>>>>> the assumptions that the zero page is always mapped as pte_special():
>>>>
>>>> I can confirm that this alternative patch also works correctly; my tests
>>>> for MTE all pass ;)
>>>
>>> Thanks Lance for testing. I'll post one of the variants today.
>>>
>>>> This looks like a better fix since it solves the boot hang issue too.
>>>
>>> In principle, yes, until I tracked down why I changed it in the first
>>> place - 68d54ceeec0e ("arm64: mte: Allow PTRACE_PEEKMTETAGS access to
>>> the zero page"). ptrace() can read tags from PROT_MTE mappings and we
>>> want to allow reading zeroes as well if the page points to the zero
>>> page. Not flagging the page as PG_mte_tagged caused issues.
>>>
>>> I can change the logic in the ptrace() code, I just need to figure out
>>> what happens to the huge zero page. Ideally we should treat both in the
>>> same way but, AFAICT, we don't use pmd_mkspecial() on the huge zero
>>> page, so it gets flagged with PG_mte_tagged.
>>
>> I changed that recently :) The huge zero folio will now always have
>> pmd_special() set.
> 
> Oh, which commit was this? It means that we can end up with
> uninitialised tags if we have a PROT_MTE huge zero page since
> set_pmd_at/set_pte_at() skips mte_sync_tags().
> 

This one:

commit d82d09e482199e6bbc204df10b2082f764cbe1f4
Author: David Hildenbrand <david@redhat.com>
Date:   Mon Aug 11 13:26:25 2025 +0200

     mm/huge_memory: mark PMD mappings of the huge zero folio special

     The huge zero folio is refcounted (+mapcounted -- is that a word?)
     differently than "normal" folios, similarly (but different) to the
     ordinary shared zeropage.


It should be in mm-stable, to go upstream in the upcoming merge window. 
It's been lurking in -next for a while now.

As it behaves just like the ordinary shared zeropage now, would we have 
to zero/initialize the tags after allocating it?

-- 
Cheers

David / dhildenb


