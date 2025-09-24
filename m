Return-Path: <stable+bounces-181593-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7706EB990CD
	for <lists+stable@lfdr.de>; Wed, 24 Sep 2025 11:13:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C0A72E64EB
	for <lists+stable@lfdr.de>; Wed, 24 Sep 2025 09:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CE7F2D5940;
	Wed, 24 Sep 2025 09:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xs2Tag4Q"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976CA287258
	for <stable@vger.kernel.org>; Wed, 24 Sep 2025 09:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758705208; cv=none; b=tGkoOtt9A+Jfc2CPAmdLARemXVGorReBXgYE9upEbfnyO/V97PHIBtISpdfyZ6pHnB4/S53IGwFV0bOL/JpMqZfFS1G5ga31E3HuJP6RaqKYEMA3IK+kI7v6ZWCnXSMKOajrpZCMxr2I2iToJau9C7EDDNtoy2A4FmBHiRj5VaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758705208; c=relaxed/simple;
	bh=kH2XbkyhlbWqNrfqh4W2hJzZxCQXO36+tE3p3x+sTHk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eAzYyxuLpTl2Q7EBcD5PEtfanRU6SFA+bqvKiwj/P9y9IXImvK1Pil60+z7V8PTQ6XBwHcQ3/A4WYyRP5FSmLgJlEhG03iQDnQSW7CbrPrcC17vaJTuKF2hLRaN9ilFM0vyOStU/floBPo9DGya60vd3vY6NGvy/XuyEpV5wihU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xs2Tag4Q; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758705205;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=zX11camkE4Hg4H4xV/n8C7NJAv/AAjeZxxkMV/ADChc=;
	b=Xs2Tag4QD8TmRy931UMYvcPJRGbk8sGSu7ZtPZBVi0UCNrhUCbWC0c33OaNrjKoPMcFOvo
	l6c+o1ipqTJgLWJNoNfE1n1WnAPZNBD+1PwdbKXN5djVxkoBFYhDR0h3b6UBfOY3Xtwip7
	2XyCN9gWcJqBQUnLMGrxDb4nKGam9zE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-sZ1N_srMP56FngMmbuBPsQ-1; Wed, 24 Sep 2025 05:13:23 -0400
X-MC-Unique: sZ1N_srMP56FngMmbuBPsQ-1
X-Mimecast-MFC-AGG-ID: sZ1N_srMP56FngMmbuBPsQ_1758705203
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3f030846a41so2953224f8f.2
        for <stable@vger.kernel.org>; Wed, 24 Sep 2025 02:13:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758705202; x=1759310002;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zX11camkE4Hg4H4xV/n8C7NJAv/AAjeZxxkMV/ADChc=;
        b=qLruwyHw/0ptCHnX8SAaEWSf40d3aeXi5k9z+XU4GpsjcbLwpl2yjoojgR4GeZxt7P
         rDVC/Lcn5SZZWd/80MjokncE4LyB1WK8nbrAAlxACG4h9OWh86gGFpEXpwISxCcLLbdO
         4MdIdTmsWLOEy9o1tfhAbFcfz4Tz5Tc98XMy6EAUlcgfAWNL92UYUb47dAiC9J6O3VV0
         OzWmNeTUIngTNVGjmnJ6jGJQ2sexxKVi1j2RVSdFZgt76McxmhyhFEYsVmsIkBYbUbyr
         a3MnUN8Mc2d1lCm1nvRairRsXhbZCB4l9vIZrSu7dSdkgj/+bdDue20uiVpD5fxz9Btx
         aHGg==
X-Forwarded-Encrypted: i=1; AJvYcCWzT97k7b5mzNTCUAIVpScF0ry6jhDWpOcshnhCLBJscmoW4Mg1vML1LAAFGhFFxM5Gd6cedY8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz52R81lG/VMtdnyWBwmdMpF0gcMecsJDivOi5LF9ZnSUYDl/Xi
	fUHlyZbYSvFnMx8M7MvcIcaWLxXxEcahmAWbis8D3U3tCXdsOlafWNFiEu2q/w3bPv0d4Wi8N0C
	idV6FefYAdxxtOHuGB7JWOqRfbinfejJ9qFw+hnM4uO04lh+BIUNuDh8V0A==
X-Gm-Gg: ASbGncuanM7KmiuzzSt/W+3MKra1dF8oYFlbPEo8HENIY/MUT3e9yox5uCBCEybt4YK
	n7R03lmcUS/rJ5Jcu9fieo56/9MEBsBffkC3ssKWHWm8YimEXZjEPJzyybQlNZV6SsZgR0+mKYd
	DYypzSLo94Sk7ulfcNpQinOBARj6OteDJEnnR0RFfIF6N5jWrtswBfcz1V3MpBEBqyGJynbF7AP
	ZSxVsMO7aX5XvT5XLivvfbtQABILP5lrgCYqt6q+qX9mqxLqxEykzodCnC+bZntlvCU6ueJwt8e
	1Z6TnBikHue+Vj1mw6+vEWH0Afi4zgsufGZOC4uVrFpeDORfk2evBKNahgjIQfLz3YkfqZ947oc
	KTruYKdQ5dIfTS0gbQX70jG3K1xJ5zAZcrINMqIA9/Y6kg0YOjyLcZAVgTVZtbcJFLQ==
X-Received: by 2002:a5d:5f83:0:b0:405:3028:1bf0 with SMTP id ffacd0b85a97d-405c3e2784emr5360066f8f.10.1758705202406;
        Wed, 24 Sep 2025 02:13:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBZFEPN12p6SWA1LtLwcoBT+0w/wHU0RQBUXQwTIxfVpyQEni4vEmdES/G/ydEaBnhiqp96A==
X-Received: by 2002:a5d:5f83:0:b0:405:3028:1bf0 with SMTP id ffacd0b85a97d-405c3e2784emr5360028f8f.10.1758705201838;
        Wed, 24 Sep 2025 02:13:21 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f14:2400:afc:9797:137c:a25b? (p200300d82f1424000afc9797137ca25b.dip0.t-ipconnect.de. [2003:d8:2f14:2400:afc:9797:137c:a25b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee15bfab67sm23593007f8f.43.2025.09.24.02.13.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Sep 2025 02:13:21 -0700 (PDT)
Message-ID: <17dabd83-0849-44c9-b4a2-196af60d9676@redhat.com>
Date: Wed, 24 Sep 2025 11:13:18 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] mm/thp: fix MTE tag mismatch when replacing
 zero-filled subpages
To: Catalin Marinas <catalin.marinas@arm.com>,
 Lance Yang <lance.yang@linux.dev>
Cc: akpm@linux-foundation.org, lorenzo.stoakes@oracle.com,
 usamaarif642@gmail.com, yuzhao@google.com, ziy@nvidia.com,
 baolin.wang@linux.alibaba.com, baohua@kernel.org, voidice@gmail.com,
 Liam.Howlett@oracle.com, cerasuolodomenico@gmail.com, hannes@cmpxchg.org,
 kaleshsingh@google.com, npache@redhat.com, riel@surriel.com,
 roman.gushchin@linux.dev, rppt@kernel.org, ryan.roberts@arm.com,
 dev.jain@arm.com, ryncsn@gmail.com, shakeel.butt@linux.dev,
 surenb@google.com, hughd@google.com, willy@infradead.org,
 matthew.brost@intel.com, joshua.hahnjy@gmail.com, rakie.kim@sk.com,
 byungchul@sk.com, gourry@gourry.net, ying.huang@linux.alibaba.com,
 apopple@nvidia.com, qun-wei.lin@mediatek.com, Andrew.Yang@mediatek.com,
 casper.li@mediatek.com, chinwen.chang@mediatek.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linux-mm@kvack.org, ioworker0@gmail.com,
 stable@vger.kernel.org
References: <20250922021458.68123-1-lance.yang@linux.dev>
 <aNGGUXLCn_bWlne5@arm.com> <a3412715-6d9d-4809-9588-ba08da450d16@redhat.com>
 <aNKJ5glToE4hMhWA@arm.com> <aNLHexcNI53HQ46A@arm.com>
 <f2fe9c01-2a8d-4de9-abd5-dbb86d15a37b@linux.dev> <aNOwuKmbAaMaEMb7@arm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <aNOwuKmbAaMaEMb7@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24.09.25 10:50, Catalin Marinas wrote:
> On Wed, Sep 24, 2025 at 10:49:27AM +0800, Lance Yang wrote:
>> On 2025/9/24 00:14, Catalin Marinas wrote:
>>> So alternative patch that also fixes the deferred struct page init (on
>>> the assumptions that the zero page is always mapped as pte_special():
>>
>> I can confirm that this alternative patch also works correctly; my tests
>> for MTE all pass ;)
> 
> Thanks Lance for testing. I'll post one of the variants today.
> 
>> This looks like a better fix since it solves the boot hang issue too.
> 
> In principle, yes, until I tracked down why I changed it in the first
> place - 68d54ceeec0e ("arm64: mte: Allow PTRACE_PEEKMTETAGS access to
> the zero page"). ptrace() can read tags from PROT_MTE mappings and we
> want to allow reading zeroes as well if the page points to the zero
> page. Not flagging the page as PG_mte_tagged caused issues.
> 
> I can change the logic in the ptrace() code, I just need to figure out
> what happens to the huge zero page. Ideally we should treat both in the
> same way but, AFAICT, we don't use pmd_mkspecial() on the huge zero
> page, so it gets flagged with PG_mte_tagged.

I changed that recently :) The huge zero folio will now always have 
pmd_special() set.

-- 
Cheers

David / dhildenb


