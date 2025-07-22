Return-Path: <stable+bounces-164294-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 30A08B0E556
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 23:19:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15B2E1C860EE
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 21:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 453E7286420;
	Tue, 22 Jul 2025 21:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="INyaU5U/"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9BD2857D2
	for <stable@vger.kernel.org>; Tue, 22 Jul 2025 21:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753219178; cv=none; b=J++bvFJ6Hl6cMH+qpQM59RRdx9u7MJfLHKT8vdzqLGu3FOqUGs5Vn7CkuIc+FbDUwuHJU70q+nSOSon4qg3qC34Xeru4lNRW5+K9+SXQZIj5eu247/we+MXUq7SboAhVDpmeLFvzc3F/T3EDpFDM099VQfhqsUMaQJo5DS0kMMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753219178; c=relaxed/simple;
	bh=U5/9PrXzn3TSV36bHyqWBQ2lvhT22VgIYiPjEDLqPoQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qQvQtrVomgHjFXAMuzC1AghMTxUentIkTDr5jxXBY7cDZ2W5xwe/wc26CU/jYf6JuchHWMd5a1MV1F0ayA2Ajy4L231jDYlxGFle1G50cHJevwSWmw4DCbj33YN4JY1UcTDypjnOOZUFLfqgyO31K2bwPIJnGnHnPYLbeq3lbt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=INyaU5U/; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3e29ee0faf3so13947565ab.2
        for <stable@vger.kernel.org>; Tue, 22 Jul 2025 14:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1753219173; x=1753823973; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vopwzi+8eYb89OM5G9WI2DnldDqvb+R9BJJKxBuhxuo=;
        b=INyaU5U/LzculQm/MyVyYUQoBjg32wX1/e3xAPdK05HbHuW2HnFeONgPH7ex6k93Xf
         9rT7ZjF0XhDktsE/OXbKle8DqiRdQ9Mb0BDm3KVITtmt1OTmI6OMJNhY4WoYgzOdhDSX
         VPZyIqju2uHwgnFf5H9XEniVOIQk13mTob94A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753219173; x=1753823973;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vopwzi+8eYb89OM5G9WI2DnldDqvb+R9BJJKxBuhxuo=;
        b=RjMohOyIjF/5CDq3kQ2kt/o+2WJoJg8yuYFWksZgMCQwCC5JdS+6jO7O6jH8I8s/f/
         +OUu6IZFlT23dRtfbkxkZVebdVJ2BbuxBDARd97/I8HT2YblqyLMbx4O0JvbnyZMrwn9
         TACRIzNuWEgnPbjOYc0UlZEOzpTybs3E160gf3AH5BVBQmXohhw7pz41AEYujHIr409s
         a2ru1k1OwjNmrK79oWinGyPIqp/4SbGJgUzYT5zAOXYi1tSX5ctCkNqZZ9326DPQ1YSx
         ox599vHfEzUMTcT/TJCAmST7BQBAd4HcFHTnCMc+AnLalz86r9BdWd8HmD75rI2lePTg
         nOrQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhQOOJ1LfA2EtVPftV0kRe/Z/r3Xoc1pHcDN8kgr6w3yNRpH0u2i0fJ7+pbtc24CWMXVO0xSc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrUCMGTh/hZ0/rHqiS/SlcHqCQymolPJXjmLOeWPmFDAxwxkUm
	7jPrb93rWkgsC1onR+Kl3R5podnnquhjS4WJCXnokPE2FC4coMN96gTvRybzNqL9ZT8=
X-Gm-Gg: ASbGncsuNSyjr0f5RvJkxsCpOH05OaRksEuDy8lPsOH20Pcki/GEUm1WcUJTtKGspon
	rb9MyMfwFdXJ9ozms5tmPE+pFbvx0V9ETKDSLIabm6TsPdNtBV+iCw1Szi9m+Myp/3zitpugrOX
	QwsgXBZIEjdrVs93JBH1AxyeXD6D19zTSM4ucDV0NSbUWt7XlCekP6tgamz0q/7O1hkHm5qlYhy
	taTuX/RJCg0OltucWsyZ3Bjbv6c8N5KhYbQeLqzwjlr6epbpzsqBPcg1MPLMtP23G8H0PY3j/6e
	HMs/rSZRStfsJqzr4pZE3WpaIJCgnSit4Xdy0vbLw5WAGHdo9bEpcInhubSX1NNJDr8lVkaG5tB
	4UPLC8YPm4nNXerpA8EUWOol3fCjphPEWiw==
X-Google-Smtp-Source: AGHT+IHB2kj7wAlirQpyMhdwef+1nzMVJzg7XJvQ92glYHifVsRf8s//4dpWUNN9PM2HfQM5LeL2FQ==
X-Received: by 2002:a05:6e02:4701:b0:3e2:9eac:dc01 with SMTP id e9e14a558f8ab-3e3354a23edmr11949525ab.18.1753219173467;
        Tue, 22 Jul 2025 14:19:33 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5084c804addsm2750342173.58.2025.07.22.14.19.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jul 2025 14:19:33 -0700 (PDT)
Message-ID: <b0d63011-fa27-4c21-a5a8-a2725ae935aa@linuxfoundation.org>
Date: Tue, 22 Jul 2025 15:19:31 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.15 000/187] 6.15.8-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250722134345.761035548@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250722134345.761035548@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/22/25 07:42, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.15.8 release.
> There are 187 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 24 Jul 2025 13:43:10 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.15.8-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.15.y
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

