Return-Path: <stable+bounces-66288-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DAFB94D651
	for <lists+stable@lfdr.de>; Fri,  9 Aug 2024 20:35:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E1731C215A6
	for <lists+stable@lfdr.de>; Fri,  9 Aug 2024 18:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9095158D72;
	Fri,  9 Aug 2024 18:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hKD+dWRb"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF6D15ECF9;
	Fri,  9 Aug 2024 18:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723228511; cv=none; b=Ns+7/heIne0W+isUdH6PF65jVMhDp4I1U3Tmd/+TjmYXZyXGlawAU2x0uMMwyslrGda6EhcFWbgKnW2PQP3SeyaX4FdSGo2sj5epfuEQvZHdwz87llDSs+q7N9943f1ovDRLGLlFTQHJjCcZCJ2SeAq/IoIH7a52xdEzFkIes8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723228511; c=relaxed/simple;
	bh=GBzaLQaNZ6M2z21ceLlhGZ8CycU1DoE/e0LTOcmZPvg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ikmVsenbuZNVHCuBdEqysiL88mZTUAUdWbvWFoIDE7wj1FBHUfeNQGNKUpUSrFKpxPZwo0titdIFJ7Id63uMhGqNd8FpwYTeAbnXNdoi1cgQqJZMs2vF5l5dJTNXSNGPN/ro+kW24vsh5xSX/lSeD7piABg2sJVdWJWl8RcGDAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hKD+dWRb; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4519383592aso14328201cf.3;
        Fri, 09 Aug 2024 11:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723228509; x=1723833309; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZKLnO3NzNrZPScOiuu1Er/4alnL7NJ0165pjeuCDvB8=;
        b=hKD+dWRbKsiPRWLvBmbWkpc7Pi3qnTYcucdjLybd1dU+dTNbGWV9vApTtU3A2sLCmT
         6eQZSiG+yrDQ78XynR3HGbkl05Ol/gb3F6l2vkQPE20ZRobaqnWdEvuqZZr+mAZ4Uv25
         2CNkP1OkS3nJapUuFGnm/OiyKUTu4tBV3lA0Oht0D/S9jm2Lx4wVcd+F0xFOX9A2NThw
         dA2RlNcCdA8Pg772mj5uzuVHL4WsTG38IsF4dNiS+rUPv1BqdW2H1GrXZ83I4l29dBMm
         VgMwFi8ZZ36lwhA84FpVrUbIxaeZQJVNXWDJMOWJ3DDcR4LDiEbT/Q1DR16aiiKxp/Yd
         XVdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723228509; x=1723833309;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZKLnO3NzNrZPScOiuu1Er/4alnL7NJ0165pjeuCDvB8=;
        b=f3H1CJe/TpJvQjuKPqizgzZxX5wMvRKNBuls79pWBuLGv8mobvlB/IhxC9MiVYvsuA
         oWU3MAGqrbqwABdtqpcZNvaift9SjoKltUDhDyQy7bFqDo9nNLqYtasnO7wWl5sp2UsF
         DGLoMYW+Yq7LNCYb2lr2cUL/WELF21JnqEcqaGCrZtosrNfh9+F6Pz8h+ftW2Hc8ngaG
         P1Yp97OexH4K/he6eVv0Tl2id0GIl4KUM3cBNQVx9R4m//0pm8ullOiejIwmxUSo/IU5
         7IN1v7ucjOMCiF9Of7QuRe2ZVRB6cpdHjLQhPlL/87YOlwjgZvHQxxrIqd09cwnr2xqR
         5Yiw==
X-Forwarded-Encrypted: i=1; AJvYcCUU0sKliLnkcJc7aW4xtigkuBUIdxu69NCKqy/wSP7SH6qt/xGuHLeBXlw1IFTQVK2CmZJQTnweyEsCnkQzq7nbvbJcYI6HXLCyJtihwfCMxfST+V2bCCASts10PBT0wfF9C8oA
X-Gm-Message-State: AOJu0YyJQDCQsYkYXh9LQFqVmpv/LR4kdYoUCT82E1tDiwXaEQ5D9+W/
	kQcwFEEv00TnAFPG+Ve/uS8A+Zv1bpeTidOmFC+Hyb24E3Lb9pA8
X-Google-Smtp-Source: AGHT+IGvOBdQGy9B0d4iLbiYIuCoHAJBcm/SlEVS/R0YZCbAPVGloz5VZdbDZ4emSyzwOWP9wkzLiQ==
X-Received: by 2002:a05:622a:1c0d:b0:451:caeb:8cfd with SMTP id d75a77b69052e-453125b87c8mr23675521cf.31.1723228508674;
        Fri, 09 Aug 2024 11:35:08 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id d75a77b69052e-4531c1c4c56sm342601cf.23.2024.08.09.11.35.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Aug 2024 11:35:07 -0700 (PDT)
Message-ID: <a74d414d-7701-436b-a31f-ed8ec54435d3@gmail.com>
Date: Fri, 9 Aug 2024 11:35:04 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 00/86] 6.1.104-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240808091131.014292134@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240808091131.014292134@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/8/24 02:11, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.104 release.
> There are 86 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 10 Aug 2024 09:11:02 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.104-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
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


