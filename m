Return-Path: <stable+bounces-103939-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB4019EFD64
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 21:25:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CFB9188EBA1
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 20:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C19001BD9C6;
	Thu, 12 Dec 2024 20:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZI20925T"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093A21B6CEF;
	Thu, 12 Dec 2024 20:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734035105; cv=none; b=po3EbrYAzFD1/omxtk6d4Do562JXJm1B3TSfK3cIUYT+qEdE6LtY+xifd5efdYTrKasSSsb95XDOmcUNBsNQqGKSPkWF14oeSwgdKHCQxvqgIJ6jdDx3BNPBHCLV+sarizpkghohyCPr6jJzrkIJzzW06oAxWTlOZ3A4/cwGcaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734035105; c=relaxed/simple;
	bh=Qd8ZBm3p8yVf+a3IlpOny97+x+Z8dg2dk2ElGjs8FCA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z4tHHG4sl7ub4N9rF4/whyq+h7X58vcznUtH+auaV+QZ1MB02VhCTOCGML86A5T4GYvlyF2v+eFbCcmHOeREflVzDX7l0MikbfwoxodXAOGHkgdRQI2KUKLcVf5lFsPcY+tarUf4ARx21ip+hAEFQL0vfLFZ6EjclOwpSCmW/o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZI20925T; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6d922db2457so9017926d6.3;
        Thu, 12 Dec 2024 12:25:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734035103; x=1734639903; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WsmWZKTDUFGjOeAhXzV23hHoSQBuVuhJuLt5WHiryh4=;
        b=ZI20925Tx+B3xtGQ0io20gtdg5+vo3aFa1oBDnd4USf4laeIxFS9uBWHoEh5UdgTRQ
         aWEQgjSHn011HdThYGYQBHYDnfS7TTfV2sj/YSDIE1DAxXqmdqGY/1X3XBczYeS624Dl
         40aaedQv985BznZQZpXbbVn2p4nv53qJcJmfjGQWjsO/KlNC92D0krKzG5n4Zh7mFqrm
         gjfXuhI0mlsjec9DvxZvABWxIeh1YZ+c2hLWZWjBDqN1tfaADjGgKuKPEa7TlQ2jIA1w
         br7LxzkbB6cX5pOtT+h7k9GOWm5Ij8DBcLSfLjjGBmiRU+inPdaeGEpVQeM5XCQjLS7Q
         gfmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734035103; x=1734639903;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WsmWZKTDUFGjOeAhXzV23hHoSQBuVuhJuLt5WHiryh4=;
        b=LpKg1B17+F92PMfJM9qc2V+FoNCFmEG2mwNbxhtWma+mWUfe0t2853wFXINAJx1+xr
         /sdEUC03NtNtHaVBcie7Zx8qMFAbFhjg353tT3kru4SGEt3xTM83iQG6d3kf09TRtb62
         GYAXcm5HNMMyhA+hvITQaQYm1k3lTeez1lLjqpFFjtauu5aD1Kogc6McosQwjvyXiejr
         bV0rNVxFool5W5yFhL4iXxj5Zo2DYy5r1wO0LYf0a2Gp8hcRKdXJ917PnCQ/a3So9Gh5
         UE9eM+QlFgE1vqeJCDM3VjO0NlZtME7cM5MIJaPiGSwu7/WaELTGo6Y8dHgFrsEjfEwn
         358w==
X-Forwarded-Encrypted: i=1; AJvYcCVCrcVK2Pgh5IxD9rjk9R76oEA9eo8hEfGoxJW2Prm/6xW5Xp6IuxH3CdGy140TUhPOFDmd5cib@vger.kernel.org, AJvYcCWoddTA+6p2dZMeukM5angnQGbfi6BTK2UDCWJos1QLTPMDSokSrth6ielOcntyX42xl6U2LVArSevaCS4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlmyHTsE3RhIJMY1ghNU75bRizJYPSObbUoo+n1/yd9yvE0jAy
	I1mXiQuP6ZULt4krYDZHlB6kQLBJr9+HrNo3CxrmUn4L67Wlbiwe
X-Gm-Gg: ASbGncvOxd7BPkifkraKOrlBFj0iZlyT/bu8UDoza9T/YRibtpHs5Vf8Buwa+muhhD8
	2WN8lKmKhaH/d8aPpnbcL+y3zc505wWk42XOn8olRlqFRngic9RCVYSoqAwRQwDa2LpArq6etcO
	YwdibfNxcp6axHPX6mZ4x7RSiP5KvAPjXCoA8EJwlevL7t2d1k18r+a7D0h9fPhXiuRIeG+RK4w
	+GK7Z/npWfGQng/QxJQ+j7BJnsZH19wsPVJovRK6AT3rD7AKxCaZuLsQworrpi4gOWWPQkIs5eA
	rzNcSWmd
X-Google-Smtp-Source: AGHT+IGgI6grpBZif/oO6iQOjexftekBRamWqawbZLPN2nvYycghF+WAN3SGJ+A1++FPntqfVBMsow==
X-Received: by 2002:ad4:5dca:0:b0:6d8:a610:21cc with SMTP id 6a1803df08f44-6db0f6ea959mr20781636d6.1.1734035102929;
        Thu, 12 Dec 2024 12:25:02 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d8dabfb7a4sm85151826d6.104.2024.12.12.12.24.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2024 12:25:02 -0800 (PST)
Message-ID: <a1ec91b0-6a45-4351-bd27-8fe35ce87711@gmail.com>
Date: Thu, 12 Dec 2024 12:24:54 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/565] 5.15.174-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20241212144311.432886635@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
In-Reply-To: <20241212144311.432886635@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/12/24 06:53, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.174 release.
> There are 565 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 14 Dec 2024 14:41:35 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.174-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
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

