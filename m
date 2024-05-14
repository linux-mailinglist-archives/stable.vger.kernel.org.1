Return-Path: <stable+bounces-45110-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CEC58C5DA8
	for <lists+stable@lfdr.de>; Wed, 15 May 2024 00:32:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40AF51C20EC3
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 22:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E0D8181D12;
	Tue, 14 May 2024 22:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OTUwxiZ4"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241C21DDEE;
	Tue, 14 May 2024 22:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715725962; cv=none; b=G2XfSdyhabs67hZe/z2owWnymbdTSKTAqJrKkB2tWhYgiYMH6tYlUkP7V2oRdrktagDnB+Gxh+GsyQqQLndfh6Nmgte9aj0pwMwQn3o5zTsZKcI0SQ5ydJ1qAheEf6hORG4vsOGMTZ1RLRq1fZPICtmAOEahzr0gQqUdckbmYvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715725962; c=relaxed/simple;
	bh=RennY2C6Z+oSU0oRQjAqTe75OFRCviPgBEI+D3LQn6A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Icwiakl2z7uQSfaPzZMECfjGyKnYKqMBt0XSDAlchC0ndSRhW5b7K8/q7eoNWMjtl0GSqb0qQNt0JZeF8pUI5sAgrbhG+hN+6q+YChquUH2TM8mJbL4xSqRDr0jehIeOBEM6yI8oOv0CRve88eN8bnJao0IJAyptpZeGu44BqOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OTUwxiZ4; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2b33e342c03so5335691a91.0;
        Tue, 14 May 2024 15:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715725959; x=1716330759; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s74EzR4awKr3eLr45eszTkAhWZLBmsDf/EkYyc0o3kg=;
        b=OTUwxiZ4mgmHabf4ALQ0UcH5VsLY5z+ApUjEvf6l9geEs+rbb7zYHA5MebhGUgdhF9
         1LguRuTtaFhklo2vXzro39ha8+eTWLmFuml6AsURJmwwIe0XOuunEPCTb62tVEZLNlqT
         zCjS3GlWADf/dshJUrvVXSyFpQIk+k5EABrrAVV7uxAxaSzzKEG2TCUpxevjBNRz+O8L
         qgS3SAV1DLTQxkoBG+xmrdXFgomQZ5rg7O1uba0dCJGTJgNkNlgVU1/iHYU/SDAkBbs8
         xV4ObMMwlG+rCs14DcFNVDBP8rEf6FQsEnZZk5L4HBxbGpB3sBDbnL8wypeKtCqu3ju3
         gVCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715725959; x=1716330759;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s74EzR4awKr3eLr45eszTkAhWZLBmsDf/EkYyc0o3kg=;
        b=bUmzHWchrYmZMJkLHearH6Wr2ZL6gozc+dktyXAU3lRW40amiNk8rAOUWpt/RONkVy
         H4pf3bFXYnIHotzRMQHTZKIBYhcrrvzWSuzUaWBQf+nSnMC0dteHmG+aD28r+Wfigf+C
         qdB2+ENQ+DxX2QryS2zdFLpqdhO98dlHRtemFjIU4y0ua/cWtbc/qjVKuflFcyD4gYx2
         BlQ3mEOGYcGO762/NmPpBWeO90VWG7Bdbr97FC+KkkKiWUt5N6a0YCNlq5EvhIw3qfYh
         g1jAXz5aHip3GwimUXppVZL6dH8FzYtQ7YxatqzyXhLoRsC/xwBpiGXK1k07N/f7VLLA
         QsIA==
X-Forwarded-Encrypted: i=1; AJvYcCU1e6eyyHpvo8yTYhZ1bnENs6h2RTo1+KuHvnrRh+vnmt7aLwxGsMzP1H2D2V8xOpvB3pRJbkUzcJUtIkjAa3chBC3U/g5JB30ncyDDKvZRHv4rQPa7rmdtQVTKUSBo1horLSXE
X-Gm-Message-State: AOJu0YwFOb1NsjPYtY3TdM3cubicXnTL7D/E+CAGFRDkKPr9VykFFjw2
	Stvne3tc4GJ1+xLdjr9Q0w2zUqs0VckHk/hRY4KVOne7H/SqFB8Q
X-Google-Smtp-Source: AGHT+IG9Iy319cNgBaxrp94szNVyTaeCn09v6tx7NwkuFYWrhwte1QksURJFD6r6MHMHsOk5icmZCA==
X-Received: by 2002:a17:90a:e507:b0:2b3:bcf7:3a9b with SMTP id 98e67ed59e1d1-2b6ccd8e078mr11850683a91.43.1715725959324;
        Tue, 14 May 2024 15:32:39 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2b5e02bcf6asm10965137a91.1.2024.05.14.15.32.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 May 2024 15:32:38 -0700 (PDT)
Message-ID: <7a3889c6-2e6a-444c-9827-56ca94aa89f9@gmail.com>
Date: Tue, 14 May 2024 15:32:36 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.4 00/84] 5.4.276-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240514100951.686412426@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240514100951.686412426@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/14/24 03:19, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.276 release.
> There are 84 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 16 May 2024 10:09:32 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.276-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
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


