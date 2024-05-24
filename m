Return-Path: <stable+bounces-46071-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B003C8CE727
	for <lists+stable@lfdr.de>; Fri, 24 May 2024 16:34:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 526711F215E7
	for <lists+stable@lfdr.de>; Fri, 24 May 2024 14:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED5DA84D30;
	Fri, 24 May 2024 14:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bfcgLx6q"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF6486AE2
	for <stable@vger.kernel.org>; Fri, 24 May 2024 14:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716561288; cv=none; b=VThk+mRxBOQJx4aAuG29tqEslSdksG20l3OTI21NaXywEhnXJ5+f0ZFEzombF+RdAnhyzmxzvZ6i/gWXWZqPCY73xzvn5W3Him0y3xleWjQu30qTgGzcoIN/hLsR2MOWC7p/314BdL0w4BqyOuzhawdeNK8Qtjr+c7JgWtbvIHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716561288; c=relaxed/simple;
	bh=1DD7UAPSGWhJO5GHaawnU+uPBfjRKH6R2/isM2cFwEY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ha+Psd45tCVaEBEO5GVPuajWR1QmYtAqRIRXbW27MP02gMTJfs+YYSykT1CgNzJNb/WX0E+3QBKFpMhqlf3yhDmfOkgtxRkCmCL4eZGoYr+rRAppxHG1uOFo/jSns9Km49QRrZlIRroI+WykTIN64Xyaz+21V10z8XUnwZTpQmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bfcgLx6q; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7e8e5875866so3713639f.1
        for <stable@vger.kernel.org>; Fri, 24 May 2024 07:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1716561286; x=1717166086; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RoFzHlSPjkXYNbJlOVt2ll4nOjdL2XVhikUa/6nwY0w=;
        b=bfcgLx6q0kxC37ciMfq4nWxewIUSxW3txMfMVZ3q1YRnIesI1oSiPSXwEZD3lz8CXN
         wPJ+I35jGxCDkROM5SsCW7ShRqLly77YynQloTqzoUNHFupxiz+zQ2WvlXcku8h665FG
         R4BsSMHOo0YRuP7jKlUj0wAd5B8aPS7gtO5XM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716561286; x=1717166086;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RoFzHlSPjkXYNbJlOVt2ll4nOjdL2XVhikUa/6nwY0w=;
        b=r3R/1YTIoWw4sFV9wen7SnsIJrhKPioQESPB6zwxwh81yDXNoIntqIdjeyFFeyQHZ3
         T3RjIF0VRBplZDYSOFsssn3T8VOgXmEXfkTc/9DSM4NKaVUV44tvGctysBQa93EbqRUd
         v19oNqMpJdg70pYYBqH6P4TS9y9m8ChInByw/rfom3g1ZgQSHpVTABqCeSBai4gJtQsz
         thh5fxPrVpzp4u/XnHElpIEzLnEROvmF8Om2QKKOiSMK1bdDrTwPffhW7uNpy4MtQLjh
         Jouh+7RhXucDf9+GGoSQW/mpaf/i7IyqxHXU61z/uNFlGpr5rpijNcVOOePYv+skWsF1
         K8rw==
X-Forwarded-Encrypted: i=1; AJvYcCV8Rk9iHfgtg0JxsSanfyEFbBVLsF/wjZg3vFxgZ0s1Zx9EZ26JMfPiK2yawbql2lLlbJtsPzX8lpeLP4eSTA6KfdwTr7v2
X-Gm-Message-State: AOJu0YxpudjLenfh9p1r2EifTT1DJGL/Dh1/Vmd/7O6BMl9qXm8tuC/5
	01FBsYWCbKBy5nW2BIPO4IU/3A/IOPzthevOvZpRZ3YrAq5FAFgpOkQtaS0bPE8=
X-Google-Smtp-Source: AGHT+IG5MmuONIihQqWnSSKPSxcNAZPcu8epoB+/zUWt7iZIYjsQWJWxkDtGuMf3gKxoQr+OuWUlKA==
X-Received: by 2002:a6b:7d43:0:b0:7de:e04b:42c3 with SMTP id ca18e2360f4ac-7e8c1adcaa7mr293181739f.0.1716561286570;
        Fri, 24 May 2024 07:34:46 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-7e9042dec6fsm38761639f.18.2024.05.24.07.34.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 May 2024 07:34:46 -0700 (PDT)
Message-ID: <fb55ae97-9770-40c3-84d4-3b714702612f@linuxfoundation.org>
Date: Fri, 24 May 2024 08:34:45 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.8 00/23] 6.8.11-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240523130329.745905823@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240523130329.745905823@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/23/24 07:13, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.8.11 release.
> There are 23 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 25 May 2024 13:03:15 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.8.11-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.8.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 
>

Compiled and booted on my test system. No dmesg regressions.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

