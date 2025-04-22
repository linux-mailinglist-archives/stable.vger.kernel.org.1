Return-Path: <stable+bounces-135040-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CACA7A95ED9
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 09:05:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0E6D3AA16E
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 07:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0A8522F392;
	Tue, 22 Apr 2025 07:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WEc3JZdz"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063F51F3FD0
	for <stable@vger.kernel.org>; Tue, 22 Apr 2025 07:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745305486; cv=none; b=XfIWMCE4xCe+0Aq/YlCS6GZwgZHA4plLsG4hVwgbxFNwNojlyDLK2sM6Mj1V7OoLU+2ZFE+pZT4LPHOu6qeO0vrk0Ydpyw9zkOqc1O8e0PmVg3n/ee4bLQ8ioHvjDc/WvXiSB24wGigLZHi+HtgK0oSc7nSasgrqQxrS9YGbKvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745305486; c=relaxed/simple;
	bh=1ntyTJA8TtikV97geuTawe+/2Tm8Y71h8JoCDCP0GtU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uBufYMt2aQm4re7M0BpWgoSh9/8o1qtwd6EXcI/D/mpZOzN4R/Z02dsoz6S9RYIG5vWYFUmFXx+R8D+0BocJd78pwHdUp/lmmAtsqqf0KyU8Njxtyv9Z61pGvSNMTba8wxg3gUXz2u1ttkFND4Y8DfZIE95nwcEqfpnQF5NZ1pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WEc3JZdz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745305483;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=RidtXoQ8utHmq+/JiDpAnUhpjg1f8nks6IGSAa7gnq4=;
	b=WEc3JZdzKGmf2QaVQCZPoCGX/MdcS5eyhOOVpSNIBw7RVb7NQUv3MYhlLJFJ7mbbSI0PFd
	aLcMNaff1vtzOl865Y/WuPStD+uzFqj2IVLnXk7I+t6H9riCc9h+S82h0ve2v2HjI/9Q8G
	64Zi+gQUfYjmGbPzXLmP46qEt65TSl0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-qBCRbI5HOzGLoajDnc-Uug-1; Tue, 22 Apr 2025 03:04:42 -0400
X-MC-Unique: qBCRbI5HOzGLoajDnc-Uug-1
X-Mimecast-MFC-AGG-ID: qBCRbI5HOzGLoajDnc-Uug_1745305481
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43efa869b19so28808875e9.2
        for <stable@vger.kernel.org>; Tue, 22 Apr 2025 00:04:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745305481; x=1745910281;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RidtXoQ8utHmq+/JiDpAnUhpjg1f8nks6IGSAa7gnq4=;
        b=WKFjKu0U+8cUD53oI8EnGfMG0Tnj+DaoULrJixho7H8NOg2gKizOUog1IMxK7mGmle
         6yn6QQtOPAZiGgr4Rh2FVJCjP9dogmaGb0yYegK9JxAqD3FoCZy/xjS8Q5t5wB2ZrFIC
         6EG7QKllOZ7QaQrsTURKE00VaDjV5Fgik2iJ43E43xtWcPh3YPIUx7nVqZJqrhpstmVn
         6GWlsIfZ2oVfHND7UApuGBQJ1G7BTDqUminRKz3k7CH3wP5iCzwuqRZDQWUnuKHZAMcG
         EoOgxiYQykWiowjfTiwYf2A9cC7DYxmVPVKpsHsfsiQl1h7UueF0H//tpKaF5Yjs61VS
         jl+g==
X-Forwarded-Encrypted: i=1; AJvYcCVxtr9exFl+o7K4b9Pihut04PjLBT0YaXdhCiG+g/e2pP5u3bndBh1UTMPI4OMfubL9qy86Cj8=@vger.kernel.org
X-Gm-Message-State: AOJu0YweOqT8aiLkHGR8RH5EvtaCXve0YagqjEJbaXP4g2zdRYijSzZp
	efg91YcAUngphG2KsyUxp5XSggbMq7ZGhP+1wnBuXBPpWgINzxnVzqQbeXQ1wpoTW0P9oIVkgY8
	mHf8J2A8v6RtWldhtYwDGtRSeI+bPl0PEICCsg0n9K+5NWWSuH2b7Dw==
X-Gm-Gg: ASbGncsBGZ26zgmUkXJZuEGtXl+X/StN8MIsP2QrzVzfb1X2Eax7uZZs+rJIAwJyyMx
	4yv7w30EuWXMVDsMpq1idd/ys1eRpms6XAxuojoXtbd267ZS0pJ9FBsYVo9mUs/4wibVPbjiRIb
	eZrgv5F6+rb5fe7rRmBlHYlOcRr6cU4ZVNUxdF6GkanaAnSOj5BgthKch92rpVbweJPIXgLcl/K
	1iqe0WnmND/YYsNtFmKEBDAjKoQmDHwEjwP4KDbdmgeeXrodswEAHPwNlkO8nx1smOflBqOPfsU
	brGza0JKJ+X/vMaaehyx+ayDq/onY90bht1lMVSCkvWslJPInDi4wIS3MUu/CjwtQLgMc+e1vKl
	ybfs3G8OmdZTThGO+dQ3pv31gKUNoD2xZ8qVn
X-Received: by 2002:a05:600c:54c2:b0:43c:fc0c:7f33 with SMTP id 5b1f17b1804b1-4406b92b57emr98154345e9.2.1745305481132;
        Tue, 22 Apr 2025 00:04:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHgWBX/11P+U8H33SSNxBptWM+XbQuz66XnLNKZuRxp5LsWM8rUt1vY1NxeviT6YKW0WfkWQg==
X-Received: by 2002:a05:600c:54c2:b0:43c:fc0c:7f33 with SMTP id 5b1f17b1804b1-4406b92b57emr98154055e9.2.1745305480787;
        Tue, 22 Apr 2025 00:04:40 -0700 (PDT)
Received: from ?IPV6:2003:cb:c731:8700:3969:7786:322:9641? (p200300cbc73187003969778603229641.dip0.t-ipconnect.de. [2003:cb:c731:8700:3969:7786:322:9641])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4408c8b0ea0sm5846715e9.2.2025.04.22.00.04.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Apr 2025 00:04:40 -0700 (PDT)
Message-ID: <7bf68ddd-7204-4a8c-b7df-03ecb6aa2ad2@redhat.com>
Date: Tue, 22 Apr 2025 09:04:38 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Please apply d2155fe54ddb to 5.10 and 5.4
To: Qingfang Deng <dqfext@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
 linux-mm@kvack.org, Zi Yan <ziy@nvidia.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Brendan Jackman <jackmanb@google.com>,
 Michal Hocko <mhocko@suse.com>, Suren Baghdasaryan <surenb@google.com>,
 Vlastimil Babka <vbabka@suse.cz>, Andrew Morton <akpm@linux-foundation.org>,
 Liu Xiang <liu.xiang@zlingsmart.com>
References: <CALW65jbBY3EyRD-5vXz6w87Q+trxaod-QVy2NhVxLNcQHVw0hg@mail.gmail.com>
 <2025042251-energize-preorder-31cd@gregkh>
 <CALW65jbNq76JJsa9sH2GhRzn=Fe=+bBicW8XWmcj-rzjJSjCQg@mail.gmail.com>
 <2025042237-express-coconut-592c@gregkh>
 <CALW65jbEq250E1T=DpGWnP+_1QnPmfQ=q92NK8vo8n+jdqbDLg@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CALW65jbEq250E1T=DpGWnP+_1QnPmfQ=q92NK8vo8n+jdqbDLg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 22.04.25 08:34, Qingfang Deng wrote:
> On Tue, Apr 22, 2025 at 2:27 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
>> On Tue, Apr 22, 2025 at 02:10:53PM +0800, Qingfang Deng wrote:
>>> On Tue, Apr 22, 2025 at 2:06 PM Greg Kroah-Hartman
>>> <gregkh@linuxfoundation.org> wrote:
>>>> All mm patches MUST get approval from the mm maintainers/developers
>>>> before we can apply them to stable kernels.
>>>>
>>>> Can you please do that here?
>>>
>>> Sure. Added to Cc list.
>>
>> They have no context here at all :(
> 
> Let me post it again:
> 
> Please consider applying d2155fe54ddb ("mm: compaction: remove
> duplicate !list_empty(&sublist) check") to 5.10 and 5.4, as it
> resolves a -Wdangling-pointer warning in recent GCC versions:
> 
> In function '__list_cut_position',
>      inlined from 'list_cut_position' at ./include/linux/list.h:400:3,
>      inlined from 'move_freelist_tail' at mm/compaction.c:1241:3:
> ./include/linux/list.h:370:21: warning: storing the address of local
> variable 'sublist' in '*&freepage_6(D)->D.15621.D.15566.lru.next'
> [-Wdangling-pointer=]

The commit looks harmless. But I don't see how it could fix any warning?

I mean, we replace two !list_empty() checks by a single one ... and the 
warning is about list_cut_position() ?

-- 
Cheers,

David / dhildenb


