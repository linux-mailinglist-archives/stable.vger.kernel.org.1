Return-Path: <stable+bounces-128327-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6693AA7BFDD
	for <lists+stable@lfdr.de>; Fri,  4 Apr 2025 16:49:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5CF217B49D
	for <lists+stable@lfdr.de>; Fri,  4 Apr 2025 14:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB3871F462D;
	Fri,  4 Apr 2025 14:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AVjf4YRf"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F261F4173
	for <stable@vger.kernel.org>; Fri,  4 Apr 2025 14:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743778065; cv=none; b=CxfxK0AHttfnonnEPjYFs5MUGktgN/IlzAiV5oYvB9ozwjG3BT6kkGvWmOYFilVZH7swnf3CF5egeD4wcwrOChggrcjpprERl5MUMHbOUjdXhdbg7LuAo+1s8pk2JNw/BQZvTUV91Ec18/x5esFhZpw1xYlQpPMolZcHG7xXGyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743778065; c=relaxed/simple;
	bh=DT0oeOxSlSB5tyOszx54qwkjlZkH81j+NmiwOPAiv6Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rd4ojqlNfb+ZzjvKJTtOeR01i//0hsTE4H+gBpH6Kddwdcnehxtptf7iOH6+LMUiHdmAQ7mbTItfyFnkeErxtmu7i5tPsO5++iiVpYdfjSNHtPKkwLpY7O+EcyJh6Jg8ORHTSmnZmU48gcxHskyv5MKmGuq/LHjsHgY9tyjljX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AVjf4YRf; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3d4436ba324so19924325ab.2
        for <stable@vger.kernel.org>; Fri, 04 Apr 2025 07:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1743778063; x=1744382863; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HV5vr/ytVO3vXtKit7H8xx/vEmS66zrCX03htvsUFGg=;
        b=AVjf4YRfc/0gLQcNOjorNPXb/Taih9Tt8J3U+Jeacbok3pjve682oDtZrzE7057UQM
         0e5i0jzH8+lCU4VRZzasWb+t6yTSyYnUZfaxmpwak5890SmcSfv8dbDS6vvm3diTCSNr
         P6OvBhmAebpbmeAIIP2LHioYEsExSOrkEGgU8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743778063; x=1744382863;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HV5vr/ytVO3vXtKit7H8xx/vEmS66zrCX03htvsUFGg=;
        b=mFSdzIXqHfjqPhikPdmdEwL8n/1E726F7msKzJjVpmWTpB1hp9G8OzmfhxRN2mTXhA
         YP/n0tIwhycS4lIjU+f/snM4eoqiwoHJMJ1mYypN1FVJV7ie2cyWY07vWp88NsdXXPp3
         mPQJKJFxamzTBmSbsalLVjytCO/R4WTGUFBOdR59hSgfY2wwBaT+9rKjBj8zQatXsEGM
         qfguWz/PmmJDmYsgKmdgqK5w//TxwRox3Cd1beaQbJW4s2k1GvZ+tVgNxbv3tbDLodx7
         NalStBp5PLOMiDwXSGRJU7puch0emlEuc4bpxMagWdea0n75nnH6MuWs07cA1XHjvCx6
         L52g==
X-Forwarded-Encrypted: i=1; AJvYcCWM5HoMhGFa70RqPhYBA2X+ajxCbDmdRfyeq38+BD2l/bi/KlLbCYJgvepfqPHG1Embe56hYEo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy98pn9m8EpwNoREe69cWWNbYcCWpwPfNTSqz8Kq8ioSiZL/+Fe
	g33uJHTPRBjwGUgPFukrgAPVXeTILVlmlERNWMobIo9zwpvzakNDXgKuKFLc7zs=
X-Gm-Gg: ASbGnctW2YnbWs6L7hPfFRyzX/jUwiL67UhX4SqAHwx+ipDcrQS5nWt4EIsH27Tq+NS
	pRdB6tE1jCxrnNhgYynU9IOWyWRKqfrCQN+grIMCmRlaEcAYhN5HKay90/94KxOCp25xT+jjP3P
	bgDczPJdDaY0RdR8htHwzDCvHoeNKe8mK5z3LmQPxL/t2VL2OSIszTgTSa2+u4xqzb+VIS03w62
	sXn2o3UPbs7rGc0gIbye8uoCmLFPGx6oXreXZSOB8/ndEksMiRrZ1KVLfgYuCFznNHIFBUftoXi
	z5DGert6UbB08jNpH36/BVS/UMgAdpzywC6+8jNODgiA0/kaenG4XKQ=
X-Google-Smtp-Source: AGHT+IGEdyTRJtsV9w/3g4cbKsZhABESQ56Z9fZbnRALmoq2R+tjiu8kPUCEse1POeCcyUAsLI2HWA==
X-Received: by 2002:a05:6e02:2590:b0:3d3:f4fc:a291 with SMTP id e9e14a558f8ab-3d6e3f88ba3mr43879915ab.19.1743778062809;
        Fri, 04 Apr 2025 07:47:42 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f4b5c4a6dfsm831627173.54.2025.04.04.07.47.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Apr 2025 07:47:42 -0700 (PDT)
Message-ID: <406a11f2-af5b-4e2a-8bd9-0cd1a8afeced@linuxfoundation.org>
Date: Fri, 4 Apr 2025 08:47:41 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 00/22] 6.12.22-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250403151622.055059925@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250403151622.055059925@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/3/25 09:20, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.22 release.
> There are 22 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 05 Apr 2025 15:16:11 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.22-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
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

