Return-Path: <stable+bounces-105044-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A19359F5685
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 19:52:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76D251892E2D
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 18:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 184391F8AE9;
	Tue, 17 Dec 2024 18:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U8brU10r"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF211F8ADA;
	Tue, 17 Dec 2024 18:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734461525; cv=none; b=regiCwzRUXRYHAxO23QmZC8yVabXQDQO/AuaCXQ+KCQR75A5yun24ozhy40vQx7nOVjaoOP1bfLaePR7vtPfuI3qN85lGs3AYoWh+qOqB9IxKVCVzE+GBSEG5Sw5uMlWdLUMOZc/VTwLbDJ1WuoDfMe0HbOm+u0Hkc7tca+ILu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734461525; c=relaxed/simple;
	bh=p6//4IiVidrIQuHKI5FobqI2mWPJitMp7g5TD9ChUPg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mNENKyh/OoBXRhCizldBW5yDCdAwFAV+3b4acQhrx0pTpQoNcNgPYWwV40iFFTS5B3boKhY/pHXsCqqiF9zw04k8+mdOLB3csBAMV4hWxHokbdhmyoVzp3149hOjaJPNDOJRL092dNUgeRnryqT0dDHkIWR1ipPal6p1CZjlK30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U8brU10r; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-725dbdf380aso4565190b3a.3;
        Tue, 17 Dec 2024 10:52:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734461524; x=1735066324; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0smcS/bmntempFPtm1Qz4whs9w6FDLxVkMsEkznK8n4=;
        b=U8brU10ryvny3Ri77UcUAa7EGPGHQsOvoSNqSLNg5A+b1XxAscWyYgKKoMd4uBqSDO
         vFE3K8DwVteL10DzmlFsQGt+Ud0Qj9F7pGRefeMqjFr4Syu2bEax2F9+HSPLzxbK2x08
         TpS9M8nx5RzhHOcOOgMoQu8TuOLSOAZXyEzyYrrRafTxG6zoST65UEMaHRSzfFrbH+YH
         zTgJSWDWb99gG3S2ZjLE8MMthm2ZvXfwxsDjpw3Vr+KTJz/IuVWdc1lCBXQRCGr8uazn
         nrNUHVEFSfGEmNew39a0BtxoE8if6blfGNuUT7TDDlb2DuNle8gvz6B0tJimNQH6TnTu
         95cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734461524; x=1735066324;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0smcS/bmntempFPtm1Qz4whs9w6FDLxVkMsEkznK8n4=;
        b=LiYrbSMd0705mhwZE7q+E5rL6a43jFPxhiANYVg19dixcFHmOL2+kuSrItcG2KTSBa
         tjrnRTeCVav3YRhBIOHOpvPsqa5OUaxvFLbg+AEslCAW9WBc27WdCzNHf4qytSCChD7w
         RcXs7ww+tEnnCMUuWXQG54qEdKJJApbtuAE0pUJuKbNzLWfZzpnA9utfA5RG2ysgSZEV
         iQDeJEuVvYxlGoSgSEBJBlV56lZwk4FLlJwzwlywvrI5aelJcqw8cK8Bx9dbwPpas0Ex
         kFBFv5kjXfzbcQbCXLMEianeuay2EVuEEOhD89RUJWuXs7ksmiHyohVJsQsC7wGCZgKG
         bjQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUsD06odEYFEeX3ou8OIGKNn42ZC++m/d4LOHCX/lVXe0zSwgoGRsYNMlOwb+JClTGiDZ9fBK5d@vger.kernel.org, AJvYcCX2cHxfdfYxhYfbcBr9cBCNUgINqdRBgg0uwWnQ228VX6z6+dUlHgfhi95r2i/0MAP86xXho2WLgjMz558=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBYsFnPxLzy6ImGX3T4R9hIpugGdNCRek6CjZWfbcmT7yPJqiC
	umqX/1b4wVh2A0fia1a13kMgiUvTdHAOK7WLjdllxdU86BIyKa1CK4+/0PZi
X-Gm-Gg: ASbGncuUGaLg529aGOdqk8dWUoO03knqaPrifAbN6YTwdKmeorUTx3isOM4ZVzhMIAG
	1+b/s++F+MzRSlOQLbLz9wGwVxH6KDqJ2uoYNFqJzTEqe+5DvzPI8yjDQVqiiButig2uwsEA9st
	CQjvH82unufFYaIisgvNfeciU8IB+V6+UsU7IoH8OlTP4B/Kczk6u4EFmd9D/9XGpctcBfxylNP
	rq9io5KO5BauE87q0jd1GRyYZuTtstrpFCCudgqqUBCICLF+P0KqVvDfByW2XJAL0JDt7pcoP/g
	Vw8DjT2r
X-Google-Smtp-Source: AGHT+IFxxbYG/VcjpNLRsAsn3SGeseRhCh21P/ItvQIwtDkvlTPd/4Xg4r/a+nDZRm2AfZACzaMMeA==
X-Received: by 2002:a05:6a21:329a:b0:1e1:bdae:e058 with SMTP id adf61e73a8af0-1e5b48a2d61mr128988637.37.1734461523764;
        Tue, 17 Dec 2024 10:52:03 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72918ac5258sm7284782b3a.20.2024.12.17.10.51.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2024 10:52:02 -0800 (PST)
Message-ID: <554c84eb-05b1-4336-8c14-501ddbf9c2a0@gmail.com>
Date: Tue, 17 Dec 2024 10:51:54 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10 00/43] 5.10.232-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20241217170520.459491270@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
In-Reply-To: <20241217170520.459491270@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/17/24 09:06, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.232 release.
> There are 43 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 19 Dec 2024 17:05:03 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.232-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
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

