Return-Path: <stable+bounces-167090-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B01FB21A0E
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 03:17:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0A892A763B
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 01:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C82B2BEC2F;
	Tue, 12 Aug 2025 01:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JC8PbDmK"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com [209.85.218.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C9D1F8676;
	Tue, 12 Aug 2025 01:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754961434; cv=none; b=IMqtWU4dwju18S873Ap6oYy21LkfoR/aRMfIxwzDjbdJz2si4YZwsEIdiLoSHDoNdNgdqAp8gxF7J1bV1xTxFWxNNiSjV6FdMX+PvSRqcLlNAgoYyecVQYy0t6Uem9p9IlwiFGWxCFtCA6iSiyII6ZMG0JOYIXddhLJrUqmZOFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754961434; c=relaxed/simple;
	bh=gBCHP64kXB1dQICiP2hErVP2nwgWWbnltU6gcp20yvg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C1DCOwc0c+keHpPiTPdYNC35nV4p6tL9CHK6MJ1oNDi+Oi8hJRv1jngch79d1f81kjHBZOXh5uN9gkydZwX4ReH8XRdHABcyAdLzAc55b3OMz2qPZsucAmxPB3BNEqm90FarXt6/AYfHLjujTsPdy68u80wFbSKOod2nmsaeDYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JC8PbDmK; arc=none smtp.client-ip=209.85.218.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f68.google.com with SMTP id a640c23a62f3a-af95ecfbd5bso824885766b.1;
        Mon, 11 Aug 2025 18:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754961431; x=1755566231; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Kx6NdeUOK2ZAavwzyn07ncyKXSjBQKSfiC64En8ptK0=;
        b=JC8PbDmKwI0uenPWzDZoW5kAVqpiBzm0szLzbaqr4Vt/5vs0CesgogDwp4i++3Nkps
         5YX+zdmRVwyAxtNyHXFM+7TomdbH6VLz5wDKnk9dBGOkgKsSYrfD51607L9P1S4kyhWA
         jg7Fj9uYHHrZ82qZ9DxTxI/qM5g0gwCLfaoRyMP0FAsBsw5jLPj7MP0M/LSPrqO078Nd
         oXuxySTZw6AvbEgjRLeeZyZ5TumyLd16KleQytOULK4DZPES+Y5PXXGAscPcDEuOEqyZ
         LWnUztG3c+rXWwYJefOKVqlWTtr0/n5bQIthNQHnVNm43xu5atO4nJoal1Qlqa+c0H0K
         xuQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754961431; x=1755566231;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kx6NdeUOK2ZAavwzyn07ncyKXSjBQKSfiC64En8ptK0=;
        b=iRDy/bEUKBH+ZIOpnawh+ySGtKR9TNSgR7RR8ytO1RlPSLZeivON/UQ6P3ZkPGhi6e
         nE+848nzDsY2pZZ01Ecs5atZUaxHuyDuwzHfsoUTbNRInGjKbqns1TBxvUj/owCuL17y
         vbjOjUzX0xS9RCye84dUJUtrFGUZh6+ecPNnJSMAVYE5i1AXLYg5SaGHaSuvB+1zP7rL
         QjaDRpINZBYqxsJGAtbgECTMnXFuAN71f9rpozQEyolaQay20vNg6N1n+mZNCMb4qBEY
         VB7Oy0xHHi9JCEGMgNGC+83qlMyhnbAJm1JtFQSiIqBWwX8XHH+byXSANrFCvXYeN4SE
         ia0A==
X-Forwarded-Encrypted: i=1; AJvYcCWKxkqYuXAPxsIRtqQzhJ5ieG2/szDO1Y57X2FMZLq06hQZx35QRxbeSV6lD09Wc5cclIYVKenNkdatYdM=@vger.kernel.org, AJvYcCXm0jx22+5uL19ecFonbdMyNzZS+I0T6bXgEJioDekY8S6uJb24UZfxLrcbgHkWZbw6OA2OUl/6@vger.kernel.org
X-Gm-Message-State: AOJu0YyUuNr3/6vN52KdZPNz6XfJCQa6Ou7HUKyOW/17O0YBeoDOmyAS
	PykQRk/R5P52RpfVYz00vjNOqKjPrrKGI5GixNS5vE8nKhihZQ0uEuuf
X-Gm-Gg: ASbGncsPPFtiU279AIljpcp8lJd5Gy3Hq8uQQ/sV8iv/bd/JO/2Iq/Onte1D3xCZY/4
	DbEpdbMYTrUneuLAZh3lfZCQ1DhcBBDb033sRcl4GUaV6qRZ2VXWkLjHxIkmVRbBjOIyJCoTjaA
	MXyclyTqsZtz/S6sg5cWGlPhy0oAuK3CTjp0RCic6laEeAjoHFRqCYXjLDs6hVUIZmAhpwioiiH
	aQCNJxF8x4e8xvG2xzdOFtEJoX0vRuwHRJ2msKSfkZeXSpL5EolY2FEv4KWQm3h3UySk1rmd48G
	jpiyMM8MWy2ndgoNzXJ9uXIWgzIT6p8+JwJEnUSstzGQvzirNeXmrtYbj9wKJTvr/+k91pCVa9t
	dqwTYKAaXtyxSyLzsu6jCDXmqUWNWbKqvIVrnom+E1L7KJwThwQzKTefw7gq4atOe1CJKWRu5xG
	rB/NS0vemtK38fCol+fxzM
X-Google-Smtp-Source: AGHT+IEEgh2ZE7NXrGwzl02oI8iVdXUPjVYyGKwYEOxmUW1rZ67qA/e691Ikur9GysNftuEPTgJSWw==
X-Received: by 2002:a17:907:7206:b0:ad8:9a86:cf52 with SMTP id a640c23a62f3a-afa1dfa336dmr126169266b.11.1754961430541;
        Mon, 11 Aug 2025 18:17:10 -0700 (PDT)
Received: from [26.26.26.1] (95.112.207.35.bc.googleusercontent.com. [35.207.112.95])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a0a3e80sm2125702966b.47.2025.08.11.18.17.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Aug 2025 18:17:10 -0700 (PDT)
Message-ID: <563bd363-d806-4ee5-bcfe-05725055598d@gmail.com>
Date: Tue, 12 Aug 2025 09:17:01 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] iommu/sva: Invalidate KVA range on kernel TLB
 flush
To: Dave Hansen <dave.hansen@intel.com>, Uladzislau Rezki <urezki@gmail.com>,
 Baolu Lu <baolu.lu@linux.intel.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Kevin Tian <kevin.tian@intel.com>, Jann Horn <jannh@google.com>,
 Vasant Hegde <vasant.hegde@amd.com>, Alistair Popple <apopple@nvidia.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Andy Lutomirski <luto@kernel.org>, Yi Lai <yi1.lai@intel.com>,
 iommu@lists.linux.dev, security@kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20250806052505.3113108-1-baolu.lu@linux.intel.com>
 <d646d434-f680-47a3-b6b9-26f4538c1209@intel.com>
 <20250806155223.GV184255@nvidia.com>
 <d02cb97a-7cea-4ad3-82b3-89754c5278ad@intel.com>
 <20250806160904.GX184255@nvidia.com>
 <62d21545-9e75-41e3-89a3-f21dda15bf16@intel.com>
 <4a8df0e8-bd5a-44e4-acce-46ba75594846@linux.intel.com>
 <4ce79c80-1fc8-4684-920a-c8d82c4c3dc8@intel.com>
 <b6defa2a-164e-4c2f-ac55-fef5b4a9ba0f@linux.intel.com>
 <2611981e-3678-4619-b2ab-d9daace5a68a@gmail.com> <aJm0znaAqBRWqOCT@pc636>
 <83c47939-7366-4b97-9368-02d432ddc24a@intel.com>
Content-Language: en-US
From: Ethan Zhao <etzhao1900@gmail.com>
In-Reply-To: <83c47939-7366-4b97-9368-02d432ddc24a@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 8/11/2025 9:55 PM, Dave Hansen wrote:
> On 8/11/25 02:15, Uladzislau Rezki wrote:
>>> kernel_pte_work.list is global shared var, it would make the producer
>>> pte_free_kernel() and the consumer kernel_pte_work_func() to operate in
>>> serialized timing. In a large system, I don't think you design this
>>> deliberately 🙂
>>>
>> Sorry for jumping.
>>
>> Agree, unless it is never considered as a hot path or something that can
>> be really contented. It looks like you can use just a per-cpu llist to drain
>> thinks.
> 
> Remember, the code that has to run just before all this sent an IPI to
> every single CPU on the system to have them do a (on x86 at least)
> pretty expensive TLB flush.
> 
It can be easily identified as a bottleneck by multi-CPU stress testing 
programs involving frequent process creation and destruction, similar to 
the operation of a heavily loaded multi-process Apache web server. 
Hot/cold path ?

> If this is a hot path, we have bigger problems on our hands: the full
> TLB flush on every CPU.
Perhaps not "WE", IPI driven TLB flush seems not the shared mechanism of
all CPUs, at least not for ARM as far as I know.

> 
> So, sure, there are a million ways to make this deferred freeing more
> scalable. But the code that's here is dirt simple and self contained. If
> someone has some ideas for something that's simpler and more scalable,
> then I'm totally open to it.
> 
> But this is _not_ the place to add complexity to get scalability.
At least, please dont add bottleneck, how complex to do that ?

Thanks,
Ethan



