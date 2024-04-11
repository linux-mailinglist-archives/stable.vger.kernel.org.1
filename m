Return-Path: <stable+bounces-39238-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0293F8A2292
	for <lists+stable@lfdr.de>; Fri, 12 Apr 2024 01:46:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0B8B2829A9
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 23:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96EB84AED7;
	Thu, 11 Apr 2024 23:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cJZgtCqC"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08DEF481B4
	for <stable@vger.kernel.org>; Thu, 11 Apr 2024 23:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712879203; cv=none; b=OW/gpSTFj4+tqHuI2xZ/T9d5UtqAB6/QvGX402aLRYrLbj6CYH5Ec8Yc8hIrqtqYKpjHLncLkEDHr4TKjyqKKSnDrKrEZ+dN+4oClyGeDYveP/iRLhXMFhELgZELJ6cOXnsFGfBUJvqZvtQrUWrt5ioVNFd3KxNrp8Y8dwPl/jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712879203; c=relaxed/simple;
	bh=Te58fI6EcdE2bJFhYbz+v0q5C9dz++1EPlQhdkT5zA0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ezHc8pYApsgsVKiF5awUj+XuMdQedkNGfuRgdtFACaiHwlK1UhHu2Va2wsGZGZfJ01MSSnLfXegQRa36yW1E81VXSxLPelnp4KyJiitWDollyCENIcL93Q5F6g+to8MylyoOo1oza2+V9b+eNVWCztN9rQ8tKw942wu9gcwdqLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cJZgtCqC; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-7c8e4c0412dso4048539f.1
        for <stable@vger.kernel.org>; Thu, 11 Apr 2024 16:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1712879200; x=1713484000; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fjibNV1N2oKSA0OqneeRyZVV5aTGA2KbobjCXl3xa9I=;
        b=cJZgtCqCwUkX74/v11G3kdFIpPtDUUss5u+le+u0gmTNpubN16qxeup5loVz2DVSLL
         KpWU4rM3YYzLjnn+QFLNT0zS5ifDAEDo2G8A0lOZ4xbEnjv1r7zfF2Lq1rUByjyvmnBr
         cXECoevYw8udLLX5hK+gLz2ILPccGzxEeLa4A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712879200; x=1713484000;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fjibNV1N2oKSA0OqneeRyZVV5aTGA2KbobjCXl3xa9I=;
        b=l95G1cIXXJL/Tzjl7SuIbJXZ34R/07jefGfs3LPXFBOdtM/6Qe7L4xP9+iM3EY15rW
         OfKrfHsslzy46uYJbNA8ICSp58H5ulWdTtJOAWHfMEUeoTEJKhmE15HPbc7pPthSln0d
         OXl10crSwopDnL9rfboQsKSNg63uX4LyT+0pgvgP29TdWvH7wFVAR62SLajrQCHxV7gk
         tpA39oF+K1lx0+glCMJHq7NqyvMV5T6q29ASxoBmbEg8pVJ2Riw3bbnsQXa4GEGViEyx
         kiHmcMdd5jtuhevzmCqL9XXuV4VCL4r20VTlDDv/O20uRC76bJE5ywsZuT6cdkkUREG6
         IM1g==
X-Forwarded-Encrypted: i=1; AJvYcCUUi1tY9VYit8RTFh9A4tClLs4OpfqXTQFcwFRQ1XEk+xkbN0ND23G9QjQcRBvRTchhcUs+Pi20cbsgyGSCbP+gN5vhwkyw
X-Gm-Message-State: AOJu0YxHwzGAbqvKjUvvvTHlpN4MmXv0zid6gm7WdwGJyFoHe4FGJBHM
	76OGlQ7guVIw3A41i03jq6MJG+TZVIFn1wZcJv9y3WOuk0jYvSlGNBNIMEHIHZl/pCAdhcCWprG
	b6Y4=
X-Google-Smtp-Source: AGHT+IF6bXZy5EeA7KV+M0Ggaub20djgk2KlnhwxiRM3BUoZuSw+nZdR3CWQAJ4KCaRZqIHys0EZbw==
X-Received: by 2002:a6b:7b05:0:b0:7d6:60dc:bc8e with SMTP id l5-20020a6b7b05000000b007d660dcbc8emr1538701iop.1.1712879200241;
        Thu, 11 Apr 2024 16:46:40 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id je3-20020a0566388a0300b0047bed18d110sm681415jab.114.2024.04.11.16.46.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Apr 2024 16:46:39 -0700 (PDT)
Message-ID: <dc19ca20-3787-4e0b-9529-68287469bb45@linuxfoundation.org>
Date: Thu, 11 Apr 2024 17:46:39 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 00/57] 5.15.155-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240411095407.982258070@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240411095407.982258070@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/11/24 03:57, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.155 release.
> There are 57 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 13 Apr 2024 09:53:55 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.155-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
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

