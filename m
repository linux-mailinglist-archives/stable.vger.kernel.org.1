Return-Path: <stable+bounces-111748-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE38CA236B4
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 22:31:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 324A11883EBD
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 21:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D8041B3939;
	Thu, 30 Jan 2025 21:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eRyWzwV/"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5AEE2AD20;
	Thu, 30 Jan 2025 21:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738272709; cv=none; b=uv2m5nHTtnc/daRNa8bx/3cxRM+V6ZfCMme4M1sk9/Jl5BeLVkbOJG67BfBt/fTqr7WS/FrH+66KKSnUNOzDbPzSiZE1jvrZK6VoMEKn011bidABgNxx3lyfUTgVLrM3SIc86kXmyyQkkCvVIk7Oic0/Yc3WhXkxNIjffI5si/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738272709; c=relaxed/simple;
	bh=V0zt8pNpSVxm3rzhk6TitG9qt6QVSI1feLDgYAggktk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Da/zsFBRluTmx6HtG4fr6CbkqqVEbSp+digakTXPu+gqUNLjE73Kwg78B+2HXZF+AXqEZ4RF6F86+df8n75t0QSnSYpsWhM+7GLIHWysm5+OMcfaZgPOJTkzjy8gaxGyX1Mg0o1Nn4Jj5NBv4KMM8JOf60nA+yf7zyeaMsDext4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eRyWzwV/; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-71e36b27b53so725367a34.1;
        Thu, 30 Jan 2025 13:31:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738272706; x=1738877506; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6ezGOPK7HRCXcFfaMlxExVACmV+hJUfqNwX+Seyi/4I=;
        b=eRyWzwV/0IMgkalf+YXFUj7Bg/BpTDUuDIfD7pdNJP4K0FEngqcnilKQPKcv8+zQrt
         KrjMRHai3nqH+V5S0bfN+oqQFLnsH0n6yKUmG528OrGu2U/9DquaPxhvoepq3oeyqnVc
         gs5smFNm0dn3Nf84g1T5YLzmHGVveugzn9vigA3tZF+jqN4K9I76zwHwYIlVqbhjXqCo
         rWEKN7n+lx4MG9rCKCp9e30GW2qIOE12n2YS9w5StZnSCVoFWRUrq2NH2sRUUclwiLOo
         ARbue8dv7LVWE/Pkfy5VUNyBLzWNt44PeQOfTEway2QQTP0EPlh0i4HBHiV9xF4CFvRG
         dW7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738272706; x=1738877506;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ezGOPK7HRCXcFfaMlxExVACmV+hJUfqNwX+Seyi/4I=;
        b=ObVvMvpGSpFwwScF24veFZ7e086gvsTOMtDu35u577Gr35Dok6rjPM2o5v1S6ba8KM
         sieYOuUpvVqHrw2F0rpUwZQCmWpOPig1mNv2VSRrTerxSW3zo0We2BJYxOB0Vnim64H0
         eLBY9yyhtL/8QOYr6ta2PtdCaGCxxoH9Xc0e8WRaD/a7s1AFf9Z8OsUF0939Yzu0CQJu
         +98QO79CJ/L6oLYNUiaZSCIHJRh9+CoCRZrmZLFQVGheNNKd+HvwhcFAR+STsM/cQRdb
         JXx6mU+vPKyvlMkTBir2Eahi9Iv/tZNBN6kBkAPkT668NRhE6ANqjt3XddI56yQMhu2Y
         0bUw==
X-Forwarded-Encrypted: i=1; AJvYcCUF+5xQSwR/sqtHmQb4eEGjR7R/2h0xQEOLn56vFLgWSlTdDfWP5Bu33naTFJpVGNsH0ajGb9k3@vger.kernel.org, AJvYcCVa8sbE1MWjCRH8GLY+bwRXk8LvwlWISozlZZaZIvMYcPKuG9aWIOLqJHKjaJAZmGID4uYHUMqXpkQ8tkM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1yI4k0NyyF4vJcU3ahb9G5uWPynVXXyrpf6eHZSLlBob5scML
	lpR2fv1dzcepI5FDYPA5qK8eSBXGff5WSsKhPJanF3JAcRVUosq4
X-Gm-Gg: ASbGncujLpCpHdQmOTezBZjQOkSIU/P72zKiMXMSvElxGS99u+iuqDjV5wxMy5YoZbZ
	v2+jA71EX7OC8eQhaz9NjESOtrONoW0A7ZE9wb9g8v/j5/Epg6DOtJAUZUsuF9q9WlDFLWkiOu0
	zAkDHUgbvHv40EKgEa5H+j243JfWw2PTVKf4lD4JDw9em/QxrQQC8s0R2gX2UD+jCPHRuOwB2c7
	h7t4enHOh1HCyESnKbKZvxUl2mr9U65bQhhhLeDv7uiyZG+fFad4ziQJ025wy4YYACt/pZgbGel
	qUMVSDtZON3saXFOTtxWSP6rnKXTY6q7cZzkwNvSKC0=
X-Google-Smtp-Source: AGHT+IFUr1xveW4w10nfBCGJ015z8r5ITT3QydOzpsub58Ot+H6hSWiyQH7L828e1Xn3dhTQX5jg1Q==
X-Received: by 2002:a05:6830:6089:b0:71d:4698:7b24 with SMTP id 46e09a7af769-7265679639cmr6534153a34.16.1738272705983;
        Thu, 30 Jan 2025 13:31:45 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-726618b9f72sm506458a34.50.2025.01.30.13.31.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jan 2025 13:31:45 -0800 (PST)
Message-ID: <ab292ebc-69c1-4f44-b8bd-f761147397da@gmail.com>
Date: Thu, 30 Jan 2025 13:31:42 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 00/49] 6.1.128-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250130140133.825446496@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
In-Reply-To: <20250130140133.825446496@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/30/25 06:01, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.128 release.
> There are 49 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 01 Feb 2025 14:01:16 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.128-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels, build tested on 
BMIPS_GENERIC:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

