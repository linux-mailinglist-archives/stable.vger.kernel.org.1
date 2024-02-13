Return-Path: <stable+bounces-20102-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 268BB8539FB
	for <lists+stable@lfdr.de>; Tue, 13 Feb 2024 19:36:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AE5A1F24B99
	for <lists+stable@lfdr.de>; Tue, 13 Feb 2024 18:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F7D1DDA6;
	Tue, 13 Feb 2024 18:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h9U6Ex9h"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3CA9101EC
	for <stable@vger.kernel.org>; Tue, 13 Feb 2024 18:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707849390; cv=none; b=K1iJg2pr9E0lKGuMOef9Y5QOp+ROfPQSk27k0sQddEWFfIn3TGVWHk+INmMycKVCzmFI5rQmXFNJAJl91Rf8yZWBBcQdPE8+ZJLXlXyWTmjYMxJGQDrE3xdP43BxomgMlca2m6dHIOsk0YQVsQ8zz/pMBnAmkYhpitK/aKj4XgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707849390; c=relaxed/simple;
	bh=uQJcl0ExSM6PiRuhlkLSoSWG+0S11Yv323J0RsbyeaI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mvnyu5ptsI3hPk07dvhHI52CKHSsAM8TdIXFomd99nitJIYgdzr8yg6Ix+UePncNowRL+Bn/1h+Ii9oGgRHdNDCVz64AuCaxAw8pShlj/FAXvgauwyWDjq1AhWVTr0MjaY0tnWoQvvy/ru1a1Up+66yz5rCOFcQ928Sy+Q8hy2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h9U6Ex9h; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707849387;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=0Qdl9JhbrRXAvKBnD0u3fPQiEvBPygg/osrVpMLZ3jI=;
	b=h9U6Ex9h86bfRVX1W6br45jhuUucm5RFiEIUTDKli5B6+FppbCplMRN0UA68ZYTukHw/1I
	h7OQDFl/OzBUOTP3WnAem3c20DXPt/FoIhTl3Q/JnYAOKIMvRFuTxbvSSTjFDAWquQN73z
	NXitmtH5o2HkETsQjiKzCSjplIu8eek=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-473-0d38pRXMP02o2BwFrRDRsA-1; Tue, 13 Feb 2024 13:36:26 -0500
X-MC-Unique: 0d38pRXMP02o2BwFrRDRsA-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-40d62d3ae0cso28167315e9.2
        for <stable@vger.kernel.org>; Tue, 13 Feb 2024 10:36:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707849385; x=1708454185;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Qdl9JhbrRXAvKBnD0u3fPQiEvBPygg/osrVpMLZ3jI=;
        b=qg8GyZSV7PV3cBTpaj8/esP+6H+6aJSgPi68NHUMoRKJOqweJrvGBQAztxvnGKz3SW
         qvXR5JyNWWhjFy88KxB/sy8QHbc/1d4Qfd+93BkfsXzcv6qqtNhuDoOojAPgbQAJz37k
         CSLWY6g1f0KYXrK7uwYTSHaqiuyG2uY/pbKUWIC7UEgBa5NqmmyJGJ2NA4vRMTnSjKgW
         ZqktWu2cKl5Ar4VrYmSqvrKNXScymUOwtSHE/IEuNfL1E33Wm+aIiSlmcW9Ser1+YcYn
         HSOd9LsouRBQk3IjP4N0twOnU79/WmNGe7v5OcN3rz2d3ASIA8ew6ZElKsTwGpCJ2k6e
         grOQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHEXHwcROGjA3V2ZcUGpl/vw5k4DRs/Iog0FLsAG61ZuJeg5wvs+DKqpeIzmKcVQULYawTy04BoW6sweY1izfmiGp0w+3z
X-Gm-Message-State: AOJu0YxxOBucKsIaMquG9jcQ2TNnR6FL3rhq7eNIXNpQ8rbrhOS3o3aR
	n6q1NJFFFcsOIoQe2fpwGyX+cgxQFPYHfPK7vw7AVi5RiYhM8G3o4moN0Bi1LP0/P4LFDd0XpSt
	n/KMxcLJiX0pOinQXXlFhSZxFdqevZfXhWmIUVxkSGw2BV72rINPk2Q==
X-Received: by 2002:a05:600c:314c:b0:411:da6d:a0d1 with SMTP id h12-20020a05600c314c00b00411da6da0d1mr295343wmo.35.1707849384938;
        Tue, 13 Feb 2024 10:36:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF7iv7tTq4Fw/+8qzCpEOG2f5y0/1SyxJ7igdMZAiXJ4FdPj45p6Im1jYsdmfdbYEAQN2dtYw==
X-Received: by 2002:a05:600c:314c:b0:411:da6d:a0d1 with SMTP id h12-20020a05600c314c00b00411da6da0d1mr295332wmo.35.1707849384589;
        Tue, 13 Feb 2024 10:36:24 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWOvHSsPwPP+cp8E6lXP/4S1vOowrqgdeyfrsuz9/yQ0Z0Pt6wy5xuB0De7j58B7QImUvC1D18sRDBONEOGbR2/UWHIjEYSdgrgvefOmId/Nj5skknwly0eK86xTLWpycdR/LRLdZWKCXwfLxgsF2DSGu8Q9Gfkwbib67Q/ahdUpspdX4XKDefcIEJSIlu6Gqd9xcVi9K6eEBpHAf0jOec6DiPBh4nMbbNocltdXI3T/skWOThOkSq5tu/LrY4slVF0ueSx+E4UWMpwrHK9oxChQoDv7V0pOpcSRC794iud0mVmorGnYfa9
Received: from ?IPV6:2003:d8:2f3c:3f00:7177:eb0c:d3d2:4b0e? (p200300d82f3c3f007177eb0cd3d24b0e.dip0.t-ipconnect.de. [2003:d8:2f3c:3f00:7177:eb0c:d3d2:4b0e])
        by smtp.gmail.com with ESMTPSA id az4-20020a05600c600400b00411ce6def3fsm1449301wmb.38.2024.02.13.10.36.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Feb 2024 10:36:24 -0800 (PST)
Message-ID: <845ca78f-913b-4a92-8b40-ff772a7ad333@redhat.com>
Date: Tue, 13 Feb 2024 19:36:23 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/huge_memory: fix swap entry values of tail pages of
 THP
Content-Language: en-US
To: Charan Teja Kalla <quic_charante@quicinc.com>,
 gregkh@linuxfoundation.org, akpm@linux-foundation.org, willy@infradead.org,
 vbabka@suse.cz, dhowells@redhat.com, surenb@google.com
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 # see patch description <stable@vger.kernel.org>
References: <1707814102-22682-1-git-send-email-quic_charante@quicinc.com>
 <a683e199-ce8a-4534-a21e-65f2528415a6@redhat.com>
 <8620c1a0-e091-46e9-418a-db66e621b9c4@quicinc.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <8620c1a0-e091-46e9-418a-db66e621b9c4@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>>> Closes:
>>> https://lore.kernel.org/linux-mm/69cb784f-578d-ded1-cd9f-c6db04696336@quicinc.com/
>>> Fixes: 3417013e0d18 ("mm/migrate: Add folio_migrate_mapping()")
>>> Cc: <stable@vger.kernel.org> # see patch description, applicable to <=6.1
>>> Signed-off-by: Charan Teja Kalla <quic_charante@quicinc.com>
>>
>> 3417013e0d18 went into 5.16.
>>
>> cfeed8ffe55b3 went into 6.6.
>>
>> So only 6.1 is affected.
>>
> 
> I tried to dig why the older kernels don't have this issue. The issue
> persists on the older kernels too, AFAICS. See,
> migrate_page_move_mapping().
> 
> So, The Fixes: tag too is unique for 6.1 kernel. And older LTS kernel
> requires different tag it seems..

We really have to identify which commit it actually broke, and whether 
it was repeatedly fixed and broken again.

Because backporting this to 6.1 might be feasible. Backporting to much 
older kernels possibly not.

> 
>>
>> Isn't there a way to bite the bullet and backport that series to 6.1
>> instead?
> 
> My worry is that, because of merge conflicts, not sure If It can end up
> in inducing some other issues.

I can have a look this/next week. I don't recall if there was any 
particular dependency.

> 
> Although we didn't test THP on older kernels, from the code walk, it
> seems issue persists to me on older to 6.1 kernel, unless I am missing
> something here. So back porting of this series to all those LTS kernels,
> may not be a straight forward?
> 
> So, I am really not sure of what is the way forward here...

Again, if we want to fix this properly, we should first identify the 
commit that actually broke it.

If it predates folios, we'd need different fixes for different stable 
kernels most likely.

The big question are:

1) Is it broken in 5.15? Did you actually try to reproduce or is this
    just a guess?

2) How did you come up with 417013e0d18 ("mm/migrate: Add
    folio_migrate_mapping()")

-- 
Cheers,

David / dhildenb


