Return-Path: <stable+bounces-191661-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16485C1C0C9
	for <lists+stable@lfdr.de>; Wed, 29 Oct 2025 17:24:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7B59188A06E
	for <lists+stable@lfdr.de>; Wed, 29 Oct 2025 16:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B11B2F0C67;
	Wed, 29 Oct 2025 16:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mr9hfBAc"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38CF82EA48F
	for <stable@vger.kernel.org>; Wed, 29 Oct 2025 16:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761754802; cv=none; b=ppPX5XQxqQzkbdWHR4WQCVnRLsXmhgbBG1jP+p4SfTOMDbF3xDWVKe3FUfxohyO27BphgRC3q3yZIYkgt3ENILA7Kd6lWd5Z6mRv+dCsuXwMfkahbQ0lLoolH0CJaHWo9eaYc/igvlarCvLKWMShDqtDgL0uuA9UQ0BNPqQCm9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761754802; c=relaxed/simple;
	bh=V0PkU4tdvyQ6MLjJOZuNo60S/gLsCkysWuWMBt5FA9A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IQTRGKkO6xsHdVutbj8kYVFpoT4mTHdtLusZAtY10kL3/Al4Sj7mzgY1qOknkU2JmrIFjTcX4l5JwjKdj5tLuOhEi0Kh6zRhIS3YEWzpFr+J5ksVHACnT0Wwsc4FKxtUN5tAlh/Tsxg8izoD/XLt/4ceGRymMHo1o82Iul2IfGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Mr9hfBAc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761754800;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=O8BU0dkWuvfJEpsUw9sXbhg+WFpR4l8NjkgoHnCY3pc=;
	b=Mr9hfBAcFGFIeK98Oz2Cy0p35/l3nDsAcYVhLm0dBxJyNu8VPCLcNU26bYVq99PaiBgw0f
	0In59dDLKRMR5LdMSFG9Nowx9aMZjgO4X4Vxahme0Mf02aE5ohoNPL9jhJrfavCmB1abi3
	v8CTxWZorIZoq0n2TvmH48+jxlqh62w=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-464-Vhue43BIPg-ZKFHjNAdxtw-1; Wed, 29 Oct 2025 12:19:57 -0400
X-MC-Unique: Vhue43BIPg-ZKFHjNAdxtw-1
X-Mimecast-MFC-AGG-ID: Vhue43BIPg-ZKFHjNAdxtw_1761754796
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-4298b58bd3bso12130f8f.2
        for <stable@vger.kernel.org>; Wed, 29 Oct 2025 09:19:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761754796; x=1762359596;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O8BU0dkWuvfJEpsUw9sXbhg+WFpR4l8NjkgoHnCY3pc=;
        b=O20DZ/raPDKvRR//N/LBUDIb/HeS7zrDoyz8Wa4shmvJn/2Hf28EIYvH241XG0pJVL
         pnPFwUOLnlfL6weJLG8hT60aHpsSUDWiqn8PXtv5hXIWw7J0k7vD7WDHhWdsZh9qaALb
         wvFCi0wY2AB924GsAIAoPi+3PLkIDXkYPjMK9SoPX6yX/T/yEum2Vhq1JLK3h3aUP5nD
         2QWSqe+vSGo4GbafuLBWCIUYyGyjPz0cyD4ELKVYSCfM4h0K3g0WuSzqaluO9a6ZhG0f
         0OSQ04BJa1hpR8WsP0siQW5N7iip3DM9p2f1Vu+ezDkh53fwrN2KZZdnKsuE6PprY+VE
         yMRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTii+YuJiaSylRUzfIR/UxvndKNIwjQCDndLrYELeU1VCGJQUgS7X9+jVYfqTDAv3PjB5qrfo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7CVJG3JUA9dIZHLbArBoXbQDN7n/6+NxX101DAZefZxRULpeB
	ncUoDlxaFjXFmnCdrNs/Ja5m6RSESpZ4TC1gPrsuHdDvpdcfQPz20ZRO9L2pIjg0ZyI0T74aO3/
	S4LcpmtC7W9P5Ltf5d1WM4C+2EdzBD/ZfvgnWGa1HE+BO4ixihPJ4UHcsuw==
X-Gm-Gg: ASbGncs8+q9GsuoqWjPa0buZudXi1Z4NnOWXI1U7eP2vUnMRGy0VsLKJrZ1xqio5mc1
	rNCJcTxTunU4c/Wb7vL496FUqi1DDKrpUhjNNeBwNYq//caq9AOCYYgoJDCMBCOo8OtBC3op9cc
	ZNjaxEfYriX1sUuZTW44xwWTVE0liugcLX0CrR4eO+2dMg9udl4bzsw7oAoAFBbdndkuJRKtqYq
	gRXFCmknUlDpqtX5MT0XRBTuzix+4tPj4qIqr01aRDlYqHdiHQvk34sNnY+DYMIYb16MHD9MxIe
	+VJbTVEmGiZ30bejRQD+W0o/KCdjlVccE7amSPe1ZVkxM0EDBHymecVqoSjHwlA6fhH8g0FW9Su
	UNRkUIXwImmGL4e0Nt1/X0Q==
X-Received: by 2002:a05:600d:4348:b0:471:1716:11c4 with SMTP id 5b1f17b1804b1-4771fb455d6mr21112325e9.34.1761754796334;
        Wed, 29 Oct 2025 09:19:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHG1LOv2HbW/PxH7xRD2o0tTI9F7qkhwfuN6a3w5f9qITD5X7KXV+32AM9oHTvhZetC9jSCJw==
X-Received: by 2002:a05:600d:4348:b0:471:1716:11c4 with SMTP id 5b1f17b1804b1-4771fb455d6mr21112055e9.34.1761754795940;
        Wed, 29 Oct 2025 09:19:55 -0700 (PDT)
Received: from [10.32.64.156] (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4771e387aa9sm53806965e9.4.2025.10.29.09.19.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Oct 2025 09:19:55 -0700 (PDT)
Message-ID: <2bff49c4-6292-446b-9cd4-1563358fe3b4@redhat.com>
Date: Wed, 29 Oct 2025 17:19:54 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Bug: Performance regression in 1013af4f585f: mm/hugetlb: fix
 huge_pmd_unshare() vs GUP-fast race
To: Jann Horn <jannh@google.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: "Uschakow, Stanislav" <suschako@amazon.de>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>, "trix@redhat.com"
 <trix@redhat.com>, "ndesaulniers@google.com" <ndesaulniers@google.com>,
 "nathan@kernel.org" <nathan@kernel.org>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "muchun.song@linux.dev" <muchun.song@linux.dev>,
 "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
 "liam.howlett@oracle.com" <liam.howlett@oracle.com>,
 "osalvador@suse.de" <osalvador@suse.de>, "vbabka@suse.cz" <vbabka@suse.cz>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <4d3878531c76479d9f8ca9789dc6485d@amazon.de>
 <CAG48ez2yrEtEUnG15nbK+hern0gL9W-9hTy3fVY+rdz8QBkSNA@mail.gmail.com>
 <c7fc5bd8-a738-4ad4-9c79-57e88e080b93@redhat.com>
 <CAG48ez2dqOF9mM2bAQv1uDGBPWndwOswB0VAkKG7LGkrTXzmzQ@mail.gmail.com>
 <81d096fb-f2c2-4b26-ab1b-486001ee2cac@lucifer.local>
 <CAG48ez3paQTctuAO1bXWarzvRK33kyLjHbQ6zsQLTWya8Y1=dQ@mail.gmail.com>
 <a317657d-5c4a-4291-9b53-4435012bd590@lucifer.local>
 <CAG48ez0ubDysSygbKjUvjR2JU6_UmFJzzXtQfk0=zQeGMPwDEA@mail.gmail.com>
 <4ebbd082-86e3-4b86-bb01-6325f300fc9c@lucifer.local>
 <CAG48ez1JEerijaUxDRad6RkVm3TLm8bSuWGxQYs+fc_rsJDpAQ@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <CAG48ez1JEerijaUxDRad6RkVm3TLm8bSuWGxQYs+fc_rsJDpAQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>>>> Why is a tlb_remove_table_sync_one() needed in huge_pmd_unshare()?
>>>
>>> Because nothing else on that path is guaranteed to send any IPIs
>>> before the page table becomes reusable in another process.
>>
>> I feel that David's suggestion of just disallowing the use of shared page
>> tables like this (I mean really does it actually come up that much?) is the
>> right one then.
> 
> Yeah, I also like that suggestion.

I started hacking on this (only found a bit of time this week), and in 
essence, we'll be using the mmu_gather when unsharing to collect the 
pages and handle the TLB flushing etc.

(TLB flushing in that hugetlb area is a mess)

It almost looks like a cleanup.

Having that said, it will take a bit longer to finish it and, of course, 
I first have to test it then to see if it even works.

But it looks doable. :)

-- 
Cheers

David / dhildenb


