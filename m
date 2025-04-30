Return-Path: <stable+bounces-139199-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99799AA50FB
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 17:58:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 564071C04E39
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 15:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C370325DD10;
	Wed, 30 Apr 2025 15:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="L6CL6EY1"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3DFB17BEBF
	for <stable@vger.kernel.org>; Wed, 30 Apr 2025 15:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746028635; cv=none; b=r7GkQcPDz5Mt/d5OiIKW98CQfosrQ3oOxitLqxtLC8wfBHwZ/yZkXcjGTQfTuiIKUBQM/s1WTuZs/fnnfNPdPu1IxnnrKFbNmWcK5zq1YUl//Znioo7Is1VwMG83oPIRE6Vzs3o4G2UfQemnoXE7MYXIify+3pj7zyeFtE1FcAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746028635; c=relaxed/simple;
	bh=YP0fZeLAlpTBiDWH5wF8m33b8xj8zwDegQm0YdkxX+s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KHiCIJRgj0932KkzDsEKqgu3ad6xErC/v4UZEE8HDTVCFGmtvu6W4BVxq84gxVo2thDUf/OfG8Mtbpp1+2W6d0h2Xed8VV6FHFGdlYCSYZkA0bVA+QbsDYHIrmwAuaDbkE70KYQpv4VtW/AZlBJVBYyWXJo80BtiHFDWtmtq2J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=L6CL6EY1; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-85e751cffbeso648539f.0
        for <stable@vger.kernel.org>; Wed, 30 Apr 2025 08:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1746028633; x=1746633433; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vbg0k1gnF7nXpY2T7u81fy1ukn3uxWlDYnypZdEAQtg=;
        b=L6CL6EY1zWDur16EVxpz09Cf8KshLS3wDuHRAeCfunzqkMygW88RTKLGtOt43+66Xi
         0+QQSATt87u0B2LX2c4tS3RAc4PkvsvfjSr1pI93NaaSRC+eGzbwoGmk9jRFnywxUNDH
         JLyuEtFlMgmjQ1O8VV9JRcNv8n6J5PsbxO7eM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746028633; x=1746633433;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vbg0k1gnF7nXpY2T7u81fy1ukn3uxWlDYnypZdEAQtg=;
        b=ZkWmn9FdIyM8wazmmSUs3g84nfPHY+r5HWsfx+0ELWwus6WHXh9UklbnzEiQynNTB1
         mROSli0jyEMOQ1YLAAp0g37axZqkNehH+RM63Sfhs2j7T/wQfk+BtheixUC/RNRYv+b5
         vdwG4I8abiwXbZalWLtae5kyYJpRNn9VNCzW+VUw0reshW9pjb/F03UouAT8ajHOKasT
         byQ9WXXYxLiMqLYIq+1Y72EttwhN25RnGtYuZMbEa6OPH6BQALyDYu+BkXaRZSoN5JnY
         WXucXhbKJamm5Vq1HpxLM0YBeCo21QDUrv1jSj1ENUG6XbIfMHx7FMhXVj/CWQk9IHRQ
         5WZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpI43+hxRWMN/VfT7q39aJPFVLcz89+YFcsPrR6NI+RU7J7wkdIZr5GsH1YezxEnSit5ZZ3jk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5RVdOpW1zRGeD7En7LzmVCWp0d2JJR8bKsEQV9fsUogDnC2Sf
	BtkTKtzfi9lcarCbXKYzlxd2DPIWtN8MYB6qt7conSbWkwX7QX+lRd2T/mxh0+4=
X-Gm-Gg: ASbGncsuAP4RpaXmG+NIGk/6bCjeNyQfRP8qeyf2l5HnJnOngxLjWPWeYMGN/v2wX/m
	8kQc6Xn1eOFFVMGThcVZs3WEHw5iSndIRaetRFREBwQfSpboy9TDP4fWgAExCoWIjycle/MhVZl
	4N1wLX7Djm5D0OMA3C/8/d6E/JIUpYkHlFiwZwjY6vsiGLyL6PEmpjgTNuZjFXbydVArhJGr/wG
	w9M4LSSgZEqd4GguIEKVRozwVO0Y76w2svAGpk+53KIuTyY34U9ZDPf+njqnVWGQZEZVEr1unqA
	qSXsA6EHjv5ZEeRuQI6eb482YcE9wH4k4f5vuZQ0HCbmZGj/vUQ=
X-Google-Smtp-Source: AGHT+IFh3WGBACndewk4cZtkcC6191QkBbQBb9kKJQqhhi0DpqegJ/d+by7PNLwd/DZjTq7NFYBTiw==
X-Received: by 2002:a05:6602:4749:b0:861:c4cf:cae8 with SMTP id ca18e2360f4ac-86497f4455emr317771939f.2.1746028632896;
        Wed, 30 Apr 2025 08:57:12 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f863149b3dsm795000173.107.2025.04.30.08.57.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Apr 2025 08:57:12 -0700 (PDT)
Message-ID: <e08635f3-bfca-462b-90e3-4c3d23e0640e@linuxfoundation.org>
Date: Wed, 30 Apr 2025 09:57:11 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/280] 6.12.26-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250429161115.008747050@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250429161115.008747050@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/29/25 10:39, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.26 release.
> There are 280 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 01 May 2025 16:10:15 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.26-rc1.gz
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

