Return-Path: <stable+bounces-106153-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD7F89FCC60
	for <lists+stable@lfdr.de>; Thu, 26 Dec 2024 18:18:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A484188261C
	for <lists+stable@lfdr.de>; Thu, 26 Dec 2024 17:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B842136351;
	Thu, 26 Dec 2024 17:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FD41KjOP"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073702B9AA;
	Thu, 26 Dec 2024 17:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735233477; cv=none; b=iMpLtmhqLakRfhhdPmNFxg/GT2hkBUbx7amIF+bllk74Fz8vrK4rtE6Do5XAjWfJHc+5AFuoEVj3iGU8SCvYs+UctJjk3l2uYzrn4OhVTKe/2xbNN6TDLSdGh7uaTcQ47sHXKIX0iNRRDn6Y7vOweT4SpE8HLGpnkPPqAVme1yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735233477; c=relaxed/simple;
	bh=ww7W+rtOj6vI3FcKydZmdcipzAf+fOFg2f8HWEOocgI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A5E/Or38yz4pphzJXeuXB56C8c04xzLwhC8iPV57/oOkNJDU2O7HfZLTRZsJYO1jJSEjuxytNWZxHKSW4hDaQGEgEc4YLjV9HJqabip7cZkz1qq5LI3YUKsB7AZbMXOlWZAM21wDyBKwbHkYUo9o3/aj4O3j3XVkZ3O5VLoQVHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FD41KjOP; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-21670dce0a7so6335385ad.1;
        Thu, 26 Dec 2024 09:17:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735233475; x=1735838275; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N2JS7KIcFGoRuhDSIr5OUV3yQoO0oPRPWcrr0Aps2ug=;
        b=FD41KjOPxa2OG6mF2naICNPnDRhiIbTvvovXlT3cJOZ9UjGwOp03g23b72bK6uEuNB
         cACDANATBi1nbNhfS1FLQsJzMCfmcB+p911z2gnxvrTRLiT4OwFlkSAvpytggfmYDYdl
         OfiwKf8u1KOwaPJ5Uwu7EfKeFkjrvf3Au1bXO9lML8eiU2DxEiVQ6kLaDsRATB4p9uwu
         K2htH0KMgUtS/xqQS8svf5zhjDtrylJbR0NtbHIiEZuiLHPyEExWr7FawiUAg1+hRlOU
         /kxN7PNlQAAJ0R13Q6ACwCbYsL2fEPLI/F18jyIzfdbWOxhhJ97unNYwkAxbMUkA4XhG
         YONA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735233475; x=1735838275;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N2JS7KIcFGoRuhDSIr5OUV3yQoO0oPRPWcrr0Aps2ug=;
        b=P6qCBEnhq7gEOSQOW9T8ficSm+A7PYzUXeos3fGPJkRqD0tipa2wuDzxqEi3X2RiM+
         JJv74mjfJiBb3AxmApebg53Y96s3KDqafeqQW/NLL9+EyVe6BSaiQn+Hp8aFYLBQQyZp
         oLEgzoC8eddet/RTEOtGHy5olDNEcPgvjxo4RgE4UeJGA1ejtdniULJIeC+LVwgIcL7f
         jFsEqKSLJVYmQD3aq6cDBcM/SBtMgRVFSc0GkWd0MGX8EaIMNkjhxeu4vEl+1u2y144+
         kTdHVXbrJkCfGkIXNOhGbG8FWbbcwqUD12rYnK/U5+whYJVQ1GJH9wjIdOTV/6F+6Ks2
         XLiA==
X-Forwarded-Encrypted: i=1; AJvYcCVMNXVf0HezWvBJhAITbajXVDt+nmzgQYbRpdn9agLxpyRUtfcuoRXoAF9Z4qRPeInQ85mN4jDMiCp/2X8=@vger.kernel.org, AJvYcCVu+mN481dwmik1rOm36EtUDn46b+H3SFtXD5WyA39BfZaXgGKvZw/9Z6Mw8f/xM2WJ4TRZFcQq@vger.kernel.org
X-Gm-Message-State: AOJu0YwX9zl8JjRzGcny5utsOSuafwhUlXSuMMfcgxY67zbFKonvj721
	BLgEnKEOh5qGY7P7GZUqu8D+81/dzveJv79rZ+Q/9NbYHJwAgL3wmqy96A==
X-Gm-Gg: ASbGncvy/pRKIrSesuwEoywkXLYyCFIufX99wzNn5AgaHN9TZpN07LMdtZfuaC5Yx6J
	CkTgjTDmDsS/lcCmRIlyh1jTmvALAduiLyH1Z3OHGpQCoTAUcMTnooOfNv7ZulI97sCER0E1tez
	2GDA0DgGTeff5z52Ku1CQ5xeJFjXtaPzJIpYQLo9psWIrIy3rWSuJKJHXxHK0LFYePg58DQ11aZ
	H7wvmJeSh8c73KgSzGiO1b3NKeHZu/gjHzH6DHOXBwhtf8d00KAlzU4mbGEZ8nXU7KXI21k4JiY
	AG0oUwAf7fyXjPWOFIw=
X-Google-Smtp-Source: AGHT+IFvTvgkZFJMiJIZRSMsJE4sRMVjtoqtMI1ZfNdqvb3f8fv3x0IsAx2GK1OaxALqD2HTYM+vTA==
X-Received: by 2002:a17:902:ec85:b0:216:45b9:43ad with SMTP id d9443c01a7336-219e6ed1eefmr305861575ad.34.1735233475269;
        Thu, 26 Dec 2024 09:17:55 -0800 (PST)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc9705ccsm122014735ad.92.2024.12.26.09.17.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Dec 2024 09:17:54 -0800 (PST)
Message-ID: <da01ed2b-8d7c-4b11-b565-966ce66f4653@gmail.com>
Date: Thu, 26 Dec 2024 09:17:53 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/160] 6.12.7-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20241223155408.598780301@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20241223155408.598780301@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/23/2024 7:56 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.7 release.
> There are 160 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 27 Dec 2024 15:53:30 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.7-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
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


