Return-Path: <stable+bounces-154585-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E0F9ADDDD1
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 23:18:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3BC7160704
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 21:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C2112E54CB;
	Tue, 17 Jun 2025 21:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eWFBnTA2"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB431DDC28
	for <stable@vger.kernel.org>; Tue, 17 Jun 2025 21:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750195098; cv=none; b=Gwjqm6/A0L4HwkN52DOwwI/DFuazTchoh7P6mcQP1VwuWZxzmFzLRitE6fB648o3g5IGNaamlkDn/kvbFzuadynu/2SlL//dtl+uFjNL0LSCPrcs+tJIHdnUNeR54RAFl3zff41A4Gyv2lHTnuiF3ugsAAnzDNvz6O3dD50PbjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750195098; c=relaxed/simple;
	bh=TVwhUKNJWh38SAaQKE/6I1lTgFb1qJ4jUs+nTHCo20k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P5/jhY1tZA0CqGIdgEHn9B3K8sg/uRP/5IBF7maAMcjcQHyyjv4SzX4HSubgpc3/wZSgvfxH5xGO6tccZmfsuZRNvm8TUe6/T6ybNdDCsl7IRJFQJu4ikkWKrJRzLgz10ZIimSkQxXQX1VKNVMoyZEquXD6I7Xu60Qd9ViXtvK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eWFBnTA2; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3dc9e7d10bdso20724335ab.2
        for <stable@vger.kernel.org>; Tue, 17 Jun 2025 14:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1750195094; x=1750799894; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lAXYvMlPvJqgHUS0OPvSDVehGX+5oMCjweHYTWvK2RM=;
        b=eWFBnTA29LDnfvJg4ysQlG6NsPZIwMkwuXntp8iBzEsOTDJQxfmXoxcMhJGbrZKHA/
         /j+tdAzvaMVmt7fss5f82KSgskbQ6XrBj+HZWGvEUFaxaGjPankrYskI0xJQs/KwiUfL
         Wgza4AegK9FPpM/OJIGQWF8UHxEqhYVGuQEDM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750195094; x=1750799894;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lAXYvMlPvJqgHUS0OPvSDVehGX+5oMCjweHYTWvK2RM=;
        b=jNxUNa5rEQSgm300vAdvqlPs9ZqO/69XKi/Eogn2xHo/X6LCPLKQVpSBADBf5d8ge7
         BtSTTxykFCaw5ndoTWtQRt0c3v4X5kEMtDvc5oJQYNECO84cuqGs/QCx2n5+ckhekiUe
         roqHaVICzW4W2beb3C/x/04cV4m3bopGQlEefgymU6aG38h1HVF3kb1dqIL0+PPmUeMz
         722ic7oRryQNpzYk25rPPBroFZqMEyKSNbMrOAfVuJmIXmtd45dQkR4eZwHVNWVe5/Q7
         SWvgBAOYfh01F2vWen60NVAHUvzM6ZRyDmHV3SOgBZLHy1J953RjD67csa4ifv6e1YTD
         Cbeg==
X-Forwarded-Encrypted: i=1; AJvYcCWHlhxgUsNtTZt+8saFyqegkKJc6btcj7mjRsnWntI3klJCmTSxkmo2qgetW4wJCmGCaFV/17Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwScr0KXFGXbe6qa1winfdiqtelitkc9CNTNvT+IziqTE53lJ9A
	5sidxW1P3kFYKZpTN+NRXYZnUQmLXxlL+MwWE+ERwZEBQGiXF0v1kcNOsiLLRJStp1g=
X-Gm-Gg: ASbGncu5SklEUkvC8zY0O6s2ImPm4+c1o+pzkIhog9pZQ7SSeyIHx99vGGR7Ja6wxgJ
	bmEBWRfHS5cYNswEFCY0Ym6wkQPU//FtfAQGh4a22crFXN31Ea7aubSalr5FXjbw726Zozo7spJ
	05wPUteeeba7oJUve/poSucbgKX+5zpgXYiZ25HJgtQnpSYQL8h2pyCI+4PTIcdaiCVMAIBtoL4
	f9hTgmsk38qIpZw3nQpBrxhfas8B7ZipessJIIlvD4o2vcFAQbMXpRIJby4HjsRiYi+D0K1Fc/D
	kuO7D27AeFqHaCL/+D3ekk4AhUibn/utAG6H66VmZvy25hAGuaCb/FS2bWCVB67JgOdHi0E7iA=
	=
X-Google-Smtp-Source: AGHT+IFQzbyhjfoaqCDmfEEPJM4MU0tVI/KTSBMdCJnveuC+5xBGYbQnQS4n5WKSyNltmb2v+iUGFw==
X-Received: by 2002:a05:6e02:11:b0:3dc:804b:2e74 with SMTP id e9e14a558f8ab-3de07d6429bmr174884875ab.19.1750195094480;
        Tue, 17 Jun 2025 14:18:14 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50149c68bfcsm2392917173.66.2025.06.17.14.18.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jun 2025 14:18:14 -0700 (PDT)
Message-ID: <f373f634-8d37-4670-b119-940a8fc161f0@linuxfoundation.org>
Date: Tue, 17 Jun 2025 15:18:13 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/512] 6.12.34-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250617152419.512865572@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250617152419.512865572@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/17/25 09:19, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.34 release.
> There are 512 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 19 Jun 2025 15:22:45 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.34-rc1.gz
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

