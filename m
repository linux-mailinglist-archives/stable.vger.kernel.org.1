Return-Path: <stable+bounces-106578-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C6A09FEABD
	for <lists+stable@lfdr.de>; Mon, 30 Dec 2024 21:58:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 084B01615CC
	for <lists+stable@lfdr.de>; Mon, 30 Dec 2024 20:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB47219CC36;
	Mon, 30 Dec 2024 20:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Gt/ZGCE0"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313E919ABA3
	for <stable@vger.kernel.org>; Mon, 30 Dec 2024 20:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735592309; cv=none; b=rfsFOKjQAeS2nMawiLuKXGY5A+wiIhPbxrb7xQxBORBYfAh3pevcwC6wfFCnFAoPd1dlACTRX/2ZxAnDkwQWr0XP/nTs6b/CRqs7VRLZ3Cqy6nE+hE+YUUJ4stpLpUzfmUajn7gLM/uHmRciepBtpJasNhsmkfmwmSZAx4J8Dos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735592309; c=relaxed/simple;
	bh=ex6QSwQEiZhlMX2qD0HPG9/IBK/NP6pU3E64l5rusB4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=udlepnXiK8r58SPAxxPVjkl1YSG2T/YFgYi21jm7xZHVy9TiqXo5K3/z0UVQZQPcR4YVVTVdqDl5idcsJi+8vSFDhCFsn0xte/0q9f2g80xoCw8YNFv0OuuZ17bvWVz0rp0er8MKWT78SCNXu5+vOhJmz6mtDm1Srhw9nUmvPTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Gt/ZGCE0; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-844bff5ba1dso754945439f.1
        for <stable@vger.kernel.org>; Mon, 30 Dec 2024 12:58:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1735592306; x=1736197106; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tB+6W+IrBzBEAXEAXQiP1227h/crTkFPCfG7eT6ve+Y=;
        b=Gt/ZGCE0TZ/hBKTdkRwmq3VHT6a4dQxH+1y725DmjY6RgpY3CzC1I8oOZagCuEyjNp
         sqNtT9xCpbwSGQgQBWPJXpuQ+C/nzO7LMW3Uh0OrJJwq00bFho87y2gbA9vnJJFOOywG
         BEZirSz8oWHQ3y8NAnSAvWB3T29pr+jZLBSLY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735592306; x=1736197106;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tB+6W+IrBzBEAXEAXQiP1227h/crTkFPCfG7eT6ve+Y=;
        b=l62p9pPvmGjpa1h1M3ZmWp/px3xOmEIMnYdMzfMgLCJ8nUhI31LLdvsHDBzmMMJ+WR
         b4ixqXnfmm1Jn5zLEtY1GY+xVRp3wtC99bsNXNhMBE4pfPhLSlO7aLNT4/2C5vwsdbTX
         kyptvEOUbRs4B1wKv/NmwmTeEfgl5535Ejo1Mm2srnWEDT5o4HMxuBbMvLtpzUV9njfN
         kvlInM/kn0cydRO8f79p+lQGaWS+f/PShwBuzdvO7/f6LaA/wg15wf7P/p2V85m0iMRv
         /Pyf2QLnD37jI5BUsVsJoxW2S2GIFgbqOLDhVGPVcYzMOX54DM84YxnIl4uV/SgDpn/2
         VGiQ==
X-Forwarded-Encrypted: i=1; AJvYcCWh0fJGoYlH7ObzLF0a7X7Fvs+QYcwGyFQhANN6a8AnYFAMrUvqTeR/GIsKaN6UHgwpQzLOhUw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXzZVH/WyzdzluJIaRFYAONp5XrIaEj0kocX28ya6duF6DYWfF
	FeRnWYi89ECCXhY3ZGiNdErxMphWKAGQOEXlbQi3ktO1/9gpVXQKEeTh7LWPRfmUt9leugnhdES
	+
X-Gm-Gg: ASbGncsty+vp7BcF359xq1ARtSbiVW8XUApCTtngBe16yqAcHgd7RESVejj1vCsr2e2
	lrCDdjDr8UoVYaNptpJIHBpWF0q51NTOWcdEAPK8y5FG/YME+dBQzJkcZ+tDLSKqwkPrPAGz9h2
	XKifRhSpx2D+DGNsx9Xin7/WPZaxdil5a5DwhCmJaIWWcewRCyjMWAcIdWvLCds3QCbgI4AlmI8
	f3BJLUHqzQSMM9ebr0kx+UobKmy0l8FNdNy4JWG4dHtMayBOtOZmiK67F8822XzWAbi
X-Google-Smtp-Source: AGHT+IGcdhrTKCB8H/gwZPtz0/Ahdr965oKRBKC5oj59c1LYlrh8O9OqYHusymm72e8baxgoyc5gNg==
X-Received: by 2002:a05:6602:3688:b0:849:a439:a276 with SMTP id ca18e2360f4ac-849a439aac6mr3654562139f.14.1735592306246;
        Mon, 30 Dec 2024 12:58:26 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e68bf80630sm5519655173.76.2024.12.30.12.58.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Dec 2024 12:58:25 -0800 (PST)
Message-ID: <7889c1c1-e9c7-40af-8771-5bdc7636d455@linuxfoundation.org>
Date: Mon, 30 Dec 2024 13:58:24 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 00/86] 6.6.69-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241230154211.711515682@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241230154211.711515682@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/30/24 08:42, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.69 release.
> There are 86 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 01 Jan 2025 15:41:48 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.69-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
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

