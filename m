Return-Path: <stable+bounces-23191-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8732C85E136
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 16:32:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D6141F2534F
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 15:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0B7E69D24;
	Wed, 21 Feb 2024 15:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UywHCwMC"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6E180C07
	for <stable@vger.kernel.org>; Wed, 21 Feb 2024 15:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708529564; cv=none; b=CjitpfFtX3rO9c6KQi4x0WYoULXTkU3lc59MPvEOWu8xJAP8Qw9bm+xGWLHCthPHCXOP8X95xPH2wvjpl+uU3DdKcfnleQ67t2uNX2fzgAo+6HLdDMNNh7KBovAq+PTgzNaZaOStjTRQRDnyoNDAJrHB8PNtbpTE4yxLLuzuyDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708529564; c=relaxed/simple;
	bh=V7d0HSjRnHzOfU+EEKSUCWwEtLbsiZEB5+rydMOHck8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kXiBcXhAEvd5VrBI8HiN6hCGQg2Sw+lmgwUavguvNe8BjXWB8xz6xoW82P4DZC+CwbXAG/gYoKBtmnul93Q5RDgn+JR5ps3vowUzTUAoQQdRKBsJw23UbYSv+gxp96aM+6vvyhkot6BoCwBkQgVquBOuuQyCu+BHs3H7DX8Y7O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UywHCwMC; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-7c49c979b5dso110967939f.1
        for <stable@vger.kernel.org>; Wed, 21 Feb 2024 07:32:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1708529562; x=1709134362; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rTUWS3ITPqTvVHNlrNDdtxwJD4AyTQiAHNyBeZPU4ps=;
        b=UywHCwMCyRhpzKcw84pCaY/tJ0RV+xQE+s/etFllRxxYUfTQ+EcZkGZSpxCMQ0+AkJ
         vU/i6bxXmPX8koM7nzRH3V6wfw0NvMOTrwa8rBIQzG1qa7Q71ZP4LGVXBSIiR7XgpDgG
         DFDwvgiRRN17NEEyxVG7i1ahm/lALiBCt3zBU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708529562; x=1709134362;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rTUWS3ITPqTvVHNlrNDdtxwJD4AyTQiAHNyBeZPU4ps=;
        b=gfF6ep0wyLLjYT9j/daw4pd2eAnZOOnDhLkrMdXotKiIpTc2gy3VHFWibdSo4cPd+F
         1C2MIwjbgHgblZeXVzNKJGmhFtF8A2YmznXzb3rVZETQB/Vzc4LK3KXByDXatairZecM
         XClt+RtUgtfHl/rCSFuSOMbN1mEiGPwJuChDMev4pQf4jux2ZIMQbxhyb5XTpRyiHttw
         IvfKRY8U9qQ4/flUynYXcLvqrmRV/IMtVT6vm14ptRZN57tOfkUTOKFG+2k9tN2gl2h/
         kOhk0ZT7fE+KM2w2X/mIF9D8Qh9aGyHOP6GXL8zvLYfr55H2jtyaDlnONBdUiV3uMU2m
         ExUg==
X-Forwarded-Encrypted: i=1; AJvYcCV9KX4BG2H2Tzs5iCGV/sL2ff4v2/O9Ps2ILwPCPxdRIsRj3lHmUNBk9iSkpjBKded6o+wtUH8EDjW+A/r2xF45YoMfguAd
X-Gm-Message-State: AOJu0YzRbzpB37700Fg1vRzT+86h4UCUDCNH2RtBv7Ytu9MrpnqI6ig0
	BcFdCBYxkIive33M733gcMoqqPYDexu+1GTK87+7RPci+EOxHFHilVDtVTVHz/k=
X-Google-Smtp-Source: AGHT+IGsafhl7SWuEo6yvVNtfR8RuWLkNqrVmSIk/bzAZaHH0TBGFMabmNdsRvlZhXzy453/7nPXrw==
X-Received: by 2002:a05:6602:1d47:b0:7c4:655:6e05 with SMTP id hi7-20020a0566021d4700b007c406556e05mr17213245iob.2.1708529562000;
        Wed, 21 Feb 2024 07:32:42 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id q11-20020a0566380ecb00b00474269ff209sm1796067jas.119.2024.02.21.07.32.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Feb 2024 07:32:41 -0800 (PST)
Message-ID: <bc6e74d1-4354-4881-929f-ae45ea1e35c6@linuxfoundation.org>
Date: Wed, 21 Feb 2024 08:32:40 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.7 000/309] 6.7.6-rc1 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240220205633.096363225@linuxfoundation.org>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240220205633.096363225@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/20/24 13:52, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.7.6 release.
> There are 309 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 22 Feb 2024 20:55:42 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.7.6-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.7.y
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


