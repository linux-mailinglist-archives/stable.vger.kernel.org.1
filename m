Return-Path: <stable+bounces-178804-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 46AD0B4803B
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 23:28:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10F5A7A22B1
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 21:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8171211706;
	Sun,  7 Sep 2025 21:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N5ZX6pVi"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520CA23741;
	Sun,  7 Sep 2025 21:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757280524; cv=none; b=sW6rIxAUBLJDn3nJkSft3GAjbcUNcIBJD8lXiijMPIEjet8NJY0sA2onqWfnPH6G3nhZwynOKN74SfYil4/+WlCr1jwNyaL/8yYfWvSFC1XfrHGGKhYSgXU+WSGWXORUv9yBeCwHkZkPu4xXcvVzPm9tcfcMrVDWttpYFUg9/xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757280524; c=relaxed/simple;
	bh=gR74D3k+MV9PfzqWWLYbz2aBI5dOUxQmFr9qPjRQexA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=DGiVegHKZnCmpOJ7TPKfx3IRFFnN1I1uuusgL4ReTV6nzDcq7cx/RECVfLHdXNREAkJzEiLn/snMsjWBHQvh1/1XEd07siQmnykc2iDSOCk/O8cJFL8AO6w3friUsRyD1TXPOW67ZbymRCeFIAci1LffggoPp4Ym22Uz0w1+2Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N5ZX6pVi; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-244582738b5so29972845ad.3;
        Sun, 07 Sep 2025 14:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757280523; x=1757885323; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GPZE3d2vBpIHqeqE5zsVlFxsV6AcS3+kycA992Tnu8k=;
        b=N5ZX6pVi/dfSE4GMGA8JHIqml813pOPuQ6Qj/XpZ2q1ogHiDeRXycFeQJa5ADUq0Qx
         jc607kEU9epNNhjFI9qJFM/ku1zbwyAx6xVXmzbaD4A4I9cr2bzH982ULFyGC6F0pVnS
         kLoZA2CwGmAkQGdT2HaR3/Ny1RBErn449WIpG7FQhi1Bphej7CoV6OYN15RD65WMMrng
         A8Zv7ifdWk2kWjI2VdYp6o8HnVPcKVrUE1P6BYlhI7x0oHDlz2gbSttMm+coUmVYMuqI
         ItUMUlRGlkmpu0FND77+gvvfQVC653OT6Q9yb44qh7Ui21farnmJDRbEMmXJxVHNYk2i
         K2gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757280523; x=1757885323;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GPZE3d2vBpIHqeqE5zsVlFxsV6AcS3+kycA992Tnu8k=;
        b=J8AMRtqAdx6B9QVC0t0C1+nR1aOFunH3QWuYNoG6DRliUvM9GDm1HPPXn5xvgOIi0Y
         bXPIJfRtT6gCUJsPSfRSf0JzsyplDS1EuS2lDBZuXTJF3GBhEHBhH8FWfQXXWtIEr7z9
         w0xAkxUZXpw98uyApRuquXjdDz7yK4onQPS7dmiDh9Qbft44TIKGfUTwpLCkpqWyKc37
         H0CJraXZGQ+zjcoKguuYNZA1YgOLHIafKmmSIYX6+oNoL3nj2H7+wKshzyLxPVCmERXs
         LiKzl7VrM/XqavMsV2nYwNgvuYav5HMTMraRd2XvEYWMFfbc2ldDnZcE0fHSG3aZTSiU
         1WEw==
X-Forwarded-Encrypted: i=1; AJvYcCUgQrtOaiN1+z195fG7Wqbc4BfIDsSMQsKt4Ran2lJxd0wBBtfxPBTrAoB+86ktqvQUwFzA+nVH@vger.kernel.org, AJvYcCVMsEI5q5SIl1ZD+RhSpfjtDl8jh2677ES6KR5JKQ9lkWsMOuLq3J0WGZw1NKaKc3Bt4VzbuUPdqd4oyy8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0Y1S7onsfeOBYF49UB0hd0auJYPu/b8MeXTtJZ0OfHu/f4Kb7
	5uwoPcqxS6EOZ15lVkUkkUWHzu/40cBR9ciPvcLL97/zH/bv4TlDWlKb
X-Gm-Gg: ASbGncv4T+tGwUnoMhgZQ8Tciwu32pzvpzG3ohlMXwKu415qMKw2APKUcXJ+if/niy8
	EMYpXlhmu302UL5iAOjXo3+6GXFFnS+o15SGIFbibE2vgZVLdV1ZxV/FFlaWvcxCHAhV864vW9j
	+2v1gOYIBmfWG3nEk3osua360cmsVeohMaOuN7haIuwJ63fZnSEdz8ygqv4GcKzBySxz6hjENvp
	9yS82n4S2RSLrQKZ942HQza4p5hmWQkvIY6CVQy94ccI7r66lfAjvWfAsDdVDv9QcY71sQQya/c
	9VN7hEXdEohhJhTShjZpoJCS3pS5leTInRDUIGUFq+A5XXkZzRL5MxqM78+Ow1M2pwl8q5/Oubo
	MDX2OovJKYDkze9JResc2qOkA9EefuNZtY4FKcCzFQo06nYvRZCLeeOQNcL3ZOFTT
X-Google-Smtp-Source: AGHT+IFjvDoW0qqD08FuutCREqLKopUYq03wiHKmvvg+3FvOwAgDbd+bp/VSXnR/dPtUmeD6521MHw==
X-Received: by 2002:a17:902:ec8e:b0:24c:cca1:7cfc with SMTP id d9443c01a7336-251761680f7mr84458115ad.59.1757280522623;
        Sun, 07 Sep 2025 14:28:42 -0700 (PDT)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4cd28ad188sm24263276a12.26.2025.09.07.14.28.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Sep 2025 14:28:41 -0700 (PDT)
Message-ID: <32b78edd-c8a3-45d1-92df-9facadb61d89@gmail.com>
Date: Sun, 7 Sep 2025 14:28:40 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.4 00/45] 5.4.299-rc1 review
From: Florian Fainelli <f.fainelli@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, achill@achill.org
References: <20250907195600.953058118@linuxfoundation.org>
 <82edb13f-134e-4aaf-ae5d-6b9f80b02e68@gmail.com>
Content-Language: en-US
In-Reply-To: <82edb13f-134e-4aaf-ae5d-6b9f80b02e68@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 9/7/2025 2:08 PM, Florian Fainelli wrote:
> 
> 
> On 9/7/2025 12:57 PM, Greg Kroah-Hartman wrote:
>> This is the start of the stable review cycle for the 5.4.299 release.
>> There are 45 patches in this series, all will be posted as a response
>> to this one.  If anyone has any issues with these being applied, please
>> let me know.
>>
>> Responses should be made by Tue, 09 Sep 2025 19:55:53 +0000.
>> Anything received after that time might be too late.
>>
>> The whole patch series can be found in one patch at:
>>     https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/ 
>> patch-5.4.299-rc1.gz
>> or in the git tree and branch at:
>>     git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable- 
>> rc.git linux-5.4.y
>> and the diffstat can be found below.
>>
>> thanks,
>>
>> greg k-h
> 
> On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels, build tested on 
> BMIPS_GENERIC:
> 
> Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
> 
> Looks like we have a minor regression introduced in the 5.4.297 cycle 
> that I will be solving separately:

Looks like we are missing 9bd9c8026341f75f25c53104eb7e656e357ca1a2 
("usb: hub: Fix flushing of delayed work used for post resume purposes") 
in the 5.4.y branch, while we do have 
a49e1e2e785fb3621f2d748581881b23a364998a ("usb: hub: Fix flushing and 
scheduling of delayed work that tunes runtime pm"), looks like the 
cherry pick is not exactly clean, will work on that later today.
-- 
Florian


