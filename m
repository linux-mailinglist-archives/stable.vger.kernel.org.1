Return-Path: <stable+bounces-136773-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 554B1A9DEAD
	for <lists+stable@lfdr.de>; Sun, 27 Apr 2025 04:34:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8BBC7A5809
	for <lists+stable@lfdr.de>; Sun, 27 Apr 2025 02:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B42931EE021;
	Sun, 27 Apr 2025 02:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M9643nf5"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7954409;
	Sun, 27 Apr 2025 02:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745721236; cv=none; b=FAvVm4WFs/kLCGsF25y954isXS2G5v7fKnAMpApVdowF1RKA8ARSH6mcwXFNUsvN85jr35rul0Q7Jb2aiKkwJiTXMSMGof3Ae/uhXXDhXobcdAMAToNJXE29nx/ZdUfG/pEBt+KENOFXI4dHN3Dyn1kX9om15Va2byfMiqeMyV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745721236; c=relaxed/simple;
	bh=ZxtpZAodsYMmprqA/xdBUuYIfmgms6hIglqzoj1gS8k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JGluXnhQDJgFlWqYGK5OvqkYYnUVIbBGD8PbsUYX2TfDrV3hxDjaGmMEPJmFyAQ++0O/ouvMK7EeHNlFrF5kAGtCVF++KuvgDYsLRsF1phBleS6MukNB+9mFekM1bTqHVxgNUm77B//M++y4SM0bRhb6conqALTLSoXt1fWQsNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M9643nf5; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7390d21bb1cso3531760b3a.2;
        Sat, 26 Apr 2025 19:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745721234; x=1746326034; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=yuyJuAwZDZC9Or0+LRKFgJLqmkboqSdppgkNjKAxl6Q=;
        b=M9643nf5Nc17HYLvUS4F02YKg4SnlR+neyV+z+nLTTi+HdojMZloDILv17WkaFP/t/
         gaogiOG4iQQPbzKn5Fnpr51sXjaZ1zU/9Xd4YKoa4dSlMbpW7JbjVMKcXyybVRNyW08p
         BvLA6CyIf1k8OBhjn1dOBgDFdqCvJo3+BW1qk4WvUBIjsmSrfBmOcWj5xS4Y6R801Fw+
         53RYPNtAbup+nQ2nlU3Kx8MYH/Ck3DcfoFcG+J9qIQGTQz1oD8fJmo4RQfs0LGLa7vXA
         W90CUurCGdhs23kBJgJXOMzOPJPHlHGemTam7CQ3x/m2Lf6mmNinojYd3OtMqK32QnmY
         nSBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745721234; x=1746326034;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yuyJuAwZDZC9Or0+LRKFgJLqmkboqSdppgkNjKAxl6Q=;
        b=AUSmzszJ/u5Hs86YwyMCzp0r3p1oZ9KLrMkca190uYHP1kTDGh/DCRR0gJP6ej7TSb
         /+rU6WlXP5YT1/wlnuMjK6Z3Jo9Vx+xYFSdFUTDGq+pcdMxfHjCNJzkLnjeYE2GKWjuh
         9a/uHIPU4og/NpcWBGNgma+j+B1wC0OOpfmoxpljvbnnSdsZJkP71dkOZlWPjjE7JaEH
         MA1DRPkWNrMi9xW2QsMVxWPdYXagxMMOjYN+9K/49RWNE5XX7gM1Ena+geeYe4uOlLpn
         CI0M+tlEpYTazzFNkD4UR0GS6qu9X11bmtyeIVZjysZRqyaIVr7EdJKVTGO4+/8UeTAE
         ExAw==
X-Forwarded-Encrypted: i=1; AJvYcCUL1gpdUt/20211IwnGkN+CeNBuEXR51VQii5usTE6Fu4Rvz1ljNDjiC5k/ImCbmvULFk3oAS2uk6Iqknk=@vger.kernel.org, AJvYcCWXkdD0eKa++p13mFzUuxpqzHpT446ovKtnrodonOb420FSS6JPFyMZJqfIN8Du3fdCmJWj1VU0@vger.kernel.org
X-Gm-Message-State: AOJu0YzhyMsvYcWLg5IstmDq1nU/VQFsrEIJmF2ibz3nDvVG+VWKsdYV
	0x9al+fWzNay8KywEloo51Jn25H/c1+buuh9TJOx/zzIyMqzvcUH
X-Gm-Gg: ASbGncsE/h/cEJcw+ZmlQbItjVdB7o8o+S5TVC1EPx7Dbf3eB3uMs5z5/hakIIaq/fi
	yCqqlK7vjfDDBSMWpjTwOxdRUPzcx3O8PflFwJUKQ9EiWa+WPZNLd+xSOxlepDEiyJ42irQVjhV
	NDO7fyjx2Q3ovHRoFFeq7vQZeo001GS/hgadInlmsoIpwvfANuzzx6EsjXhzSKNW/772BM/Xasm
	sgaVWXVevnaqvh0Q8kDZ3I+97nRwT5Lv0VgMWtx+cML4SkUdeQLnjrP0NlNPD5gxhKly3FOd4BN
	zuK+DYDxWJOxorhXM7LXb2iToUCRKjNrvRtm+3s3+vbv87u4PCJ1RIsO3mOg/6Tv13RIv5lyZwg
	hA2J3KLz+HYW2j/sOj9HJRocD
X-Google-Smtp-Source: AGHT+IF4rpnQ+T6vzivQmEmUzDO2lMYwsNeAH3uLKba/nLKUJoONOmmFovVGVgFTgRL1jHHQTdrxxg==
X-Received: by 2002:a05:6a21:900a:b0:1f3:3ca3:8216 with SMTP id adf61e73a8af0-2045b6b2166mr9700153637.5.1745721234042;
        Sat, 26 Apr 2025 19:33:54 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b15fa80fbb5sm4971990a12.55.2025.04.26.19.33.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Apr 2025 19:33:53 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <de718b6b-cbe1-4ccd-be70-794b60e91e0b@roeck-us.net>
Date: Sat, 26 Apr 2025 19:33:51 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/223] 6.12.25-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org, shuah@kernel.org,
 patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
 jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
 srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org
References: <20250423142617.120834124@linuxfoundation.org>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20250423142617.120834124@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Greg,

On 4/23/25 07:41, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.25 release.
> There are 223 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 25 Apr 2025 14:25:27 +0000.
> Anything received after that time might be too late.
> 
...
> Nathan Chancellor <nathan@kernel.org>
>      kbuild: Add '-fno-builtin-wcslen'
> 

This patch was already in 6.12.24, and it is now twice in 6.12.y.

3802df8552de kbuild: Add '-fno-builtin-wcslen'
9c03f6194e88 kbuild: Add '-fno-builtin-wcslen'

and

$ grep fno-builtin-wcslen Makefile
KBUILD_CFLAGS += -fno-builtin-wcslen
KBUILD_CFLAGS += -fno-builtin-wcslen

This is the second time this happened in the 6.12 series. The other sequence is

61749c035911 Revert "vfio/platform: check the bounds of read/write syscalls"
61ba518195d6 vfio/platform: check the bounds of read/write syscalls
a20fcaa230f7 vfio/platform: check the bounds of read/write syscalls

Would it be possible to avoid those duplicates ? It doesn't matter in
the above cases, but we might not always be that lucky.

Thanks,
Guenter


