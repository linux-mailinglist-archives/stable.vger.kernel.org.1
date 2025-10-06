Return-Path: <stable+bounces-183433-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 590E7BBE3BF
	for <lists+stable@lfdr.de>; Mon, 06 Oct 2025 15:54:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 12FE14E3427
	for <lists+stable@lfdr.de>; Mon,  6 Oct 2025 13:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FFE62D374A;
	Mon,  6 Oct 2025 13:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c95OTyAd"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4767D27F19F
	for <stable@vger.kernel.org>; Mon,  6 Oct 2025 13:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759758835; cv=none; b=vBw1os2Nbtv/X2Llq60/JAG+aDy0ssIsImkrAY8N9+biHR/Dpg1C9HAk/cNSTJam0zStfgrLpC4hVTr99lJq0XUaIiK9IwlbrnsjYjUmDkYIRid8M43pjgz3Bqwn0ag1kGB3Ns5HgE8xQhXCLfiPf9YnbQytegCltjGuGK6qpvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759758835; c=relaxed/simple;
	bh=NzuZ2WimXZhzKfuoxT422QsjdAD7EiCbAZGkcz1OTCM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L5S0EjiHAbXgfV0HgqMHZZwMfFllt1OYMGoVk9seRwj2wAkR2VWQxfxCf1cLYZNPBus5GXU2hf55RGM4DQI8vBMENCTguSrni3OKS0pRWJ9LdMMjC15CcL4AY/FtoH9CqV1e2nA05HHkn/5OBLoY4T40Lv/h6oiGMJHYYa7PXYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c95OTyAd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759758832;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=CGLl7ctOpTpoDpfWPZR3DaFESuMtpId6EeCDbxcp3bo=;
	b=c95OTyAdTyKLW9mGELgTCZizZ8Fwo8ORNBontJgvsNdQsLQUZbvhz4DUSzlQnKs/Se+zbm
	AP/+qu3fN6xfOgBbdUbSVQUds+/CYKrrIAp5+Og9A3m1e1xxqq5dOTH6RUplixE0DQf60p
	CZxPPQdtWa6/uY7OThbkqJPhZ8gjpnM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-191-itHrmwYnN6uCpkkssTfTwA-1; Mon, 06 Oct 2025 09:53:50 -0400
X-MC-Unique: itHrmwYnN6uCpkkssTfTwA-1
X-Mimecast-MFC-AGG-ID: itHrmwYnN6uCpkkssTfTwA_1759758830
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3f4fbdf144dso2680931f8f.2
        for <stable@vger.kernel.org>; Mon, 06 Oct 2025 06:53:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759758830; x=1760363630;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CGLl7ctOpTpoDpfWPZR3DaFESuMtpId6EeCDbxcp3bo=;
        b=qYvTGLKGQXmKAkzFspn60sWUrsNLoktjmHHVcrDbbQ8lGBbqq8vNYhd/sVf2ZJhpu0
         yDy9Jgmk00H7Mrcsc6A0GtnE4bLncba45drRSHjfZuDVR+Og1eSX/3XDrLcRlWY5Wcuk
         kGDfGpuaauTXxdkKeqDGMAe6+cITlA5IQx3OXecdYNpat70tOw3jg277vKuMkqAaTV/w
         M94I8/aBzCnDDOFKhHzr0qO7YtZ4ks5tUuf4eYiHQ6LOvY3ZPbNakz0Rx2QRamrreBmc
         yS/njPgdUuULOAtWWD21DhicjsTrp0SDHTBmLAR8k3AmcW9Qd2F/b1YOdSD2A8jpEDWC
         IzGg==
X-Forwarded-Encrypted: i=1; AJvYcCXxtUOMzhMLDp6ny0XZ6t1SoIr4b51GrB4oUVv2osYk7TidPvyUnqFWeqqzldpX/sc6EN0D1uI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXRYNnOo9cTmCPu3Zt7vDBrMcpXBeL9FcxwxpjxZiy/cHmMr8O
	qR8ufHaEiLBNjnQXAm/XM/ebzgHHsPMRn7LQyMQtWxD4NTWWCtYL++66PSZW+kHTFG9vwVVyd51
	0gdOYg+FekbmDpzVZonSVADSybnuuCK2f9/fQQ8ls1mR2D2rCB3ErSSPf4g==
X-Gm-Gg: ASbGncu2wOKezkz/95d43lYeXxpElPhzReQXD4AxROiYy/ZdFKYy/FF5Nqq5o7eVVMT
	rC1pHE1w3REpexkOuk3MXzpWbL3RxM922OHjT86I7J5FNkscNMVdXLC/EoX94HYcsHzCDE1AkCC
	WPjSv0qiqhgdqVYcBG2yhiykDK0aHboe/yjLuYwHdvb1qmCZ4vSlx/pycVWXDKT8HE9kg/KZEsO
	qGtkfi/l6EIfzP7/33/MSF75aFzl7ex343iSu6qdiaGoXAEyQ1HmS15NW8SW32jHwOAyjz3BmFb
	Jpm2ZzNQ3s0FHb75QMvUtvGassRI2VaSeJ+FMNIYxmufmr9l2Dp9fvs9bxxjvIELkrt8OSdOH7V
	AQ/Xi+pIS
X-Received: by 2002:a5d:5885:0:b0:3cd:edee:c7f1 with SMTP id ffacd0b85a97d-425671aa965mr9519903f8f.56.1759758829619;
        Mon, 06 Oct 2025 06:53:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG4z3VUwSp6NiPOhxjtLfmmF5LdjV37JJ4DT2V+xwJ/f0irliRMICXktxy6TvXFLIvLoD96wQ==
X-Received: by 2002:a5d:5885:0:b0:3cd:edee:c7f1 with SMTP id ffacd0b85a97d-425671aa965mr9519876f8f.56.1759758829047;
        Mon, 06 Oct 2025 06:53:49 -0700 (PDT)
Received: from [192.168.3.141] (tmo-083-110.customers.d1-online.com. [80.187.83.110])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8e980dsm22658378f8f.36.2025.10.06.06.53.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Oct 2025 06:53:48 -0700 (PDT)
Message-ID: <989c49fc-1f6f-4674-96e7-9f987ec490db@redhat.com>
Date: Mon, 6 Oct 2025 15:53:46 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] fsnotify: Pass correct offset to fsnotify_mmap_perm()
To: Ryan Roberts <ryan.roberts@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Amir Goldstein <amir73il@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20251003155238.2147410-1-ryan.roberts@arm.com>
 <edc832b4-5f4c-4f26-a306-954d65ec2e85@redhat.com>
 <66251c3e-4970-4cac-a1fc-46749d2a727a@arm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <66251c3e-4970-4cac-a1fc-46749d2a727a@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06.10.25 14:14, Ryan Roberts wrote:
> On 06/10/2025 12:36, David Hildenbrand wrote:
>> On 03.10.25 17:52, Ryan Roberts wrote:
>>> fsnotify_mmap_perm() requires a byte offset for the file about to be
>>> mmap'ed. But it is called from vm_mmap_pgoff(), which has a page offset.
>>> Previously the conversion was done incorrectly so let's fix it, being
>>> careful not to overflow on 32-bit platforms.
>>>
>>> Discovered during code review.
>>>
>>> Cc: <stable@vger.kernel.org>
>>> Fixes: 066e053fe208 ("fsnotify: add pre-content hooks on mmap()")
>>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>>> ---
>>> Applies against today's mm-unstable (aa05a436eca8).
>>>
>>
>> Curious: is there some easy way to write a reproducer? Did you look into that?
> 
> I didn't; this was just a drive-by discovery.
> 
> It looks like there are some fanotify tests in the filesystems selftests; I
> guess they could be extended to add a regression test?
> 
> But FWIW, I think the kernel is just passing the ofset/length info off to user
> space and isn't acting on it itself. So there is no kernel vulnerability here.

Right, I'm rather wondering if this could have been caught earlier and 
how we could have caught it earlier :)

-- 
Cheers

David / dhildenb


