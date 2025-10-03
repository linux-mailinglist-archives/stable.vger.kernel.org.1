Return-Path: <stable+bounces-183302-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C1F36BB7ADB
	for <lists+stable@lfdr.de>; Fri, 03 Oct 2025 19:14:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0D6164ED506
	for <lists+stable@lfdr.de>; Fri,  3 Oct 2025 17:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 853562D8799;
	Fri,  3 Oct 2025 17:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ivlYDj1/"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35EF260590
	for <stable@vger.kernel.org>; Fri,  3 Oct 2025 17:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759511637; cv=none; b=p10zuU1KS3Wclc370eje+nsh16tYcovnz0GBZ5bgyhJhxqn3LVPQXmVM8HsJeFTV1yXDnwUxZQHRGYvzcfpbnVbmsKK/VW6iBK9ZUzb3YqgsIYBFZE12yzO9K3UQVP2UGYa3KdvlO9gvrFget7BGQ6EH74A6T2+o/l01WEjNok0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759511637; c=relaxed/simple;
	bh=V2yDQ9t5WRaCCFVniNPFFtjcU+Z93008Qn/4tgTMN9o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FfVEuQ/xNAFx72AevdFMjLmDsJU3C2WuPZPFHbjppHhOUR6XUL2UkW/GaIr1MKN4ClV5u6F520AGNfReOJOOYwVuu6aTm4j9JADfPTB63ka+j1RS+kyhXiMsmL0khIOomErKQNDqwqfAkPn6HLPKpqEIjEulm6cBoQq2aMbFntQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ivlYDj1/; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-780fc3b181aso1515010b3a.2
        for <stable@vger.kernel.org>; Fri, 03 Oct 2025 10:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759511635; x=1760116435; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g9aHct2AGSJyqUdy/hqfaZO5vGD3Tcs42UjzJUIOSD0=;
        b=ivlYDj1/dhFAma/WWtSkFtWQ6jd+0wppWAiwlmEiUpPR9eLGwD540c2O0xlnLazw10
         z5ayio4WIji0JlbaXCrNPjtOlcWcUoO1ksQo8hU66H6UEcmri/S5OiG/3WX7NscKKPgt
         K/uVw89grNFhfpmSMckkGFZOpD+gzS/hpheKOGpR3G7XxtCtSnR3S5DS5bAr/nOgY3bn
         X0pL5ImgLFNwE43PFsABK7lpmD7T8Om4LP+Ubz85VZqg9D2sG/sJN7teExQr6VP/8mmc
         mV2ZkD08dnGpd9N3pyfuFYtSDws5FZNOoViMLGXk6kspDEMQd2jiolYKANroinlG29Y0
         9LlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759511635; x=1760116435;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g9aHct2AGSJyqUdy/hqfaZO5vGD3Tcs42UjzJUIOSD0=;
        b=Lrs2Rf6MGmpAQJeCX/nR31nwV8l3QNfFh7GO3WQWJmZ0K3p6q60V5/cK9aj+hpEDXT
         VQIEzp4Q/i2k5LPq5SvENfqSrASEdVeLFmo46SpC3hbrokOZ7LRv6QdftNLI9+WZ8gof
         d7lsX7Rulv078KkqVc7iLcgolZBa9EAwuhr6bbZHZyDJVBlP1OH3Wi+46P3H1k+4ChfA
         AQrjuWZwdY7xIcGzFTVMWuI/xa6f4OPgE1ivSXguCTSuEHe8u0v1n8B6zMESTmapRIxa
         enFnTrvbBBPgW6ueYCT5UaDN4HQ2ZJ0PAbBzmj8cI8oT7GfmR6CL+YlIpBG2Gylbxayd
         brvg==
X-Forwarded-Encrypted: i=1; AJvYcCXmHAeiSqJeGTm94splph2M5gcg2jD85XVjrUZ7MBPn5Npiqakv2zoe7Q3yNfUHsoATrpmZJoE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi3yTd9d7I4Wy49aeBInpzZbNAld26qVL+keuiOZBWxvm8/qN9
	q77iG5HlPEmyu2M2s7AP8Ma0S4H23Q3x3oiI/udflcViRMYOURe9Dkt+9qiKfk6I
X-Gm-Gg: ASbGncvOE02YtKgh0MFtIpxCQNa4BQZbdkTkIlRsZZ9WscIsfrke0QwtJvqzAv8NTR4
	511lL0xWxZ577XdcuibMG4D2P1AJ/TfSd91GIty5E/FBoxw7FBsvWBT1YSbVuQqh4oCK4wHk87r
	cxu6pjZ3oENiL4F3auBocUg85KV2tGGSftyJagqoTYGpGaMpbmzjQs+IURmXn1xQW7j36jfIzBt
	ih/4zLuXylFgm4kWAyDj4htX2kHIe4HLGD5CioFFMEZX8YMwNqRh/fkPYzv5jaSYtsTrs8vdw8X
	KeUoF3FAQNWX6LV6fb9JdcrAzi5Irw08yIi6DwZFDZtuIWvqTLL3Yx3vgTZ6/GNO5X58h9qaiMx
	ec46luhCzTt/2/KJ5RPAiGHwPAzL5ebWLD1HHqskZT+JPf9J3RGphXhG5O2dEEvpdbumjBe7FJ2
	y1WmLgPRm3UyhZ
X-Google-Smtp-Source: AGHT+IGYxcu/7m4cInBmVlBcaknFm26QdLjuVZE24mLFzQf4XQmV94nPh21u2/AfgdOkqw3I9aKJhg==
X-Received: by 2002:a05:6a20:6a28:b0:2f0:4f71:c478 with SMTP id adf61e73a8af0-32b620d8f50mr5346720637.46.1759511635156;
        Fri, 03 Oct 2025 10:13:55 -0700 (PDT)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78b0209005asm5517750b3a.81.2025.10.03.10.13.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Oct 2025 10:13:54 -0700 (PDT)
Message-ID: <f9c844f3-fc5a-4e66-8547-754f73e33af1@gmail.com>
Date: Fri, 3 Oct 2025 10:13:50 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 0/7] 6.6.110-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org
References: <20251003160331.487313415@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20251003160331.487313415@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/3/2025 9:06 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.110 release.
> There are 7 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 05 Oct 2025 16:02:25 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.110-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
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


