Return-Path: <stable+bounces-207911-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 05611D0C1AC
	for <lists+stable@lfdr.de>; Fri, 09 Jan 2026 20:49:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F22613031CF1
	for <lists+stable@lfdr.de>; Fri,  9 Jan 2026 19:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61B1B35A932;
	Fri,  9 Jan 2026 19:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f7MdnYtY"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28226363C57
	for <stable@vger.kernel.org>; Fri,  9 Jan 2026 19:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767988164; cv=none; b=fvPqkU8U/DOzHCYy9sd8KIlTRs3aRSElMmkHxEnoVPeV3B0zU7xaTv2WNIeA1UUygstYaenlDqcv84X8QUZQKY4xp0J4ENHh5oxVRuzuIr+WNbB5ACeyBbeUfCwYuFpm10UCT3Taf8SwkXgFHqMADTPsvdLgp5wqr0BzvKw4szA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767988164; c=relaxed/simple;
	bh=fNgpKzV1HTUMU30nFRHOgjqfz1ALy5IdtMnv3OyZ5AM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=En0UaKGbBROpC6f51CW3K/BmemH1Ed4jrh/9qXe28ukDYlR8UhBxoOL4uXktGlQKeu834aU2GbmkkVVeYjSDjTy0jdRX6DCVvH4B2s0pHNGjIR4XvBdoM1ebQEhfDbaXn3WVlsyT6eFIwe6EVsZVad/7CzoDKuh0cpmavHiH7XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f7MdnYtY; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2b0ea1edf11so10782721eec.0
        for <stable@vger.kernel.org>; Fri, 09 Jan 2026 11:49:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767988159; x=1768592959; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aR93X7jFP3F2xN51srcz5K/pRwSYrhR5yVbLC1NYbmY=;
        b=f7MdnYtYAUze//Pxbk/01cTtg5XQ2aDxNjj0CgEaVMM5oD8zXIfMeOe1SUZeFVO5pS
         zMp2ylR/Ynk+qPol91je95+drX1QJNCXlwYmIJs7jWPrENtuKpSrUOyGZj0hS5pFDi26
         RsYu8IezD6VfdYYp7GkO1PkQuZ42yspB95I+En6MDfwwN86oDja8X8pK3zI9+vM8EeH4
         pr9PFyJaK7AZV6aCBwp+cjp8BNI19Nw4p2/ec5woAweGwu0r7cAC5tlyNER7fzoUHvgt
         o9a751XvQEnBhh/BPxRCTc8WOpyxDqLToSMYwpJ/Nyy9es0KVsA4LG/GR+HSpm1kYbUw
         BIWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767988159; x=1768592959;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aR93X7jFP3F2xN51srcz5K/pRwSYrhR5yVbLC1NYbmY=;
        b=QxSZBt+A0tzED5Aq+2sZ4efySbGh2UBWvJwZ6iW0SqnsMUiqJkIjM9Rf1gZZEwzjG9
         8VSUZrosZJhNpOlJOnSPzlLhD339K/+GCN4GCnI7mFuFqc+Or+9V+YylJFCj6TgPu0bP
         tEX5dcv1p5PrbBGFrwWMOdqzF+Xg9wgYmr+SUpv1iXMavyD3MPBIp0jopeb799V43q/L
         G5YC/KpCA6p36MzpG3INVU0WPtQ3xyrVmhOInCjFRC4SWgVzQkuRqqULxd2B1pWxUTaM
         IyapyR4o7VBoUnvu+GCCdCsbuDZ4FeTcIOns8G9HbfIstFH+O8ZdllftpTcw0V7ufzXe
         hXCg==
X-Forwarded-Encrypted: i=1; AJvYcCXD0YEF5Orr/ey/hxaehFfwgviZEEe7vOnbGxievsBxILyKMTPN1oRyhYliilD6DQRJAm/+ACc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzGfgWgOaNXErljae/TcNnQFgkJNuT95McH/i5PYIgkPrDOMx+
	nQN2qjR1iDRnwzxXSCyDVaN5AOkfxN2KQBsqnHzPniyCPxgxQ9B9Dts8
X-Gm-Gg: AY/fxX5g1jRa0x49/oE+apnhUOo4JqXzZcRoCuI8XdNqAEGDhJi+Ph4zriNxqipTUjo
	iW+HXkHavzZxaaSlqDb/34GHZEXFILfgB4h3uWS8OlMFsbWaL/rtX4jVHj/p7OE/iH2VJQvGaXG
	7tcATQTsmJTtf+VrRMHEQZ4vXq4ZswwojV4Boravaltfr+PMjTUGhi76cx0j0rNFi8CSRmtWQ5M
	w8UXQQ7pKEmpb3Dju2r4Ne71LAS2BtzoGyaDzwdEHfzuUWDwqqib/u9IdGnR0Y2nFJvLXFIrh8x
	yx6DdUs1JZx0NKF9bKKMsxVcQmXbDMFq2pxaSDiQAy8+HG+Q7JxBQbeuUwPo/VHpUcyjKEUKGBN
	PcuUhbLPJCmIErgUpQpgRgPsh0irE4rUKB+RY95N0+lDyZDDvP5sFlpXsDw7ptnM0hv7TOgz00J
	ohOolcMCJ47You9Pe+nh3bAPPqk4dies35jy5rKA==
X-Google-Smtp-Source: AGHT+IFvZ1SqB0E6m6lTuwHY2ZsR9JOTkGm7acWRR4cfQOZSjjIKuG+tOmwjteXbZhhRzDDHLC95mw==
X-Received: by 2002:a05:7301:108:b0:2b0:5a23:9c7b with SMTP id 5a478bee46e88-2b17d341a09mr7102693eec.41.1767988159283;
        Fri, 09 Jan 2026 11:49:19 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b170675076sm11972955eec.2.2026.01.09.11.49.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jan 2026 11:49:18 -0800 (PST)
Message-ID: <fbe5d6b5-6fe1-47f3-8e1a-ae38eb896f31@gmail.com>
Date: Fri, 9 Jan 2026 11:49:14 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 00/16] 6.12.65-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260109111951.415522519@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260109111951.415522519@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/9/26 03:43, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.65 release.
> There are 16 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 11 Jan 2026 11:19:41 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.65-rc1.gz
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

