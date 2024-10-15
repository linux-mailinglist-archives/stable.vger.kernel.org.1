Return-Path: <stable+bounces-86356-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8126399EFC7
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 16:39:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 293B81F21CF1
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 14:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1591B1C4A19;
	Tue, 15 Oct 2024 14:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Rmp3ae6i"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2032E14A4E0
	for <stable@vger.kernel.org>; Tue, 15 Oct 2024 14:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729003179; cv=none; b=tmEI+cbsqfSVamRiDGa5E6QR+mwvvwEoJTCEiyKYW8Z5Gl02Dsn8eYgQL88K7OFfuPmNZEbL+y7huXirg3ClpJeKvA/N7IbxzLv6yoVvh4X1vSDKkyvqittu+TFmOoPYyefyWqQ2ejlE8elFv21VReR7CBSlGsNUIZ7Mx2YBUIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729003179; c=relaxed/simple;
	bh=+FET4V+Go0PVk0KPckgbUBF2yItjsFHqmEQsxlFShNg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UIhlnqQGPJLK7NGR4c4garB8WUDo+3z7xkCNnHB8Ggd8BAWvYPkjfdXMulBDWpUlfy/A3ME/FqbMnUh0tIGeTcNlnE5U0487BPazXLQ2jKk8LUByO80elya5boew57xUGC0sa35OQ/JRftC3n/07OQwB3KVKQZZ5kVvwUfEp98M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Rmp3ae6i; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-837b92bd007so316828039f.2
        for <stable@vger.kernel.org>; Tue, 15 Oct 2024 07:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1729003176; x=1729607976; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aYV3QcxC45dpKB8impDWnSd6jizz1LlWcNLXatvfVSQ=;
        b=Rmp3ae6i5/3vhMzAcBSTJDy4tlUvpnrDUKJXl9oFbVQ+E3TEc6BlJ/PNLzuG/MpWwf
         zjFTwoatzObxB1hI40YfLwTBn0PdoZqhcefRNfAA6o4OBwGh94UPnSz0KchScIEoDZ6h
         P5RQZMKgwQA86OXURrcFkh213jCC02zy8DsaA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729003176; x=1729607976;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aYV3QcxC45dpKB8impDWnSd6jizz1LlWcNLXatvfVSQ=;
        b=SevHLm4s8NCEZMpNBcjCjlA7cig6sku/cCsvkvVJyweaO5AN0A5zjP4/RElI79WtbZ
         7V/+OXRhpaSaaTZo+ANRcMsLmrkY0ypLhk2R21Fo2cEwgoMPmnNIdjEIQ7kvWiPchV+R
         a0aw082/e5Wu77ubfJJkMuaG1sAbxPUC+Y4Zy/B98NdOm+kguL/rORO4uhc6Djb0DVPQ
         VSLk/JOBfZe6tTntjt1E3BFx83TA5QWqbaMekeuXdzr3XTIbpHfTVtK7o7dtES7GZ84w
         9qG6RzzGi1w7oe7IytpcLEikSqwhFKoZiKsXlbhTnwhL6y7Vy0+VCIHytaSAbtVqbooe
         Nt2Q==
X-Forwarded-Encrypted: i=1; AJvYcCX0m1DutIwCtEORCXU61tRel+Tle/923ZehuQLSIcQVR86+mVr1eTGsibpQ2GFf1CdN+GBZ0eU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/F0kArKBLYqQ4Jgt/q7iWYpZk8Z4Cnp3A26fECOAjGVr8BPNa
	OzE+Wu9ElYf79OcQDruaNR1m+HKZd6PHMtwl5w+BlYecldkULJ6I3iJgLwmxrnY=
X-Google-Smtp-Source: AGHT+IED5yavwawNcgQC8TkzJld/CVTX7L8NciyUzcWybTw6y0vv+1spOMbUSvc9mmZZ2bo2GmR3dQ==
X-Received: by 2002:a05:6602:164e:b0:82d:38d:1362 with SMTP id ca18e2360f4ac-83a64bf39b8mr1160104639f.0.1729003176231;
        Tue, 15 Oct 2024 07:39:36 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4dbec9b24c2sm338146173.58.2024.10.15.07.39.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Oct 2024 07:39:35 -0700 (PDT)
Message-ID: <6b913fd4-ae85-4388-8f41-7378fbf3d137@linuxfoundation.org>
Date: Tue, 15 Oct 2024 08:39:34 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.11 000/214] 6.11.4-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241014141044.974962104@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241014141044.974962104@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/14/24 08:17, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.11.4 release.
> There are 214 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 16 Oct 2024 14:09:57 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.11.4-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.11.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah


