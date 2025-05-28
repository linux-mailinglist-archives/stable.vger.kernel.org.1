Return-Path: <stable+bounces-147971-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57A4AAC6C92
	for <lists+stable@lfdr.de>; Wed, 28 May 2025 17:09:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F20A71BC785C
	for <lists+stable@lfdr.de>; Wed, 28 May 2025 15:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE95E28B4FC;
	Wed, 28 May 2025 15:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hab5H/tc"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCAED28B3F6
	for <stable@vger.kernel.org>; Wed, 28 May 2025 15:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748444975; cv=none; b=qDMcEgibjaoarSj6/Zixh6g3Xqvi86WGSky+JjrE9FDE/BXZcwBnSPq5F4PnlI/HrnY0GcVcmb8Q4p2Oi3WvGwGFljwOpJg53CQd13eg0K5xj+aSh7E0iyVVFyEGYpwOvIQ35MraB6pM2PZmXxDUpdbvSJv+k1KXR183lBgtKQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748444975; c=relaxed/simple;
	bh=TGXEr7l1J7mfsMG6BxAhgUCbUt3uGdg19nubkOmfw+M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CL2pMhdqojRM3H96OiwCIigcGzBg+ljx6xiWvy4+kpj7SjkeaAuvtWI5MQ0o5Lr6s7Yi2j0rOcqHAZsQtDO0jdE4gMt+4ZJ+I6x1KSHTmg/jZlyKhB9rK9RzP9y6/wEQUDlqHW4cioH6BcrLygibtMok0JVZYCCGBEE3HCNpgfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hab5H/tc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748444972;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ZtG4pUsrLMzZSuXA5vOxqh/0qXdhBG7xRWPrPlWmp+s=;
	b=Hab5H/tc59qFPZegWbmmkZN5TLVK95Xg8ERHDti4nwRQeMQTiTila8az88Q5pSU0UDNuyU
	PgvfFzkwmv1PTXt9uF3ldvk8YpKT4KPtj9+BPebYosQrcpTCq3ab4EWT0nThcOblni2RUh
	CQLBGp9yGOkbQYRbyR/sizUDVU9JzRE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-144-Z6uXGXllPM2f1VfUZMxmow-1; Wed, 28 May 2025 11:09:30 -0400
X-MC-Unique: Z6uXGXllPM2f1VfUZMxmow-1
X-Mimecast-MFC-AGG-ID: Z6uXGXllPM2f1VfUZMxmow_1748444969
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-44b1f5b8e9dso17927725e9.2
        for <stable@vger.kernel.org>; Wed, 28 May 2025 08:09:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748444969; x=1749049769;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZtG4pUsrLMzZSuXA5vOxqh/0qXdhBG7xRWPrPlWmp+s=;
        b=mgIikG45Aw5RaHS9jZkXuiiclfpsCVZFxzWlXZFuGk8YwRdWbCYao1vFS0F75LRmvs
         NWmr8UU5pvjjZrSC74qDshN7feUm//asgQGAQCPea3G5KeV988pNgWXdMSjsOzgf5I5C
         aL3AtdQ7bs5H1R7+1qBVQrFioeiyBpcARb/kPiQVOVF3Djek6Cr1dgdvOcGVZW8PLKbq
         gabZjOcH/QhU7dokPQHIpup5psTdtWiooo+RJa4VJu3xCNHU31kixfByPXtnVdXvLQ1+
         8C2TWYrHtzRHNAlJUzjvGgDnvTqckgemyCro1Uj8YXM6Ywh5/SbDOUmkeFdDLRxuGyx4
         XzYg==
X-Forwarded-Encrypted: i=1; AJvYcCWDXWYxgdM6FnhOxi/ybgOwtAnWYT/6kIXljvaS2VU4zmEGLD/oq5JmywTMgOdL38dU2GAfUg0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5QiKPMb0nc5UQ3fstHuFE69YQXq5RkKJQRskhE1p9DmH0AhRD
	8J5jNG/KHlGYKnY6JYKxHtf4M95aMBD7QPFZ5abVAq7zBK/bxVw5qtTpZ8xXe1lDo39exUo73Vv
	P1AoqXV/RcahaMB2mK5WgFc4HyeTFcAe9a/NnRHz3yLJ4q28fwHVpiRquHw==
X-Gm-Gg: ASbGnctfLwnuRHBdYpivOK4l4/gm2ojF2+NFi/dfDe/gfYHQpS2TTH9EfWGBCEorNV6
	0Hdoshv7pNioxl/2PcBS2Rz4MDZLLUjQLUhJdA1gtVH1jeUPkYP40RMhlX+FHOjsyuN6lGT1Fhp
	TLAKJBgK6ylYx0QqftbqcruCjyDoT4bfB2CACJZG4EpQrqfZuI1cXodGRLgszEuK9lsXJBjiExw
	2KpsM5YdChClTvx+8gAIYm3TPPYI6NAZJuJyMsMS/5MpTiEVn46fRLa2fkiSP5qGoWiTZ4s5ZSj
	VoAq+atnnEddwomZLH9vjEFB/rKrDoYGYgo2Zth/nq0d5yqE+Ru28qdGgd/5DS/w4Sunznw5+FN
	nGHeAb2C9HL8O0PvqALVfyzx3PET5o51K9uQdaSA=
X-Received: by 2002:a05:600c:6215:b0:43d:563:6fef with SMTP id 5b1f17b1804b1-44c9493e615mr149339645e9.21.1748444968652;
        Wed, 28 May 2025 08:09:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEk5kAdrFJFRNmWPkWjusixhiFB3w3jWwCIaQbToe4XMiw4O+ZQo3iB46t4RqFj+pR/iFF74w==
X-Received: by 2002:a05:600c:6215:b0:43d:563:6fef with SMTP id 5b1f17b1804b1-44c9493e615mr149339245e9.21.1748444968184;
        Wed, 28 May 2025 08:09:28 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f30:ec00:8f7e:58a4:ebf0:6a36? (p200300d82f30ec008f7e58a4ebf06a36.dip0.t-ipconnect.de. [2003:d8:2f30:ec00:8f7e:58a4:ebf0:6a36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450064ae786sm24445705e9.23.2025.05.28.08.09.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 May 2025 08:09:27 -0700 (PDT)
Message-ID: <629bb87e-c493-4069-866c-20e02c14ddcc@redhat.com>
Date: Wed, 28 May 2025 17:09:26 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] mm/hugetlb: fix a deadlock with pagecache_folio and
 hugetlb_fault_mutex_table
To: Peter Xu <peterx@redhat.com>, Oscar Salvador <osalvador@suse.de>
Cc: Gavin Guo <gavinguo@igalia.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, muchun.song@linux.dev,
 akpm@linux-foundation.org, mike.kravetz@oracle.com, kernel-dev@igalia.com,
 stable@vger.kernel.org, Hugh Dickins <hughd@google.com>,
 Florent Revest <revest@google.com>, Gavin Shan <gshan@redhat.com>
References: <20250528023326.3499204-1-gavinguo@igalia.com>
 <aDbXEnqnpDnAx4Mw@localhost.localdomain> <aDcl2YM5wX-MwzbM@x1.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <aDcl2YM5wX-MwzbM@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28.05.25 17:03, Peter Xu wrote:
> On Wed, May 28, 2025 at 11:27:46AM +0200, Oscar Salvador wrote:
>> On Wed, May 28, 2025 at 10:33:26AM +0800, Gavin Guo wrote:
>>> There is ABBA dead locking scenario happening between hugetlb_fault()
>>> and hugetlb_wp() on the pagecache folio's lock and hugetlb global mutex,
>>> which is reproducible with syzkaller [1]. As below stack traces reveal,
>>> process-1 tries to take the hugetlb global mutex (A3), but with the
>>> pagecache folio's lock hold. Process-2 took the hugetlb global mutex but
>>> tries to take the pagecache folio's lock.
>>>
>>> Process-1                               Process-2
>>> =========                               =========
>>> hugetlb_fault
>>>     mutex_lock                  (A1)
>>>     filemap_lock_hugetlb_folio  (B1)
>>>     hugetlb_wp
>>>       alloc_hugetlb_folio       #error
>>>         mutex_unlock            (A2)
>>>                                          hugetlb_fault
>>>                                            mutex_lock                  (A4)
>>>                                            filemap_lock_hugetlb_folio  (B4)
>>>         unmap_ref_private
>>>         mutex_lock              (A3)
>>>
>>> Fix it by releasing the pagecache folio's lock at (A2) of process-1 so
>>> that pagecache folio's lock is available to process-2 at (B4), to avoid
>>> the deadlock. In process-1, a new variable is added to track if the
>>> pagecache folio's lock has been released by its child function
>>> hugetlb_wp() to avoid double releases on the lock in hugetlb_fault().
>>> The similar changes are applied to hugetlb_no_page().
>>>
>>> Link: https://drive.google.com/file/d/1DVRnIW-vSayU5J1re9Ct_br3jJQU6Vpb/view?usp=drive_link [1]
>>> Fixes: 40549ba8f8e0 ("hugetlb: use new vma_lock for pmd sharing synchronization")
>>> Cc: <stable@vger.kernel.org>
>>> Cc: Hugh Dickins <hughd@google.com>
>>> Cc: Florent Revest <revest@google.com>
>>> Reviewed-by: Gavin Shan <gshan@redhat.com>
>>> Signed-off-by: Gavin Guo <gavinguo@igalia.com>
>> ...
>>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>>> index 6a3cf7935c14..560b9b35262a 100644
>>> --- a/mm/hugetlb.c
>>> +++ b/mm/hugetlb.c
>>> @@ -6137,7 +6137,8 @@ static void unmap_ref_private(struct mm_struct *mm, struct vm_area_struct *vma,
>>>    * Keep the pte_same checks anyway to make transition from the mutex easier.
>>>    */
>>>   static vm_fault_t hugetlb_wp(struct folio *pagecache_folio,
>>> -		       struct vm_fault *vmf)
>>> +		       struct vm_fault *vmf,
>>> +		       bool *pagecache_folio_locked)
>>>   {
>>>   	struct vm_area_struct *vma = vmf->vma;
>>>   	struct mm_struct *mm = vma->vm_mm;
>>> @@ -6234,6 +6235,18 @@ static vm_fault_t hugetlb_wp(struct folio *pagecache_folio,
>>>   			u32 hash;
>>>   
>>>   			folio_put(old_folio);
>>> +			/*
>>> +			 * The pagecache_folio has to be unlocked to avoid
>>> +			 * deadlock and we won't re-lock it in hugetlb_wp(). The
>>> +			 * pagecache_folio could be truncated after being
>>> +			 * unlocked. So its state should not be reliable
>>> +			 * subsequently.
>>> +			 */
>>> +			if (pagecache_folio) {
>>> +				folio_unlock(pagecache_folio);
>>> +				if (pagecache_folio_locked)
>>> +					*pagecache_folio_locked = false;
>>> +			}
>>
>> I am having a problem with this patch as I think it keeps carrying on an
>> assumption that it is not true.
>>
>> I was discussing this matter yesterday with Peter Xu (CCed now), who has also some
>> experience in this field.
>>
>> Exactly against what pagecache_folio's lock protects us when
>> pagecache_folio != old_folio?
>>
>> There are two cases here:
>>
>> 1) pagecache_folio = old_folio  (original page in the pagecache)
>> 2) pagecache_folio != old_folio (original page has already been mapped
>>                                   privately and CoWed, old_folio contains
>> 				 the new folio)
>>
>> For case 1), we need to hold the lock because we are copying old_folio
>> to the new one in hugetlb_wp(). That is clear.
> 
> So I'm not 100% sure we need the folio lock even for copy; IIUC a refcount
> would be enough?

The introducing patches seem to talk about blocking concurrent migration 
/ rmap walks.

Maybe also concurrent fallocate(PUNCH_HOLE) is a problem regarding 
reservations? Not sure ...


For 2) I am also not sure if we need need the pagecache folio locked; I 
doubt it ... but this code is not the easiest to follow.

-- 
Cheers,

David / dhildenb


