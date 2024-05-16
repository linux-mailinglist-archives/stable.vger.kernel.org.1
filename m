Return-Path: <stable+bounces-45321-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C45E8C7AE6
	for <lists+stable@lfdr.de>; Thu, 16 May 2024 19:12:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47728280DD0
	for <lists+stable@lfdr.de>; Thu, 16 May 2024 17:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B569F155A43;
	Thu, 16 May 2024 17:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f0V5wK+Y"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F0315539A;
	Thu, 16 May 2024 17:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715879543; cv=none; b=SihaVQzbgergiJm3NMxU2w7JRQSe4d0PWqKrgE0qkjhMpLDifBKc4SMAvlzMup0Ma3Z6vj5xhIkX+4rTaSSm54A198xqwx1oIU3iPdc4hnMs03DqnQBHtbqdTfxqTHFBc4m/i4NogZI+0aTj1VQvImFyZJBIuBzvAeHUARGuMkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715879543; c=relaxed/simple;
	bh=FhE0/+Vev/VD1sKePplNrzUpXEfx7mJdHOT5LI85Ld0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z8rASoHyIiPU1jDRWVqe4yFrOj6QLtSMM3lPJtXDxXIKnB8WjTHIVWo+jyf2ndg5FsLI0S5mnzeuMveOiY452/vQUL4TT7qGZE+O3WMja6LBKcDe6DNgM7xHKKgr6UU4CZsPB2tmyxdeJL8AkLk519u9JgGZJhYA1nuAw4jrsYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f0V5wK+Y; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6a04bae512aso38862996d6.2;
        Thu, 16 May 2024 10:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715879541; x=1716484341; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WNtCqrtDQOq5DdS6OQ5vwazjgqxJj8aBt0efGR7Z08Y=;
        b=f0V5wK+Y6SWj7dQNR3KyfRSLdPtnPjqnGzuI10rAcgjZN1nj7Or6m5rI1SZ8lqgGuI
         Vou1FThCYZz3YLGQ+up0X85w9kLbHEhWd5pN+o2uVDcWuEMXWiwMIoyqABgci55JEDnS
         nQIn/jiDRNvYmXeEISa4a4xjIvRcv4PRtEw4mh6E7nJV3in/UTjMpspi/iR7jhUYIqG5
         2osKaxFVN9uPS8LmAXOXyD8snocDRJ/hYkAExv8R6jmSRHQdXAVnlIRc2atSSKQqP6/6
         P52YJznIBUxdNIXSCHkWLhXpqKIigeK1P/QM+gnNzN+HVtoSa2kz0IpD3KLwszdz0QGF
         xftA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715879541; x=1716484341;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WNtCqrtDQOq5DdS6OQ5vwazjgqxJj8aBt0efGR7Z08Y=;
        b=Io49pwvnX8jAoXT95noq7shTUcpDCo7sAq+d4G9oPn0pedwXVngiE2AebHj0A+XlrP
         EZZeMzudBcnTYSxo4o0R93M4aw2L5YFILbOekn8PYXsqSoQanHllf+XjnlSePyHwYmft
         hL2Nxn1BtvbraEoqJmolXLqTz8I0yZN2VfKgMBg6JtRhK9WIIXd4XsIfRxGUC6rP37UW
         lxqAZtWc4fB+6u+V0ReNRPoxF9N6gvVLScjYkd1FzZi3OvxcgmSbergsYxnOnfJlEGUV
         5Xk08KfteyVdrJSy3s/NCFCWr2K15dNzdHQ2WEwYcKC9lIgb1trrhKiQi21sGMpGtwlO
         4IuA==
X-Forwarded-Encrypted: i=1; AJvYcCU5V8Yz7aZk3jM1L8K7yrK7LZ3heI3UvAByA8CC3OEgEeWKYP8D7HInVnZK0lTZdx/seForUvMD4O8Csay1Yq/TPeCcwAANnAtRl4cEiWGn00M22tAkw6WRtm2U+ctpKqmHzY0n
X-Gm-Message-State: AOJu0YwBhyR1THs5JDja1HjVbJITHQ1iNQ6xoVSsGGGrFBHqdELNYenP
	HPx2s/Js243DUOqdu53oR3Tm21yFrhg5NfT/4c8Pm7Lz02oxw3h8jh2hmmgq
X-Google-Smtp-Source: AGHT+IG9HkjRFX1+YYNHBv/8dIe/DIDRiBupHz5JYg3PVe/p9rP5vVSjJEbRQE/hJq1GVm93at3f8g==
X-Received: by 2002:a05:6214:2f8b:b0:69b:12a0:295c with SMTP id 6a1803df08f44-6a168378b13mr232212446d6.57.1715879540836;
        Thu, 16 May 2024 10:12:20 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id 6a1803df08f44-6a15f194945sm76619176d6.61.2024.05.16.10.12.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 May 2024 10:12:19 -0700 (PDT)
Message-ID: <ea42405f-77df-40fa-af3f-e35b8a8cd484@gmail.com>
Date: Thu, 16 May 2024 10:12:16 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/168] 5.15.159-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240515082414.316080594@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240515082414.316080594@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/15/24 01:27, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.159 release.
> There are 168 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 17 May 2024 08:23:27 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.159-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
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


