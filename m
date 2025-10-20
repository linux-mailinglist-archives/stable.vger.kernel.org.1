Return-Path: <stable+bounces-188206-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA715BF2AAF
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 19:18:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 461C918A4A4C
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 17:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3649A32C316;
	Mon, 20 Oct 2025 17:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TI0qHgfw"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7157F2882D7
	for <stable@vger.kernel.org>; Mon, 20 Oct 2025 17:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760980709; cv=none; b=SG8o6w2MswyuFvW8CwdD4W1vrc85eyWQspXStzvYF8oRt6raX1WPxnuV75nuTZcF5XIrK0osY0BEJE5NRZpE2472xtiXjF+A1PxMTs287/x95Iz1n46POWrRpCXG0QRzoVcV1FeA3y/wiDn+bYvBKL2cdulfaxkvfoAIw1xBK4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760980709; c=relaxed/simple;
	bh=j8JDhbIj0OYlEiufnyV3XQkDcqSIGNJpPm9HP7CsOjo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kU5C6s570BUCDvY9Mv319E2pEavpitdvUqcLk/pHEZMiDUGmFNxnhejXvRp9ew8qjC1PLUsK/zOj+GVjc87tZuf0TLgGxgrwDk6CceL8V6uDLH68fzx2uuPlwItt1h7PWZjhPEHleJPvxqQ/41kdfhT9oVcXAZzERYx+8SaqbXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TI0qHgfw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760980706;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=evREIIg1Q3eF3TMvX6tXdHcweEVqxuFmPv5AL/GwLz4=;
	b=TI0qHgfwf2xFGUZHuNBhcwAbW7DI7TMH6yCgl02WMLoCLt0StggEPQCdYcTjGDg/IuG0As
	KtwdmBVLrgAEKYQD6R5xPG04suWaaLCLTmqPblG7FOz7nIU6HEmzaQStMAcWEke8GOwR6U
	Ko4aMnc868aQaCfn+fGZse2aFGXU00s=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-303-tvrjvtQOMqiJGA8dWV1ipQ-1; Mon, 20 Oct 2025 13:18:22 -0400
X-MC-Unique: tvrjvtQOMqiJGA8dWV1ipQ-1
X-Mimecast-MFC-AGG-ID: tvrjvtQOMqiJGA8dWV1ipQ_1760980700
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3ee888281c3so8887224f8f.3
        for <stable@vger.kernel.org>; Mon, 20 Oct 2025 10:18:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760980700; x=1761585500;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=evREIIg1Q3eF3TMvX6tXdHcweEVqxuFmPv5AL/GwLz4=;
        b=MqzT02EQyguazUKFnXr0WfTrd0ZITumuHdnLuw/XWz8yAqD9iUuF5diC4EOdJE2Huz
         m3MMqy0ft9+yy08BgSMKxn9Vs60oILR9wKFewqxhC5H03gQYYyvaj9q8UYWaru7CSM6B
         pnYbv9CkiKw4Qe+zlErHB98wPUSdFiQkNn+6+SilbzVSH4RTL29Fjc+KtXVA8Lg7DqCH
         H9J2ogLta9P24OPBE26qlYKrnfBJ2+K/4bMz4GQZ1fMM3IDcTXZdNT9NhSKBxrXrQQUK
         1ipaegU9V2MZ+vYuHkMz8qLYeQFRlfZSV/LYfewDbQgazU3XhH9831YfvEU384ju7ls8
         cxxw==
X-Forwarded-Encrypted: i=1; AJvYcCXrWUYg2GTpDuSdb/7SRfUj4Y47NxBgSLrCHam0nVpyRgXYCFAkx3lQOsVzLOxjd+fExrkj2Ng=@vger.kernel.org
X-Gm-Message-State: AOJu0YyY1jh+ThSMfBc1GSna5yOr6bg0yZ6XOXrMJbZVOrrPczwd6kTD
	ZculWytGVNS6+EZFetakHUX25DMoRPGwIDcoBmETa4feSn8vS89LkdWIa2WXeDeZvICe4RaJELr
	RuRPXe2XBqNMwYRGCHMoHF9Q1vQBGrd17X6D0QkagXHOfTdwVxOLUSIEgsw==
X-Gm-Gg: ASbGncvvffSg+oWXgmH2slohEBd5M7COjUbM22fZnVWD2tweWXqVCJo9SHJcM3smNHw
	KGVgJoMoIBrDMKZOKCJUA32y5umjbj+mWh60uQb0XkTvwWt4/zl7KfPlruvS+hZFf8zcNL9znqJ
	LQWwfKOFamd+fORhupWs2lF3x7B9rALOlpMgDG/5CwouCQ01XYlEynbX8OO4wUj7QslBYCq3GHH
	nEVO1uX/YE5454AcNwwn+jOJew/jPfqaBPJO+lGKeLZv8Z8g2ZLk2CTDNzK8rLCfGxnLhRocpSB
	pVH/yVHdLKt1Eva4n78aH8jawW8HUBp3Zfq1le6MgsapYjKn9lHOMyfdrRb+JFZIYYRTCE0sopD
	YfmVGLXJcHVa/wMSgQxBf/9l7M3ieqWwN/dlwjguwkjSE+df5mYwcc1mKqMKHWsDPAfzfhi065S
	NToDXl+hWAG6YBckjPZiZ4grwCCfQ=
X-Received: by 2002:a05:6000:2287:b0:3ec:8c8:7b79 with SMTP id ffacd0b85a97d-42704ded0b1mr9923525f8f.61.1760980700418;
        Mon, 20 Oct 2025 10:18:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEsI213zwekDCyhaes1/CGMYO/HLtgUGK3QMQMJUNg5C2J1S7QZqYIh3FWpsycwOeUpv/3Dmg==
X-Received: by 2002:a05:6000:2287:b0:3ec:8c8:7b79 with SMTP id ffacd0b85a97d-42704ded0b1mr9923511f8f.61.1760980700018;
        Mon, 20 Oct 2025 10:18:20 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f0c:c200:fa4a:c4ff:1b32:21ce? (p200300d82f0cc200fa4ac4ff1b3221ce.dip0.t-ipconnect.de. [2003:d8:2f0c:c200:fa4a:c4ff:1b32:21ce])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427ea5b3d4csm15832349f8f.19.2025.10.20.10.18.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 10:18:19 -0700 (PDT)
Message-ID: <c81dcb7e-f91c-44e9-b880-0e0188a8ff5b@redhat.com>
Date: Mon, 20 Oct 2025 19:18:18 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Bug: Performance regression in 1013af4f585f: mm/hugetlb: fix
 huge_pmd_unshare() vs GUP-fast race
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Jann Horn <jannh@google.com>
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
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <81d096fb-f2c2-4b26-ab1b-486001ee2cac@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


>>>
>>> So in case the page table got reused in the meantime, we should just
>>> back off and be fine, right?
>>
>> The shared page table is mapped with a PUD entry, and we don't check
>> whether the PUD entry changed here.
> 
> Could we simply put a PUD check in there sensibly?

A PUD check would only work if we are guaranteed that the page table 
will not get freed in the meantime, otherwise we might be walking 
garbage, trying to interpret garbage as PMDs etc.

That would require RCU freeing of page tables, which we are not 
guaranteed to have IIRC.

The easiest approach is probably to simply never reuse shared page tables.

If there is consensus on that I can try to see if I can make it fly easily.

-- 
Cheers

David / dhildenb


