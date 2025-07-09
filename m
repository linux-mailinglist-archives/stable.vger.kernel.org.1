Return-Path: <stable+bounces-161499-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC812AFF45F
	for <lists+stable@lfdr.de>; Thu, 10 Jul 2025 00:06:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2C9B3B07C5
	for <lists+stable@lfdr.de>; Wed,  9 Jul 2025 22:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0804241CB2;
	Wed,  9 Jul 2025 22:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UifMY2Gg"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9393E13D2B2
	for <stable@vger.kernel.org>; Wed,  9 Jul 2025 22:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752098801; cv=none; b=uS1qp/xyFpMKvYzY+wDhpaCut4wGTY6gXB791OJ1iAWpFxePWAMzvEUHFgCbU9lcdRs9SSNo1dK/OvvPs7VWwoCw7ksHNaIanI5BpN8yDIfXelLvX4ajh7ZWsrE82qNzh2zBUMBodG+gaPKDSJZI2oM5qmFIUNdsggzbvh6sO14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752098801; c=relaxed/simple;
	bh=UivWZVbVTdAnNMHvcMlummL2yP5IUJF6YP9QTx7V2tQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bgGVZz60Q3xigQO2PaqVD1uVN5HkObhOsIWWAd0Jw9Ga6C7XNyBwJm86fXrFWBsAAkBg8+FmNifcO9/K27qqaRnKWp/nxY6ic1EkQ6lhUAaVDownF7yKEqJAaCnMX3xnyflEURSv6HFZbMRwaepOPUZgpS+HHahAUD+zoPhL+6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UifMY2Gg; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3df2ccbb895so2932575ab.3
        for <stable@vger.kernel.org>; Wed, 09 Jul 2025 15:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1752098797; x=1752703597; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AHVWGMYHRCKbeFjqKUCEW0KQtyaUl3Of7Bsa4d9NxMs=;
        b=UifMY2GggVhBNXWIgOs5fiBljg22QniffZZhOGbol58ck883+pC35CPGIBeJQrnIOA
         HRMvV0Cl3y8PluYqmnInksWqWbKNOGgXISzpOG0CXndCWA6hWn+04JqA9zIX15eq2xGe
         SD4b2hg50FElch2LiAX8fx5YLSglDcOnLCIbE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752098797; x=1752703597;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AHVWGMYHRCKbeFjqKUCEW0KQtyaUl3Of7Bsa4d9NxMs=;
        b=Jc4841ZkSYRxqA+7uAbQwkjSY8/Ed5mX3/4bMfas4146lkqIXKDGaIbcTkWv6mhwEA
         9QDPE+E5Dk6kB+Ue7zqMIpI5h/h7pM1UsKMRnSEwtRmV3qR5R8vNfiSKnObxCcqMsJAt
         1kmq2tIgvZG2KTMVdU/abzuRju0fGKdewogRjSVyiNk8fUqXgTZCWo4LcqGC18VAn7lT
         CrJ5L9KtefkhqPYWyTqBDqQanEychsIywjt6x6imVTkunb9gcBciiaLblGCbzbjKTYh4
         sUl1/sBzvCNprOBZWwY2KmJL3nAZhp3Gb/iLIjPw1QbaCQy6i2hFIanPyfYlb+QNzf5k
         oMRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdShtJLxm29kMSV9GIrtg2wWYh09YcS1zzt1gTnm/nWRM7XGCP1kM/Q2hkSZntxW7GTnNQkdc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyR2YPos4vu6P0SAUQyC8i+9Ojb1e7vRnFQCpe7mWn/tCdXcPaP
	Rj0UZ9jTcS9nDnECcmM7DNXk+5ZCiMYgA/XRAQSerKv2KKalB9sLUeRbaQoCFtXTGVc=
X-Gm-Gg: ASbGncs+uiGfsIOUBaRNW5oTLcqL5i0lDqouAoTlbOAeEaGHaK0FbAlp1nedHxHOC/K
	BdKfagnSzSO/Ow2pqBfTX7IVIa5fjR/YxpUT/4fHH46d7fmEnb7F+ydIzuQS0eMvy3V/uYzSuml
	t+wgYmiNZJHWQDegabv434vituVVeyLt4hect61UyaQ4NiXY2eZPlUTR4hc8WbaLljE3bBIpwdG
	g5xRYQpp3p1bOxDHqJonQyOfxy/YM88gA+BM2xoshdw3shXXQ4S60RzvAGlFSKWM3NCxMrCZxY6
	FUN0Uy4D+exWJc5VTsM+0HeJ/AlofIjE84wi3hzezd/KiUgk2DyOWHdG2ClNBUaXTtLKvJWoaw=
	=
X-Google-Smtp-Source: AGHT+IHWjvyzeLL6N8yU+Q79PG0An3NzZ7hrnWtn2/hlkyOhS6W5NhNcVoTCYr01Ld/L8cIfVJIByg==
X-Received: by 2002:a05:6e02:2205:b0:3df:3110:cc01 with SMTP id e9e14a558f8ab-3e2461eb736mr3622715ab.19.1752098797568;
        Wed, 09 Jul 2025 15:06:37 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-505569cc6e3sm37400173.102.2025.07.09.15.06.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jul 2025 15:06:37 -0700 (PDT)
Message-ID: <2c51d285-186c-4110-b292-4051737ad215@linuxfoundation.org>
Date: Wed, 9 Jul 2025 16:06:35 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 00/81] 6.1.144-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250708162224.795155912@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250708162224.795155912@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/8/25 10:22, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.144 release.
> There are 81 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 10 Jul 2025 16:22:09 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.144-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
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

