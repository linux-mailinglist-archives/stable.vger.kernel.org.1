Return-Path: <stable+bounces-169416-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24270B24CDE
	for <lists+stable@lfdr.de>; Wed, 13 Aug 2025 17:10:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 106671883380
	for <lists+stable@lfdr.de>; Wed, 13 Aug 2025 15:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 817A72F28F6;
	Wed, 13 Aug 2025 15:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VFCuFcDb"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1392E8DEC
	for <stable@vger.kernel.org>; Wed, 13 Aug 2025 15:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755097536; cv=none; b=LW/7FFFl8w5R11bACff5uOQuuCFAkY1x+5F3AONzW2YgrNTIU+c+o6r2rEEqDUtXTDmNaluBzikYMVR2CJpI+hTxl4ACjFMLRbVbr71O3PNV5RCpC0h1byzspenZfS/q7jDnIDN/tSA8bgVN04+5teGaK8a3I9i8lKURApwXEEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755097536; c=relaxed/simple;
	bh=3XzWy2tt6bqaDyewBfl3310hnzDoLk8KgRxkC51IzhA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GtmRmzcuHy/2gzddJrRNotIhThJnSHoRwpP2lJAeCG5oigM/YKQ+xd1+7L0Ku9bmkUlew4XY/ZZdNk7AnVsn6Pge38vVeBfmE1keMRMnZSXFIwdx3UAjclV/aoEJBANQF0ba4eFwuK+NkNTGxqlcCkXIpqqsIzlmzAZkiZvD4I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VFCuFcDb; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-884328c9473so204139f.0
        for <stable@vger.kernel.org>; Wed, 13 Aug 2025 08:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1755097533; x=1755702333; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bLuxF8BcFQ4U8Ber6EP4PVwS4pfKrMlITaK4ixL0kHE=;
        b=VFCuFcDbZBAV0Cxc8O45ddSVRoWaD3pYueV9YHvF5bsWe/KXYApbc7C/uAfxNX1gLZ
         q/G7IRRFncRdMXvoe3Wr4wDC7GFGiEORwbUiFVJAaKUdHZNqLyKujfyoHqQ8kNv54wcb
         VZHLcICqYjjG6DMmX9Y3w7J51f2brc2nmksDc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755097533; x=1755702333;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bLuxF8BcFQ4U8Ber6EP4PVwS4pfKrMlITaK4ixL0kHE=;
        b=Kjg+EOInUJMHSjJ33ySk0Dbhwi8QXJhU88QP/ihQuft2J0KIXWl8jUI5Yj7tkLfwUX
         WBFZzNs+cjEJ4HTlsync8dYVvJ5yq/Czm4j56ddq6iH6A4BiyfTp5XmxEPCst5axYufi
         FunBUiYEBA8qvjkyaoq8hAA3EOTX2aydaIYXU3/wnHXOFhTurelplGJW2ibzCkwuBX5S
         fpBQ7Xvzub3kLkXr0R+SnpiL8MhiQRPPOOJ20caQoRW56YN5QVFlvbtRTnDXHc3GMe+e
         T95NAPcKTRcJ/kpyyLciPK5RH0+JesfPY5Yb1gtFFIK+QQX3s2PSquQ5l/flGDWYRHnf
         8zxw==
X-Forwarded-Encrypted: i=1; AJvYcCUOxkgpaQgn75i9AygajJCNe6GU2WNMPXsrovv0jc/jdxZSeXTApu0nfNbv6dEA/N20ce7FxbU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhYS4uxDAsVw7BSWGR2pr6qsU1Kwk2tGoZnH5CiBehS36T4rue
	TlLZ13FaPxbWxAyAuyaBV3r9/WdRQLvZKIFo0Wy1DEfbM6yDGbd3sdJv5pxE11TCLlA14nPrrBk
	ZmyEs
X-Gm-Gg: ASbGnctPnFw67B3WoAt89HUo9MOkYyIx9TulW1IJZS8v5+0Ck1QNLhB+GiT7DH6fYdD
	EnSCO21cXZz3oJh9JMNa2be/oN0suD2t9n5223TAIt60H1bBHNf580gSlYJnNaJLPReOPKrwteh
	jc3y4da3VWBiMSYD3HY17Iwa9drwargUcJFcZv3fPTeyGojx+y3n4fndwHrlLu6Jhj98kIfrNoa
	Zds2LqdxvrEUR3HjInNxakGA8KLWKrEe/MRNIVS0GZW/wF3nNQtQLFyGLedw5S1IDj3kVkCxtmG
	yNs/aXNLa/VJA0lgbFLfxvClb8AgjX2FfziEFf3LH9hHd7JQ+yUxVj06eDlKFkAPHgs2uK4/BmT
	asBR7RB+Jpn3VK34uU6a4FEEeSV6xpiZQJw==
X-Google-Smtp-Source: AGHT+IGV/ISII8H2LUhsvrlcWKzdOlv0auQmk4l8zj9XLpqt/+BOLYq6RaNdUSrvqV76pSjl/LDVlA==
X-Received: by 2002:a05:6602:1651:b0:881:4b5e:fa9d with SMTP id ca18e2360f4ac-8842a332320mr450166339f.0.1755097532624;
        Wed, 13 Aug 2025 08:05:32 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-883f19d013dsm448497339f.31.2025.08.13.08.05.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Aug 2025 08:05:32 -0700 (PDT)
Message-ID: <173eccf4-5613-4899-a3d1-1931379ce09b@linuxfoundation.org>
Date: Wed, 13 Aug 2025 09:05:30 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.16 000/627] 6.16.1-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20250812173419.303046420@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250812173419.303046420@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/12/25 11:24, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.16.1 release.
> There are 627 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 14 Aug 2025 17:32:40 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.16.1-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.16.y
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

