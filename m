Return-Path: <stable+bounces-146368-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE4B4AC3FFA
	for <lists+stable@lfdr.de>; Mon, 26 May 2025 15:00:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10C76188E770
	for <lists+stable@lfdr.de>; Mon, 26 May 2025 13:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B018D202987;
	Mon, 26 May 2025 13:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V1nx0LED"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4A415E5DC
	for <stable@vger.kernel.org>; Mon, 26 May 2025 12:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748264401; cv=none; b=SXdRF8hXjB6Vdz9y5jrdlMQ+itoDOiXXrKhxEbACNKGJHHk3JLSM78pUBLFyDQJWJl4K33lXXm4mqsGRYTpyPIoTUxOR9r/2m+hIj7V9d95pouwohabJ/d6uRpFvbhwln/DLnj9TowxgQfK4dRgIC5e+1KQMDK8sRwAMy1OWhxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748264401; c=relaxed/simple;
	bh=GPDmM427tdPYI24Bk6z/gaji3dcD9ymvvBXqIVij4GI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L9RqqODA2IiIVSc9Frz98g/5ZixjZ3SRguphbm5ZIguEfridtfDgvv0H4RKlk+tgYPj0PQ/15ckV9cGyZdq+QgnG8SPi/vyxEgOw8NB1eHq9u2LWvTpsCsfLU/eiIL9aeLIePppVZxgkhnbkHojnmgIIHWtvN2o6cqjDWTOTIow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V1nx0LED; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748264398;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=n6EYd9d/BuLZh3EC8tMgXIbGwz3KQXX+Z+svUMtDejY=;
	b=V1nx0LED7UdtpCSqLC3ownUesgy7RFph8e+VS/kOWeJemHg8KH8elO+g8IrsEQVTUk9xOr
	tSiCenGkv5eABDZiFJL/+Yq335JMuS23ZmVo4z/02N+7Ojd6HjLmEl6fnRCPum6Of/xqfR
	B/YMzdlUfZtpfnZiCQwYB2WWZQoTgAc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-319-NrSos3tZMpiTCj90OM3cBg-1; Mon, 26 May 2025 08:59:57 -0400
X-MC-Unique: NrSos3tZMpiTCj90OM3cBg-1
X-Mimecast-MFC-AGG-ID: NrSos3tZMpiTCj90OM3cBg_1748264396
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a375938404so1473482f8f.0
        for <stable@vger.kernel.org>; Mon, 26 May 2025 05:59:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748264396; x=1748869196;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=n6EYd9d/BuLZh3EC8tMgXIbGwz3KQXX+Z+svUMtDejY=;
        b=Xzt+DXgXg3SGZXZBVnAqiB4hNsLS8B1Y5j33wxeXvdNCduQqPqRoR7QYuFzntlIx4p
         E4GFtqV9lo/x7gAzX+10sNnU6PD4c4byPgCU5DjRGbXopL1kyXQgQZWbA8to4sxqIf0A
         uo+4jjkCgjXWSJEwDnoQ0Dyb6Xqy6TeP/iop/Psu4Hpfj46tESKzpluONuZ5AvGNBlNI
         9FJpEWpGFxkHa6yqaVxemyN7AxytYRBgMRHyLOyn2eRAVB0kN3tu7HrPed8hdQ3gQulr
         YYMu0qYTt1CYJmSazDb7hx9O6fwlPSdm2EFA0ZZoDIrN7plnd2LAkrqge6cL4LgBkNIa
         VXZA==
X-Forwarded-Encrypted: i=1; AJvYcCUZxp/aQF6TegARKCdEx5DY2wgzeJaXmyQQxvmm9xJxABT/PjydYb8NeymmB+0avD+lIOT47RA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzclW/n/sUvotbMnT/jfgTtqMA50rz+xKmBt/wEAhl7ojqJa7Yp
	vwW3MHotnQosKDsIVNCUTlRx+uwTNhTWtriPJZAFE6/5v6myKBvoW2EWkgG5crbWGssCHktKwae
	CI4VtFNkdOBJlZXkI4ZwA+Eb5I9tjAeVkenzefMBzHnB5U3aOVZc0X1RGyw==
X-Gm-Gg: ASbGncvKEnuYs/KhsYmK18cY9kmwRSaBriaBfTBix6FSLTzh21FxCiFht8OzxNDXkf/
	NDmlnDVcTj9FFpHb7JkMPtiCQnF8tlgF6Ou4qiYzSUQTnDY8Jek6m5B1AjVKWOSAnDS3hXGNgVU
	zhvegmPIR+/sLcbukzOofejx1tRtDUI8skqUOl1fZ25wIRsTEF/pnM4ZVjkOv/J83rAgAxLSMgj
	7PYv0ab3sKVW9ZnI+S5r60QHEB40vsBH8AMkgBusmj77mTmLaP898v/bd1BQJDsRMp/m05Jk1Tr
	lVNE8FhKsFe4YHT+SJDP7VRHe0RDMncB4/d7XLd2FdgmdzbMbmjjerUc2oEbJZZ0GWy1DlgzXPN
	JFB1ET2KNamnbb5F0Ux8ygWc8w8T2QYhvUh7vK5M=
X-Received: by 2002:a05:6000:2910:b0:3a0:9dfc:da4 with SMTP id ffacd0b85a97d-3a4cb489adcmr6051684f8f.42.1748264396152;
        Mon, 26 May 2025 05:59:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFU7sCqih/eqD4nOcXRC1xvOuPP39fwhwretOa+FIqMiws+mWE4SttUe+YY9ZMHmwcoCHBVxA==
X-Received: by 2002:a05:6000:2910:b0:3a0:9dfc:da4 with SMTP id ffacd0b85a97d-3a4cb489adcmr6051667f8f.42.1748264395757;
        Mon, 26 May 2025 05:59:55 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f19:6500:e1c1:8216:4c25:efe4? (p200300d82f196500e1c182164c25efe4.dip0.t-ipconnect.de. [2003:d8:2f19:6500:e1c1:8216:4c25:efe4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4d1ed8740sm5369659f8f.83.2025.05.26.05.59.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 May 2025 05:59:55 -0700 (PDT)
Message-ID: <87521d93-cc03-480d-a2ef-3ef8c84481c9@redhat.com>
Date: Mon, 26 May 2025 14:59:54 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/hugetlb: fix kernel NULL pointer dereference when
 replacing free hugetlb folios
To: Ge Yang <yangge1116@126.com>, akpm@linux-foundation.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 21cnbao@gmail.com, baolin.wang@linux.alibaba.com, muchun.song@linux.dev,
 osalvador@suse.de, liuzixing@hygon.cn
References: <1747884137-26685-1-git-send-email-yangge1116@126.com>
 <d405ba61-0002-4663-8ab7-ab728049d8a3@redhat.com>
 <07b7d4fd-c600-4de1-aea4-037e148da79b@126.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <07b7d4fd-c600-4de1-aea4-037e148da79b@126.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 26.05.25 14:57, Ge Yang wrote:
> 
> 
> 在 2025/5/26 20:41, David Hildenbrand 写道:
>> On 22.05.25 05:22, yangge1116@126.com wrote:
>>> From: Ge Yang <yangge1116@126.com>
>>>
>>> A kernel crash was observed when replacing free hugetlb folios:
>>>
>>> BUG: kernel NULL pointer dereference, address: 0000000000000028
>>> PGD 0 P4D 0
>>> Oops: Oops: 0000 [#1] SMP NOPTI
>>> CPU: 28 UID: 0 PID: 29639 Comm: test_cma.sh Tainted 6.15.0-rc6-zp #41
>>> PREEMPT(voluntary)
>>> RIP: 0010:alloc_and_dissolve_hugetlb_folio+0x1d/0x1f0
>>> RSP: 0018:ffffc9000b30fa90 EFLAGS: 00010286
>>> RAX: 0000000000000000 RBX: 0000000000342cca RCX: ffffea0043000000
>>> RDX: ffffc9000b30fb08 RSI: ffffea0043000000 RDI: 0000000000000000
>>> RBP: ffffc9000b30fb20 R08: 0000000000001000 R09: 0000000000000000
>>> R10: ffff88886f92eb00 R11: 0000000000000000 R12: ffffea0043000000
>>> R13: 0000000000000000 R14: 00000000010c0200 R15: 0000000000000004
>>> FS:  00007fcda5f14740(0000) GS:ffff8888ec1d8000(0000)
>>> knlGS:0000000000000000
>>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>> CR2: 0000000000000028 CR3: 0000000391402000 CR4: 0000000000350ef0
>>> Call Trace:
>>> <TASK>
>>>    replace_free_hugepage_folios+0xb6/0x100
>>>    alloc_contig_range_noprof+0x18a/0x590
>>>    ? srso_return_thunk+0x5/0x5f
>>>    ? down_read+0x12/0xa0
>>>    ? srso_return_thunk+0x5/0x5f
>>>    cma_range_alloc.constprop.0+0x131/0x290
>>>    __cma_alloc+0xcf/0x2c0
>>>    cma_alloc_write+0x43/0xb0
>>>    simple_attr_write_xsigned.constprop.0.isra.0+0xb2/0x110
>>>    debugfs_attr_write+0x46/0x70
>>>    full_proxy_write+0x62/0xa0
>>>    vfs_write+0xf8/0x420
>>>    ? srso_return_thunk+0x5/0x5f
>>>    ? filp_flush+0x86/0xa0
>>>    ? srso_return_thunk+0x5/0x5f
>>>    ? filp_close+0x1f/0x30
>>>    ? srso_return_thunk+0x5/0x5f
>>>    ? do_dup2+0xaf/0x160
>>>    ? srso_return_thunk+0x5/0x5f
>>>    ksys_write+0x65/0xe0
>>>    do_syscall_64+0x64/0x170
>>>    entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>>
>>> There is a potential race between __update_and_free_hugetlb_folio()
>>> and replace_free_hugepage_folios():
>>>
>>> CPU1                              CPU2
>>> __update_and_free_hugetlb_folio   replace_free_hugepage_folios
>>>                                       folio_test_hugetlb(folio)
>>>                                       -- It's still hugetlb folio.
>>>
>>>     __folio_clear_hugetlb(folio)
>>>     hugetlb_free_folio(folio)
>>>                                       h = folio_hstate(folio)
>>>                                       -- Here, h is NULL pointer
>>>
>>> When the above race condition occurs, folio_hstate(folio) returns
>>> NULL, and subsequent access to this NULL pointer will cause the
>>> system to crash. To resolve this issue, execute folio_hstate(folio)
>>> under the protection of the hugetlb_lock lock, ensuring that
>>> folio_hstate(folio) does not return NULL.
>>>
>>> Fixes: 04f13d241b8b ("mm: replace free hugepage folios after migration")
>>> Signed-off-by: Ge Yang <yangge1116@126.com>
>>> Cc: <stable@vger.kernel.org>
>>> ---
>>>    mm/hugetlb.c | 8 ++++++++
>>>    1 file changed, 8 insertions(+)
>>>
>>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>>> index 3d3ca6b..6c2e007 100644
>>> --- a/mm/hugetlb.c
>>> +++ b/mm/hugetlb.c
>>> @@ -2924,12 +2924,20 @@ int replace_free_hugepage_folios(unsigned long
>>> start_pfn, unsigned long end_pfn)
>>>        while (start_pfn < end_pfn) {
>>>            folio = pfn_folio(start_pfn);
>>> +
>>> +        /*
>>> +         * The folio might have been dissolved from under our feet,
>>> so make sure
>>> +         * to carefully check the state under the lock.
>>> +         */
>>> +        spin_lock_irq(&hugetlb_lock);
>>>            if (folio_test_hugetlb(folio)) {
>>>                h = folio_hstate(folio);
>>>            } else {
>>> +            spin_unlock_irq(&hugetlb_lock);
>>>                start_pfn++;
>>>                continue;
>>>            }
>>> +        spin_unlock_irq(&hugetlb_lock);
>>
>> As mentioned elsewhere, this will grab the hugetlb_lock for each and
>> every pfn in the range if there are no hugetlb folios (common case).
>>
>> That should certainly *not* be done.
>>
>> In case we see !folio_test_hugetlb(), we should just move on.
>>
> 
> The main reason for acquiring the hugetlb_lock here is to obtain a valid
> hstate, as the alloc_and_dissolve_hugetlb_folio() function requires
> hstate as a parameter. This approach is indeed not performance-friendly.
> However, in the patch available at
> https://lore.kernel.org/lkml/1747987559-23082-1-git-send-email-yangge1116@126.com/,
> all these operations will be removed.

No, you still take locks on anything that is !folio_ref_count(folio).

We should really have an early folio_test_hugetlb(folio) check.

hugetlb is on most systems out there the absolute *corner case*.

-- 
Cheers,

David / dhildenb


