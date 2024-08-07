Return-Path: <stable+bounces-65965-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F3D3F94B22C
	for <lists+stable@lfdr.de>; Wed,  7 Aug 2024 23:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F50EB24BDE
	for <lists+stable@lfdr.de>; Wed,  7 Aug 2024 21:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74C1684D25;
	Wed,  7 Aug 2024 21:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e/QCStHT"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF87F12C53B;
	Wed,  7 Aug 2024 21:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723066229; cv=none; b=b3NVDJTmgAV4/aWU9y4KhhEN5XAEEzVaHTcGBAFCu8iRhSCfTb7p+POw5dS7qwUE4pl1sJT5ljzdf4ZExLYEoVEeOqsfueG3chM/EI53pomvbbTvjH1olAdDwOaEPrSJpTAHbnzSFTSybwx69r3E+Gqk+v/CBLZH1qinGjNH488=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723066229; c=relaxed/simple;
	bh=S2WUcIEsA6+3ppym2CRAnEQy1XpPkseZ+RkrsXGrgM4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=crCMYCiYkcnypGRGjy8Csmh1TN4IfsHI9JluL+arbJm+I4+UAdjXe1ZQmtjzeiIKUQ8poYaEGj0n2Rg2N5q8QO+m6PFgbxhHPFQwBzDgeHp2SRXFJ6PyeGo6EAsWl6tRJ6T9qf5r1EQzoxEBIZ7nY0JCtu4OYfyLVfsSqV7w86w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e/QCStHT; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1fd640a6454so3623295ad.3;
        Wed, 07 Aug 2024 14:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723066227; x=1723671027; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uQCkeRXbqsoC6TGsNWXjN9AhH2OGAT8bTLYitR2KHqw=;
        b=e/QCStHTEWe5vI8KHNib6M1W1C+z3sj2fPGEVk0Uaqku65bfD9gPW7NKgqKdjPsIUC
         tvYxasUmR4THtrQc7THvDJO3V+40h8k0Cm+QAZXnwSVgQOL8BWsm36iDIMee7T4UFD63
         2HGUy0+Gqq8rTknK+oA1aLzGswX9CzK5kck4i+OkF+f4H604jFKtukKTCPtdeJj8Lhd9
         whOGRfgaijj7fgLO1+21HZjHsDccoG+uXH0UsxSMuuQaYkPb4Tlfh8QRhiw8JtBtSDYN
         1MM9OJE58AuGRdiOyTY0VXRkeiyRrMp3ECVqu7cIdmd5WMX9BqxEo0Bq06cEBeV12Zbr
         pp3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723066227; x=1723671027;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uQCkeRXbqsoC6TGsNWXjN9AhH2OGAT8bTLYitR2KHqw=;
        b=LdP9U4dzJklOcfSVXnf//hQEpvk9l0c1FHGxhpTv9IGPhetUOHiAi735O+/89xOxMH
         4cxdf57ALOM8Rs2h1e4+3Xy46Eo1bmYa8P0PPCIeRuDaFVaTZnhsIf9wUFoUtn/BCq2s
         FWodUXx1EoMTddDSyBvV4u+Rcd9Y1dYspEREuZLC48fr+oVdvjODivksxuQsVgl/3DHZ
         V3YLpFh9WW4a0zUtuYA/Jpx1YSHcagAB+SvFbcnDC9/S/APeA9+jP2NNa0DNYPl304Pd
         SUA4YUdIGdVvQF2OqQR/MQGvEgQTcdylOspNi3k2BgZuRt/9pfT8fOzZhvlKU99uAD0P
         IcPg==
X-Forwarded-Encrypted: i=1; AJvYcCXYKqStz8+5s5IQYFL7XYkqV1F63ZxJZfEzfcK27owhN1Y12qAq2DbbjUphl4pXeZsFv935P4gkNWY5F4pkeC9TnoHGBqvcpB/xgrj2CYCAH6bkY7xCnvW3vEr53obYmiHIRrsy
X-Gm-Message-State: AOJu0Yz9dMjnxSUojGIc3QACQpDR9I7azUprI6S51q13tL2H68RCRdmM
	AGM0RTLe+KwusVKd2mEe6Lq2ejR25bewtZrFW3X3QNlFdl6yRNy3
X-Google-Smtp-Source: AGHT+IEz/VuQPyBI274b+xhvDuQNnkMCKoXQr+SkjlteNH0ShrF/hfNYRP42/6H7rVpizZs+Bi8zBQ==
X-Received: by 2002:a17:902:e88e:b0:1fb:35c7:8ea4 with SMTP id d9443c01a7336-1ff5727c893mr221732745ad.2.1723066227115;
        Wed, 07 Aug 2024 14:30:27 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1ff58f19d0csm111280265ad.2.2024.08.07.14.30.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Aug 2024 14:30:26 -0700 (PDT)
Message-ID: <ec2c5de9-830f-41f8-879c-39d19771edf5@gmail.com>
Date: Wed, 7 Aug 2024 14:30:24 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/121] 6.6.45-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240807150019.412911622@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240807150019.412911622@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/7/24 07:58, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.45 release.
> There are 121 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 09 Aug 2024 14:59:53 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.45-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels, build tested on 
BMIPS_GENEIRC:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


