Return-Path: <stable+bounces-62646-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE6E3940A27
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 09:45:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 749631C20FC2
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 07:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6F5718EFDB;
	Tue, 30 Jul 2024 07:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Da8z8qv2"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127DB16848B
	for <stable@vger.kernel.org>; Tue, 30 Jul 2024 07:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722325523; cv=none; b=PInGi2Bjh9CcGWbuIMIcnDLiNozLTQk+y2fYhoXANGatxzR+cRlCCQCo4e2IodjJm8BHIzFF4ZZA9sbYf9ahx/CO5fDl+FpbDVtpIHEMmgaCR4I7DmElAG40W9xV3/jNM9XHWMffqfZhvT3/XpDKpyCzhvfDniUK9bsau5CirLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722325523; c=relaxed/simple;
	bh=wznoV680KqMWS/MlCZxoXHKepY/0Ug6LCGof+aLUtFA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HRv0jP0y0st2dzk3Za7qthjs7MQ7SBpcZikfPGa/vWKhz4WnrYLec03GKBaEO15+XBAK17Xj3e0iagefOmdgXx7EfXFXn+gV/efiq5qV5Qyc1CGaVVTBsE1fLhSjl3uaHOj6YWi+eKeKFNSZnhyKHmWO3xa2PUOSGAw4kMs4DuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Da8z8qv2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722325521;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ck64k5Euo2onW/2Qr1N2B97paaQEw63eQ9tuTmojtHA=;
	b=Da8z8qv2BJ0xmyg0LluSDrA2f5vDEbjWgTy4oP2yhaCYdLvSnaIhXc9wCZ/Z6oJm7qfiNk
	C/0ZFzp5WdLpJpxBYGfTQ8wVt5MOy36gyezAF8DFR1uaupv6vMEDLYVha554vvxAGr+594
	ChF9Hs34eWbjsJMrKlCr1G/lQ77rr3U=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-544-Q-YDzlMNNyqz22eR_slCsw-1; Tue, 30 Jul 2024 03:45:19 -0400
X-MC-Unique: Q-YDzlMNNyqz22eR_slCsw-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-42817b91d91so28526485e9.3
        for <stable@vger.kernel.org>; Tue, 30 Jul 2024 00:45:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722325518; x=1722930318;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ck64k5Euo2onW/2Qr1N2B97paaQEw63eQ9tuTmojtHA=;
        b=KOqwlwB4NHHI2de+h7laACtJm/Kl5GpLFmGSS8Z98Y+OpXeMVYnjEc8sFKr3m0wxab
         SVIsFmn7Z3nG2U0lPkh/ubbw8USFAvglIx4AQz6+7v0zbuwuW2RXJNuuoI0AwACAKxAb
         tMgLN/H00v3Gmg0vsGol12ona2vuW0uIGd5Kp/wc/pHOKyyB8UuAYvdXrFVxbAiEJceF
         iSYCQypCwYNb9OltJSnqslftNJcf8/su0tJ8FZqvGUThJR86DDQ8CZxriU0P2TcEe3UA
         k8u69CXGzIl+roixF/QRVu2RidbUgjKCC6iHwtrYM5qVJGx2A19WuSI+lNwhC3MRzK+c
         z+lw==
X-Forwarded-Encrypted: i=1; AJvYcCXVYYEMII4l/3c9mK/8QuBJXM96ICzyHdg/2XvJb2AYm3PeouYMznXD9weBKy8INBoHqFC6lrz6lpyDHDWWkmtBYb4SkDRy
X-Gm-Message-State: AOJu0YxDXNwaXDuBEu/UPA0zglU8gRPEVcCFbtZvlfzUuFO5IMQpVl0G
	aQPx53lhhOv3KJ/qdk/ZRileGkak9KqNsjwCjgy3MIpW9pXNbpF9xUXIbW2Ly6m0NSm22AiKl5h
	KW9H/TZ+AYHWj96dW18qbOFs41kV9mGQjZeGuViNPQAAIFTijQm8tVg==
X-Received: by 2002:a05:600c:19c8:b0:426:6fd2:e14b with SMTP id 5b1f17b1804b1-42811d8c0d7mr85828275e9.11.1722325518023;
        Tue, 30 Jul 2024 00:45:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENux1tTvDpWwy183jVoXH1C4ya6HGPC6j4TO1QjnTCASeMbFQ6ofo9sRvfuz5lGq+AWJjSyQ==
X-Received: by 2002:a05:600c:19c8:b0:426:6fd2:e14b with SMTP id 5b1f17b1804b1-42811d8c0d7mr85827955e9.11.1722325517290;
        Tue, 30 Jul 2024 00:45:17 -0700 (PDT)
Received: from ?IPV6:2003:cb:c706:4e00:31ad:5274:e21c:b59? (p200300cbc7064e0031ad5274e21c0b59.dip0.t-ipconnect.de. [2003:cb:c706:4e00:31ad:5274:e21c:b59])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-428057b7218sm203076875e9.47.2024.07.30.00.45.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jul 2024 00:45:16 -0700 (PDT)
Message-ID: <9e018975-8a80-46a6-ab38-f3e2945c8878@redhat.com>
Date: Tue, 30 Jul 2024 09:45:15 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] mm/gup: Clear the LRU flag of a page before adding to
 LRU batch
To: Ge Yang <yangge1116@126.com>, akpm@linux-foundation.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 21cnbao@gmail.com, baolin.wang@linux.alibaba.com, liuzixing@hygon.cn
References: <1719038884-1903-1-git-send-email-yangge1116@126.com>
 <3a2ab0ea-3a07-45a0-ae0e-b9d48bf409bd@redhat.com>
 <79234eac-d7cc-424b-984d-b78861a5e862@126.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <79234eac-d7cc-424b-984d-b78861a5e862@126.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

>> Looking at this in more detail, I wonder if we can turn that to
>>
>> if (!folio_test_clear_lru(folio))
>>       return;
>> folio_get(folio);
>>
>> In all cases? The caller must hold a reference, so this should be fine.
>>
> 
> Seems the caller madvise_free_pte_range(...), calling
> folio_mark_lazyfree(...), doesn't hold a reference on folio.
> 

If that would be the case and the folio could get freed concurrently, 
the folio_get(folio) would be completely broken.

In madvise_free_pte_range() we hold the PTL, so the folio cannot get 
freed concurrently.

folio_get() is only allowed when we are sure the folio cannot get freed 
concurrently, because we know there is a reference that cannot go away.


-- 
Cheers,

David / dhildenb


