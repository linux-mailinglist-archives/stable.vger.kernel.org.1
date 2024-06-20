Return-Path: <stable+bounces-54779-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A8579114B5
	for <lists+stable@lfdr.de>; Thu, 20 Jun 2024 23:34:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0182281BA1
	for <lists+stable@lfdr.de>; Thu, 20 Jun 2024 21:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37AAA74BF0;
	Thu, 20 Jun 2024 21:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Sh9Le3HR"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB8959148
	for <stable@vger.kernel.org>; Thu, 20 Jun 2024 21:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718919261; cv=none; b=f+yF3ow9N2JIXf1p/oo25mqdmleb+Ya2AuCUz8fh/Wd7hvCdXKt7qrMLcatkrZGDGVgOG3hVTShUC5IUdbxK9Y4uQPdwAgA8Hlh1ZzIVCNp0tQLrRnePtjE4yhjHj5SLhfpIIDzD8NT7L7oAxnzs2J/ckega7SntiZuXPip58c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718919261; c=relaxed/simple;
	bh=KTjjL+JKAvw+Qt0PJuGuYKm2WnQ8r33t1A+d+cB5QHA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k+V8gffeWJRUzCA8kDyHSSzj2iCNA/GO//+Z1Al8wQOEmU8rPGWsvF90QL2R05QUt8AkGmVpbQ8NUvT/C/Ja/pIk80DHE7E697HJ5sy7qMVDrbwwTrQIfu5M73nbX8U6e7GhCdMCN4CSxZfSQtbFGJv+9jBPI36mb6Id1/e56dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Sh9Le3HR; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7eb721a19c9so2576039f.2
        for <stable@vger.kernel.org>; Thu, 20 Jun 2024 14:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1718919258; x=1719524058; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/sS9AcK82VG8l8ZobUjuQu874doLpAEywwJuD6PipkU=;
        b=Sh9Le3HRVqEzDml3X53A+RPYvXWGdg9EvUw0rsq7XnXTdfIRgcEfnv+kPnDavfB+VR
         XjFrJCmlnVy3+aHCYclndPyuYZ5FnkAuYQ04iiLTdXMdgfh4Cw+AtXX3Uwszex8nvmHd
         uw73Ugz2YWmD/bBsqIsrXZSPvR5uBIVyUT12g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718919258; x=1719524058;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/sS9AcK82VG8l8ZobUjuQu874doLpAEywwJuD6PipkU=;
        b=DxBv+7Z8a/dGBrOIostwJtZhlEUzkHXC6LeQC0P0muf8/dRuMYkstD3Dglq4ug8xgt
         PsYuH0BpLKylTzc+ZhEraOZZhfulGzXHYbE0rznQlu82bMF2xsshskP6NSRHLSkU5YTX
         L3dwNkAhnU/T3loV20a60tJfBGTaMqitJCq8vS2nhkaWi33Q0DEn0bZS/lj+yCTktxyc
         pSPai2UnmWfxRrvaJKzLW1NCjfAgcKJ8I7Q7efaAXwlmxJpcfmDJqlsM5dLUrxRuvFvg
         a8iVo0LMnBuNEZkg9Qv170wQlaQKTq1h82CbPpPqQ3eTkZ1jnEsn26YAftZwe1IQEZN3
         kWLA==
X-Forwarded-Encrypted: i=1; AJvYcCWaZddHPfE27KcKXc4b4CTXIZmGSjsogQDlRjiMqAQpNTsRVcZldFzZ8GCGio90r2BfoE7KggdjMzaVTvZCd5lNaHY1vFnq
X-Gm-Message-State: AOJu0YzTLq4zeaG3E9NhQulsXEbB/hWvWuOgf3mB38TopJkp9pqlhgZX
	mGVh/XNhRkRzy6uSUoCG+CmYzBrPSdVKHAiL/h42Zz+hJycsusLMAh0kBAlbTfc=
X-Google-Smtp-Source: AGHT+IE7vszslD1EzgHNWCRCztpQZU+nao4bi9wPfz6rtQsIhoYpZixmMSW6UPcaae19IMvqbm/1xg==
X-Received: by 2002:a6b:6814:0:b0:7eb:2c45:4688 with SMTP id ca18e2360f4ac-7f13ee9007fmr713914139f.2.1718919258059;
        Thu, 20 Jun 2024 14:34:18 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-7f391fd9d5asm2838339f.14.2024.06.20.14.34.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jun 2024 14:34:17 -0700 (PDT)
Message-ID: <d3d4cdb1-329b-4344-819f-356632548ed4@linuxfoundation.org>
Date: Thu, 20 Jun 2024 15:34:16 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.9 000/281] 6.9.6-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240619125609.836313103@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240619125609.836313103@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/19/24 06:52, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.9.6 release.
> There are 281 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 21 Jun 2024 12:55:11 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.9.6-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.9.y
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

