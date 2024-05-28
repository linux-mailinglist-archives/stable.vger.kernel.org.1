Return-Path: <stable+bounces-47596-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 559F48D269D
	for <lists+stable@lfdr.de>; Tue, 28 May 2024 22:57:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8703D1C24A1A
	for <lists+stable@lfdr.de>; Tue, 28 May 2024 20:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A57117B41C;
	Tue, 28 May 2024 20:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JoGGW+/F"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E3D17966D;
	Tue, 28 May 2024 20:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716929860; cv=none; b=s4tTpF5MgpLUFDctWm5oxhFOf6jhG3sNRZB/R1Pezk7TRvKxcmnCrF/0r3Lp8pzEbUO3OfG6zex5fsNDeyTuai0koyuLgCQEeSeMJ+5wtqolErUAq1Pu4CPQfBPQg/s4kOg68BcllQak8NBze0I/97dm4Ohv6Hxh9V9flcIGrxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716929860; c=relaxed/simple;
	bh=Y3ZBHOPIu2u+nsoWmsODdBPCJTITCXogegxmExBptRM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s/3IsAFgr6wB6EIZWhoJfBfPFGZG8mv5syYEOFSp5rfRTYbsQNFrnyqR4OPzBXaRZkGrmisj08oh2U6ttLn5reooccs3OUWccm9NYU6Mp3TREn1qnjJ26+Lr5IaeXfW8i8SVYvtRoPc637iCAraRb0nXO7ZWLIIPCD5qKZJyL/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JoGGW+/F; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6f6bddf57f6so1326892b3a.0;
        Tue, 28 May 2024 13:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716929859; x=1717534659; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7mRas9wPp85C5J0VZDAcnXYBCgiC2lkr+yBEWsgNvL0=;
        b=JoGGW+/Fb0xa3Xnut47f3yN9nUXGszTBmXMLvfJwEuII43CcxIVFD2nrLaJX0yrBa5
         7UzScKdkisPiOsBek+N8umD62FTkPSGzH+ZwJAP7PanANwIwL7MbNq0PnbUcEPsWNUqr
         n3rzctxIAybBsy3jzMX5Hzd1qotpH3NweKFyg6/wX/kcNfhnDEn//+cE4LYrEx7yhBKA
         LBaNlL0DVZydGwPC+xAzxETQ4b1nrH0YfYn7h4v2p+hAB4Ru5ZcnumS2MAGf/xABiC2C
         k0TT/ihYbabVgCEZ6zbK1LgDJS1g55Gsi8RY3hQDIdx2wCQ+QFuvbyiDW3jXnvbTeg8c
         Woug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716929859; x=1717534659;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7mRas9wPp85C5J0VZDAcnXYBCgiC2lkr+yBEWsgNvL0=;
        b=RYKDNSPd1/p8fU6g98W99ydo8JYnFux9kK0pmCnmwLJfSfX+wHpVK8Rq579xGMveAq
         pfclfmU64O4KUEK163KyvkbrbZsn2GjDAxq01x0QS34l/BRQr7nFj6xqZG4WALmVNCta
         Y1So5Wdx3AIHYfJgTKFK6u+xXbBTpKQc6mh8XjSag2REsmMpYRvQBKr/PfbFO17c+6QV
         WlSn+lqMAODlTTO/1/+rUF/j/fuL12aO5/zcRN2WHR98EzjlNHzNa6y6EScWxLce9dh4
         Esv+J4Bv8mlYULfnYZrj+Cy8f651tcks7Y/IxyoyWwZq1CNS8Bnf/LHFcFY5ztwXCRKb
         6+Ig==
X-Forwarded-Encrypted: i=1; AJvYcCUN/Wg/mTkWm8Z+zE7AhdzhM6lKMCBMYhEAWDpP55nXxObIYy9PKTKeJ334IV5VO1yaLwmGjYlPpWNyWnNe/gTP+ZNX8RDOIf3DJOa4m+zll9sZIj4XI4/pohcXuKDctUfn223H
X-Gm-Message-State: AOJu0YzGYxTFwynXGVDqacDebNCEjWozYRPuOvRcYKOhswKkHOU4RqLA
	YvXOZPFKIX9EZqvfNCy9O0h3ZPr+T88+2Rv0n3RB/oRwj9i++ann
X-Google-Smtp-Source: AGHT+IGpXKGory1d47XZFSfaFNvBieFbxtFg+9wadqc1f3Pz8HegJA9FkiEvGJSY7Wy1L0L9p/FO+w==
X-Received: by 2002:a05:6a00:6c91:b0:6f6:d789:285 with SMTP id d2e1a72fcca58-6f8f308f94amr15921761b3a.10.1716929858781;
        Tue, 28 May 2024 13:57:38 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-6f8fc155bfbsm6843362b3a.74.2024.05.28.13.57.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 May 2024 13:57:38 -0700 (PDT)
Message-ID: <6fa88a74-4c21-4d43-9961-9808438c2319@gmail.com>
Date: Tue, 28 May 2024 13:57:36 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.8 000/493] 6.8.12-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240527185626.546110716@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240527185626.546110716@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/27/24 11:50, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.8.12 release.
> There are 493 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 29 May 2024 18:53:22 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.8.12-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.8.y
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


