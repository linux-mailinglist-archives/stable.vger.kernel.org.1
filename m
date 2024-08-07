Return-Path: <stable+bounces-65966-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD7F794B237
	for <lists+stable@lfdr.de>; Wed,  7 Aug 2024 23:34:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30D7CB21CB5
	for <lists+stable@lfdr.de>; Wed,  7 Aug 2024 21:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95F0714A09F;
	Wed,  7 Aug 2024 21:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IkBMK2Oq"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C156D145FF9
	for <stable@vger.kernel.org>; Wed,  7 Aug 2024 21:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723066488; cv=none; b=srvzp1TaAQkWvst0ItfUl7GUQHV2SYU6pDUIuigq44LCDmn+9qNzomDBRlFXo+7bFM1oRzmvzwNQmMZ40c5ZqXPjHgPAT7z/eiVsfB7hi+CZATYlaP5J8MPEMRCG85CT6ZPrkpnRQWtwtg9KU3mR71BUWPmozoXDIepNOoQISqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723066488; c=relaxed/simple;
	bh=L5D6Da8d8PDLUP/fPT/55SXNoHUlfgsys/gI4OIfhvU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YgmsUU8cj2TH9CLk8/5MYZr5PnMlMy1avkDGBFejkDqPrvQ2A4F+zK6sS2nCQGS09VR6gBVKrt2wwwQxVkhVeEB7tHKEAUKgiHyi+2n+CXnd2S+JMAHU+S6F9uJRZUKev8/6w39o6hL23l5LRtkDV9NWqmxr4x3Jn1PTulzQ3Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IkBMK2Oq; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-39aecad3ea7so252025ab.2
        for <stable@vger.kernel.org>; Wed, 07 Aug 2024 14:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1723066486; x=1723671286; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JzleT9HD4xqdpPEYR+tWtbUQCAn3f2oq3BskLFI5XiQ=;
        b=IkBMK2OqpuG0CJJfzWP9EUDqTADBSqnmqKuJXmCT156WwT7vUpKHC1YUWc+9We93FE
         WLliEPLsrguIIyjmoDx/6+gz3dXk3MSGolXDDOEALen3BASv4BWgHL64T1GIcVLPaDoU
         N2TA3aDUhN74K7yALAbO/ucZ4wr8H04Lllb3g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723066486; x=1723671286;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JzleT9HD4xqdpPEYR+tWtbUQCAn3f2oq3BskLFI5XiQ=;
        b=s9OVYCeWe8AKE94/7uF6zCv8P5xQgFJ6r8/8FEotnc38wJeV8Od1eAzkNTFfybPMDu
         kTExHv2SLcYb25+wNKxOQmLhG7kdHYZq2vsPTJIIZKNnDclDBj0GFeXoDrY6vYRb2urz
         vgPQmv9/earbqxSF3LsiZkjEt2eMhqHyBC/mt/7s+wpeOyrDwrt+CNeDC9XE+F0v6jaN
         y7SDbcmSonsCJa1G8MgBLkpbnfMg85gfPK/OD1nidiDox6b0iaQGZrzAhuP9NWwctTgD
         l3A2KCATbcQpXR9x5mYPEc0kWs5G5eZ/xUOYUS7TYFG11vvKGNsopW+Wio05JU6OQojJ
         vWTA==
X-Forwarded-Encrypted: i=1; AJvYcCUjXzZBW5eupkj3KXz9TxAIdYELCvHN0/mhDN5mhVZ7VOqbvTRzKPcUmBvm0RZer6TB69+jtvkaDkRFpBsRTh+cH6Ps2tZS
X-Gm-Message-State: AOJu0Ywa56x2/gxxCY1dOQL10/zzqxGYXczal1KzPhMlBW2RMJ6xQAiZ
	lqz8AmS4Z8I3RbVkuoWpJT4zsS0b22Hck5vdWx1bz1CgUpKqM8U2Woy6UbH0Fm8=
X-Google-Smtp-Source: AGHT+IE/iAvs+xq+B9OSJ95PcWTsUGdNYYT6r7pEyPXJdr9sdk19BaDRTg4HhsAlyDZFSlhat9MsbQ==
X-Received: by 2002:a05:6e02:16cc:b0:39a:f2f4:7ead with SMTP id e9e14a558f8ab-39b1fb5770bmr135522395ab.1.1723066485702;
        Wed, 07 Aug 2024 14:34:45 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-39b20ab4f73sm48137485ab.39.2024.08.07.14.34.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Aug 2024 14:34:45 -0700 (PDT)
Message-ID: <77c85a59-c9bd-4a04-a325-e205aa2e1df3@linuxfoundation.org>
Date: Wed, 7 Aug 2024 15:34:44 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.10 000/123] 6.10.4-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240807150020.790615758@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240807150020.790615758@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/7/24 08:58, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.10.4 release.
> There are 123 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 09 Aug 2024 14:59:54 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.10.4-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.10.y
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


